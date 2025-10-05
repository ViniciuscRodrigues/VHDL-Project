library IEEE;
use IEEE.std_logic_1164.all;

entity prim_proc_tb is
end prim_proc_tb;

architecture behavior of prim_proc_tb is
  -- Componente a ser testado
  component prim_proc
    port (
      in1, in2, in3, in4 : in std_logic;
      ctrl : in std_logic_vector (1 downto 0);
      sai : out std_logic
    );
  end component;

  -- Sinais para conectar ao componente
  signal s_in1, s_in2, s_in3, s_in4 : std_logic := '0';
  signal s_ctrl : std_logic_vector(1 downto 0) := "00";
  signal s_sai : std_logic;

begin
  -- Instanciando a Unidade Sob Teste (UUT)
  uut : prim_proc
    port map (
      in1 => s_in1,
      in2 => s_in2,
      in3 => s_in3,
      in4 => s_in4,
      ctrl => s_ctrl,
      sai => s_sai
    );

  -- Processo para aplicar os estímulos
  stimulus_proc : process
  begin
    -- Caso 1: Seleciona in1
    s_ctrl <= "00";
    s_in1 <= '1'; s_in2 <= '0'; s_in3 <= '0'; s_in4 <= '0';
    wait for 100 ns;
    s_in1 <= '0';
    wait for 100 ns;

    -- Caso 2: Seleciona in2
    s_ctrl <= "01";
    s_in1 <= '1'; s_in2 <= '1'; s_in3 <= '0'; s_in4 <= '0';
    wait for 100 ns;
    s_in2 <= '0';
    wait for 100 ns;

    -- Caso 3: Seleciona in3
    s_ctrl <= "10";
    s_in1 <= '0'; s_in2 <= '1'; s_in3 <= '1'; s_in4 <= '0';
    wait for 100 ns;
    s_in3 <= '0';
    wait for 100 ns;

    -- Caso 4: Seleciona in4
    s_ctrl <= "11";
    s_in1 <= '0'; s_in2 <= '0'; s_in3 <= '1'; s_in4 <= '1';
    wait for 100 ns;
    s_in4 <= '0';
    wait for 100 ns;

    wait; -- Fim da simulação
  end process;
end behavior;
