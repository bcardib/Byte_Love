import SwiftUI
import Combine

class UserResponse: ObservableObject {
    @Published var responses: [String] = []
    @Published var totalPoints: Int = 0
}

// Custom Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(hex.startIndex, offsetBy: 1)
        }
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

// Main Sign-Up View
struct ContentView: View {
    @State private var selectedGender = 0
    @State private var selectedAge = 0
    @State private var selectedSexuality = 0
    @State private var selectedPronouns = 0
    @State private var selectedOption = 0
    @State private var selectedShowerFrequency = 0
    @State private var selectedProgrammingInterest = 0
    @State private var selectedGamingInterest = 0
    @State private var selectedTechInterest = 0
    @State private var selectedMBTI = 0
    @State private var navigateToNextPage = false // State to control navigation

    let genders = ["Male", "Female", "Other"]
    let sexualities = ["Heterosexual", "Homosexual", "Bisexual", "Other"]
    let pronouns = ["He/Him", "She/Her", "They/Them", "Other"]
    let frequencies = ["Daily", "Weekly", "Monthly", "Rarely"]
    let interests = ["Java", "Python", "C++", "Swift"]
    let ages = Array(18...100) // Create an array of ages from 18 to 100
    let mbtiOptions = ["ISTJ", "ISFJ", "INFJ", "INTJ", "ISTP", "ISFP", "INFP", "INTP", "ESTP", "ESFP", "ENFP", "ENTP", "ESTJ", "ESFJ", "ENFJ", "ENTJ"]

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Personal Information")) {
                        VStack(spacing: 10) {
                            Picker("Gender", selection: $selectedGender) {
                                ForEach(0..<genders.count, id: \.self) { index in
                                    Text(genders[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Age", selection: $selectedAge) {
                                ForEach(0..<ages.count, id: \.self) { index in
                                    Text("\(ages[index])")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Sexuality", selection: $selectedSexuality) {
                                ForEach(0..<sexualities.count, id: \.self) { index in
                                    Text(sexualities[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Pronouns", selection: $selectedPronouns) {
                                ForEach(0..<pronouns.count, id: \.self) { index in
                                    Text(pronouns[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Shower Frequency", selection: $selectedShowerFrequency) {
                                ForEach(0..<frequencies.count, id: \.self) { index in
                                    Text(frequencies[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("MBTI", selection: $selectedMBTI) {
                                ForEach(0..<mbtiOptions.count, id: \.self) { index in
                                    Text(mbtiOptions[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()
                        }
                        .padding(.top, 20) // Add top margin
                    }

                    Section(header: Text("Preferences")) {
                        Picker("Type of Relationship", selection: $selectedOption) {
                            Text("eDating").tag(0)
                            Text("In Person").tag(1)
                            Text("Friendship").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        .background(Color(hex: "#4897AB"))
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(hex: "#4897AB"), lineWidth: 2))
                    }

                    Section(header: Text("Interests")) {
                        VStack(spacing: 10) {
                            Picker("Programming Interests", selection: $selectedProgrammingInterest) {
                                ForEach(0..<interests.count, id: \.self) { index in
                                    Text(interests[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Gaming Interests", selection: $selectedGamingInterest) {
                                ForEach(0..<interests.count, id: \.self) { index in
                                    Text(interests[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()

                            Picker("Tech Interests", selection: $selectedTechInterest) {
                                ForEach(0..<interests.count, id: \.self) { index in
                                    Text(interests[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .background(Color(hex: "#4897AB"))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding()
                        }
                    }

                    NavigationLink(
                        destination: NextPageView()
                            .environmentObject(UserResponse()), // Ensure the environment object is passed here
                        isActive: $navigateToNextPage,
                        label: { EmptyView() } // Hidden navigation link
                    )

                    Button(action: {
                        navigateToNextPage = true
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#D33442"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.system(size: 18))
                    }
                    .padding()
                }
                .background(Color(hex: "#001514"))
                .ignoresSafeArea()
            }
            .navigationBarHidden(true) // Hide the navigation bar title
        }
    }
}




struct QuestionView: View {
    @EnvironmentObject var userResponse: UserResponse
    @State private var selectedAnswer: Int? = nil
    let question: String
    let options: [String]
    let points: [Int]
    let nextPage: AnyView

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text(question)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()

            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    selectedAnswer = index
                    updateUserResponse(selectedIndex: index)
                }) {
                    Text(options[index])
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedAnswer == index ? Color(hex: "#D33442") : Color(hex: "#4897AB"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.system(size: 18))
                }
            }
            .padding()

            Spacer()

            NavigationLink(
                destination: nextPage
                    .environmentObject(userResponse),
                isActive: Binding(
                    get: { selectedAnswer != nil },
                    set: { _ in }
                ),
                label: { EmptyView() }
            )
            .hidden()
        }
        .background(Color(hex: "#001514"))
        .ignoresSafeArea()
    }

    private func updateUserResponse(selectedIndex: Int) {
        userResponse.responses.append(options[selectedIndex])
        userResponse.totalPoints += points[selectedIndex]
    }
}




// Next Page View
struct NextPageView: View {
    var body: some View {
        QuestionView(
            question: "You see an attractive member of the preferred gender across the computer lab. How do you proceed?",
            options: [
                "Avoid eye contact and never speak to them",
                "Ask for help debugging ;)",
                "Stare from afar",
                "Ask for their discord"
            ],
            points: [2, 4, 1, 3],
            nextPage: AnyView(SecondQuestionView())
        )
    }
}

struct SecondQuestionView: View {
    var body: some View {
        QuestionView(
            question: "They are now approaching you… what do you do?",
            options: [
                "Run away",
                "Go for the handshake",
                "What’s up brother 🤓☝️",
                "Wink"
            ],
            points: [3, 4, 2, 1],
            nextPage: AnyView(ThirdQuestionView())
        )
    }
}
struct ThirdQuestionView: View {
    var body: some View {
        QuestionView(
            question: "What are you suggesting for a first date?",
            options: [
                "Co-op campaign",
                "Discord call dinner date",
                "Climbing gym",
                "Subway"
            ],
            points: [3, 4, 1, 2],
            nextPage: AnyView(FourthQuestionView())
        )
    }
}
struct FourthQuestionView: View {
    var body: some View {
        QuestionView(
            question: "You’re going on a first date! What are you going to wear?",
            options: [
                "Hoodie and sweats",
                "Anime shirt",
                "Fedora",
                "Dressy!"
            ],
            points: [3, 2, 1, 4],
            nextPage: AnyView(FifthQuestionView())
        )
    }
}

struct FifthQuestionView: View {
    var body: some View {
        QuestionView(
            question: "What’s your fragrance ;)?",
            options: [
                "Perfume",
                "Temu vape",
                "Axe body spray",
                "B/O"
            ],
            points: [1, 3, 2, 4],
            nextPage: AnyView(SixthQuestionView())
        )
    }
}
struct SixthQuestionView: View {
    var body: some View {
        QuestionView(
            question: "How often do you touch grass?",
            options: [
                "In genshin? Daily",
                "Daily",
                "Weekly",
                "Every other month"
            ],
            points: [4, 1, 2, 3],
            nextPage: AnyView(SeventhQuestionView())
        )
    }
}
struct SeventhQuestionView: View {
    var body: some View {
        QuestionView(
            question: "Do you have a skincare routine?",
            options: [
                "4 in 1 soap",
                "Water",
                "No.",
                "Yes babe"
            ],
            points: [2, 3, 4, 1],
            nextPage: AnyView(EighthQuestionView())
        )
    }
}
struct EighthQuestionView: View {
    var body: some View {
        QuestionView(
            question: "What do you do for exercise?",
            options: [
                "Weightlifting",
                "Walk, jog, run",
                "Nothing",
                "Esports"
            ],
            points: [2, 1, 3, 4],
            nextPage: AnyView(ResultPageView())
        )
    }
}



// Result Page View
struct ResultPageView: View {
    @EnvironmentObject var userResponse: UserResponse

    var body: some View {
        VStack {
            Text("Your Responses:")
                .font(.title)
                .padding()
            
            ForEach(userResponse.responses, id: \.self) { response in
                Text(response)
                    .font(.headline)
                    .padding()
            }
            
            Text("Total Weirdness Points: \(userResponse.totalPoints)")
                .font(.title2)
                .padding()
        }
        .background(Color(hex: "#001514"))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserResponse()) // Add environmentObject here
    }
}

struct NextPageView_Previews: PreviewProvider {
    static var previews: some View {
        NextPageView()
            .environmentObject(UserResponse()) // Add environmentObject here
    }
}

struct ResultPageView_Previews: PreviewProvider {
    static var previews: some View {
        ResultPageView()
            .environmentObject(UserResponse()) // Add environmentObject here
    }
}
