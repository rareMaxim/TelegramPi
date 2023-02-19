unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, TelegaPi.Client,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  TelegaPi.Types;

type
  TForm5 = class(TForm)
    TelegaPi1: TTelegaPi;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure TelegaPi1Message(ASender: TObject; AMessage: TtgMessage);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.FormCreate(Sender: TObject);
begin
  TelegaPi1.Start;
end;

procedure TForm5.TelegaPi1Message(ASender: TObject; AMessage: TtgMessage);
begin
  Memo1.Lines.Add(AMessage.Text);
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
