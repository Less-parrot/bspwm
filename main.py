from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

# render_template para poder agregar el o los archivos html, y poderlos retornar en las funciones que lo necesite

app = Flask(__name__)


@app.route("/")
def main():
    # Definimos las variables que podremos usar en nuestra pagina web.
    a = "jejeje, soy python, html y web como estan? Supongo que nunca pensaron verme por aqui"  # string
    i = [True, "juan", "peru", "colombia"]  # lista
    b = [i for i in range(30)]  # bucle de 0 a 29
    titulo = "PythonWar"  # variable para poner titulo a nuestra pagina.

    return render_template("index.html", ass=a, bucle=i, b=b, titulo=titulo)
    # con lo que esta despues de la coma ^ podemos hacer ese tipo de variables para usarlas
    # en los archivos html de la parte frontend de la pagina.
    # Podiendo haci hacer bucles, cnficionales y todo lo que se te ocurra.


if __name__ == "__main__":
    app.run(host='myserver.local')
