import 'package:agucareer/pages/home_page.dart';
import 'package:agucareer/models/user_model.dart';
import 'package:agucareer/pages/sifremi_unuttum_widget.dart';
import 'package:agucareer/viewmodels/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../values/colors.dart';
import '../values/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _mail = "";
  String _pass = "";
  bool _rememberMe = true;

  final storage = new FlutterSecureStorage();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void onSifremiUnuttumPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SifremiUnuttumWidget()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 90.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.acikMor,
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          '      Kullanıcı Girişi       ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      _buildEmailTF(),
                      SizedBox(height: 10.0),
                      _buildPasswordTF(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildRememberMeCheckbox(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildLoginBtn(context),
                      _buildForgotPasswordBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: secondBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (String str) {
              _mail = str;
            },
            style: TextStyle(
              color: AppColors.acikMor,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.acikMor.withOpacity(0.4),
              ),
              hintText: 'E-postanı Gir',
              hintStyle: TextStyle(
                color: AppColors.acikMor.withOpacity(0.4),
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 25.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: secondBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            onChanged: (String str) {
              _pass = str;
            },
            obscureText: true,
            style: TextStyle(
              color: AppColors.acikMor,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: AppColors.acikMor.withOpacity(0.4),
              ),
              hintText: 'Şifreni Gir',
              hintStyle: TextStyle(
                color: AppColors.acikMor.withOpacity(0.4),
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () => this.onSifremiUnuttumPressed(context),
        child: Text(
          'Şifremi Unuttum',
          style: TextStyle(
            color: AppColors.acikMor,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.acikMor),
            child: Checkbox(
              value: _rememberMe,
              activeColor: AppColors.acikMor,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Beni Hatırla',
            style: purpleTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(15.0),
        color: AppColors.acikMor,
        onLongPress: () => onLogInLongPressed(_mail, _pass, context),
        onPressed: () => onLogInPressed(_mail, _pass, context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'GİRİŞ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void onLogInPressed(String mail, String pass, BuildContext context) async {
    updateLoginData();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      User user = await _userModel.signIn(_mail, _pass);
      if (user != null)
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      debugPrint(">>> login_page >>> onLogInPressed >>> ${e.toString()}");
    }
  }

  void onLogInLongPressed(String mail, String pass, BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      await _userModel.createUser(_mail, _pass);
    } catch (e) {
      debugPrint(">>> login_page >>> onLogInLongPressed >>> ${e.toString()}");
    }
  }

  void updateLoginData() async {
    final SharedPreferences prefs = await _prefs;
    if (_rememberMe) {
      await prefs.setBool("_rememberMe", true);
      await storage.write(key: "_mail", value: _mail);
      await storage.write(key: "_pass", value: _pass);
    } else {
      await prefs.setBool("_rememberMe", false);
      await storage.delete(key: "_mail");
      await storage.delete(key: "_pass");
    }
  }

}
