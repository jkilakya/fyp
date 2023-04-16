//
//  WalletView.swift
//
//  Created by Ilakya JK on 26/3/2023.
//

import SwiftUI
import UIKit
import Glaip

protocol DataDelegate{
    func updateBal(newBal: String)
}


struct WalletView: View, DataDelegate {
func updateBal(newBal: String) {
      print(newBal)
      AKMbal = newBal
}


    @State var onSwapView = false // Step 2

    @State var AKMbal = ""

@ObservedObject private var glaip = Glaip(
     title: "Glaip Demo App",
     description: "Demo app to demonstrate Web3 login",
     supportedWallets: [.MetaMask])

     

func getAKMbal()  {



//------------------------------------------------------------------
let jsonString = """
  
   {"name":"ilakya", "age":21, "illness":"idk bro"}
  
  
"""

let data = Data(jsonString.utf8)

print(data)

//print("Hash1:----------------------")
//print(Hash().example(text: "{\"name\":\"ilakya\", \"age\":21, \"illness\":\"idk bro\"}"))
//print("Hash2:----------------------")
//print(Hash2().example2(json: data))
//print("Hash3:----------------------")
//print(Hash3().example3(json: data))
//print(Hash2().example2(json: {"name":"ilakya", "age":21, "illness":"idk bro"}))


//------------------------------------------------------------------




APIFunctions.functions.delegate = self
APIFunctions.functions.fetchBalance()
print("hello")
var akmbal = ""

//func getAKMbal() async  {
let myobj = APIFunctions()
//AKMbal = "for now"
AKMbal =   myobj.rollDice()

}
     
var body: some View {
        
       
    //NavigationView{ // Step 1
    
    VStack(alignment: .leading, spacing: 3.0) {
    
    Text("      WALLET")
    .font(.title)
    .fontWeight(.bold)
    .foregroundColor(Color("accentColor"))
    .multilineTextAlignment(.trailing)
    .padding(.all)
    
    
    Spacer()
    
    VStack(alignment: .center, spacing: 10.0){
    
//    // Step 3
//    NavigationLink(destination: SwapView(), isActive: $onSwapView) { EmptyView() }
    
    
    
    Text("Available Balance")
    .font(.title)
    .fontWeight(.semibold)
    .foregroundColor(Color("secondaryColor"))
    .multilineTextAlignment(.center)
    .padding(.all)
    
    
    //we want to fetch the data from the API call
    //make a call to API functions
    
    
//    Text(AKMbal)
//    .onAppear(perform:getAKMbal)

    Text(AKMbal)
    .onAppear(perform: getAKMbal
    
    )
    
    
    //Text("0 AKM + 1000 USDC")
    //.font(.largeTitle)
    .font(.title2)
    .foregroundColor(Color("accentColorSwapped"))
    .multilineTextAlignment(.center)
    .padding([.leading, .bottom, .trailing])
    
    
    
    HStack( alignment: .top, spacing: 10.0) {
    
    
    if #available(iOS 14.0, *) {
    Button {
    //using glaip to connect to metamask
    glaip.loginUser(type: .MetaMask) { result in
      switch result {
      case .success(let user):
        print(user.wallet.address)
      case .failure(let error):
        print(error)
      }
    }
    
    print("Deposit button was tapped")
    } label: {
    if #available(iOS 14.0, *) {
    Label("Deposit", systemImage: "square.and.arrow.down.fill")
    } else {
    // Fallback on earlier versions
    }
    }
    .padding(.all)
    .frame(width: 122.0)
    .accessibilityAddTraits([.isButton])
    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
    .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
    .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
    } else {
    // Fallback on earlier versions
    }
    
    
    
    
    if #available(iOS 14.0, *) {
    Button {
    
    //using glaip to connect to metamask
    glaip.loginUser(type: .MetaMask) { result in
      switch result {
      case .success(let user):
        print(user.wallet.address)
      case .failure(let error):
        print(error)
      }
    }
    print("Swap button was tapped")
    //insert code to jump to swapView here
    
    self.onSwapView = true // Step 4
    
    
    
    } label: {
    Label("Swap", systemImage: "rectangle.2.swap")
    }
    .padding(.all)
    .frame(width: 122.0)
    .accessibilityAddTraits([.isButton])
    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
    .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
    .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
    } else {
    // Fallback on earlier versions
    }
    
    
    
    
    if #available(iOS 14.0, *) {
    Button {
    //using glaip to connect to metamask
    glaip.loginUser(type: .MetaMask) { result in
      switch result {
      case .success(let user):
        print(user.wallet.address)
      case .failure(let error):
        print(error)
      }
    }
    
    print("Withdraw button was tapped")
    } label: {
    if #available(iOS 14.0, *) {
    Label("Withdraw", systemImage: "square.and.arrow.up.fill")
    } else {
    // Fallback on earlier versions
    }
    }
    .padding(.all)
    .frame(width: 136.0)
    .accessibilityAddTraits([.isButton])
    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
    .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
    .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
    } else {
    // Fallback on earlier versions
    }
    
    
    }
    .padding(.all)//end of buttons HStack
    
    
    //inserting here
    Spacer()
    
    Text("Previous Rewards")
    .font(.title3)
    .fontWeight(.semibold)
    .foregroundColor(Color.black)
    .multilineTextAlignment(.center)
    .padding(.all)
    
    ScrollView(.vertical){
    
    VStack(alignment: .center, spacing: 5.0){
    
    HStack( alignment: .center, spacing: 3.0){
    Image(/*@START_MENU_TOKEN@*/"arkam logo"/*@END_MENU_TOKEN@*/)
    Spacer()
    Text("January 2023")
    .font(.headline)
    .multilineTextAlignment(.leading)
    .padding(.all)
    
    Spacer()
    
    
    Text("+ 0 AKM")
    .font(.headline)
    .fontWeight(.semibold)
    .foregroundColor(Color("accentColorSwapped"))
    .multilineTextAlignment(.trailing)
    .padding(.all)
    
    }
    //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("foregroundColor")/*@END_MENU_TOKEN@*/)
    
    Spacer()
    
    HStack( alignment: .center, spacing: 3.0){
    Image(/*@START_MENU_TOKEN@*/"arkam logo"/*@END_MENU_TOKEN@*/)
    Spacer()
    
    Text("December 2022")
    .font(.headline)
    .multilineTextAlignment(.leading)
    .padding(.all)
    
    Spacer()
    
    Text("+ 0 AKM")
    .font(.headline)
    .foregroundColor(Color("accentColorSwapped"))
    .multilineTextAlignment(.trailing)
    .padding(.all)
    
    
    }
    //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("foregroundColor")/*@END_MENU_TOKEN@*/)
    
    Spacer()
    
    HStack( alignment: .center, spacing: 3.0){
    Image(/*@START_MENU_TOKEN@*/"arkam logo"/*@END_MENU_TOKEN@*/)
    
    Spacer()
    
    Text("November 2022")
    .font(.headline)
    .multilineTextAlignment(.leading)
    .padding(.all)
    
    Spacer()
    
    Text("+ 0 AKM")
    .font(.headline)
    .foregroundColor(Color("accentColorSwapped"))
    .multilineTextAlignment(.trailing)
    .padding(.all)
    
    
    }
    //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("foregroundColor")/*@END_MENU_TOKEN@*/)
    
    Spacer()
    
    HStack( alignment: .center, spacing: 3.0){
    Image(/*@START_MENU_TOKEN@*/"arkam logo"/*@END_MENU_TOKEN@*/)
    
    Spacer()
    
    
    Text("October 2022")
    .font(.headline)
    .multilineTextAlignment(.leading)
    .padding(.all)
    
    Spacer()
    
    Text("+ 0 AKM")
    .font(.headline)
    .foregroundColor(Color("accentColorSwapped"))
    .multilineTextAlignment(.trailing)
    .padding(.all)
 
    
    }
    //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("foregroundColor")/*@END_MENU_TOKEN@*/)
    
    
    }//end of bottom vstack
    .padding(.all)
    .accentColor(/*@START_MENU_TOKEN@*/Color("primaryColor")/*@END_MENU_TOKEN@*/)
    
    
    }
    .padding(.all)//end of ScrollView
    
    
    Spacer()
    //inserting here ends**********8
    
    }
    .padding(.all)
    .accentColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
    
    //******************************************************
    //end of top VStack
    
    
    
    
    }
    .padding(.all)
    
    //end of main VStack
    
    //}
    //.navigationBarTitle("")
    .navigationBarHidden(true)
    
        
        //end of NavigationView
            
      

    }
}

struct WalletView_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        WalletView()
        //WalletView(onSwapView: false)
    }
}

//extension UITableViewController: DataDelegate{
//    func updateBal(newBal: String) {
//        do{
//             //akmbal = try JSONDecoder().decode()(String.self, from: newBal.data(using: .utf8)!)
//            print(newBal)
//        }
//        catch{
//            print("failed to decode")
//        }
//    }
//}
