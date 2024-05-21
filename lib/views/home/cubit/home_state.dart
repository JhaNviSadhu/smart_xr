part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class ShowButton extends HomeState {}

class HideButton extends HomeState {}

class RadioButtonChange extends HomeState {}

class HomeDataLoading extends HomeState {}

class HomeDataSuccess extends HomeState {}

class HomeDataError extends HomeState {}
