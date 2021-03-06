-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Spence
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : ALU.vhd
-- Generated   : Fri Mar 30 11:16:54 2007
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ALU} architecture {ALU}}

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	 port(
		 OpSel : in STD_LOGIC_VECTOR(2 downto 0);
		 Data : in STD_LOGIC_VECTOR(3 downto 0);
		 Accumulator : in STD_LOGIC_VECTOR(3 downto 0);
		 Result : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is	   


begin
	
-- fill in details to create result as a function of Data and Accumulator, based on OpSel.
 -- e.g : Build a multiplexer choosing between the eight ALU operations.  Either use a case statement (and thus a process)
 --       or a conditional signal assignment statement ( x <= Y when <condition> else . . .)
 -- ALU Operations are defined as:
 -- OpSel : Function
--  0     : AND
--  1     : NEG (2s complement)
--  2     : NOT (invert)
--  3     : ROR
--  4     : OR
--  5     : IN
--  6     : ADD
--  7     : LD
aluswitch: process (Accumulator, Data, OpSel)
        begin
		  	
		 

	
          
		end process;

-- OR, enter your conditional signal statement here
Result <= (Data and Accumulator)      when (Opsel="000") else
		           (not(Accumulator) + "0001") when (Opsel="001" )else
					  (not Accumulator)           when (Opsel="010" )else
					  (To_StdLogicVector(To_BitVector(Accumulator) ror 1))  when (Opsel="011" )else
					  (Data or Accumulator)       when (Opsel="100" )else
					  (Data)                      when (Opsel="101" )else
					  (Data + Accumulator)        when (Opsel="110" )else
					  (Data)                      when (Opsel="111" )else
					  Data;

end ALU;

