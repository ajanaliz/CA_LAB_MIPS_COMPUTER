----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:38 04/10/2016 
-- Design Name: 
-- Module Name:    multiplier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplier is
GENERIC (n : in INTEGER  :=5);
PORT (
			input1 :in STD_LOGIC_VECTOR ( n-1 DOWNTO 0);
			input2 :in STD_LOGIC_VECTOR ( n-1 DOWNTO 0);
			OUTPUT :OUT STD_LOGIC_VECTOR ( 2*n-1 DOWNTO 0));
end multiplier;

architecture Behavioral of multiplier is
COMPONENT adder_and_subtractor IS
	GENERIC (n : in integer);
	PORT(
	Input1 : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	Input2 : IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	Selector : IN STD_LOGIC;
	Output : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	carry : OUT STD_LOGIC);
	
END COMPONENT;
type twoDArray is array (n-1 downto 0) of STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL andMatrix : twoDArray ;
	SIGNAL procMatrix : twoDArray ;
	SIGNAL carry: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL temp: twoDArray;
begin
outerGen: for i in 0 to n-1 GENERATE
		inneren: for j in 0 to n-1 GENERATE
		andMatrix(i)(j) <=Input1(j) and Input2(i);
		END GENERATE;
END GENERATE;
procMatrix(0) <=andMatrix(0);
carry(0)<='0';
multGEN: for i in 0 to n-2 GENERATE
	output(i) <=procMatrix(i)(0);
	temp(i) <=carry(i)&procMatrix(i)(n-1 DOWNTO 1);
	add: adder_and_subtractor GENERIC MAP(n) PORT MAP(andMatrix(i+1),temp(i),'0',procMatrix(i+1),carry(i+1));
end GENERATE;
output((2*n)-1 downto n-1) <=carry(n-1)&procMatrix(n-1); 
end Behavioral;

