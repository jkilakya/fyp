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
    
    var delegate: DataDelegate?
    static let functions = APIFunctions()
    var baseURL = "http://10.68.10.185:8081"
    
     var akmbal: Any = "..."
    
    
    func rollDice() ->String{
        print(akmbal)
        fetchBalance()
        print(akmbal)
        return "\(self.akmbal)"
        //return "smthh"
    }
    
    
    func fetchBalance() {
        let newURL = self.baseURL + "/fetch"
        AF.request(newURL).response { response in
            //print(response.data!)
            let data = String(data: response.data!, encoding: .utf8)
            //print(data)
            self.akmbal = data
            
            
            
            self.delegate?.updateBal(newBal: data!)
           
            
            
        }
        
        //return data
    }
    
    func makeCryptoReward(){
        let newURL = self.baseURL + "/reward"
        let accountSwift = "0xaF5958690bE8911412f7364e6953be6878C6967A"
        let monthCaloriesSwift = "4000"
        let percentageConsistencySwift = "0.6"
        AF.request(newURL, method: .post, encoding: URLEncoding.httpBody, headers: [
            "account": accountSwift,
            "monthCaloriesBurnt": monthCaloriesSwift,
            "percentageConsistency":percentageConsistencySwift]).responseJSON{
                response in
                print(response.data!)
                let data = String(data: response.data!, encoding: .utf8)
                print(data)
                
            }
    }
    
    
    func reimburse(Hash: String){
        let newURL = self.baseURL + "/reimburse"
        let accountSwift = "0xaF5958690bE8911412f7364e6953be6878C6967A"
        let amount = "300"//has to pass value
        //let hash = Hash //pass value
        AF.request(newURL, method: .post, encoding: URLEncoding.httpBody, headers: [
            "account": accountSwift,
            "amount": amount,
            "hash": Hash]).responseJSON{
                response in
                let data = String(data: response.data!, encoding: .utf8)
                let banner = InsuranceClaimCompletionBanner()
                banner.duration = 4
                banner.show(queuePosition: .front)
                print(response.data!)
                print(data)
                
            }
    }
    
}
