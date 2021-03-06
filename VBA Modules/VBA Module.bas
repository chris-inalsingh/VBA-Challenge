Attribute VB_Name = "Module1"


Sub StockTicker():
    'Declare worksheet
    Dim Ws As Worksheet
    
    'Declare variables
    Dim tickercode As String
    Dim summaryrow As Integer
    Dim yearlychange As Double
    Dim Datevalue As Integer
    Dim stockvolumetotal As LongLong
    Dim closeprice As Double
    Dim openprice As Double
    
    
    'Create For loop for worksheets
    For Each Ws In Worksheets
    
    'Summary Headers
    Ws.Cells(1, 9).Value = "Ticker"
    Ws.Cells(1, 10).Value = "Yearly change"
    Ws.Cells(1, 11).Value = "Percent change"
    Ws.Cells(1, 12).Value = "Total stock volume"
    
    
    
    'Variables
    summaryrow = 2
    stockvolumetotal = 0
    closeprice = 0
    openprice = Ws.Cells(2, 3).Value
    yearlychange = 0
    LastRow = Ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    
    
    'Create For Loop
    For i = 2 To LastRow
        
        'Start Conditional
         If Ws.Cells(i + 1, 1).Value <> Ws.Cells(i, 1).Value Then
                tickercode = Ws.Cells(i, 1).Value
                stockvolumetotal = stockvolumetotal + Ws.Cells(i, 7).Value
                        
                 'Input Ticker code and stockvolume total into Summary table
                Ws.Cells(summaryrow, 9).Value = tickercode
                Ws.Cells(summaryrow, 12).Value = stockvolumetotal
               
                'Yearlychange input
                closeprice = Ws.Cells(i, 6).Value
                yearlychange = closeprice - openprice
                Ws.Cells(summaryrow, 10).Value = yearlychange
                
                
                'Nested conditional for percent change
                If openprice <> 0 Then
                    percentchange = (yearlychange / openprice)
                End If
                
                'Assigned value to table and formatting percent change
                Ws.Cells(summaryrow, 11).Value = percentchange
                Ws.Cells(summaryrow, 11).Style = "Percent"
                Ws.Cells(summaryrow, 11).NumberFormat = "0.0000%"
                
                
                'Formatting of yearly changes
                If (yearlychange > 0) Then
                    Ws.Cells(summaryrow, 10).Interior.ColorIndex = 4
                Else
                    Ws.Cells(summaryrow, 10).Interior.ColorIndex = 3
                End If
                
                'Reset values for next ticker code
                openprice = Ws.Cells(i + 1, 3).Value
                closeprice = 0
                yearlychange = 0
                summaryrow = summaryrow + 1
                stockvolumetotal = 0
        Else
        
                'stockvolumetotal sum amounts
                stockvolumetotal = stockvolumetotal + Ws.Cells(i, 7).Value
                   
                
        End If
        
    
     Next i
                
   Next Ws
   
End Sub


