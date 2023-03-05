unit TelegaPi.Client;

interface

uses
  Citrus.Mandarin,
  Citrus.ThreadTimer,
  System.Classes,
  System.SysUtils,
  TelegaPi.Types,
  TelegaPi.Methods,
  System.Net.HttpClient;

type
  TTelegaPiBase = class(TComponent)
  private
    FMandarin: TMandarinClientJson;
    FIsAsyncMode: Boolean;
    FToken: string;
    FServer: string;
    FTimer: TThreadTimer;
    FMessageOffset: Int64;
    FAllowedUpdates: TAllowedUpdates;
    FLimitUpdates: Integer;
    procedure DoWorkWithUpdates(AUpdates: TArray<ItgUpdate>; AHttpResponse: IHTTPResponse);
  protected
    procedure EventParser(AUpdates: TArray<ItgUpdate>); virtual;
    procedure TypeUpdate(AUpdate: ItgUpdate); virtual;
    // Ñîáûòèÿ
    procedure DoOnUpdates(AUpdates: TArray<ItgUpdate>); virtual; abstract;
    procedure DoOnUpdate(AUpdate: TtgUpdate); virtual; abstract;
    procedure DoOnMessage(AMessage: TTgMessage); virtual; abstract;
    procedure DoOnInlineQuery(AInlineQuery: TtgInlineQuery); virtual; abstract;
    procedure DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult); virtual; abstract;
    procedure DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery); virtual; abstract;
    procedure DoOnEditedMessage(AEditedMessage: TTgMessage); virtual; abstract;
    procedure DoOnChannelPost(AChannelPost: TTgMessage); virtual; abstract;
    procedure DoOnEditedChannelPost(AEditedChannelPost: TTgMessage); virtual; abstract;
    procedure DoOnShippingQuery(AShippingQuery: TtgShippingQuery); virtual; abstract;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery); virtual; abstract;
  public
    procedure Start;
    procedure Stop;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    /// A simple method for testing your bot's authentication token. Requires no
    /// parameters. Returns basic information about the bot in form of a User object.
    /// </summary>
    function GetMe: ITgGetMeMethod;
    /// <summary>
    /// Use this method to log out from the cloud Bot API server before launching the
    /// bot locally. You must log out the bot before running it locally, otherwise
    /// there is no guarantee that the bot will receive updates. After a successful
    /// call, you can immediately log in on a local server, but will not be able to log
    /// in back to the cloud Bot API server for 10 minutes. Returns True on success.
    /// Requires no parameters.
    /// </summary>
    function LogOut: ITgLogOutMethod;
    /// <summary>
    /// Use this method to close the bot instance before moving it from one local
    /// server to another. You need to delete the webhook before calling this method to
    /// ensure that the bot isn't launched again after server restart. The method will
    /// return error 429 in the first 10 minutes after the bot is launched. Returns
    /// True on success. Requires no parameters.
    /// </summary>
    function Close: ITgCloseMethod;
    function GetUpdates: ITgGetUpdatesMethod;
    /// <summary>
    /// Use this method to send text messages. On success, the sent Message is returned.
    /// </summary>
    function SendMessage: ItgSendMessageMethod;
  published
    property IsAsyncMode: Boolean read FIsAsyncMode write FIsAsyncMode;
    property Token: string read FToken write FToken;
    property Server: string read FServer write FServer;
    property MessageOffset: Int64 read FMessageOffset write FMessageOffset;
    property AllowedUpdates: TAllowedUpdates read FAllowedUpdates write FAllowedUpdates;
    property LimitUpdates: Integer read FLimitUpdates write FLimitUpdates;
  end;

  TTelegaPiConsole = class(TTelegaPiBase)
  private
    FOnUpdate: TProc<ItgUpdate>;
    FOnUpdates: TProc<TArray<ItgUpdate>>;
    FOnCallbackQuery: TProc<TtgCallbackQuery>;
    FOnChannelPost: TProc<ITgMessage>;
    FOnChosenInlineResult: TProc<TtgChosenInlineResult>;
    FOnEditedChannelPost: TProc<ITgMessage>;
    FOnMessage: TProc<ITgMessage>;
    FOnInlineQuery: TProc<TtgInlineQuery>;
    FOnEditedMessage: TProc<ITgMessage>;
    FOnShippingQuery: TProc<TtgShippingQuery>;
    FOnPreCheckoutQuery: TProc<TtgPreCheckoutQuery>;
  protected
    procedure DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery); override;
    procedure DoOnChannelPost(AChannelPost: TTgMessage); override;
    procedure DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult); override;
    procedure DoOnEditedChannelPost(AEditedChannelPost: TTgMessage); override;
    procedure DoOnEditedMessage(AEditedMessage: TTgMessage); override;
    procedure DoOnInlineQuery(AInlineQuery: TtgInlineQuery); override;
    procedure DoOnMessage(AMessage: TTgMessage); override;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery); override;
    procedure DoOnShippingQuery(AShippingQuery: TtgShippingQuery); override;
    procedure DoOnUpdate(AUpdate: TtgUpdate); override;
    procedure DoOnUpdates(AUpdates: TArray<ItgUpdate>); override;
  public
{$REGION 'Events|Події'}
    property OnCallbackQuery: TProc<TtgCallbackQuery> read FOnCallbackQuery write FOnCallbackQuery;
    property OnChannelPost: TProc<ITgMessage> read FOnChannelPost write FOnChannelPost;
    property OnChosenInlineResult: TProc<TtgChosenInlineResult> read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedChannelPost: TProc<ITgMessage> read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnEditedMessage: TProc<ITgMessage> read FOnEditedMessage write FOnEditedMessage;
    property OnInlineQuery: TProc<TtgInlineQuery> read FOnInlineQuery write FOnInlineQuery;
    property OnMessage: TProc<ITgMessage> read FOnMessage write FOnMessage;
    property OnPreCheckoutQuery: TProc<TtgPreCheckoutQuery> read FOnPreCheckoutQuery write FOnPreCheckoutQuery;
    property OnShippingQuery: TProc<TtgShippingQuery> read FOnShippingQuery write FOnShippingQuery;
    property OnUpdate: TProc<ItgUpdate> read FOnUpdate write FOnUpdate;
    property OnUpdates: TProc < TArray < ItgUpdate >> read FOnUpdates write FOnUpdates;
{$ENDREGION}
  end;

  TtgOnUpdate = procedure(ASender: TObject; AUpdate: TtgUpdate) of object;

  TtgOnUpdates = procedure(ASender: TObject; AUpdates: TArray<ItgUpdate>) of object;

  TtgOnMessage = procedure(ASender: TObject; AMessage: TTgMessage) of object;

  TtgOnInlineQuery = procedure(ASender: TObject; AInlineQuery: TtgInlineQuery) of object;

  TtgOnInlineResultChosen = procedure(ASender: TObject; AChosenInlineResult: TtgChosenInlineResult) of object;

  TtgOnCallbackQuery = procedure(ASender: TObject; ACallbackQuery: TtgCallbackQuery) of object;

  TtgOnChannelPost = procedure(ASender: TObject; AChanelPost: TTgMessage) of object;
  TtgOnShippingQuery = procedure(ASender: TObject; AShippingQuery: TtgShippingQuery) of object;
  TtgOnChosenInlineResult = procedure(ASender: TObject; AChosenInlineResult: TtgChosenInlineResult) of object;
  TtgOnEditedChannelPost = procedure(ASender: TObject; AEditedChannelPost: TTgMessage) of object;

  TTelegaPi = class(TTelegaPiBase)
  private
    FOnMessageEdited: TtgOnMessage;
    FOnInlineResultChosen: TtgOnInlineResultChosen;
    FOnUpdate: TtgOnUpdate;
    FOnChannelPost: TtgOnChannelPost;
    FOnCallbackQuery: TtgOnCallbackQuery;
    FOnMessage: TtgOnMessage;
    FOnInlineQuery: TtgOnInlineQuery;
    FOnUpdates: TtgOnUpdates;
    FOnShippingQuery: TtgOnShippingQuery;
    FOnChosenInlineResult: TtgOnChosenInlineResult;
    FOnEditedChannelPost: TtgOnEditedChannelPost;
    FOnEditedMessage: TtgOnMessage;

  protected
    procedure EventParser(AUpdates: TArray<ItgUpdate>); override;
  protected
    procedure DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery); override;
    procedure DoOnChannelPost(AChannelPost: TTgMessage); override;
    procedure DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult); override;
    procedure DoOnEditedChannelPost(AEditedChannelPost: TTgMessage); override;
    procedure DoOnEditedMessage(AEditedMessage: TTgMessage); override;
    procedure DoOnInlineQuery(AInlineQuery: TtgInlineQuery); override;
    procedure DoOnMessage(AMessage: TTgMessage); override;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery); override;
    procedure DoOnShippingQuery(AShippingQuery: TtgShippingQuery); override;
    procedure DoOnUpdate(AUpdate: TtgUpdate); override;
    procedure DoOnUpdates(AUpdates: TArray<ItgUpdate>); override;
  published
{$REGION 'Events|Події'}
    /// <summary>
    /// <para>
    /// Событие возникает когда получено <see cref="TelegAPi.Types|TtgUpdate" />
    /// </para>
    /// <para>
    /// Occurs when an <see cref="TelegAPi.Types|TtgUpdate" /> is
    /// received.
    /// </para>
    /// </summary>
    property OnUpdate: TtgOnUpdate read FOnUpdate write FOnUpdate;
    property OnUpdates: TtgOnUpdates read FOnUpdates write FOnUpdates;
    /// <summary>
    /// <para>
    /// Событие возникает когда получено <see cref="TelegAPi.Types|TtgMessage" />
    /// </para>
    /// <para>
    /// Occurs when a <see cref="TelegAPi.Types|TtgMessage" /> is
    /// recieved.
    /// </para>
    /// </summary>
    property OnMessage: TtgOnMessage read FOnMessage write FOnMessage;
    /// <summary>
    /// <para>
    /// Возникает когда <see cref="TelegAPi.Types|TtgMessage" /> было
    /// изменено.
    /// </para>
    /// <para>
    /// Occurs when <see cref="TelegAPi.Types|TtgMessage" /> was edited.
    /// </para>
    /// </summary>
    property OnMessageEdited: TtgOnMessage read FOnMessageEdited write FOnMessageEdited;
    property OnChannelPost: TtgOnChannelPost read FOnChannelPost write FOnChannelPost;
    /// <summary>
    /// <para>
    /// Возникает, когда получен <see cref="TelegAPi.Types|TtgInlineQuery" />
    /// </para>
    /// <para>
    /// Occurs when an <see cref="TelegAPi.Types|TtgInlineQuery" /> is
    /// received.
    /// </para>
    /// </summary>
    property OnInlineQuery: TtgOnInlineQuery read FOnInlineQuery write FOnInlineQuery;
    /// <summary>
    /// <para>
    /// Возникает когда получен <see cref="TelegAPi.Types|TtgChosenInlineResult" />
    /// </para>
    /// <para>
    /// Occurs when a <see cref="TelegAPi.Types|TtgChosenInlineResult" />
    /// is received.
    /// </para>
    /// </summary>
    property OnInlineResultChosen: TtgOnInlineResultChosen read FOnInlineResultChosen write FOnInlineResultChosen;
    /// <summary>
    /// <para>
    /// Возникает когда получен <see cref="TelegAPi.Types|TtgCallbackQuery" />
    /// </para>
    /// <para>
    /// Occurs when an <see cref="TelegAPi.Types|TtgCallbackQuery" /> is
    /// received
    /// </para>
    /// </summary>
    property OnCallbackQuery: TtgOnCallbackQuery read FOnCallbackQuery write FOnCallbackQuery;
    property OnShippingQuery: TtgOnShippingQuery read FOnShippingQuery write FOnShippingQuery;
    property OnChosenInlineResult: TtgOnChosenInlineResult read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedChannelPost: TtgOnEditedChannelPost read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnEditedMessage: TtgOnMessage read FOnEditedMessage write FOnEditedMessage;
{$ENDREGION}
  end;

procedure Register;

implementation

uses
  TelegaPi.Core.Methods;

procedure Register;
begin
  RegisterComponents('Telegram', [TTelegaPi]);
end;

{TTelegaPiBase }
function TTelegaPiBase.Close: ITgCloseMethod;
begin
  Result := TtgCloseMethod.Create(FMandarin, 'close');
end;

constructor TTelegaPiBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsAsyncMode := not IsConsole;
  FMandarin := TMandarinClientJson.Create();
  FMandarin.OnBeforeExcecute := procedure(AMandarin: IMandarin)
    begin
      AMandarin.AddUrlSegment('server', FServer); // do not localize
      AMandarin.AddUrlSegment('token', FToken); // do not localize
    end;
  FServer := 'https://api.telegram.org';
  FTimer := TThreadTimer.Create(
    procedure
    begin
      // FTimer.Stop; // Timer pause
      with GetUpdates do
      begin
        if FMessageOffset > 0 then
          SetOffset(FMessageOffset);
        if AllowedUpdates <> [] then
          SetAllowedUpdates(FAllowedUpdates);
        if FLimitUpdates > 0 then
          SetLimit(FLimitUpdates);
        Excecute(DoWorkWithUpdates);
      end;

    end);
  FTimer.Interval := 1000;
end;

destructor TTelegaPiBase.Destroy;
begin
  FTimer.Free;
  FMandarin.Free;
  inherited Destroy;
end;

procedure TTelegaPiBase.DoWorkWithUpdates(AUpdates: TArray<ItgUpdate>; AHttpResponse: IHTTPResponse);
begin
  if Assigned(AUpdates) and (Length(AUpdates) > 0) then
  begin
    EventParser(AUpdates);
    FMessageOffset := AUpdates[High(AUpdates)].UpdateID + 1;
    {Timer continue}
    //  FTimer.Start;
  end;
end;

procedure TTelegaPiBase.EventParser(AUpdates: TArray<ItgUpdate>);
begin
  DoOnUpdates(AUpdates);
  for var LUpdate in AUpdates do
  begin
    DoOnUpdate(LUpdate as TtgUpdate);
    TypeUpdate(LUpdate as TtgUpdate);
  end;
end;

function TTelegaPiBase.GetMe: ITgGetMeMethod;
begin
  Result := TtgGetMeMethod.Create(FMandarin, 'getMe');
end;

function TTelegaPiBase.GetUpdates: ITgGetUpdatesMethod;
begin
  Result := TtgGetUpdatesMethod.Create(FMandarin, 'getUpdates');
end;

function TTelegaPiBase.LogOut: ITgLogOutMethod;
begin
  Result := TtgLogOutMethod.Create(FMandarin, 'logOut');
end;

function TTelegaPiBase.SendMessage: ItgSendMessageMethod;
begin
  Result := TtgSendMessageMethod.Create(FMandarin, 'sendMessage');
end;

procedure TTelegaPiBase.Start;
begin
  FTimer.Start;
end;

procedure TTelegaPiBase.Stop;
begin
  FTimer.Stop;
end;

procedure TTelegaPiBase.TypeUpdate(AUpdate: ItgUpdate);
begin
  case AUpdate.GetType of
    TtgUpdateType.MessageUpdate:
      DoOnMessage(AUpdate.Message);

    TtgUpdateType.InlineQueryUpdate:
      DoOnInlineQuery(AUpdate.InlineQuery);

    TtgUpdateType.ChosenInlineResultUpdate:
      DoOnChosenInlineResult(AUpdate.ChosenInlineResult);

    TtgUpdateType.CallbackQueryUpdate:
      DoOnCallbackQuery(AUpdate.CallbackQuery);

    TtgUpdateType.EditedMessage:
      DoOnEditedMessage(AUpdate.EditedMessage);

    TtgUpdateType.ChannelPost:
      DoOnChannelPost(AUpdate.ChannelPost);

    TtgUpdateType.EditedChannelPost:
      DoOnEditedChannelPost(AUpdate.EditedChannelPost);

    TtgUpdateType.ShippingQueryUpdate:
      DoOnShippingQuery(AUpdate.ShippingQuery);

    TtgUpdateType.PreCheckoutQueryUpdate:
      DoOnPreCheckoutQuery(AUpdate.PreCheckoutQuery);
  else
    raise EArgumentOutOfRangeException.Create('Unknown Event Type');
  end;
end;

{ TTelegaPiConsole }

procedure TTelegaPiConsole.DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(ACallbackQuery);
end;

procedure TTelegaPiConsole.DoOnChannelPost(AChannelPost: TTgMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(AChannelPost);
end;

procedure TTelegaPiConsole.DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(AChosenInlineResult);
end;

procedure TTelegaPiConsole.DoOnEditedChannelPost(AEditedChannelPost: TTgMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(AEditedChannelPost);
end;

procedure TTelegaPiConsole.DoOnEditedMessage(AEditedMessage: TTgMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(AEditedMessage);
end;

procedure TTelegaPiConsole.DoOnInlineQuery(AInlineQuery: TtgInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(AInlineQuery);
end;

procedure TTelegaPiConsole.DoOnMessage(AMessage: TTgMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(AMessage);
end;

procedure TTelegaPiConsole.DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
    OnPreCheckoutQuery(APreCheckoutQuery);
end;

procedure TTelegaPiConsole.DoOnShippingQuery(AShippingQuery: TtgShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(AShippingQuery);
end;

procedure TTelegaPiConsole.DoOnUpdate(AUpdate: TtgUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(AUpdate);
end;

procedure TTelegaPiConsole.DoOnUpdates(AUpdates: TArray<ItgUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(AUpdates);
end;

{ TTelegaPi }

procedure TTelegaPi.DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(Self, ACallbackQuery);
end;

procedure TTelegaPi.DoOnChannelPost(AChannelPost: TTgMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(Self, AChannelPost);
end;

procedure TTelegaPi.DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(Self, AChosenInlineResult);
end;

procedure TTelegaPi.DoOnEditedChannelPost(AEditedChannelPost: TTgMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(Self, AEditedChannelPost);
end;

procedure TTelegaPi.DoOnEditedMessage(AEditedMessage: TTgMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(Self, AEditedMessage);
end;

procedure TTelegaPi.DoOnInlineQuery(AInlineQuery: TtgInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(Self, AInlineQuery);
end;

procedure TTelegaPi.DoOnMessage(AMessage: TTgMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(Self, AMessage);
end;

procedure TTelegaPi.DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery);
begin
  inherited;
  //  if Assigned(OnPreCheckoutQuery) then
  //    OnPreCheckoutQuery(APreCheckoutQuery);
end;

procedure TTelegaPi.DoOnShippingQuery(AShippingQuery: TtgShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(Self, AShippingQuery);
end;

procedure TTelegaPi.DoOnUpdate(AUpdate: TtgUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(Self, AUpdate);
end;

procedure TTelegaPi.DoOnUpdates(AUpdates: TArray<ItgUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(Self, AUpdates);
end;

procedure TTelegaPi.EventParser(AUpdates: TArray<ItgUpdate>);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      inherited EventParser(AUpdates);
    end);
end;

end.
