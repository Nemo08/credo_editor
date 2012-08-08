unit formGetParam;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls,Messages;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    function init(str:string):variant;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

{$R *.dfm}
    function TOKBottomDlg.init(str:string):variant;
      begin
        label1.Caption:=str;
        OkBottomDlg.ShowModal;
        {OKBottomDlg.Show;}
        init:=Edit1.Text;
        Edit1.Text:='';
      end;

procedure TOKBottomDlg.OKBtnClick(Sender: TObject);
begin
  OkBottomDlg.Close;
end;


end.
