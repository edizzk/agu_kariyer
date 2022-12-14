import 'package:agucareer/pages/profil_page.dart';
import 'package:agucareer/values/values.dart';
import 'package:agucareer/viewmodels/user_model.dart';
import 'package:agucareer/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../values/colors.dart';

class ProfilDuzenleWidget extends StatelessWidget {

  var _nameController = TextEditingController();
  var _workController = TextEditingController();
  var _bioController = TextEditingController();
  var _professionalController = TextEditingController();

  void _updateUserData(BuildContext context) async {
    UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    Map<String, dynamic> map = {
      'name': _nameController.text,
      'bio': _bioController.text,
      'professional': _professionalController.text,
      'company': _workController.text
    };
    bool value = false;
    try {
      value = await _userModel.updateUser(_userModel.user.userID, map);
    } on Exception catch (e) {
      debugPrint("ERROR profil_duzenle_widget _updateUserData: ${e.toString()}");
    }
    if(value){
      await _userModel.currentUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(_userModel.user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    _nameController = TextEditingController(text: _userModel.user.name);
    _workController = TextEditingController(text: _userModel.user.company);
    _bioController = TextEditingController(text: _userModel.user.bio);
    _professionalController = TextEditingController(text: _userModel.user.professional);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 60, right: 60),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.acikMor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  '      Profili D??zenle       ',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InputField.standart(_nameController, "??smini Gir", "??sim:", Icons.person),
              SizedBox(
                height: 20,
              ),
              InputField.standart(_professionalController, "Mesle??ini/B??l??m??n?? Gir", "Meslek / B??l??m:", Icons.work),
              SizedBox(
                height: 20,
              ),
              InputField.standart(_workController, "??al??????t??????n Yeri Gir", "??al????ma Yeri:", Icons.place),
              SizedBox(
                height: 20,
              ),
              InputField.longTextBox(_bioController, "Hakk??nda Anlatmak ??stediklerini Gir", "Hakk??mda:", Icons.add),
              SizedBox(
                height: 30,
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        width: 118,
                        height: 53,
                        margin: EdgeInsets.only(top: 20),
                        child: FlatButton(
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(_userModel.user))),
                          color: AppColors.acikMor.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icon-forward.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Atla",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                        width: 118,
                        height: 53,
                        margin: EdgeInsets.only(top: 20),
                        child: FlatButton(
                          onPressed: () => _updateUserData(context),
                          color: AppColors.acikMor.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/save-icon.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Kaydet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ]
              )
            ],
          )),
    );
  }

}