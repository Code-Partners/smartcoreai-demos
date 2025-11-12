unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  SmartCoreAI.Comp.Connection, SmartCoreAI.Types, SmartCoreAI.Driver.OpenAI,
  SmartCoreAI.Comp.Chat, Vcl.WinXCtrls, Web.HTTPApp, Web.HTTPProd, Web.DSProd;

type
  TForm3 = class(TForm)
    EmployeeConnection: TFDConnection;
    CustomerTable: TFDQuery;
    srcCustomer: TDataSource;
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    SalesTable: TFDQuery;
    DBGrid2: TDBGrid;
    srcSales: TDataSource;
    AIOpenAIDriver1: TAIOpenAIDriver;
    AIConnection1: TAIConnection;
    AIChatRequest1: TAIChatRequest;
    ActivityIndicator1: TActivityIndicator;
    DataSetPageProducer1: TDataSetPageProducer;
    lblSummary: TLabel;
    procedure AIOpenAIDriver1Cancel(Sender: TObject; const RequestId: TGUID);
    procedure FormShow(Sender: TObject);
    procedure AIChatRequest1Error(Sender: TObject; const ErrorMessage: string);
    procedure AIChatRequest1Response(Sender: TObject; const Text: string);
    procedure CustomerTableAfterScroll(DataSet: TDataSet);
  private
    FLastRequestId: TGUID;
    procedure ActivityMonitor(const AStatus: Boolean);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.ActivityMonitor(const AStatus: Boolean);
begin
  ActivityIndicator1.Animate := AStatus;
  ActivityIndicator1.Visible := AStatus;
end;

procedure TForm3.AIChatRequest1Error(Sender: TObject;
  const ErrorMessage: string);
begin
  ActivityMonitor(False);
end;

procedure TForm3.AIChatRequest1Response(Sender: TObject; const Text: string);
begin
  ActivityMonitor(False);
  lblSummary.Caption := Text;
end;

procedure TForm3.AIOpenAIDriver1Cancel(Sender: TObject; const RequestId: TGUID);
begin
  ActivityMonitor(False);
  FLastRequestId := Tguid.Empty;
end;

procedure TForm3.CustomerTableAfterScroll(DataSet: TDataSet);
begin
  // Request a summary for the current record
  lblSummary.Caption := '';
  ActivityMonitor(True);
  FLastRequestId := AIChatRequest1.Chat(DataSetPageProducer1.Content);
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  ActivityMonitor(False);
end;

end.
