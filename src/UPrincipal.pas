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
    Label2: TLabel;
    lblTotalCupom: TLabel;
    Label4: TLabel;
    lblQtdeSemProtocolo: TLabel;
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

function SomaTag(pTag: IXMLNode; const TagNome: string): Double;
var
  I: Integer;
begin
  Result := 0;

  if pTag = nil then
    Exit;

  if SameText(pTag.NodeName, TagNome) then
    Result := StrToFloatDef(StringReplace(pTag.Text,'.',',',[rfReplaceAll]),0);

  for I := 0 to pTag.ChildNodes.Count - 1 do
    Result := Result + SomaTag(pTag.ChildNodes[I], TagNome);
end;

function GetTagValue(pTag: IXMLNode; const TagNome: string): string;
var
  I: Integer;
  Valor: string;
begin
  Result := '';
  if pTag = nil then Exit;

  if SameText(pTag.NodeName, TagNome) then
    Exit(pTag.Text);

  for I := 0 to pTag.ChildNodes.Count - 1 do
  begin
    Valor := GetTagValue(pTag.ChildNodes[I], TagNome);
    if Valor <> '' then
      Exit(Valor);
  end;
end;


function SomaItensNFCE(XML: IXMLDocument): Double;
var
  NodeDet, NodeProd: IXMLNode;
  i: Integer;
  qCom, vUnCom: Double;
begin
  Result := 0;

  NodeDet := XML.DocumentElement;

  // percorre todo XML procurando <det>
  for i := 0 to NodeDet.ChildNodes.Count - 1 do
  begin
    if SameText(NodeDet.ChildNodes[i].NodeName, 'NFe') then
      NodeDet := NodeDet.ChildNodes[i];
  end;

  NodeDet := NodeDet.ChildNodes.FindNode('infNFe');

  for i := 0 to NodeDet.ChildNodes.Count - 1 do
  begin
    if SameText(NodeDet.ChildNodes[i].NodeName, 'det') then
    begin
      NodeProd := NodeDet.ChildNodes[i].ChildNodes.FindNode('prod');

      if Assigned(NodeProd) then
      begin
        qCom := StrToFloatDef(StringReplace(NodeProd.ChildNodes['qCom'].Text,'.',',',[rfReplaceAll]),0);
        vUnCom := StrToFloatDef(StringReplace(NodeProd.ChildNodes['vUnCom'].Text,'.',',',[rfReplaceAll]),0);

        Result := Result + (qCom * vUnCom);
      end;
    end;
  end;
end;

function GetvNF(XML: IXMLDocument): Double;
var
  Node: IXMLNode;
begin
  Result := 0;

  Node := XML.DocumentElement
            .ChildNodes.FindNode('NFe')
            .ChildNodes.FindNode('infNFe')
            .ChildNodes.FindNode('total')
            .ChildNodes.FindNode('ICMSTot')
            .ChildNodes.FindNode('vNF');

  if Assigned(Node) then
    Result := StrToFloatDef(StringReplace(Node.Text,'.',',',[rfReplaceAll]),0);
end;


procedure TfrmPrincipal.btnProcuraXMLClick(Sender: TObject);
var
  XML      : IXMLDocument;
  PastaXML : string;
  t: TThread;
  QtdeArquivos : TArray<string>;

  vItem : Double;

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
    TotalVPag: Double;

  Begin
    Contador    := 0;
    Processados := 0;
    TotalVPag   := 0;


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
      lblQtdeProcessados.Caption  := IntToStr(Processados);
      lblTotalCupom.Caption       := FormatFloat(',##0.00', TotalVPag);  //FloatToStr(TotalVPag);
      lblQtdeSemProtocolo.Caption := IntToStr(Contador);
      ProgressBar1.Position       := Processados;
    end;
    Memo1.Lines.Add('-----['+IntToStr(Contador) +' Arquivo(s) Encontrado(s)]-------------------------');
  End);
  t.Start;
end;

end.
