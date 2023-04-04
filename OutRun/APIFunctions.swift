//
//  [FILENAME]
//
//  OutRun
//  Copyright (C) 2020 Tim Fraedrich <timfraedrich@icloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation
import Alamofire

class APIFunctions {

    func fetchBalance(){
        AF.request("http://172.20.10.2:8081/fetch").response { response in
            print(response.data!)
            let data = String(data: response.data!, encoding: .utf8)
            print(data)
        }
    }
    
    func makeCryptoReward(){
        let accountSwift = "0x455E5AA18469bC6ccEF49594645666C587A3a71B"
        let monthCaloriesSwift = "3750"
        let percentageConsistencySwift = "0.5"
        AF.request("http://172.20.10.2:8081/reward", method: .post, encoding: URLEncoding.httpBody, headers: [
            "account": accountSwift,
            "monthCaloriesBurnt": monthCaloriesSwift,
            "percentageConsistency":percentageConsistencySwift]).responseJSON{
                response in
                print(response.data!)
                let data = String(data: response.data!, encoding: .utf8)
                print(data)
                
            }
    }
}