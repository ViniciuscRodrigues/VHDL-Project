library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity transmissor is
  port (
    clock : in std_logic;
    reset : in std_logic;
    send : in std_logic;
    palavra : in std_logic_vector(7 downto 0);
    busy : out std_logic;
    linha : out std_logic
  );
end entity transmissor;

architecture fsm of transmissor is
  -- Definindo os estados da máquina
  type state_t is (ST_IDLE, ST_START, ST_DATA, ST_STOP);
  signal state_reg, state_next : state_t;

  -- Registros internos
  signal p_reg : std_logic_vector(7 downto 0);
  signal b_count : unsigned(2 downto 0);

begin
  -- Processo sequencial (registros e transição de estados)
  process (clock, reset)
  begin
    if reset = '1' then
      state_reg <= ST_IDLE;
      b_count <= (others => '0');
      p_reg <= (others => '0');
    elsif rising_edge(clock) then
      state_reg <= state_next;

      -- Lógica dos registros baseada no estado ATUAL
      case state_reg is
        when ST_IDLE =>
          if send = '1' then
            p_reg <= palavra; -- Carrega a palavra
          end if;

        when ST_START =>
          b_count <= "111"; -- Inicia o contador de bits em 7

        when ST_DATA =>
          b_count <= b_count - 1; -- Decrementa o contador

        when ST_STOP =>
          -- Nenhum registro precisa ser atualizado aqui
      end case;
    end if;
  end process;

  -- Processo combinacional (lógica do próximo estado e saídas)
  process (state_reg, send, b_count)
  begin
    -- Valores padrão
    state_next <= state_reg;
    linha <= '1'; -- Linha em repouso por padrão

    case state_reg is
      when ST_IDLE =>
        linha <= '1';
        if send = '1' then
          state_next <= ST_START;
        end if;

      when ST_START =>
        linha <= '0'; -- Start bit
        state_next <= ST_DATA;

      when ST_DATA =>
        linha <= p_reg(to_integer(b_count)); -- Envia o bit de dado
        if b_count = "000" then
          state_next <= ST_STOP;
        else
          state_next <= ST_DATA;
        end if;

      when ST_STOP =>
        linha <= '1'; -- Stop bit
        state_next <= ST_IDLE;

    end case;
  end process;

  -- Saída 'busy' (atribuição concorrente conforme a dica)
  -- 'busy' está ativo em todos os estados, exceto IDLE.
  busy <= '0' when state_reg = ST_IDLE else '1';

end architecture fsm;
