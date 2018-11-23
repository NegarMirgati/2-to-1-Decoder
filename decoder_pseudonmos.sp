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
VinX	2	0   DC 1
VinA	3	0	DC 1

***************************** INVERTER ****************************

.SUBCKT MYinverter IN GND  NODE OUT
Mp1	OUT	        0		NODE    NODE    pmos 	    l='Lmin'  w='0.5*Lmin'	
Mn2 OUT         IN      GND     GND     nmos        l='Lmin'  w='1*Lmin'
.ENDS MYinverter

**************************** AND GATE ****************************

.SUBCKT Myand inA inB GND NODE AIOUT
Mp3     AOUT     0       NODE    NODE    pmos    l ='Lmin'    w ='1*Lmin'
Mn5     AOUT     inA     mid     mid     nmos    l ='Lmin'    w ='2*Lmin'
Mn6     mid      inB     GND     GND     nmos    l ='Lmin'    w ='2*Lmin'

Mp1	AIOUT	    0		NODE    NODE    pmos 	        l ='Lmin'  w ='0.5*Lmin'	
Mn2 AIOUT       AOUT        GND     GND     nmos        l ='Lmin'  w ='1*Lmin'
.ENDS Myand

X1 2 0 1  4 MYinverter
X2 4 0 1  5 MYinverter
* Y1 Node 6 *
X3 5 3 0  1  6 Myand   
* Y2 Node 7 *
X4 4 3 0  1  7 Myand


*********Type of Analysis***
.tran  0.1ns  20ns 

.MEASURE TRAN tpdr
 + trig V(7) val = '0.5 * Vdd'  fall = 1
 + targ V(4)  val = '0.5 * Vdd' rise = 1

.MEASURE TRAN tpdf 
+ trig V(7) val = '0.5 * Vdd' rise = 1
+ targ V(4) val = '0.5 * Vdd' fall = 1

.MEASURE TRAN tpd  param = '0.5 * (tpdr + tpdf)'

.MEASURE TRAN AVGpower avg Power
.MEASURE TRAN PDP param = 'tpd * avgpower'
.op
.END

