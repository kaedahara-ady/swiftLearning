//
//  RandomManager.swift
//  uiKitTestPrjct1
//
//  Created by OverPowerPWND Keeper83 on 21/9/22.
//

import Foundation

protocol RandomManagerDelegate: AnyObject {
    func didUpdateRandomUser(_ randomManager: RandomManger, random: RandomModel)
    func didFailWithError(error: Error)
}

struct RandomManger {
    let randomURL = "https://randomuser.me/api/"
    
    weak var delegate: RandomManagerDelegate?
    
    func fetchRandom(userGender: String) {
        let urlString = "\(randomURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
                if let safeData = data {
                    if let random = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRandomUser(self, random: random)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ randomData: Data) -> RandomModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RandomData.self, from: randomData)
            let gender = decodedData.results[0].gender
            
            
            let random = RandomModel(userGender: gender)
            
            return random
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
