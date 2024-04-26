@app.route('/register', methods=['GET', 'POST'])
# def register():
#     msg = ''
#     if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
#         username = request.form['username']
#         password = request.form['password']
#         email = request.form['email']
#         cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
#         cursor.execute(
#             'SELECT * FROM users WHERE username = % s', (username, ))
#         user = cursor.fetchone()
#         if user:
#             msg = 'user already exists !'
#         elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
#             msg = 'Invalid email address !'
#         elif not re.match(r'[A-Za-z0-9]+', username):
#             msg = 'name must contain only characters and numbers !'
#         else:
#             cursor.execute('INSERT INTO users VALUES \
#             (NULL, % s, % s, % s)',
#                            (username, email, password, ))
#             mysql.connection.commit()
#             msg = 'You have successfully registered !'
#             # return jsonify(msg)
#             return render_template("login.html")
#             return f" {msg}"
#     elif request.method == 'POST':
#         msg = 'Please fill out the form !'
#     # return jsonify(msg) 
#     return render_template("register.html", msg=msg )