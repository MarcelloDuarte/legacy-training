Feature: Adding talks to an event

  In order to allow event attendees to give feedback on a specific talk
  As a Event Host
  I needs speakers to be able to add their talk to the event

  Scenario: Successfully adding a new talk
    Given there is an event named "Reclaiming the Legacy"
    When I add a talk named "Using BDD on Legacy Code"
    Then I should be informed that the talk was successfully added
    And the talk "Using BDD on Legacy Code" should be listed for this event

  Scenario: Being able to edit my previously added talk title
    Given there is an event named "Reclaiming the Legacy"
    And I have already added a talk named "Using BDD on Legacy Code"
    When change the title of my talk to "Using Behat on Legacy Code"
    Then I should be informed that the talk information was successfully updated
    And the new title of the talk should be "Using Behat on Legacy Code"

  Scenario: Being informed that the talk title is missing
    Given there is an event named "Reclaiming the Legacy"
    When I add a talk named ""
    Then I should be informed that the talk title is missing
    And there should be no talks listed for this event

  Scenario: Being told a talk with the same title already exists
    Given there is an event named "Reclaiming the Legacy"
    And I have already added a talk named "Using BDD on Legacy Code"
    When I add a another talk named "Using BDD on Legacy Code"
    Then I should be informed that a talk with the same name already exists
    And there should only be one talk listed for this event

  Scenario: Being able to add more than one talk
    Given there is an event named "Reclaiming the Legacy"
    And I have already added a talk named "Using BDD on Legacy Code"
    When I add a another talk named "Using PhpSpec on Legacy Code"
    Then I should be informed that the talk was successfully added
    And the second talk listed for this event should be "Using PhpSpec on Legacy Code"

  Scenario: Adding a talk to a given event track
    Given there is an event named "Reclaiming the Legacy"
    And this event has a track named "Behaviour Driven Development"
    When I add a talk named "Using BDD on Legacy Code" to the track "Behaviour Driven Development"
    Then the talk "Using BDD on Legacy Code" should be listed for this event
    And its track should be "Behaviour Driven Development"
