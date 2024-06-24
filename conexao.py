import mysql.connector
from mysql.connector import Error

class Conexao:

    @classmethod
    def create_server_connection(cls):
        connection = None
        try:
            connection = mysql.connector.connect(
                host="localhost",
                user="root",
                passwd="",
                database="agenciaviagens"
            )
            print("MySQL Database connection successful")
        except Error as err:
            print(f"Error: '{err}'")

        return connection