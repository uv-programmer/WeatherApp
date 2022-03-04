//
//  DetailViewController.swift
//  WeatherApp
//
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    var listData = [List]()
    var city :String?
    var index = 0
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var tempTypeLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgView.backgroundColor = .blue
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = city
        switch index {
        case 0:
            clearData(data: (listData.first?.main)!)
        case 1:
            cloudyData(data: (listData.first?.clouds)!)
        case 2:
            windData(data: (listData.first?.wind)!)
        default:
            break
        }
    }
    
    func clearData(data:Main){
        typeImage.image = UIImage(named: "clear")
        tempTypeLbl.text = "Clear"
        degreeLbl.text = String(describing:Int(data.temp ?? 0.0)) + "°"
        let unixVal = String(describing: listData.first?.dt ?? 0)
        let Date = (Double(unixVal))!.getDateStringFromUTC()
        dateLbl.text = "\(Date)"
        dayLbl.text = "Monday"
        feelsLikeLbl.text = " Feels like" + " " + "\(data.feels_like ?? 0)" + "°"
        
        
    }
    
    func cloudyData(data:Clouds){
        typeImage.image = UIImage(named: "cloudy")
        tempTypeLbl.text = "Cloudy"
        degreeLbl.text = String(describing:Int(data.all ?? 0)) + "°"
        let Date = (Double("1596632400"))!.getDateStringFromUTC()
        dateLbl.text = "\(Date)"
        dayLbl.text = "Monday"
        feelsLikeLbl.text = " Feels like" + " " + "\(listData.first?.main?.feels_like ?? 0)"
    }
    
    
    func windData(data:Wind) {
        typeImage.image = UIImage(named: "wind")
        tempTypeLbl.text = "Wind"
        degreeLbl.text = String(describing:Int(data.deg ?? 0)) + "°"
        let Date = (Double("1596632400"))!.getDateStringFromUTC()
        dateLbl.text = "\(Date)"
        dayLbl.text = "Monday"
        feelsLikeLbl.text = " Feels like" + " " + "\(listData.first?.main?.feels_like ?? 0)"
    }


}


extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date)
    }
}
