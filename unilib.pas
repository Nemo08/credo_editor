unit unilib;

interface
function  Win2Dos(St :String) :String;
function  Dos2Win(St :String) :String;
function GetFolderDialog(Handle: Integer; Caption: string; var strFolder:
  string): Boolean;

implementation
uses   Windows,SysUtils,shlobj;

function  Win2Dos(St :String) :String;
     const
         Win_2_DOS: Array[$80..$FF] of Byte = (
$3f,$3f,$27,$3f,$22,$3a,$c5,$d8,$3f,$25,$3f,$3c,$3f,$3f,$3f,$3f,
$3f,$27,$27,$22,$22,$07,$2d,$2d,$3f,$54,$3f,$3e,$3f,$3f,$3f,$3f,
$ff,$f6,$f7,$3f,$fd,$3f,$b3,$15,$f0,$63,$f2,$3c,$bf,$2d,$52,$f4,
$f8,$2b,$49,$69,$3f,$e7,$14,$fa,$f1,$fc,$f3,$3e,$3f,$3f,$3f,$f5,
$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$8f,
$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9a,$9b,$9c,$9d,$9e,$9f,
$a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$a8,$a9,$aa,$ab,$ac,$ad,$ae,$af,
$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef);
  var
    I : Integer;
begin
     for i:=1 to Length(St) do
         begin
              if byte(St[i]) > $7F then
                 St[i] := char(WIN_2_DOS[byte(St[i])]);
         end;
     Result:=St;
end;

function  Dos2Win(St :String) :String;
     const
     Dos_2_WIN: Array[$80..$FF] of Byte = (
//     0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
 $c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$cf,
 $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd,$de,$df,
 $e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef,
 $86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,
 $86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,
 $86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,
 $f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff,
 $a8,$b8,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86,$86);
  var
    I : Integer;
begin
     for i:=1 to Length(St) do
         begin
              if byte(St[i]) > $7F then
                 St[i] := char(Dos_2_Win[byte(St[i])]);
         end;
     Result:=St;
end;

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData:
  LPARAM): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  BrowseCallbackProc := 0;
end;

function GetFolderDialog(Handle: Integer; Caption: string; var strFolder:
  string): Boolean;
const
  BIF_STATUSTEXT = $0004;
  BIF_NEWDIALOGSTYLE = $0040;
  BIF_RETURNONLYFSDIRS = $0080;
  BIF_SHAREABLE = $0100;
  BIF_USENEWUI = BIF_EDITBOX or BIF_NEWDIALOGSTYLE;

var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  JtemIDList: PItemIDList;
  Path: PAnsiChar;
begin
  Result := False;
  Path := StrAlloc(MAX_PATH);
  SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, JtemIDList);
  with BrowseInfo do
  begin
    hwndOwner := GetActiveWindow;
    pidlRoot := JtemIDList;
    SHGetSpecialFolderLocation(hwndOwner, CSIDL_DRIVES, JtemIDList);

    { return display name of item selected }
    pszDisplayName := StrAlloc(MAX_PATH);

    { set the title of dialog }
    lpszTitle := PChar(Caption); //'Select the folder';
    { flags that control the return stuff }
    ulFlags := {ulFlags or} BIF_NEWDIALOGSTYLE or BIF_RETURNONLYFSDIRS;
 //ulFlags := ulFlags or BIF_RETURNONLYFSDIRS;
    lpfn := @BrowseCallbackProc;
    { extra info that's passed back in callbacks }
    lParam := LongInt(PChar(strFolder));
  end;

  ItemIDList := SHBrowseForFolder(BrowseInfo);

  if (ItemIDList <> nil) then
    if SHGetPathFromIDList(ItemIDList, Path) then
    begin
      strFolder := Path;
      Result := True
    end;
end;
end.
 