unit Unit5;

interface

uses
  TelegaPi.Keyboard,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, TelegaPi.Client,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  TelegaPi.Types;

type
  TForm5 = class(TForm)

    Memo1: TMemo;
    TelegaPi1: TTelegaPi;
    procedure FormCreate(Sender: TObject);
    procedure TelegaPi1Message(ASender: TObject; AMessage: TtgMessage);
  private
    { Private declarations }
  public
    { Public declarations }
    function kb(at: string): string;

  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.FormCreate(Sender: TObject);
begin
  TelegaPi1.Start;

  // kb.Free;
end;

function TForm5.kb(at: string): string;
var
  x: TArray<string>;
begin

  x := ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  Result := TtgKeyboard.ReplyKb([x]).ResizeKeyboard(True) //
  { .Wrap(
    function(ARow, AIndex: Integer; ABtn: TtgKeyboardButton): Boolean
    begin
    Result := True;
    end) }.ToJson;
end;

procedure TForm5.TelegaPi1Message(ASender: TObject; AMessage: TtgMessage);
begin
  Memo1.Lines.Add(AMessage.Text);

  TelegaPi1.SendMessage //
    .SetChatId(AMessage.From.Id) //
    .SetText('test') //
    .ReplyMarkup(kb(AMessage.Text)) //
    .Excecute(nil);
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
