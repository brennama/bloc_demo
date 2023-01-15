import 'package:dog_app/repository/dog_image_repo.dart';
import 'package:dog_app/screens/bloc/dog_image_bloc.dart';
import 'package:dog_app/screens/bloc/dog_image_events.dart';
import 'package:dog_app/screens/bloc/dog_image_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogImageScreen extends StatelessWidget {
  const DogImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Looks up the widget tree and finds our instance of our Repo, which
      // was provided in main.dart.
      create: (_) => DogImageBloc(repository: context.read<DogImageRepo>()),
      child: BlocBuilder<DogImageBloc, DogImageState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  // Looks up the widget tree and finds the bloc (in this case
                  // it's just been provided above with our BlocProvider).
                  context.read<DogImageBloc>().add(FetchDogImage());
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: const Text('Cute Frogs Drinking Bubble Tea'),
              ),
              body: Center(
                child: Builder(
                  builder: (_) {
                    if (state is DogImageInitialState) {
                      return const Text('Click the button to see an AI generated image of a frog drinking bubble tea',
                      textAlign: TextAlign.center,);
                    } else if (state is DogImageLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is DogImageLoadedState) {
                      return Image.network(state.imageUrl);
                    } else if (state is DogImageErrorState) {
                      return const Text('Something went wrong, please try again.');
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            );
          },
        ),
    );
  }
}
