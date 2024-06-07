import os
import warnings
warnings.simplefilter("ignore")
import tensorflow as tf
from tensorflow.keras.preprocessing import image
from tensorflow.keras.models import load_model
import numpy as np
#import cv2
from flask import Flask, render_template, request, flash, redirect, url_for, session, jsonify, g
from flask_mysqldb import MySQL
import MySQLdb.cursors
import MySQLdb.cursors, re, hashlib
from PIL import Image
from werkzeug.utils import secure_filename
import io
from flask_bcrypt import Bcrypt


app = Flask(__name__)

# Create a Bcrypt Object
bcrypt = Bcrypt(app)

app.secret_key = 'Tomato Disese'

# Connect to the database
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'project_grad'


UPLOAD_FOLDER = 'uploads/'
ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png', 'gif'}
MAX_CONTENT_LENGTH = 2 * 1024 * 1024  # 2 MB

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = MAX_CONTENT_LENGTH

# Ensure the upload folder exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
     

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

#  Preddicting The Disease of the Tomato Plant
@app.route('/predict',methods = ["GET", "POST"])
def upload():
    global result
    if request.method == 'POST':
        if 'file' not in request.files:
        # Debug statement to indicate missing file key
            return jsonify({'error': 'No file part in the request'}), 400
        
        file = request.files['file']
        
        if file.filename == '':
                # Handle the case where no image was uploaded
                return jsonify({'msg': 'No image uploaded'}), 400  # Or any appropriate response
            
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)
        else:
            # Handle the case where no image was uploaded
            return jsonify({'msg': 'No image uploaded'}), 400
        # Make prediction
        preds = model_predict(file_path, model)
        result = preds
        result = str(result).strip()         
        # Store the result in the session
        session['result'] = result

        return jsonify({'result': result})
        # return f" {result}"  
    # return f" {result}"
    return jsonify({'result': result}) 

# Selecting data from Database and Storing in File Json  
@app.route('/select_data', methods=['GET', 'POST'])
def select_data():
    try:
        app.logger.info('Building the messages list...')
        
        # Obtain a cursor from the MySQL connection
        cursor = mysql.connection.cursor()
        
        # Get the value from the upload function
        predict = upload().strip()
        # return predict     
        app.logger.info(f"Predict value: {predict}")
        
        # Your SQL query using the predict value
        sql = """
            SELECT 
                `about_disease`, 
                `preventing_spread`, 
                `protect_healthy_tomato`, 
                `treatment` 
            FROM 
                `treatment` 
            INNER JOIN 
                `tomato_disease` 
            ON 
                treatment.disease_id = tomato_disease.id 
            WHERE 
                `disease_name` =%s
        """        
        # Log the SQL query and predict value
        app.logger.debug(f"Executing SQL query: {sql} with predict value:{predict}")
        
        # Execute the SQL query
        cursor.execute(sql, (predict,))
        result = cursor.fetchone()
        
        # Log the query result
        app.logger.info(f"Query result: {result}")
        
        # Return the query result as a JSON response
        if result:
            return jsonify({'result': result})
        else:
            return jsonify({'result': None})
    except Exception as e:
        # Log any exceptions
        app.logger.error(f"An error occurred: {e}")
        return jsonify({'error': str(e)}), 500




def construct_response( msg, data=None):
    return {
        
            "msg": msg,
        "data": data
    }
   
  
# Verifing the identity of the user based on the credentials provided, such as a username and password.
@app.route('/login', methods=['POST','GET'])
def login():
    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            username = data['username']
            password = data['password']
        elif('username' in request.form and 'password' in request.form ):
            username = request.form['username']
            password = request.form['password']
        
        if username and password:
            hash = password + app.secret_key
            hash = hashlib.sha1(hash.encode())
            password = hash.hexdigest()
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM users WHERE username = %s AND password = %s', (username, password,))
            user = cursor.fetchone()
            if user :
                session['loggedin'] = True
                session['id'] = user['id']
                session['username'] = user['username']
                return jsonify({'msg': 'Logged in successfully!', 'status': 'success'})
            else:
                return jsonify({'msg': 'Incorrect username / password!', 'status': 'error'})
        else:
            return jsonify({'msg': 'Username and password are required', 'status': 'error'})
    else:
        return render_template("login.html") 


 # User Can Sign In Our Application Using username , email, password and Image    
@app.route('/register', methods=['POST','GET'])
def register():
    if request.method == 'POST':
        if request.is_json:
                data = request.get_json()
                username = data['username']
                password = data['password']
                email = data['email']
        else:
                username = request.form['username']
                password = request.form['password'] 
                email = request.form['email']
                
                # Hash a Password
                hash = password + app.secret_key
                hash = hashlib.sha1(hash.encode())
                hashed_password = hash.hexdigest()
                
                # check if the post request has the file part
                if 'file' not in request.files:
                    return jsonify({'error': 'No image file part in the request'}), 400
                
                file = request.files['file']
                if file.filename == '':
                    # Handle the case where no image was uploaded
                    return jsonify({'msg': 'No image uploaded'}), 400  # Or any appropriate response
                
                if file and allowed_file(file.filename):
                    filename = secure_filename(file.filename)
                    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                else:
                    # Handle the case where no image was uploaded
                    return jsonify({'msg': 'No image uploaded'}), 400
                
                if username and password and email:
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
                            cursor.execute('INSERT INTO users (username, email, password, image) VALUES (%s, %s, %s, %s)',
                                            (username, email, hashed_password, filename))
                            mysql.connection.commit()
                            return jsonify({'msg': 'You have successfully registered !', 'status': 'success'})
                else:
                    return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})
    else:
        return render_template("register.html")

#  User Can Loggout From Application
@app.route('/logout', methods = ["POST", "GET"])
def logout():
    if 'loggedin' in session:
        session.pop('loggedin', None)
        session.pop('id', None)
        session.pop('username', None)
        return jsonify({'msg': 'Logged out successfully', 'status': 'success'})
    else:
        msg = "You are not logged in"
        return render_template("login.html", msg = msg)
        



@app.route('/')
def index():
     if 'loggedin' in session:    
        msg = "You are logged in"
        return render_template('index.html', msg=msg)
     else:
        msg = "You are not logged in"
        return render_template('login.html', msg=msg)


    
    
# For Enable the user to edit his personal information
@app.route('/update', methods=['POST','GET'])
def update():
    if 'loggedin' in session:
        if request.method == 'POST':
            if request.is_json:
                data = request.json
                if 'username' in data and 'password' in data and 'email' in data:
                    username = data['username']
                    password = data['password']
                    email = data['email']
                    id = session['id']
                else:
                    return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})    
            else:
                if 'username' in request.form and 'password' in request.form and 'email' in request.form:
                    username = request.form.get('username')
                    password = request.form.get('password')
                    email = request.form.get('email')
                    id = session['id']
                else:
                    return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})   
                # return password     
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM users WHERE id = %s', (id,))
            user = cursor.fetchone()
            # Hash a Password
            hash = 'password' + app.secret_key
            hash = hashlib.sha1(hash.encode())
            hashed_password = hash.hexdigest()
            # return hashed_password

            if user and user['id'] != id:
                return jsonify({'msg': 'User already exists !', 'status': 'error'})
            elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
                return jsonify({'msg': 'Invalid email address !', 'status': 'error'})
            elif not re.match(r'[A-Za-z0-9]+', username):
                return jsonify({'msg': 'Name must contain only characters and numbers !', 'status': 'error'})
            else:
                cursor.execute('UPDATE users SET username = %s, email = %s, password = %s WHERE id = %s',
                            (username, email, hashed_password, id))
                mysql.connection.commit()
                return jsonify({'msg': 'You have successfully updated !', 'status': 'success'})
        else:
            return render_template('update.html') 
    else:
        msg = "You are not logged"
        return render_template('login.html', msg=msg)
    

# showing the profile data for user
@app.route("/display", methods=['POST','GET'])
def display():
    if 'loggedin' not in session:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})

    id = session['id']
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT `id`, `username`, `email`, `image` FROM `users` WHERE id = %s", (id,))
    user = cursor.fetchone()
    cursor.close()
    return jsonify({'User_Data': user, 'status': 'success'})


# Creating Journal To follow-up our plant
@app.route('/create_journal', methods=['POST','GET'])
def create_journal():
    if 'loggedin' in session and 'result' in session:
        if request.method == 'POST':
            if request.is_json:
                data = request.get_json()
                title = data['title']
                plant_age = data['plant_age']
                date = data['date']
            else:
                title = request.form['title']
                plant_age = request.form['plant_age']
                date = request.form['date']
                
                # check if the post request has the file part
                if 'file' not in request.files:
                    return jsonify({'error': 'No image file part in the request'}), 400
                
                file = request.files['file']
                # If the user does not select a file, the browser submits an
                # empty file without a filename.
                if file.filename == '':
                    # Handle the case where no image was uploaded
                    return jsonify({'msg': 'No image uploaded'}), 400  # Or any appropriate response
                
                if file and allowed_file(file.filename):
                    filename = secure_filename(file.filename)
                    file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                    file.save(file_path)
                else:
                    # Handle the case where no image was uploaded
                    return jsonify({'msg': 'No image uploaded'}), 400
                
            user_id = session['id']
            
            # predict = upload()
            Disease_name = session['result'] 
            app.logger.info(f"Query result=======================: {Disease_name}")
            
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            # Your SQL query using the predict value
            sql = " SELECT `treatment_id` FROM `tomato_disease` WHERE `disease_name` = %s "
            
            # Log the SQL query and predict value
            app.logger.debug(f"Executing SQL query: {sql} with predict value: {Disease_name}")
            
            # Execute the SQL query
            cursor.execute(sql, (Disease_name,))
            data = cursor.fetchone()
            app.logger.info(f"Query result=======================: {data}")
            treatment_id = data['treatment_id']
            app.logger.info(f"Query result=======================: {treatment_id}")
                
            cursor.execute('INSERT INTO journals ( `title`, `date`, `Plant_age`, `image`, `Disease_name`, `user_id`, `treatment_id`) VALUES (%s, %s, %s, %s, %s, %s, %s)',
                        (title, date, plant_age, filename, Disease_name, user_id, treatment_id ))
            mysql.connection.commit()
            
            return jsonify({'msg': 'Your Journal Created successfully !', 'status': 'success'})
        
        else:
            return render_template("create_journal.html")
    else:
        msg = "You are not logged in"
        return render_template("login.html", msg=msg)
    
    
# Selecting the saved journals that user can be created based on the user id  
@app.route("/saved_journal", methods=['POST','GET'])
def saved_journal():
    if 'loggedin' not in session:
        return jsonify({'msg': 'You are not logged in', 'status': 'error'})

    id = session['id']
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM journals WHERE user_id = %s", (id,))
    journal = cursor.fetchone()
    cursor.close()
    return jsonify({'Journal_Data': journal, 'status': 'success'})


# Selecting the tasks for the plant's treatment based on the session of disease name
@app.route("/tasks", methods=['POST','GET'])
def tasks():
        if 'loggedin' not in session:
            return jsonify({'msg': 'You are not logged in', 'status': 'error'})

        id = session['id']
        Disease_name = session['result']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        # Your SQL query using the predict value
        sql = ' SELECT `id` FROM `tomato_disease` WHERE `disease_name` = %s '
        
        # Log the SQL query and predict value
        app.logger.debug(f"Executing SQL query: {sql} with predict value: {Disease_name}")
        
        # Execute the SQL query
        cursor.execute(sql, (Disease_name,))
        data = cursor.fetchone()
        app.logger.info(f"Query disease_id =======================: {data}")
        disease_id = data['id']
        sql = "SELECT `one-time`, `immediate`, `frequency-based` FROM `treatment_tasks` WHERE disease_id = %s"
        app.logger.debug(f"Executing SQL query: {sql} with predict value: {disease_id}")
        cursor.execute(sql, (disease_id,))
        journal = cursor.fetchone()
        # Log the query result
        app.logger.info(f"Query result: {journal}")
        
        # Return the query result as a JSON response
        if journal:
            return jsonify({'journal': journal})
        else:
            return jsonify({'journal': None})
 
        
# Enable the user to create additional tasks
@app.route('/add_task', methods=['GET', 'POST'])
def add_task():
    if 'loggedin' not in session:
            return jsonify({'msg': 'You are not logged in', 'status': 'error'})
    if request.method == 'POST':
        if request.is_json:
                data = request.get_json()
                task = data['task']
        else:
                task = request.form['task']
                user_id = session['id']
                Disease_name = session['result']
                # return Disease_name
                cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                # Your SQL query using the predict value
                sql = ' SELECT `id` FROM `tomato_disease` WHERE `disease_name` = %s '  
                # Log the SQL query and predict value
                app.logger.debug(f"Executing SQL query: {sql} with predict value: {Disease_name}")           
                # Execute the SQL query
                cursor.execute(sql, (Disease_name,))
                data = cursor.fetchone()
                app.logger.info(f"Query disease_id =======================: {data}")
                disease_id = data['id']
                
                if task and user_id and disease_id:   
                    cursor.execute('INSERT INTO additional_tasks (task, user_id, disease_id) VALUES (%s, %s, %s)',
                                    (task, user_id, disease_id))
                    mysql.connection.commit()
                    return jsonify({'msg': 'Your task added successfully  !', 'status': 'success'})
                else:
                    return jsonify({'msg': 'Incomplete data provided !', 'status': 'error'})
    else:
        return render_template("add_task.html")       
            

# Selecting the tasks for the plant's treatment based on the session of disease name
@app.route("/select_additional_task", methods=['POST','GET'])
def select_additional_task():
        if 'loggedin' not in session:
            return jsonify({'msg': 'You are not logged in', 'status': 'error'})

        id = session['id']
        Disease_name = session['result']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        # Your SQL query using the predict value
        sql = ' SELECT `id` FROM `tomato_disease` WHERE `disease_name` = %s '
        
        # Log the SQL query and predict value
        app.logger.debug(f"Executing SQL query: {sql} with predict value: {Disease_name}")
        
        # Execute the SQL query
        cursor.execute(sql, (Disease_name,))
        data = cursor.fetchone()
        app.logger.info(f"Query disease_id =======================: {data}")
        disease_id = data['id']
        sql = "SELECT `task` FROM `additional_tasks` WHERE disease_id = %s"
        app.logger.debug(f"Executing SQL query: {sql} with predict value: {disease_id}")
        cursor.execute(sql, (disease_id,))
        task = cursor.fetchone()
        # Log the query result
        app.logger.info(f"Query result: {task}")
        
        # Return the query result as a JSON response
        if task:
            return jsonify({'task': task})
        else:
            return jsonify({'task': None})



if __name__ == "__main__":
    app.run(port=5001, debug=True)
