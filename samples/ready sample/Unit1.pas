unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.StdCtrls, FMX.Controls.Presentation,

  uBitmapHelper;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    memDados: TFDMemTable;
    memDadosNomeImg: TStringField;
    memDadosExtImg: TStringField;
    memDadosUrlImg: TStringField;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    ListView1: TListView;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    FListScrollPos : Single;
    procedure SeparaDados(const AUrl: String; var ANome, AExt: string);
    procedure SetListScrollPos(const Value: Single);
    procedure CarregarImagensVisiveis;
  public
    { Public declarations }
    property ListScrollPos : Single read FListScrollPos write SetListScrollPos;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.CarregarImagensVisiveis;
var
  I : Integer;
  Rect : TRectF;
begin
  for I := 0 to Pred(ListView1.Items.Count) do
  begin
    Rect := ListView1.GetItemRect(I);
    if Rect.IntersectsWith(ListView1.LocalRect) then
    begin
      if ListView1.Items[I].Objects.ImageObject.Bitmap.IsEmpty then
        ListView1.Items[I].Objects.ImageObject.Bitmap.LoadFromUrl(
          ListView1.Items[I].Objects.DetailObject.Text,
          True
        );
    end;
  end;
end;

procedure TForm1.ListView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  ListScrollPos := ListView1.ScrollViewPos;
end;

procedure TForm1.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if ListView1.GetItemRect(ListView1.Items.Count-1).Bottom <= ListView1.Height then
    AItem.Objects.ImageObject.Bitmap.LoadFromUrl(memDados.Fields[2].AsString, True);
end;

procedure TForm1.SeparaDados(const AUrl: String; var ANome, AExt: string);
var
  I: Integer;
begin
  ANome := '';
  AExt := '';

  for I := Length(AUrl) downto 1 do
  begin
    if AUrl[I] = '/' then
      break;

    ANome := AUrl[I] + ANome;
  end;

  AExt := ExtractFileExt(ANome);
  Delete(AExt, 1, 1); //remove o ponto da extensão
end;

procedure TForm1.SetListScrollPos(const Value: Single);
begin
  if (Value > FListScrollPos) or (Value <= 0) then
  begin
    FListScrollPos := Value;
    CarregarImagensVisiveis;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  Str  : TStringList;
  Url  : string;
  Nome : string;
  Ext  : string;
begin
  try
    Str := TStringList.Create;

    {$REGION 'Montagem da lista de URLs'}
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/zT6De-620x427.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/ZquAW-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/zO8QO-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/Z9Ooj-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/YYxzg-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/YV6ZW-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/wzKgL-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/WynR5-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/vmzZx-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/VJYYA-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/Uq007-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/UBwcw-620x484.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/TMmQw-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/tEEuq-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/t8xiY-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/SXGvZ-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/SjQev-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/SDgOR-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/rL0R8-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/RBt7W-620x339.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/RA6RF-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/QyFpY-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/QiGco-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/pTMWt-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/PQMDy-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/P6Kee-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/oeXNj-620x379.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/O69Gy-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/MUKLq-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/MOfFG-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/M8vAD-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/M5fEn-620x407.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/LMAtc-620x341.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/lkYg9-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/LhPkF-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/lhmcA-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/lAOat-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/L9Ne8-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/jZDU4-620x356.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/jlFtm-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/jHjRk-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/jBDTs-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/itmrJ-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/iLeBr-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/IkT0f-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/iALkR-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/HUIPD-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/HkO1R-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/GuMPe-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/GQwa9-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/GjxSc-620x350.png');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/GJcoH-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/ghjOQ-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/gD7Cq-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/g2OiS-620x348.png');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/FvLks-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/FOnBz-620x334.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/fK6w8-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/FCCJu-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/fArNp-620x496.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/f6T8C-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/etX38-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/EGu3g-620x339.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/e68sU-620x372.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/e6xGe-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/e5SbT-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/dZP33-620x379.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/duImz-620x413.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/DsKhk-620x465.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/Dgsso-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/DEvbE-620x308.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/cyISe-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/cN8Ua-620x373.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/CaGVi-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/BTSfh-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/Aso9s-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/156u2-620x424.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/83cON-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/48jHv-620x381.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/31NLu-620x381.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/9fVOR-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/9b14O-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/7sflU-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/07GWs-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/6WW8s-620x424.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/4L6u5-620x340.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/3geWt-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/1oEJ6-620x387.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/0Rivn-620x346.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/0qW18-620x348.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/0Q8s1-620x359.jpg');
      Str.Add('http://criticalhits.com.br/wp-content/uploads/2013/04/0hj9C-620x381.jpg');
    {$ENDREGION}

    memDados.Close;
    memDados.Open;
    memDados.DisableControls;
    try
      for URL in Str do
      begin
        SeparaDados(Url, Nome, Ext);
        memDados.Append;
        memDadosNomeImg.AsString := Nome;
        memDadosExtImg.AsString  := Ext;
        memDadosUrlImg.AsString  := Url;
        memDados.Post;
      end;
    finally
      memDados.EnableControls;
      memDados.First;
      ListScrollPos := 1;
    end;
  finally
    Str.DisposeOf;
  end;
end;

end.
