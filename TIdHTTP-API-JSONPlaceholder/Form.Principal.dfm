object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'TIdHTTP  - API JSONPlaceholder'
  ClientHeight = 464
  ClientWidth = 926
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 926
    Height = 398
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'id'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'title'
        Width = 251
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'body'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 398
    Width = 926
    Height = 66
    Align = alBottom
    TabOrder = 1
    object btnConectar: TButton
      Left = 556
      Top = 1
      Width = 369
      Height = 64
      Align = alRight
      Caption = 'Conectar'
      TabOrder = 0
      OnClick = btnConectarClick
    end
    object RadioGroup1: TRadioGroup
      Left = 1
      Top = 1
      Width = 304
      Height = 64
      Align = alLeft
      Caption = 'Tipo de conex'#227'o(API)'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'IdHTTP'
        'RestClient')
      TabOrder = 1
    end
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 744
    Top = 304
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://jsonplaceholder.typicode.com/posts'
    Params = <>
    Left = 32
    Top = 304
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 144
    Top = 304
  end
  object RESTResponse1: TRESTResponse
    Left = 272
    Top = 304
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 216
    Top = 64
    object FDMemTable1id: TIntegerField
      FieldName = 'id'
    end
    object FDMemTable1title: TStringField
      FieldName = 'title'
      Size = 1000
    end
    object FDMemTable1body: TStringField
      FieldName = 'body'
      Size = 1000
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 88
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 472
    Top = 136
    object LimparGrid1: TMenuItem
      Caption = 'Limpar Grid'
      OnClick = LimparGrid1Click
    end
  end
end
