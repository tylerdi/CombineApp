//
//  Weather.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
//  "天气数据model"

import Foundation

/**
 实况天气
 https://restapi.amap.com/v3/weather/weatherInfo?city=110101&key=b1089c8e3a4bdd58ee3f1655092e54f7
 
 {
 "status": "1",
 "count": "1",
 "info": "OK",
 "infocode": "10000",
 "lives": [
             {
                 "province": "北京",
                 "city": "东城区",
                 "adcode": "110101",
                 "weather": "晴",
                 "temperature": "12",
                 "winddirection": "西",
                 "windpower": "≤3",
                 "humidity": "12",
                 "reporttime": "2023-04-07 10:50:26",
                 "temperature_float": "12.0",
                 "humidity_float": "12.0"
             }
     ]
 }
 
 预报天气
 https://restapi.amap.com/v3/weather/weatherInfo?extensions=all&city=110000&key=b1089c8e3a4bdd58ee3f1655092e54f7
 
 {
 "status": "1",
 "count": "1",
 "info": "OK",
 "infocode": "10000",
 "forecasts": [
             {
             "city": "北京市",
             "adcode": "110000",
             "province": "北京",
             "reporttime": "2023-04-07 12:20:33",
             "casts": [
             {
             "date": "2023-04-07",
             "week": "5",
             "dayweather": "晴",
             "nightweather": "晴",
             "daytemp": "16",
             "nighttemp": "4",
             "daywind": "西北",
             "nightwind": "西",
             "daypower": "4",
             "nightpower": "≤3",
             "daytemp_float": "16.0",
             "nighttemp_float": "4.0"
             },
             {
             "date": "2023-04-08",
             "week": "6",
             "dayweather": "晴",
             "nightweather": "多云",
             "daytemp": "20",
             "nighttemp": "8",
             "daywind": "西南",
             "nightwind": "西南",
             "daypower": "4",
             "nightpower": "≤3",
             "daytemp_float": "20.0",
             "nighttemp_float": "8.0"
             },
             {
             "date": "2023-04-09",
             "week": "7",
             "dayweather": "晴",
             "nightweather": "晴",
             "daytemp": "23",
             "nighttemp": "10",
             "daywind": "南",
             "nightwind": "西南",
             "daypower": "≤3",
             "nightpower": "≤3",
             "daytemp_float": "23.0",
             "nighttemp_float": "10.0"
             },
             {
             "date": "2023-04-10",
             "week": "1",
             "dayweather": "晴",
             "nightweather": "晴",
             "daytemp": "26",
             "nighttemp": "10",
             "daywind": "西南",
             "nightwind": "西北",
             "daypower": "4",
             "nightpower": "≤3",
             "daytemp_float": "26.0",
             "nighttemp_float": "10.0"
             }
         ]
     }
 ]
 }
 */

struct WeatherResponse: Codable {
    var status: String = ""
    var count: String = ""
    var info: String = ""
    var infocode: String = ""

    // 天气数据
    var lives: [Weather] = []
}

// 省份、城市、天气和温度相关信息
struct Weather: Identifiable {
    var id = UUID()
    // 省份名
    var province: String = ""
    
    // 城市名
    var city: String = ""
    
    // 天气现象（汉字描述）
    var weather: String = ""
    
    // 实时气温，单位：摄氏度
    var temperature: String = ""
    
    // 风向描述
    var winddirection: String = ""
    
    // 风力级别，单位：级
    var windpower: String = ""
    
    // 空气湿度
    var humidity: String = ""
    
    // 数据发布的时间
    var reporttime: String = ""
}

// 映射
extension Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case province
        case city
        case weather
        case temperature
        case winddirection
        case windpower
        case humidity
        case reporttime
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        province = try values.decode(String.self, forKey: .province)
        city = try values.decode(String.self, forKey: .city)
        weather = try values.decode(String.self, forKey: .weather)
        temperature = try values.decode(String.self, forKey: .temperature)
        winddirection = try values.decode(String.self, forKey: .winddirection)
        windpower = try values.decode(String.self, forKey: .windpower)
        humidity = try values.decode(String.self, forKey: .humidity)
        reporttime = try values.decode(String.self, forKey: .reporttime)
    }
}
