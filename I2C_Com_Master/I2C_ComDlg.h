// I2C_ComDlg.h : header file
//

#include "I2C.h"

#if !defined(AFX_I2C_COMDLG_H__9DE72287_0A58_11D8_B526_00104BF1F258__INCLUDED_)
#define AFX_I2C_COMDLG_H__9DE72287_0A58_11D8_B526_00104BF1F258__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CI2C_ComDlg dialog

class CI2C_ComDlg : public CDialog
{
// Construction
public:
	CI2C_ComDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CI2C_ComDlg)
	enum { IDD = IDD_I2C_COM_DIALOG };
	int		m_MensajeIn;
	int		m_MensajeOut;
	int		m_SlaveAddress;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CI2C_ComDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

private:
I2c	Board;

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CI2C_ComDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnSend();
	afx_msg void OnReceive();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_I2C_COMDLG_H__9DE72287_0A58_11D8_B526_00104BF1F258__INCLUDED_)
