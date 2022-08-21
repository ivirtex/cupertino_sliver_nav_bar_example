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
  String title = 'Title';

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        barBackgroundColor: CupertinoColors.systemBackground,
      ),
      home: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              leading: const Icon(CupertinoIcons.person_2),
              largeTitle: Text(title),
              trailing: const Icon(CupertinoIcons.add_circled),
              stretch: true,
              border: null,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoSearchTextField(
                  onChanged: (value) => setState(() => title = value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
