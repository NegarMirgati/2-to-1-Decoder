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
VinX	2	0	DC 1
VinA	3	0   DC 1
Vclk    clk 0	pulse	0	1	0n	0p	   0p		1n	2n      
***************************** DYNAMIC INVERTER ****************************

.SUBCKT MYDynamicinverter IN CLK GND  NODE OUT
Mp1	OUT	        CLK		NODE    NODE    pmos 	    l='Lmin'  w='2*Lmin'	
Mn2 OUT         IN      GND     GND     nmos        l='Lmin'  w='1*Lmin'
.ENDS MYDynamicinverter
***************************** INVERTER ****************************

.SUBCKT MYStaticinverter IN GND  NODE OUT
Mp1	AIOUT	    AOUT		NODE    NODE    pmos 	    l ='Lmin'  w ='2*Lmin'	
Mn2 AIOUT       AOUT        GND     GND     nmos        l ='Lmin'  w ='1*Lmin'
.ENDS MYStaticinverter

**************************** AND GATE ****************************

.SUBCKT Myand inA inB CLK GND NODE AIOUT
Mp3     AOUT     CLK     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mn5     AOUT     inA     mid     mid     nmos    l ='Lmin'    w ='2*Lmin'
Mn6     mid      inB     mid2    mid2    nmos    l ='Lmin'    w ='2*Lmin'
Mn7     mid2     CLK     GND     GND   nmos      l ='Lmin'    w ='2*Lmin'

Mp1	AIOUT	    AOUT		NODE    NODE    pmos 	    l ='Lmin'  w ='2*Lmin'	
Mn2 AIOUT       AOUT        GND     GND     nmos        l ='Lmin'  w ='1*Lmin'
.ENDS Myand

************************ DECODER *********************************

X1 2  clk   0  1  4 MYDynamicinverter
X2 4        0  1  5 MYStaticinverter
X3 5  clk   0  1  6 MYDynamicinverter
X4 6        0  1  7 MYStaticinverter

* Y1 Node 10 *
X5 7  3   clk  0  1  8  Myand 
X6 8           0  1  9 MYStaticinverter  
X7 9      clk  0  1  10 MYDynamicinverter

* Y2 Node 13 *
X8 5 3    clk  0  1  11 Myand
X9  11           0 1  12 MYStaticinverter  
X10 12    clk  0  1 13 MYDynamicinverter


*********Type of Analysis***
.tran  0.1ns  20ns

.op
.END

