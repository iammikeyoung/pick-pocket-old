![pick-pocket-ios](intrepid-logo.png)
# PickPocket App - Winter 2017

## Overview of Steps:

* [Create Models](#create-models) - Create models that encapsulate the logic from the game [Mastermind](ultimate-mastermind-rules.pdf).
* [Create UI](#create-ui) - Create a UI that allows you to play a one-way Mastermind game against a computer opponent.
* [Previous Guesses](#previous-guesses) - Add a list of previous guesses to the UI to make it easier to remember what you’ve already guessed.
* [Networking](#networking) - Add a networking class that allows you to crack a remote lock using an API.

## Create Models

Checkout this [link](https://docs.google.com/a/intrepid.io/document/d/1Wywului461Y45yPI0grVbXJd6oj6FukvSLCbRmFJaLw/edit?usp=sharing
), which describes the game logic in more detail.

These models are included in the starter project. Start by implementing the `submit` function.
```Swift
struct Lock {
    let code: String
    func submit(guess: String) -> PickPocketResult {}
}

struct PickPocketResult {
    let correct: Int
    let misplaced: Int
}
```

As you can see, a `Lock` can be initialized with a code. You can then get a `PickPocketResult` back by submitting a guess `String`. The `PickPocketResult` will contain hints for `correct` and `misplaced` digits.

Write unit tests that verify that the game logic is working correctly.

## Create UI

![pick-pocket-ios](pick-pocket-wireframe.png)

Create a UI based on the above wireframe. It doesn’t have to match it exactly, but use it as a guide for what features to include.

1. Add six buttons that will allow the user to input digits 1-6. We will keep the number of buttons static for now, but imagine that we could change the number of buttons in the future!
* Whenever the user presses a button, a digit should be added to a readout.
* There should be some UI that indicates whether or not you have guessed correctly. If you have not yet guessed correctly, you should display a locked lock emoji :lock:. If you submit a correct guess the lock will be opened :unlock:. The lock should display the number of digits in the combination.
* Once you enter the number of digits in the combo, your guess will be submitted. You should receive feedback based on your guess. You should see the numberCorrect ⚫ and the numberMisplaced ⚪.

This is a perfect opportunity to use Model-View-ViewModel ([MVVM](https://www.objc.io/issues/13-architecture/mvvm/)) architecture. You should create a ViewModel class that receives user input from the digit buttons. Once enough digits have been collected, the ViewModel should use its internal models to submit a guess and calculate a `PickPocketResult`. The ViewModel exposes representations of the `correct` and `misplaced` members of `PickPocketResult` in an emoji format. It also exposes an emoji to indicate whether you have cracked the code. You will want to write unit tests that verify that the correct hint string is returned for the correct input.

## Previous Guesses

Expand your ViewModel or create a different one to display your past attempts. See #5 in the wireframe.

## Networking

Add a networking class that allows you to crack a single remote lock using an API. We'll call this class `RequestManager`. `RequestManager` should be a [singleton](http://krakendev.io/blog/the-right-way-to-write-a-singleton). `RequestManager` should use URLSession or [Alamofire](https://github.com/Alamofire/Alamofire) to make HTTP requests. You should use a library like [Genome](https://github.com/LoganWright/Genome) for the JSON parsing. `RequestManager` should return all data asynchronously to its callers via a callback closure. Here is the interface you should use for `RequestManager`:

```swift
static let sharedInstance = RequestManager()

func post(guess: String,
          userID: String,
          userToPick: String,
          completion: @escaping ((Intrepid.Result<PickPocketResult>) -> Void)) {}
```

You will need to use Intrepid's [Swift Wisdom](https://github.com/IntrepidPursuits/swift-wisdom) library in order to access the `Result` enum that is used in the `post` function.

At this stage we're ready to start cracking remote locks! You'll want to set up Retrofit so that you can easily access the API we've created. The base URL of the PickPocket API is:

https://g557v08nj5.execute-api.us-east-1.amazonaws.com/release

The first thing you'll want to do is send a POST request to the endpoint /picklock/{victim} with the following body:

```json
{
    "token": "1e32c098-93cf-11e7-8bf1-e29045b92989",
    "guess": "[2,3,2]"
}
```

The `{victim}` in the URL is the user whose lock you are trying to crack. You can use the username `Paul` to test against the 'guess' 232.  The `token` in the JSON body is a unique
identifier created by the server when a new user is added.  We will provide you with starter values for these items when you get to this step. You should probably test
out this web request in an app like [Postman](https://www.getpostman.com/) before adding it to your app.

**Important** - Once you introduce the ability to crack both local and remote locks you will have to update the original `Lock` and `PickPocketResult` [models](#create-models).

