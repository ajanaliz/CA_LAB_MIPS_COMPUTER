library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_ARITH.all;

entity Mux_4_2 is 
  port (
    Sel : in std_logic ;
	  in0 : in std_logic_vector ( 3 downto 0 );
	  in1 : in std_logic_vector ( 3 downto 0 );
	  output : out std_logic_vector ( 3 downto 0 )
	);
	end Mux_4_2;
architecture Behavioral of Mux_4_2 is

begin

process(sel)
	begin
		case sel is
			
			when '0' =>
			  output <= in0 ;
			  
			when '1' => 
			  output <= in1 ;
			  		  
			when others =>
			end case ;	
	end process;
end Behavioral;


			








