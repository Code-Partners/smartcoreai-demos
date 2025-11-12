object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'SmartPaste Demo'
  ClientHeight = 356
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 677
    Height = 356
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 667
    ExplicitHeight = 324
    object TabSheet1: TTabSheet
      Caption = 'Contact'
      object Label1: TLabel
        Left = 17
        Top = 40
        Width = 55
        Height = 15
        Caption = 'Firstname:'
      end
      object Label2: TLabel
        Left = 17
        Top = 80
        Width = 54
        Height = 15
        Caption = 'Lastname:'
      end
      object Label3: TLabel
        Left = 17
        Top = 120
        Width = 37
        Height = 15
        Caption = 'Phone:'
      end
      object Label4: TLabel
        Left = 17
        Top = 168
        Width = 32
        Height = 15
        Caption = 'Email:'
      end
      object Label5: TLabel
        Left = 368
        Top = 40
        Width = 45
        Height = 15
        Caption = 'Address:'
      end
      object edtFirstname: TEdit
        Left = 78
        Top = 37
        Width = 240
        Height = 23
        TabOrder = 0
        TextHint = 'Firstname'
      end
      object edtLastname: TEdit
        Left = 77
        Top = 77
        Width = 240
        Height = 23
        TabOrder = 1
        TextHint = 'Lastname'
      end
      object edtPhone: TEdit
        Left = 78
        Top = 117
        Width = 240
        Height = 23
        TabOrder = 2
        TextHint = 'Phone'
      end
      object edtAddressLine1: TEdit
        Left = 419
        Top = 37
        Width = 240
        Height = 23
        TabOrder = 3
        TextHint = 'Address Line 1'
      end
      object edtEmail: TEdit
        Left = 77
        Top = 165
        Width = 240
        Height = 23
        TabOrder = 4
        TextHint = 'Email'
      end
      object edtAddressLine2: TEdit
        Left = 419
        Top = 77
        Width = 240
        Height = 23
        TabOrder = 5
        TextHint = 'Address Line 2'
      end
      object edtCity: TEdit
        Left = 419
        Top = 117
        Width = 240
        Height = 23
        TabOrder = 6
        TextHint = 'City'
      end
      object edtState: TEdit
        Left = 419
        Top = 165
        Width = 100
        Height = 23
        TabOrder = 7
        TextHint = 'State'
      end
      object edtPostcode: TEdit
        Left = 536
        Top = 165
        Width = 50
        Height = 23
        TabOrder = 8
        TextHint = 'Postcode'
      end
      object edtCountry: TEdit
        Left = 419
        Top = 208
        Width = 167
        Height = 23
        TabOrder = 9
        TextHint = 'Country'
      end
      object Button1: TButton
        Left = 495
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 10
      end
      object Button2: TButton
        Left = 584
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Cancel'
        TabOrder = 11
      end
      object Button3: TButton
        Left = 17
        Top = 296
        Width = 75
        Height = 25
        Caption = 'Smart Paste'
        TabOrder = 12
        OnClick = Button3Click
      end
    end
  end
  object ActivityIndicator1: TActivityIndicator
    Left = 102
    Top = 319
  end
  object AIConnection1: TAIConnection
    Driver = AIOpenAIDriver1
    Left = 48
    Top = 80
  end
  object AIOpenAIDriver1: TAIOpenAIDriver
    Params.Strings = (
      'Model=gpt-4o-mini')
    OnCancel = AIOpenAIDriver1Cancel
    Left = 224
    Top = 80
  end
  object AIJSONRequest1: TAIJSONRequest
    Connection = AIConnection1
    DataSet = FDMemTable1
    OnSuccess = AIJSONRequest1Success
    OnError = AIJSONRequest1Error
    Left = 48
    Top = 208
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 832
  end
end
