object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'GaussSeidl'
  ClientHeight = 390
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 224
    Width = 441
    Height = 161
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 756
    Height = 210
    TabOrder = 1
    object Label1: TLabel
      Left = 593
      Top = 19
      Width = 64
      Height = 13
      Caption = 'Ilo'#347#263' iteracji: '
    end
    object Label4: TLabel
      Left = 56
      Top = 0
      Width = 12
      Height = 13
      Caption = 'x1'
    end
    object Label5: TLabel
      Left = 120
      Top = 0
      Width = 12
      Height = 13
      Caption = 'x2'
    end
    object Label6: TLabel
      Left = 184
      Top = 0
      Width = 12
      Height = 13
      Caption = 'x3'
    end
    object Label7: TLabel
      Left = 248
      Top = 0
      Width = 12
      Height = 13
      Caption = 'x4'
    end
    object Label9: TLabel
      Left = 479
      Top = 0
      Width = 5
      Height = 13
      Caption = 's'
    end
    object Label10: TLabel
      Left = 3
      Top = 19
      Width = 23
      Height = 13
      Caption = 'y1 ='
    end
    object Label11: TLabel
      Left = 3
      Top = 43
      Width = 23
      Height = 23
      Caption = 'y2 ='
    end
    object Label12: TLabel
      Left = 3
      Top = 72
      Width = 26
      Height = 13
      Caption = 'y3 = '
    end
    object Label13: TLabel
      Left = 3
      Top = 98
      Width = 23
      Height = 13
      Caption = 'y4 ='
    end
    object StringGrid1: TStringGrid
      Left = 32
      Top = 19
      Width = 409
      Height = 183
      BevelOuter = bvNone
      Ctl3D = True
      FixedColor = clWhite
      RowCount = 7
      GradientEndColor = clMedGray
      ParentCtl3D = False
      TabOrder = 0
      RowHeights = (
        24
        24
        24
        24
        24
        24
        24)
    end
    object Edit1: TEdit
      Left = 663
      Top = 16
      Width = 66
      Height = 21
      TabOrder = 1
    end
    object Edit2: TEdit
      Left = 663
      Top = 58
      Width = 66
      Height = 21
      TabOrder = 2
    end
    object Edit3: TEdit
      Left = 663
      Top = 85
      Width = 67
      Height = 21
      TabOrder = 3
    end
    object Button1: TButton
      Left = 560
      Top = 85
      Width = 97
      Height = 25
      Caption = 'Dodaj zmienn'#261' x'
      TabOrder = 4
      OnClick = DodajZmiennaX
    end
    object StringGrid2: TStringGrid
      Left = 447
      Top = 19
      Width = 72
      Height = 183
      ColCount = 1
      FixedCols = 0
      RowCount = 6
      TabOrder = 5
      RowHeights = (
        24
        24
        24
        24
        24
        24)
    end
    object Edit4: TEdit
      Left = 663
      Top = 116
      Width = 67
      Height = 21
      TabOrder = 6
    end
    object Button3: TButton
      Left = 560
      Top = 116
      Width = 97
      Height = 25
      Caption = 'Dodaj zmienn'#261' s'
      TabOrder = 7
      OnClick = DodajZmiennaS
    end
    object Button4: TButton
      Left = 560
      Top = 54
      Width = 97
      Height = 25
      Caption = 'Ilo'#347#263' zmiennych'
      TabOrder = 8
      OnClick = UstawIloscZmiennych
    end
    object Button5: TButton
      Left = 560
      Top = 161
      Width = 97
      Height = 25
      Caption = 'Reset'
      TabOrder = 9
      OnClick = Reset
    end
  end
  object Panel2: TPanel
    Left = 455
    Top = 224
    Width = 309
    Height = 161
    TabOrder = 2
    object Label3: TLabel
      Left = 200
      Top = 18
      Width = 69
      Height = 16
      Caption = 'Arytmetyka:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 40
      Top = 16
      Width = 83
      Height = 16
      Caption = 'Wczytaj Dane:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button2: TButton
      Left = 192
      Top = 56
      Width = 89
      Height = 25
      Caption = 'Normalna'
      TabOrder = 0
      OnClick = SzukajClickNormal
    end
    object Button6: TButton
      Left = 192
      Top = 104
      Width = 89
      Height = 25
      Caption = 'Przedzia'#322'owa'
      TabOrder = 1
      OnClick = SzukajClickInterval
    end
    object Button8: TButton
      Left = 32
      Top = 56
      Width = 97
      Height = 25
      Caption = 'Dane 1'
      TabOrder = 2
      OnClick = WczytaDane1
    end
    object Button9: TButton
      Left = 32
      Top = 104
      Width = 97
      Height = 25
      Caption = 'Dane 2'
      TabOrder = 3
      OnClick = WczytajDane2
    end
  end
end
