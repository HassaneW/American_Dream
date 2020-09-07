
import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var degreesTown : UILabel!
    @IBOutlet weak var conditionWeather : UILabel!
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var segmentControl : UISegmentedControl!
    lazy var descriptionDate : String = {
        return refreshDate()
    }()
    var weatherArray : [Weather]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        print(refreshDate())
    }
    func setUp() {
        WeatherService.shared.getWeathers { [weak self] (resultWeather) in
            switch resultWeather {
            case .success(let weathers):
                print(weathers)
                self?.weatherArray = weathers
                self?.setUpUiWeather(weather: weathers[0])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    func refreshDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date()
        )
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        setUpUiWeather(weather: weatherArray?[sender.selectedSegmentIndex])
    }
    func setUpUiWeather(weather: Weather?)  {
        guard let weather = weather else { return }
        degreesTown.text = "\(weather.degrees)"
        conditionWeather.text = weather.conditionDescription
        dateLabel.text = descriptionDate
        guard let url = weather.conditionIconUrl  else { return }
        dateLabel.text = refreshDate()
        guard let urlIcon = URL.init(string: url)  else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlIcon) {
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    self?.imgIcon.image = image
                }
            }
        }
    }
}
