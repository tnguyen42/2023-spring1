// SPDX-License-Identifier: Unlicense
// Specify the versions of Solidity compatible
pragma solidity >=0.8.0 <0.9.0;

contract Twitter {
  struct Tweet {
    string content;
    address author;
    uint256 id;
    uint256 timestamp;
    bool deleted;
  }

  Tweet[] private _tweets;

  /**
   * A NatSpec comment
   * This function allows a user to write a tweet
   * @param _content The content of the tweet
   */
  function createTweet(string calldata _content) external {
    Tweet memory newTweet;

    newTweet.content = _content;
    newTweet.author = msg.sender;
    newTweet.timestamp = block.timestamp;
    newTweet.id = _tweets.length;
    newTweet.deleted = false;

    _tweets.push(newTweet);
  }

  /**
   * Returns a specific tweet given an id
   * @param _id The id of the tweet you want to fetch
   * @return A specific tweet, given an id
   */
  function getTweet(uint256 _id) external view returns (Tweet memory) {
    require(_tweets[_id].deleted == false, 'The tweet you are searching is deleted');
    return _tweets[_id];
  }

  /**
   * Returns all the tweets
   */
  function getTweets() external view returns (Tweet[] memory) {
    Tweet[] memory returnedTweets;
    uint256 j = 0;

    // Go through the entire array of tweets and only return the not-deleted tweets
    for (uint256 i = 0; i < _tweets.length; i++) {
      if (_tweets[i].deleted == false) {
        // TODO: this line breaks the unit tests
        returnedTweets[j] = _tweets[i];
        j++;
      }
    }

    return returnedTweets;
  }

  /**
   * Allows an author to update his own tweet
   * @param _id The id of the tweet to be updated
   */
  function updateTweet(uint _id, string calldata _newContent) external {
    // Check the condition defined in the first argument, and goes forward if true, throws the error
    // in the second argument otherwise
    require(_tweets[_id].deleted == false, 'The tweet you are searching is deleted');
    require(_tweets[_id].author == msg.sender, 'Only the author of the tweet can edit it');

    _tweets[_id].content = _newContent;
  }

  /**
   * Delete a given tweet
   * @param _id The id of the tweet to be deleted
   */
  function deleteTweet(uint256 _id) external {
    require(_tweets[_id].deleted == false, 'You are trying to delete a tweet that is already deleted');
    require(_tweets[_id].author == msg.sender, 'Only the author of the tweet can delete it');
    _tweets[_id].deleted = true;
  }
}
