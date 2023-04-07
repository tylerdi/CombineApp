
//
//  ViewController.swift
//  CombineWeatherApp
//
//  Created by 张帝 on 2023/4/7.
//  “主控制器”

import UIKit
import Combine

class ViewController: UIViewController {
    
    private(set) var responseSubject = PassthroughSubject<String?, Never>()
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!

    private var webservice: Webservice = Webservice()
    private var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置Publisher
        setupPublihsers()
    }

    private func setupPublihsers() {
        // 监听文本框文字改变的通知
        self.cancellable = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.cityTextField)
            // 过滤输入框文本
            .compactMap {
                if let tf = $0.object as? UITextField, let city = tf.text {
                    return city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                }
                return ""
            }
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)

        .flatMap ({ city in
            // 拼接输入的城市编码,获取城市天气数据
            return self.webservice.fetchWeather(city: city)
        })
        .sink { completion in
            // 错误处理
            if case let .failure(error) = completion {
                self.weatherTempLabel.text = "城市编码输入错误"
                print(error.localizedDescription)
            }
        } receiveValue: {  model in
            guard let model = model else { return }
            print("model = \(model)")
            // 返回数据,展示天气信息
            self.weatherTempLabel.text =
            "省份:\(model.province)\n城市:\(model.city)\n天气:\(model.weather)\n气温:\(model.temperature)℃\n风向:\(model.winddirection)\n风力：\(model.windpower)\n空气湿度：\(model.humidity)\n发布时间：\(model.reporttime)"
            }
    }
}
