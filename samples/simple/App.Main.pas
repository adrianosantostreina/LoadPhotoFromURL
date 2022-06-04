unit App.Main;

interface

uses
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants,
  FMX.Layouts,
  FMX.ListBox;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Edit1: TEdit;
    Button2: TButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    ListBox1: TListBox;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  uBitmapHelper;

{$R *.fmx}


procedure TForm5.Button1Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadFromUrl(Edit1.Text);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadThumbnailFromUrl(Edit1.Text, 50, 50);
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  LThread: TThread;
begin
  LThread :=
    TThread.CreateAnonymousThread(
    procedure()
    var
      I: Integer;
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          Image1.BeginUpdate;
          Image2.BeginUpdate;
          Image3.BeginUpdate;
          Image4.BeginUpdate;

          Image1.Bitmap := nil;
          Image2.Bitmap := nil;
          Image3.Bitmap := nil;
          Image4.Bitmap := nil;
        end
        );

      for I := 0 to Pred(ListBox1.Items.Count) do
      begin
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure()
          begin
            case I of
              1: Image2.Bitmap.LoadFromUrl('ftp://tdevrocks.com.br/portal/fotos/mizuno1.jpg');
              0: Image1.Bitmap.LoadFromUrl('ftp://tdevrocks.com.br/portal/fotos/mizuno2.jpg');
              2: Image3.Bitmap.LoadFromUrl('ftp://tdevrocks.com.br/portal/fotos/mizuno3.jpg');
              3: Image4.Bitmap.LoadFromUrl('ftp://tdevrocks.com.br/portal/fotos/mizuno4.jpg');
            end;
          end
        )
      end;

      Image1.EndUpdate;
      Image2.EndUpdate;
      Image3.EndUpdate;
      Image4.EndUpdate;
    end
    );
  LThread.Start;
end;

end.
