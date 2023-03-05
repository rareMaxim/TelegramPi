unit TelegaPi.Types;

interface

uses
  System.JSON.Serializers;

type
{$SCOPEDENUMS ON}
  /// <summary>
  /// The type of an Update
  /// </summary>
  TtgUpdateType = (
    /// <summary>
    /// Update Type is unknown
    /// </summary>
    UnknownUpdate = 0,

    /// <summary>
    /// The <see cref="Update" /> contains a <see cref="Message" />.
    /// </summary>
    MessageUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an edited <see cref="Message" />
    /// </summary>
    EditedMessage,
    /// <summary>
    /// The <see cref="Update" /> contains a channel post <see cref="Message" />
    /// </summary>
    ChannelPost,
    /// <summary>
    /// The <see cref="Update" /> contains an edited channel post <see cref="Message" />
    /// </summary>
    EditedChannelPost,
    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="InlineQuery" />.
    /// </summary>
    InlineQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains a <see cref="ChosenInlineResult" />
    /// </summary>
    ChosenInlineResultUpdate,

    /// <summary>
    /// The <see cref="Update" /> contins a <see cref="CallbackQuery" />
    /// </summary>
    CallbackQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="ShippingQueryUpdate" />
    /// </summary>
    ShippingQueryUpdate,

    /// <summary>
    /// The <see cref="Update" /> contains an <see cref="PreCheckoutQueryUpdate" />
    /// </summary>
    PreCheckoutQueryUpdate,
    //
    Pool,
    //
    PollAnswer,
    //
    MyChatMember,
    //
    ChatMember,
    //
    ChatJoinRequest,

    /// <summary>
    /// Receive all <see cref="Update" /> Types
    /// </summary>
    All = 255);

  TAllowedUpdate = (message, Edited_message, Channel_post, Edited_channel_post, Inline_query, Chosen_inline_result,
    Callback_query);
  TAllowedUpdates = set of TAllowedUpdate;

{$SCOPEDENUMS OFF}

  ItgUser = interface
    ['{33BF51DB-F10F-4408-9E64-82E56AB870FE}']
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetFirstName: string;
    function GetId: Int64;
    function GetIsBot: Boolean;
    function GetSupportsInlineQueries: Boolean;
    function GetUsername: string;
    // public
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    property FirstName: string read GetFirstName;
    property Id: Int64 read GetId;
    property IsBot: Boolean read GetIsBot;
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
    property Username: string read GetUsername;
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

  TtgChatPhoto = class

  end;

  TtgMessage = class;

  TtgChatPermissions = class

  end;

  TtgChatLocation = class

  end;

  TtgChat = class
  private
    [JsonName('id')]
    FId: Int64;
    [JsonName('type')]
    FType: string;
    [JsonName('title')]
    FTitle: string;
    [JsonName('username')]
    FUsername: string;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('is_forum')]
    FIsForum: Boolean;
    [JsonName('photo')]
    FPhoto: TtgChatPhoto;
    [JsonName('active_usernames')]
    FActiveUsernames: TArray<string>;
    [JsonName('emoji_status_custom_emoji_id')]
    FEmojiStatusCustomEmojiId: string;
    [JsonName('bio')]
    FBio: string;
    [JsonName('has_private_forwards')]
    FHasPrivateForwards: Boolean;
    [JsonName('has_restricted_voice_and_video_messages')]
    FHasRestrictedVoiceAndVideoMessages: Boolean;
    [JsonName('join_to_send_messages')]
    FJoinToSendMessages: Boolean;
    [JsonName('join_by_request')]
    FJoinByRequest: Boolean;
    [JsonName('description')]
    FDescription: string;
    [JsonName('invite_link')]
    FInviteLink: string;
    [JsonName('pinned_message')]
    FPinnedMessage: TtgMessage;
    [JsonName('permissions')]
    FPermissions: TtgChatPermissions;
    [JsonName('slow_mode_delay')]
    FSlowModeDelay: Integer;
    [JsonName('message_auto_delete_time')]
    FMessageAutoDeleteTime: Integer;
    [JsonName('has_aggressive_anti_spam_enabled')]
    FHasAggressiveAntiSpamEnabled: Boolean;
    [JsonName('has_hidden_members')]
    FHasHiddenMembers: Boolean;
    [JsonName('has_protected_content')]
    FHasProtectedContent: Boolean;
    [JsonName('sticker_set_name')]
    FStickerSetName: string;
    [JsonName('can_set_sticker_set')]
    FCanSetStickerSet: Boolean;
    [JsonName('linked_chat_id')]
    FLinkedChatId: Int64;
    [JsonName('location')]
    FLocation: TtgChatLocation;
  public
    property Id: Int64 read FId write FId;
    property &Type: string read FType write FType;
    property Title: string read FTitle write FTitle;
    property Username: string read FUsername write FUsername;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property IsForum: Boolean read FIsForum write FIsForum;
    property Photo: TtgChatPhoto read FPhoto write FPhoto;
    property ActiveUsernames: TArray<string> read FActiveUsernames write FActiveUsernames;
    property EmojiStatusCustomEmojiId: string read FEmojiStatusCustomEmojiId write FEmojiStatusCustomEmojiId;
    property Bio: string read FBio write FBio;
    property HasPrivateForwards: Boolean read FHasPrivateForwards write FHasPrivateForwards;
    property HasRestrictedVoiceAndVideoMessages: Boolean read FHasRestrictedVoiceAndVideoMessages
      write FHasRestrictedVoiceAndVideoMessages;
    property JoinToSendMessages: Boolean read FJoinToSendMessages write FJoinToSendMessages;
    property JoinByRequest: Boolean read FJoinByRequest write FJoinByRequest;
    property Description: string read FDescription write FDescription;
    property InviteLink: string read FInviteLink write FInviteLink;
    property PinnedMessage: TtgMessage read FPinnedMessage write FPinnedMessage;
    property Permissions: TtgChatPermissions read FPermissions write FPermissions;
    property SlowModeDelay: Integer read FSlowModeDelay write FSlowModeDelay;
    property MessageAutoDeleteTime: Integer read FMessageAutoDeleteTime write FMessageAutoDeleteTime;
    property HasAggressiveAntiSpamEnabled: Boolean read FHasAggressiveAntiSpamEnabled
      write FHasAggressiveAntiSpamEnabled;
    property HasHiddenMembers: Boolean read FHasHiddenMembers write FHasHiddenMembers;
    property HasProtectedContent: Boolean read FHasProtectedContent write FHasProtectedContent;
    property StickerSetName: string read FStickerSetName write FStickerSetName;
    property CanSetStickerSet: Boolean read FCanSetStickerSet write FCanSetStickerSet;
    property LinkedChatId: Int64 read FLinkedChatId write FLinkedChatId;
    property Location: TtgChatLocation read FLocation write FLocation;
  end;

  TtgMessageEntity = class

  end;

  TtgAnimation = class

  end;

  TtgAudio = class

  end;

  TtgDocument = class

  end;

  TtgPhotoSize = class

  end;

  TtgSticker = class

  end;

  TtgVideo = class

  end;

  TtgVideoNote = class

  end;

  TtgVoice = class

  end;

  TtgContact = class

  end;

  TtgDice = class

  end;

  TtgGame = class

  end;

  TtgPoll = class

  end;

  TtgVenue = class

  end;

  TtgLocation = class

  end;

  TtgMessageAutoDeleteTimerChanged = class

  end;

  TtgInvoice = class

  end;

  TtgSuccessfulPayment = class

  end;

  TtgUserShared = class

  end;

  TtgChatShared = class

  end;

  TtgWriteAccessAllowed = class

  end;

  TtgPassportData = class

  end;

  TtgProximityAlertTriggered = class

  end;

  TtgForumTopicCreated = class

  end;

  TtgForumTopicEdited = class

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

  TtgPollAnswer = class

  end;

  TtgChatMemberUpdated = class

  end;

  TtgChatJoinRequest = class

  end;

  TtgForumTopicClosed = class

  end;

  TtgForumTopicReopened = class

  end;

  TtgGeneralForumTopicHidden = class

  end;

  TtgGeneralForumTopicUnhidden = class

  end;

  TtgVideoChatScheduled = class

  end;

  TtgVideoChatStarted = class

  end;

  TtgVideoChatEnded = class

  end;

  TtgVideoChatParticipantsInvited = class

  end;

  TtgWebAppData = class

  end;

  TtgInlineKeyboardMarkup = class

  end;

  ItgUpdate = interface
    ['{66946DBE-B901-4080-8D31-FDB08BD5DA9A}']
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
    //  public
    function GetType: TtgUpdateType;
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

  ItgMessage = interface
    ['{1EED92B5-35C2-4FDF-ACCF-16053DDBB9C0}']
    function GetAnimation: TtgAnimation;
    function GetAudio: TtgAudio;
    function GetAuthorSignature: string;
    function GetCaption: string;
    function GetCaptionEntities: TArray<TtgMessageEntity>;
    function GetChannelChatCreated: Boolean;
    function GetChat: TtgChat;
    function GetChatShared: TtgChatShared;
    function GetConnectedWebsite: string;
    function GetContact: TtgContact;
    function GetDate: Integer;
    function GetDeleteChatPhoto: Boolean;
    function GetDice: TtgDice;
    function GetDocument: TtgDocument;
    function GetEditDate: Integer;
    function GetEntities: TArray<TtgMessageEntity>;
    function GetForumTopicClosed: TtgForumTopicClosed;
    function GetForumTopicCreated: TtgForumTopicCreated;
    function GetForumTopicEdited: TtgForumTopicEdited;
    function GetForumTopicReopened: TtgForumTopicReopened;
    function GetForwardDate: Integer;
    function GetForwardFrom: TTgUser;
    function GetForwardFromChat: TtgChat;
    function GetForwardFromMessageId: Int64;
    function GetForwardSenderName: string;
    function GetForwardSignature: string;
    function GetFrom: TTgUser;
    function GetGame: TtgGame;
    function GetGeneralForumTopicHidden: TtgGeneralForumTopicHidden;
    function GetGeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden;
    function GetGroupChatCreated: Boolean;
    function GetHasMediaSpoiler: Boolean;
    function GetHasProtectedContent: Boolean;
    function GetInvoice: TtgInvoice;
    function GetIsAutomaticForward: Boolean;
    function GetIsTopicMessage: Boolean;
    function GetLeftChatMember: TTgUser;
    function GetLocation: TtgLocation;
    function GetMediaGroupId: string;
    function GetMessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged;
    function GetMessageId: Int64;
    function GetMessageThreadId: Int64;
    function GetMigrateFromChatId: Int64;
    function GetMigrateToChatId: Int64;
    function GetNewChatMembers: TArray<TTgUser>;
    function GetNewChatPhoto: TArray<TtgPhotoSize>;
    function GetNewChatTitle: string;
    function GetPassportData: TtgPassportData;
    function GetPhoto: TArray<TtgPhotoSize>;
    function GetPinnedMessage: TtgMessage;
    function GetPoll: TtgPoll;
    function GetProximityAlertTriggered: TtgProximityAlertTriggered;
    function GetReplyMarkup: TtgInlineKeyboardMarkup;
    function GetReplyToMessage: TtgMessage;
    function GetSenderChat: TtgChat;
    function GetSticker: TtgSticker;
    function GetSuccessfulPayment: TtgSuccessfulPayment;
    function GetSupergroupChatCreated: Boolean;
    function GetText: string;
    function GetUserShared: TtgUserShared;
    function GetVenue: TtgVenue;
    function GetViaBot: TTgUser;
    function GetVideo: TtgVideo;
    function GetVideoChatEnded: TtgVideoChatEnded;
    function GetVideoChatParticipantsInvited: TtgVideoChatParticipantsInvited;
    function GetVideoChatScheduled: TtgVideoChatScheduled;
    function GetVideoChatStarted: TtgVideoChatStarted;
    function GetVideoNote: TtgVideoNote;
    function GetVoice: TtgVoice;
    function GetWebAppData: TtgWebAppData;
    function GetWriteAccessAllowed: TtgWriteAccessAllowed;
    //  public

    property MessageId: Int64 read GetMessageId;
    property MessageThreadId: Int64 read GetMessageThreadId;
    property From: TTgUser read GetFrom;
    property SenderChat: TtgChat read GetSenderChat;
    property Date: Integer read GetDate;
    property Chat: TtgChat read GetChat;
    property ForwardFrom: TTgUser read GetForwardFrom;
    property ForwardFromChat: TtgChat read GetForwardFromChat;
    property ForwardFromMessageId: Int64 read GetForwardFromMessageId;
    property ForwardSignature: string read GetForwardSignature;
    property ForwardSenderName: string read GetForwardSenderName;
    property ForwardDate: Integer read GetForwardDate;
    property IsTopicMessage: Boolean read GetIsTopicMessage;
    property IsAutomaticForward: Boolean read GetIsAutomaticForward;
    property ReplyToMessage: TtgMessage read GetReplyToMessage;
    property ViaBot: TTgUser read GetViaBot;
    property EditDate: Integer read GetEditDate;
    property HasProtectedContent: Boolean read GetHasProtectedContent;
    property MediaGroupId: string read GetMediaGroupId;
    property AuthorSignature: string read GetAuthorSignature;
    property Text: string read GetText;
    property Entities: TArray<TtgMessageEntity> read GetEntities;
    property Animation: TtgAnimation read GetAnimation;
    property Audio: TtgAudio read GetAudio;
    property Document: TtgDocument read GetDocument;
    property Photo: TArray<TtgPhotoSize> read GetPhoto;
    property Sticker: TtgSticker read GetSticker;
    property Video: TtgVideo read GetVideo;
    property VideoNote: TtgVideoNote read GetVideoNote;
    property Voice: TtgVoice read GetVoice;
    property Caption: string read GetCaption;
    property CaptionEntities: TArray<TtgMessageEntity> read GetCaptionEntities;
    property HasMediaSpoiler: Boolean read GetHasMediaSpoiler;
    property Contact: TtgContact read GetContact;
    property Dice: TtgDice read GetDice;
    property Game: TtgGame read GetGame;
    property Poll: TtgPoll read GetPoll;
    property Venue: TtgVenue read GetVenue;
    property Location: TtgLocation read GetLocation;
    property NewChatMembers: TArray<TTgUser> read GetNewChatMembers;
    property LeftChatMember: TTgUser read GetLeftChatMember;
    property NewChatTitle: string read GetNewChatTitle;
    property NewChatPhoto: TArray<TtgPhotoSize> read GetNewChatPhoto;
    property DeleteChatPhoto: Boolean read GetDeleteChatPhoto;
    property GroupChatCreated: Boolean read GetGroupChatCreated;
    property SupergroupChatCreated: Boolean read GetSupergroupChatCreated;
    property ChannelChatCreated: Boolean read GetChannelChatCreated;
    property MessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged read GetMessageAutoDeleteTimerChanged;
    property MigrateToChatId: Int64 read GetMigrateToChatId;
    property MigrateFromChatId: Int64 read GetMigrateFromChatId;
    property PinnedMessage: TtgMessage read GetPinnedMessage;
    property Invoice: TtgInvoice read GetInvoice;
    property SuccessfulPayment: TtgSuccessfulPayment read GetSuccessfulPayment;
    property UserShared: TtgUserShared read GetUserShared;
    property ChatShared: TtgChatShared read GetChatShared;
    property ConnectedWebsite: string read GetConnectedWebsite;
    property WriteAccessAllowed: TtgWriteAccessAllowed read GetWriteAccessAllowed;
    property PassportData: TtgPassportData read GetPassportData;
    property ProximityAlertTriggered: TtgProximityAlertTriggered read GetProximityAlertTriggered;
    property ForumTopicCreated: TtgForumTopicCreated read GetForumTopicCreated;
    property ForumTopicEdited: TtgForumTopicEdited read GetForumTopicEdited;
    property ForumTopicClosed: TtgForumTopicClosed read GetForumTopicClosed;
    property ForumTopicReopened: TtgForumTopicReopened read GetForumTopicReopened;
    property GeneralForumTopicHidden: TtgGeneralForumTopicHidden read GetGeneralForumTopicHidden;
    property GeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden read GetGeneralForumTopicUnhidden;
    property VideoChatScheduled: TtgVideoChatScheduled read GetVideoChatScheduled;
    property VideoChatStarted: TtgVideoChatStarted read GetVideoChatStarted;
    property VideoChatEnded: TtgVideoChatEnded read GetVideoChatEnded;
    property VideoChatParticipantsInvited: TtgVideoChatParticipantsInvited read GetVideoChatParticipantsInvited;
    property WebAppData: TtgWebAppData read GetWebAppData;
    property ReplyMarkup: TtgInlineKeyboardMarkup read GetReplyMarkup;
  end;

  TtgMessage = class(TInterfacedObject, ItgMessage)
  private
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
    [JsonName('has_protected_content')]
    FHasProtectedContent: Boolean;
    [JsonName('media_group_id')]
    FMediaGroupId: string;
    [JsonName('author_signature')]
    FAuthorSignature: string;
    [JsonName('text')]
    FText: string;
    [JsonName('entities')]
    FEntities: TArray<TtgMessageEntity>;
    [JsonName('animation')]
    FAnimation: TtgAnimation;
    [JsonName('audio')]
    FAudio: TtgAudio;
    [JsonName('document')]
    FDocument: TtgDocument;
    [JsonName('photo')]
    FPhoto: TArray<TtgPhotoSize>;
    [JsonName('sticker')]
    FSticker: TtgSticker;
    [JsonName('video')]
    FVideo: TtgVideo;
    [JsonName('video_note')]
    FVideoNote: TtgVideoNote;
    [JsonName('voice')]
    FVoice: TtgVoice;
    [JsonName('caption')]
    FCaption: string;
    [JsonName('caption_entities')]
    FCaptionEntities: TArray<TtgMessageEntity>;
    [JsonName('has_media_spoiler')]
    FHasMediaSpoiler: Boolean;
    [JsonName('contact')]
    FContact: TtgContact;
    [JsonName('dice')]
    FDice: TtgDice;
    [JsonName('game')]
    FGame: TtgGame;
    [JsonName('poll')]
    FPoll: TtgPoll;
    [JsonName('venue')]
    FVenue: TtgVenue;
    [JsonName('location')]
    FLocation: TtgLocation;
    [JsonName('new_chat_members')]
    FNewChatMembers: TArray<TTgUser>;
    [JsonName('left_chat_member')]
    FLeftChatMember: TTgUser;
    [JsonName('new_chat_title')]
    FNewChatTitle: string;
    [JsonName('new_chat_photo')]
    FNewChatPhoto: TArray<TtgPhotoSize>;
    [JsonName('delete_chat_photo')]
    FDeleteChatPhoto: Boolean;
    [JsonName('group_chat_created')]
    FGroupChatCreated: Boolean;
    [JsonName('supergroup_chat_created')]
    FSupergroupChatCreated: Boolean;
    [JsonName('channel_chat_created')]
    FChannelChatCreated: Boolean;
    [JsonName('message_auto_delete_timer_changed')]
    FMessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged;
    [JsonName('migrate_to_chat_id')]
    FMigrateToChatId: Int64;
    [JsonName('migrate_from_chat_id')]
    FMigrateFromChatId: Int64;
    [JsonName('pinned_message')]
    FPinnedMessage: TtgMessage;
    [JsonName('invoice')]
    FInvoice: TtgInvoice;
    [JsonName('successful_payment')]
    FSuccessfulPayment: TtgSuccessfulPayment;
    [JsonName('user_shared')]
    FUserShared: TtgUserShared;
    [JsonName('chat_shared')]
    FChatShared: TtgChatShared;
    [JsonName('connected_website')]
    FConnectedWebsite: string;
    [JsonName('write_access_allowed')]
    FWriteAccessAllowed: TtgWriteAccessAllowed;
    [JsonName('passport_data')]
    FPassportData: TtgPassportData;
    [JsonName('proximity_alert_triggered')]
    FProximityAlertTriggered: TtgProximityAlertTriggered;
    [JsonName('forum_topic_created')]
    FForumTopicCreated: TtgForumTopicCreated;
    [JsonName('forum_topic_edited')]
    FForumTopicEdited: TtgForumTopicEdited;
    [JsonName('forum_topic_closed')]
    FForumTopicClosed: TtgForumTopicClosed;
    [JsonName('forum_topic_reopened')]
    FForumTopicReopened: TtgForumTopicReopened;
    [JsonName('general_forum_topic_hidden')]
    FGeneralForumTopicHidden: TtgGeneralForumTopicHidden;
    [JsonName('general_forum_topic_unhidden')]
    FGeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden;
    [JsonName('video_chat_scheduled')]
    FVideoChatScheduled: TtgVideoChatScheduled;
    [JsonName('video_chat_started')]
    FVideoChatStarted: TtgVideoChatStarted;
    [JsonName('video_chat_ended')]
    FVideoChatEnded: TtgVideoChatEnded;
    [JsonName('video_chat_participants_invited')]
    FVideoChatParticipantsInvited: TtgVideoChatParticipantsInvited;
    [JsonName('web_app_data')]
    FWebAppData: TtgWebAppData;
    [JsonName('reply_markup')]
    FReplyMarkup: TtgInlineKeyboardMarkup;
    function GetAnimation: TtgAnimation;
    function GetAudio: TtgAudio;
    function GetAuthorSignature: string;
    function GetCaption: string;
    function GetCaptionEntities: TArray<TtgMessageEntity>;
    function GetChannelChatCreated: Boolean;
    function GetChat: TtgChat;
    function GetChatShared: TtgChatShared;
    function GetConnectedWebsite: string;
    function GetContact: TtgContact;
    function GetDate: Integer;
    function GetDeleteChatPhoto: Boolean;
    function GetDice: TtgDice;
    function GetDocument: TtgDocument;
    function GetEditDate: Integer;
    function GetEntities: TArray<TtgMessageEntity>;
    function GetForumTopicClosed: TtgForumTopicClosed;
    function GetForumTopicCreated: TtgForumTopicCreated;
    function GetForumTopicEdited: TtgForumTopicEdited;
    function GetForumTopicReopened: TtgForumTopicReopened;
    function GetForwardDate: Integer;
    function GetForwardFrom: TTgUser;
    function GetForwardFromChat: TtgChat;
    function GetForwardFromMessageId: Int64;
    function GetForwardSenderName: string;
    function GetForwardSignature: string;
    function GetFrom: TTgUser;
    function GetGame: TtgGame;
    function GetGeneralForumTopicHidden: TtgGeneralForumTopicHidden;
    function GetGeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden;
    function GetGroupChatCreated: Boolean;
    function GetHasMediaSpoiler: Boolean;
    function GetHasProtectedContent: Boolean;
    function GetInvoice: TtgInvoice;
    function GetIsAutomaticForward: Boolean;
    function GetIsTopicMessage: Boolean;
    function GetLeftChatMember: TTgUser;
    function GetLocation: TtgLocation;
    function GetMediaGroupId: string;
    function GetMessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged;
    function GetMessageId: Int64;
    function GetMessageThreadId: Int64;
    function GetMigrateFromChatId: Int64;
    function GetMigrateToChatId: Int64;
    function GetNewChatMembers: TArray<TTgUser>;
    function GetNewChatPhoto: TArray<TtgPhotoSize>;
    function GetNewChatTitle: string;
    function GetPassportData: TtgPassportData;
    function GetPhoto: TArray<TtgPhotoSize>;
    function GetPinnedMessage: TtgMessage;
    function GetPoll: TtgPoll;
    function GetProximityAlertTriggered: TtgProximityAlertTriggered;
    function GetReplyMarkup: TtgInlineKeyboardMarkup;
    function GetReplyToMessage: TtgMessage;
    function GetSenderChat: TtgChat;
    function GetSticker: TtgSticker;
    function GetSuccessfulPayment: TtgSuccessfulPayment;
    function GetSupergroupChatCreated: Boolean;
    function GetText: string;
    function GetUserShared: TtgUserShared;
    function GetVenue: TtgVenue;
    function GetViaBot: TTgUser;
    function GetVideo: TtgVideo;
    function GetVideoChatEnded: TtgVideoChatEnded;
    function GetVideoChatParticipantsInvited: TtgVideoChatParticipantsInvited;
    function GetVideoChatScheduled: TtgVideoChatScheduled;
    function GetVideoChatStarted: TtgVideoChatStarted;
    function GetVideoNote: TtgVideoNote;
    function GetVoice: TtgVoice;
    function GetWebAppData: TtgWebAppData;
    function GetWriteAccessAllowed: TtgWriteAccessAllowed;
  public
    constructor Create;
    destructor Destroy; override;

    property MessageId: Int64 read GetMessageId;
    property MessageThreadId: Int64 read GetMessageThreadId;
    property From: TTgUser read GetFrom;
    property SenderChat: TtgChat read GetSenderChat;
    property Date: Integer read GetDate;
    property Chat: TtgChat read GetChat;
    property ForwardFrom: TTgUser read GetForwardFrom;
    property ForwardFromChat: TtgChat read GetForwardFromChat;
    property ForwardFromMessageId: Int64 read GetForwardFromMessageId;
    property ForwardSignature: string read GetForwardSignature;
    property ForwardSenderName: string read GetForwardSenderName;
    property ForwardDate: Integer read GetForwardDate;
    property IsTopicMessage: Boolean read GetIsTopicMessage;
    property IsAutomaticForward: Boolean read GetIsAutomaticForward;
    property ReplyToMessage: TtgMessage read GetReplyToMessage;
    property ViaBot: TTgUser read GetViaBot;
    property EditDate: Integer read GetEditDate;
    property HasProtectedContent: Boolean read GetHasProtectedContent;
    property MediaGroupId: string read GetMediaGroupId;
    property AuthorSignature: string read GetAuthorSignature;
    property Text: string read GetText;
    property Entities: TArray<TtgMessageEntity> read GetEntities;
    property Animation: TtgAnimation read GetAnimation;
    property Audio: TtgAudio read GetAudio;
    property Document: TtgDocument read GetDocument;
    property Photo: TArray<TtgPhotoSize> read GetPhoto;
    property Sticker: TtgSticker read GetSticker;
    property Video: TtgVideo read GetVideo;
    property VideoNote: TtgVideoNote read GetVideoNote;
    property Voice: TtgVoice read GetVoice;
    property Caption: string read GetCaption;
    property CaptionEntities: TArray<TtgMessageEntity> read GetCaptionEntities;
    property HasMediaSpoiler: Boolean read GetHasMediaSpoiler;
    property Contact: TtgContact read GetContact;
    property Dice: TtgDice read GetDice;
    property Game: TtgGame read GetGame;
    property Poll: TtgPoll read GetPoll;
    property Venue: TtgVenue read GetVenue;
    property Location: TtgLocation read GetLocation;
    property NewChatMembers: TArray<TTgUser> read GetNewChatMembers;
    property LeftChatMember: TTgUser read GetLeftChatMember;
    property NewChatTitle: string read GetNewChatTitle;
    property NewChatPhoto: TArray<TtgPhotoSize> read GetNewChatPhoto;
    property DeleteChatPhoto: Boolean read GetDeleteChatPhoto;
    property GroupChatCreated: Boolean read GetGroupChatCreated;
    property SupergroupChatCreated: Boolean read GetSupergroupChatCreated;
    property ChannelChatCreated: Boolean read GetChannelChatCreated;
    property MessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged read GetMessageAutoDeleteTimerChanged;
    property MigrateToChatId: Int64 read GetMigrateToChatId;
    property MigrateFromChatId: Int64 read GetMigrateFromChatId;
    property PinnedMessage: TtgMessage read GetPinnedMessage;
    property Invoice: TtgInvoice read GetInvoice;
    property SuccessfulPayment: TtgSuccessfulPayment read GetSuccessfulPayment;
    property UserShared: TtgUserShared read GetUserShared;
    property ChatShared: TtgChatShared read GetChatShared;
    property ConnectedWebsite: string read GetConnectedWebsite;
    property WriteAccessAllowed: TtgWriteAccessAllowed read GetWriteAccessAllowed;
    property PassportData: TtgPassportData read GetPassportData;
    property ProximityAlertTriggered: TtgProximityAlertTriggered read GetProximityAlertTriggered;
    property ForumTopicCreated: TtgForumTopicCreated read GetForumTopicCreated;
    property ForumTopicEdited: TtgForumTopicEdited read GetForumTopicEdited;
    property ForumTopicClosed: TtgForumTopicClosed read GetForumTopicClosed;
    property ForumTopicReopened: TtgForumTopicReopened read GetForumTopicReopened;
    property GeneralForumTopicHidden: TtgGeneralForumTopicHidden read GetGeneralForumTopicHidden;
    property GeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden read GetGeneralForumTopicUnhidden;
    property VideoChatScheduled: TtgVideoChatScheduled read GetVideoChatScheduled;
    property VideoChatStarted: TtgVideoChatStarted read GetVideoChatStarted;
    property VideoChatEnded: TtgVideoChatEnded read GetVideoChatEnded;
    property VideoChatParticipantsInvited: TtgVideoChatParticipantsInvited read GetVideoChatParticipantsInvited;
    property WebAppData: TtgWebAppData read GetWebAppData;
    property ReplyMarkup: TtgInlineKeyboardMarkup read GetReplyMarkup;
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
    [JsonName('chat_join_request')]
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
    function GetType: TtgUpdateType;
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

uses
  System.SysUtils;

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

constructor TtgUpdate.Create;
begin
  inherited Create;
  FMessage := nil;
  FEditedMessage := nil;
  FChannelPost := nil;
  FEditedChannelPost := nil;
  FInlineQuery := nil;
  FChosenInlineResult := nil;
  FCallbackQuery := nil;
  FShippingQuery := nil;
  FPreCheckoutQuery := nil;
  FPoll := nil;
  FPollAnswer := nil;
  FMyChatMember := nil;
  FChatMember := nil;
  FChatJoinRequest := nil;
end;

destructor TtgUpdate.Destroy;
begin
  if Assigned(FChatJoinRequest) then
    FreeAndNil(FChatJoinRequest);
  if Assigned(FChatMember) then
    FreeAndNil(FChatMember);
  if Assigned(FMyChatMember) then
    FreeAndNil(FMyChatMember);
  if Assigned(FPollAnswer) then
    FreeAndNil(FPollAnswer);
  if Assigned(FPoll) then
    FreeAndNil(FPoll);
  if Assigned(FPreCheckoutQuery) then
    FreeAndNil(FPreCheckoutQuery);
  if Assigned(FShippingQuery) then
    FreeAndNil(FShippingQuery);
  if Assigned(FCallbackQuery) then
    FreeAndNil(FCallbackQuery);
  if Assigned(FChosenInlineResult) then
    FreeAndNil(FChosenInlineResult);
  if Assigned(FInlineQuery) then
    FreeAndNil(FInlineQuery);
  if Assigned(FEditedChannelPost) then
    FreeAndNil(FEditedChannelPost);
  if Assigned(FChannelPost) then
    FreeAndNil(FChannelPost);
  if Assigned(FEditedMessage) then
    FreeAndNil(FEditedMessage);
  if Assigned(FMessage) then
    FreeAndNil(FMessage);
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

function TtgUpdate.GetType: TtgUpdateType;
begin
  if CallbackQuery <> nil then
    Result := TtgUpdateType.CallbackQueryUpdate
  else if ChannelPost <> nil then
    Result := TtgUpdateType.ChannelPost
  else if ChosenInlineResult <> nil then
    Result := TtgUpdateType.ChosenInlineResultUpdate
  else if EditedChannelPost <> nil then
    Result := TtgUpdateType.EditedChannelPost
  else if EditedMessage <> nil then
    Result := TtgUpdateType.EditedMessage
  else if InlineQuery <> nil then
    Result := TtgUpdateType.InlineQueryUpdate
  else if Message <> nil then
    Result := TtgUpdateType.MessageUpdate
  else if PreCheckoutQuery <> nil then
    Result := TtgUpdateType.PreCheckoutQueryUpdate
  else if ShippingQuery <> nil then
    Result := TtgUpdateType.ShippingQueryUpdate
  else
    Result := TtgUpdateType.UnknownUpdate;
end;

function TtgUpdate.GetUpdateId: Int64;
begin
  Result := FUpdateId;
end;

constructor TtgMessage.Create;
begin
  inherited Create;
  FFrom := TTgUser.Create();
  FSenderChat := TtgChat.Create();
  FChat := TtgChat.Create();
end;

destructor TtgMessage.Destroy;
begin
  for var LEntity in FEntities do
    LEntity.Free;
  FChat.Free;
  FSenderChat.Free;
  FFrom.Free;
  FReplyMarkup.Free;
  FContact.Free;
  FForwardFrom.Free;
  FForwardFromChat.Free;
  FReplyToMessage.Free;
  inherited Destroy;
end;

function TtgMessage.GetAnimation: TtgAnimation;
begin
  Result := FAnimation;
end;

function TtgMessage.GetAudio: TtgAudio;
begin
  Result := FAudio;
end;

function TtgMessage.GetAuthorSignature: string;
begin
  Result := FAuthorSignature;
end;

function TtgMessage.GetCaption: string;
begin
  Result := FCaption;
end;

function TtgMessage.GetCaptionEntities: TArray<TtgMessageEntity>;
begin
  Result := FCaptionEntities;
end;

function TtgMessage.GetChannelChatCreated: Boolean;
begin
  Result := FChannelChatCreated;
end;

function TtgMessage.GetChat: TtgChat;
begin
  Result := FChat;
end;

function TtgMessage.GetChatShared: TtgChatShared;
begin
  Result := FChatShared;
end;

function TtgMessage.GetConnectedWebsite: string;
begin
  Result := FConnectedWebsite;
end;

function TtgMessage.GetContact: TtgContact;
begin
  Result := FContact;
end;

function TtgMessage.GetDate: Integer;
begin
  Result := FDate;
end;

function TtgMessage.GetDeleteChatPhoto: Boolean;
begin
  Result := FDeleteChatPhoto;
end;

function TtgMessage.GetDice: TtgDice;
begin
  Result := FDice;
end;

function TtgMessage.GetDocument: TtgDocument;
begin
  Result := FDocument;
end;

function TtgMessage.GetEditDate: Integer;
begin
  Result := FEditDate;
end;

function TtgMessage.GetEntities: TArray<TtgMessageEntity>;
begin
  Result := FEntities;
end;

function TtgMessage.GetForumTopicClosed: TtgForumTopicClosed;
begin
  Result := FForumTopicClosed;
end;

function TtgMessage.GetForumTopicCreated: TtgForumTopicCreated;
begin
  Result := FForumTopicCreated;
end;

function TtgMessage.GetForumTopicEdited: TtgForumTopicEdited;
begin
  Result := FForumTopicEdited;
end;

function TtgMessage.GetForumTopicReopened: TtgForumTopicReopened;
begin
  Result := FForumTopicReopened;
end;

function TtgMessage.GetForwardDate: Integer;
begin
  Result := FForwardDate;
end;

function TtgMessage.GetForwardFrom: TTgUser;
begin
  Result := FForwardFrom;
end;

function TtgMessage.GetForwardFromChat: TtgChat;
begin
  Result := FForwardFromChat;
end;

function TtgMessage.GetForwardFromMessageId: Int64;
begin
  Result := FForwardFromMessageId;
end;

function TtgMessage.GetForwardSenderName: string;
begin
  Result := FForwardSenderName;
end;

function TtgMessage.GetForwardSignature: string;
begin
  Result := FForwardSignature;
end;

function TtgMessage.GetFrom: TTgUser;
begin
  Result := FFrom;
end;

function TtgMessage.GetGame: TtgGame;
begin
  Result := FGame;
end;

function TtgMessage.GetGeneralForumTopicHidden: TtgGeneralForumTopicHidden;
begin
  Result := FGeneralForumTopicHidden;
end;

function TtgMessage.GetGeneralForumTopicUnhidden: TtgGeneralForumTopicUnhidden;
begin
  Result := FGeneralForumTopicUnhidden;
end;

function TtgMessage.GetGroupChatCreated: Boolean;
begin
  Result := FGroupChatCreated;
end;

function TtgMessage.GetHasMediaSpoiler: Boolean;
begin
  Result := FHasMediaSpoiler;
end;

function TtgMessage.GetHasProtectedContent: Boolean;
begin
  Result := FHasProtectedContent;
end;

function TtgMessage.GetInvoice: TtgInvoice;
begin
  Result := FInvoice;
end;

function TtgMessage.GetIsAutomaticForward: Boolean;
begin
  Result := FIsAutomaticForward;
end;

function TtgMessage.GetIsTopicMessage: Boolean;
begin
  Result := FIsTopicMessage;
end;

function TtgMessage.GetLeftChatMember: TTgUser;
begin
  Result := FLeftChatMember;
end;

function TtgMessage.GetLocation: TtgLocation;
begin
  Result := FLocation;
end;

function TtgMessage.GetMediaGroupId: string;
begin
  Result := FMediaGroupId;
end;

function TtgMessage.GetMessageAutoDeleteTimerChanged: TtgMessageAutoDeleteTimerChanged;
begin
  Result := FMessageAutoDeleteTimerChanged;
end;

function TtgMessage.GetMessageId: Int64;
begin
  Result := FMessageId;
end;

function TtgMessage.GetMessageThreadId: Int64;
begin
  Result := FMessageThreadId;
end;

function TtgMessage.GetMigrateFromChatId: Int64;
begin
  Result := FMigrateFromChatId;
end;

function TtgMessage.GetMigrateToChatId: Int64;
begin
  Result := FMigrateToChatId;
end;

function TtgMessage.GetNewChatMembers: TArray<TTgUser>;
begin
  Result := FNewChatMembers;
end;

function TtgMessage.GetNewChatPhoto: TArray<TtgPhotoSize>;
begin
  Result := FNewChatPhoto;
end;

function TtgMessage.GetNewChatTitle: string;
begin
  Result := FNewChatTitle;
end;

function TtgMessage.GetPassportData: TtgPassportData;
begin
  Result := FPassportData;
end;

function TtgMessage.GetPhoto: TArray<TtgPhotoSize>;
begin
  Result := FPhoto;
end;

function TtgMessage.GetPinnedMessage: TtgMessage;
begin
  Result := FPinnedMessage;
end;

function TtgMessage.GetPoll: TtgPoll;
begin
  Result := FPoll;
end;

function TtgMessage.GetProximityAlertTriggered: TtgProximityAlertTriggered;
begin
  Result := FProximityAlertTriggered;
end;

function TtgMessage.GetReplyMarkup: TtgInlineKeyboardMarkup;
begin
  Result := FReplyMarkup;
end;

function TtgMessage.GetReplyToMessage: TtgMessage;
begin
  Result := FReplyToMessage;
end;

function TtgMessage.GetSenderChat: TtgChat;
begin
  Result := FSenderChat;
end;

function TtgMessage.GetSticker: TtgSticker;
begin
  Result := FSticker;
end;

function TtgMessage.GetSuccessfulPayment: TtgSuccessfulPayment;
begin
  Result := FSuccessfulPayment;
end;

function TtgMessage.GetSupergroupChatCreated: Boolean;
begin
  Result := FSupergroupChatCreated;
end;

function TtgMessage.GetText: string;
begin
  Result := FText;
end;

function TtgMessage.GetUserShared: TtgUserShared;
begin
  Result := FUserShared;
end;

function TtgMessage.GetVenue: TtgVenue;
begin
  Result := FVenue;
end;

function TtgMessage.GetViaBot: TTgUser;
begin
  Result := FViaBot;
end;

function TtgMessage.GetVideo: TtgVideo;
begin
  Result := FVideo;
end;

function TtgMessage.GetVideoChatEnded: TtgVideoChatEnded;
begin
  Result := FVideoChatEnded;
end;

function TtgMessage.GetVideoChatParticipantsInvited: TtgVideoChatParticipantsInvited;
begin
  Result := FVideoChatParticipantsInvited;
end;

function TtgMessage.GetVideoChatScheduled: TtgVideoChatScheduled;
begin
  Result := FVideoChatScheduled;
end;

function TtgMessage.GetVideoChatStarted: TtgVideoChatStarted;
begin
  Result := FVideoChatStarted;
end;

function TtgMessage.GetVideoNote: TtgVideoNote;
begin
  Result := FVideoNote;
end;

function TtgMessage.GetVoice: TtgVoice;
begin
  Result := FVoice;
end;

function TtgMessage.GetWebAppData: TtgWebAppData;
begin
  Result := FWebAppData;
end;

function TtgMessage.GetWriteAccessAllowed: TtgWriteAccessAllowed;
begin
  Result := FWriteAccessAllowed;
end;

end.
