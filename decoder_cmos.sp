* 2-to-1 Decoder - CMOS Logic *
************ Library *************
.prot
.inc '45nm.pm'
.unprot

********* Params*******
.param			Lmin=45n
+Vdd=1V

.global	Vdd
****** Sources ******
Vdd	    1	0  	1
VinX	2	0	DC 0
VinA	3	0	DC 1

***************************** INVERTER ****************************

.SUBCKT MYinverter IN GND  NODE OUT
Mp1	OUT	        IN		NODE    NODE    pmos 	    l='Lmin'  w='4*Lmin'	
Mn2 OUT         IN      GND     GND     nmos        l='Lmin'  w='2*Lmin'
.ENDS MYinverter

**************************** AND GATE ****************************

.SUBCKT Myand inA inB GND NODE AIOUT
Mp3     AOUT     inB     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mp4     AOUT     inA     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mn5     AOUT     inA     mid     mid     nmos    l ='Lmin'    w ='2*Lmin'
Mn6     mid      inB     GND     GND     nmos    l ='Lmin'    w ='2*Lmin'

Mp1	AIOUT	    AOUT		NODE    NODE    pmos 	    l ='Lmin'  w ='4*Lmin'	
Mn2 AIOUT       AOUT        GND     GND     nmos        l ='Lmin'  w ='2*Lmin'
.ENDS Myand

************************ DECODER *********************************

X1 2 0 1  4 MYinverter
X2 4 0 1  5 MYinverter
* Y1 Node 6 *
X3 5 3 0  1  6 Myand   
* Y2 Node 7 *
X4 4 3 0  1  7 Myand

.tran	0.1ns	60ns  
.op
.END

