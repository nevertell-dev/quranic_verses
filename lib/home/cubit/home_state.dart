part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.chapters);

  final List<Chapter> chapters;

  @override
  List<Object> get props => [chapters];
}
