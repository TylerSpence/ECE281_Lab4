ECE281_Lab4
===========

#Design
##ALU Modifications

The given ALU shell had to be modified to implement the funtionality demonstrated in the table below.

|  OpSel |  Function  |
|--:|--: |
|  0 |  AND  | 
|  1 |  NEG  | 
|  2 |  NOT  | 
|  3 |  ROR | 
|  4 |  OR  |  
|  5 |  IN  |  
|  6 |  ADD  |  
|  7 |  LDA  |

This was accomplished using the following output logic code.
```vhdl
Result <= (Data and Accumulator)      when (Opsel="000") else
		           (not(Accumulator) + "0001") when (Opsel="001" )else
					  (not Accumulator)           when (Opsel="010" )else
					  (To_StdLogicVector(To_BitVector(Accumulator) ror 1))  when (Opsel="011" )else
					  (Data or Accumulator)       when (Opsel="100" )else
					  (Data)                      when (Opsel="101" )else
					  (Data + Accumulator)        when (Opsel="110" )else
					  (Data)                      when (Opsel="111" )else
					  Data;
```
This code assigned the given values using data and the accumulator according to the binary representation of the input of OpSel. 

##ALU Test and Debug
This resulted in the following waveform, which matched up with the predicted logic from the code.
![alt tag] (https://raw.githubusercontent.com/TylerSpence/ECE281_Lab4/master/aluscreenshot.PNG)
