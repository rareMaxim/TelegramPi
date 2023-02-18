unit TelegaPi.Client;

interface

uses
  Citrus.Mandarin,
  System.Classes,
  System.SysUtils,
  TelegaPi.Types,
  TelegaPi.Methods;

type

  TTelegaPi = class(TComponent)
  private
    FMandarin: TMandarinClientJson;
    FIsAsyncMode: Boolean;
    FToken: string;
    FServer: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetMe: ITgGetMeMethod;
    function LogOut: ITgLogOutMethod;
    function GetUpdates: ITgGetUpdatesMethod;
    function SendMessage: ItgSendMessageMethod;
  published
    property IsAsyncMode: Boolean read FIsAsyncMode write FIsAsyncMode;
    property Token: string read FToken write FToken;
    property Server: string read FServer write FServer;
  end;

implementation

uses
  TelegaPi.Core.Methods;

constructor TTelegaPi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsAsyncMode := not IsConsole;
  FMandarin := TMandarinClientJson.Create();
  FMandarin.OnBeforeExcecute := procedure(AMandarin: IMandarin)
    begin
      AMandarin.AddUrlSegment('server', FServer); // do not localize
      AMandarin.AddUrlSegment('token', FToken); // do not localize
      ;
    end;
  FServer := 'https://api.telegram.org';
end;

destructor TTelegaPi.Destroy;
begin
  FMandarin.Free;
  inherited Destroy;
end;

function TTelegaPi.GetMe: ITgGetMeMethod;
begin
  Result := TtgGetMeMethod.Create(FMandarin, 'getMe');
end;

function TTelegaPi.GetUpdates: ITgGetUpdatesMethod;
begin
  Result := TtgGetUpdatesMethod.Create(FMandarin, 'getUpdates');
end;

function TTelegaPi.LogOut: ITgLogOutMethod;
begin
  Result := TtgLogOutMethod.Create(FMandarin, 'logOut');
end;

function TTelegaPi.SendMessage: ItgSendMessageMethod;
begin
  Result := TtgSendMessageMethod.Create(FMandarin, 'sendMessage');
end;

end.
