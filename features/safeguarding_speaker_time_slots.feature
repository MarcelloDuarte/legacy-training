Feature: Safeguarding each speakers timeslots from overlapping entries

  In order to my tail details from accidentally overlapping speakers times
  As a Event Speaker
  I need to have my submitted talk validated so that it does not overlap with previously submitted talks

  Background:
    Given there is an event named "Reclaiming the Legacy"

  Scenario: Being able to submit a talk which starts after the previous one ends
    Given the event has a talk named "Using BDD on Legacy Code" starting at 10:00 running for 50 minutes
    When I add a another talk named "Using PhpSpec on Legacy Code" starting at 11:00
    Then I should be informed that the talk was successfully added
    And the second talk listed for this event should be "Using PhpSpec on Legacy Code"

  Scenario: Being able to submit a talk which ends before the next talk begins
    Given the event has a talk named "Using BDD on Legacy Code" starting at 10:00
    When I add a another talk named "Using PhpSpec on Legacy Code" starting at 9:30 running for 20 minutes
    Then I should be informed that the talk was successfully added
    And the first talk listed for this event should be "Using PhpSpec on Legacy Code"

  Scenario: Not being able to submit a talk when its start-time overlaps with a previous talk
    Given the event has a talk named "Using BDD on Legacy Code" starting at 10:00 running for 50 minutes
    When I add a another talk named "Using PhpSpec on Legacy Code" starting at 10:30
    Then I should be informed that my talk overlaps with an existing talk
    And there should only be one talk listed for this event

  Scenario: Not being able to submit a talk when its end-time overlaps with a previous talk
    Given the event has a talk named "Using BDD on Legacy Code" starting at 10:00
    When I add a another talk named "Using PhpSpec on Legacy Code" starting at 9:30 running for 40 minutes
    Then I should be informed that my talk overlaps with an existing talk
    And there should only be one talk listed for this event



