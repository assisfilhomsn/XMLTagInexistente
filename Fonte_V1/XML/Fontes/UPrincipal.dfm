object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Memo1: TMemo
    Left = 8
    Top = 39
    Width = 608
    Height = 394
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object btnProcuraXML: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Verificar XML'
    TabOrder = 1
    OnClick = btnProcuraXMLClick
  end
  object ProgressBar1: TProgressBar
    Left = 456
    Top = 8
    Width = 150
    Height = 17
    TabOrder = 2
  end
end
