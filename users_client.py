from dotenv import dotenv_values
from users import Users

config = dotenv_values(".env")
users_obj = Users(
    host=config["MYSQL_HOST"],
    port=config["MYSQL_PORT"],
    usr=config["MYSQL_USERNAME"],
    pwd=config["MYSQL_PASSWORD"],
    db="usermanagement"
)
users_obj.insert_test_users()



