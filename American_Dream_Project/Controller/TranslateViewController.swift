
import UIKit
import Foundation

class TranslateViewController: UIViewController {
    @IBOutlet var picker : UIPickerView!
    @IBOutlet weak var textView : UITextView!
    private let availableLanguages = ["English", "Mandarin"]
    private let availableLanguagesCodes = ["en", "zh"]
    private var selectedLanguageCode = "en"
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        picker.dataSource = self
        picker.delegate = self
        setupTextView()
    }
    private func setupTextView() {
        textView.text = "Veuillez entrer un texte a traduire"
        addToolbar()
    }
    func setUp()  {
        TranslateService.shared.getTranslate(text: textView.text, targetCode: selectedLanguageCode) { [weak self] (resultTranslate) in
            switch resultTranslate {
            case .success(let translate):
                print(translate)
                DispatchQueue.main.async {
                    self?.textView.text = translate.translatedText
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func addToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clikedClear))
        let convert = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([clear, spaceBtn, convert], animated: true)
        self.textView.inputAccessoryView = toolbar
    }
    @objc func clikedClear() {
        textView.text = ""
    }
    @objc func done() {
        textView.resignFirstResponder()
    }
    @IBAction func translate() {
        textView.resignFirstResponder()
        setUp()
    }
}
extension TranslateViewController : UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableLanguages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableLanguages[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setupTextView()
        selectedLanguageCode = availableLanguagesCodes[row]
    }
}

