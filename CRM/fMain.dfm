object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Customer Summary Demo'
  ClientHeight = 447
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Padding.Left = 4
  Padding.Top = 4
  Padding.Right = 4
  Padding.Bottom = 4
  OnShow = FormShow
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 4
    Top = 41
    Width = 329
    Height = 402
    Align = alLeft
    DataSource = srcCustomer
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object ToolBar1: TToolBar
    Left = 4
    Top = 4
    Width = 793
    Height = 37
    ButtonHeight = 44
    Caption = 'ToolBar1'
    TabOrder = 1
    ExplicitWidth = 783
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 240
      Height = 44
      DataSource = srcCustomer
      Align = alLeft
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 333
    Top = 41
    Width = 464
    Height = 402
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 4
    Padding.Top = 4
    Padding.Right = 4
    Padding.Bottom = 4
    TabOrder = 2
    ExplicitWidth = 454
    ExplicitHeight = 370
    object GroupBox1: TGroupBox
      Left = 4
      Top = 4
      Width = 456
      Height = 105
      Align = alTop
      Caption = 'Summary'
      Padding.Left = 4
      Padding.Top = 4
      Padding.Right = 4
      Padding.Bottom = 4
      TabOrder = 0
      ExplicitWidth = 446
      object lblSummary: TLabel
        Left = 6
        Top = 21
        Width = 444
        Height = 78
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        WordWrap = True
        ExplicitLeft = 5
        ExplicitWidth = 447
        ExplicitHeight = 79
      end
    end
    object GroupBox2: TGroupBox
      Left = 4
      Top = 109
      Width = 456
      Height = 289
      Align = alClient
      Caption = 'Order History'
      Padding.Left = 4
      Padding.Top = 4
      Padding.Right = 4
      Padding.Bottom = 4
      TabOrder = 1
      ExplicitWidth = 446
      ExplicitHeight = 257
      object DBGrid2: TDBGrid
        Left = 6
        Top = 21
        Width = 444
        Height = 262
        Align = alClient
        DataSource = srcSales
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 560
    Top = 88
  end
  object EmployeeConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    Connected = True
    LoginPrompt = False
    Left = 102
    Top = 162
  end
  object CustomerTable: TFDQuery
    Active = True
    AfterScroll = CustomerTableAfterScroll
    Connection = EmployeeConnection
    SQL.Strings = (
      'SELECT * FROM CUSTOMER')
    Left = 102
    Top = 274
  end
  object srcCustomer: TDataSource
    DataSet = CustomerTable
    Left = 368
    Top = 544
  end
  object SalesTable: TFDQuery
    Active = True
    IndexFieldNames = 'CUST_NO'
    MasterSource = srcCustomer
    MasterFields = 'CUST_NO'
    Connection = EmployeeConnection
    SQL.Strings = (
      'SELECT * FROM SALES')
    Left = 200
    Top = 688
  end
  object srcSales: TDataSource
    DataSet = SalesTable
    Left = 368
    Top = 688
  end
  object AIOpenAIDriver1: TAIOpenAIDriver
    Params.Strings = (
      'Model=gpt-4o-mini')
    OnCancel = AIOpenAIDriver1Cancel
    Left = 256
    Top = 32
  end
  object AIConnection1: TAIConnection
    Driver = AIOpenAIDriver1
    Left = 80
    Top = 32
  end
  object AIChatRequest1: TAIChatRequest
    Connection = AIConnection1
    OnResponse = AIChatRequest1Response
    OnError = AIChatRequest1Error
    Left = 80
    Top = 176
  end
  object DataSetPageProducer1: TDataSetPageProducer
    HTMLDoc.Strings = (
      
        'Create a brief summary of the following customer, to be used as ' +
        'a quick reference for a sales agent. '
      
        'Don'#39't just repeat what is in the record, but be sure to highligh' +
        't if they are On Hold or not. '
      
        'If they are On Hold, this should be very prominent in the summar' +
        'y, so that the sales agent cannot miss it. '
      'Use capitalisation to highlight the on hold status.'
      'Only return the summary, no titles or anything else. '
      ''
      'CUSTOMER: <#CUSTOMER>'
      'CONTACT_FIRST: <#CONTACT_FIRST> '
      'CONTACT_LAST: <#CONTACT_LAST>'
      'PHONE_NO: <#PHONE_NO>'
      'CITY: <#CITY>'
      'ON_HOLD: <#ON_HOLD>')
    DataSet = CustomerTable
    Left = 304
    Top = 192
  end
end
