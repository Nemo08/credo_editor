object OKBottomDlg: TOKBottomDlg
  Left = 587
  Top = 113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 101
  ClientWidth = 367
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 353
    Height = 88
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 25
    Top = 25
    Width = 3
    Height = 13
  end
  object OKBtn: TButton
    Left = 274
    Top = 50
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object Edit1: TEdit
    Left = 25
    Top = 50
    Width = 236
    Height = 21
    TabOrder = 1
  end
end
