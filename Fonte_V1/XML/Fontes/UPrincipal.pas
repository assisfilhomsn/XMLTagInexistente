unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Xml.XMLDoc, Xml.XMLIntf, Vcl.ComCtrls;



type
  TfrmPrincipal = class(TForm)
    Memo1: TMemo;
    btnProcuraXML: TButton;
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

uses
  System.Types;

type
  TProcuraXMLThread = class(TThread)
  private
    FMemo: TMemo;
    FProgressBar: TProgressBar;
    FPastaXML: string;
    FTotal: Integer;
    procedure AddToMemo(const Texto: string);
    procedure UpdateProgress(Posicao: Integer);
  protected
    procedure Execute; override;
  public
    constructor Create(AMemo: TMemo; AProgressBar: TProgressBar; const Pasta: string);
  end;

{ TProcuraXMLThread }

function NodeExistsRecursive(Node: IXMLNode; const NodeName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if Node = nil then Exit;

  if SameText(Node.NodeName, NodeName) then
    Exit(True);

  for I := 0 to Node.ChildNodes.Count - 1 do
    if NodeExistsRecursive(Node.ChildNodes[I], NodeName) then
      Exit(True);
end;

constructor TProcuraXMLThread.Create(AMemo: TMemo; AProgressBar: TProgressBar; const Pasta: string);
begin
  inherited Create(False); // Já inicia executando
  FreeOnTerminate := True;
  FMemo := AMemo;
  FProgressBar := AProgressBar;
  FPastaXML := Pasta;
end;

procedure TProcuraXMLThread.AddToMemo(const Texto: string);
begin
  FMemo.Lines.Add(Texto);
end;

procedure TProcuraXMLThread.UpdateProgress(Posicao: Integer);
begin
  FProgressBar.Position := Posicao;
end;

procedure TProcuraXMLThread.Execute;
var
  LArquivo: string;
  ListaArquivos: TStringDynArray;
  XML: IXMLDocument;
  Count: Integer;
  LBaseName: string;
begin
  ListaArquivos := TDirectory.GetFiles(FPastaXML, '*.xml');
  FTotal := Length(ListaArquivos);
  Count := 0;

  // Inicializa ProgressBar e Memo na UI
  Synchronize(
    procedure
    begin
      FProgressBar.Min := 0;
      FProgressBar.Max := FTotal;
      FProgressBar.Position := 0;
      FMemo.Clear;
    end
  );

  for LArquivo in ListaArquivos do
  begin
    try
      XML := TXMLDocument.Create(nil);
      XML.LoadFromFile(LArquivo);
      XML.Active := True;

      if not NodeExistsRecursive(XML.DocumentElement, 'nProt') then
      begin
        LBaseName := ExtractFileName(LArquivo); // calcula fora do Synchronize
        Synchronize(
          procedure
          begin
            FMemo.Lines.Add(LBaseName);
          end
        );
      end;

    except
      LBaseName := ExtractFileName(LArquivo); // idem para erro
      Synchronize(
        procedure
        begin
          FMemo.Lines.Add('ERRO ao ler: ' + LBaseName);
        end
      );
    end;

    Inc(Count);
    Synchronize(
      procedure
      begin
        FProgressBar.Position := Count;
      end
    );
  end;
end;



{$R *.dfm}

{
procedure TfrmPrincipal.btnProcuraXMLClick(Sender: TObject);
var
  Arquivo: string;
  XML: IXMLDocument;
  PastaXML: string;
begin
  Memo1.Clear;
  //PastaXML := 'C:\MeusXMLs';
  PastaXML := 'F:\MegaSys\GODOI_PULO_SEQUENCIA\teste';

  for Arquivo in TDirectory.GetFiles(PastaXML, '*.xml') do
  begin
    try
      XML := TXMLDocument.Create(nil);
      XML.LoadFromFile(Arquivo);
      XML.Active := True;

      if not NodeExistsRecursive(XML.DocumentElement, 'nProt') then
        Memo1.Lines.Add(ExtractFileName(Arquivo));

    except
      Memo1.Lines.Add('ERRO ao ler: ' + ExtractFileName(Arquivo));
    end;
  end;
  ShowMessage('Fim do Processamento!!!');
end;
}

procedure TfrmPrincipal.btnProcuraXMLClick(Sender: TObject);
begin
  TProcuraXMLThread.Create(Memo1, ProgressBar1, 'F:\MegaSys\GODOI_PULO_SEQUENCIA\teste');
end;

end.
