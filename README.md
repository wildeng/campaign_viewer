# README
Tech Test Cygnets

Design choices:

Given the nature of the task I’ve decided to stick with sqlite which I think fits the purpose of the test. In a real life scenario a more mature and business oriented database - Postgres or MariaDB - is recommended
The interface is pure Rails “out of the box”

To keep the design simple I’ve decided to use three tables:

1- Campaigns 
2- Votes
3- Candidates

1- Campaigns has three fields
	* Name - string
	* The 2 standard Active record timestamp fields
	* I would have created a start and end fields to identify when the campaign started end ended but, I didn’t have any information regarding this
	* A description field could also have been useful but this is out of the scope of the exercise
	* The table has a one to many relationship with votes
	* The table has a one to many relationship with candidates

2- Votes
	* choice - string
	* validity - integer -> this comes from the fact that I decided to use an enum to represent the valid states of this field in the model. This makes sure that when creating a vote with a not permitted state - for example during the import script - I can catch the error and properly manage the exception
	* campaign_id -> foreign key that makes easier to count the votes for a campaign
	* Usual Rails timestamps

3- Candidates
	* name - string field that represents the candidate
	* campaign_id -> foreign key that makes easier to load the candidates belonging to a campaign
	* score - an integer representing all the valid votes
	* uncounted_messagges - an integer representing the number of votes received but not counted as valid


The heavy lifting is all done through the import script which has the following responsibilities:
	* Checking that each line of the votes sample is a valid vote
	* If it’s a valid vote sample creates the campaign DB record - only if it doesn’t exists - and loads all valid votes in the DB. This has been put into a transaction to make a rollback easier in case of an error. I think that this could also be further improved by using atomic transaction instead of what is know to try to have more control around the import script.
	* After loading the votes it calculates the score of each candidate and the number of uncounted votes for each candidate by using two methods that have been created in the Campaign model. This has been made possible by creating a rake task which loads the Rails environment and provides access to all necessary models.

- To Run the code
    - Clone the repository
    - Bundle install
    - Run Rails db:migrate
    - Run rails --trace import_data <absolute_path_of_the_input_file>
    - Run rails s to run in development mode

