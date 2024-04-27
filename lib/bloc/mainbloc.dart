import 'dart:async';
import 'package:bookapp/model/bookdatamodel.dart';
import 'package:bookapp/model/booksearchmodel.dart';
import 'package:bookapp/utils/helperclass.dart';
import 'package:bookapp/utils/initializerclass.dart';
import 'package:bookapp/utils/miscclass.dart';
import 'package:bookapp/utils/serverhelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<FetchBookData>(fetchBookData);
    on<SearchBooks>(searchBooks);
  }

  Future<FutureOr<void>> fetchBookData(
      FetchBookData event, Emitter<MainState> emit) async {
    try {
      emit(LoadingBookData());
      Initializer.bookDataModel = BookDataModel.fromJson(
          await ServerHelper4466.get(
              'https://openlibrary.org/people/mekBot/books/already-read.json'));
      if (Initializer.bookDataModel!.numFound! > 0) {
        emit(BookDataFetched());
      } else {
        emit(BookDataNotFound());
      }
    } catch (e) {
      emit(BookDataNotFetched());
      Helper.showLog('Something went wrong $e');
    }
  }

  Future<FutureOr<void>> searchBooks(
      SearchBooks event, Emitter<MainState> emit) async {
    try {
      if (!Misc.isEmpty(event.query)) {
        emit(SearhcingBooks());
        Initializer.bookSearchModel = BookSearchModel.fromJson(
            await ServerHelper4466.get(
                'https://openlibrary.org/search.json?title=${event.query}'));
        if (Initializer.bookSearchModel!.numFound! > 0) {
          emit(BooksFound(query: event.query));
        } else {
          emit(BooksNotFound());
        }
      } else {
        emit(NoSearch());
      }
    } catch (e) {
      emit(SearhcingBooksFailed());
      Helper.showLog('Something went wrong $e');
    }
  }
}

class MainEvent {}

class MainState {}

class FetchBookData extends MainEvent {}

class LoadingBookData extends MainState {}

class BookDataFetched extends MainState {}

class BookDataNotFound extends MainState {}

class BookDataNotFetched extends MainState {}

// search books
class SearchBooks extends MainEvent {
  final String? query;
  SearchBooks({required this.query});
}

class SearhcingBooks extends MainState {}

class BooksFound extends MainState {
  final String? query;
  BooksFound({required this.query});
}

class BooksNotFound extends MainState {}

class NoSearch extends MainState {}

class SearhcingBooksFailed extends MainState {}
