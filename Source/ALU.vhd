library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_ARITH.all;

entity ALU is 
  port (
    opcode : in std_logic_vector ( 3 downto 0 ) ;
	  register_1 : in std_logic_vector ( 15 downto 0 );
	  register_2 : in std_logic_vector ( 15 downto 0 );
	  carry_flag_sum : out std_logic ;
	  carry_flag_sub : out std_logic ;
	  alu_out : out std_logic_vector ( 15 downto 0 )
	);
	end ALU;
architecture Behavioral of ALU is


component Adder is 
  port(
        A : in std_logic_vector(15 downto 0) ;
        B : in std_logic_vector(15 downto 0) ;
        F : out std_logic ;
        O : out std_logic_vector(15 downto 0) 
    );
end component ;

component Subtractor is 
  port(
        A : in std_logic_vector(15 downto 0) ;
        B : in std_logic_vector(15 downto 0) ;
        F : out std_logic ;
        O : out std_logic_vector(15 downto 0) 
    );
end component ;

signal out_sum : std_logic_vector ( 15 downto 0 ) := "0000000000000000";
signal out_sub : std_logic_vector ( 15 downto 0 ) := "0000000000000000";

signal temp_reg1 , temp_reg2 : std_logic_vector ( 7 downto 0 );


begin
temp_reg1 <= register_1 (7 downto 0);
temp_reg2 <= register_2 (7 downto 0);

Adder1 : Adder port map (register_1 , register_2 , carry_flag_sum , out_sum );
Subtractor1 : Subtractor port map(register_1 , register_2 ,carry_flag_sub , out_sub);

process(opcode,register_1,register_2,out_sum,out_sub)
	begin
		case opcode is
			when "0000" =>
			  alu_out <= out_sum ;

			when "0001" => 
			  alu_out <= out_sub ;
			when "0010" =>
			  alu_out <= register_1 and register_2;
			when "0011" =>
			  alu_out <= register_1 or register_2;
			when "0100" =>
			  alu_out <= temp_reg1 *  temp_reg2 ;
	   	when "0101" =>
--			  alu_out <= temp_reg1 / temp_reg2;
--			when "0110" =>
			  alu_out <= register_1 xor register_2;
			when "0111" =>
			  alu_out <= register_1 nor register_2;
			when others =>
			end case ;	
	end process;
end Behavioral;


			



