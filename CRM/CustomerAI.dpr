program CustomerAI;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows11 Polar Light');
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
