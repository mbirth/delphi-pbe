unit PBE_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Jpeg, GIFImage, FileCtrl;

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
    SM_Message: TEdit;
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
    procedure Button_LoadClick(Sender: TObject);
    procedure PB_ListClick(Sender: TObject);
    procedure PB_OrderFLClick(Sender: TObject);
    procedure PB_OrderLFClick(Sender: TObject);
    procedure PB_PhotoDelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileListBox1Change(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure Button_CloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TPBEntry = record
    Version: String[5];
    Name: String[30];
    Home, Work, Mobile, Fax, Other: String[80];
    Email: String[50];
    Title: String[15];
    Company: String[30];
    PhotoFile: String[255];
  end;

var
  Form1: TForm1;
  BackupFileName: string;
  PhoneBook: array[1..999] of TPBEntry;
  PhoneBookMax: integer;
  PhoneBookPhotoCount: integer = 0;
  f: Textfile;


implementation

{$R *.dfm}

function DecodeQP(my: string): string;
const qpa: string[16] = '0123456789ABCDEF';
var i: integer;
    qp: byte;
begin
  i := Pos('=',my);
  while (i>0) do begin
    my[i] := '?';
    qp := (Pos(my[i+1],qpa)-1)*16+Pos(my[i+2],qpa)-1;
    my := Copy(my,1,i-1)+Chr(qp)+Copy(my,i+3,Length(my)-i-2);
    i := Pos('=',my);
  end;
  DecodeQP := my;
end;

function B64toBin(my: string): string;
const b64a: string[64] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var x,i,j: integer;
    res: string;
begin
  res := '';
  for i:=1 to 4 do begin
    x := Pos(my[i],b64a)-1;
    if (x>=0) then begin
      j := 32;
      repeat
        if (x DIV j)>0 then begin
          res := res + '1';
          x := x - j;
        end else res := res + '0';
        j := j DIV 2;
      until (j=0);
    end else begin
      res := res + '000000';
    end;
  end;
  B64toBin := res;
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
    i := Pos('<br/><br/>',data);  // Find end of record
    if (i>0) then begin
      data := Copy(data,1,i-1);
    end;
    data := StringReplace(data,'<br/>','',[rfReplaceAll]); // Remove all <br/>
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
  s := '<br/>'+field+':';
  i := Pos(s, data);
  if (i<=0) then begin
    s := '<br/>'+field+';ENCODING=QUOTED-PRINTABLE:';
    i := Pos(s, data);
    if (i>0) then qp := true;
  end;
  if (i>0) then begin
    j := Pos('<br/>',Copy(data,i+5,Length(data)-i-5))+i+5;
    tmp := Copy(data,i+Length(s),j-i-Length(s)-1);
  end else tmp := '';
  if (qp) then tmp := DecodeQP(tmp);
  FindDataInStream := tmp;
end;

function ParsePBStream(data: AnsiString): TPBEntry;
var tmp: TPBEntry;
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
  for i:=1 to PhoneBookMax do begin
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
  if (PhoneBookMax>0) then begin
    for i:=1 to PhoneBookMax do begin
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
var i: integer;
    cl: AnsiString;
begin
  Form1.ProgressBar.Min := 0;
  Form1.ProgressBar.Max := FileSize(InFile);
  Form1.ProgressBar.Visible := true;
  i:=1;
  repeat
    ReadLn(InFile, cl);
  until Eof(InFile) OR (cl='<Contacts>');
  ReadLn(InFile, cl);
  repeat
    Form1.ProgressBar.Position := FilePos(InFile);
    cl := Trim(cl);
    PhoneBook[i] := ParsePBStream(cl);
    Inc(i);
    ReadLn(InFile, cl);
  until Eof(InFile) OR (cl='<Contacts/>');
  PhoneBookMax := i-1;
  Form1.StatusBar.SimpleText := 'Loaded '+IntToStr(PhoneBookMax)+' contacts into memory.';
  BuildPBList;
  Form1.ProgressBar.Visible := false;
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
  BackupFileName := DirectoryListBox1.Directory+'\'+FileName.Text;
  StatusBar.SimpleText := 'Loading '+BackupFileName+' ...';
  AssignFile(f,BackupFileName);
  StatusBar.SimpleText := StatusBar.SimpleText + '...';
  Reset(f);
  StatusBar.SimpleText := StatusBar.SimpleText + '...';
  ReadPBintoMem(f);
  StatusBar.SimpleText := StatusBar.SimpleText + ' done.';
  CloseFile(f);
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
  i := Form1.PB_List.ItemIndex+1;
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
  i := Form1.PB_List.ItemIndex+1;
  PhoneBook[i].PhotoFile := '';
  Form1.PB_ListClick(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
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
  PhoneBookMax := 0;
  StatusBar.SimpleText := StatusBar.SimpleText + ' done.';
  Button_Close.Enabled := false;
  Button_SaveAs.Enabled := false;
  Button_Save.Enabled := false;
  if (FileExists(DirectoryListBox1.Directory+'\'+FileName.Text)) AND (Pos('*',FileName.Text)=0) then Button_Load.Enabled := true else Button_Load.Enabled := false;
  Form1.DriveComboBox1.Enabled := true;
  Form1.DirectoryListBox1.Enabled := true;
  Form1.FilterComboBox1.Enabled := true;
  Form1.FileListBox1.Enabled := true;
end;

end.
