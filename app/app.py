from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<H2>Wecome Here, You like this simpe Flask app?</H2>"

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=True, host='0.0.0.0', port=port)