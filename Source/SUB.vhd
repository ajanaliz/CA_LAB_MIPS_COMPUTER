library ieee;
use ieee.std_logic_1164.all;

entity Borrow_Lookahead_Subtractor is
	port(
	       x : in std_logic_vector(3 downto 0);
		     y : in std_logic_vector(3 downto 0);
       		bin : in std_logic;
		     sub : out std_logic_vector(3 downto 0);
		     bout : out std_logic
	);
end Borrow_Lookahead_Subtractor;

architecture BO_BLS of Borrow_Lookahead_Subtractor is
	signal p , g , b : std_logic_vector(3 downto 0);
	begin
		g <= not(x) and y;
		p <= not(x) or y;
		
		b(0) <= bin;
		b(1) <= g(0) or (p(0) and bin);
		b(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and bin);
		b(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and bin);
		
		bout <= g(3) or(p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and bin);
		
		sub <= x xor y xor b;
end BO_BLS;



library ieee;
use ieee.std_logic_1164.all ;

entity Subtractor is 
  port(
        A : in std_logic_vector(15 downto 0) ;
        B : in std_logic_vector(15 downto 0) ;
        F : out std_logic ;
        O : out std_logic_vector(15 downto 0) 
    );
end Subtractor ;

architecture BO_Subtractor of Subtractor is
  
  component Borrow_Lookahead_Subtractor is 
	port(
	       x : in std_logic_vector(3 downto 0);
		     y : in std_logic_vector(3 downto 0);
       		bin : in std_logic;
		     sub : out std_logic_vector(3 downto 0);
		     bout : out std_logic
	);
  end component ;
  
  signal bi : std_logic_vector ( 2 downto 0 ) ;
  
  begin
    
    BLS1 : Borrow_Lookahead_Subtractor port map ( A( 3 downto 0 ) , B( 3 downto 0 ) , '0' , O( 3 downto 0 ) , bi(0) ) ;
    BLS2 : Borrow_Lookahead_Subtractor port map ( A( 7 downto 4 ) , B( 7 downto 4 ) , bi(0) , O( 7 downto 4 ) , bi(1) ) ;
    BLS3 : Borrow_Lookahead_Subtractor port map ( A( 11 downto 8 ) , B( 11 downto 8 ) , bi(1) , O( 11 downto 8 ) , bi(2) ) ;
    BLS4 : Borrow_Lookahead_Subtractor port map ( A( 15 downto 12 ) , B( 15 downto 12 ) , bi(2) , O( 15 downto 12 ) , F ) ;
           
  end BO_Subtractor ;

