import 'package:flutter/material.dart';
import 'package:igor/Ui/widgets/btn.widget.dart';
import 'package:igor/Ui/widgets/userIcon.widget.dart';
import 'package:igor/core/Helpers/Cosntants.dart';
import 'package:igor/core/Models/Post.Model.dart';
import 'package:igor/core/Painters/header.painter.dart';
import 'package:igor/main.vm.dart';
import 'package:stacked/stacked.dart';

class DetailsPage extends ViewModelWidget<MainViewModel> {
  final PostModel model;
  DetailsPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, MainViewModel vm) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: HeaderDelegate(
                          userId: model.userIdStr,
                          imageUrl: Constants.MOCK_IMAGE),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          TextFormField(
                            controller: vm.titleCtrl,
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            controller: vm.bodyCtrl,
                            maxLines: 5,
                            textAlign: TextAlign.start,
                          ),
                        ]),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Btn(
                              title: "save",
                              isDisabled: !vm.isEdited,
                              onTap: () async {
                                await vm.editPost(model.id);
                                vm.closePage(context);
                              },
                            ),
                            Btn(
                              title: "close",
                              onTap: () => vm.closePage(context),
                            ),
                          ],
                        )
                      ]),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                      ),
                    )
                  ],
                );
              })),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String userId;
  final String imageUrl;
  const HeaderDelegate({required this.userId, required this.imageUrl});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final perc = 1 - (shrinkOffset / maxExtent);
    final iconSize = 100.0;
    return Stack(
      children: [
        ClipPath(
          clipper: HeaderClipper(perc: perc),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform(
            transform: Matrix4.translationValues(0, iconSize * 0.5 * perc, 0),
            child: UserIcon(
              userId: userId,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
