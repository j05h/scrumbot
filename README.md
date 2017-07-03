# ScrumBot
Dumb ScrumBot.

## Installation

Run it on any old server. Heroku works just fine, you can push this repo and it'll start right away.

Get yourself an API token from [Slack](http://slack.com/services/new/bot)
Set a SLACK_API_TOKEN variable either in a .env file, your environment, or with

```
heroku config:add SLACK_API_TOKEN
```

Set a DATABASE_URL by the same means above.

## Usage

ScrumBot isn't all that smart (right now).

I called my ScrumBot "scrum" (I'm imaginative that way)

In a channel you've invited the bot to say:

```
@scrum I fixed the bug where scrumbot doesn't persist anything today
```

You'll get a simple ack back from ScrumBot.

If you want to know what happened in the current channel, just say

```
@scrum report
```

And you'll get a report for today's scrum.

If you want a report on a different channel, You can say

```
@scrum report #my-favorite-channel
```

And you'll get that channel's report.


If you're forgetful, you can ask for help.

```
@scrum help
```

If you're friendly, you can say hi.

```
@scrum hi
```

ScrumBot keeps only a single entry for each member of a team each day in each channel.
If you send multiple scrum messages, ScrumBot will just record the last one.
Like I said, ScrumBot is dumb.

PRs welcome.
Bugs are highly probable.
Persistence is futile.
