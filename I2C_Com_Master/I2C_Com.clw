; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CI2C_ComDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "I2C_Com.h"

ClassCount=3
Class1=CI2C_ComApp
Class2=CI2C_ComDlg
Class3=CAboutDlg

ResourceCount=3
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_I2C_COM_DIALOG

[CLS:CI2C_ComApp]
Type=0
HeaderFile=I2C_Com.h
ImplementationFile=I2C_Com.cpp
Filter=N

[CLS:CI2C_ComDlg]
Type=0
HeaderFile=I2C_ComDlg.h
ImplementationFile=I2C_ComDlg.cpp
Filter=D
LastObject=IDC_MensajeOut
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=I2C_ComDlg.h
ImplementationFile=I2C_ComDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=6
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,static,1342308352

[DLG:IDD_I2C_COM_DIALOG]
Type=1
Class=CI2C_ComDlg
ControlCount=11
Control1=IDOK,button,1342242817
Control2=IDC_MensajeOut,edit,1350639745
Control3=IDC_Send,button,1342251008
Control4=IDC_STATIC,static,1342181390
Control5=IDC_Receive,button,1342242816
Control6=IDC_MensajeIn,edit,1350633601
Control7=IDC_Address,edit,1350631553
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342177287
Control10=IDC_STATIC,static,1342308352
Control11=IDC_STATIC,static,1342308352

