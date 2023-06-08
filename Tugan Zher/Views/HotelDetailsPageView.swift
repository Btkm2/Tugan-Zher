//
//  HotelDetailsPageView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 08.06.2023.
//

import SwiftUI

struct HotelDetailsPageView: View {
    @State var image: Image?
    @State var hotel_description = ""
    var body: some View {
        VStack {
            if let image = image {
                image.resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width*0.9, height: 300)
                    .border(Color.yellow)
                //                .overlay {
                //                    HStack {
                //                        Text(hotel_description)
                //                        Image(systemName: "star.fill")
                //                            .resizable()
                //                            .renderingMode(.original)
                //                            .aspectRatio(contentMode: .fit)
                //                            .frame(width: 20, height: 20)
                //                            .foregroundColor(.yellow)
                //                    }
                //                    .frame(width: 70, height: 30)
                //                    .background(Color("LightGreen"))
                //                    .position(x: 35, y: 25)
                //                }
            }
            Text(hotel_description)
                .font(.system(size: 16, weight: .medium, design: .serif))
                .padding()
                .border(Color.red)
        }
        .onAppear {
            downloadImage()
            fetchDescriptionFromServer()
        }
    }
    
    private func downloadImage() {
        //http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error while dowloading image from server, \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        .resume()
    }
    
    func fetchDescriptionFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/hotel/1/") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let text = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    if let jsonData = text.data(using: .utf8) {
                        let hotel = try? decoder.decode(Hotel.self, from: jsonData)
                        DispatchQueue.main.async {
                            print("hotels: \(hotel)")
                            self.hotel_description = String(hotel?.description ?? "")
                            print(hotel_description)
                        }
                    }
                }
            }.resume()
        }
}

struct HotelDetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        HotelDetailsPageView()
    }
}
