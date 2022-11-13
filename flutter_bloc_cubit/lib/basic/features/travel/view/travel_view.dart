import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/basic/features/travel/cubit/travel_cubit.dart';
import 'package:kartal/kartal.dart';

import '../model/travel_model.dart';

class TravelView extends StatelessWidget {
  const TravelView({super.key});

  final _data1 = "Hey John! \n Where do you want to go today?";
  final _data2 = "Popular destination near you";
  final _data3 = "See All";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TravelCubit>(
      create: (context) => TravelCubit()..fetchItems(),
      child: BlocConsumer<TravelCubit, TravelStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
                padding: context.paddingLow,
                child: Column(
                  children: [
                    Text(_data1, style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                    TextField(
                      onChanged: ((value) {
                        return context.read<TravelCubit>().searchByItems(value);
                      }),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    context.emptySizedHeightBoxLow,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_data2, style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                        InkWell(
                          child: Text(_data3, style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                          onTap: () {
                            context.read<TravelCubit>().seeAllItems();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: context.dynamicHeight(0.26), child: _buildItemsCastle(context)),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state is TravelItemsSeeAll ? state.images.length : 0,

                            
                            itemBuilder: (context, index) {
                              final image = (state as TravelItemsSeeAll).images[index];
                              return Image.asset(image);
                            })),
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _buildItemsCastle(BuildContext context) {
    return BlocSelector<TravelCubit, TravelStates, List<TravelModel>>(
        selector: (state) {
          return state is TravelItemsLoaded ? state.items : context.read<TravelCubit>().allItems;
        },
        builder: ((context, state) => ListView.builder(
            itemCount: state.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
                 
              return Card(
                child: SizedBox(
                  width: context.dynamicWidth(0.37),
                  child: Image.asset(state[index].imagePath),
                ),
              );
            })));
  }
}
