program PBE;

uses
  Forms,
  PBE_U in 'PBE_U.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PhoneBackup Editor';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
