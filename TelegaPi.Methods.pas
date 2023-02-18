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

  ITgGetUpdatesMethod = interface
    ['{1DE30710-09ED-4F56-9752-0E9D1D36FBD8}']
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

  ItgSendMessageMethod = interface
    ['{757408C1-EA70-4B8C-A5DA-24A3242C48B4}']
    function SetChatId(const AChatId: Int64): ItgSendMessageMethod; overload;
    function SetChatId(const AChatId: string): ItgSendMessageMethod; overload;
    function SetMessageThreadId(const AMessageThreadId: Int64): ItgSendMessageMethod;
    function SetText(const AText: string): ItgSendMessageMethod;
    procedure Excecute(AResponse: TProc<ItgMessage, IHttpResponse>);
  end;

implementation

end.
