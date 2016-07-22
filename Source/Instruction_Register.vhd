library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity INS is
	port (
			Data_in : in std_logic_vector(15 downto 0);
			Source1 :out std_logic_vector(3 downto 0);
			Source2 :out std_logic_vector(3 downto 0);
			Destination :out std_logic_vector(3 downto 0);
			OP_Code :out std_logic_vector(3 downto 0)
			);
end INS;
  architecture Behavioral of INS is
begin
  process(Data_in)
    begin
      
   Source2 <= Data_in( 3 downto 0 );
   Source1 <= Data_in( 7 downto 4 );
   Destination <= Data_in( 11 downto 8 );
   OP_Code <= Data_in( 15 downto 12 );
  end process;
end Behavioral;




