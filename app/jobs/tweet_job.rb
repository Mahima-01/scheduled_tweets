class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    binding.irb
    return if tweet.published?

    # Rescheduled a twwet to the future
    return if tweet.published_at > Time.current

    tweet.publish_to_twitter!
  end
end

# Push the published_at forward
# noon -> 8am
# -
# 8am -> sets tweet id
# Noon -> published, does nothing

# Push the published_at forward
# 9am -> 1pm
# -
# 9am -> should do nothing
# 1pm -> should publish the tweet and set the tweet_id