unit TelegaPi.Core.Types;

interface

uses
  Citrus.JObject,
  System.JSON.Serializers,
  TelegaPi.Types;

type
  TTgResponse = class
  private
    [JsonName('ok')]
    FIsOk: Boolean;
    [JsonName('result')]
    [JsonConverter(TJObjectConverter)]
    FResult: TJObject;
    [JsonName('error_code')]
    FErrorCode: Integer;
    [JsonName('description')]
    FDescription: string;
  public
    constructor Create;
    destructor Destroy; override;
    property IsOk: Boolean read FIsOk write FIsOk;
    property Result: TJObject read FResult write FResult;
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property Description: string read FDescription write FDescription;
  end;

  TTgUser = class(TInterfacedObject, ItgUser)
  private
    [JsonName('can_join_groups')]
    FCanJoinGroups: Boolean;
    [JsonName('can_read_all_group_messages')]
    FCanReadAllGroupMessages: Boolean;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('id')]
    FId: Int64;
    [JsonName('is_bot')]
    FIsBot: Boolean;
    [JsonName('supports_inline_queries')]
    FSupportsInlineQueries: Boolean;
    [JsonName('username')]
    FUsername: string;
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetFirstName: string;
    function GetId: Int64;
    function GetIsBot: Boolean;
    function GetSupportsInlineQueries: Boolean;
    function GetUsername: string;
  public
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    property FirstName: string read GetFirstName;
    property Id: Int64 read GetId;
    property IsBot: Boolean read GetIsBot;
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
    property Username: string read GetUsername;
  end;

  TtgChat = class

  end;

  TtgMessage = class
  private
    [JsonName('via_bot')]
    [JsonName('message_id')]
    FMessageId: Int64;
    [JsonName('message_thread_id')]
    FMessageThreadId: Int64;
    [JsonName('from')]
    FFrom: TTgUser;
    [JsonName('sender_chat')]
    FSenderChat: TtgChat;
    [JsonName('date')]
    FDate: Integer;
    [JsonName('chat')]
    FChat: TtgChat;
    [JsonName('forward_from')]
    FForwardFrom: TTgUser;
    [JsonName('forward_from_chat')]
    FForwardFromChat: TtgChat;
    [JsonName('forward_from_message_id')]
    FForwardFromMessageId: Int64;
    [JsonName('forward_signature')]
    FForwardSignature: string;
    [JsonName('forward_signature')]
    FForwardSenderName: string;
    [JsonName('forward_date')]
    FForwardDate: Integer;
    [JsonName('is_topic_message')]
    FIsTopicMessage: Boolean;
    [JsonName('is_automatic_forward')]
    FIsAutomaticForward: Boolean;
    [JsonName('reply_to_message')]
    FReplyToMessage: TtgMessage;
    [JsonName('via_bot')]
    FViaBot: TTgUser;
    [JsonName('edit_date')]
    FEditDate: Integer;
    FHasProtectedContent: Boolean;
  public
    property MessageId: Int64 read FMessageId write FMessageId;
    property MessageThreadId: Int64 read FMessageThreadId write FMessageThreadId;
    property From: TTgUser read FFrom write FFrom;
    property SenderChat: TtgChat read FSenderChat write FSenderChat;
    property Date: Integer read FDate write FDate;
    property Chat: TtgChat read FChat write FChat;
    property ForwardFrom: TTgUser read FForwardFrom write FForwardFrom;
    property ForwardFromChat: TtgChat read FForwardFromChat write FForwardFromChat;
    property ForwardFromMessageId: Int64 read FForwardFromMessageId write FForwardFromMessageId;
    property ForwardSignature: string read FForwardSignature write FForwardSignature;
    property ForwardSenderName: string read FForwardSenderName write FForwardSenderName;
    property ForwardDate: Integer read FForwardDate write FForwardDate;
    property IsTopicMessage: Boolean read FIsTopicMessage write FIsTopicMessage;
    property IsAutomaticForward: Boolean read FIsAutomaticForward write FIsAutomaticForward;
    property ReplyToMessage: TtgMessage read FReplyToMessage write FReplyToMessage;
    property ViaBot: TTgUser read FViaBot write FViaBot;
    property EditDate: Integer read FEditDate write FEditDate;
    property HasProtectedContent: Boolean read FHasProtectedContent write FHasProtectedContent;
  end;

  TtgInlineQuery = class

  end;

  TtgChosenInlineResult = class

  end;

  TtgCallbackQuery = class

  end;

  TtgShippingQuery = class

  end;

  TtgPreCheckoutQuery = class

  end;

  TtgPoll = class

  end;

  TtgPollAnswer = class

  end;

  TtgChatMemberUpdated = class

  end;

  TtgChatJoinRequest = class

  end;

  TtgUpdate = class(TInterfacedObject, ItgUpdate)
  private
    [JsonName('update_id')]
    FUpdateId: Int64;
    [JsonName('message')]
    FMessage: TtgMessage;
    [JsonName('edited_message')]
    FEditedMessage: TtgMessage;
    [JsonName('channel_post')]
    FChannelPost: TtgMessage;
    [JsonName('edited_channel_post')]
    FEditedChannelPost: TtgMessage;
    [JsonName('inline_query')]
    FInlineQuery: TtgInlineQuery;
    [JsonName('chosen_inline_result')]
    FChosenInlineResult: TtgChosenInlineResult;
    [JsonName('callback_query')]
    FCallbackQuery: TtgCallbackQuery;
    [JsonName('shipping_query')]
    FShippingQuery: TtgShippingQuery;
    [JsonName('pre_checkout_query')]
    FPreCheckoutQuery: TtgPreCheckoutQuery;
    [JsonName('poll')]
    FPoll: TtgPoll;
    [JsonName('poll_answer')]
    FPollAnswer: TtgPollAnswer;
    [JsonName('my_chat_member')]
    FMyChatMember: TtgChatMemberUpdated;
    [JsonName('chat_member')]
    FChatMember: TtgChatMemberUpdated;
    FChatJoinRequest: TtgChatJoinRequest;
    function GetCallbackQuery: TtgCallbackQuery;
    function GetChannelPost: TtgMessage;
    function GetChatJoinRequest: TtgChatJoinRequest;
    function GetChatMember: TtgChatMemberUpdated;
    function GetChosenInlineResult: TtgChosenInlineResult;
    function GetEditedChannelPost: TtgMessage;
    function GetEditedMessage: TtgMessage;
    function GetInlineQuery: TtgInlineQuery;
    function GetMessage: TtgMessage;
    function GetMyChatMember: TtgChatMemberUpdated;
    function GetPoll: TtgPoll;
    function GetPollAnswer: TtgPollAnswer;
    function GetPreCheckoutQuery: TtgPreCheckoutQuery;
    function GetShippingQuery: TtgShippingQuery;
    function GetUpdateId: Int64;
  public
    constructor Create;
    destructor Destroy; override;
    property UpdateId: Int64 read GetUpdateId;
    property Message: TtgMessage read GetMessage;
    property EditedMessage: TtgMessage read GetEditedMessage;
    property ChannelPost: TtgMessage read GetChannelPost;
    property EditedChannelPost: TtgMessage read GetEditedChannelPost;
    property InlineQuery: TtgInlineQuery read GetInlineQuery;
    property ChosenInlineResult: TtgChosenInlineResult read GetChosenInlineResult;
    property CallbackQuery: TtgCallbackQuery read GetCallbackQuery;
    property ShippingQuery: TtgShippingQuery read GetShippingQuery;
    property PreCheckoutQuery: TtgPreCheckoutQuery read GetPreCheckoutQuery;
    property Poll: TtgPoll read GetPoll;
    property PollAnswer: TtgPollAnswer read GetPollAnswer;
    property MyChatMember: TtgChatMemberUpdated read GetMyChatMember;
    property ChatMember: TtgChatMemberUpdated read GetChatMember;
    property ChatJoinRequest: TtgChatJoinRequest read GetChatJoinRequest;
  end;

implementation

function TTgUser.GetCanJoinGroups: Boolean;
begin
  Result := FCanJoinGroups;
end;

function TTgUser.GetCanReadAllGroupMessages: Boolean;
begin
  Result := FCanReadAllGroupMessages;
end;

function TTgUser.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TTgUser.GetId: Int64;
begin
  Result := FId;
end;

function TTgUser.GetIsBot: Boolean;
begin
  Result := FIsBot;
end;

function TTgUser.GetSupportsInlineQueries: Boolean;
begin
  Result := FSupportsInlineQueries;
end;

function TTgUser.GetUsername: string;
begin
  Result := FUsername;
end;

constructor TTgResponse.Create;
begin
  inherited Create;
  FResult := TJObject.Create();
end;

destructor TTgResponse.Destroy;
begin
  FResult.Free;
  inherited Destroy;
end;

constructor TtgUpdate.Create;
begin
  inherited Create;
  FMessage := TtgMessage.Create();
  FEditedMessage := TtgMessage.Create();
  FChannelPost := TtgMessage.Create();
  FEditedChannelPost := TtgMessage.Create();
  FInlineQuery := TtgInlineQuery.Create();
  FChosenInlineResult := TtgChosenInlineResult.Create();
  FCallbackQuery := TtgCallbackQuery.Create();
  FShippingQuery := TtgShippingQuery.Create();
  FPreCheckoutQuery := TtgPreCheckoutQuery.Create();
  FPoll := TtgPoll.Create();
  FPollAnswer := TtgPollAnswer.Create();
  FMyChatMember := TtgChatMemberUpdated.Create();
  FChatMember := TtgChatMemberUpdated.Create();
  FChatJoinRequest := TtgChatJoinRequest.Create();
end;

destructor TtgUpdate.Destroy;
begin
  FChatJoinRequest.Free;
  FChatMember.Free;
  FMyChatMember.Free;
  FPollAnswer.Free;
  FPoll.Free;
  FPreCheckoutQuery.Free;
  FShippingQuery.Free;
  FCallbackQuery.Free;
  FChosenInlineResult.Free;
  FInlineQuery.Free;
  FEditedChannelPost.Free;
  FChannelPost.Free;
  FEditedMessage.Free;
  FMessage.Free;
  inherited Destroy;
end;

function TtgUpdate.GetCallbackQuery: TtgCallbackQuery;
begin
  Result := FCallbackQuery;
end;

function TtgUpdate.GetChannelPost: TtgMessage;
begin
  Result := FChannelPost;
end;

function TtgUpdate.GetChatJoinRequest: TtgChatJoinRequest;
begin
  Result := FChatJoinRequest;
end;

function TtgUpdate.GetChatMember: TtgChatMemberUpdated;
begin
  Result := FChatMember;
end;

function TtgUpdate.GetChosenInlineResult: TtgChosenInlineResult;
begin
  Result := FChosenInlineResult;
end;

function TtgUpdate.GetEditedChannelPost: TtgMessage;
begin
  Result := FEditedChannelPost;
end;

function TtgUpdate.GetEditedMessage: TtgMessage;
begin
  Result := FEditedMessage;
end;

function TtgUpdate.GetInlineQuery: TtgInlineQuery;
begin
  Result := FInlineQuery;
end;

function TtgUpdate.GetMessage: TtgMessage;
begin
  Result := FMessage;
end;

function TtgUpdate.GetMyChatMember: TtgChatMemberUpdated;
begin
  Result := FMyChatMember;
end;

function TtgUpdate.GetPoll: TtgPoll;
begin
  Result := FPoll;
end;

function TtgUpdate.GetPollAnswer: TtgPollAnswer;
begin
  Result := FPollAnswer;
end;

function TtgUpdate.GetPreCheckoutQuery: TtgPreCheckoutQuery;
begin
  Result := FPreCheckoutQuery;
end;

function TtgUpdate.GetShippingQuery: TtgShippingQuery;
begin
  Result := FShippingQuery;
end;

function TtgUpdate.GetUpdateId: Int64;
begin
  Result := FUpdateId;
end;

end.
