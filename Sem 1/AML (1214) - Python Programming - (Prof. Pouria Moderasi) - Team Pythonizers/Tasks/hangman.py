import random

# defining the words and returning a random word
def choose_word():
    words = [    
        "programming",
        "computer",
        "hangman",
        "developer",
        "challenge",
        "python",
        "language",
        "code",
        "software",
        "debugging",
        "variable",
        "algorithm",
        "function",
        "iteration",
        "repository",
        "version",
        "debugging",
        "keyboard",
        "debugging",
        "application"
    ]   
    # returning a random word from the word list
    return random.choice(words)

# displaying the word
def display_word(word, guessed_letters):

    # creating an empty list 
    display = ""

    # looping through the word to generate each character
    for letter in word:
        if letter in guessed_letters:
            display += letter
        else:
            display += "_"
    return display

# defining and printing the hangman
def print_hangman(attempts):
    stages = [
        '''
           -----
           |   |
               |
               |
               |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
               |
               |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
           |   |
               |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
          /|   |
               |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
          /|\  |
               |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
          /|\  |
          /    |
               |
        -------

        ''',
        '''
           -----
           |   |
           O   |
          /|\  |
          / \  |
               |
        -------

        '''
    ]

    # printing the stages of hangman within the attempts
    print(stages[attempts])


def hangman():

    # defining the maximum attempts
    max_attempts = 6

    # creating an empty list to hold guessed letters
    guessed_letters = []

    # grabbing the randomly generated word
    word_to_guess = choose_word()

    # initializing the number of attempts
    attempts = 0

    print("Welcome to Hangman!")
    print(display_word(word_to_guess, guessed_letters))

    # creating a loop to check for the guess
    while True:

        # getting the input letter from the user and converting it to lowercase
        guess = input("Guess a letter: ").lower()

        # checking if the guess is an alphabet and is a single letter
        if guess.isalpha() and len(guess) == 1:

            # checking if the letter is already guessed
            if guess in guessed_letters:
                print("You already guessed that letter. Try again.")
            else:

                # appending the letter if not already guessed and is in the actual word
                guessed_letters.append(guess)

                # checking if the letter is not in the word
                if guess not in word_to_guess:

                    # incrementing the number of attempts
                    attempts += 1

                    # calling the print_hangman function passing a parameter attempts
                    print_hangman(attempts)

                    # printing the number of attempts left
                    print("Incorrect guess. Attempts left:", max_attempts - attempts)

                    # condition if maximum attempts reached
                    if attempts == max_attempts:
                        print("Sorry, you ran out of attempts. The word was:", word_to_guess)
                        break
                else:
                    print("Good guess!")

                word_display = display_word(word_to_guess, guessed_letters)
                print(word_display)

                if "_" not in word_display:
                    print("Congratulations! You guessed the word:", word_to_guess)
                    break
        else:
            print("Invalid input. Please enter a single letter.")

# main function
if __name__ == "__main__":
    hangman()
