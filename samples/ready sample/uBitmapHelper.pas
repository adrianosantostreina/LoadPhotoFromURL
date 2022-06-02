unit uBitmapHelper;

interface

uses
  System.Classes,
  System.Net.HttpClient,
  FMX.Graphics;

type
  TBitmapHelper = class helper for TBitmap
  public
    procedure LoadFromUrl(AUrl: string);overload;
    procedure LoadFromUrl(AUrl: string; ADone: Boolean);overload;
    procedure LoadThumbnailFromUrl(AUrl: string; const AFitWidth, AFitHeight: Integer);
  end;

implementation

uses
  System.SysUtils, System.Types, IdHttp, IdTCPClient, uAnonThread;

procedure TBitmapHelper.LoadFromUrl(AUrl: string);
var
  _Thread: TAnonymousThread<tmemorystream>;
begin
  _Thread := TAnonymousThread<tmemorystream>.Create(
    function: TMemoryStream
    var
      Http: THttpClient;
    begin
      Result := TMemoryStream.Create;
      //Http := TIdHttp.Create(nil);
      Http := THTTPClient.Create;
      Http.ContentType := 'text/html';
      try
        try
          Http.Get(AUrl, Result);
        except
          Result.Free;
        end;
      finally
        Http.Free;
      end;
    end,
    procedure(AResult: TMemoryStream)
    begin
      if AResult.Size > 0 then
        TThread.Synchronize(TThread.CurrentThread, procedure begin
          LoadFromStream(AResult);
        end);
      AResult.Free;
    end,
    procedure(AException: Exception)
    begin
    end
  );
end;

procedure TBitmapHelper.LoadFromUrl(AUrl: string; ADone: Boolean);
var
  _Thread      : TAnonymousThread<tmemorystream>;

begin
  _Thread := TAnonymousThread<tmemorystream>.Create(
    function: TMemoryStream
    var
      Http: TIdHttp;
      vHttpClient  : THttpClient;
    begin
      Result := TMemoryStream.Create;
      vHttpClient := THTTPClient.Create;
      vHttpClient.ContentType := 'text/html';

      //Http := TIdHttp.Create(nil);

      try
        try
          vHttpClient.Get(AUrl, Result);
          //Http.Get(AUrl, Result);
        except
          Result.Free;
        end;
      finally
        vHttpClient.Free;
        //Http.Free;
      end;
    end,
    procedure(AResult: TMemoryStream)
    begin
      if AResult.Size > 0 then
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          LoadFromStream(AResult);
        end);
      AResult.Free;
    end,
    procedure(AException: Exception)
    begin
    end
  );

end;

procedure TBitmapHelper.LoadThumbnailFromUrl(AUrl: string; const AFitWidth,
  AFitHeight: Integer);
var
  Bitmap: TBitmap;
  scale: Single;
begin
  LoadFromUrl(AUrl);
  scale := RectF(0, 0, Width, Height).Fit(RectF(0, 0, AFitWidth, AFitHeight));
  Bitmap := CreateThumbnail(Round(Width / scale), Round(Height / scale));
  try
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

end.
