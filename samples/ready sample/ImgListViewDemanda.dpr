program ImgListViewDemanda;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uBitmapHelper in 'uBitmapHelper.pas',
  uAnonThread in 'uAnonThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
