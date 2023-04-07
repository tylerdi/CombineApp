
//
//  ViewController.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
//  “主控制器”

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    private var webservice: Webservice = Webservice()
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPublihsers()
    }

    private func setupPublihsers() {
        // 监听文本框文字改变的通知
        let publisher  = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.cityTextField)
        
        self.cancellable = publisher.compactMap {
            ($0.object as! UITextField).text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        }
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .flatMap { city in
            // 拼接输入的城市编码,获取城市天气数据
            return self.webservice.fetchWeather(city: city)
                .catch{_ in Just(Weather(province: "", city: "", weather: "", temperature: "", winddirection: "", windpower: "", humidity: "", reporttime: ""))}
                .map{ $0 }
        }
        .sink {
            // 展示天气信息
            if $0.province.count > 0 {
                self.weatherTempLabel.text =
                "省份:\($0.province)\n城市:\($0.city)\n天气:\($0.weather)\n气温:\($0.temperature)℃\n风向:\($0.winddirection)\n风力：\($0.windpower)\n空气湿度：\($0.humidity)\n发布时间：\($0.reporttime)"
            } else {
                self.weatherTempLabel.text = "城市编码输入错误"
            }
        }
    }
}
