unit TelegaPi.Methods;

interface

uses
  TelegaPi.Types, System.SysUtils, Citrus.Mandarin;

type
  ITgMethod<T> = interface
    ['{5DDC21DC-FBF1-410D-9169-CC17A3903983}']
  end;

  ITgGetMeMethod = interface(ITgMethod<ItgUser>)
    ['{EE3B55AC-9138-4564-86E9-AE4F9FA04A24}']
    procedure Excecute(AResponse: TProc<ItgUser, IHttpResponse>);
  end;

  ITgGetUpdatesMethod = interface
    ['{1DE30710-09ED-4F56-9752-0E9D1D36FBD8}']
    function SetOffset(const AOffset: Integer): ITgGetUpdatesMethod;
    function SetLimit(const ALimit: Integer): ITgGetUpdatesMethod;
    function SetTimeout(const ATimeout: Integer): ITgGetUpdatesMethod;
    procedure Excecute(AResponse: TProc<TArray<ItgUpdate>, IHttpResponse>);
  end;

implementation

end.
