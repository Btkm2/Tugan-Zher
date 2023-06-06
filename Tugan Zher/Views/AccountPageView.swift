//
//  AccountPageView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 05.06.2023.
//

import SwiftUI

struct AccountPageView: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .overlay {
                            Circle()
                                .stroke(.black, lineWidth: 2)
                                .foregroundColor(Color.white)
                                .frame(width: 60, height: 60)
                        }
                        .padding(.bottom, 15)
                    Text("Muratbekuly Beket")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                    Text("1st level user")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(Color.yellow)
                }
                .frame(width: UIScreen.main.bounds.width, height: 250)
//                .border(Color.red)
                .background(Color("LightGreen"))
                AccountListElements(image_name: "person.circle.fill", text: "Account management", padding: 150)
                AccountListElements(image_name: "wallet.pass", text: "Payment", padding: 255)
                AccountListElements(image_name: "suit.heart", text: "Saved", padding: 275)
                AccountListElements(image_name: "hand.thumbsup", text: "Reviews", padding: 255)
                AccountListElements(image_name: "list.bullet.rectangle.portrait", text: "Questions", padding: 235)
                AccountListElements(image_name: "questionmark.circle", text: "Contact us", padding: 230)
                AccountListElements(image_name: "hand.raised.square", text: "Security Q&A", padding: 210)
                AccountListElements(image_name: "percent", text: "Special offers", padding: 210)
                AccountListElements(image_name: "network", text: "Travellers network", padding: 230)
            }
        }
    }
}

struct AccountPageView_Previews: PreviewProvider {
    static var previews: some View {
        AccountPageView()
    }
}

struct AccountListElements: View {
    var image_name: String
    var text: String
    var padding: CGFloat
    var body: some View {
        HStack {
            Image(systemName: image_name)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.black)
//                .padding(.bottom, 10)
                .frame(width: 20, height: 20)
//                .border(Color.yellow)
            Text(text)
                .font(.system(size: 18))
        }
        .padding(.trailing, padding)
        .frame(width: UIScreen.main.bounds.width, height: 60)
    }
}
