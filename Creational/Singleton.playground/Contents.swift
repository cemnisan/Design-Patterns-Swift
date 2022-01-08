import AVFoundation

enum GameMusicRoute {
    case mainMusic
    case clickCardMusic
    case gameMusic
    
    var getMusic: String {
        switch self {
        case .mainMusic:
            return "mainMusic"
        case .clickCardMusic:
            return "clickCardMusic"
        case .gameMusic:
            return "gameMusic"
        }
    }
    
    var getUrl: URL {
        guard let path = Bundle.main.path(forResource: getMusic,
                                          ofType: ".mp4") else { return URL(fileURLWithPath: "")}
        let url = URL(fileURLWithPath: path)
        
        return url
    }
}

final class GameMusic {
    private var player: AVAudioPlayer?
    
    static let shared = GameMusic()
    
    private init() {}
}

extension GameMusic {
    func playGameMusic(from route: GameMusicRoute) {
        let url = route.getUrl
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

GameMusic.shared.playGameMusic(from: .mainMusic)
GameMusic.shared.playGameMusic(from: .gameMusic)
GameMusic.shared.playGameMusic(from: .clickCardMusic)
