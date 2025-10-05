library IEEE;
use IEEE.std_logic_1164.all;
entity transmissor_tb is
end transmissor_tb;
architecture transmissor_tb of transmissor_tb is
signal busy, linha, reset, send: std_logic;
signal clock: std_logic:='0';
signal palavra : std_logic_vector(7 downto 0);
begin
UUT : entity work.transmissor port map (clock => clock, reset => reset, send => send,
palavra => palavra, busy => busy, linha => linha);
process
begin
clock <= '1' after 10 ns, '0' after 20 ns;
wait for 20 ns;
end process;
reset <= '1', '0' after 3 ns, '1' after 240 ns, '0' after 243 ns;
send <= '0', '1' after 23 ns, '0' after 50 ns, '1' after 240 ns, '0' after 280 ns;
palavra <= "11010001", "00100110" after 150 ns;
end transmissor_tb;