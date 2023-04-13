unit TelegaPi.Methods;

interface

uses
  TelegaPi.Types, System.SysUtils, Citrus.Mandarin;

type
  ITgGetMeMethod = interface
    ['{EE3B55AC-9138-4564-86E9-AE4F9FA04A24}']
    procedure Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
  end;

  ITgLogOutMethod = interface
    ['{DC9FAB1C-F2B2-4DCF-B92A-809AB3DECED2}']
    procedure Excecute(AResponse: TProc<Boolean, IHttpResponse>);
  end;

  ITgCloseMethod = interface
    ['{BDB1E3E8-D8D7-48E6-AD89-E41EE83EB5DA}']
    procedure Excecute(AResponse: TProc<Boolean, IHttpResponse>);
  end;

  ITgGetUpdatesMethod = interface
    ['{1DE30710-09ED-4F56-9752-0E9D1D36FBD8}']
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    function SetAllowedUpdates(AAllowedUpdates: TAllowedUpdates): ITgGetUpdatesMethod;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

  ItgSendMessageMethod = interface
    ['{757408C1-EA70-4B8C-A5DA-24A3242C48B4}']
    function SetChatId(const AChatId: Int64): ItgSendMessageMethod; overload;
    function SetChatId(const AChatId: string): ItgSendMessageMethod; overload;
    function SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
    function SetText(const AText: string): ItgSendMessageMethod;
    function SetParseMode(const AParseMode: string): ItgSendMessageMethod;
    function SetEntities(const AEntities: TArray<TtgMessageEntity>): ItgSendMessageMethod;
    function SetDisableWebPagePreview(const ADisableWebPagePreview: Boolean): ItgSendMessageMethod;
    function SetDisableNotification(const ADisableNotification: Boolean): ItgSendMessageMethod;
    function SetProtectContent(const AProtectContent: Boolean): ItgSendMessageMethod;
    function SetReplyToMessageId(const AMessageId: Int64): ItgSendMessageMethod;
    function SetAllowSendingWithoutReply(const AAllowSendingWithoutReply: Boolean): ItgSendMessageMethod;
    function ReplyMarkup(const AKeyboard: string): ItgSendMessageMethod;
    procedure Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
  end;

  ItgForwardMessageMethod = interface
    ['{2E2CBC33-3560-4C29-8D69-D598CDE626DB}']
    function SetChatId(const AChatId: Int64): ItgForwardMessageMethod; overload;
    function SetChatId(const AChatId: string): ItgForwardMessageMethod; overload;
    function SetMessageThreadId(const AMessageThreadId: Int64): ItgForwardMessageMethod;
    function SetFromChatId(const AChatId: Int64): ItgForwardMessageMethod; overload;
    function SetFromChatId(const AChatId: string): ItgForwardMessageMethod; overload;
    function SetDisableNotification(const ADisableNotification: Boolean): ItgForwardMessageMethod;
    function SetProtectContent(const AProtectContent: Boolean): ItgForwardMessageMethod;
    function SetMessageId(const AMessageId: Int64): ItgForwardMessageMethod; overload;
    //
    procedure Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
  end;

implementation

end.
