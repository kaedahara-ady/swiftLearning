//
//  RandomData.swift
//  uiKitTestPrjct1
//
//  Created by OverPowerPWND Keeper83 on 21/9/22.
//

import Foundation
import UIKit

struct RandomData: Codable {
//    let picture = UIImage()
    let results: [Results]
}

struct Results: Codable {
    let gender: String
    let name: Name
}


struct Name: Codable {
    let title, first, last: String
}


//struct Picture: Codable {
//    let large, medium, thumbnail: String
//}
