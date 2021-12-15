![logo](./docs/logo.png)

# Link to Repository:

You can find a source code in [here](https://github.com/EEYoussef/Birthday_wisher.git)

# Software Development Plan:

You can find the Trello Board in [here](https://trello.com/invite/b/K25yLiwf/8868b9ed9f09f6d8f275ad025a19ae69/birthday-wisher-app)

It embeds birthday’s greeting letters in-app and allows you to send  messages  at the selected time. You can create the auto sending tasks for your friends all in once and then forget about that. Those  messages will be sent out automatically as long as you keep birthday contact list updated.

Out of Scope:





### Installation 
You will need:
1. Ruby installed. If you don't already have it, you can find it [here](https://www.ruby-lang.org/en/downloads/). 
2. Ruby Gems:
   1. Artii [here](https://rubygems.org/search?query=artii) 
   2. tty-prompt  [here](https://rubygems.org/gems/tty-prompt) 
   3. colorize [here](https://rubygems.org/gems/colorize)  
   4. Json [here](https://rubygems.org/gems/json)
   5. Bundler  [here](https://help.dreamhost.com/hc/en-us/articles/115001070131-Using-Bundler-to-install-Ruby-gems).


## Steps to install Birthday Wisher

**To install from Github:**

1. open terminal

2. Change the working directory to the location where you want the cloned directory.

3. go to the repository that holds the source code [here](https://github.com/EEYoussef/Birthday_wisher.git).

4. Click on Code and copy the link.

5. On your terminal : Type `git clone`, and then paste the URL you copied.

6. .Press **Enter** to create your local clone.

   if any error occurs please check this link from Github [here]
   (https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) 

7. Change to the directory that contains the repository.

8. change directory to the src directory.

```
 cd src
```

9. Type this code into the terminal to start the application.

```
 ./bw.sh
```

## Useful Commands :

To view the help menu type:

```
 ruby main.rb -h
```

For more information about the app type:

```
 ruby main.rb -info
```

For displaying all the list of contact, type:

```
 ruby main.rb -c
```

For displaying all the message templates type:

```
 ruby main.rb -l
```

## Requirments to send an email message from your account :

You will need a Postmark account [start here](https://postmarkapp.com/), server and sender signature (or verified domain) set up to use it.

please check [link](https://github.com/wildbit/postmark-gem/wiki/Getting-Started) for further details

For the purpose of this assignment, all these details have been hardcoded. AND WILL BE DELETED ONCE THE PURPOSE IS MET.



### Potential Ethical, Legal Implications

