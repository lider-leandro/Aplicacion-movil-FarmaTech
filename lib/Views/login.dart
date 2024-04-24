import 'package:flutter/material.dart';
import 'package:flutter_sqlite_auth_app/Components/button.dart';
import 'package:flutter_sqlite_auth_app/Components/colors.dart';
import 'package:flutter_sqlite_auth_app/Components/textfield.dart';
import 'package:flutter_sqlite_auth_app/JSON/users.dart';
import 'package:flutter_sqlite_auth_app/Views/profile.dart';
import 'package:flutter_sqlite_auth_app/Views/signup.dart';

import '../SQLite/database_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Our controllers
  //Controller is used to take the value from user and pass it to database
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  //Login Method
  //We will take the value of text fields using controllers in order to verify whether details are correct or not
  login()async{
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db.authenticate(Users(usrName: usrName.text, password: password.text));
    if(res == true){
      //If result is correct then go to profile or home
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
    }else{
      //Otherwise show the error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Because we don't have account, we must create one to authenticate
                //lets go to sign up

                const Text("INICIO",style: TextStyle(color: primaryColor,fontSize: 40),),
                Image.asset("assets/fondo.jpeg"),
                InputField(hint: "Usuario", icon: Icons.account_circle, controller: usrName),
                InputField(hint: "Contraseña", icon: Icons.lock, controller: password,passwordInvisible: true),

                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text("Recordar"),
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: isChecked,
                    onChanged: (value){
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                ),

                //Our login button
                Button(label: "INICIAR SESION", press: (){
                login();

                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No tiene una cuenta?",style: TextStyle(color: Colors.grey),),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                        },
                        child: const Text("CREAR CUENTA"))
                  ],
                ),

                 // Access denied message in case when your username and password is incorrect
                //By default we must hide it
                 //When login is not true then display the message
                 isLoginTrue? Text("usuario o la contraseña es incorrecta",style: TextStyle(color: Colors.red.shade900),):const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
