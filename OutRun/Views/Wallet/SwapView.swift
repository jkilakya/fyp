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

import SwiftUI

struct SwapView: View {
    
    @State var value = ""
    @State  var fromCurr = "USDC"
    @State  var toCurr = "AKM"
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10.0) {
            
            
            Text("SWAP")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("accentColor"))
                .multilineTextAlignment(.leading)
                .padding(.all)
            
           // Spacer()
            
            VStack(alignment: .leading, spacing: 3.0){
                
                Text("Swap from")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.all)
                
                HStack( alignment: .top, spacing: 10.0){
                    
                    
                    
                    TextField("Enter amount", text: $value)
                        .padding(.all)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        
                    
                    Spacer()
                    
                    Menu("USDC") {
                        Text("USDC")
                        Text("AKM")
                        Text("ETH")
                    }
                    .padding(.all)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("accentColor")/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    
                    
                }
                //end of HStack
                
                Text("Balance: $1000.00")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("accentColorSwapped"))
                    .multilineTextAlignment(.trailing)
                    .padding(.all)
                
                
           // }//end of from VStack
            
            
            Spacer()
                
                
            
            //VStack(alignment: .leading, spacing: 3.0){
                
                Text("Swap to")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.all)
                
                HStack( alignment: .top, spacing: 10.0){
                    Text("\((Double(value) ?? 0.0)*2, specifier: "%.2f")")
                        .padding(.all)
                        .font(.title2)
                    
                    Spacer()
                    
//                    Picker(selection:$toCurr, label: Text("Currency")) {
//                        Text("USDC").tag(1)
//                        Text("AKM").tag(2)
//                    }

                    Menu("AKM") {
                        Text("USDC")
                        Text("AKM")
                        Text("ETH")
                    }
                    .padding(.all)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("accentColor")/*@END_MENU_TOKEN@*/)
                    .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    
                }
                .padding(.all)//end of HStack
               
           }//end of to VStack
            .padding(.all)
            .accentColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("foregroundColor")/*@END_MENU_TOKEN@*/)
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            
          //Button begins here
                if #available(iOS 14.0, *) {
                    Button {
                        print("SWAP button was tapped")
                        print(value)
                    } label: {
                        if #available(iOS 14.0, *) {
                            Label("Swap", systemImage: "rectangle.2.swap.fill")
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .padding(.all)
                    .frame(width: 400.0)
                    .accessibilityAddTraits([.isButton])
                    .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                    .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.orange/*@END_MENU_TOKEN@*/)
                    .font(.title)
                } else {
                    // Fallback on earlier versions
                }
            
            //button ends here
            
            

                
            //Spacer()
          

        }
        .padding(.all)//end of VStack

    }
        
    }


struct SwapView_Previews: PreviewProvider {
    static var previews: some View {
        SwapView()
    }
}

