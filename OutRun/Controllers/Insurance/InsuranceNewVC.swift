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


class InsuranceNewVC:  UIViewController {
    
    //----------------------------- TableViewController,
    
    var mydata: Any = []
    
//    init(){
//        self.mydata = []
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //-----------------------------
    
    private lazy var rewardButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh))

    @IBOutlet weak var makeClaimButton: UIButton!
    @IBOutlet weak var onBoardingCost: UIStackView!
    @IBOutlet weak var horizontalLine: UIStackView!
    @IBOutlet weak var startPolicyButton: UIButton!
    @IBOutlet weak var monthlyPremium: UIStackView!
    @IBOutlet weak var horizontalLineConstraint: NSLayoutConstraint!
    
    
    //gloabl vars for submitting a claim
    
    var textField1: UITextField!
    var textField2: UITextField!
    var textField3: UITextField!
    var textField4: UITextField!
    var textField5: UITextField!
    
    let submitClaim = UIButton()
    func subcbuttonTapped(){}
    //@IBOutlet weak var textField1: UITextField!
//    @IBOutlet weak var textField2: UITextField!
//    @IBOutlet weak var textField3: UITextField!
//    @IBOutlet weak var textField4: UITextField!
//    @IBOutlet weak var textField5: UITextField!
    //@IBOutlet weak var submitClaim: UIButton!
    //@IBAction func subcbuttonTapped(){}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        self.navigationItem.title = "Insurance"
        makeClaimButton.layer.cornerRadius = 10
        //API functions for checking insurance payments
//        APIFunctions.functions.delegateInsurance = self
//        APIFunctions.functions.insuranceStarted()
        self.navigationItem.rightBarButtonItem = rewardButton
        
        textField1 = UITextField()
        textField2 = UITextField()
        textField3 = UITextField()
        textField4 = UITextField()
        textField5 = UITextField()
        
        textField1.becomeFirstResponder()
        textField1.delegate = self
        
        textField2.becomeFirstResponder()
        textField2.delegate = self
        
        textField3.becomeFirstResponder()
        textField3.delegate = self
        
        textField4.becomeFirstResponder()
        textField4.delegate = self
    
        textField5.becomeFirstResponder()
        textField5.delegate = self
        
    }
    
    @IBAction func clickClaimButton(_ sender: Any) {
        print ("Claim button pressed.")
        let detailVC = DetailViewController()
               detailVC.headline = "Make a Claim"
               self.present(detailVC, animated: true, completion: nil)
               
               
               let statsView = StatsView(title: "Fill in the details below", statViews: [])
               detailVC.view.addSubview(statsView)
               statsView.snp.makeConstraints { (make) in
                   make.top.equalToSuperview().inset(120)
                   make.left.equalTo(detailVC.view.snp.centerX).offset(-200)
                   make.bottom.equalToSuperview().inset(50)
               }
               
       //        let textField = UITextField(frame: CGRect(x: 10, y: 140, width: 200, height: 30))
       //        textField.placeholder = "Enter some text"
       //        textField.textColor = UIColor.black
       //        detailVC.view.addSubview(textField)
       //        func myMethod(from textField: UITextField) -> String? {
       //            return textField.text
       //        }
               
               
               
               let dateofservice = LabelledDataViewCustom(title: "Date of Service",measurementAndUnit: "")
               detailVC.view.addSubview(dateofservice)
               dateofservice.snp.makeConstraints { make in
                   make.left.equalToSuperview().offset(20)
                   make.top.equalToSuperview().offset(160)
               }
               
               //frame: CGRect(x: 10, y: 140, width: 200, height: 30)
               //let textField1 = UITextField()
               textField1.placeholder = "Date"
               textField1.textColor = UIColor.black
               detailVC.view.addSubview(textField1)
               textField1.snp.makeConstraints { make in
                   make.top.equalTo(dateofservice.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               
               let medicaldiagnosis = LabelledDataViewCustom(title: "Your Medical Diagnosis", measurementAndUnit: "")
               detailVC.view.addSubview(medicaldiagnosis)
               medicaldiagnosis.snp.makeConstraints { make in
                   make.top.equalTo(textField1.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               //let textField2 = UITextField()
               textField2.placeholder = "Eg. Asthama"
               textField2.textColor = UIColor.black
               detailVC.view.addSubview(textField2)
               textField2.snp.makeConstraints { make in
                   make.top.equalTo(medicaldiagnosis.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               
               let healthpname = LabelledDataViewCustom(title: "Health Provider Name", measurementAndUnit: "")
               detailVC.view.addSubview(healthpname)
               healthpname.snp.makeConstraints { make in
                   make.top.equalTo(textField2.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               //let textField3 = UITextField()
               textField3.placeholder = "Eg. Queen's Mary Hospital"
               textField3.textColor = UIColor.black
               detailVC.view.addSubview(textField3)
               textField3.snp.makeConstraints { make in
                   make.top.equalTo(healthpname.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               let healthpcontact = LabelledDataViewCustom(title: "Health Provider Contact", measurementAndUnit: "")
               detailVC.view.addSubview(healthpcontact)
               healthpcontact.snp.makeConstraints { make in
                   make.top.equalTo(textField3.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               //let textField4 = UITextField()
               textField4.placeholder = "Eg. 0000-0000"
               textField4.textColor = UIColor.black
               detailVC.view.addSubview(textField4)
               textField4.snp.makeConstraints { make in
                   make.top.equalTo(healthpcontact.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }

               let Totalmedicalcost = LabelledDataViewCustom(title: "Total medical cost", measurementAndUnit: "")
               detailVC.view.addSubview(Totalmedicalcost)
               Totalmedicalcost.snp.makeConstraints { make in
                   make.top.equalTo(textField4.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               //let textField5 = UITextField()
               textField5.placeholder = "Eg. 500 USD"
               textField5.textColor = UIColor.black
               detailVC.view.addSubview(textField5)
               textField5.snp.makeConstraints { make in
                   make.top.equalTo(Totalmedicalcost.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(20)
               }
               
               
               let supdocuments = UIButton()
               supdocuments.setTitle("Add supporting documents", for: .normal)
               supdocuments.backgroundColor = .orange
               supdocuments.layer.cornerRadius = 10
               supdocuments.addTarget(self, action: #selector(supdoctapped), for: .touchUpInside)
               detailVC.view.addSubview(supdocuments)


               //let submitClaim = UIButton()
               submitClaim.setTitle("Submit Claim", for: .normal)
               submitClaim.backgroundColor = .orange
               submitClaim.layer.cornerRadius = 10
               submitClaim.addTarget(self, action: #selector(subclaimtapped), for: .touchUpInside)
               //submitClaim.addTarget(self, action: #selector(subcbuttonTapped), for: .touchUpInside)
               detailVC.view.addSubview(submitClaim)
               
               
               supdocuments.snp.makeConstraints { (make) in
                   make.top.equalTo(textField5.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(50)
                   make.width.equalTo(300)
                   make.height.equalTo(40)
                }
               
               submitClaim.snp.makeConstraints { (make) in
                   make.top.equalTo(supdocuments.snp.bottom).offset(20)
                   make.left.equalToSuperview().offset(50)
                   make.width.equalTo(300)
                   make.height.equalTo(40)
                }
        
        

    }//end of clickClaimButton
    
    
    @objc func refresh(sourceView: UIBarButtonItem){
        print ("Refresh button pressed")
        onBoardingCost.removeFromSuperview()
        startPolicyButton.setTitle("Pay next month's premium", for: .normal)
    }

    @objc func supdoctapped() {
    }
   
    
    
    @IBAction func subclaimtapped(_ sender: UIButton) {
        
        //this needs to fire when submit claim is clicked
        
        //create the json with the required info here
        
        //here we unwrap an optional type with forced unwarapping, empty textfields can throw an error
        let banner = InsuranceClaimCompletionBanner()
                
        banner.show(queuePosition: .front)
        
         mydata = [
            //personal info
            "PersonalInformation":[
                "Name": "Alice Grey",
                "Height":"175", //in centimenters
                "Weigth": "70", //in kilograms
                "PreviousIllnesses": "asthma, minor heart attack",
            ],
            
            //insurance section
            "InsuranceInformation":[
                "InsurancePlan": "Basic",
                "MonthlyPremium": "500 USD"
            
            ],
            
            //activity information - last three months
            "ActivityInformation":[
                
                "caloriesBurnt_0monthsago": "13500", //in kcal
                "caloriesBurnt_1monthsago": "14500",
                "caloriesBurnt_2monthsago": "12000",
                
                "consistency_0monthsago": "0.6",
                "consistency_1monthsago": "0.55",
                "consistency_2monthsago": "0.5",
            
            ],
            
            
            "ClaimInformation":[
                
                "dos":self.textField1.text!,
                "diagnosis": self.textField2.text!,
                "hpName": self.textField3.text!,
                "hpContact": self.textField4.text!,
                "cost": self.textField5.text!
            ]
            

        ]

        ClaimInfoHandler().infohandle(data: mydata)
     
    }

}//end of class InsuranceNewVC

extension InsuranceNewVC: UITextFieldDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let tfval = textField.text{
            //print("im hereeeeeeeee")
            print("\(tfval)")
        }
            
        return true
    }
}
