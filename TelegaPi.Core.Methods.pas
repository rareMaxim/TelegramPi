﻿unit TelegaPi.Core.Methods;

interface

uses
  TelegaPi.Methods,
  Citrus.Mandarin,
  System.SysUtils,
  TelegaPi.Types,
  TelegaPi.Core.Helpers;

type
  TtgMethod = class(TInterfacedObject)
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

  TtgGetMeMethod = class(TtgMethod, ITgGetMeMethod)
  public
    procedure Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
  end;

  TtgLogOutMethod = class(TtgMethod, ITgLogOutMethod)
    procedure Excecute(AResponse: TProc<Boolean, IHttpResponse>);
  end;

  TtgCloseMethod = class(TtgMethod, ITgCloseMethod)
    procedure Excecute(AResponse: TProc<Boolean, IHttpResponse>);
  end;

  TtgGetUpdatesMethod = class(TtgMethod, ITgGetUpdatesMethod)
  public
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    function SetAllowedUpdates(AAllowedUpdates: TAllowedUpdates): ITgGetUpdatesMethod;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

  TtgSendMessageMethod = class(TtgMethod, ItgSendMessageMethod)
  public
    function SetChatId(const AChatId: Int64): ItgSendMessageMethod; overload;
    function SetChatId(const AChatId: string): ItgSendMessageMethod; overload;
    function SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
    function SetText(const AText: string): ItgSendMessageMethod;
    function SetParseMode(const AParseMode: string): ItgSendMessageMethod;
    procedure Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
  end;

implementation

uses
  System.JSON,
  Citrus.JObject,
  System.Generics.Collections;

{ TtgMethod<T> }

constructor TtgMethod.Create(AMandarin: TMandarinClientJson; const AMethod: string);
begin
  inherited Create;
  FClient := AMandarin;
  FMandarin := BuildMandarin(AMethod);
end;

function TtgMethod.GetMandarin: IMandarin;
begin
  Result := FMandarin;
end;

procedure TtgMethod.InternExec<TR>(AResponse: TProc<TR, IHttpResponse>);
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
        begin
          var
          LNewData := LResponse.GetValue('result').ToJSON;
          var
          LSerialized := TJObjectConfig.Current.Serializer.Deserialize<TR>(LNewData);
          AResponse(LSerialized, AHttp);
        end
        else
          raise Exception.CreateFmt('%s: %s = %s', [FMandarin.GetUrlSegment('METHOD_NAME'),
            LResponse.GetValue('error_code').Value, LResponse.GetValue('description').Value]);
      finally
        LResponse.Free;
      end;
    end, True);
end;

function TtgMethod.BuildMandarin(const AMethod: string): IMandarinExt;
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
      LUpdates: TArray<ItgUpdate>;
    begin
      SetLength(LUpdates, length(AData));
      for var i := Low(AData) to High(AData) do
        LUpdates[i] := AData[i];
      AResponse(LUpdates, AHttp);
    end);
end;

function TtgGetUpdatesMethod.SetAllowedUpdates(AAllowedUpdates: TAllowedUpdates): ITgGetUpdatesMethod;
begin
  GetMandarin.AddQueryParameter('allowed_updates', AAllowedUpdates.ToString);
  Result := Self;
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
  GetMandarin.Body.AddJsonPair('chat_id', AChatId);
  Result := Self;
end;

function TtgSendMessageMethod.SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
begin
  GetMandarin.Body.AddJsonPair('message_thread_id', AMessageThreadId.ToString);
  Result := Self;
end;

function TtgSendMessageMethod.SetParseMode(const AParseMode: string): ItgSendMessageMethod;
begin
  GetMandarin.Body.AddJsonPair('parse_mode', AParseMode);
  Result := Self;
end;

function TtgSendMessageMethod.SetText(const AText: string): ItgSendMessageMethod;
begin
  GetMandarin.Body.AddJsonPair('text', AText);
  Result := Self;
end;

function TtgSendMessageMethod.SetChatId(const AChatId: Int64): ItgSendMessageMethod;
begin
  GetMandarin.Body.AddJsonPair('chat_id', AChatId.ToString);
  Result := Self;
end;

{ TtgLogOutMethod }

procedure TtgLogOutMethod.Excecute(AResponse: TProc<Boolean, IHttpResponse>);
begin
  InternExec<Boolean>(AResponse);
end;

{ TtgCloseMethod }

procedure TtgCloseMethod.Excecute(AResponse: TProc<Boolean, IHttpResponse>);
begin
  InternExec<Boolean>(AResponse);
end;

end.
