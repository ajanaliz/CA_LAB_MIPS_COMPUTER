library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Register_PC is
	port (
	    CLK : in std_logic;
			Data_in : in std_logic_vector(15 downto 0);
			Data_out :out std_logic_vector(15 downto 0)
			);
end Register_PC;
  architecture Behavioral of Register_PC is
begin
  process(CLK)
    begin
      
      Data_out <= Data_in;
  
  end process;
end Behavioral;




