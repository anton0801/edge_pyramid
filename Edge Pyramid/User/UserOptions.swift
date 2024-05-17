import Foundation

class UserOptions: ObservableObject {
    
    @Published var background = UserDefaults.standard.string(forKey: "background") ?? "game_main_back" {
        didSet {
            UserDefaults.standard.set(background, forKey: "background")
        }
    }
    
    @Published var paunts = UserDefaults.standard.integer(forKey: "paunts") {
        didSet {
            UserDefaults.standard.set(background, forKey: "paunts")
        }
    }
    
}
