if Rails.env.development?
  Houston::Alerts.config.sync :open, "zendesk", every: "5m", icon: "fa-life-buoy" do

    # We want to pull down all the tickets that have been
    # assigned to the EP group. We can't do that directly
    # with the API, so we create a view in Zendesk that
    # performs that filter and use it here.
    $zendesk.tickets(path: "views/69193308/tickets").map { |ticket|
      project_slug = case ticket["tags"].join(" ")
      when /\b360members\b/ then "members"
      when /\b360unite\b/ then "unite"
      when /\b360ledger\b/ then "ledger"
      end

      { key: ticket.url,
        number: ticket.id,
        summary: ticket.subject,
        text: ticket.description,
        environment_name: "production",
        project_slug: project_slug,
        url: "https://concordiatech1446588092.zendesk.com/agent/tickets/#{ticket.id}" } }
  end
end