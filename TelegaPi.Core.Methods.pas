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
    constructor Create(AMandarin: TMandarinClientJson; const AMethod: string); virtual;
    function GetMandarin: IMandarin;
  end;

  TtgGetMeMethod = class(TtgMethod<ItgUser>, ITgGetMeMethod)
  public
    procedure Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
  end;

  TtgGetUpdatesMethod = class(TtgMethod<ITgGetUpdatesMethod>, ITgGetUpdatesMethod)
  public
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

  TtgSendMessageMethod = class(TtgMethod<ItgSendMessageMethod>, ItgSendMessageMethod)
  public
    function SetChatId(const AChatId: Int64): ItgSendMessageMethod; overload;
    function SetChatId(const AChatId: string): ItgSendMessageMethod; overload;
    function SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
    function SetText(const AText: string): ItgSendMessageMethod;
    procedure Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
  end;

implementation

uses
  System.JSON, Citrus.JObject,
  System.Generics.Collections;

{ TtgMethod<T> }

constructor TtgMethod<T>.Create(AMandarin: TMandarinClientJson; const AMethod: string);
begin
  inherited Create;
  FClient := AMandarin;
  FMandarin := BuildMandarin(AMethod);
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

{ TtgSendMessageMethod }
procedure TtgSendMessageMethod.Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
begin
  InternExec<TtgMessage>(
    procedure(AData: TtgMessage; AHttp: IHttpResponse)
    begin
      AResponse(AData, AHttp);
    end);
end;

function TtgSendMessageMethod.SetChatId(const AChatId: string): ItgSendMessageMethod;
begin
  GetMandarin.AddQueryParameter('chat_id', AChatId);
  Result := Self;
end;

function TtgSendMessageMethod.SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
begin
  GetMandarin.AddQueryParameter('message_thread_id', AMessageThreadId.ToString);
  Result := Self;
end;

function TtgSendMessageMethod.SetText(const AText: string): ItgSendMessageMethod;
begin
  GetMandarin.AddQueryParameter('text', AText);
  Result := Self;
end;

function TtgSendMessageMethod.SetChatId(const AChatId: Int64): ItgSendMessageMethod;
begin
  GetMandarin.AddQueryParameter('chat_id', AChatId.ToString);
  Result := Self;
end;

end.
