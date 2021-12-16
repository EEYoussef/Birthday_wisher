![logo](./docs/logo.png)

# Link to Repository:

You can find a source code in [here](https://github.com/EEYoussef/Birthday_wisher.git)

# Software Development Plan:

You can find the Trello Board in [here](https://trello.com/invite/b/K25yLiwf/8868b9ed9f09f6d8f275ad025a19ae69/birthday-wisher-app)

**Purpose:** An application to help the user to send birthday wishes to recipients in a contact list.

**The problem:** If a user has a long list of contacts and wants to send them birthday wishes on their birthday, it will be hard for him/her to remember whose birthday is today. Even if the user relies on a reminder to alert him/herself when each person's birthday is, it will be difficult to manually customize and send a birthday wish to each recipient. This will be a time consuming and tedious task for a long list of recipients.

 **Target Audience:** The application will suit any user who wants to constantly send birthday wishes to a given contact list. For example, a marketing department for an online retail store or a loyalty program.

 # # **Scope:** 

**What it will do: **

1. The user can set up the application to send a birthday wish email to a list of contacts on their birthday.

2. The user can edit the contact list. 

3. It will randomly pick an email to send to each of these friends in the contact list.

   

**What it will not do:** 

1. Send the birthday wish via text message.
2. The application will not send photos or pictures to the emails.
3. The user cannot search the contact list by a day within the month, e.g. 13/01/2022The user cannot update the details of more than one contact at a time. After saving a new contact the application will not ask if the user wishes to add another contact.
4. The user cannot search the contact list by date of birth or email. 
5. The application will not save birthdays on a leap year.
6. The year of birth is not included in the date of birth. therefore the age of each contact is not tracked. Some selections will go undo or go back. 
7.  The names of the sender or receiver will not include emojis, emoticons, symbols or other languages.



**Requirement/Features:** 

1. . Variables:Loops: Conditional control structures: Error handling: 

The user can create, add, edit details or delete contacts from the list. Variables:Loops: Conditional control structures: Error handling: 

To add a contact, the application requires; full name, date of birth and email. Variables: Loops: Conditional control structures: Error handling: 

After adding the contact, the application will ask the user to review the details before saving Variables:Loops: Conditional control structures: Error handling: 

The user can search the contact list only by contact name. Variables:Loops: Conditional control structures: Error handling: 
When searching the contact list the user can only one contact from the search results. Variables:Loops: Conditional control structures: Error handling: 
The user can search the contact list within a customized interval of calendar months, e.g. birthdays between April and June. Variables:Loops: Conditional control structures: Error handling: 
The application will send the recipient a birthday wish to their email with the recipient name in it.  Variables:Loops: Conditional control structures: Error handling: 

### Installation 
You will need:
1. Ruby installed. If you don't already have it, you can find it [here](https://www.ruby-lang.org/en/downloads/). 

2. Ruby Gems:
   1. Artii [here](https://rubygems.org/search?query=artii) 
   
   2. tty-prompt  [here](https://rubygems.org/gems/tty-prompt) 
   
   3. colorize [here](https://rubygems.org/gems/colorize)  
   
   4. Json [here](https://rubygems.org/gems/json)
   
   5. Pastel [here](https://rubygems.org/gems/pastel/versions/0.7.1)
   
   6. Bundler  [here](https://help.dreamhost.com/hc/en-us/articles/115001070131-Using-Bundler-to-install-Ruby-gems).
   
      


## Steps to install Birthday Wisher

**To install from Github:**

1. Open terminal

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

please check the [link](https://github.com/wildbit/postmark-gem/wiki/Getting-Started) for further details

For the purpose of this assignment, all these details have been hardcoded. AND WILL BE DELETED ONCE THE PURPOSE IS MET.



### Potential Ethical, Legal Implications

