from datetime import *
from crud import *
from conexao import Conexao
resposta = 0

while(resposta!=11):

    print("""
        Opções:
        1- Verificar rota de viagens
        2- Vizualizar histórico de voo por cliente
        3- Verificar reservar de determinado voo
        4- Verificar relatório de vendas por operadora
        5- Atualizar 
        6- Verificar idade cliente
        7- Verificar aniversariantes por data
        8- Visualizar trechos comuns
        9- Visualizar clientes sem voos no ano anterior
        10- Visualizar número de reservas de determinado cliente
        11- Encerrar programa
""")
    resposta = int(input("Selecione uma opção: "))

    if resposta == 1:
        voo = int(input("Insira o voo desejado: "))
        # dataInicio = input("In)

    elif resposta == 2:
        nome = input("Digite o nome do cliente desejado: ")

        
        conn = Conexao.create_server_connection()        

        cursor = conn.cursor()
        query = f"""SELECT A.* FROM VOO A, RESERVA B, CLIENTE C, TRECHO D WHERE A.ID_VOO = D.VOO_ID_VOO AND D.CODIGO_RESERVA = B.CODIGO_RESERVA AND B.CLIENTE_CPF = C.CPF AND NOME LIKE %s;"""
        cursor.execute(query, (nome,))
        
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    
    # elif resposta == 3:

    # elif resposta == 4:
    #     operadora = input("Digite o nome da operadora desejado: ")
    #     dataPagamento = input("Insira a data de pagamento: ")

    #     conn = Conexao.create_server_connection()        

    #     cursor = conn.cursor()
    #     query = f"""SELECT SUM(VALOR) AS SOMA_DOS_PAGAMENTO FROM PAGAMENTO WHERE OPERADORA_CARTAO = %s AND DATA_PAGAMENTO LIKE %s"""
    #     cursor.execute(query, (operadora, dataPagamento))
        
    #     rows = cursor.fetchall()

    #     if rows[0]:
    #         print(rows)
    #         soma_pagamento = float(rows[0][0])
    #         print(f"Soma dos pagamentos para {operadora} na data {dataPagamento}: {soma_pagamento}")
    #     else:
    #         print(f"Nenhum resultado encontrado para {operadora} na data {dataPagamento}")
    # elif resposta == 5:

    # elif resposta == 6:

    elif resposta == 7:
        print("Verificar aniversariantes")
        datastr = input("Digite a data no formato DD/MM/AAAA: ")

        data = datetime.strptime(datastr, '%d/%m/%Y')
        dia = data.day
        mes = data.month

        #cria conexao
        conn = Conexao.create_server_connection()        

        cursor = conn.cursor()
        query = f"""SELECT * FROM CLIENTE WHERE DAY(DATA_NASCIMENTO) = %s AND MONTH(DATA_NASCIMENTO) = %s"""
        cursor.execute(query, (dia, mes))
        
        rows = cursor.fetchall()
        for row in rows:
            print(row)
        
    # elif resposta == 8:

    elif resposta == 9:
        conn = Conexao.create_server_connection()        

        cursor = conn.cursor()
        query = f"""SELECT A.NOME, A.EMAIL FROM CLIENTE A, TRECHO B, RESERVA C WHERE B.CODIGO_RESERVA = C.CODIGO_RESERVA AND C.CLIENTE_CPF = A.CPF AND YEAR(B.DATA_HORA) = YEAR(NOW())-1"""
        cursor.execute(query)
        
        rows = cursor.fetchall()
        print(rows)
        for row in rows:
            print(f"Total de reservas: {row[0]}")



    elif resposta == 10:
        cpf = input("Digite o CPF do cliente desejado: ")      
        dtini = input("Informe a data inicial no formato YYYY-MM-DD: ")
        dtfim = input("Informe a data final no formato YYYY-MM-DD: ")
        conn = Conexao.create_server_connection()        

        cursor = conn.cursor()
        query = f"""SELECT CONTAR_RESERVAS('{cpf}', '{dtini}', '{dtfim}') AS total_reservas"""
        cursor.execute(query)
        
        rows = cursor.fetchall()
        for row in rows:
                print(f"Total de reservas: {row[0]}")

