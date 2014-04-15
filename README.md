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

Implementation was accomplished using the following conditional output logic code.
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


####Debugging
Mostly I had issues with syntax (and the spelling of Data). In addition, I learned of the method that I used for ROR during in class discussions on the work days. 

#Datapath Modifications
The datapath implements the ALU and uses it in conjunction with several other essential parts of the computer such as the IR and MAR.

The given shell had to be modified to conform to the given commands.

|  Mnemonic |  Encoding  |
|--:|--: |
|  NOP |  0000 | 
|  NEG |  0001 | 
|  NOT |  0010 | 
|  ROR |  0011 | 
|  OUT |  0100 aaaa  |  
|  IN |  0101 aaaa  |  
|  ADDI |  0110 vvvv  |  
|  LDAI |  0111 vvvv  |
|  AND |  1000 aaaa aaaa | 
|  JMP |  1001  aaaa aaaa| 
|  JZ |  1010 aaaa aaaa | 
|  JN |  1011 aaaa aaaa| 
|  OR |  1100  aaaa aaaa|  
|  STA |  1101 aaaa aaaa |  
|  ADDD |  1110 aaaa aaaa |  
|  LDAD |  1111 aaaa aaaa  |

##Coding
The first step of making the datapath work was by first creating an instantiation of the ALU within the datapath.
```vhdl
Inst_ALU: ALU PORT MAP(
		OpSel => OpSel,
		Data => Data,
		Accumulator => Accumulator,
		Result => ALU_Result
	);
```
Then, the IR and MAR had to be created using this general format for code.
```vhdl
process(IRLd, Reset_L, Clock)
  	begin
     if rising_edge(Clock) then


	  if (Reset_L= '0') then
	     IR <= "0000";

		elsif (IRLd= '1') then 
		   IR <= Data;
     

			end if;
			end if;


  	end process;   
```

Because the reset signal is an active low, it must be set to reset when the signal is zero.

The next step was to implement the Address selector that decided whether to load data from the MAR or the PC to the address bus.

```vhdl
process(AddrSel, MARHi, MARLo, PC)
  	begin
       
	  if (AddrSel= '1') then
	     Addr <= MARHi & MARLo;

		elsif (AddrSel= '0') then 
		   Addr <= PC;
     

			end if;

  	end process; 
```

The next step was to implement a tri state buffer to prevent the data from becoming a veritable mix of cool aid.

```vhld
Data <=   Accumulator       when    EnAccBuffer='1'         else    "ZZZZ"     ;
```

The last step was to implement the datapaht status signals.
```vhdl
AlessZero <=   Accumulator(3) ;			
  	AeqZero <=  not Accumulator(3) or Accumulator(2) or Accumulator(1) or Accumulator(0); 
```

##Datapath Test and Debug
The datapath that was created was then implemented and run in isim using the testbench provided. Then the modified signal provided to us had to essentially be forced upon the waveform in order to have all the signals behave properly. The waveform is displayed below. 

![alt tag] (https://raw.githubusercontent.com/TylerSpence/ECE281_Lab4/master/screenshotdatapath.png)

In the testbench there was an extra comma and semicolon that had to be deleted for it to function appropriately. In addition, Captain Silva assited me with the logic used for the IR, MARHi, and MARLo. Also, classroom discussion facilitated me learning about the use of the & symbol in combining MARHi and MARLo. 


#Simulation
The following section contains analysis of waveforms and the reverse engineering of what is actually taking place. 

0-50ns analysis: Done in lab document by Captain Silva

50-100ns analysis:

![alt tag] (https://raw.githubusercontent.com/TylerSpence/ECE281_Lab4/master/fiftythroughundo.png)

At approximately 65ns, the value of opsel becomes 3, which corresponds to ror in the ALU. The value stored in the accumulator at this time is B, which corresponds to the binary value of 1011. It is then rotated right to 1101, which corresponds to the hex value of D, which is what ends up being in the accumulator. 

For this entire section addrsel is 0, meaning that the PC is going to be loaded to the data bus unless another load is triggered. When the funtion described with the accumulator is occuring, a z is output by the data in accordance with the buffer. 

At t=50ns and 80ns, pcld is 1, and accordingly the data becomes the value of what is on the pc. At t=85ns, data becomes 3, what was previously on the ir. 

225ns analysis:

![alt taag] (https://raw.githubusercontent.com/TylerSpence/ECE281_Lab4/master/jump.png)

Essentially, the jump fintions by loading the value that is in marlo into the PC. Up until that point the pc increases in an increment of one. The jump causes it to jump to 2.


#PRISM program listing
Essentially, the program begins by loading B and then RORing it. It then outputs the data (loading a 4) witha the operand being 3. It then does nothing (NOP). Then the ir is d, which is STA, so the program loads MARHi & MARLo because pcld is 1. Thus B0 is loaded. Then the jump to 02 occurs. 
It is demonstrated below.

![alt tag] (https://raw.githubusercontent.com/TylerSpence/ECE281_Lab4/master/prisimdiagram.png)
#Answer to question
Memory needs to be added to form a microprocessor. 

#Documentation:
Discussed above in debugging sections.
