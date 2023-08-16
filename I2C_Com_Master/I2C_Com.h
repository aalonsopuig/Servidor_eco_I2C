// I2C_Com.h : main header file for the I2C_COM application
//

#if !defined(AFX_I2C_COM_H__9DE72285_0A58_11D8_B526_00104BF1F258__INCLUDED_)
#define AFX_I2C_COM_H__9DE72285_0A58_11D8_B526_00104BF1F258__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CI2C_ComApp:
// See I2C_Com.cpp for the implementation of this class
//

class CI2C_ComApp : public CWinApp
{
public:
	CI2C_ComApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CI2C_ComApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CI2C_ComApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_I2C_COM_H__9DE72285_0A58_11D8_B526_00104BF1F258__INCLUDED_)
