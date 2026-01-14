unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Xml.XMLDoc, Xml.XMLIntf, Vcl.ComCtrls;

type
  TfrmPrincipal = class(TForm)
    Memo1: TMemo;
    btnProcuraXML: TButton;
    FileOpenDialog1: TFileOpenDialog;
    edtTag: TEdit;
    Label1: TLabel;
    lblQtdeArquivosXml: TLabel;
    Label3: TLabel;
    lblQtdeProcessados: TLabel;
    ProgressBar1: TProgressBar;
    procedure btnProcuraXMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function TagExiste(pTag: IXMLNode; const TagNome: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if pTag = nil then Exit;

  if SameText(pTag.NodeName, TagNome) then
    Exit(True);

  for I := 0 to pTag.ChildNodes.Count - 1 do
    if TagExiste(pTag.ChildNodes[I], TagNome) then
      Exit(True);
end;

procedure TfrmPrincipal.btnProcuraXMLClick(Sender: TObject);
var
  XML      : IXMLDocument;
  PastaXML : string;
  t: TThread;
  QtdeArquivos : TArray<string>;

begin
  edtTag.TextHint := 'Digite o Nome da Tag sem <>';
  if edtTag.Text = '' then
    edtTag.Text := 'nProt';

  if FileOpenDialog1.Execute then
  begin
    PastaXML := FileOpenDialog1.FileName;
    QtdeArquivos := TDirectory.GetFiles(PastaXML,'*.xml',TSearchOption.soTopDirectoryOnly);
    lblQtdeArquivosXml.Caption := Format('Total de arquivos XML: %d', [Length(QtdeArquivos)]);
  end;
  ProgressBar1.Min := 0;
  ProgressBar1.max := Length(QtdeArquivos);

  Memo1.Clear;
  t := TThread.CreateAnonymousThread(Procedure
  var
    Arquivo  : string;
    Contador, Processados : Integer;

  Begin
    Contador    := 0;
    Processados := 0;

    for Arquivo in TDirectory.GetFiles(PastaXML, '*.xml') do
    begin
      try
        XML := TXMLDocument.Create(nil);
        XML.LoadFromFile(Arquivo);
        XML.Active := True;

        //if not TagExiste(XML.DocumentElement, 'nProt') then
        if not TagExiste(XML.DocumentElement, edtTag.Text) then
        begin
          Memo1.Lines.Add(ExtractFileName(Arquivo)+' Sem TAG <'+edtTag.Text+'>');
          inc(Contador);
        end;
      except
        Memo1.Lines.Add('ERRO ao ler: ' + ExtractFileName(Arquivo));
      end;
      inc(Processados);
      lblQtdeProcessados.Caption := IntToStr(Processados);
      ProgressBar1.Position := Processados;
    end;
    Memo1.Lines.Add('-----['+IntToStr(Contador) +' Arquivo(s) Encontrado(s)]-------------------------');
  End);
  t.Start;
end;

end.
