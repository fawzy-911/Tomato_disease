import os
import warnings
warnings.simplefilter("ignore")
import tensorflow as tf
from tensorflow.keras.preprocessing import image
from tensorflow.keras.models import load_model
import numpy as np
#import cv2
from flask import Flask, render_template, request, redirect, url_for, session, jsonify, g
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re


from flask import Flask, render_template, request
from werkzeug.utils import secure_filename


app = Flask(__name__)
app.secret_key = 'Tomato Disese'

# Connect to the database
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'project_grad'
 
 
mysql = MySQL(app)

#load the trained model
MODEL_PATH = "models/model_inception.h5"
model = load_model(MODEL_PATH)
#class_names = ['Tomato_Bacterial_spot', 'Tomato_Early_blight', 'Tomato_Late_blight', 'Tomato_Leaf_Mold', 'Tomato_healthy']
class_names = ['Bacterial_spot' ,'Early_blight', 'Late_blight' ,'Leaf_Mold' ,'Septoria_leaf_spot' ,'Spider_mites Two-spotted_spider_mite','Target_Spot','Tomato_Yellow_Leaf_Curl_Virus','Tomato_mosaic_virus','Healthy']
def model_predict(img_path, model):

    img = image.load_img(img_path, target_size=(224, 224))

    # Preprocessing the image
    x = image.img_to_array(img)
    x=x/255
    x = np.expand_dims(x, axis=0)

    predictions = model.predict(x)
    label = class_names[np.argmax(predictions[0])]
    return label

@app.route('/predict',methods = ["GET", "POST"])
def upload():
    global result
    if request.method == 'POST':
        f = request.files['file']

        # Save the file to ./uploads
        basepath = os.path.dirname(__file__)
        file_path = os.path.join(
            basepath, 'uploads', secure_filename(f.filename))
        f.save(file_path)

        # Make prediction
        preds = model_predict(file_path, model)
        result = preds
        
        return f" {result}"  
    return f" {result}"   

# Selecting data from Database and Storing in File Json

@app.route('/api/select_data', methods=['GET', 'POST'])
def select_data():
    app.logger.info('Building the messages list...')
    cursor = mysql.connection.cursor()
    predict = upload()
    predict = predict.strip()
    sql = "SELECT `about_disease`, `preventing_spread`, `protect_healthy_tomato`, `treatment` FROM `treatment` INNER JOIN `tomato_disease` ON treatment.disease_id = tomato_disease.id WHERE `disease_name`=% s"

    cols = ['id', 'about_disease', 'preventing_spread', 'protect_healthy_tomato', 'treatment', 'disease_id']
            # cols = ['id' , 'treatment']
    app.logger.debug('Get message with index: {}'.format(cols))
    try:
        output = cursor.execute(sql, (predict, ))
       
        if output == True :
            result = cursor.fetchone()
            return jsonify({'result': result})
        else:
            return "Something Wrong"      
    except Exception as e:
        print("An error occurred:", e)
    
    
 
# Verifing the identity of the user based on the credentials provided, such as a username and password.

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            username = data.get('username')
            password = data.get('password')
        else:
             username = request.form.get('username')
             password = request.form.get('password')
        
        if username and password:
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(
                'SELECT * FROM users WHERE username = % s \
                AND password = % s', (username, password, ))
            user = cursor.fetchone()
            if user:
                session['loggedin'] = True
                session['id'] = user['id']
                session['username'] = user['username']
                return jsonify({'msg': 'Logged in successfully !', 'status': 'success'})
            else:
                return jsonify({'msg': 'Incorrect username / password !', 'status': 'error'})
            
        else:
            return jsonify({'msg': 'Username and password are required', 'status': 'error'})
    else:
        return jsonify({'msg': 'Invalid request', 'status': 'error'})


def construct_response( msg, data=None):
    return {
        
            "msg": msg,
        "data": data
    }
       
       
       
@app.route('/register', methods=['POST'])
def register():
    data = request.json
    if 'username' in data and 'password' in data and 'email' in data:
        username = data['username']
        password = data['password']
        email = data['email']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        user = cursor.fetchone()

        if user:
            return jsonify({'msg': 'User already exists !', 'status': 'error'})
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            return jsonify({'msg': 'Invalid email address !', 'status': 'error'})
        elif not re.match(r'[A-Za-z0-9]+', username):
            return jsonify({'msg': 'Name must contain only characters and numbers !', 'status': 'error'})
        else:
            cursor.execute('INSERT INTO users (username, email, password) VALUES (%s, %s, %s)',
                           (username, email, password))
            mysql.connection.commit()
            return jsonify({'msg': 'You have successfully registered !', 'status': 'success'})
    else:
        return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})

@app.route('/logout')
def logout():
    if 'loggedin' in session:
        session.pop('loggedin', None)
        session.pop('id', None)
        session.pop('username', None)
        return jsonify({'msg': 'Logged out successfully', 'status': 'success'})
    else:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})


@app.route('/')
@app.route('/', methods = ["GET"])
def index():
     if 'loggedin' in session:
        return jsonify({'msg': 'You are logged in', 'status': 'success'})
     else:
         return jsonify({'msg': 'You are not logged in', 'status': 'error'})

# Route to render the update form
@app.route('/update', methods=['GET'])
def update_form():
    if 'loggedin' in session:
        id = session['id']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE id = %s", (id,))
        user = cur.fetchone()
        cur.close()
        return jsonify({'user': user, 'status': 'success'})
    else:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})

@app.route('/update', methods=['POST'])
def update():
    if 'loggedin' in session:
        data = request.json
        if 'username' in data and 'password' in data and 'email' in data and 'id' in data:
            username = data['username']
            password = data['password']
            email = data['email']
            user_id = data['id']

            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
            user = cursor.fetchone()

            if user and user['id'] != user_id:
                return jsonify({'msg': 'User already exists !', 'status': 'error'})
            elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
                return jsonify({'msg': 'Invalid email address !', 'status': 'error'})
            elif not re.match(r'[A-Za-z0-9]+', username):
                return jsonify({'msg': 'Name must contain only characters and numbers !', 'status': 'error'})
            else:
                cursor.execute('UPDATE users SET username = %s, email = %s, password = %s WHERE id = %s',
                               (username, email, password, user_id))
                mysql.connection.commit()
                return jsonify({'msg': 'You have successfully updated !', 'status': 'success'})
        else:
            return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})
    else:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})
    
    


@app.route("/display")
def display():
    if 'loggedin' in session:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM users WHERE id = %s', (session['id'],))
        user = cursor.fetchone()
        cursor.close()
        return jsonify({'User_Data': user, 'status': 'success'})
    else:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})



if __name__ == "__main__":
    app.run(port=5001, debug=True)
