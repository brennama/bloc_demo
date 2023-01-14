

import 'package:dog_app/repository/dog_image_repo.dart';
import 'package:dog_app/screens/bloc/dog_image_events.dart';
import 'package:dog_app/screens/bloc/dog_image_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc
class DogImageBloc extends Bloc<DogImageEvent, DogImageState> {
  final DogImageRepo repository;

  DogImageBloc({required this.repository}) : super(DogImageInitialState()) {
    on<FetchDogImage>((event, emit) async {
      emit(DogImageLoadingState());
      try {
        final dogImage = await repository.fetchRandomDogImage();
        emit(DogImageLoadedState(imageUrl: dogImage));
      } catch(e) {
        emit(DogImageErrorState());
      }
    });
  }
}