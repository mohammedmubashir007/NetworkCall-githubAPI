import SwiftUI

struct ContentView: View {
    @State private var user : GithubUser?
    
    
    var body: some View {
        VStack(spacing:20){
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120,height: 120)
            Text(user?.login ?? "Username")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "This is where github bio will go")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            }catch GHError.invalidUrl{
                print("Error in url")
            }catch GHError.invalidData{
                print("Error in data")
            }catch GHError.noResponse {
                print("Error in response")
            }catch {
                print("unknown error")
            }
        }
    }
    
    
    func getUser() async throws -> GithubUser {
        let endpoint = "https://api.github.com/users/sallen0400"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw GHError.noResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GithubUser.self, from: data)
            
        } catch {
            throw GHError.invalidData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GithubUser :Codable {
    let login : String
    let avatarUrl : String
    let bio : String
}

enum GHError:Error {
    case invalidUrl
    case noResponse
    case invalidData
}
