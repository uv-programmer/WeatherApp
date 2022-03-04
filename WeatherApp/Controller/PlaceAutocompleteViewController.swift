// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import GooglePlaces
import UIKit

class PlaceAutocompleteViewController: UIViewController {

  private var tableView: UITableView!
  private var tableDataSource: GMSAutocompleteTableDataSource!
    var responseWeather : ResponseWeather?

  override func viewDidLoad() {
    super.viewDidLoad()
      parseData()
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 44.0))
    searchBar.delegate = self
    view.addSubview(searchBar)

    tableDataSource = GMSAutocompleteTableDataSource()
    tableDataSource.delegate = self

    tableView = UITableView(frame: CGRect(x: 0, y: 150, width: self.view.frame.size.width, height: self.view.frame.size.height - 44))
    tableView.delegate = tableDataSource
    tableView.dataSource = tableDataSource

    view.addSubview(tableView)
  }
    
    func parseData() {
        let jsonData = readLocalJSONFile(forName: "WeatherData")!
        print(jsonData)
        if let listObj = parse(jsonData: jsonData) {
            print(listObj)
            responseWeather = listObj
            
        }
    }
    
    
    
    
    
    
    
}

extension PlaceAutocompleteViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // Update the GMSAutocompleteTableDataSource with the search text.
    tableDataSource.sourceTextHasChanged(searchText)
  }
}

extension PlaceAutocompleteViewController: GMSAutocompleteTableDataSourceDelegate {
  func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator off.
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    // Reload table data.
    tableView.reloadData()
  }

  func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
    // Turn the network activity indicator on.
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    // Reload table data.
    tableView.reloadData()
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
    // Do something with the selected place.
      let WeatherListViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherListViewController") as! WeatherListViewController
      WeatherListViewController.listData = responseWeather?.list ?? []
      WeatherListViewController.city = responseWeather?.city?.name
      self.navigationController?.pushViewController(WeatherListViewController, animated: true)
      
      parseData()
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
    // Handle the error.
    print("Error: \(error.localizedDescription)")
  }

  func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
    return true
  }
}
