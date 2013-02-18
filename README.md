# hubot\_notify

A simple plugin to send and HTTP message (via POST) to a webservice (hubot)
for reposting to IRC

# Installation:

Add to bundler.d/Gemfile.local.rb as:

    gem 'hubot\_notify', :git => 'https://github.com/GregSutcliffe/hubot\_notify.git'

then update & restart Foreman:

    bundle update

# Usage:


Add to your Foreman `config/settings.yaml`:

```yaml
:hubot:
  :enabled: true
  :address: 'http://ircbot:8080/hubot/irc'
```

You will also need a listening Hubot (see below for a sample listener script)

Build a new host, and check you get a message in IRC from your bot.

# Setting up Hubot

Follow https://github.com/github/hubot/wiki/Deploying-Hubot-onto-UNIX as far as
"Installing Hubot". Then run:

   ./bin/hubot -c /tmp/hubot

to create a deployed version. Then add the irc plugin to the dependencies:

    cd /tmp/hubot
    vi package.json

    "dependencies": {
      "hubot-irc": ">= 0.0.1",
      "hubot": ">=2.4.6",
      "hubot-scripts": ">= 2.4.1",
      "optparse": "1.0.3"
    },

    npm install

Edit _irc.coffee_ to set the channel name and the message prefix, and add it to scripts:

    room = '##myroom'
    message = "mynick: #{msg}"

    cp irc.coffee /tmp/hubot/scripts/

Start hubot:

    export HUBOT_IRC_SERVER="chat.freenode.net"
    export HUBOT_IRC_ROOMS="##myroom"
    export HUBOT_IRC_NICK="mybot"
    cd /tmp/hubot && bin/hubot -a irc

You probably want to either background this with nohup or run it in a screen

# TODO

* Add settings to the HTTP POST so they don't have to be hardcoded in _irc.coffee_
* Support other bots?

# Copyright

Copyright (c) 2012-2013 Greg Sutcliffe

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
