-- Criação de function para calcular custo total da rota.
CREATE OR ALTER FUNCTION [dbo].[FNCCalcularCustoTotalRota](
    @ValorPedagio MONEY,
    @ValorGasolina MONEY
)
    RETURNS MONEY
    AS
    /* Documentação
    */
    BEGIN
        RETURN
            (@ValorPedagio + @ValorGasolina)
    END;

-- Criação de function para calcular a idade do mototrista.
CREATE OR ALTER FUNCTION [dbo].[FNCCalcularIdadeMotorista](
    @DataNascimento DATE
)
    RETURNS TINYINT
    AS
    /* Documentação
    */
    BEGIN
        RETURN
            (SELECT DATEDIFF(DAY, @DataNascimento, GETDATE()) / 365.25)
    END;

-- Criação de function para obter o número de entregas em determinado mês.
CREATE OR ALTER FUNCTION [dbo].[FNCRelatorioEntregas](
    @DataEntrega DATE
)
    RETURNS TABLE
    AS
    /* Documentação
    */
    RETURN
        (SELECT COUNT(Id) AS 'Quantidade de Entregas'
            FROM Entrega
                WHERE DataEntrega = DATEPART(MONTH, @DataEntrega))

-- Criação de function para verificar se o caminhão está disponível.
CREATE OR ALTER FUNCTION [dbo].[FNCVerificarDisponibilidadeCaminhao](
    @IdCaminhao INT,
    @DataRequerida DATE
)
    RETURNS VARCHAR
    AS
    /* Documentação
    */ 
    BEGIN
        (SELECT C.Modelo
            FROM Caminhao C
                WHERE NOT EXISTS (SELECT IdCaminhao
                                    FROM Entrega
                                        WHERE IdCaminhao = @IdCaminhao AND DataEntrega < @DataRequerida))
    END;

-- Criação de function para calcular a hora de chegada.
CREATE OR ALTER FUNCTION [dbo].[FNCCalcularHoraChegada](
    @IdEntrega INT
)
    RETURNS TIME
    AS 
    /* Documentação
    */ 
    BEGIN
        RETURN
            (SELECT DATEADD(HOUR, R.TempoEstimado, E.HoraPartida)
                FROM Entrega E
                    INNER JOIN Rota R
                ON R.Id = E.IdRota
                    WHERE E.IdEntrega = @IdEntrega)
    END;

-- Criação de function para concatenar cidade com UF.
CREATE OR ALTER FUNCTION [dbo].[FNCConcatenarCidadeUF](
    @IdCidade SMALLINT
)
    RETURNS VARCHAR (95)
    AS
    /* Documentação
    */
    BEGIN
        (SELECT CONCAT(C.Nome, '-', UF.Sigla)
            FROM Cidade C
                INNER JOIN UF
            ON UF.Id = C.IdUF
                WHERE C.Id = @IdCidade)
    END;
