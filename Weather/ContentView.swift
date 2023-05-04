//
//  ContentView.swift
//  Weather
//
//  Created by Joao Melo on 26/04/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                Text("Weather")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical, 30)
                    VStack {
                        ForEach(viewModel.weatherList) { city in
                            NavigationLink(destination: LocationWeatherView(name: city.name, temperature: city.current_weather!.temperature, background: city.current_weather!.background())) {
                                Image(city.current_weather!.background())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 350, height: 110)
                                    .clipped()
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                                    .opacity(0.8)
                                    .overlay (alignment: .top) {
                                        HStack(alignment: .top) {
                                            VStack(alignment: .leading) {
                                                Text(city.name)
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                Text(city.time())
                                            }
                                            .shadow(radius: 10)
                                            Spacer()
                                            Text(String(format: "%.1f°C", city.current_weather!.temperature))
                                                .font(.largeTitle)
                                                .fontWeight(.light)
                                                .shadow(radius: 10)
                                        }
                                        .padding()
                                        .foregroundColor(.white)
                                        
                                    }
                            }
                            .padding(.bottom, 3)
                            
                        }
                    }
                }
                .padding()
            }
            .padding(.top, 0.1)
            .background(.black)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(.black)
    }
}
