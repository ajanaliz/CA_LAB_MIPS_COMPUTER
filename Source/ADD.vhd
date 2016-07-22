library ieee;
use ieee.std_logic_1164.all ;

entity Carry_Lookahead_Adder is 
  port(
        x : in std_logic_vector(3 downto 0) ;
        y : in std_logic_vector(3 downto 0) ;
        cin : in std_logic ;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic  
    );
end Carry_Lookahead_Adder ;

architecture BO_CLA of Carry_Lookahead_Adder is
  
  signal p , g , c : std_logic_vector( 3 downto 0 ) ;
  
  begin
    
    g <= x and y ;
    p <= x xor y ;
    
    c(0) <= cin ;
    c(1) <= g(0) or (p(0) and cin);
		c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
		c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
		
		cout <= g(3) or(p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and cin);
		
		sum <= p xor c;
    
end BO_CLA;



library ieee;
use ieee.std_logic_1164.all ;

entity Adder is 
  port(
        A : in std_logic_vector(15 downto 0) ;
        B : in std_logic_vector(15 downto 0) ;
        F : out std_logic ;
        O : out std_logic_vector(15 downto 0) 
    );
end Adder ;

architecture BO_Adder of Adder is
  
  component Carry_Lookahead_Adder is 
   port(
        x : in std_logic_vector(3 downto 0) ;
        y : in std_logic_vector(3 downto 0) ;
        cin : in std_logic ;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic 
 
    );
  end component ;
  
  signal cin : std_logic_vector ( 2 downto 0 ) ;
  
  begin
    
    CLA1 : Carry_Lookahead_Adder port map ( A( 3 downto 0 ) , B( 3 downto 0 ) , '0' , O( 3 downto 0 ) , cin(0) ) ;
    CLA2 : Carry_Lookahead_Adder port map ( A( 7 downto 4 ) , B( 7 downto 4 ) , cin(0) , O( 7 downto 4 ) , cin(1) ) ;
    CLA3 : Carry_Lookahead_Adder port map ( A( 11 downto 8 ) , B( 11 downto 8 ) , cin(1) , O( 11 downto 8 ) , cin(2) ) ;
    CLA4 : Carry_Lookahead_Adder port map ( A( 15 downto 12 ) , B( 15 downto 12 ) , cin(2) , O( 15 downto 12 ) , F ) ;
    
       
  end BO_Adder ;

