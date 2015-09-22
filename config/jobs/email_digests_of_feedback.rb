Houston.config do
  at "3:35pm", "report:feedback:daily.digest" do
    User.with_view_option("feedback.digest", "daily").find_each do |user|
      comments = Houston::Feedback::Comment
        .where(project_id: user.followed_projects.pluck(:id))
        .unread_by(user)
        .since(1.day.ago)
      Houston.try({max_tries: 3}, Net::OpenTimeout) do
        Houston::Feedback::Mailer.daily_digest_for(comments, user).deliver! if comments.any?
      end
    end
  end

  at "3:35pm", "report:feedback:weekly.digest", every: :friday do
    User.with_view_option("feedback.digest", "weekly").find_each do |user|
      comments = Houston::Feedback::Comment
        .where(project_id: user.followed_projects.pluck(:id))
        .unread_by(user)
        .since(1.week.ago)
      Houston.try({max_tries: 3}, Net::OpenTimeout) do
        Houston::Feedback::Mailer.weekly_digest_for(comments, user).deliver! if comments.any?
      end
    end
  end
end