import 'package:flutter/material.dart';

class AnimatedSlideShow extends StatefulWidget {
  List<String> data = ['First Slide', 'Second Slide', 'Third Slide'];

  @override
  _AnimatedSlideShowState createState() => _AnimatedSlideShowState();
}

class _AnimatedSlideShowState extends State<AnimatedSlideShow> {
  int _activeCard;
  final double blur = 30;
  final double offset = 20;
  final double top = 100;
  final double noBlur = 0;
  final double noOffset = 0;
  final double noTop = 200;
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(viewportFraction: 0.8);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.round();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.data.length,
              controller: _pageController,
              itemBuilder: (context, int position) {
                if (_currentPage == position) {
                  return AnimatedCard(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.green]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: blur,
                              offset: Offset(offset, offset))
                        ]),
                    blur: blur,
                    offset: offset,
                    top: top,
                    child: Center(
                        child: Text(
                      widget.data[position],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    )),
                  );
                } else {
                  return AnimatedCard(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.black]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: blur,
                              offset: Offset(offset, offset))
                        ]),
                    blur: noBlur,
                    offset: noOffset,
                    top: noTop,
                    child: Center(
                        child: Text(
                      widget.data[position],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w100),
                    )),
                  );
                }
              })),
    );
  }
}

class AnimatedCard extends StatefulWidget {
  final double blur;
  final double offset;
  final double top;
  Widget child;
  Decoration decoration;

  AnimatedCard(
      {Key key,
      @required this.child,
      @required this.blur,
      @required this.offset,
      @required this.decoration,
      @required this.top})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnimatedCardState();
  }
}

class _AnimatedCardState extends State<AnimatedCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: EdgeInsets.only(top: widget.top, bottom: 50, right: 20, left: 20),
      decoration: widget.decoration,
      child: widget.child,
    );
  }
}
