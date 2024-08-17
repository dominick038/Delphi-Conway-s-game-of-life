program pConwaysGameOfLife;

uses
  Vcl.Forms,
  fmMainForm in 'Forms\fmMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
