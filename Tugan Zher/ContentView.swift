//
//  ContentView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 31.05.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var image: Image?
    @State var serverText: String = ""
    var body: some View {
        Form {
            Section(header: Text("Explore")) {
                TopElements(down_image: $image, fetched_text: $serverText)
            }
            Section(header: Text("Tours")) {
                TopTourView()
            }
        }
        .onAppear {
            downloadImage()
            fetchTextFromServer()
        }
    }
    func downloadImage() {
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
    
    func fetchTextFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/hotelrating/1/") else {
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
                        let rating = try? decoder.decode(HotelRating.self, from: jsonData)
                        DispatchQueue.main.async {
                            print("rating: \(rating)")
                            self.serverText = String(rating?.points ?? 0)
                            print(serverText)
                        }
                    }
                }
            }.resume()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TopElements: View {
    @Binding var down_image: Image?
    @Binding var fetched_text: String
    @State var hotel_detail_sheet_toggle = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Explore top rated hotels")
            Button(action: {
                hotel_detail_sheet_toggle = true
            }, label: {
                if let image = down_image {
                    image.resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .overlay {
                            HStack {
                                Text(fetched_text)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.yellow)
                            }
                            .frame(width: 70, height: 30)
                            .background(Color("LightGreen"))
                            .position(x: 35, y: 25)
                        }
                }
            })
            .foregroundColor(Color.black)
//            Rectangle()
//                .frame(width: UIScreen.main.bounds.width*0.9, height: 200)
//                .background(Color.gray)
            Text("Location")
        }
        .sheet(isPresented: $hotel_detail_sheet_toggle) { HotelDetailsPageView()
        }
    }
}

struct TopTourView: View {
    @State var tourImage: Image?
    @State var description: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            if let image = tourImage {
                image.resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            Text(description)
        }
        .onAppear {
            downloadTourImage()
            fetchTourTextFromServer()
        }
    }
    func downloadTourImage() {
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg") else {
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
                    self.tourImage = image
                }
            }
        }
        .resume()
    }
    
    func fetchTourTextFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/tour/2/") else {
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
                        let descrptn = try? decoder.decode(TourDetails.self, from: jsonData)
                        DispatchQueue.main.async {
                            print("rating: \(descrptn)")
                            self.description = String(descrptn?.description ?? "")
                            print(description)
                        }
                    }
                }
            }.resume()
        }
}
