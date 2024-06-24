import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/counter_bloc.dart';
import 'package:flutter_block/user_bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc()..add(CounterDecEvent());
    final userBloc = UserBloc();
    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(create: (context) => counterBloc),
          BlocProvider<UserBloc>(create: (context) => userBloc)
        ],
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    counterBloc.add(CounterIncEvent());
                  },
                  icon: const Icon(Icons.plus_one)),
              IconButton(
                  onPressed: () {
                    counterBloc.add(CounterDecEvent());
                  },
                  icon: const Icon(Icons.exposure_minus_1)),
              IconButton(
                  onPressed: () {
                    userBloc.add(UserGetUsersEvent(counterBloc.state));
                  },
                  icon: const Icon(Icons.person)),
              IconButton(
                  onPressed: () {
                    userBloc.add(UserGetJobEvent(counterBloc.state));
                  },
                  icon: const Icon(Icons.work))
            ],
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  BlocBuilder<CounterBloc, int>(
                      bloc: counterBloc,
                      builder: (context, state) {
                        return Text(state.toString(),
                            style: const TextStyle(fontSize: 33));
                      }),
                  BlocBuilder<UserBloc, UserState>(
                      bloc: userBloc,
                      builder: (context, state) {
                        final users = state.users;
                        final jobs = state.job;
                        return Column(
                          children: [
                            if (state.isLoading)
                              const CircularProgressIndicator(),
                            if (users.isNotEmpty)
                              ...state.users.map((e) => Text(e.name)),
                            if (jobs.isNotEmpty)
                              ...state.job.map((e) => Text(e.name))
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
