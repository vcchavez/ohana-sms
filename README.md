# Ohana SMS

This project is the product of a 1.5 day hackathon-- [SF State's Day of Civic Hacking 2016] (http://hackathon.sfsu.edu/home).

"Ohana SMS is a Ruby on Rails application that allows people in need who lack
access to the internet to find human services via SMS."

Built upon the work of
[Moncef Belyamani](https://github.com/monfresh/ohana-sms)
which was inspired by and built upon the work of
[Mark Silverberg](https://github.com/marks/ohana-sms).

[ohana-api]: https://github.com/codeforamerica/ohana-api

### Added Features
We've decided to add a feature to be able to provide feedback for the listings. A user, 
after requesting more information about any given location, can now rate it on a scale 
of 1-5 Stars by simply replying '0'. Ratings are automatically updated and any user can 
see the updated ratings whenever they're viewing the locations available.

### Features We'd Like to Add
Besides providing a quantitative rating, we'd like users to be able to provide qualitative
feedback about their experience. After giving a numerical rating, we'd like to prompt the 
user for any additional comments about their experience. All feedback is always anonymous,
since we're not storing the user's data. 

Furthermore, what's the point of feedback if it never reaches the correct people? 
We'd like to add a script that biweekly or monthly gathers all the new comments for 
all locations, and then emails the respective location a compilation of comments and 
ratings they've received. 

### An Aside
Neither of the collaborators knew Rails coming into this project so this was both quite
the challenge and learning experience. This project was inspired by 
[Code for America's] (https://www.codeforamerica.org) Ready to Work en Español [Challenge]
(https://cache.codeforamerica.org/events/national-day-2016/challenge-ready-to-work-en-espanol).

### Public domain

This project is [dedicated to the public domain](LICENSE.md).
As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright
> and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication][CC0].
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of
> copyright interest.

[CC0]: https://creativecommons.org/publicdomain/zero/1.0/
