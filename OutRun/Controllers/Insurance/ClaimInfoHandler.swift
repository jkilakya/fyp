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

class ClaimInfoHandler{
    
    func infohandle(data: Any){
        //print("bro i print json data man!!-----------------------------")
        print(data)
        
        generateHash(infodict: data)
    }
     
    
    func generateHash(infodict: Any){
        
        //print("the generateHash funcccc")
        
//        //convert from type Any to String
//        print("this is the Any to String bit-----------")
//        let Data = (infodict as? String)!
//        print("the Data")
//        print(Data)
        
        //get the JSON of the dictionary
        //var amt = infodict[""]
        
        let jsoninfo = getJSON(infodict: infodict)
        //print("printing json info in genhash")
        print(jsoninfo)
        
        //call the hash function
        print("hash of the Data: ")
        print(Hash4().sha256(jsoninfo))
        
        var dataHash = Hash4().sha256(jsoninfo)! // stores the hash of the user information
        
        //now call API function reimbusre(amount, hash) to connect to backend and store on blockchain
        APIFunctions().reimburse(Hash: dataHash)
        
        
        
    }
    
    func getJSON(infodict: Any) -> Data{
        
        //converting the swift dictionary to JSON here
        if var theJSONData = try? JSONSerialization.data(
            withJSONObject: infodict,
            options: [.prettyPrinted]) {
            let theJSONText = String(data: theJSONData,
                                       encoding: .ascii)
            print("JSON string = \n \(theJSONText!)")
            //print(theJSONData)
            
            //convert the json to string
            return theJSONData
            
        }
        
        return Data()
    }
    
//    func jsonToString(json: AnyObject){
//            do {
//                let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
//                let convertedString = String(data: data1, encoding: .utf8) // the data will be converted to the string
//                print(convertedString) // <-- here is ur string
//
//            } catch let myJSONError {
//                print(myJSONError)
//            }
//
//        }
//
    
    
}
