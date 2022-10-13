import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:scribble/scribble.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = 'Title ///';

  ScrollController _scrollController = ScrollController();
  TextDirection _textDirection = TextDirection.ltr;

  double x = 0;
  double y = 0;
  double z = 0;

  Matrix4 _matrix4 = Matrix4.identity()..setEntry(3, 2, 0.005);

  double _scroll = -100.0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        // splashColor: Colors.red,
        // highlightColor: Colors.red,
      ),
      child: CupertinoApp(
        theme: const CupertinoThemeData(
          barBackgroundColor: CupertinoColors.systemGroupedBackground,
        ),
        home: Directionality(
          textDirection: _textDirection,
          child: CupertinoPageScaffold(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: FilledButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape:
                          MaterialStatePropertyAll(ContinuousRectangleBorder()),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: Text('hit test'),
                    ),
                    onPressed: () {},
                  ),
                  // largeTitle: Row(),
                  // largeTitle: Text(title),
                  // middle: Text(title),
                  stretch: true,
                  border: null,
                ),
                SliverToBoxAdapter(
                  child: ColoredBox(
                    color: CupertinoColors.systemGroupedBackground,
                    child: CupertinoListSection.insetGrouped(
                      children: [
                        CupertinoTextFormFieldRow(
                          onChanged: (value) => setState(() {
                            title = value;
                          }),
                          placeholder: 'title here',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                              child: const Text('scroll'),
                              onPressed: () async {
                                await _scrollController.animateTo(
                                  _scroll,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut,
                                );

                                _scrollController.position.hold(() {});
                              },
                            ),
                            Card(
                              child: Row(
                                children: [
                                  Slider(
                                      min: -500,
                                      max: 0,
                                      value: _scroll,
                                      onChanged: (newScrollTarget) {
                                        setState(() {
                                          _scroll = newScrollTarget;
                                        });
                                      }),
                                  Text(_scroll.toInt().toString()),
                                ],
                              ),
                            )
                          ],
                        ),
                        FilledButton(
                          child: const Text('back'),
                          onPressed: () {
                            _scrollController.position.hold(() {}).cancel();
                          },
                        ),
                        FilledButton(
                          child: const Text('switch LTR/RTL'),
                          onPressed: () {
                            setState(() {
                              _textDirection =
                                  _textDirection == TextDirection.ltr
                                      ? TextDirection.rtl
                                      : TextDirection.ltr;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Transform(
                            transform: _matrix4,
                            alignment: FractionalOffset.center,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                setState(() {
                                  _matrix4
                                    ..rotateX(-details.delta.dy / 500)
                                    ..rotateY(details.delta.dx / 500);
                                });
                              },
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Material(
                                  color: Colors.red,
                                  child: InkWell(
                                    onTap: () {},
                                    child: const FlutterLogo(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // const SliverFillRemaining(
                //   child: ColoredBox(
                //     color: CupertinoColors.systemGroupedBackground,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
