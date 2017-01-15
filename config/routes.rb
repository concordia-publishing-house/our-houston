Houston::Engine.routes.draw do


  # Activity Feed

  get "activity" => "activity_feed#index", as: :activity_feed



  # Dashboards

  namespace "dashboards" do
    get "releases", :to => "releases#index"
    get "recent", :to => "releases#recent"
    get "upcoming", :to => "releases#upcoming"
    get "staging", :to => "staging#index"
    get "pulls", :to => "pulls#index"
  end



  # Reports

  scope "reports" do
    # Shows various stats about process and product
    get "", to: "reports#default"
    get "star", to: "reports#star2"

    # Shows who has entered their Star and Empower time over the last two weeks
    get "star/dashboard", to: "reports#star"

    # Alerts, historical
    get "alerts", to: "reports#alerts"

    # Scorecards
    get "weekly/by_user/:nickname", to: "reports#user_report"

    # Sprint and Alerts details for each week
    get "weekly", to: "reports#weekly_report", as: :weekly_report

    constraints bin: /weekly|daily/ do
      get ":bin/star/by_component.xlsx", to: "reports#star_export_by_component"
      get ":bin/star/chargeable.xlsx", to: "reports#star_export_chargeable"
    end
  end



  # Nanoconfs

  namespace "nanoconfs" do
    get "past", to: "presentations#past_presentations", as: :past_presentations
    get "", to: "presentations#index", as: :presentations
    get "new", to: "presentations#new", as: :new_presentation
    post "", to: "presentations#create", as: :create_presentation
    get ":id", to: "presentations#show", as: :presentation
    get ":id/edit", to: "presentations#edit", as: :edit_presentation
    patch ":id", to: "presentations#update", as: :update_presentation
  end



   # Conversation Tester

  get "conversation", to: "conversations#new"
  get "conversation/recognize", to: "conversations#recognize"
  get "conversation/entities", to: "conversations#entities"



  # Pull Requests

  get "pulls", to: "github/pulls#index"



  # Misc

  get "colors", to: "colors#index"
  get "extras/pairs", to: "extras#pairs"

end
