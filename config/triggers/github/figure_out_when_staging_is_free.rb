Houston.config do
  on "github:pull:updated" do |pull_request, changes|
    next unless changes.key? "labels"
    before, after = changes["labels"]

    removed = before - after
    added = after - before

    removed.each do |label|
      Houston.observer.fire "github:pull:label-removed", pull_request, label
    end

    added.each do |label|
      Houston.observer.fire "github:pull:label-added", pull_request, label
    end

    if (before.include?("on-staging") && added.include?("test-pass")) || removed.include?("on-staging")
      Houston.observer.fire "staging:#{pull_request.project.slug}:free"
    end
  end
end
