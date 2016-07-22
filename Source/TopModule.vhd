library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity TopModule is
 port(
	CLK : in std_logic 
 );
end TopModule;

architecture behave of TopModule is 

component Ram is
	port (
	  WriteData :in std_logic_vector(15 downto 0);
		Address : in std_logic_vector(4 downto 0);
		Read : in std_logic;
		Write : in std_logic;
		MemData :out std_logic_vector(15 downto 0)
	);
end component;


component REGFIL is
	port (
	    Read_Register_1 :in std_logic_vector(3 downto 0);
			Read_Register_2 :in std_logic_vector(3 downto 0);
			Write_Register :in std_logic_vector(3 downto 0);
			Write_data : in std_logic_vector(15 downto 0);
			Write: in std_logic;
			Read_Data_1 :out std_logic_vector(15 downto 0);
			Read_Data_2 :out std_logic_vector(15 downto 0)
			);
end component;

component INS is
	port (
			Data_in : in std_logic_vector(15 downto 0);
			Source1 :out std_logic_vector(3 downto 0);
			Source2 :out std_logic_vector(3 downto 0);
			Destination :out std_logic_vector(3 downto 0);
			OP_Code :out std_logic_vector(3 downto 0)
			);
end component;


component ALU is 
  port (
    opcode : in std_logic_vector ( 3 downto 0 ) ;
	  register_1 : in std_logic_vector ( 15 downto 0 );
	  register_2 : in std_logic_vector ( 15 downto 0 );
	  carry_flag_sum : out std_logic ;
	  carry_flag_sub : out std_logic ;
	  alu_out : out std_logic_vector ( 15 downto 0 )
	);
	end component;
	
  signal PC , PC_Temp : std_logic_vector ( 15 downto 0 ) := "0000000000000000";  
  signal Opcode , Reg_Address1 , Reg_Address2 , Destiny , Ins_Source1 , Ins_Source2 , Ins_Destiny: std_logic_vector ( 3 downto 0 ) ;
  signal Data_In_Inst , Reg_Read1 , Reg_Read2 , Reg_Write , Alu_Result , Ram_Write_Data , Immediate , Temp1 , Temp2 : std_logic_vector ( 15 downto 0 ) ; 
  signal Reg_Write_Read , Flag_sum , Flag_Sub , Ram_Read , Ram_Write : std_logic ;
  signal Ram_Address : std_logic_vector ( 4 downto 0 ) ;
   
   
type state is (s0 , s1 , s2 ,s3 ,s4 , s5 , s6 , s7 , s8 , s9 , s10 );
    signal curr_S : state := s10 ;

begin

  myALU : ALU port map ( Opcode , Reg_Read1 , Reg_Read2 , Flag_sum , Flag_Sub , Alu_Result ) ;
  myINS : INS port map ( Data_In_Inst , Ins_Source1 , Ins_Source2 , Ins_Destiny , Opcode ) ;
  myRAM : Ram port map ( Ram_Write_Data , Ram_Address , Ram_Read , Ram_Write , Data_In_Inst ) ;
  MyRegisterFIle : REGFIL port map ( Reg_Address1 , Reg_Address2 , Destiny , Reg_Write , Reg_Write_Read , Reg_Read1 , Reg_Read2 ) ;
  
  process(CLK)
    
	   begin
		    case Curr_S is
		        when s0 => 
		          if Opcode(3) = '0' then 
		            PC_Temp <= PC + 1 ;
		            Reg_Address1 <= Ins_Source1 ;
		            Reg_Address2 <= Ins_Source2 ;
		            Reg_Write_Read <= '0' ;            
		            Curr_S <= s1 ;
		          elsif Opcode( 3 downto 1 ) = "100" then
		            PC_Temp <= PC + 1 ;
		            Reg_Address1 <= Ins_Destiny ;
		            Reg_Address2 <= Ins_Destiny ;
		            Reg_Write_Read <= '0' ;
		            Immediate <= Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1 & Ins_Source2 ;		            
		            Curr_S <= s2 ;
		          elsif Opcode = "1100" then
		            Curr_S <= s3 ;
		          elsif Opcode = "1110" then
		            PC_Temp <= PC + 1 ;
		            Temp2( 3 downto 0 ) <= Ins_Source1 ;
		            Reg_Address1 <= Ins_Destiny ;
		            Immediate <= Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) & Ins_Source2 ;
		            Curr_S <= s6 ;	    
		          
		          elsif Opcode = "1101" then
		            PC_Temp <= PC + 1 ;
		            Temp2( 3 downto 0 ) <= Ins_Source1 ;
		            Reg_Address1 <= Ins_Destiny ;
		            Immediate <= Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) &Ins_Source2(3) & Ins_Source2(3) & Ins_Source2(3) & Ins_Source2 ;
		            Curr_S <= s4 ;
		          elsif Opcode( 3 downto 1 ) = "101" then
		            PC_Temp <= PC + 1 ;
		            Reg_Address1 <= Ins_Source1 ;
		            Reg_Address2 <= Ins_Source2 ;
		            Reg_Write_Read <= '0' ;            
		            Immediate <= Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1(3) & Ins_Source1 & Ins_Source2 & '0' ;		            
		            if Opcode(0) = '0' then 
		                Curr_S <= s8 ;	            
		            elsif Opcode(0) = '1' then 
		                Curr_S <= s9 ;
		            end if ;
		          elsif Opcode = "1111" then
		            PC <= "0000000000000000" ;
		            Curr_S <= s10 ;
		          end if ;
		          
		        when s1 => 
		            Destiny <= Ins_Destiny ;
		            Reg_Write <= Alu_Result ;
		            Reg_Write_Read <= '1' ;
		            PC <= PC_Temp ;
		            Curr_S <= s10 ;
		        when s2 => 
		            Destiny <= Ins_Destiny ;  
		            if Opcode(0) = '0' then 
		              Reg_Write <=  Reg_Read1 + Immediate ;
                elsif Opcode(0) = '1' then 
		              Reg_Write <=  Reg_Read1 - Immediate ;
		            end if ;
		            Reg_Write_Read <= '1' ;
		            PC <= PC_Temp ;
		            Curr_S <= s10 ;
		        when s3 => 
		            PC <= PC ( 15 downto 13 ) & Ins_Destiny &  Ins_Source1 & Ins_Source2 & '0' ;
		            Curr_S <= s10 ;
		        when s4 => 
		            Temp1 <= Reg_Read1 + Immediate ;
		            Ram_Address <= Temp1 ( 4 downto 0 ) ;
		            Ram_Read <= '1' ;
		            Ram_Write <= '0' ;
		            Curr_S <= s5 ;
		        when s5 => 
		            Destiny <= Temp2( 3 downto 0 ) ;
		            Reg_Write_Read <= '1' ;
		            Reg_Write <= Data_In_Inst ;
		            PC <= PC_Temp ;
		            Curr_S <= s10 ;
		        when s6 => 
		            Temp1 <= Reg_Read1 + Immediate ; 
                Reg_Address1 <= Temp2( 3 downto 0 ) ;
                Reg_Write_Read <= '0' ;
		            Curr_S <= s7 ;
		        when s7 => 
		            Ram_Write_Data <= Reg_Read1 ;
		            Ram_Address <= Temp1 ( 4 downto 0 ) ;
		            Ram_Read <= '0' ;
		            Ram_Write <= '1' ;
		            PC <= PC_Temp ;
		            Curr_S <= s10 ;
		        when s8 =>
		            if Reg_Read1 = Reg_Read2 then
		                PC <= PC + 2 + Immediate ;
		            else 
		                PC <= PC_Temp ;
		            end if ;
		            
		            Curr_S <= s10 ;
		            
		        when s9 =>
		            if Reg_Read1 > Reg_Read2 then
		                PC <= PC + 2 + Immediate ;
		            else
		                PC <= PC_Temp ;
		            end if ;
		            
		            Curr_S <= s10 ;        
		        when s10 => 
		            Ram_Address <= PC ( 4 downto 0 ) ;
		            Ram_Read <= '1' ;
		            Ram_Write <= '0' ;       
		            Curr_S <= s0 ;
			      when others =>
			  end case ;	
	   end process;

end behave ;
