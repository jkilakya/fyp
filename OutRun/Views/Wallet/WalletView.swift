//
//  WalletView.swift
//  trialApp
//
//  Created by Ilakya JK on 26/3/2023.
//

import SwiftUI

struct WalletView: View {
    @available(iOS 13.0, *)
    var body: some View {
        
        
        VStack(spacing:10.0) {
            
            Text("My Wallet")
                .padding(.all)
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            VStack{
                
                
                
                Text("Available balance")
                Text("0 AKM + 1000 USDC")
                

                
                HStack {
                    
                    if #available(iOS 14.0, *) {
                        Button {
                            print("Deposit button was tapped")
                        } label: {
                            Label("Deposit", systemImage: "square.and.arrow.down.fill")
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
                            print("Swap button was tapped")
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
                    
                    
                }//end of buttons HStack
                
            }//end of top VStack
            
            Spacer()
            
            Text("Previous Rewards")
            
            VStack{
                
                HStack{
                    Image(/*@START_MENU_TOKEN@*/"Image Name"/*@END_MENU_TOKEN@*/)
                    Text("January 2023")
                    Text("+ 0 AKM")
                    
                }
                
                Spacer()
                
                HStack{
                    Image("Image Name")
                    Text("December 2022")
                    Text("+ 0 AKM")
                    
                }
                
                Spacer()
                
                HStack{
                    Image(/*@START_MENU_TOKEN@*/"Image Name"/*@END_MENU_TOKEN@*/)
                    Text("November 2022")
                    Text("+ 0 AKM")
                    
                }
                
                Spacer()
                
                HStack{
                    Image(/*@START_MENU_TOKEN@*/"Image Name"/*@END_MENU_TOKEN@*/)
                    Text("October 2022")
                    Text("+ 0 AKM")
                    
                }
            }
            
          
            
        }//end of VStack

    }
}

struct WalletView_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        WalletView()
    }
}
