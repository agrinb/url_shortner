# Url Shortner

Built in Rails, Postgres and Jquery

### What:
URL shortners produce a short link by creating a redirect link that contains a small fixed number of characters.
    
### Database / Models
Model: URL 
 - old_url
 - short_url
 - code
 - timestamps
 
Model: Visit
 - ip
 - url_id
 - old_url
 - timestamps


My database choice was Postgres because the data is structured and perfect for a relational DB. Postgres App has proven to be stable for me and my go-to choice. The structure of the tables is pretty trivial. Only one table was technically necessary to be normalized.  I used two Models(tables), the reason for this was to demonstrate that I can. And also because an additional requirement, such as, a leaderboard by region would require an additional model. I created a model - Visit, where I store the ip, timestamp, url_id and the destination url. Storing of the destination url was technically redundant since every visit belongs to a URL instance. However, storing the destination url in the Visit model allowed me to run a single query to get the URLs ordered by all the visits.
 ```sh   
   @leaderboard = Visit.group('url_id', 'old_url').order('count_id desc').count('id')
  ```
@leaderboard is a hash that contains the destination URL and count of visits, it's also odered in descending order. 

Not having old_url in this Model would mean that this query would only return the ids of the URLs which then would translate into additional queries to get the objects and their destination urls (old_url)

The other alternative would have been to simple add 'count' attribute to the URL model and increment it in the 'redirect_url' method which does the actual redirect. I wanted to add some complexity to this so, I chose to exlore the Visit model option, it adds flexibility.

### Code generation 
I chose to use all letters because it would allow for a shorter URL given 26 character options vs 0-9 for each character space in the url.

Originally I was going to just choose a random digit 1-26 and translate it into a letter and append to string. 

Then I found this method 
```sh
[*('A'..'Z')].sample(8).join
```
cleaner and less code.

### Validation
I originally wanted to validate that 
- the URL contains http:// or https:// (Done)
- url field is not empty (Done, HTML5 form validation)
- url redirect resolves (started)
- presence of destination and redirect url when creating URL object.

Ran into some problems with 
Net::HTTP.new with links that were no resolving and didn't want to have code that's sprinled with rescues. So I took it out. Will experiment with it over the weekend.

### CSS
Mostly wrote my own CSS, practice makes perfect. 
Plugged in Bootstrap to get the table style. 
