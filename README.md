A Ruby library for the Google PageSpeed API.

## Usage

### Command Line

```bash
$ pagespeed add-key YOUR_API_KEY
$ pagespeed -u blahed.com
  - Avoid landing page redirects
  - Enable compression
  - Leverage browser caching
  - Reduce server response time
  - Minify CSS
  - Minify HTML
  - Minify JavaScript
  - Eliminate render-blocking JavaScript and CSS in above-the-fold content
  - Optimize images
  - Prioritize visible content

Total Score: 87/100 (desktop)
```

### Ruby API

```ruby
require 'pagespeed'

request = PageSpeed::Request.new("google.com", 'YOUR_API_KEY', 'desktop')
request.pagespeed
```

## Contributers

- [blahed][1]
- [danriti][2]

[1]: https://github.com/blahed
[2]: https://github.com/danriti
