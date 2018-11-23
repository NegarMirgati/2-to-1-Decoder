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

VinX	2	0	pulse  Vdd  0  10ps  10ps    10ns    20ns
VinA	3	0   pulse  Vdd  0  10ps  10ps    10ns    20ns

Vclk    clk 0	pulse	1	0	0n	0p	   0p		2n	4n      
***************************** INVERTER ****************************

.SUBCKT MYStaticinverter IN GND  NODE OUT
Mp1	OUT	    IN		NODE    NODE    pmos 	    l ='Lmin'  w ='2*Lmin'	
Mn2 OUT     IN     GND     GND     nmos        l ='Lmin'  w ='2*Lmin'
.ENDS MYStaticinverter

**************************** NAND GATE ****************************

.SUBCKT Mynand inA inB CLK GND NODE AIOUT
Mp1     AIOUT     CLK     NODE    NODE    pmos    l ='Lmin'    w ='2*Lmin'
Mn2     AIOUT     inA     mid     mid     nmos    l ='Lmin'    w ='2*Lmin'
Mn3     mid      inB     mid2    mid2    nmos    l ='Lmin'    w ='2*Lmin'
Mn4     mid2     CLK     GND     GND     nmos    l ='Lmin'    w ='2*Lmin'

.ENDS Mynand

************************ DECODER *********************************

X1 2  0  1  4 MYStaticinverter
X2 4  0  1  5 MYStaticinverter

* Y1 Node 7 *
X3 5  3   clk  0  1   6 Mynand 
X4 6  0  1  7 MYStaticinverter  

* Y2 Node 9 *
X5  4 3    clk  0  1  8 Mynand
X6  8 0  1  9 MYStaticinverter  



*********Type of Analysis***
.tran  0.5ns  50ns 

.op
.END

