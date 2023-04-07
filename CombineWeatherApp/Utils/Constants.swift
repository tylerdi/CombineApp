//
//  Constants.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
//  "定义常量"

import Foundation

 /*
  key  - 请求服务权限标识 b1089c8e3a4bdd58ee3f1655092e54f7
  city - 城市编码,城市的adcode，adcode信息可参考城市编码表
  
  city = 110000 Beijing
  city = 310000 Shanghai
  city = 440100 Guangzhou
  city = 440300 Shenzhen
  city = 320500 Suzhou
  city = 210100 Shengyang
*/

struct Constants {
    struct URLs{
        // 拼接城市id,返回完整的url
        static func weather(city: String) -> String {
            
            /**
            注： extensions : 气象类型 base:返回实况天气 all:返回预报天气
            如果需要明天的天气数据需要添加参数 extensions=all
            let url =  "https://restapi.amap.com/v3/weather/weatherInfo?extensions=all&city=\(city)&key=b1089c8e3a4bdd58ee3f1655092e54f7"
             */
            return "https://restapi.amap.com/v3/weather/weatherInfo?city=\(city)&key=b1089c8e3a4bdd58ee3f1655092e54f7"
        }
    }
}
