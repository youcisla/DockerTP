from flask import Flask, jsonify
import mysql.connector
import os
from dotenv import load_dotenv

app = Flask(__name__)

# MySQL configuration
# Load environment variables from .env file
load_dotenv()

db_config = {
    'host': 'mysql',
    'user': 'root',
    'password': os.getenv('MYSQL_ROOT_PASSWORD'),
    'database': os.getenv('MYSQL_DATABASE'),
    'port': 3306
}

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

@app.route('/data')
def data():
    try:
        connection = mysql.connector.connect(**db_config)
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM test_table")
        result = cursor.fetchall()
        return jsonify({"data": result}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'connection' in locals() and connection.is_connected():
            connection.close()

@app.route('/debug-db')
def debug_db():
    try:
        connection = mysql.connector.connect(**db_config)
        if connection.is_connected():
            return jsonify({"status": "connected"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        if 'connection' in locals() and connection.is_connected():
            connection.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4743, debug=True)