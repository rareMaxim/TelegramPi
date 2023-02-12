unit TelegaPi.Core.Methods;

interface

uses
  TelegaPi.Methods,
  Citrus.Mandarin,
  System.SysUtils,
  TelegaPi.Types;

type
  TtgMethod<T> = class(TInterfacedObject, ITgMethod<T>)
  private const
    BOT_URL = '{server}/bot{token}/{METHOD_NAME}'; // do not localize
  private
    FClient: TMandarinClientJson;
    FMandarin: IMandarin;
  protected
    function BuildMandarin(const AMethod: string): IMandarinExt;
    procedure InternExec<TR>(AResponse: TProc<TR, IHttpResponse>);
  public
    constructor Create(AMandarin: TMandarinClientJson); virtual;
    function GetMandarin: IMandarin;
  end;

  TtgGetMeMethod = class(TtgMethod<ItgUser>, ITgGetMeMethod)
  public
    constructor Create(AMandarin: TMandarinClientJson); override;
    procedure Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
  end;

  TtgGetUpdatesMethod = class(TtgMethod<ITgGetUpdatesMethod>, ITgGetUpdatesMethod)
  public
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    constructor Create(AMandarin: TMandarinClientJson); override;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

implementation

uses
  System.JSON, Citrus.JObject, TelegaPi.Core.Types,
  System.Generics.Collections;

{ TtgMethod<T> }

constructor TtgMethod<T>.Create(AMandarin: TMandarinClientJson);
begin
  inherited Create;
  FClient := AMandarin;
end;

function TtgMethod<T>.GetMandarin: IMandarin;
begin
  Result := FMandarin;
end;

procedure TtgMethod<T>.InternExec<TR>(AResponse: TProc<TR, IHttpResponse>);
begin
  FClient.Execute(GetMandarin,
    procedure(AHttp: IHttpResponse)
    var
      LRawData: string;
      LResponse: TJSONObject;
    begin
      LRawData := AHttp.ContentAsString();
      LResponse := TJSONObject.ParseJSONValue(LRawData) as TJSONObject;
      try
        if LResponse.GetValue('ok').Value = 'true' then
          AResponse(TJObjectConfig.Current.Serializer.Deserialize<TR>(LResponse.GetValue('result').ToJSON), AHttp)
        else
          raise Exception.CreateFmt('%s: %d = %s', [FMandarin.GetUrlSegment('METHOD_NAME'),
            LResponse.GetValue('error_code').Value, LResponse.GetValue('description').Value]);
      finally
        LResponse.Free;
      end;
    end, True);
end;

function TtgMethod<T>.BuildMandarin(const AMethod: string): IMandarinExt;
begin
  Result := FClient.NewMandarin(BOT_URL)//
    .AddUrlSegment('METHOD_NAME', AMethod);
end;

constructor TtgGetMeMethod.Create(AMandarin: TMandarinClientJson);
begin
  inherited Create(AMandarin);
  FMandarin := BuildMandarin('getMe');
end;

{ TtgGetMeMethod }

procedure TtgGetMeMethod.Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
begin
  InternExec<TTgUser>(
    procedure(AData: TTgUser; AHttp: IHttpResponse)
    begin
      AResponse(AData, AHttp);
    end);
end;

{ TtgGetUpdatesMethod }

constructor TtgGetUpdatesMethod.Create(AMandarin: TMandarinClientJson);
begin
  inherited Create(AMandarin);
  FMandarin := BuildMandarin('getUpdates');
end;

procedure TtgGetUpdatesMethod.Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
begin
  InternExec < TArray < TtgUpdate >> (
    procedure(AData: TArray<TtgUpdate>; AHttp: IHttpResponse)
    var
      LUpdates: TList<ItgUpdate>;
    begin
      LUpdates := TList<ItgUpdate>.Create;
      try
        for var LUpdate in AData do
          LUpdates.Add(LUpdate);
        AResponse(LUpdates.ToArray, AHttp);
      finally
        LUpdates.Free;
      end;
    end);
end;

function TtgGetUpdatesMethod.SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
begin
  GetMandarin.AddQueryParameter('limit', ALimit.ToString);
  Result := Self;
end;

function TtgGetUpdatesMethod.SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
begin
  GetMandarin.AddQueryParameter('offset', AOffset.ToString);
  Result := Self;
end;

function TtgGetUpdatesMethod.SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
begin
  GetMandarin.AddQueryParameter('timeout', ATimeout.ToString);
  Result := Self;
end;

end.
