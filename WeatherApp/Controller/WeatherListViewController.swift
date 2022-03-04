//
//  WeatherListViewController.swift
//  WeatherApp
//
//

import UIKit
import Foundation

class WeatherListViewController: UIViewController {

   
    @IBOutlet weak var weatherListTblView: UITableView!
    var listData = [List]()
    var city: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = city
        print(listData)
        // Do any additional setup after loading the view.
    }
    

  

}

extension WeatherListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (weatherListTblView.dequeueReusableCell(withIdentifier: "WeatherDataTableViewCell", for: indexPath) as? WeatherDataTableViewCell)!
            cell.setupCell(data: listData,index: indexPath.row)
          return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.listData = listData
        detailViewController.city = city
        detailViewController.index = indexPath.row
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}
