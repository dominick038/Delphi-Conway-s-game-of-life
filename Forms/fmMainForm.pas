unit fmMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Skia, Vcl.Skia,
  System.Types, Vcl.StdCtrls;

type
  TLifeGrid = array[1..30, 1..30] of Boolean;

  TMainForm = class(TForm)
    SimulationTimer: TTimer;
    SkiaPaintBox: TSkPaintBox;
    lblGenerationCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SimulationTimerTimer(Sender: TObject);
    procedure SkiaPaintBoxDraw(ASender: TObject; const ACanvas: ISkCanvas; const ADest: TRectF; const AOpacity: Single);

  private
    FRunning: Boolean;
    FLifeGrid: TLifeGrid;
    FGenerationCount: Integer;

    procedure DoEvolutionStep;
    procedure PauseProc;
    procedure GenerateLifeGrid;
    function CountNeighbors(Row, Col: Integer): Integer;

  end;

var
  MainForm: TMainForm;

implementation

uses
  System.Math,
  System.UITypes;

{$R *.dfm}

function TMainForm.CountNeighbors(Row, Col: Integer): Integer;
const
  NeighborOffsets: array[1..8] of TPoint = (
    (X: -1; Y: -1),  // Top-Left
    (X: -1; Y:  0),  // Top
    (X: -1; Y:  1),  // Top-Right
    (X:  0; Y: -1),  // Left
    (X:  0; Y:  1),  // Right
    (X:  1; Y: -1),  // Bottom-Left
    (X:  1; Y:  0),  // Bottom
    (X:  1; Y:  1)   // Bottom-Right
  );
begin
  Result := 0;

  for var I := 1 to 8 do
  begin
    var NeighborRow := Row + NeighborOffsets[I].X;
    var NeighborCol := Col + NeighborOffsets[I].Y;

    if NeighborRow < 1 then
      NeighborRow := 30
    else if NeighborRow > 30 then
      NeighborRow := 1;

    if NeighborCol < 1 then
      NeighborCol := 30
    else if NeighborCol > 30 then
      NeighborCol := 1;

    if FLifeGrid[NeighborRow, NeighborCol] then
      Inc(Result);
  end;
end;

procedure TMainForm.DoEvolutionStep;
begin
  var NewGrid := FLifeGrid;
  for var I := 1 to 30 do
  begin
    for var J := 1 to 30 do
    begin
      var NeighbourAmount := CountNeighbors(I, J);
      if NeighbourAmount < 2 then
        NewGrid[I][J] := False
      else if NeighbourAmount > 3 then
        NewGrid[I][J] := False
      else if (NeighbourAmount = 3) or ((NeighbourAmount = 2) and FLifeGrid[I][J]) then
        NewGrid[I][J] := True;
    end;
  end;

  FLifeGrid := NewGrid;
  SkiaPaintBox.Redraw;

  Inc(FGenerationCount);
  lblGenerationCount.Caption := Format('Generation: %d', [FGenerationCount]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  FRunning := True;
  GenerateLifeGrid;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FRunning := False;
  inherited;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  R_KEY = Ord('R');
begin
  case Key of
    VK_SPACE: PauseProc;

    VK_RIGHT:
      if not FRunning then
        DoEvolutionStep;

    R_KEY:
    begin
      if not FRunning then
        GenerateLifeGrid;
      FGenerationCount := 0;
      lblGenerationCount.Caption := Format('Generation: %d', [FGenerationCount]);
      SkiaPaintBox.Redraw;
    end;

  end;
end;

procedure TMainForm.PauseProc;
begin
  FRunning := not FRunning;
end;

procedure TMainForm.GenerateLifeGrid;
begin
  for var i := 1 to 30 do
  begin
    for var J := 1 to 30 do
    begin
      var WillBeAlive := Random(100);
      if 10 > WillBeAlive then
        FLifeGrid[i][j] := True
      else
        FLifeGrid[i][j] := False;
    end;
  end;
end;

procedure TMainForm.SimulationTimerTimer(Sender: TObject);
begin
  if FRunning then
    DoEvolutionStep;
end;

procedure TMainForm.SkiaPaintBoxDraw(ASender: TObject; const ACanvas: ISkCanvas; const ADest: TRectF; const AOpacity: Single);
begin
  var Paint: ISkPaint := TSkPaint.Create;
  Paint.AntiAlias := true;

  Paint.Color := TAlphaColors.Black;
  var BgRect := TRectF.Create(PointF(0, 0), 900, 900);
  ACanvas.DrawRect(BgRect, Paint);

  Paint.Color := TAlphaColors.White;
  for var Row := 1 to 30 do
  begin
    for var Col := 1 to 30 do
    begin
      if FLifeGrid[Row, Col] then
      begin
        var X := (Col - 1) * 30;
        var Y := (Row - 1) * 30;

        var CellRect := TRectF.Create(X, Y, X + 30, Y + 30);;
        ACanvas.DrawRect(CellRect, Paint);
      end;
    end;
  end;
end;

end.
