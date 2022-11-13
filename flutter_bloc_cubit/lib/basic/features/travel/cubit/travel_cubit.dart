import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/basic/features/travel/model/travel_model.dart';

class TravelCubit extends Cubit<TravelStates> {
  TravelCubit() : super(TravelLoading());

  List<TravelModel> allItems = [];

  Future<void> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1));
    allItems = TravelModel.mockItems;
    emit(TravelItemsLoaded(allItems));
  }

  void searchByItems(String data) {
    final result = allItems.where((element) => element.title.toLowerCase().contains(data.toLowerCase())).toList();
    emit(TravelItemsLoaded(result));
  }

  void seeAllItems() {
    emit(TravelItemsSeeAll([
      ImageEnums.camp_alt.toPathFeed,
      ImageEnums.camp_alt2.toPathFeed,
    ]));
  }
}

abstract class TravelStates {}

class TravelLoading extends TravelStates {}

class TravelItemsLoaded extends TravelStates {
  final List<TravelModel> items;

  TravelItemsLoaded(this.items);
}

class TravelItemsSeeAll extends TravelStates {
  final List<String> images;

  TravelItemsSeeAll(this.images);
}
