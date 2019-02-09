*******************************************************

.param gflag__totalflag_mos__mos__cmos040lp=0
.param gflag__globalflag_mos__mos__cmos040lp=1
.param svtlp_dev=1

.include './45nm_MGK.pm'

.OPTIONS GMIN=1e-30 
.options POST
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-15
.options RMIN=1e-15
.options ABSTOL=1e-25  ABSVDC=1e-25 
.options RELTOL=1e-20  
.options RELVDC=1e-2 
.options NUMDGT=4     PIVOT=1e-13
.option MEASDGT=6
.temp 25

.PARAM  pvdd=1.0
.PARAM  Vin_A=0
.PARAM  Vin_B=0
.PARAM  Vin_C=0

vvdd   vdd   0   dc='pvdd'
vgnd   gnd   0   dc=0

Vina    nodea   0   Vin_A
Vinb    nodeb   0   Vin_B
Vinc    nodec   0   Vin_C

**netlist
Mp1    1   nodea   vdd   vdd   pmos  l=47.0329073273n w=164.855021636n 
Mp2    1   nodeb   vdd   vdd   pmos  l=47.9154136625n w=143.2773267n 
Mp3    nodecon nodec   1   vdd   pmos l=45.8469431398n w=162.708234204n 
Mn1    5   nodea   gnd   gnd   nmos  l=45.8422026258n w=168.707909706n 
Mn2    5   nodeb   gnd   gnd   nmos  l=50.2348269296n w=101.824346025n 
Mn3    nodecon nodec   5   gnd   nmos l=48.8008798841n w=108.016815647n 
Mp4    4   nodea   vdd   vdd   pmos  l=47.2391798199n w=182.194669245n 
Mp5    nodecon nodeb   4   vdd   pmos  l=45.2371750638n w=165.095569845n 
Mn4    nodecon nodeb   node4   gnd   nmos l=48.5299700744n w=93.4861811524n 
Mn5    node4   nodea   gnd   gnd   nmos l=47.2874704197n w=131.559099101n 
Mp6    2   nodea   vdd   vdd   pmos  l=47.652467525n w=150.781708138n 
Mp7    2   nodeb   vdd   vdd   pmos l=46.444275276n w=156.019435636n 
Mp8    2   nodec   vdd   vdd   pmos l=49.2009821186n w=138.547022282n 
Mp9    nodes0n nodecon 2   vdd   pmos l=46.8576322757n w=81.1343710239n 
Mn6    3   nodea   gnd   gnd   nmos l=47.5224358951n w=159.268335475n 
Mn7    3   nodeb   gnd   gnd   nmos l=50.5166682525n w=118.041645539n 
Mn8    3   nodec   gnd   gnd   nmos l=46.0081685767n w=105.888491192n 
Mn9    nodes0n nodecon 3   gnd   nmos l=49.5344581129n w=83.1889959664n 
Mp10   9   nodea   vdd   vdd   pmos  l=46.9259533283n w=132.09928126n 
Mp11   8   nodeb   9   vdd   pmos    l=45.6744150147n w=237.455262766n 
Mp12   nodes0n nodec   8   vdd   pmos l=54.4107594437n w=222.422669861n 
Mn10   7   nodea   gnd   gnd   nmos  l=48.3274041752n w=119.739517794n 
Mn11   6   nodeb   7   gnd   nmos    l=49.7724863031n w=182.617632567n 
Mn12   nodes0n nodec   6   gnd   nmos  l=50.5009504456n w=152.92655059n 
Mp13   nodeco  nodecon vdd   vdd   pmos l=49.1143970164n w=78.4441093842n 
Mn13   nodeco  nodecon gnd   gnd   nmos l=45.0474176041n w=97.7660863254n 
Mp14   nodes0  nodes0n vdd   vdd   pmos l=54.3152123776n w=109.874038742n 
Mn14   nodes0  nodes0n gnd   gnd   nmos  l=51.7322973982n w=90.2454357337n  



.DATA In_Var
Vin_A   Vin_B   Vin_C
0       0       0   * 000
0       0       1.0     * 001       
0       1.0     0   * 010       
0       1.0     1.0     * 011       
1.0     0       0   * 100       
1.0     0       1.0     * 101        
1.0     1.0     0   * 110       
1.0     1.0     1.0     * 111
.ENDDATA

.DC dummy 1 1 1 SWEEP DATA=In_Var

    .MEAS   DC  Vsup        AVG     v(vdd)
    .MEAS   DC  Ivdd        AVG i(vvdd)        
    .MEAS   DC  VIS     param='-Vsup*Ivdd'

    .MEAS   DC  Va      AVG     v(nodea)
    .MEAS   DC  Ia      AVG i(Vina)
    .MEAS   DC  VIA     param='-Va*Ia'

    .MEAS   DC  Vb      AVG     v(nodeb)
    .MEAS   DC  Ib      AVG i(Vinb)
    .MEAS   DC  VIB     param='-Vb*Ib'

    .MEAS   DC  Vc      AVG     v(nodec)
    .MEAS   DC  Ic      AVG i(Vinc)
    .MEAS   DC  VIC     param='-Vc*Ic'

    .MEAS   DC  leakage     param='VIS+VIA+VIB+VIC'
    .meas   dc  sum   avg v(nodes0)
    .meas   dc  carry avg v(nodeco)
.END       


