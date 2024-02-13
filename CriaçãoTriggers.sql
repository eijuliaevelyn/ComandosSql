-- Criação de trigger para registrar o valor gasto total.
CREATE OR ALTER TRIGGER [dbo].[TRGRegistrarValorGastoTotal]
ON [Rota]
AFTER INSERT 
    AS
    /* Documentação
    */ 
    BEGIN
        -- Declarando Variáveis.
        DECLARE @IdRota INT,
                @ValorPedagio MONEY,
                @ValorGasolina MONEY,
                @ValorGastoTotal MONEY

        -- Recuperando da tabela Inserted.
        SELECT @IdRota = Id,
               @ValorPedagio = ValorPedagio,
               @ValorGasolina = ValorGasolina
            FROM Inserted

        -- Setando valor para variável @ValorGastoTotal.
        SET @ValorGastoTotal = [dbo].[FNCCalcularCustoTotalRota](@ValorPedagio, @ValorGasolina)

        -- Atualizando com Inserted.
        IF @IdRota IS NOT NULL
            BEGIN
                UPDATE Rota
                    SET ValorGastoTotal = @ValorGastoTotal
                WHERE Id = @IdRota
            END
    END;

-- Criação de trigger para verificar a capacidade do caminhão.
CREATE OR ALTER TRIGGER [dbo].[TRGVerificarCapacidadeCaminhao]
ON [Entrega]
INSTEAD OF INSERT 
    AS
    /* Documentação
    */ 
    BEGIN
        -- Declarando Variáveis.
        DECLARE @IdEntrega INT,
                @IdCaminhao INT
    END;

-- Criação de trigger para concatenar cidade e UF.
CREATE OR ALTER TRIGGER [dbo].[TRGConcatenarCidadeUF]
ON [Cidade]
AFTER INSERT
    AS
    /* Documentação
    */
    BEGIN
        -- Declarando Variáveis.
        DECLARE @IdCidade SMALLINT,
                @CidadeUF VARCHAR (95)

        -- Recurando da Inserted.
        SELECT @IdCidade = Id
            FROM Inserted

        -- Setando valor para variável @CidadeUF.
        SET @CidadeUF = [dbo].[FNCConcatenarCidadeUF](@IdCidade)

        -- Atualizando com a Inseterd.
        IF @IdCidade IS NOT NULL
            BEGIN
                UPDATE Cidade
                    SET CidadeUF = @CidadeUF
                WHERE Id = @IdCidade
            END
    END;

-- Criação de trigger para preencher a idade dos motoristas.
CREATE OR ALTER TRIGGER [dbo].[TRGPreencherIdadeMotorista]
ON [Motorista]
AFTER INSERT
    AS
    /* Documentação
    */
    BEGIN
        -- Declarando Variáveis.
        DECLARE @IdMotorista INT,
                @DataNascimento DATE,
                @Idade TINYINT

        -- Recurando da Inserted.
        SELECT @IdMotorista = Id,
               @DataNascimento = DataNascimento
            FROM Inserted

        -- Setando valor para variável @Idade.
        SET @Idade = [dbo].[FNCCalcularIdadeMotorista](@DataNascimento)

        -- Atualizando com a Inseterd.
        IF @IdMotorista IS NOT NULL
            BEGIN
                UPDATE Motorista
                    SET Idade = @Idade
                WHERE Id = @IdMotorista
            END
    END;