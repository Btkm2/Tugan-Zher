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
                TopElements(down_image: $image)
            }
        }
        .onAppear {
            downloadImage()
        }
    }
    func downloadImage() {
        //http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp
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
            guard let url = URL(string: "https://example.com/api/text") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let text = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.serverText = text
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
    var body: some View {
        VStack(alignment: .leading) {
            Text("Explore top rated hotels")
            if let image = down_image {
                image.resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
//            Rectangle()
//                .frame(width: UIScreen.main.bounds.width*0.9, height: 200)
//                .background(Color.gray)
            Text("Location")
        }
    }
}
