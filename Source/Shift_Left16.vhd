library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shiftLeft16bit is
 port(
	input:in std_logic_vector(15 downto 0);
	output: out std_logic_vector(15 downto 0)
 );
 end entity;
 
architecture behave of shiftLeft16bit is
 begin
  output <= input(13 downto 0) & '0' & '0' ;
end architecture;

