object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Conway'#39's game of life'
  ClientHeight = 900
  ClientWidth = 900
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object SkiaPaintBox: TSkPaintBox
    Left = 0
    Top = 0
    Width = 900
    Height = 900
    OnDraw = SkiaPaintBoxDraw
  end
  object lblGenerationCount: TLabel
    Left = 8
    Top = 8
    Width = 134
    Height = 27
    Caption = 'Generation: 0'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Roman'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object SimulationTimer: TTimer
    Interval = 100
    OnTimer = SimulationTimerTimer
    Left = 568
    Top = 32
  end
end
