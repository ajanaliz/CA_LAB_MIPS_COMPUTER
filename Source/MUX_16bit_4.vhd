library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_ARITH.all;

entity Mux_16_4 is 
  port (
    Sel : in std_logic_vector ( 1 downto 0 ) ;
	  in0 : in std_logic_vector ( 15 downto 0 );
	  in1 : in std_logic_vector ( 15 downto 0 );
	  in2 : in std_logic_vector ( 15 downto 0 );
	  in3 : in std_logic_vector ( 15 downto 0 );
	  output : out std_logic_vector ( 15 downto 0 )
	);
	end Mux_16_4;
architecture Behavioral of Mux_16_4 is

begin

process(sel)
	begin
		case sel is
			
			when "00" =>
			  output <= in0 ;
			  
			when "01" => 
			  output <= in1 ;
			  
			when "10" =>
			  output <= in2 ;
			  
			when "11" =>
			  output <= in3 ;
			  
			when others =>
			end case ;	
	end process;
end Behavioral;


			





