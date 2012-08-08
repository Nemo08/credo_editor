unit reader_un;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,readerlib, ToolWin, ComCtrls, StdCtrls, Buttons, Menus, ExtCtrls,
  Grids, ImgList, unilib,FormGetParam;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    StringGrid1: TStringGrid;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    ImageList1: TImageList;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    ToolBar1: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Tabs: TTabControl;
    N16: TMenuItem;
    N17: TMenuItem;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    Edit7: TEdit;
    StringGrid2: TStringGrid;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Edit5: TEdit;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    TabSheet4: TTabSheet;
    N18: TMenuItem;
    ToolButton5: TToolButton;
    N19: TMenuItem;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel1: TPanel;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    panel2: TPanel;
    N20: TMenuItem;
    N21: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure TabsChange(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure TabsDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure N16Click(Sender: TObject);
    procedure DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure drawpoints;
    procedure StringGrid1Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TCredoChild = class(TCredoObj)
  procedure onChanged;override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  maxobj=2;
var
  Form1: TForm1;
  //prg:array[0..2] of TCredoChild;
implementation

{$R *.dfm}
procedure TForm1.drawpoints;
  var j,num:integer;
      tempop:string;
      tempstr:string;
      TCrobj:TCredoChild;
begin
  if  inttostr(Stringgrid1.Selection.top)
    =inttostr(Stringgrid1.Selection.bottom) then
      begin
        tCrobj:=TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]);
        num:=(Stringgrid1.Selection.top);
{        showmessage(inttostr(Stringgrid1.Selection.top));}
        num:=num-1;
        str(tcrobj.popsuper[num].RepHeight:4:2,tempstr);
        Edit6.Text:=tempstr;
        str(tcrobj.popsuper[num].poper[1].xz0:4:2,tempstr);
        Edit7.Text:=tempstr;
        case tcrobj.popsuper[num].datatype of
          1:begin
            PageControl2.TabIndex:=0;
            Edit5.Text:=inttostr(tcrobj.popsuper[num].otsc);
          end;
          2:begin
            PageControl2.TabIndex:=1;
            ComboBox1.ItemIndex:=tcrobj.popsuper[num].teotype-1;
            case tcrobj.popsuper[num].naprkrug of
              1:Edit2.Text:='право';
              2:Edit2.Text:='лево';
            end;
            Edit3.Text:=inttostr(tcrobj.popsuper[num].teograd)+'.'+
                        inttostr(tcrobj.popsuper[num].teomin)+'.'+
                        inttostr(tcrobj.popsuper[num].teosec)+'"';
            str(tcrobj.popsuper[num].teoheight:4:2,tempstr);
            Edit4.Text:=tempstr;
          end;
          3:begin
            PageControl2.TabIndex:=2;
          end;
        end;

        for j:=1 to 60 do
          begin
              tempop:=tcrobj.popsuper[num].poper[j].textop;
              if (tcrobj.popsuper[num].poper[j].pointcode=99)and
                 (tcrobj.popsuper[num].poper[j].len=0)and
                 (tcrobj.popsuper[num].poper[j].vugrad=0)and
                 (tcrobj.popsuper[num].poper[j].vumin=0)and
                 (tcrobj.popsuper[num].poper[j].vusec=0)and
                 (tcrobj.popsuper[num].poper[j].vkgrad=0)and
                 (tcrobj.popsuper[num].poper[j].vkmin=0)and
                 (tcrobj.popsuper[num].poper[j].vksec=0)and
                 (tcrobj.popsuper[num].poper[j].len=0)then
               else
               begin
                 Form1.StringGrid2.RowCount:=j+1;
                 Form1.StringGrid2.Cells[8,j]:=(tcrobj.popsuper[num].poper[j].textop);
                 //Form1.StringGrid2.Cells[0,j]:=inttostr(j);
                 Form1.StringGrid2.Cells[0,j]:=inttostr(tcrobj.popsuper[num].poper[j].pointcode);
                 str(tcrobj.popsuper[num].poper[j].height:4:2,tempstr);
                 Form1.StringGrid2.Cells[6,j]:=tempstr;
                 str(tcrobj.popsuper[num].poper[j].len:4:2,tempstr);
                 Form1.StringGrid2.Cells[5,j]:=tempstr;
                 if tcrobj.popsuper[num].datatype=1 then
                  begin
                    str(tcrobj.popsuper[num].poper[j].xz0:4:2,tempstr);
                    Form1.StringGrid2.Cells[1,j]:=tempstr;
                  end
                 else
                  begin
                    str(tcrobj.popsuper[num].poper[j].OsLen:4:2,tempstr);
                    Form1.StringGrid2.Cells[1,j]:=tempstr;
                  end;
                 str(tcrobj.popsuper[num].poper[j].otscrei,tempstr);
                 Form1.StringGrid2.Cells[3,j]:=tempstr;
                 {отсчет по ВК}
                 str(tcrobj.popsuper[num].poper[j].vkgrad,tempstr);
                 Form1.StringGrid2.Cells[4,j]:=tempstr+'°';
                 str(tcrobj.popsuper[num].poper[j].vkMIN,tempstr);
                 Form1.StringGrid2.Cells[4,j]:=Form1.StringGrid2.Cells[4,j]+tempstr+CHR(39);
                 str(tcrobj.popsuper[num].poper[j].vksec,tempstr);
                 Form1.StringGrid2.Cells[4,j]:=Form1.StringGrid2.Cells[4,j]+tempstr+'"';
                 {Вертикальный угол}
                 str(tcrobj.popsuper[num].poper[j].vugrad,tempstr);
                 Form1.StringGrid2.Cells[7,j]:=tempstr+'°';
                 str(tcrobj.popsuper[num].poper[j].vuMIN,tempstr);
                 Form1.StringGrid2.Cells[7,j]:=Form1.StringGrid2.Cells[7,j]+tempstr+CHR(39);
                 str(tcrobj.popsuper[num].poper[j].vusec,tempstr);
                 Form1.StringGrid2.Cells[7,j]:=Form1.StringGrid2.Cells[7,j]+tempstr+'"';
               end;
          end;
      end;
end;

procedure TcredoChild.onChanged;
  var i,j:integer;
      numhilo:array[1..2] of smallint;
      numfull:integer absolute numhilo;
      tempstr:string;
      tcredoobj:TCredoChild;
 begin
   Form1.StringGrid1.CleanupInstance;
   tcredoobj:=TCredoChild(form1.tabs.Tabs.Objects[form1.tabs.TabIndex]);
   Form1.StringGrid1.RowCount:=tcredoobj.popkeycount+1;
   for i:=0 to tcredoobj.popkeycount-1 do
     begin

        tempstr:=pk2str(tcredoobj.popsuper[i].pk);
        Form1.StringGrid1.Cells[0,i+1]:=tempstr;
        // ищу отметку оси
        for j:=1 to 60 do
          begin
            if (tcredoobj.popsuper[i].poper[j].pointcode=1) then
                begin
                  str(tcredoobj.popsuper[i].poper[j].height:4:2,tempstr);
                  Form1.StringGrid1.Cells[1,i+1]:='О '+tempstr;
                  break;
                end;
            if (tcredoobj.popsuper[i].poper[j].pointcode=0) then
                begin
                  str(tcredoobj.popsuper[i].poper[j].height:4:2,tempstr);
                  Form1.StringGrid1.Cells[1,i+1]:='Р '+tempstr;
                  break;
                end;
          end;
     end;
     Form1.Drawpoints;
  end;

procedure buildui;
   begin
     //form1.StringGrid1.Cells[0,0]:='#';
     form1.StringGrid1.Cells[0,0]:='ПК';
     form1.StringGrid1.Cells[1,0]:='Отметка оси';
     //form1.StringGrid1.ColWidths[0]:=25;
     form1.StringGrid1.ColWidths[0]:=75;
     form1.StringGrid1.ColWidths[1]:=81;
     //*************************************
     //*************************************
     //form1.StringGrid2.Cells[0,0]:='#';
     form1.StringGrid2.Cells[0,0]:='код';
     form1.StringGrid2.Cells[1,0]:='Расст. от оси '+chr(13)
     +' прибора '+chr(13)+' до точки, м ';
     form1.StringGrid2.Cells[2,0]:='Дально-'+chr(13)+' мерное'
     +chr(13)+' расст., м';
     form1.StringGrid2.Cells[3,0]:='Отсчет '+chr(13)+' по рейке'
     +chr(13)+' мм';
     form1.StringGrid2.Cells[4,0]:='Отсчет '+chr(13)+' по ВК'
     +chr(13)+' гр.мин.с';
     form1.StringGrid2.Cells[5,0]:='Расстояние '+chr(13)+
     ' от проектн. '+chr(13)+' оси';
     form1.StringGrid2.Cells[6,0]:='Отметка';
     form1.StringGrid2.Cells[7,0]:='Верт.угол, '+chr(13)+' гр.мин.с';
     form1.StringGrid2.Cells[8,0]:='Наименование';
     //form1.StringGrid2.ColWidths[0]:=25;
     form1.StringGrid2.ColWidths[0]:=35;
     form1.StringGrid2.ColWidths[1]:=90;
     form1.StringGrid2.ColWidths[5]:=75;
     form1.StringGrid2.ColWidths[6]:=60;
     form1.StringGrid2.ColWidths[7]:=65;
     form1.StringGrid2.ColWidths[8]:=120;
     form1.StringGrid2.RowHeights[0]:=50;
   end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  buildui;
end;

 //////////////////////////////////////////////////////


procedure TForm1.N2Click(Sender: TObject);
var

s: string;

begin
  if tabs.Tabs.Count<=(maxobj-1) then
  if GetFolderDialog(handle, 'Выберите папку с объектом CredoLin', s) then
   begin
      tabs.Tabs.AddObject('Объект '+inttostr(tabs.TabIndex+2),TCredoChild.Create);
      tabs.TabIndex:=tabs.Tabs.Count-1;
      if tabs.Tabs.Count=0 then
        tabs.Visible:=false
      else tabs.Visible:=true;
//      tabs.Tabs.Count
      if TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).OpenObject(s) then
        begin
          StringGrid1.Enabled:=true;
          StringGrid1.Color:=clWindow;
        end
      else
        showmessage('Произошла ошибка. Возможно эта папка не содержит объекта CredoLin');
   end;
    //createtab;
end;

//продольное смещение поперечников
procedure TForm1.N7Click(Sender: TObject);
var v:variant;
    s:string;
    r:real;
begin
  V:=OkBottomDlg.init('Введите величину смещения в метрах');
  s:=v;
  try
        r:=strtofloat(s);
        TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveToProd(StringGrid1.Selection.Top,StringGrid1.Selection.Bottom,r);
  except
      MessageDlg('Введено неправильное значение', mtError, [mbOk], 0);
  end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  try
  TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).SaveObject;
   except
      MessageDlg('Ошибка 3', mtError, [mbOk], 0);
  end;
end;


procedure TForm1.N10Click(Sender: TObject);
begin
  TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveOsToNol(StringGrid1.Selection.Top,Stringgrid1.Selection.Bottom);
end;

procedure TForm1.N13Click(Sender: TObject);
begin
  try
   N7Click(Sender);
  except
      MessageDlg('Ошибка: нипонятная ошибка 2', mtError, [mbOk], 0);
  end;
end;

// поперечное смещение поперечников
procedure TForm1.N15Click(Sender: TObject);
begin
  try
    TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveOsToNol(StringGrid1.Selection.Top,Stringgrid1.Selection.Bottom);
  except
      MessageDlg('Ошибка: нипонятная ошибка 1', mtError, [mbOk], 0);
  end;    
end;

procedure TForm1.N14Click(Sender: TObject);
var v:variant;
    s:string;
    r:real;
begin
  V:=OkBottomDlg.init('Введите величину смещения в метрах');
  s:=v;
  try
        if pos('.',s)<>0 then s[pos('.',s)]:=',';
        r:=strtofloat(s);
        TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveToPop(StringGrid1.Selection.Top,StringGrid1.Selection.Bottom,r);
  except
      MessageDlg('Введено неправильное значение', mtError, [mbOk], 0);
  end;
end;


procedure TForm1.TabsChange(Sender: TObject);
begin
   TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).onChanged;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.TabsDrawTab(Control: TCustomTabControl; TabIndex: Integer;
  const Rect: TRect; Active: Boolean);
begin
    if tabs.Tabs.Count=0 then
    tabs.Visible:=false
    else tabs.Visible:=true;
end;

procedure TForm1.N16Click(Sender: TObject);
begin
  Tabs.Tabs.Delete(Tabs.TabIndex);
end;

//жирный шрифт и центрирование
procedure TForm1.DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  var l_oldalign : word;
    l_YPos,l_XPos : integer;
    s,s1 : string;
    l_col,l_row :longint;
  begin
    l_col := acol;
    l_row := arow;
    with sender as tstringgrid do
      begin
        
        if (l_row<>0) then
          begin
            canvas.Brush.Color:=clWindow;
{ось}      if (Cells[0,l_row]='0')or(Cells[0,l_row]='1') then canvas.Brush.Color:=rgb(253,208,220);
{кромки}    if (Cells[0,l_row]='2') then canvas.Brush.Color:=rgb(210,255,254);
            if (Cells[0,l_row]='3') then canvas.Brush.Color:=rgb(213,220,255);
{оголовок}  if (Cells[0,l_row]='6') then canvas.Brush.Color:=rgb(176,255,183);
{низ отк}   if (Cells[0,l_row]='7') then canvas.Brush.Color:=rgb(232,230,219);
{бровка}    if (Cells[0,l_row]='10') then canvas.Brush.Color:=rgb(251,253,185);
          end;

        if (l_row=0) then
          canvas.font.style:=canvas.font.style;//+[fsbold];
        if l_row=0 then
          begin
            l_oldalign:=settextalign(canvas.handle,ta_center);
            l_XPos:=rect.left + (rect.right - rect.left) div 2;
            s:=cells[l_col,l_row];
            while s<>'' do
              begin
                if pos(#13,s)<>0 then
                  begin
                    if pos(#13,s)=1 then  s1:=''
                    else
                      begin
                        s1:=trim(copy(s,1,pred(pos(#13,s))));
                        delete(s,1,pred(pos(#13,s)));
                      end;
                    delete(s,1,2);
                  end
                else
                  begin
                    s1:=trim(s);
                    s:='';
                  end;
                l_YPos:=rect.top+2;
                canvas.textrect(rect,l_Xpos,l_YPos,s1);
                inc(rect.top,rowheights[l_row] div 3);
            end;
          settextalign(canvas.handle,l_oldalign);
        end
        else
          begin
            canvas.textrect(rect,rect.left+2,rect.top+2,cells[l_col,l_row]);
          end;
        canvas.font.style:=canvas.font.style-[fsbold];
    end;
  end;

procedure TForm1.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(Sender,ACol, ARow,Rect,State);
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  DrawCell(Sender,ACol, ARow,Rect,State);
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
  drawpoints;
end;

procedure TForm1.N18Click(Sender: TObject);
begin
  try
    TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveOsToCenter(StringGrid1.Selection.Top,StringGrid1.Selection.Bottom);
  except MessageDlg('Ошибка: нипонятная ошибка 56746', mtError, [mbOk], 0);
  end;
end;



procedure TForm1.N20Click(Sender: TObject);
var v:variant;
    s:string;
    r:real;
begin
  V:=OkBottomDlg.init('Введите величину смещения высоты в метрах');
  s:=v;
  try
        if pos('.',s)<>0 then s[pos('.',s)]:=decimalseparator;
        if pos(',',s)<>0 then s[pos(',',s)]:=decimalseparator;        
        r:=strtofloat(s);
        TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).MoveHeight(StringGrid1.Selection.Top,StringGrid1.Selection.Bottom,r);
        TCredoChild(tabs.Tabs.Objects[tabs.TabIndex]).onChanged;
  except
      MessageDlg('Введено неправильное значение', mtError, [mbOk], 0);
  end;
end;


end.
