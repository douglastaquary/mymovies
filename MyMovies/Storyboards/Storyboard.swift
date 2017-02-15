import Foundation
import UIKit

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("\nFailed to instantiate initialViewControlller for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

struct Storyboard {
    enum LaunchScreen: StoryboardSceneType {
        static let storyboardName = "LaunchScreen"
    }
    enum Main: String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        static func initialViewController() -> UINavigationController {
            guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
                fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
            }
            return vc
        }
        
        case moviesViewControllerScene = "MoviesViewController"
        static func instantiateCharacterViewController() -> MoviesViewController {
            guard let vc = Storyboard.Main.moviesViewControllerScene.viewController() as? MoviesViewController
                else {
                    fatalError("ViewController 'MoviesViewController' is not of the expected class MoviesViewController.")
            }
            return vc
        }
        
        case movieViewControllerScene = "MovieViewController"
        static func instantiateCharactersViewController() -> MovieViewController {
            guard let vc = Storyboard.Main.movieViewControllerScene.viewController() as? MovieViewController
                else {
                    fatalError("ViewController 'ItemViewController' is not of the expected class ItemViewController.")
            }
            return vc
        }
    }
}
