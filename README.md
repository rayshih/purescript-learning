# My Purescript Learning Notes

This a repo that record my learning process of learning purescript.

I created this repo to share my learning experience of purescript.
Hope I can help more and more people get into know the beauty of functional programming.

Welcome to leave any things as issues, like any parts that you don't understand or any suggestions.
I mean ANYTHING!

## Some notices before start

I'm trying to target the very newcomers, like someone doesn't have any programming experience.
So if there are some things need more advanced knowledge, I'll simply mark them as "medium" or
"advanced" and won't describe the detail, and then carry on.

## Current: Lession 1 - Hello World

Let's start with web app!

There are several frameworks can be used, and I think the most easier one to start with is Pux.

Here is the official Pux website: <http://purescript-pux.org/>

Let's start:

Step 1:

Install npm, git.

Npm is the tool related to JavaScript environment. And Git is a tool for version control.
We don't need to learn the details of them for now.

Step 2:

Clone the starter project:

```bash
// Open your terminal and type following commands

// Just clone a template project into folder `1-pux-hello-world`
git clone git://github.com/alexmingoia/pux-starter-app.git 1-pux-hello-world

// Change directory into this folder
cd 1-pux-hello-world

// Install the dependencies
npm install

// Run the project
npm start
```

And then, give it a little time until it shows

```
Listening on 3000
```

Then you can open your browser and type `localhost:3000` to see the web app you just created.

Step 3: The Hello World

There are lots of files created which seems a little bit scary. But please don't.
Let's write our first line of code!

Open the file `src/App/View/Homepage.purs` with any text editor you like.
You will see bunch of `import`s, but you can ignore it for now.

Follow that, there are 4 lines:

```purescript
view :: State -> HTML Event
view (State st) =
  div do
    h1 $ a ! href "https://www.purescript-pux.org" $ text "purescript-pux.org"
```

Please do not try to understand them for now. I'll explain later.
For the "Hello World", please replace the last 2 lines like this.

```purescript
view :: State -> HTML Event
view (State st) =
  text "Hello World"
```

Remember to save your file, and go back to your browser and witness the change you just made.
(Don't need to refresh the page)

You may see few warnings appear in your terminal. Don't worry, We'll clean them later.

(To be continued)

## Next things to learn

- Server side programming

## More Learning Materials

Here are some reading materials that I've read before start this repository.

1. [PureScript by Example](https://leanpub.com/purescript/read)
2. [Learn you a Haskell](http://learnyouahaskell.com/)

However, it's not necessary to read these before checking this repo.
I'll try my best to describe any detail, and hope that it is extrememly easy to
understand, even for the person who haven't done any programming before.
