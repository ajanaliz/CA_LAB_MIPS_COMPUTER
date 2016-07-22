library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Ram is
	port (
	  WriteData :in std_logic_vector(15 downto 0);
		Address : in std_logic_vector(4 downto 0);
		Read : in std_logic;
		Write : in std_logic;
		MemData :out std_logic_vector(15 downto 0)
	);
end Ram;

architecture Behavioral of Ram is
	type Matrix is array (31 downto 0) of std_logic_vector (15 downto 0);
	signal Data_Matrix : Matrix:= (
0 =>      "0000001000000001" ,
1 =>      "0011001100000001" ,
2 =>      "0100010000000001" ,
3 =>      "0110010100000001" ,
4 =>      "1000000001111111" ,
5 =>      "1011000000000001" ,
9 =>      "1101010001110000" ,
10 =>     "1100000000000011" ,
6 =>      "1111000000000000" ,
others => "0000000000000000" ) ;
	
    begin
	     process( Read , Write , Address , WriteData )
	       begin
		
		        if (Read = '1' and Write = '0') then
			         MemData <= Data_Matrix(to_integer(unsigned(Address)));
		        elsif(Read = '0' and Write = '1') then
			         Data_Matrix(to_integer(unsigned(Address))) <= WriteData;
		        end if;
		
	     end process;
end Behavioral;


