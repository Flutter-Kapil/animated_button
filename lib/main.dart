import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Center(
        child: AnimatedButton(),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myController.forward();
        setState(() {});
      },
      child: Container(
        height: 150,
        width: 150,
        color: Colors.grey,
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 3.0).animate(myController),
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }

  void toggleVisible() {
    print('Button clicked');
  }
}
