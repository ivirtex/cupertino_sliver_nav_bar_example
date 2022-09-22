import 'package:flutter/cupertino.dart';

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

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        barBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text(title),
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
                    ],
                  ),
                ),
              ),
              const SliverFillRemaining(
                child: ColoredBox(
                  color: CupertinoColors.systemGroupedBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Next page"),
            stretch: true,
            border: null,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Go back"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
