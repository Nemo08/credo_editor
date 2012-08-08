unit readerlib;

interface

uses
  Classes, SysUtils,unilib,Dialogs,Math;
const
  maxcredonumber=500; // ???????????? ?????????? ???????? (????????????)
type
  //real48Array = array [1..6] of byte;
  //int4arr =array [1..4] of smallint;
  wrd100arr = array [1..101] of char;
// no?oeoo?a popsuper.bin
 recarr_WIN = record
         pointcode:byte;   //��� �����, ���� popcodto.txt
         xz0,       // ����� Len � ��������??
         OsLen,    // ���������� �� ������� �� ���
         len,     // ���������� �� �������.��� (�������) � � ���.��
         height:real48;   //������� �����
         gorinstr: real48; // �������� �����������
         otscrei:word;  //������ �� ����� ����� (�������) � �� ����
         xz1:byte;
         vkgrad,vkmin,vksec:word;  // ������ �� ��, ���� ��� ���
         xz2:byte;
         vugrad,vumin,vusec:word;  // ������������� ����, ���� ��� ���
         textop:string[12];  //��������� �������� �����
         recend:byte;
  end;

 recarr = packed record
         pointcode:byte;   //��� �����, ���� popcodto.txt
         xz0,       // ����� Len � ��������??
         OsLen,    // ���������� �� ������� �� ���
         len,     // ���������� �� �������.��� (�������)
         height:real48;   //������� �����
         gorinstr: real48; // �������� �����������
         otscRei:word;  //������ �� ����� ����� (�������)
         xz1:byte;
         vkgrad,vkmin,vksec:word;  // ������ �� ��, ���� ��� ���
         xz2:byte;
         vugrad,vumin,vusec:word;  // ������������� ����, ���� ��� ���
         textop:array [1..12] of char;  //��������� �������� �����
         recend:byte;

  end;

 popsuperstruct = packed record    //  ��� ���������� �� ���-�����

     pk,plus,dot:word; //Pk+Plus.dot
     kolkov:byte;{���������� ������� � �������� ������}
     str1:byte;  {��}
     poptype:byte;{1-������,2-���� �/�,3-�����,��}
     xz0:byte;   {��}
     datatype:byte;{��� ��������� ������ 1-������� 2-���� 3-�������}
     teotype:byte;{��� ��������� 1-������ 1, 2-2, 3-3}
     naprkrug:byte;{2-���� ����, 1 -�����}
     teoheight:real48; {������ ���������}
     xz:byte;     {��}
     teograd,teomin,teosec:word;{������� ��������, ����.���.���.}
     otscReiNiv:word; // ������ �� ����� �������� (�������)
     RepHeight:real48; //������� ������ (�������)
     a,b:byte;    {��}
     poper:array [1..60] of recarr; // ������ �����
     str3:wrd100arr;
  end;

  popsuperstruct_WIN = record    //  ��� ���������� �� ���-�����

     pk:real; //������ ������ � ������
     kolkov:byte;{���������� ������� � �������� ������}
     poptype:byte;{1-������,2-���� �/�,3-�����,��}
     datatype:byte;{��� ��������� ������ 1-������� 2-���� 3-�������}
     teotype:byte;{��� ��������� 1-������ 1, 2-2, 3-3}
     teograd,teomin,teosec:word;{������� ��������, ����.���.���.}
     naprkrug:byte;{2-���� ����, 1 -�����}
     teoheight:real48; {������ ���������}
     xz,xz0:byte;
     str1:byte;
     otsc:word; // ������ �� ����� �������� (�������) � ��  ����
     RepHeight:real; //������� ������ (�������) � �, ����.��
     a,b:byte;
     poper:array [1..60] of recarr_WIN; // ������ �����
     str3:wrd100arr;
     popkeystr:integer;
     // ������ �� ������ , 3..4 - ����� ������ ����������� � ����� popsuper
  end;
  poppointer=^popsuperstruct_WIN;
  // no?oeoo?a oaeea popkey.bin
  popkeystruct = packed record
     // Aey niaianoeiinoe: pk+plus.dot, ?.?. 2+13.54
     //pkLo,pkHi,plusLo,plusHi,dotLo,dotHi:byte;
     pkLo,pkHi,plusLo,plusHi,dotLo,dotHi:byte;
     str1,pkpos:integer; //1..2 ?????? ??? ???????????
     end;
  popkeystruct_win = packed record
     // Aey niaianoeiinoe: pk+plus.dot, ?.?. 2+13.54
     //pkLo,pkHi,plusLo,plusHi,dotLo,dotHi:byte;
     pk,plus,dot:word;
     str1,pkpos:integer; //1..2 ?????? ??? ???????????
     end;

   popkeytype= array[0..maxcredonumber-1] of popkeystruct;
   popsuperarray = array [0..maxcredonumber-1] of popsuperstruct_WIN;

   TCredoObj=class(TObject)
         popkeycount:integer; // ?????????? ???????????? ? popkey
        // popsupercount:integer; // ?????????? ???????????? ? popsuper
         popsuper:array [0..maxcredonumber-1] of popsuperstruct_WIN; // ????????? ????? popsuper

      private
{         function NullEv:int64; virtual;}
         folderpath:string;  //???? ? ????? ? ????????

         procedure Sort;
         procedure doNothing(str:string);
         function isNotNullPoint(pt:recarr_win):boolean;

      public   { Public declarations }
         function getpoper(n:integer):popsuperstruct_WIN;
         procedure SaveObject;
         function OpenObject(objectpath:string):boolean;
         procedure MoveToProd(frompop,topop:integer;offs:real);
         procedure MoveToPop(frompop,topop:integer;offs:real);
         procedure MoveOsToNol(frompop,topop:integer);
         procedure MoveOsToCenter(frompop,topop:integer);
         function pk2str(pk:real):string;
         procedure MoveHeight(frompop,topop:integer;offs:real);         
         // �����������
         procedure onChanged; virtual;
         procedure onChangePoints; virtual;
         procedure onOpend; virtual;
{         procedure onClosed; virtual; abstract;}
         procedure onError(str:variant); virtual;
      private
         property error:variant write OnError;
      end;
var
      prog:array[0..2] of TCredoObj;

      //***************************************************
implementation

// ����������� ������� ������� ������ �� ������
procedure TCredoObj.onOpend; // ������� �������� �������
begin
end;
procedure TCredoObj.onChanged; //�������-��������� ������ � �������
begin
end;
procedure TCredoObj.onChangePoints; //�������-��������� ����� � �����������
begin
end;
procedure TCredoObj.onError(str:variant); // ��������� �� ������
begin
  MessageDlg(Str, mtError, [mbOk], 0);
end;
procedure TCredoObj.doNothing(str:string);
begin
  MessageDlg(Str, mtError, [mbOk], 0);
{  Showmessage(str);}
end;

// �������������� int ������ ������ � ������ � str ������ ���� ##+##.##
function TCredoObj.pk2str(pk:real):string;
  var
    q:string;
  begin
    q:=floattostr(pk);
    if pos(',',q)=0 then q:= q+',00';
    if (pk<100) then  insert('0+',q,pos(',',q)-2);
    if (pk>=100) then  insert('+',q,pos(',',q)-2);
    pk2str:=q;
  end;

  // ��������, �� �������� �� ����� � ����������� "������", true - �� ��������
function TCredoObj.isNotNullPoint(pt:recarr_win):boolean;
 begin
    isNotNullPoint:=true;
    if (pt.pointcode=99)and(pt.len=0){and
       (pt.vugrad=0)and(pt.vumin=0)and
       (pt.vusec=0)and(pt.vkgrad=0)and
       (pt.vkmin=0)and(pt.vksec=0)and
       (pt.len=0)}then isNotNullPoint:=false;
 end;

// ���������� ����������� �������
procedure TCredoObj.SaveObject;
  var
      popsuperfile:file of popsuperStruct;
      popkeyfile:file of popkeyStruct_win;
      i,k,l:integer;
      popsupertemp:popsuperStruct;
      popkeytemp:popkeyStruct_win;
      str1_win:string[20];
begin
  try
  if (popkeycount>=1)and(folderpath<>'') then
    begin
      AssignFile(popkeyfile,folderpath+'\popkey.bin');
      Rewrite(popkeyfile);
      AssignFile(popsuperfile,folderpath+'\popsuper.bin');
      Rewrite(popsuperfile);

      for i:=0 to (popkeycount-1) do
        begin
          seek(popkeyfile,i);
{
              inttostr(floor(r/100))+'+'+
              inttostr(floor(r-floor(r/100)*100))+'.'+
              inttostr(floor((r-floor(r))*100))
}
          popkeytemp.pk:=floor(popsuper[i].pk/100);
          popkeytemp.plus:=floor(popsuper[i].pk-floor(popsuper[i].pk/100)*100);
          popkeytemp.dot:=floor((popsuper[i].pk-floor(popsuper[i].pk))*100);
          popkeytemp.str1:=popsuper[i].popkeystr;
          popkeytemp.pkpos:=i;

          write(popkeyfile,popkeytemp);

          // popsuper
               seek(popsuperfile,i);
               popsupertemp.pk:=popkeytemp.pk;
               popsupertemp.plus:=popkeytemp.plus;
               popsupertemp.dot:=popkeytemp.dot;
               popsupertemp.str1:=popsuper[i].str1;
               popsupertemp.otscReiNiv:=popsuper[i].otsc;
               popsupertemp.RepHeight:= popsuper[i].RepHeight;
                popsupertemp.a:= popsuper[i].a;
                popsupertemp.b:=popsuper[i].b;
                popsupertemp.str3:=popsuper[i].str3;
                popsupertemp.kolkov:=popsuper[i].kolkov;
                popsupertemp.poptype:=popsuper[i].poptype;
                popsupertemp.datatype:=popsuper[i].datatype;
                popsupertemp.teotype:=popsuper[i].teotype;
                popsupertemp.teograd:=popsuper[i].teograd;
                popsupertemp.teomin:=popsuper[i].teomin;
                popsupertemp.teosec:=popsuper[i].teosec;
                popsupertemp.naprkrug:=popsuper[i].naprkrug;
                popsupertemp.teoheight:=popsuper[i].teoheight;
                popsupertemp.xz:=popsuper[i].xz;
                popsupertemp.xz0:=popsuper[i].xz0;
               for k:=1 to 60 do
                begin
                  popsupertemp.poper[k].pointcode:=popsuper[i].poper[k].pointcode;
                  popsupertemp.poper[k].xz0:=popsuper[i].poper[k].xz0;
                  popsupertemp.poper[k].OsLen:=popsuper[i].poper[k].OsLen;
                  popsupertemp.poper[k].len:=popsuper[i].poper[k].len;
                  popsupertemp.poper[k].height:=popsuper[i].poper[k].height;
                  popsupertemp.poper[k].gorinstr:=popsuper[i].poper[k].gorinstr;
                  popsupertemp.poper[k].otscRei:=popsuper[i].poper[k].otscrei;
                  for l:=1 to 14 do
                    popsupertemp.poper[k].xz1:=popsuper[i].poper[k].xz1;
                    popsupertemp.poper[k].xz2:=popsuper[i].poper[k].xz2;
                    popsupertemp.poper[k].vkgrad:=popsuper[i].poper[k].vkgrad;
                    popsupertemp.poper[k].vkmin:=popsuper[i].poper[k].vkmin;
                    popsupertemp.poper[k].vksec:=popsuper[i].poper[k].vksec;
                    popsupertemp.poper[k].vugrad:=popsuper[i].poper[k].vugrad;
                    popsupertemp.poper[k].vumin:=popsuper[i].poper[k].vumin;
                    popsupertemp.poper[k].vusec:=popsuper[i].poper[k].vusec;
                    {
         xz1:byte;
         vkgrad,vkmin,vksek:word;  // ������ �� ��, ���� ��� ���
         xz2:byte;
         vugrad,vumin,vusec:word;  // ������������� ����, ���� ��� ���
}
                  str1_win:=win2dos(popsuper[i].poper[k].textop);
                  for l:=1 to 12 do
                  popsupertemp.poper[k].textop[l]:=str1_win[l];
                  popsupertemp.poper[k].recend:=popsuper[i].poper[k].recend;
                end;
            write(popsuperfile,popsupertemp);
        end;
      close(popkeyfile);
      close(popsuperfile);
    end;
    except
      doNothing('������: ������ ���������-��!!');
    end;
end;
// �������� ����������� �������
function TCredoObj.OpenObject(objectpath:string):boolean;
   var
      popsuperfile:file of popsuperStruct;
      popkeyfile:file of popkeyStruct;
      i,k,l,size:integer;
      popsupertemp:popsuperStruct;
      popkeytemp:popkeyStruct;
      pk,dot,plus,pos:integer;
      pkfull:real;
      str1_win:string[20];
      str1:array [1..20] of byte absolute str1_win;
      str12_win:string[12];
      otsc_win:word;
      otsc_dos:array [1..2] of byte absolute otsc_win;
   begin
      OpenObject:=false;
      if (FileExists(objectpath+'\popsuper.bin')and
          FileExists(objectpath+'\popkey.bin')and
          (objectpath<>'')) then
        begin
          AssignFile(popsuperfile,objectpath+'\popsuper.bin');
          Reset(popsuperfile);

//******************************
          AssignFile(popkeyfile,objectpath+'\popkey.bin');
          Reset(popkeyfile);
          size:=filesize(popkeyfile);
          popkeycount:=size;// ������ ���-�� ������������
          for i:=0 to (size-1) do
            begin
               seek(popkeyfile,i);
               read(popkeyfile, popkeytemp);
               //**********************************************************
               // �������� ��� ��� ��������� � ������ WIN
               //**********************************************************
               // �����
               pk:= (popkeytemp.pkhi shl 8) + popkeytemp.pklo;
               plus:= (popkeytemp.plushi shl 8) + popkeytemp.pluslo;
               dot:= (popkeytemp.dothi shl 8) + popkeytemp.dotlo;
               pos:=  popkeytemp.pkpos;
               pkfull:=pk*100+plus+(dot/100);
               popsuper[i].popkeystr:=popkeytemp.str1;

               /////////////////  ������ ������ �� popsuper
               try
                 seek(popsuperfile,pos);
                 read(popsuperfile, popsupertemp);
               except
                showmessage('������ ������ �����!');
                exit;
               end;
               popsuper[i].pk:=1;
               popsuper[i].pk:=pkfull;
               // ������ str1
               for k:=1 to 20 do
                popsuper[i].str1:=popsupertemp.str1;

               // ������ �� �������� otsc
               popsuper[i].otsc:=popsupertemp.otscReiNiv;
               // RepHeight
               popsuper[i].RepHeight:=popsupertemp.RepHeight;
               //a, b , str3
               popsuper[i].a:=popsupertemp.a;
               popsuper[i].b:=popsupertemp.b;
               popsuper[i].str3:=popsupertemp.str3;
{     kolkov ���������� ������� � �������� ������
     poptype 1-������,2-���� �/�,3-�����,��
     datatype ��� ��������� ������ 1-������� 2-���� 3-�������
     teotype ��� ��������� 1-������ 1, 2-2, 3-3
     teograd,teomin,teosec ������� ��������, ����.���.���.
     naprkrug 2-���� ����, 1 -�����
     teoheight  ������ ���������
     xz,xz0:byte;}
                popsuper[i].kolkov:=popsupertemp.kolkov;
                popsuper[i].poptype:=popsupertemp.poptype;
                popsuper[i].datatype:=popsupertemp.datatype;
                popsuper[i].teotype:=popsupertemp.teotype;
                popsuper[i].teograd:=popsupertemp.teograd;
                popsuper[i].teomin:=popsupertemp.teomin;
                popsuper[i].teosec:=popsupertemp.teosec;
                popsuper[i].naprkrug:=popsupertemp.naprkrug;
                popsuper[i].teoheight:=popsupertemp.teoheight;
                popsuper[i].xz:=popsupertemp.xz;
                popsuper[i].xz0:=popsupertemp.xz0;
               // ��������� ������ � ��� ������
               for k:=1 to 60 do
                begin
                  //pointcode
                  popsuper[i].poper[k].pointcode:=popsupertemp.poper[k].pointcode;
                  //xz0
                  popsuper[i].poper[k].xz0:=popsupertemp.poper[k].xz0;
                  //OsLen
                  popsuper[i].poper[k].OsLen:=popsupertemp.poper[k].OsLen;
                  //len
                  popsuper[i].poper[k].len:=popsupertemp.poper[k].len;
                  //height
                  popsuper[i].poper[k].height:=popsupertemp.poper[k].height;
                  //gorinstr
                  popsuper[i].poper[k].gorinstr:=popsupertemp.poper[k].gorinstr;
                  //otscRei
                  popsuper[i].poper[k].otscrei:=popsupertemp.poper[k].otscRei;
                  // xz4
                  for l:=1 to 14 do

                    popsuper[i].poper[k].xz1:=popsupertemp.poper[k].xz1;
                    popsuper[i].poper[k].xz2:=popsupertemp.poper[k].xz2;
                    popsuper[i].poper[k].vkgrad:=popsupertemp.poper[k].vkgrad;
                    popsuper[i].poper[k].vkmin:=popsupertemp.poper[k].vkmin;
                    popsuper[i].poper[k].vksec:=popsupertemp.poper[k].vksec;
                    popsuper[i].poper[k].vugrad:=popsupertemp.poper[k].vugrad;
                    popsuper[i].poper[k].vumin:=popsupertemp.poper[k].vumin;
                    popsuper[i].poper[k].vusec:=popsupertemp.poper[k].vusec;

                  //txtop
                  str12_win:='            ';
                  for l:=1 to 12 do
                    str12_win[L]:=popsupertemp.poper[k].textop[l];
                  popsuper[i].poper[k].textop:=dos2win(str12_win);
                  //recend
                  popsuper[i].poper[k].recend:=popsupertemp.poper[k].recend;
                  // ��������� � ���������� ����������� �������� �� popkey
                  popsuper[i].popkeystr:=popkeytemp.str1;
                end;
           end;
          closefile(popkeyfile);
          closefile(popsuperfile);
          OpenObject:=true;
          folderpath:=objectpath;
          OnOpend;
          OnChanged;
        end
        else error:='������: � �������� ��� ������ ������, ���� �������� ����';
   end;
// ������ ���������� �� ������
function TCredoObj.getpoper(n:integer):popsuperstruct_WIN;
  begin
    if n<=(popkeycount) then
      begin
        getpoper:=popsuper[n];
      end
    else
      error:='������: ����������� � ����� ������� �� ����������';
  end;

  // �������� ��� � �������� �������� �����
procedure TCredoObj.MoveOsToCenter(frompop,topop:integer);
  var
    i,j,k,kolkr,oldos:integer;
    krlev,krprav,centr:real;
  begin
    try
      frompop:=frompop-1;
      topop:=topop-1;
      for i:=frompop to topop do
        begin
          kolkr:=0;
          for j:=1 to 60 do
            if popsuper[i].poper[j].pointcode=2 then kolkr:=kolkr+1;
          if kolkr=2 then
            begin
              krlev:=0;
              krprav:=0;
              for j:=1 to 60 do
                if popsuper[i].poper[j].pointcode=2 then
                  if krlev=0 then
                    krlev:=popsuper[i].poper[j].len
                  else krprav:=popsuper[i].poper[j].len;
              if krlev<>krprav then
                begin
                  centr:= (abs(krlev)+abs(krprav))/2;
                  if krlev<krprav then
                    centr:=krlev+centr else centr:=krprav+centr;
                  for j:=1 to 60 do
                    if (popsuper[i].poper[j].pointcode=1)or
                       (popsuper[i].poper[j].pointcode=0) then
                        begin
                          oldos:=j;
                          break;
                        end;
                  for j:=1 to 60 do
                    if isNotNullPoint(popsuper[i].poper[j])=false then
                      begin
                        popsuper[i].poper[j].pointcode:=1;
                        popsuper[i].poper[j].len:=centr;
                        popsuper[i].poper[j].textop:='��� �������.';
                        popsuper[i].poper[j].height:=popsuper[i].poper[oldos].height;
                        if (centr<popsuper[i].poper[oldos].len) then
                          begin
                            for k:=1 to 60 do
                              if (popsuper[i].poper[k].pointcode=2)and(popsuper[i].poper[k].len<popsuper[i].poper[oldos].len) then
                                begin
                                  popsuper[i].poper[j].height:=(popsuper[i].poper[oldos].height-popsuper[i].poper[k].height)*((centr-popsuper[i].poper[k].len)/(popsuper[i].poper[oldos].len-popsuper[i].poper[k].len))+popsuper[i].poper[k].height;
                                  break;
                                end;
                          end
                        else
                          begin
                            for k:=1 to 60 do
                              if (popsuper[i].poper[k].pointcode=2)and(popsuper[i].poper[k].len>popsuper[i].poper[oldos].len) then
                                begin
                                  popsuper[i].poper[j].height:=(popsuper[i].poper[oldos].height-popsuper[i].poper[k].height)*((centr-popsuper[i].poper[k].len)/(popsuper[i].poper[oldos].len-popsuper[i].poper[k].len))+popsuper[i].poper[k].height;
                                  break;
                                end;
                          end;
                        popsuper[i].poper[oldos].pointcode:=3;
                        popsuper[i].poper[oldos].textop:='����� �� �/�';
                        onChanged;
                        break;
                      end;
                end
              else
                doNothing('������: �� �� '+pk2str(popsuper[i].pk)+' ������� ������?? ���������� ���!');
            end
          else
              doNothing('������: �� �� '+pk2str(popsuper[i].pk)+' ����� 2� ������. ���������� ���!');
        end;
    except
      doNothing('������: ����� ������ MoveOsToProd');
    end;
  end;
// ����������� ������������ ���������
procedure TCredoObj.MoveToProd(frompop,topop:integer;offs:real);
  var
    i:integer;
  begin
    try
    frompop:=frompop-1;
    topop:=topop-1;
    if popkeycount>=2 then
    if (popsuper[frompop].pk<=popsuper[topop].pk)
    and(frompop<=topop)and(topop<=(popkeycount-1)) then
      begin
        for i:=frompop to topop do
           popsuper[i].pk:=popsuper[i].pk+offs;
        Sort;
        OnChanged;
      end;
    except
      doNothing('������: ����� ������ MoveProd ��� �������������������� �������');
    end;
  end;
// �������� ������������ ���������
procedure TCredoObj.MoveToPop(frompop,topop:integer;offs:real);
  var
    i,j:integer;
  begin
    try
    frompop:=frompop-1;
    topop:=topop-1;
    if popkeycount>=2 then
    if (popsuper[frompop].pk<=popsuper[topop].pk)
    and(frompop<=topop)
    and(topop<=(popkeycount-1)) then
      begin
        for i:=frompop to topop do
          for j:=1 to 60 do
            if isNotNullPoint(popsuper[i].poper[j]) then
              if popsuper[i].datatype=1 then // ���� �������, �� ��0
                popsuper[i].poper[j].xz0:=popsuper[i].poper[j].xz0+offs
              else popsuper[i].poper[j].len:=popsuper[i].poper[j].len+offs;
        OnChangePoints;
        OnChanged;
      end;
    except
      doNothing('������: ����� ������ MovePop ��� �������������������� �������');
    end;
  end;
// �������� ������������ �� ������
procedure TCredoObj.MoveHeight(frompop,topop:integer;offs:real);
  var
    i,j:integer;
  begin
    try
    frompop:=frompop-1;
    topop:=topop-1;
    if popkeycount>=2 then
    if (popsuper[frompop].pk<=popsuper[topop].pk)
    and(frompop<=topop)
    and(topop<=(popkeycount-1)) then
      begin
        for i:=frompop to topop do
          for j:=1 to 60 do
            if isNotNullPoint(popsuper[i].poper[j]) then
              if popsuper[i].datatype=1 then // ���� �������, �� ��0
                popsuper[i].poper[j].otscrei:=popsuper[i].poper[j].otscrei+Round(offs*1000)
              else popsuper[i].poper[j].height:=popsuper[i].poper[j].height+offs;
        OnChangePoints;
        OnChanged;
      end;
    except
      doNothing('������: ����� ������ MovePop ��� �������������������� �������');
    end;
  end;
// �������� ��� � ����
procedure TCredoObj.MoveOsToNol(frompop,topop:integer);
  var
    i,j:integer;
  begin
    try
    frompop:=frompop-1;
    topop:=topop-1;
    if popkeycount>=2 then
    if (popsuper[frompop].pk<=popsuper[topop].pk)
    and(frompop<=topop)and(topop<=(popkeycount-1)) then
      begin
        for i:=frompop to topop do
          for j:=1 to 60 do
            if (popsuper[i].poper[j].Len<>0)and
               ((popsuper[i].poper[j].pointcode=0)or
                (popsuper[i].poper[j].pointcode=1))
                then
                  MovetoPop(i+1,i+1,popsuper[i].poper[j].Len*(-1));
        OnChangePoints;
        OnChanged;
      end;
    except
      doNothing('������: ����� ������ MoveProd ��� �������������������� �������');
    end;
  end;
  ////////////////////////////////////////////////////////////////////
 procedure TCredoObj.Sort;
     var
      i,count:integer;
      temp:popsuperstruct_WIN;

 begin
     count:=popkeycount-2;
     while count>0 do
     begin
      for i:=0 to count do
        if popsuper[i].pk>popsuper[i+1].pk then
          begin
            temp:=popsuper[i+1];
            popsuper[i+1]:=popsuper[i];
            popsuper[i]:=temp;
          end;
      count:=count-1;
     end;
  end;


end.

