ohana-sms
=========

A project to create an SMS interface for the Ohana API, powered by Tropo. A civic hacking project to give back to the community by [@Skram](http://twitter.com/skram) of [Social Health Insights](http://socialhealthinsights.com).

Demonstration
-------------
<table>
  <tr>
    <th>Service</th>
    <th>Number/Name</th>
    <th>Voice/Text</th>
  </tr>
  <tr>
    <th>Call/SMS</th>
    <td>+1 650-397-2418</td>
    <td>Both</td>
  </tr>
  <tr>
    <th>SIP</th>
    <td>sip:9991432720@sip.tropo.com</td>
    <td>Voice only</td>
  </tr>
</table>

Data Source
-----------
This app uses data from the [Ohana API](http://www.ohanaapi.org/).
- HTTP API Documentation at http://ohanapi.herokuapp.com/api/docs
- This app uses the Ruby library at https://github.com/codeforamerica/ohanakapa-ruby/

Current Limitations
-------------------
- User is only prompted for a location and only a 5-digit zip code is acceptable.
- User is not asked for what kind of service they are looking for. "food" is hardcoded in.
  - It is easy to ask SMS users what "kind" they are looking for or even let them include free text queries. This is not the case for phone users. We can say "press or say 1 for food, 2 for shelter, etc.." or use voice recognition for a set vocabulary but then we must explain the available words, etc.

TODO
----
- Add information for contributing to this repo (it's very much welcomed)
- Add screenshots and/or recordings to demo functionality

Steps to recreate
-----------------

1. You will need to have [Ruby](http://www.ruby-lang.org/en/downloads/), [Rubygems](http://docs.rubygems.org/read/chapter/3), [Heroku](http://docs.heroku.com/heroku-command) and [Git](http://book.git-scm.com/2_installing_git.html) installed first.

2. Drop into your command line and run the following commands:
  * `git clone http://github.com/marks/ohana-sms.git --depth 1`
  * `cd ohana-sms`

3. Edit the `config.yml` to use suit your preferences and make sure following ENV are set (Google Analytics ones and are optional):
  ```
    OHANA_API_KEY=your_api_key
    GOOGLE_ANALYTICS_DOMAIN=yourdomain.com
    GOOGLE_ANALYTICS_ID=UA-XXXXXXXX-XX
  ```

4. Back at the command line, issue:
  * `heroku create`
  * `git push heroku master`

5. Log in or sign up for [Tropo](http://www.tropo.com/) and create a new WebAPI application.
    For the App URL, enter in your Heroku app's URL and append `/index.json` to the end of it.

6. That's it! Call in, use, and tinker with your app!
