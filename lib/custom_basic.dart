import 'package:flutter/material.dart';

class CanvasBasic extends StatelessWidget {
  const CanvasBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //You will see like squart accoding with the size passed to the custompainter
      color: Colors.grey,
      child: CustomPaint(
        painter:
            DoubleRectPainer(), //recived a class that extend from custompainter
        size: const Size(300, 400),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(size.width, size.height),
        paint); /*draw a line from the start or origin
              (left top corner of the container) 
              to the end in this case 
              (right bottom corner of the container)
              becase we passed a offset(x = 0, y = (x= 300, y = 400))*/
  }

  /*This method is called whenever the CustomPainter repaints. if return true, the CustomPainter will be repainted */
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CirclePainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    // paint.style = PaintingStyle.stroke; //To set the style as stroke border, not fill
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40,
        paint); /*Its the same situation, we divide the between two or width and height
      to get the center of the container*/
  }

  /*This method is called whenever the CustomPainter repaints. if return true, the CustomPainter will be repainted */
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RectangulePainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    // paint.style = PaintingStyle.stroke; //To set the style as stroke border, not fill
    // canvas.drawRect(Rect.fromCenter(
    //   center: Offset(size.width / 2, size.height / 2),
    //   width: size.width / 2,
    //   height: size.height / 2),
    //   paint);
    canvas.drawRect(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: 100),
        paint);
    /*get a rectangle in the center of the container*/
  }

  /*This method is called whenever the CustomPainter repaints. if return true, the CustomPainter will be repainted */
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OvalPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    canvas.drawOval(const Rect.fromLTRB(10, 20, 100, 300), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RectWithRadiusPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            const Rect.fromLTWH(10, 20, 100, 300), const Radius.circular(10)),
        paint);
    // canvas.drawRRect(RRect.fromRectAndCorners(const Rect.fromLTWH(10, 20, 100, 300),
    // topLeft: const Radius.circular(10),
    // topRight: const Radius.circular(10),
    // bottomLeft: const Radius.circular(10),
    // bottomRight: const Radius.circular(10)), paint);

    //up
    canvas.drawRRect(
        RRect.fromRectXY(
            Rect.fromCenter(
                center: Offset(size.width - 30, size.height - 30),
                height: 30,
                width: 30),
            30,
            10),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class DoubleRectPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    Rect bigRect = const Rect.fromLTRB(10, 28, 100, 200);
    Rect smallRect = const Rect.fromLTRB(20, 30, 100, 100);
    RRect bigRRect = RRect.fromRectXY(bigRect, 75,25);
    RRect smallRRect = RRect.fromRectXY(smallRect, 75,25);

    canvas.drawDRRect(bigRRect,smallRRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}