//
//  ViewModel.swift
//  Weather
//
//  Created by Joao Melo on 26/04/23.
//

import Foundation

struct CurrentWeather: Decodable {
    let temperature: Double
    let weathercode: Int
    let is_day: Int
    
    func background() -> String {
        let background: String
        switch weathercode {
            case 0:
                background = "clear"
            case 1...3:
                background = "mainlyclear"
            case 45, 48:
                background = "fogsky"
            case 51, 53, 55:
                background = "drizzle"
            case 56...57:
                background = "freezingdrizzle"
            case 61, 63, 65, 80, 81:
                background = "moderaterain"
            case 66, 67:
                background = "freezingrain"
            case 71,73,77,85:
                background = "snowyday"
            case 75:
                background = "violentsnowfall"
            case 82:
                background = "heavyshower"
            case 86:
                background = "heavysnowshower"
            default:
                background = "thunderstorm"
        }
        return background + String(is_day)
    }
}

struct Weather: Decodable {
    let current_weather: CurrentWeather
}

struct City: Identifiable {
    let id: Int
    let name: String
    let timeZone: TimeZone
    let latitude: String
    let longitude: String
    var current_weather: CurrentWeather?
    
    func time() -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = self.timeZone
        formatter.dateFormat = "hh:mm a"

        return formatter.string(from: Date())

    }
}

class WeatherViewModel: ObservableObject {
    
    private var cityList: [City] = [City(id: 0, name: "Aarhus", timeZone: TimeZone(identifier: "Europe/Copenhagen")!, latitude: "56.16", longitude: "10.21"), City(id: 1, name: "Taipei", timeZone: TimeZone(identifier: "Asia/Taipei")!, latitude: "25.05", longitude: "121.53"), City(id: 2, name: "Miami", timeZone: TimeZone(identifier: "America/New_York")!, latitude: "25.77", longitude: "-80.19"), City(id: 3, name: "Tokyo", timeZone: TimeZone(identifier: "Asia/Tokyo")!, latitude: "35.69", longitude: "139.69")]
    
    @Published var weatherList: [City] = []
    
    init(){
        fetchWeather()
    }
    
    func fetchWeather() {
        for var city in cityList {
            guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(city.latitude)&longitude=\(city.longitude)&current_weather=true") else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let parsed = try JSONDecoder().decode(Weather.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        city.current_weather = parsed.current_weather
                        self.weatherList.append(city)
                        
                    }
                    
                }
                catch {
                    print("Failed")
                }
            }
            task.resume()
        }
    }
}
