object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 526
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 12
    Top = 11
    Width = 54
    Height = 17
    Caption = 'Tag XML'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 79
    Width = 608
    Height = 442
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnProcuraXML: TButton
    Left = 8
    Top = 41
    Width = 608
    Height = 33
    Caption = 'Ler Arquivos XML'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Roboto Bk'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnProcuraXMLClick
  end
  object edtTag: TEdit
    Left = 80
    Top = 8
    Width = 217
    Height = 23
    TabOrder = 2
    TextHint = 'Digite o Nome da Tag sem <>'
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 552
    Top = 56
  end
end
