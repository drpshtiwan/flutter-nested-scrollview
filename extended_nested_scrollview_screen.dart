import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';

class CustomNestedScrollViewScreen extends StatefulWidget {
  const CustomNestedScrollViewScreen({Key? key}) : super(key: key);

  @override
  State<CustomNestedScrollViewScreen> createState() =>
      _CustomNestedScrollViewScreenState();
}

class _CustomNestedScrollViewScreenState
    extends State<CustomNestedScrollViewScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    double expandedHeight = 200;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: DefaultTabController(
        length: tabs.length,
        child: Container(
          child: ExtendedNestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.blue.shade900,
                  leading: const Icon(Icons.menu),
                  expandedHeight: expandedHeight,
                  forceElevated: innerBoxIsScrolled,
                  title: const Text(
                    'Extended NestedScrollView',
                    style: TextStyle(color: Colors.white),
                  ),
                  bottom: TabBar(
                      indicatorColor: Colors.yellow,
                      indicatorWeight: 5,
                      labelColor: Colors.white,
                      tabs: tabs.map((String tab) => Tab(text: tab)).toList()),
                )
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return expandedHeight;
            },
            onlyOneScrollInBody: true,
            body: TabBarView(
              children: tabs.map((String tabItem) {
                return TabScreen(tabKey: tabItem);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class TabScreen extends StatefulWidget {
  const TabScreen({
    super.key,
    required this.tabKey,
  });

  final String tabKey;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: PageStorageKey<String>(widget.tabKey),
      slivers: [
        SliverFixedExtentList(
          itemExtent: 100,
          delegate: SliverChildBuilderDelegate((context, index) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Screen Item $index for ${widget.tabKey}'),
              ),
            );
          }),
        )
      ],
    );
  }
}
