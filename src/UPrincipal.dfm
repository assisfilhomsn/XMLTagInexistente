object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'XML <Tag> Inexistente'
  ClientHeight = 574
  ClientWidth = 732
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
  object lblTotalXMLDescricao: TLabel
    Left = 8
    Top = 80
    Width = 168
    Height = 21
    Caption = 'Total de arquivos XML'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 101
    Width = 206
    Height = 21
    Caption = 'Qtde Arquivos Processados...: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblQtdeProcessados: TLabel
    Left = 216
    Top = 101
    Width = 9
    Height = 21
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 162
    Width = 206
    Height = 21
    Caption = 'Valor Total .........................................: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblTotalCupom: TLabel
    Left = 216
    Top = 162
    Width = 9
    Height = 21
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 122
    Width = 206
    Height = 21
    Caption = 'Qtde sem Protocolo ...................: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblQtdeSemProtocolo: TLabel
    Left = 216
    Top = 122
    Width = 9
    Height = 21
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 142
    Width = 206
    Height = 21
    Caption = 'Valor Total Itens..............................: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblTotalItem: TLabel
    Left = 216
    Top = 142
    Width = 9
    Height = 21
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblQtdeArquivosXml: TLabel
    Left = 216
    Top = 80
    Width = 9
    Height = 21
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 189
    Width = 716
    Height = 348
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnProcuraXML: TButton
    Left = 8
    Top = 41
    Width = 716
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
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 543
    Width = 716
    Height = 23
    ParentShowHint = False
    Smooth = True
    ShowHint = False
    TabOrder = 3
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 552
    Top = 56
  end
end
