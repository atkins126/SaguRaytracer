program Raytracer;

{$APPTYPE CONSOLE}

uses
  sysutils,
  dateutils,
  uimageppmexporter in 'src\uimageppmexporter.pas',
  uraytracer in 'src\uraytracer.pas',
  uscene in 'src\uscene.pas',
  usceneelements in 'src\usceneelements.pas',
  uvectortypes in 'src\uvectortypes.pas',
  uviewer in 'src\uviewer.pas',
  udelphisceneloader in 'src\udelphisceneloader.pas',
  ubaselist in 'src\ubaselist.pas',
  usceneelementlists in 'src\usceneelementlists.pas';

var
  AViewer: TViewer;
  AScene: TScene;
  AStart, AEnd: TTime;

begin
  //                 Normal    Inline functions
  //    480, 640   = ~420;   //281
  //    768, 1024  = ~1190;
  //    720, 1280  = ~1140   //
  //    768, 1366  = ~1320
  //    1080, 1920 = ~2590
  //    1500, 2000 = ~4560
  //    2160, 3840 = ~10190  //
  //    3000, 4000 = ~18150; //10850

  //TODO:
  //1 - Memory leaks

  AScene := TSceneLoader.Build('scene.json');
  try
    AViewer := TViewer.Create(AScene.Camera);
    try
      ////////////////////////////////////////////////////////////////////////////

        AStart := now;
        TRaytracer.Render(AViewer, AScene);
        AEnd := now;

      ////////////////////////////////////////////////////////////////////////////

      TImagePPMExporter.ExportToFile(AViewer, 'render.ppm');
      //AViewer.SaveToBitmap('render.bmp');
    finally
      AViewer.Free;
    end;
  finally
    AScene.Free;
  end;

  writeln('Done ' + MillisecondsBetween(AStart, AEnd).ToString + ' ms');
  readln;
end.

