<p align="center">
  <a href="https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/logo.png">
    <img alt="LoadPhotoFromURL" src="https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/logo.png">
  </a>  
</p>

# LoadPhotoFromURL
This class was built to make it easy to load images and thumbnails using the file's URL.

## Installation
Just register in the Library Path of your Delphi the path of the SOURCE folder of the library, or if you prefer, you can use Boss (dependency manager for Delphi) to perform the installation:
```
boss install github.com/adrianosantostreina/LoadPhotoFromURL
```

## Use
Declare uBitmapHelper in the Uses section of the unit where you want to make the call to the class's method.
```delphi
uses
   uBitmapHelper;
```
Then, just add a component of type TImage to the form or create a variable of this type if you wish.

## Loading a full-size image
```delphi
procedure TForm5.Button1Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg');
end;
```

## Loading an image thumbnail
```delphi
procedure TForm5.Button2Click(Sender: TObject);
begin
  Image1.Bitmap := nil;
  Image1.Bitmap.LoadThumbnailFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg', 50, 50);
end;
```

## Loading multiple images at the same time
* Create a list of URL's
```delphi
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
            //
            case I of
              1: Image2.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno1.jpg');
              0: Image1.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno2.jpg');
              2: Image3.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno3.jpg');
              3: Image4.Bitmap.LoadFromUrl('https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/image/mizuno4.jpg');
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
```
## Documentation Languages
[English (en)](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/README.md)<br>
[Português (ptBR)](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/README-ptBR.md)<br>

## ⚠️ License
`LoadPhotoFromURL` is free and open-source library licensed under the [MIT License](https://github.com/adrianosantostreina/LoadPhotoFromURL/blob/main/LICENSE.md). 
