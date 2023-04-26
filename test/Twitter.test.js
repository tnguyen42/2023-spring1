const { ethers } = require('hardhat');
require('chai').should();

describe('Twitter tests', () => {
  beforeEach(async () => {
    Twitter = await ethers.getContractFactory('Twitter');
    twitter = await Twitter.deploy();
    [author0, author1] = await ethers.getSigners();
  });

  describe('CRUD features', () => {
    beforeEach(async () => {
      await twitter.connect(author0).createTweet('First tweet');
    });

    it('should have 1 tweet in the initial state', async () => {
      (await twitter.getTweets()).length.should.equal(1);
    });

    it('should return the content of the first tweet', async () => {
      const firstTweet = await twitter.getTweet(0);
      firstTweet[0].should.equal('First tweet');
      firstTweet[1].should.equal(author0.address);
    });
  });
});
