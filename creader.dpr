program creader;

uses
  Forms,
  reader_un in 'reader_un.pas' {Form1},
  readerlib in 'readerlib.pas',
  unilib in 'unilib.pas',
  formGetParam in 'ico\formGetParam.pas' {OKBottomDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'cReader';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.Run;
end.
