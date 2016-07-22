library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Sign_E is
	port (
			Data_in : in std_logic_vector(3 downto 0);
			Data_out :out std_logic_vector(15 downto 0)
			);
end Sign_E;
  architecture Behavioral of Sign_E is
    begin
      Data_out (0) <= Data_in (0);
      Data_out (1) <= Data_in (1);
      Data_out (2) <= Data_in (2);
      Data_out (3) <= Data_in (3);
      Data_out (4) <= Data_in (3);
      Data_out (5) <= Data_in (3);
      Data_out (6) <= Data_in (3);
      Data_out (7) <= Data_in (3);
      Data_out (8) <= Data_in (3);
      Data_out (9) <= Data_in (3);
      Data_out (10) <= Data_in (3);
      Data_out (11) <= Data_in (3);
      Data_out (12) <= Data_in (3);
      Data_out (13) <= Data_in (3);
      Data_out (14) <= Data_in (3);
      Data_out (15) <= Data_in (3);
end Behavioral;



