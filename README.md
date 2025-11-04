# AiDrudge

* get headlines from rss feeds 
* link to original article
* extract talking points
* summarize left and rights view
* which side has most support
* right or left leaning (with rating)

# Requirements: 
* account with openapi 
* account with anthropic 
* account with hosting provider 
* * fly.io offers hobby tier at no cost and $5 per month depending on traffic

 Frontpage is located: http://www.yourhostname.com/
 Admin is located: http://www.yourhostname.com/admin
### Launching on fly.io

* Run `fly launch`
* Set the openapi key `fly secrets set OPENAI_API_KEY=your_api_key'
* Set the anthropic key `fly secrets set ANTHROPIC_API_KEY=your_api_key'

# Development:
To start the server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
