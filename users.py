import mysql.connector
import hashlib
import random
import string


class Utils:
    @staticmethod
    def generate_password():
        length = 12
        characters = string.ascii_letters + string.digits + string.punctuation
        return ''.join(random.choice(characters) for i in range(length))


class Users:
    def __init__(self, host, port, usr, pwd, db):
        self.__host = host
        self.__port = port
        self.__usr = usr
        self.__pwd = pwd
        self.__db = db

    def __create_connection(self):
        """
        Connect to the MySQL database (replace 'your_database' with your actual database name)

        """
        return mysql.connector.connect(
            host=self.__host,
            port=self.__port,
            user=self.__usr,
            password=self.__pwd,
            database=self.__db
        )

    def read_test_data(self):
        conn = self.__create_connection()
        cursor = conn.cursor()
        cursor.execute("CREATE TABLE mytest1 (id INTEGER PRIMARY KEY)")
        cursor.execute("INSERT INTO mytest1 (id) VALUES (1), (2)")
        cursor.execute("SELECT * FROM mytest1")
        print(cursor.fetchall())
        conn.close()

    def insert_test_users(self):
        conn = self.__create_connection()
        cursor = conn.cursor()

        # Insert 200 users into the Users table
        for user_id in range(1, 201):
            username = f'user{user_id}'
            email = f'user{user_id}@example.com'
            password = Utils.generate_password()  # Replace this with your password hashing logic

            # Replace 'hashed_password_X' with your actual password hashing logic
            hashed_password = hashlib.sha256(password.encode()).hexdigest()

            # SQL insert statement
            sql_insert = f"INSERT INTO Users (Username, Password, Email) VALUES ('{username}', '{hashed_password}', '{email}')"

            # Execute the insert statement
            cursor.execute(sql_insert)

        # Commit the changes and close the connection
        conn.commit()
        conn.close()
