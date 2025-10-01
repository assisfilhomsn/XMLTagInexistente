unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Xml.XMLDoc, Xml.XMLIntf;

type
  TfrmPrincipal = class(TForm)
    Memo1: TMemo;
    btnProcuraXML: TButton;
    FileOpenDialog1: TFileOpenDialog;
    edtTag: TEdit;
    Label1: TLabel;
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
  Arquivo  : string;
  XML      : IXMLDocument;
  PastaXML : string;
  Contador : Integer;

begin
  Contador := 0;
  Memo1.Clear;

  if FileOpenDialog1.Execute then
    PastaXML := FileOpenDialog1.FileName;

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
  end;
  Memo1.Lines.Add('-----['+IntToStr(Contador) +' Arquivos Processados]-------------------------');
  edtTag.TextHint := 'Digite o Nome da Tag sem <>';
end;

end.
