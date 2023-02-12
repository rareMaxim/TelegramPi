unit IntegrationTests;

interface

uses
  TelegaPi.Client,
  DUnitX.TestFramework;

type

  [TestFixture]
  TMyTestObject = class
  strict private
    FBot: TTelegaPi;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure getUpdate;
    [Test]
    procedure getMe;

    // Test with TestCase Attribute to supply parameters.
    [Test]
    [TestCase('TestA', '1,2')]
    [TestCase('TestB', '3,4')]
    procedure Test2(const AValue1: Integer; const AValue2: Integer);
  end;

implementation

uses
  System.SysUtils,
  Citrus.Mandarin,
  TelegaPi.Types;

procedure TMyTestObject.getUpdate;
begin
  FBot.GetUpdates//
  // .SetOffset(0)//
    .Excecute(
    procedure(AUpdates: TArray<ItgUpdate>; AHttp: IHTTPResponse)
    begin
      for var LUpdate in AUpdates do
        System.Write(LUpdate.UpdateId.tostring + ' ');
    end);
end;

procedure TMyTestObject.Setup;
begin
  FBot := TTelegaPi.Create(nil);
  FBot.Token := '494720781:AAHCESGawcyIaJRPjzZJBytVUa7XlPA2Q0c';
end;

procedure TMyTestObject.TearDown;
begin
  FBot.Free;
  FBot := nil;
end;

procedure TMyTestObject.getMe;
begin
  FBot.getMe.Excecute(
    procedure(AUser: ITgUser; AHttp: IHTTPResponse)
    begin
      Assert.AreEqual(200, AHttp.StatusCode);
      Assert.IsNotEmpty(AUser.FirstName);
      Assert.IsNotEmpty(AUser.Username);
      Assert.AreEqual(AUser.IsBot, True);
    end);
end;

procedure TMyTestObject.Test2(const AValue1: Integer; const AValue2: Integer);
begin
end;

initialization

ReportMemoryLeaksOnShutdown := True;
TDUnitX.RegisterTestFixture(TMyTestObject);

finalization

IsConsole := False;

end.
