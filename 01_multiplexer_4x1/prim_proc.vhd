library IEEE;
use IEEE.std_logic_1164.all;

entity prim_proc is
  port (
    in1, in2, in3, in4 : in std_logic;
    ctrl : in std_logic_vector (1 downto 0);
    sai : out std_logic
  );
end prim_proc;

architecture prim_proc_of of prim_proc is
begin
  process (in1, in2, in3, in4, ctrl)
  begin
    case ctrl is
      when "00" => sai <= in1;
      when "01" => sai <= in2;
      when "10" => sai <= in3;
      when "11" => sai <= in4;
      when others => sai <= 'X'; -- Saída indefinida para outros casos
    end case;
  end process;
end prim_proc_of;
