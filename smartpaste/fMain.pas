unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  SmartCoreAI.Comp.Connection, System.JSON, SmartCoreAI.Comp.JSON,
  SmartCoreAI.Types, SmartCoreAI.Driver.OpenAI, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCtrls, SmartCoreAI.Consts;



type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    edtFirstname: TEdit;
    edtLastname: TEdit;
    edtPhone: TEdit;
    edtAddressLine1: TEdit;
    edtEmail: TEdit;
    edtAddressLine2: TEdit;
    edtCity: TEdit;
    edtState: TEdit;
    edtPostcode: TEdit;
    edtCountry: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    AIConnection1: TAIConnection;
    AIOpenAIDriver1: TAIOpenAIDriver;
    AIJSONRequest1: TAIJSONRequest;
    FDMemTable1: TFDMemTable;
    ActivityIndicator1: TActivityIndicator;
    procedure AIOpenAIDriver1Cancel(Sender: TObject; const RequestId: TGUID);
    procedure AIJSONRequest1Error(Sender: TObject; const ErrorMessage: string);
    procedure AIJSONRequest1Success(Sender: TObject; const Response: string);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FLastRequestId: TGUID;
    procedure ActivityMonitor(const AStatus: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  Clipbrd;

{$R *.dfm}

procedure TForm1.ActivityMonitor(const AStatus: Boolean);
begin
  ActivityIndicator1.Animate := AStatus;
  ActivityIndicator1.Visible := AStatus;
end;

procedure TForm1.AIJSONRequest1Error(Sender: TObject;
  const ErrorMessage: string);
begin
  ActivityMonitor(False);
end;

procedure TForm1.AIJSONRequest1Success(Sender: TObject; const Response: string);
var
  LResponse : TJSONObject;
  LValues : TJSONObject;
  LText : String;
begin
  ActivityMonitor(False);
  LResponse := TJSONObject.ParseJSONValue(Response) as TJSONObject;
  try
    LText := LResponse.FindValue('output[0].content[0].text').ToString;
    // clean up the string crud
    LText := StringReplace(LText,  '\n', '', [rfReplaceAll]);
    LText := StringReplace(LText,  '\"', '"', [rfReplaceAll]);
    LText := StringReplace(LText,  '}"', '}', [rfReplaceAll]);
    LText := StringReplace(LText,  '"{', '{', [rfReplaceAll]);
    LValues := TJSONObject.ParseJSONValue(LText) as TJSONObject;
    try
      edtFirstname.Text := StringReplace(LValues.FindValue('Firstname').ToString, '"', '', [rfReplaceAll]);
      edtLastname.Text := StringReplace(LValues.FindValue('Lastname').ToString, '"', '', [rfReplaceAll]);
      edtEmail.Text := StringReplace(LValues.FindValue('Email').ToString, '"', '', [rfReplaceAll]);
      edtPhone.Text := StringReplace(LValues.FindValue('Phone').ToString, '"', '', [rfReplaceAll]);
      edtAddressLine1.Text := StringReplace(LValues.FindValue('Address Line 1').ToString, '"', '', [rfReplaceAll]);
      edtAddressLine2.Text := StringReplace(LValues.FindValue('Address Line 2').ToString, '"', '', [rfReplaceAll]);
      edtCity.Text := StringReplace(LValues.FindValue('City').ToString, '"', '', [rfReplaceAll]);
      edtState.Text := StringReplace(LValues.FindValue('State').ToString, '"', '', [rfReplaceAll]);
      edtPostcode.Text := StringReplace(LValues.FindValue('Postcode').ToString, '"', '', [rfReplaceAll]);
      edtCountry.Text := StringReplace(LValues.FindValue('Country').ToString, '"', '', [rfReplaceAll]);
    finally
      LValues.Free;
    end;
  finally
    LResponse.Free;
  end;
end;

procedure TForm1.AIOpenAIDriver1Cancel(Sender: TObject; const RequestId: TGUID);
begin
  ActivityMonitor(False);
  FLastRequestId := Tguid.Empty;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LParams: TJSONObject;
begin
    ActivityMonitor(True);
    // build request
    LParams := TJSONObject.Create;
    try
      try
        LParams.AddPair('model', TAIOpenAIParams(AIOpenAIDriver1.Params).Model)
             .AddPair('text', TJSONObject.Create.AddPair('format', TJSONObject.Create.AddPair('type', 'json_object')))
             .AddPair('input',
                      '''
                      Respond with a JSON array with ONLY the following keys.
                      For each key, infer a value from USER_DATA:
                      {Firstname,Lastname,Email,Phone,Address Line 1,Address Line 2,City,State,Postcode,Country}
                      Do not explain how the values were determined.
                      For fields without any corresponding information in USER_DATA, use an empty value.
                      USER_DATA: {
                      ''' + Clipboard.AsText + '}');
        AIJSONRequest1.Params := LParams.ToJSON;
        AIJSONRequest1.Endpoint := cOpenAI_ResponsesEndPoint;

        FLastRequestId := AIJSONRequest1.Execute;
      except
        on E: Exception do
          ActivityMonitor(False);
      end;
    finally
      LParams.Free;
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ActivityMonitor(False);
end;

end.
