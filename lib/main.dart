import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            AnimatedButton(Icons.thumb_down),
            AnimatedButton(Icons.favorite),
            AnimatedButton(Icons.thumb_up), 
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  IconData buttonIcon;
  AnimatedButton(this.buttonIcon);
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  double locationBtnOpacity = 1.0;

  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    //add status listener to get blinking effect
    myController.addStatusListener((AnimationStatus buttonAnimationStatus) {
      if (buttonAnimationStatus == AnimationStatus.completed) {
        myController.reverse();
      } else if (buttonAnimationStatus == AnimationStatus.dismissed) {
        myController.forward();
      }
    });
    myController.addListener(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
        CurvedAnimation(parent: myController, curve: Curves.bounceIn);
    return GestureDetector(
      onTap: () {
        myController.forward();
        setState(() {});
      },
      child: Container(
        height: 150,
        width: 150,
        color: Colors.white,
        child: Transform.scale(
          scale: Tween(begin: 1.0, end: 3.0).transform(smoothAnimation.value),
          child:Icon(widget.buttonIcon,color:Colors.red,size: 40,),
        ),
      ),
    );
  }

  void toggleVisible() {
    print('Button clicked');
  }
}
