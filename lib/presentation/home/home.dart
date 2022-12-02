import 'package:flutter/material.dart';
import 'package:hive_test/app/dependency_injection.dart';
import 'package:hive_test/domain/model/people.dart';
import 'package:hive_test/presentation/home/home_viewmodel.dart';
import 'package:hive_test/presentation/resources/app_resources/app_double.dart';
import 'package:hive_test/presentation/resources/app_resources/app_ints.dart';
import 'package:hive_test/presentation/resources/app_resources/app_strings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _viewModel = getIt<HomeViewModel>();
  final _uuidTextEditCtrl = TextEditingController();
  final _nameTextEditCtrl = TextEditingController();
  final _oldTextEditCtrl = TextEditingController();

  _bind() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel.start();
      _viewModel.showId(_showUuid);
      Future.delayed(const Duration(seconds: AppInts.i1), () {
        _viewModel.fetchPeople();
      });
    });
  }

  _showUuid(String uuid) {
    _uuidTextEditCtrl.text = uuid;
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.ending();
    _uuidTextEditCtrl.dispose();
    _nameTextEditCtrl.dispose();
    _oldTextEditCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDoubles.d10, horizontal: AppDoubles.d20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          decoration: const InputDecoration(
                              label: Text(AppStrings.id),
                              hintText: AppStrings.id),
                          controller: _uuidTextEditCtrl,
                          enabled: false),
                    ),
                    IconButton(
                        onPressed: () {
                          _viewModel.enabledUuid(true);
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                TextField(
                    decoration: const InputDecoration(
                        label: Text(AppStrings.name),
                        hintText: AppStrings.name),
                    controller: _nameTextEditCtrl),
                TextField(
                    decoration: const InputDecoration(
                        label: Text(AppStrings.old), hintText: AppStrings.old),
                    controller: _oldTextEditCtrl),
                ElevatedButton(
                    onPressed: () async {
                      if (_uuidTextEditCtrl.text.isNotEmpty &&
                          _uuidTextEditCtrl.text.isNotEmpty &&
                          _uuidTextEditCtrl.text.isNotEmpty) {
                        await _viewModel.putPeople(
                            _uuidTextEditCtrl.text.trim(),
                            _nameTextEditCtrl.text.trim(),
                            _oldTextEditCtrl.text.trim(),
                            _showUuid);
                        _viewModel.enabledUuid(false);
                        _nameTextEditCtrl.clear();
                        _oldTextEditCtrl.clear();
                      }
                    },
                    child: Text(AppStrings.save.toUpperCase())),
                const Divider(),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<People>>(
                stream: _viewModel.peoplesOutput,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final peoples = snapshot.data;
                    return peoples != null && peoples.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final people = peoples[index];
                              return ListTile(
                                title: Text('${people.name} ${people.old}'),
                              );
                            },
                            itemCount: peoples.length,
                          )
                        : const Center(child: Text(AppStrings.noData));
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text(AppStrings.anErrorOccurred));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
