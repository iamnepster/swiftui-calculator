import SwiftUI

enum CalculatorButton {
    case zero, one, two, three, four, five, six, seven, eight, nine, comma
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "x"
        case .divide: return "/"
        case .ac: return "AC"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .comma: return ","
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .equals, .plus, .minus, .multiply, .divide:
            return Color(.orange)
        case .ac, .plusMinus, .percent:
            return Color(.gray)
        default:
            return Color(.darkGray)
        }
    }
}

class CalculatorViewModel: ObservableObject {
    
    @Published var displayedValue = "0"
    
    func handleInput(button: CalculatorButton) {
        // TODO: finish calc logic in future parser project
        if displayedValue != "0" {
            switch button.title {
            case "1", "2", "3", "4", "5", "6", "7", "8", "9":
                self.displayedValue += button.title
                break
            case "AC":
                self.displayedValue = "0"
                break
            default:
                self.displayedValue += button.title
            }
        } else {
            self.displayedValue = button.title
        }
    }
}

struct ContentView: View {
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .comma, .equals]
    ]
    
    @ObservedObject var calculatorViewModel = CalculatorViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(self.calculatorViewModel.displayedValue)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                        .padding()
                }
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.calculatorViewModel.handleInput(button: button)
                            }) {
                                Text(button.title)
                                    .foregroundColor(.white)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                    .background(button.backgroundColor)
                                    .cornerRadius(self.buttonHeight())
                            }
                        }
                    }
                }
            }
        }
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
