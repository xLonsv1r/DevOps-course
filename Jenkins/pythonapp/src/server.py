from flask import Flask
server = Flask(__name__)

@server.route("/")
def hello():
    return "Hello World! and CI+Poll SCM and master"

if __name__ == "__main__":
   server.run(host='0.0.0.0', port="5001")