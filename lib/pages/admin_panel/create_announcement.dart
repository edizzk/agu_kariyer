import 'package:agucareer/models/notification_model.dart';
import 'package:agucareer/values/colors.dart';
import 'package:agucareer/values/constants.dart';
import 'package:agucareer/viewmodels/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateAnnouncement extends StatefulWidget {
  @override
  _CreateAnnouncement createState() => _CreateAnnouncement();
}

class _CreateAnnouncement extends State<CreateAnnouncement> {
  bool _sendToStudent = false;
  bool _sendToMentor = false;
  var _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getCustomAppBar(),
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
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _buildAnnouncementTF(),
                      SizedBox(height: 50.0),
                      _buildCheckBoxsTF(),
                      SizedBox(height: 20.0),
                      _buildSendBtn()
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

  Widget _buildAnnouncementTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            decoration: secondBoxDecorationStyle,
            child: Scrollbar(
              child: TextFormField(
                controller: _controller,
                minLines: 1,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: AppColors.acikMavi,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.announcement,
                    color: AppColors.acikMavi.withOpacity(0.4),
                  ),
                  hintText: 'Duyurunuz',
                  hintStyle: TextStyle(
                    color: AppColors.acikMavi.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
          )
        ]);
  }

  Widget _buildSendBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(15.0),
        color: AppColors.koyuMor.withOpacity(1.0),
        onPressed: () {
          sendIt(context);
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'G??nder',
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

  Widget _buildCheckBoxsTF() {
    return Container(
      height: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Spacer(flex: 1),
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.acikMor),
            child: Checkbox(
              value: _sendToMentor,
              activeColor: AppColors.acikMor,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _sendToMentor = value;
                });
              },
            ),
          ),
          Text(
            'Ment??re Yolla',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: AppColors.acikMor),
          ),
          Spacer(flex: 3),
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.acikMor),
            child: Checkbox(
              value: _sendToStudent,
              activeColor: AppColors.acikMor,
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _sendToStudent = value;
                });
              },
            ),
          ),
          Text(
            '????renciye Yolla',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                color: AppColors.acikMor),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
          ),
          color: AppColors.koyuMor.withOpacity(1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(20),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Text(
              "Duyuru Yap",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendIt(BuildContext context) {
    String receiver = "";
    if (_sendToStudent) receiver = "STUDENT";
    if (_sendToMentor) receiver = "MENTOR";
    if (_sendToStudent && _sendToMentor) receiver = "ALL";

    final _userModel = Provider.of<UserModel>(context, listen: false);
    _userModel.makeAnnouncement(
        Notifications(receiver: receiver, text: _controller.text, type: "ANN"));
  }
}
