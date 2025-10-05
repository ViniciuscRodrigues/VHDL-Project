library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity n_bit_d_tb is
end n_bit_d_tb;

architecture behavior of n_bit_d_tb is
  constant N_TEST : integer := 4; -- Testando para N=4, conforme solicitado no item 4

  -- Sinais
  signal s_input : std_logic_vector(N_TEST - 1 downto 0) := (others => '0');
  signal s_output_proc : std_logic_vector((2**N_TEST) - 1 downto 0);
  signal s_output_gen : std_logic_vector((2**N_TEST) - 1 downto 0);

begin
  -- Instanciação 1: Arquitetura com 'process'
  uut_proc : entity work.n_bit_d(n_bit_d_of)
    generic map (N => N_TEST)
    port map (
      input => s_input,
      output => s_output_proc
    );

  -- Instanciação 2: Arquitetura com 'for-generate'
  uut_gen : entity work.n_bit_d(n_bit_d_generate)
    generic map (N => N_TEST)
    port map (
      input => s_input,
      output => s_output_gen
    );

  -- Processo de estímulo
  stimulus_proc : process
  begin
    -- Itera por todas as 2**N possibilidades de entrada
    for i in 0 to (2**N_TEST) - 1 loop
      s_input <= std_logic_vector(to_unsigned(i, N_TEST));
      wait for 50 ns;
    end loop;
    wait;
  end process;

end behavior;