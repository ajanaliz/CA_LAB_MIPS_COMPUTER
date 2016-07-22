library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity REGFIL is
	port (
	    Read_Register_1 :in std_logic_vector(3 downto 0);
			Read_Register_2 :in std_logic_vector(3 downto 0);
			Write_Register :in std_logic_vector(3 downto 0);
			Write_data : in std_logic_vector(15 downto 0);
			Write: in std_logic;
			Read_Data_1 :out std_logic_vector(15 downto 0);
			Read_Data_2 :out std_logic_vector(15 downto 0)
			);
end REGFIL;
  architecture Behavioral of REGFIL is
	type Matrix is array (15 downto 0) of std_logic_vector (15 downto 0);
	signal Data_Matrix : Matrix:= (
0 =>      "1111000011110000" ,
1 =>      "1010101010101010" ,
others => "0000000000000000" ) ;
begin
  process(Read_Register_1 , Read_Register_2 , Write_Register , Write_data , Write )
    begin
      if (Write = '1') then
        Data_Matrix(to_integer(unsigned(Write_Register))) <= Write_data;
    elsif (Write = '0') then
      Read_Data_1 <= Data_Matrix (to_integer(unsigned(Read_Register_1)));
      Read_Data_2 <= Data_Matrix (to_integer(unsigned(Read_Register_2)));
    end if;
  end process;
end behavioral;