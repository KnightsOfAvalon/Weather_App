import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/WeatherModel.dart';
import 'package:weather_app/WeatherRepo.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {


}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class WeatherNotSearched extends WeatherState {

}

class WeatherIsLoading extends WeatherState {

}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherNotLoaded extends WeatherState {

}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(WeatherState initialState, this.weatherRepo) : super(WeatherNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    // TODO: implement mapEventToState
    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch(_) {
        yield WeatherNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherNotSearched();
    }
  }

}