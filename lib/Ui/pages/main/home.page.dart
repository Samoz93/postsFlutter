import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:igor/main.vm.dart';
import 'package:igor/Ui/widgets/err.widget.dart';
import 'package:igor/Ui/widgets/userIcon.widget.dart';
import 'package:stacked/stacked.dart';

class HomePage extends ViewModelWidget<MainViewModel> {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, vm) {
    return Scaffold(
      body: SafeArea(
        child: vm.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : vm.hasError
                ? ErrWidget(err: vm.error)
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (v) {
                            vm.filterKeyWord = v;
                          },
                          decoration: InputDecoration(hintText: "Search"),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: vm.hasData
                            ? ListView.builder(
                                itemCount: vm.data.length,
                                itemBuilder: (context, index) {
                                  final item = vm.data[index];
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        vm.navigate(context, item.id);
                                      },
                                      child: Slidable(
                                        actions: [
                                          IconSlideAction(
                                            onTap: () => vm.delteItem(item.id),
                                            color: Colors.red,
                                            iconWidget: Icon(Icons.delete),
                                          ),
                                        ],
                                        key: Key("${item.id}"),
                                        actionPane: SlidableBehindActionPane(),
                                        closeOnScroll: true,
                                        secondaryActions: [
                                          IconSlideAction(
                                            onTap: () =>
                                                vm.navigate(context, item.id),
                                            color: Colors.grey.shade300,
                                            iconWidget: Icon(Icons.edit),
                                          ),
                                        ],
                                        child: ListTile(
                                          isThreeLine: true,
                                          leading: UserIcon(
                                            userId: item.userIdStr,
                                          ),
                                          title: Text(item.title),
                                          subtitle:
                                              Text(_truncatedText(item.body)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Column(
                                children: [
                                  Center(
                                    child: Text(
                                        "No Results for your search keyword !!"),
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }

  String _truncatedText(String text) {
    final maxLength = 50;
    final length = min((text.length * 0.5).ceil(), maxLength);
    final suffix = text.length > maxLength ? "..." : '';
    return "${text.substring(0, length)} $suffix";
  }
}
