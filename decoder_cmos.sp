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
VinX	2	0   0
VinA	3	0   pulse  0  1  100ps  100ps    1ns    2ns
***************************** INVERTER ****************************

.SUBCKT MYinverter IN GND  NODE OUT
Mp1	OUT	        IN		NODE    NODE    pmos 	    l='Lmin'  w='2*Lmin'	
Mn2 OUT         IN      GND     GND     nmos        l='Lmin'  w='1*Lmin'
.ENDS MYinverter

**************************** AND GATE ****************************

.SUBCKT Myand inA inB GND NODE AIOUT
Mp3     AOUT     inB     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mp4     AOUT     inA     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mn5     AOUT     inA     mid     mid     nmos    l ='Lmin'    w ='2*Lmin'
Mn6     mid      inB     GND     GND     nmos    l ='Lmin'    w ='2*Lmin'

Mp1	AIOUT	    AOUT		NODE    NODE    pmos 	    l ='Lmin'  w ='2*Lmin'	
Mn2 AIOUT       AOUT        GND     GND     nmos        l ='Lmin'  w ='1*Lmin'
.ENDS Myand

************************ DECODER *********************************

X1 2 0 1  4 MYinverter
X2 4 0 1  5 MYinverter
* Y1 Node 6 *
X3 5 3 0  1  6 Myand   
* Y2 Node 7 *
X4 4 3 0  1  7 Myand


*********Type of Analysis***
.tran  0.025ns  20ns 

.MEASURE TRAN tphl
 + trig V(3) val = '0.5 * Vdd'  rise = 1  targ V(7)  val = '0.5 * Vdd' rise = 1

.MEASURE TRAN tplh
+ trig V(3) val = '0.5 * Vdd' fall = 1 targ V(7) val = '0.5 * Vdd'  fall = 1

.MEASURE TRAN tpd  param = '0.5 * (tphl + tplh)'

.MEASURE TRAN AVGpower avg Power
.MEASURE TRAN PDP param = 'tpd * avgpower'
.op
.END

