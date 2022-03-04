//

import Foundation

// MARK: - Helper methods for reading & parsing the JSON file.

// Method to read the local json file.

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}


// Parse the jsonData using the JSONDecoder with help of json model

func parse(jsonData: Data) -> ResponseWeather? {
    do {
        let decodedData = try JSONDecoder().decode(ResponseWeather.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}


func convertToCelsius(fahrenheit: Double) -> Double {
    return (5.0 / 9.0 * (Double(fahrenheit) - 32.0))
}


