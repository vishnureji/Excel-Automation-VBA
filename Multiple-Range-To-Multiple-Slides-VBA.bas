Sub CovertToPpt()

'PURPOSE: Copy multiple Excel Ranges and Paste them into multiple slides 
'SOURCE: www.vishnureji.tk
'mail:web.vishnureji@gmail.com

Dim myPresentation As Object
Dim mySlide As Object
Dim PowerPointApp As Object
Dim shp As Object
Dim MySlideArray As Variant
Dim MyRangeArray As Variant
Dim x As Long
 
'Create an Instance of PowerPoint
  On Error Resume Next
    
    'Is PowerPoint already opened?
      Set PowerPointApp = GetObject(class:="PowerPoint.Application")
    
    'Clear the error between errors
      Err.Clear

    'If PowerPoint is not already open then open PowerPoint
      If PowerPointApp Is Nothing Then Set PowerPointApp = CreateObject(class:="PowerPoint.Application")
    
    'Handle if the PowerPoint Application is not found
      If Err.Number = 429 Then
        MsgBox "PowerPoint could not be found, aborting."
        Exit Sub
      End If

  On Error GoTo 0
  
'Make PowerPoint Visible and Active
  'PowerPointApp.ActiveWindow.Panes(2).Activate
    
'Create a New Presentation
  Set myPresentation = PowerPointApp.Presentations.Add
  
  'List of PPT Slides to Paste to
  MySlideArray = Array(1, 2, 3)

'List of Excel Ranges to Copy from
    MyRangeArray = Array(Sheet7.Range("A1:P26"), Sheet4.Range("A1:P15"), Sheet6.Range("A1:P25"))

'Loop through Array data
  For x = LBound(MySlideArray) To UBound(MySlideArray)
    'Copy Excel Range
        MyRangeArray(x).Copy
    'Add a slide to the Presentation
  Set mySlide = myPresentation.Slides.Add(MySlideArray(x), 12) '11 = ppLayoutTitleOnly
    'Paste to PowerPoint and position
      On Error Resume Next
        Set shp = myPresentation.Slides(MySlideArray(x)).Shapes.PasteSpecial(DataType:=2) 'Excel 2007-2010
        Set shp = PowerPointApp.ActiveWindow.Selection.ShapeRange 'Excel 2013
      On Error GoTo 0
    
    'Center Object
      With myPresentation.PageSetup
        shp.Left = (.SlideWidth \ 2) - (shp.Width \ 2)
        shp.Top = (.SlideHeight \ 2) - (shp.Height \ 2)
      End With
      
  Next x

'Transfer Complete
  Application.CutCopyMode = False
  ThisWorkbook.Activate
  MsgBox "Complete!"

End Sub
