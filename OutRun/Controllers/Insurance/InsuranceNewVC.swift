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

import UIKit

class InsuranceNewVC: UITableViewController {

    
    @IBOutlet weak var makeClaimButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        self.navigationItem.title = "Insurance"
        makeClaimButton.layer.cornerRadius = 10

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func clickClaimButton(_ sender: Any) {
        print ("Claim button pressed. Firing up reward function")
        let myfunctions = APIFunctions()
        myfunctions.fetchBalance()
        
    }

}

