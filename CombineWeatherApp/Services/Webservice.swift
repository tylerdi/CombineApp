//
//  Webservice.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
// "获取天气数据"

import Foundation
import Combine

class Webservice{
    
    // 获取天气数据
    func fetchWeather(city: String) -> AnyPublisher<Weather,Error> {
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("Invalid URL")
        }
        // 获取天气数据
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map{
                if let tmpWeahter = $0.lives.first {
                    return tmpWeahter
                } else {
                    return Weather(province: "", city: "", weather: "", temperature: "", winddirection: "", windpower: "", humidity: "", reporttime: "")
                }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
