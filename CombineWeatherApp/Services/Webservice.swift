//
//  Webservice.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
// "获取天气数据"

import Foundation
import Combine

class Webservice {
    
    // 获取天气数据
    func fetchWeather(city: String) -> AnyPublisher<Weather?, Error> {
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("Invalid URL")
        }
        
        // 获取天气数据
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ (output) -> Data in
                // 请求失败错误处理
                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .tryCatch({ (error) throws -> AnyPublisher<WeatherResponse, Error> in
                // 抛出异常
                throw error
            })
            .tryMap {
                return $0.lives.first
            }
            .eraseToAnyPublisher()
    }
    
}
