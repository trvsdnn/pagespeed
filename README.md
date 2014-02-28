a ruby wrapper around the google pagespeed api

## Usage

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

$ pagespeed -u blahed.com -s mobile
  - Avoid landing page redirects
  - Avoid plugins
  - Configure the viewport
  - Enable compression
  - Leverage browser caching
  - Reduce server response time
  - Minify CSS
  - Minify HTML
  - Minify JavaScript
  - Eliminate render-blocking JavaScript and CSS in above-the-fold content
  - Optimize images
  - Prioritize visible content
  - Size content to viewport
  - Size tap targets appropriately
  - Use legible font sizes

Total Score: 75/100 (mobile)
```
