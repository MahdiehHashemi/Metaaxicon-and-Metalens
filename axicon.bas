Option Explicit
Sub Main
Dim nu As Integer

nu=0

Const d As Double=360
Const nn As Integer=11
Dim x As Double
Dim y As Double

Dim sta(3362) As Integer
Dim i, m,n,k,mm As Integer
Dim j As Integer
Dim tmpa, tmpb As String, contents As String
Dim ty As Integer
m=1
n=1
i=1
j=1
	Open "D:\axicon\Axicon,Lens10\alphari.txt" For Input As #1
	While EOF(1) = 0
        Line Input #1,tmpa
	'contents = contents + tmpa
	sta(m)=CInt(tmpa)
        m=m+1
	Wend
m=1
For mm=1 To 41
y=(mm-41/2)*d
For i=1 To 41
x=(i-41/2)*d
n=m+1681

With Rotate
nu=nu+1


    .Reset
    .Name ("c_" & nu)
    .Component ("component1")
    .Material ("Silicon (loss free)")
    .Mode ("pointlist")
    .StartAngle (180-sta(m)/2)
    .Angle (sta(m))
    .Height (0)
    .RadiusRatio (1)
    .Origin (x,y,0)
    .Rvector ( 1,0,0)
    .Zvector ( 0,0,1)
    .Point ( 140, 200)
    .LineTo ( sta(n), 200 )
    .LineTo ( sta(n), 0 )
    .LineTo ( 140, 0 )
    .LineTo ( 140, 200 )
    .create

End With
m=m+1

Next
Next

End Sub
