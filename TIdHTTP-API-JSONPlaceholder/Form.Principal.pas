unit Form.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ExtCtrls,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Vcl.Grids, Vcl.DBGrids, System.JSON, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    IdHTTP1: TIdHTTP;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FDMemTable1id: TIntegerField;
    FDMemTable1title: TStringField;
    FDMemTable1body: TStringField;
    PopupMenu1: TPopupMenu;
    LimparGrid1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure JsonToDataSet(aDataset: TDataSet; aJSON: string);
    procedure LimparGrid1Click(Sender: TObject);
  private
    procedure IdHTTpGET;
    procedure RestClientGet;
    const UrlGET = 'http://jsonplaceholder.typicode.com/posts';
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  FDMemTable1.Close;
  FDMemTable1.Open;

  if RadioGroup1.ItemIndex = 0 then
  begin
    IdHTTpGET;
  end
  else
  begin
    if RadioGroup1.ItemIndex = 1 then
    begin
      RestClientGet;
    end;
  end;
end;

procedure TfrmPrincipal.IdHTTpGET;
var
  Response: string;
begin
  try
    // Faça uma solicitação GET para obter a lista de posts da API JSONPlaceholder
    Response := IdHTTP1.Get(UrlGET);
    JsonToDataSet(FDMemTable1, Response);
    // Exiba a resposta no Memo
    //Memo1.Lines.Text := Response;
  except
    on E: Exception do
      ShowMessage('Erro ao fazer solicitação: ' + E.Message);
  end;
end;

procedure TfrmPrincipal.JsonToDataSet(aDataset: TDataSet; aJSON: string);
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TfrmPrincipal.LimparGrid1Click(Sender: TObject);
begin
  FDMemTable1.Close;
  FDMemTable1.Open;
  FDMemTable1.Refresh;
end;

procedure TfrmPrincipal.RestClientGet;
begin
  //Configurar o método, endpoint e parâmetros, se necessário
  //RESTRequest1.Method := rmGET;
  RESTClient1.BaseURL := UrlGET;
  // Executar a solicitação
  try
    RESTRequest1.Execute;
    // Processar a resposta
    if RESTResponse1.StatusCode = 200 then
    begin
      // A resposta foi bem-sucedida
      // Você pode acessar os dados da resposta em RESTResponse1.Content
      JsonToDataSet(FDMemTable1, RESTRequest1.Response.JSONText);
      //Memo1.Lines.Text := RESTResponse1.Content;
      //Memo1.Lines.Add(RESTRequest1.Response.JSONText);
    end
    else
    begin
      // A solicitação falhou com o código de status RESTResponse1.StatusCode
      ShowMessage('Erro ao fazer solicitação: ' + IntToStr(RESTResponse1.StatusCode));
    end;
  except
    on E: Exception do
    begin
      // Lidar com exceções, se houver
      ShowMessage('Erro: ' + E.Message);
    end;
  end;
end;

end.
