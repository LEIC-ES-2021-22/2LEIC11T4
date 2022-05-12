import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';
import 'package:uni/view/Widgets/schedule_slot.dart';
import 'package:url_launcher/url_launcher.dart';

/// Manages the 'paperwork' sections of the app
class ErasmusPaperworkView extends StatelessWidget {
  ErasmusPaperworkView(
      {Key key,
        @required this.tabController,
        @required this.tabBarContent,
        @required this.text,
        this.scrollViewController});

  final List<String> tabBarContent;
  final List<String> text;
  final TabController tabController;
  final ScrollController scrollViewController;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Column(children: <Widget>[
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PageTitle(name: 'Paperwork'),
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: createTabs(queryData, context),
          ),
        ],
      ),
      Expanded(
          child: TabBarView(
            controller: tabController,
            children: createPaperwork(context),
          ))
    ]);
  }

  /// Returns a list of widgets empty with tabs for each day of the week.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < tabBarContent.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width * 1 / 3,
        child: Tab(key: Key('paperwork-page-tab-$i'), text: tabBarContent[i]),
      ));
    }
    return tabs;
  }

  List<Widget> createPaperwork(context) {
    final List<Widget> tabBarViewContent = <Widget>[];
    for (int i = 0; i < tabBarContent.length; i++) {
      tabBarViewContent.add(createTabBody(context, i));
    }
    return tabBarViewContent;
  }


  Widget Function(dynamic textContent, BuildContext context) displayTabContent(
      int i) {
    Widget tabContent(textContent, BuildContext context) {
      return Container(
          key: Key('paperwork-page-day-column-$i'),
          child: ListView(
            children: <Widget>[
              Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: textContent.length / 24,
                        right: textContent.length / 24,
                        top: textContent.length / 24,
                        bottom: textContent.length / 24),
                    child: Column(children: <Widget>[
                      MarkdownBody(
                        styleSheet: MarkdownStyleSheet(),
                        shrinkWrap: false,
                        data: textContent,
                        onTapLink: (text, url, title) async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          }
                        },
                      ),
                    ]),
                  ))
            ],
          )
      );
    }

    return tabContent;
  }

  Widget createTabBody(BuildContext context, int i) {
    return RequestDependentWidgetBuilder(
      context: context,
      contentGenerator: displayTabContent(i),
      content: text[i],
      contentChecker: text[i].isNotEmpty,
      onNullContent:
      Center(child: Text('Página em construção...')),
      index: i,
    );
  }
}
