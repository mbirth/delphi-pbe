object Form1: TForm1
  Left = 191
  Top = 106
  Width = 818
  Height = 656
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 
    'PhoneBackup Editor (PBE) --- by Markus Birth <mbirth@webwriters.' +
    'de>'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DirLabel: TLabel
    Left = 336
    Top = 8
    Width = 465
    Height = 13
    AutoSize = False
    Caption = 
      'C:\Documents and Settings\Administrator\My Documents\Development' +
      '\Delphi\PBE'
  end
  object ProgBarText: TLabel
    Left = 336
    Top = 240
    Width = 257
    Height = 21
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object FileName: TEdit
    Left = 336
    Top = 240
    Width = 257
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = '*.MS'
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 272
    Width = 793
    Height = 329
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Phonebook'
      object Label1: TLabel
        Left = 135
        Top = 12
        Width = 52
        Height = 20
        Caption = 'Name:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 158
        Top = 44
        Width = 31
        Height = 13
        Caption = 'Home:'
        Enabled = False
      end
      object Label3: TLabel
        Left = 161
        Top = 68
        Width = 29
        Height = 13
        Caption = 'Work:'
        Enabled = False
      end
      object Label4: TLabel
        Left = 156
        Top = 93
        Width = 34
        Height = 13
        Caption = 'Mobile:'
        Enabled = False
      end
      object Label5: TLabel
        Left = 170
        Top = 117
        Width = 20
        Height = 13
        Caption = 'Fax:'
        Enabled = False
      end
      object Label6: TLabel
        Left = 161
        Top = 141
        Width = 29
        Height = 13
        Caption = 'Other:'
        Enabled = False
      end
      object Label7: TLabel
        Left = 159
        Top = 164
        Width = 31
        Height = 13
        Caption = 'E-mail:'
        Enabled = False
      end
      object Label8: TLabel
        Left = 167
        Top = 188
        Width = 23
        Height = 13
        Caption = 'Title:'
        Enabled = False
      end
      object Label9: TLabel
        Left = 143
        Top = 212
        Width = 47
        Height = 13
        Caption = 'Company:'
        Enabled = False
      end
      object PB_List: TListBox
        Left = 0
        Top = 0
        Width = 129
        Height = 233
        Enabled = False
        ItemHeight = 13
        TabOrder = 0
        OnClick = PB_ListClick
      end
      object PB_OrderGroup: TRadioGroup
        Left = 0
        Top = 240
        Width = 105
        Height = 57
        Caption = 'Order'
        Enabled = False
        TabOrder = 1
      end
      object PB_OrderLF: TRadioButton
        Left = 8
        Top = 256
        Width = 73
        Height = 17
        Caption = 'Last, First'
        Checked = True
        Enabled = False
        TabOrder = 2
        TabStop = True
        OnClick = PB_OrderLFClick
      end
      object PB_OrderFL: TRadioButton
        Left = 8
        Top = 272
        Width = 73
        Height = 17
        Caption = 'First Last'
        Enabled = False
        TabOrder = 3
        OnClick = PB_OrderFLClick
      end
      object PB_Name: TEdit
        Left = 192
        Top = 8
        Width = 273
        Height = 28
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object PB_Home: TEdit
        Left = 192
        Top = 40
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 5
      end
      object PB_Work: TEdit
        Left = 192
        Top = 64
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 6
      end
      object PB_Mobile: TEdit
        Left = 192
        Top = 88
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 7
      end
      object PB_Fax: TEdit
        Left = 192
        Top = 112
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 8
      end
      object PB_Other: TEdit
        Left = 192
        Top = 136
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 9
      end
      object PB_Email: TEdit
        Left = 192
        Top = 160
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 10
      end
      object PB_Title: TEdit
        Left = 192
        Top = 184
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 11
      end
      object PB_Company: TEdit
        Left = 192
        Top = 208
        Width = 273
        Height = 21
        Enabled = False
        TabOrder = 12
      end
      object PB_PhotoGroup: TGroupBox
        Left = 568
        Top = 24
        Width = 117
        Height = 177
        Caption = 'Photo'
        TabOrder = 13
        object PB_Photo: TImage
          Left = 8
          Top = 32
          Width = 101
          Height = 80
          Center = True
          Proportional = True
        end
        object PB_PhotoDelButton: TButton
          Left = 8
          Top = 120
          Width = 101
          Height = 17
          Caption = 'Delete!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = PB_PhotoDelButtonClick
        end
        object PB_PhotoLoadButton: TButton
          Left = 8
          Top = 136
          Width = 101
          Height = 17
          Caption = 'Load...'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object PB_PhotoSaveButton: TButton
          Left = 8
          Top = 152
          Width = 101
          Height = 17
          Caption = 'Save...'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object PB_PhotoAtt: TCheckBox
          Left = 7
          Top = 13
          Width = 106
          Height = 17
          Caption = 'photo attached'
          Enabled = False
          TabOrder = 3
        end
      end
      object PB_NewButton: TButton
        Left = 192
        Top = 256
        Width = 75
        Height = 25
        Caption = 'New'
        Enabled = False
        TabOrder = 14
        OnClick = PB_NewButtonClick
      end
      object PB_DelButton: TButton
        Left = 272
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Delete!'
        Enabled = False
        TabOrder = 15
        OnClick = PB_DelButtonClick
      end
      object PB_SaveButton: TButton
        Left = 376
        Top = 256
        Width = 89
        Height = 25
        Caption = 'Save Changes'
        Enabled = False
        TabOrder = 16
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Calendar'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'SMSes'
      ImageIndex = 2
      object Label10: TLabel
        Left = 651
        Top = 4
        Width = 84
        Height = 13
        Caption = 'SMS Protocoll ID:'
      end
      object Label11: TLabel
        Left = 605
        Top = 28
        Width = 130
        Height = 13
        Caption = 'SMS Data Coding Scheme:'
      end
      object Label12: TLabel
        Left = 576
        Top = 52
        Width = 54
        Height = 13
        Caption = 'Timestamp:'
      end
      object Label13: TLabel
        Left = 148
        Top = 13
        Width = 33
        Height = 13
        Caption = 'SMSC:'
      end
      object Label14: TLabel
        Left = 134
        Top = 36
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Recipient:'
      end
      object SM_List: TListBox
        Left = 0
        Top = 0
        Width = 121
        Height = 297
        ItemHeight = 13
        TabOrder = 0
      end
      object SM_SMSC: TEdit
        Left = 184
        Top = 8
        Width = 185
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = 'SM_SMSC'
      end
      object SM_Recipient: TEdit
        Left = 184
        Top = 32
        Width = 185
        Height = 21
        Enabled = False
        TabOrder = 2
        Text = 'SM_Recipient'
      end
      object SM_PID: TEdit
        Left = 736
        Top = 0
        Width = 49
        Height = 21
        Enabled = False
        TabOrder = 3
        Text = 'SM_PID'
      end
      object SM_DCS: TEdit
        Left = 736
        Top = 24
        Width = 49
        Height = 21
        Enabled = False
        TabOrder = 4
        Text = 'SM_DCS'
      end
      object SM_TimeStamp: TEdit
        Left = 632
        Top = 48
        Width = 153
        Height = 21
        Enabled = False
        TabOrder = 5
        Text = 'SM_TimeStamp'
      end
      object SM_NewButton: TButton
        Left = 184
        Top = 216
        Width = 75
        Height = 25
        Caption = 'New'
        Enabled = False
        TabOrder = 6
      end
      object SM_DelButton: TButton
        Left = 272
        Top = 216
        Width = 75
        Height = 25
        Caption = 'Delete!'
        Enabled = False
        TabOrder = 7
      end
      object SM_RadioSent: TRadioButton
        Left = 200
        Top = 56
        Width = 49
        Height = 17
        Caption = 'Sent'
        TabOrder = 9
      end
      object SM_RadioRecvd: TRadioButton
        Left = 296
        Top = 56
        Width = 73
        Height = 17
        Caption = 'Received'
        TabOrder = 10
      end
      object SM_Message: TMemo
        Left = 136
        Top = 72
        Width = 233
        Height = 137
        Enabled = False
        Lines.Strings = (
          'SM_Message')
        TabOrder = 8
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Settings'
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 8
        Top = 8
        Width = 769
        Height = 273
        ActivePage = TabSheet6
        TabOrder = 0
        object TabSheet6: TTabSheet
          Caption = 'Data Accounts'
          ImageIndex = 1
        end
        object TabSheet5: TTabSheet
          Caption = 'WAP Profiles'
          object WP_List: TListBox
            Left = 0
            Top = 0
            Width = 121
            Height = 241
            ItemHeight = 13
            TabOrder = 0
          end
        end
        object TabSheet7: TTabSheet
          Caption = 'Bookmarks'
          ImageIndex = 2
          object Label15: TLabel
            Left = 216
            Top = 8
            Width = 39
            Height = 13
            Caption = 'Caption:'
          end
          object Label16: TLabel
            Left = 216
            Top = 56
            Width = 25
            Height = 13
            Caption = 'URL:'
          end
          object BM_List: TListBox
            Left = 0
            Top = 0
            Width = 201
            Height = 241
            ItemHeight = 13
            TabOrder = 0
          end
          object BM_Name: TEdit
            Left = 216
            Top = 24
            Width = 233
            Height = 21
            TabOrder = 1
            Text = 'BM_Name'
          end
          object BM_URL: TEdit
            Left = 216
            Top = 72
            Width = 537
            Height = 21
            TabOrder = 2
            Text = 'BM_URL'
          end
          object BM_UpButton: TButton
            Left = 200
            Top = 208
            Width = 41
            Height = 17
            Caption = 'Up'
            TabOrder = 3
          end
          object BM_DownButton: TButton
            Left = 200
            Top = 224
            Width = 41
            Height = 17
            Caption = 'Down'
            TabOrder = 4
          end
          object BM_NewButton: TButton
            Left = 256
            Top = 152
            Width = 75
            Height = 25
            Caption = 'New'
            TabOrder = 5
          end
          object BM_DelButton: TButton
            Left = 416
            Top = 152
            Width = 75
            Height = 25
            Caption = 'Delete!'
            TabOrder = 6
          end
          object BM_ButtonSave: TButton
            Left = 336
            Top = 152
            Width = 75
            Height = 25
            Caption = 'Save'
            TabOrder = 7
          end
        end
        object TabSheet8: TTabSheet
          Caption = 'Profiles'
          ImageIndex = 3
          object Label17: TLabel
            Left = 128
            Top = 8
            Width = 61
            Height = 13
            Caption = 'Profile name:'
          end
          object PR_List: TListBox
            Left = 0
            Top = 0
            Width = 121
            Height = 241
            ItemHeight = 13
            TabOrder = 0
          end
          object PR_Name: TEdit
            Left = 128
            Top = 24
            Width = 121
            Height = 21
            TabOrder = 1
            Text = 'PR_Name'
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Locks'
          ImageIndex = 4
          object LO_AutoKeylock: TCheckBox
            Left = 16
            Top = 16
            Width = 113
            Height = 17
            Caption = 'Automatic Keylock'
            TabOrder = 0
          end
        end
        object TabSheet10: TTabSheet
          Caption = 'Time'
          ImageIndex = 5
        end
        object TabSheet11: TTabSheet
          Caption = 'My Shortcuts'
          ImageIndex = 6
          object SC_List: TListBox
            Left = 8
            Top = 8
            Width = 425
            Height = 225
            ItemHeight = 13
            TabOrder = 0
          end
          object SC_ButtonUp: TButton
            Left = 432
            Top = 200
            Width = 49
            Height = 17
            Caption = 'Up'
            TabOrder = 1
          end
          object SC_ButtonDown: TButton
            Left = 432
            Top = 216
            Width = 49
            Height = 17
            Caption = 'Down'
            TabOrder = 2
          end
          object SC_AvailSCs: TComboBox
            Left = 440
            Top = 8
            Width = 313
            Height = 21
            ItemHeight = 0
            TabOrder = 3
            Text = 'SC_AvailSCs'
          end
          object SC_ButtonAdd: TButton
            Left = 440
            Top = 32
            Width = 75
            Height = 25
            Caption = '< Add'
            TabOrder = 4
          end
          object SC_ButtonDel: TButton
            Left = 440
            Top = 96
            Width = 75
            Height = 25
            Caption = 'Delete!'
            TabOrder = 5
          end
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'Debug'
      ImageIndex = 4
      object Label18: TLabel
        Left = 8
        Top = 8
        Width = 86
        Height = 13
        Caption = 'Number of entries:'
      end
      object Label19: TLabel
        Left = 16
        Top = 58
        Width = 29
        Height = 13
        Caption = 'Group'
      end
      object Label20: TLabel
        Left = 13
        Top = 83
        Width = 28
        Height = 13
        Caption = 'Name'
      end
      object DBG_Count: TEdit
        Left = 96
        Top = 4
        Width = 65
        Height = 21
        TabOrder = 0
        Text = 'DBG_Count'
      end
      object DBG_Entry: TMemo
        Left = 8
        Top = 104
        Width = 289
        Height = 145
        Lines.Strings = (
          'DBG_Entry')
        TabOrder = 1
      end
      object DBG_ShowEntry: TButton
        Left = 328
        Top = 56
        Width = 121
        Height = 25
        Caption = 'Show Entry'
        TabOrder = 2
        OnClick = DBG_ShowEntryClick
      end
      object DBG_EntryGroup: TEdit
        Left = 48
        Top = 56
        Width = 249
        Height = 21
        TabOrder = 3
        Text = 'DBG_EntryGroup'
      end
      object DBG_EntryName: TEdit
        Left = 48
        Top = 80
        Width = 249
        Height = 21
        TabOrder = 4
        Text = 'DBG_EntryName'
      end
      object DBG_SelEntry: TSpinEdit
        Left = 328
        Top = 32
        Width = 121
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object DBG_LastEntry: TCheckBox
        Left = 8
        Top = 248
        Width = 209
        Height = 17
        Caption = 'Last entry of this group'
        TabOrder = 6
      end
      object DBG_Groups: TMemo
        Left = 328
        Top = 104
        Width = 281
        Height = 145
        Lines.Strings = (
          'DBG_Groups')
        TabOrder = 7
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 610
    Width = 810
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Select a PhoneBackup file (*.MS)'
  end
  object FileListBox1: TFileListBox
    Left = 336
    Top = 24
    Width = 465
    Height = 209
    FileEdit = FileName
    FileType = [ftHidden, ftSystem, ftNormal]
    ItemHeight = 13
    Mask = '*.MS'
    TabOrder = 3
    OnChange = FileListBox1Change
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 321
    Height = 201
    DirLabel = DirLabel
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 4
    OnChange = DirectoryListBox1Change
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 8
    Width = 321
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 5
  end
  object FilterComboBox1: TFilterComboBox
    Left = 8
    Top = 240
    Width = 321
    Height = 21
    FileList = FileListBox1
    Filter = 'PhoneBackup files (*.MS)|*.MS|All files (*.*)|*.*'
    TabOrder = 6
  end
  object Button_Load: TButton
    Left = 597
    Top = 240
    Width = 75
    Height = 20
    Caption = 'Load'
    Enabled = False
    TabOrder = 7
    OnClick = Button_LoadClick
  end
  object Button_Save: TButton
    Left = 672
    Top = 240
    Width = 49
    Height = 20
    Caption = 'Save!'
    Enabled = False
    TabOrder = 8
    OnClick = Button_SaveClick
  end
  object ProgressBar: TProgressBar
    Left = 336
    Top = 264
    Width = 465
    Height = 22
    TabOrder = 9
    Visible = False
  end
  object Button_SaveAs: TButton
    Left = 721
    Top = 240
    Width = 48
    Height = 20
    Caption = 'Save As'
    Enabled = False
    TabOrder = 10
    OnClick = Button_SaveAsClick
  end
  object Button_Close: TButton
    Left = 769
    Top = 240
    Width = 33
    Height = 20
    Caption = 'Close'
    Enabled = False
    TabOrder = 11
    OnClick = Button_CloseClick
  end
end
