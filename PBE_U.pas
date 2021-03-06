unit PBE_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Jpeg, GIFImage, FileCtrl, Spin;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    StatusBar: TStatusBar;
    PB_List: TListBox;
    PB_OrderGroup: TRadioGroup;
    PB_OrderLF: TRadioButton;
    PB_OrderFL: TRadioButton;
    PB_Name: TEdit;
    PB_Home: TEdit;
    PB_Work: TEdit;
    PB_Mobile: TEdit;
    PB_Fax: TEdit;
    PB_Other: TEdit;
    PB_Email: TEdit;
    PB_Title: TEdit;
    PB_Company: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PB_PhotoGroup: TGroupBox;
    PB_Photo: TImage;
    PB_PhotoDelButton: TButton;
    PB_PhotoLoadButton: TButton;
    PB_PhotoSaveButton: TButton;
    FileName: TEdit;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DirLabel: TLabel;
    DriveComboBox1: TDriveComboBox;
    FilterComboBox1: TFilterComboBox;
    Button_Load: TButton;
    Button_Save: TButton;
    SM_List: TListBox;
    PB_NewButton: TButton;
    PB_DelButton: TButton;
    SM_SMSC: TEdit;
    SM_Recipient: TEdit;
    SM_PID: TEdit;
    SM_DCS: TEdit;
    SM_TimeStamp: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PB_PhotoAtt: TCheckBox;
    BM_List: TListBox;
    BM_Name: TEdit;
    BM_URL: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    LO_AutoKeylock: TCheckBox;
    PR_List: TListBox;
    PR_Name: TEdit;
    Label17: TLabel;
    BM_UpButton: TButton;
    BM_DownButton: TButton;
    WP_List: TListBox;
    BM_NewButton: TButton;
    BM_DelButton: TButton;
    SM_NewButton: TButton;
    SM_DelButton: TButton;
    PB_SaveButton: TButton;
    ProgressBar: TProgressBar;
    Button_SaveAs: TButton;
    Button_Close: TButton;
    SM_Message: TMemo;
    TabSheet12: TTabSheet;
    DBG_Count: TEdit;
    Label18: TLabel;
    DBG_Entry: TMemo;
    DBG_ShowEntry: TButton;
    DBG_EntryGroup: TEdit;
    DBG_EntryName: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    DBG_SelEntry: TSpinEdit;
    DBG_LastEntry: TCheckBox;
    DBG_Groups: TMemo;
    ProgBarText: TLabel;
    SC_List: TListBox;
    SC_ButtonUp: TButton;
    SC_ButtonDown: TButton;
    SC_AvailSCs: TComboBox;
    SC_ButtonAdd: TButton;
    SC_ButtonDel: TButton;
    SM_RadioSent: TRadioButton;
    SM_RadioRecvd: TRadioButton;
    BM_ButtonSave: TButton;
    procedure Button_LoadClick(Sender: TObject);
    procedure PB_ListClick(Sender: TObject);
    procedure PB_OrderFLClick(Sender: TObject);
    procedure PB_OrderLFClick(Sender: TObject);
    procedure PB_PhotoDelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileListBox1Change(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Button_CloseClick(Sender: TObject);
    procedure DBG_ShowEntryClick(Sender: TObject);
    procedure Button_SaveClick(Sender: TObject);
    procedure Button_SaveAsClick(Sender: TObject);
    procedure PB_DelButtonClick(Sender: TObject);
    procedure PB_NewButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TPhoneEntry = record
    Version: String[5];
    Name: String[30];
    Home, Work, Mobile, Fax, Other: String[80];
    Email: String[50];
    Title: String[15];
    Company: String[30];
    PhotoFile: String[255];
  end;
  TSMSEntry = record
    PDUHeader: String[40];
    SMSC, PhoneNo: longint;
    TStamp: TDateTime;
    Sent: boolean;
    Msg: String[160];
  end;
  TPBData = record
    Group: AnsiString;
    Name: AnsiString;
    Value: AnsiString;
    LastOfGroup: Boolean;
  end;
  TStartEnd = record
    from, til: word;
  end;
  TGroups = record
    Contacts: TStartEnd;
    Calendar: TStartEnd;
    SMSes: TStartEnd;
    SettingsData: TStartEnd;
    SettingsWAP: TStartEnd;
    Bookmarks: TStartEnd;
    SettingsProfiles: TStartEnd;
    SettingsLocks: TStartEnd;
    SettingsTime: TStartEnd;
    SettingsCustMenu: TStartEnd;
  end;

var
  Form1: TForm1;
  BackupFileName: string;
  PB: array of TPBData;
  PhoneBook: array of TPhoneEntry;
  PhoneBookPhotoCount: integer = 0;
  Groups: TGroups;
  f: Textfile;


implementation

const CRLF: string = Chr(13)+Chr(10);

{$R *.dfm}

function DecodeQP(my: string): string;
const qpa: string[16] = '0123456789ABCDEF';
var i: integer;
    qp: byte;
begin
  Result := my;
  i := Pos('=',Result);
  while (i>0) do begin
    Result[i] := '?';
    qp := (Pos(Result[i+1],qpa)-1)*16+Pos(Result[i+2],qpa)-1;
    Result := Copy(Result,1,i-1)+Chr(qp)+Copy(Result,i+3,Length(Result)-i-2);
    i := Pos('=',Result);
  end;
end;

function B64toBin(my: string): string;
const b64a: string[64] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var x,i,j: integer;
begin
  Result := '';
  for i:=1 to 4 do begin
    x := Pos(my[i],b64a)-1;
    if (x>=0) then begin
      j := 32;
      repeat
        if (x DIV j)>0 then begin
          Result := Result + '1';
          x := x - j;
        end else Result := Result + '0';
        j := j DIV 2;
      until (j=0);
    end else begin
      Result := Result + '000000';
    end;
  end;
end;

function BintoASC(my: string): string;
var i: integer;
    res: string;
begin
  res := '';
  while (Length(my)>=8) do begin
    i := 0;
    if (my[1]<>'0') then i := i + 128;
    if (my[2]<>'0') then i := i +  64;
    if (my[3]<>'0') then i := i +  32;
    if (my[4]<>'0') then i := i +  16;
    if (my[5]<>'0') then i := i +   8;
    if (my[6]<>'0') then i := i +   4;
    if (my[7]<>'0') then i := i +   2;
    if (my[8]<>'0') then i := i +   1;
    res := res + Chr(i);
    my := Copy(my,9,Length(my)-8);
  end;
  BintoASC := res;
end;

function DecodeB64(my: AnsiString): AnsiString;
var buf: string[4];
    binbuf: string[24];
    res: string;
begin
  res := '';
  while Length(my)>=4 do begin
    buf := Copy(my,1,4);
    my := Copy(my,5,Length(my)-4);
    binbuf := B64toBin(buf);   // convert 4 B64-hextets to a 24 Bit-string ('0' or '1')
    res := res + BintoASC(binbuf);  // convert the binary string to 3 Bytes
  end;
  DecodeB64 := res;
end;

function FindPhotoInStream(data: AnsiString): string;
var i: integer;
    fn,t: string;
    f: TextFile;
begin
  fn := '';
  i := Pos('PHOTO;ENCODING=BASE64;TYPE=',data);
  if (i>0) then begin
    data := Copy(data,i+27,Length(data)-i-27);
    i := Pos(CRLF+CRLF,data);  // Find end of record
    if (i>0) then begin
      data := Copy(data,1,i-1);
    end;
    data := StringReplace(data,CRLF,'',[rfReplaceAll]); // Remove all <br/>
    i := Pos(':',data); // Find Image-Type (first 3 or 4 chars followed by a colon)
    if (i>0) then begin
      t := Copy(data,1,i-1);  // Now contains the Image-Type ('JPEG' or 'GIF')
      data := Copy(data,i+1,Length(data)-i);  // The pure data in Base64
    end;
    data := DecodeB64(data);
    Inc(PhoneBookPhotoCount);
    fn := GetEnvironmentVariable('TEMP')+'\PBE\';
    if NOT DirectoryExists(fn) then if NOT CreateDir(fn) then Exit;
    fn := fn + 'PB';
    if (PhoneBookPhotoCount<100) then fn := fn + '0';
    if (PhoneBookPhotoCount<10) then fn := fn + '0';
    fn := fn + IntToStr(PhoneBookPhotoCount) + '.';
    if (t='JPEG') then fn := fn + 'jpg';
    if (t='GIF') then fn := fn + 'gif';
    AssignFile(f, fn);
    Rewrite(f);
    Write(f,data);
    CloseFile(f);
  end;
  FindPhotoInStream := fn;   // Return the filename of the extracted picture
end;

function FindDataInStream(field: string; data: AnsiString): string;
var i,j: integer;
    s: string;
    qp: boolean;
    tmp: string;
begin
  qp := false;
  s := CRLF+field+':';
  i := Pos(s, data);
  if (i<=0) then begin
    s := CRLF+field+';ENCODING=QUOTED-PRINTABLE:';
    i := Pos(s, data);
    if (i>0) then qp := true;
  end;
  if (i>0) then begin
    j := Pos(CRLF,Copy(data,i+5,Length(data)-i-5))+i+5;
    tmp := Copy(data,i+Length(s),j-i-Length(s)-1);
  end else tmp := '';
  if (qp) then tmp := DecodeQP(tmp);
  FindDataInStream := tmp;
end;

function ParsePBStream(data: AnsiString): TPhoneEntry;
var tmp: TPhoneEntry;
begin
  tmp.Version := FindDataInStream('VERSION',data);
  tmp.Name := FindDataInStream('N',data);
  tmp.Home := FindDataInStream('TEL;HOME',data);
  tmp.Work := FindDataInStream('TEL;WORK',data);
  tmp.Mobile := FindDataInStream('TEL;CELL',data);
  tmp.Fax := FindDataInStream('TEL;FAX',data);
  tmp.Other := FindDataInStream('TEL',data);
  tmp.Email := FindDataInStream('EMAIL;INTERNET;PREF',data);
  tmp.Title := FindDataInStream('TITLE',data);
  tmp.Company := FindDataInStream('COMPANY',data);
  tmp.PhotoFile := FindPhotoInStream(data);
  ParsePBStream := tmp;
end;

function FormatName(y: string): string;
var x1,x2,x: string;
    i: integer;
begin
  i := Pos(';',y);
  if (i>0) then begin
    x1 := Copy(y,1,i-1);
    x2 := Copy(y,i+1,Length(y)-i);
    if (Length(x1)>0) AND (Length(x2)>0) then begin
      if (Form1.PB_OrderLF.Checked) then x := x1 + ', ' + x2 else x := x2 + ' ' + x1;
    end else if (Length(x1)=0) AND (Length(x2)>0) then x := x2
    else if (Length(x1)>0) AND (Length(x2)=0) then x := x1
    else if (Length(x1)=0) AND (Length(x2)=0) then x := '<no name>';
  end else x := y;
  FormatName := x;
end;

procedure BuildPBList;
var i: integer;
begin
  Form1.PageControl1.ActivePageIndex := 0;
  Form1.PB_List.Clear;
  for i:=0 to Length(PhoneBook)-1 do begin
    Form1.PB_List.Items.Add(FormatName(PhoneBook[i].Name));
  end;
end;

procedure DeleteTemp;
var i: integer;
    e: boolean;
    d: string;
begin
  e := false;
  d := '';
  if (Length(PhoneBook)>0) then begin
    for i:=0 to Length(PhoneBook)-1 do begin
      if (PhoneBook[i].PhotoFile<>'') then begin
        if (d='') then d := ExtractFileDir(PhoneBook[i].PhotoFile);
        if (NOT DeleteFile(PhoneBook[i].PhotoFile)) then e := true;
      end;
    end;
    if (d<>'') then if NOT RemoveDir(d) then e := true;
    if e then ShowMessage('Some files could not be deleted. Check '+d+' to delete them manually.');
  end;
end;

procedure ReadPBintoMem(var InFile: TextFile);
var i, j: integer;
    cl, gp: AnsiString;
begin
  (*********************************************************************
  ***** READ FILE INTO ARRAY                                       *****
  *********************************************************************)
  Form1.ProgressBar.Min := 0;
  Form1.ProgressBar.Max := FileSize(InFile);
  Form1.ProgressBar.Position := 0;
  Form1.ProgressBar.Visible := true;
  Form1.ProgBarText.Caption := 'Reading file...';
  Application.ProcessMessages;
  i:=0;
  gp := '';
  Groups.Contacts.from := $FFFF;
  Groups.Contacts.til := $FFFF;
  Groups.Calendar.from := $FFFF;
  Groups.Calendar.til := $FFFF;
  Groups.SMSes.from := $FFFF;
  Groups.SMSes.til := $FFFF;
  Groups.SettingsData.from := $FFFF;
  Groups.SettingsData.til := $FFFF;
  Groups.SettingsWAP.from := $FFFF;
  Groups.SettingsWAP.til := $FFFF;
  Groups.Bookmarks.from := $FFFF;
  Groups.Bookmarks.til := $FFFF;
  Groups.SettingsProfiles.from := $FFFF;
  Groups.SettingsProfiles.til := $FFFF;
  Groups.SettingsLocks.from := $FFFF;
  Groups.SettingsLocks.til := $FFFF;
  Groups.SettingsTime.from := $FFFF;
  Groups.SettingsTime.til := $FFFF;
  Groups.SettingsCustMenu.from := $FFFF;
  Groups.SettingsCustMenu.til := $FFFF;

  repeat
    ReadLn(InFile, cl);
    Form1.ProgressBar.Position := FilePos(InFile);
    cl := Trim(cl);
    cl := StringReplace(cl, '<br/>', CRLF, [rfReplaceAll]);
    if (cl='<Contacts>') then Groups.Contacts.from := i
      else if (cl='<Contacts/>') then Groups.Contacts.til := i-1
      else if (cl='<Calendar>') then Groups.Calendar.from := i
      else if (cl='<Calendar/>') then Groups.Calendar.til := i-1
      else if (cl='<SMS_Messages>') then Groups.SMSes.from := i
      else if (cl='<SMS_Messages/>') then Groups.SMSes.til := i-1
      else if (cl='<Settings_DataAccount>') then Groups.SettingsData.from := i
      else if (cl='<Settings_DataAccount/>') then Groups.SettingsData.til := i-1
      else if (cl='<Settings_WAP>') then Groups.SettingsWAP.from := i
      else if (cl='<Settings_WAP/>') then Groups.SettingsWAP.til := i-1
      else if (cl='<Bookmarks>') then Groups.Bookmarks.from := i
      else if (cl='<Bookmarks/>') then Groups.Bookmarks.til := i-1
      else if (cl='<Settings_Profiles>') then Groups.SettingsProfiles.from := i
      else if (cl='<Settings_Profiles/>') then Groups.SettingsProfiles.til := i-1
      else if (cl='<Settings_Locks>') then Groups.SettingsLocks.from := i
      else if (cl='<Settings_Locks/>') then Groups.SettingsLocks.til := i-1
      else if (cl='<Settings_Time>') then Groups.SettingsTime.from := i
      else if (cl='<Settings_Time/>') then Groups.SettingsTime.til := i-1
      else if (cl='<Settings_CustomMenu>') then Groups.SettingsCustMenu.from := i
      else if (cl='<Settings_CustomMenu/>') then Groups.SettingsCustMenu.til := i-1;

    if (cl[1]='<') AND (cl[Length(cl)]='>') AND (cl[Length(cl)-1]<>'/') AND (Pos(' ',cl)=0) then begin
      gp := gp + '>' + Copy(cl, 2, Length(cl)-2);
    end else if (cl[1]='<') AND (cl[Length(cl)-1]+cl[Length(cl)]='/>') AND (Pos(' ',cl)=0) then begin
      gp := Copy(gp,1,Length(gp)-Length(cl)+2);
      // gp := StringReplace(gp, '>' + Copy(cl, 2, Length(cl)-3), '', [rfReplaceAll]);
      if (i>0) then PB[i-1].LastOfGroup := true;
    end else if (Pos('value=', LowerCase(cl))>0) AND (Pos('/>', cl)>0) then begin
      Inc(i);
      SetLength(PB, i);
      PB[i-1].Group := gp;
      PB[i-1].Name := Copy(cl, Pos('<', cl)+1, Pos(' ', cl)-Pos('<', cl)-1);
      PB[i-1].Value := Copy(cl, Pos('value=', LowerCase(cl))+6, Pos('/>', cl)-Pos('value=', LowerCase(cl))-6);
      PB[i-1].LastOfGroup := false;
    end else if (Pos('value=', LowerCase(cl))>0) AND (Pos('/>', cl)=0) then begin
      Inc(i);
      SetLength(PB, i);
      PB[i-1].Group := gp;
      PB[i-1].Name := Copy(cl, Pos('<', cl)+1, Pos(' ', cl)-Pos('<', cl)-1);
      PB[i-1].Value := Copy(cl, Pos('value=', LowerCase(cl))+6, Length(cl)-Pos('value=', LowerCase(cl))-6);
      PB[i-1].LastOfGroup := false;
    end else if (Pos('value=', LowerCase(cl))=0) AND (Pos('/>', cl)=0) then begin
      PB[i-1].Value := PB[i-1].Value + cl;
    end else if (Pos('value=', LowerCase(cl))=0) AND (Pos('/>', cl)>0) then begin
      PB[i-1].Value := PB[i-1].Value + Copy(cl,1,Pos('/>', cl)-2);
    end;
  until Eof(InFile);
  Form1.ProgressBar.Visible := false;
  Form1.DBG_Count.Text := IntToStr(i);
  Form1.DBG_SelEntry.MaxValue := i-1;
  Form1.DBG_Groups.Text := 'Contacts: '+IntToStr(Groups.Contacts.from)+'..'+IntToStr(Groups.Contacts.til)+CRLF+
                           'Calendar: '+IntToStr(Groups.Calendar.from)+'..'+IntToStr(Groups.Calendar.til)+CRLF+
                           'SMSes: '+IntToStr(Groups.SMSes.from)+'..'+IntToStr(Groups.SMSes.til)+CRLF+
                           'Data: '+IntToStr(Groups.SettingsData.from)+'..'+IntToStr(Groups.SettingsData.til)+CRLF+
                           'WAP: '+IntToStr(Groups.SettingsWAP.from)+'..'+IntToStr(Groups.SettingsWAP.til)+CRLF+
                           'Bookmarks: '+IntToStr(Groups.Bookmarks.from)+'..'+IntToStr(Groups.Bookmarks.til)+CRLF+
                           'Profiles: '+IntToStr(Groups.SettingsProfiles.from)+'..'+IntToStr(Groups.SettingsProfiles.til)+CRLF+
                           'Locks: '+IntToStr(Groups.SettingsLocks.from)+'..'+IntToStr(Groups.SettingsLocks.til)+CRLF+
                           'Time: '+IntToStr(Groups.SettingsTime.from)+'..'+IntToStr(Groups.SettingsTime.til)+CRLF+
                           'CustomMenu: '+IntToStr(Groups.SettingsCustMenu.from)+'..'+IntToStr(Groups.SettingsCustMenu.til);

  Form1.StatusBar.SimpleText := 'File openened. Now parsing for Contacts ...';

  (*********************************************************************
  ***** PARSE CONTACTS FROM ARRAY                                  *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Contacts (1/10) ...';
  Application.ProcessMessages;
  if (Groups.Contacts.from<$FFFF) then begin
    j := 1;
    i := Groups.Contacts.from;
    Form1.ProgressBar.Min := Groups.Contacts.from;
    Form1.ProgressBar.Max := Groups.Contacts.til;
    Form1.ProgressBar.Position := Groups.Contacts.from;
    Form1.ProgressBar.Visible := true;
    while (i<=Groups.Contacts.til) do begin
      Form1.ProgressBar.Position := i;
      SetLength(PhoneBook, j);
      PhoneBook[j-1] := ParsePBStream(PB[i].Value);
      Inc(j);
      Inc(i);
    end;
    Form1.StatusBar.SimpleText := 'Loaded '+IntToStr(Length(PhoneBook))+' contacts into memory.';
    BuildPBList;
    Form1.ProgressBar.Visible := false;
  end;

  (*********************************************************************
  ***** PARSE CALENDAR ENTRIES FROM ARRAY                          *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Calendar (2/10) ...';
  Application.ProcessMessages;
  if (Groups.Calendar.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE SMSes FROM ARRAY                                     *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing SMSes (3/10) ...';
  Application.ProcessMessages;
  if (Groups.SMSes.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE DATA ACCOUNTS FROM ARRAY                             *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Data accounts (4/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsData.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE WAP ACCOUNTS FROM ARRAY                              *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing WAP accounts (5/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsWAP.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE BOOKMARKS FROM ARRAY                                 *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Bookmarks (6/10) ...';
  Application.ProcessMessages;
  if (Groups.Bookmarks.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE PROFILES FROM ARRAY                                  *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Profiles (7/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsProfiles.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE LOCK SETTINGS FROM ARRAY                             *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Locks (8/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsLocks.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE TIME SETTINGS FROM ARRAY                             *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Time settings (9/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsTime.from<$FFFF) then begin

  end;

  (*********************************************************************
  ***** PARSE CUSTOM MENUS FROM ARRAY                              *****
  *********************************************************************)
  Form1.ProgBarText.Caption := 'Parsing Custom Menus (10/10) ...';
  Application.ProcessMessages;
  if (Groups.SettingsCustMenu.from<$FFFF) then begin

  end;

end;

procedure EnablePBFields(x: boolean);
begin
  with Form1 do begin
    Label1.Enabled := x;
    PB_Name.Enabled := x;
    Label2.Enabled := x;
    PB_Home.Enabled := x;
    Label3.Enabled := x;
    PB_Work.Enabled := x;
    Label4.Enabled := x;
    PB_Mobile.Enabled := x;
    Label5.Enabled := x;
    PB_Fax.Enabled := x;
    Label6.Enabled := x;
    PB_Other.Enabled := x;
    Label7.Enabled := x;
    PB_Email.Enabled := x;
    Label8.Enabled := x;
    PB_Title.Enabled := x;
    Label9.Enabled := x;
    PB_Company.Enabled := x;
  end;
end;

procedure TForm1.Button_LoadClick(Sender: TObject);
begin
  Form1.Button_Load.Enabled := false;
  Form1.DirectoryListBox1.Enabled := false;
  Form1.DriveComboBox1.Enabled := false;
  Form1.FilterComboBox1.Enabled := false;
  Form1.FileListBox1.Enabled := false;
  Form1.FileName.Visible := false;
  Form1.ProgBarText.Visible := true;
  BackupFileName := DirectoryListBox1.Directory+'\'+FileName.Text;
  StatusBar.SimpleText := 'Loading '+BackupFileName+' ...';
  AssignFile(f,BackupFileName);
  StatusBar.SimpleText := StatusBar.SimpleText + '...';
  Reset(f);
  StatusBar.SimpleText := StatusBar.SimpleText + '...';
  ReadPBintoMem(f);
  StatusBar.SimpleText := StatusBar.SimpleText + ' done.';
  CloseFile(f);
  Form1.ProgBarText.Visible := false;
  Form1.FileName.Visible := true;
  Form1.PB_List.Enabled := true;
  Form1.PB_OrderGroup.Enabled := true;
  Form1.PB_OrderFL.Enabled := true;
  Form1.PB_OrderLF.Enabled := true;
  Form1.Button_Save.Enabled := true;
  Form1.Button_SaveAs.Enabled := true;
  Form1.Button_Close.Enabled := true;
end;

procedure TForm1.PB_ListClick(Sender: TObject);
var i: integer;
    x: TJPEGImage;
    y: TGIFImage;
begin
  i := Form1.PB_List.ItemIndex;
  x := TJpegImage.Create;
  y := TGIFImage.Create;
  Form1.PB_Name.Text := FormatName(PhoneBook[i].Name);
  Form1.PB_Home.Text := PhoneBook[i].Home;
  Form1.PB_Work.Text := PhoneBook[i].Work;
  Form1.PB_Mobile.Text := PhoneBook[i].Mobile;
  Form1.PB_Fax.Text := PhoneBook[i].Fax;
  Form1.PB_Other.Text := PhoneBook[i].Other;
  Form1.PB_Email.Text := PhoneBook[i].Email;
  Form1.PB_Title.Text := PhoneBook[i].Title;
  Form1.PB_Company.Text := PhoneBook[i].Company;
  if PhoneBook[i].PhotoFile <> '' then Form1.PB_PhotoAtt.Checked := true else Form1.PB_PhotoAtt.Checked := false;
  if (PhoneBook[i].PhotoFile<>'') then begin
    if (Pos('.jp',PhoneBook[i].PhotoFile)>0) then begin
      x.LoadFromFile(PhoneBook[i].PhotoFile);
      Form1.PB_Photo.Picture.Graphic := x;
      x.Free;
    end;
    if (Pos('.gif',PhoneBook[i].PhotoFile)>0) then begin
      y.LoadFromFile(PhoneBook[i].PhotoFile);
      Form1.PB_Photo.Picture.Graphic := y;
      y.Free;
    end;
    Form1.PB_Photo.Visible := true;
  end else Form1.PB_Photo.Visible := false;
  EnablePBFields(true);
end;

procedure TForm1.PB_OrderFLClick(Sender: TObject);
begin
  BuildPBList;
end;

procedure TForm1.PB_OrderLFClick(Sender: TObject);
begin
  BuildPBList;
end;

procedure TForm1.PB_PhotoDelButtonClick(Sender: TObject);
var i: integer;
begin
  i := Form1.PB_List.ItemIndex;
  DeleteFile(PhoneBook[i].PhotoFile);
  PhoneBook[i].PhotoFile := '';
  Form1.PB_ListClick(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StatusBar.SimpleText := 'Cleaning up ...';
  DeleteTemp;
end;

procedure TForm1.FileListBox1Change(Sender: TObject);
begin
  if (FileExists(DirectoryListBox1.Directory+'\'+FileName.Text)) AND (Pos('*',FileName.Text)=0) AND (NOT Button_Close.Enabled) then Button_Load.Enabled := true else Button_Load.Enabled := false;
end;

procedure TForm1.DirectoryListBox1Change(Sender: TObject);
begin
  if (FileExists(DirectoryListBox1.Directory+'\'+FileName.Text)) AND (Pos('*',FileName.Text)=0) AND (NOT Button_Close.Enabled) then Button_Load.Enabled := true else Button_Load.Enabled := false;
end;

procedure TForm1.Button_CloseClick(Sender: TObject);
begin
  if (Button_Close.Caption = 'Close') then begin
    StatusBar.SimpleText := 'Cleaning up ...';
    EnablePBFields(false);
    PB_List.Enabled := false;
    PB_OrderGroup.Enabled := false;
    PB_OrderFL.Enabled := false;
    PB_OrderLF.Enabled := false;
    PB_List.Clear;
    PB_Name.Text := '';
    PB_Home.Text := '';
    PB_Work.Text := '';
    PB_Mobile.Text := '';
    PB_Fax.Text := '';
    PB_Other.Text := '';
    PB_Email.Text := '';
    PB_Title.Text := '';
    PB_Company.Text := '';
    PB_PhotoAtt.Checked := false;
    PB_Photo.Visible := false;
    DeleteTemp;
    SetLength(PhoneBook, 0);
    StatusBar.SimpleText := StatusBar.SimpleText + ' done.';
    Button_Close.Enabled := false;
    Button_SaveAs.Enabled := false;
    Button_Save.Enabled := false;
    if (FileExists(DirectoryListBox1.Directory+'\'+FileName.Text)) AND (Pos('*',FileName.Text)=0) then Button_Load.Enabled := true else Button_Load.Enabled := false;
    Form1.DriveComboBox1.Enabled := true;
    Form1.DirectoryListBox1.Enabled := true;
    Form1.FilterComboBox1.Enabled := true;
    Form1.FileListBox1.Enabled := true;
  end else if Button_Close.Caption = 'Cancel' then begin
    Button_SaveAs.Enabled := true;
    Button_Close.Caption := 'Close';
    FileName.Text := ExtractFileName(BackupFileName);
    FileName.Enabled := false;
  end;
end;

procedure TForm1.DBG_ShowEntryClick(Sender: TObject);
var i: integer;
begin
  i := Form1.DBG_SelEntry.Value;
  Form1.DBG_EntryGroup.Text := PB[i].Group;
  Form1.DBG_EntryName.Text := PB[i].Name;
  Form1.DBG_Entry.Text := PB[i].Value;
  Form1.DBG_LastEntry.Checked := PB[i].LastOfGroup;
end;

procedure TForm1.Button_SaveClick(Sender: TObject);
begin
  ShowMessage('Not yet supported.');
  if (Button_Close.Caption = 'Cancel') then begin
    Button_Close.Caption := 'Close';
    FileName.Enabled := false;
    BackupFileName := DirectoryListBox1.Directory+'\'+FileName.Text;
    Button_SaveAs.Enabled := true;
  end;
  AssignFile(f, BackupFileName);
end;

procedure TForm1.Button_SaveAsClick(Sender: TObject);
begin
  Button_SaveAs.Enabled := false;
  Button_Close.Caption := 'Cancel';
  FileName.Enabled := true;
  FileName.SetFocus;
end;

procedure TForm1.PB_DelButtonClick(Sender: TObject);
begin
  // Delete phonebook entry
end;

procedure TForm1.PB_NewButtonClick(Sender: TObject);
begin
  // Add new phonebook entry
end;

end.
