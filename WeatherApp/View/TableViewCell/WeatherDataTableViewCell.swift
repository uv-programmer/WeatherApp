

import UIKit

class WeatherDataTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weathertempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data:[List],index:Int) {
        switch index {
        case 0:
            clearData(data: (data.first?.main)!)
        case 1:
            cloudyData(data: (data.first?.clouds)!)
        case 2:
            windData(data: (data.first?.wind)!)
        default:
            break
        }
        
    }
    
    func clearData(data:Main){
        weatherIcon.image = UIImage(named: "clear")
        weatherLabel.text = "Clear"
        weathertempLabel.text = String(describing:Int(data.temp ?? 0.0)) + "°"
        
    }
    
    func cloudyData(data:Clouds){
        weatherIcon.image = UIImage(named: "cloudy")
        weatherLabel.text = "Cloudy"
        weathertempLabel.text = String(describing:data.all ?? 0) + "°"
    }
    
    
    func windData(data:Wind) {
        weatherIcon.image = UIImage(named: "wind")
        weatherLabel.text = "Wind"
        weathertempLabel.text = String(describing:data.deg ?? 0) + "°"
    }

}
