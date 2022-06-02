program AppSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  App.Main in 'App.Main.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
