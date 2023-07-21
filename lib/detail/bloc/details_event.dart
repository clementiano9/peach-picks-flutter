part of './details_bloc.dart';

abstract class DetailsEvent {}

class DetailsLoaded extends DetailsEvent {
}

class PlayPress extends DetailsEvent {}