```php
<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\RawMinkContext;

/**
 * Defines application features from the specific context.
 */
class TalksContext extends RawMinkContext implements Context, SnippetAcceptingContext
{
    private $db;

    private $eventId;

    private $lastAddedTalk;

    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     */
    public function __construct()
    {
        $this->db = mysqli_connect('localhost', 'root', '', 'joindin');
    }

    /**
     * @beforeScenario
     */
    public function clearEventsAndTalks()
    {
        mysqli_query($this->db, "DELETE FROM event_track");
        mysqli_query($this->db, "DELETE FROM events");
        mysqli_query($this->db, "DELETE FROM talks");
        mysqli_query($this->db, "DELETE FROM talk_track");
        mysqli_query($this->db, "DELETE FROM talk_speaker");
    }
    /**
     * @Given there is an event named :eventName
     */
    public function thereIsAnEventCalled($eventName)
    {
        mysqli_query($this->db, "INSERT INTO `events` VALUES (\"$eventName\",NULL,UNIX_TIMESTAMP(),UNIX_TIMESTAMP()+24*3600,0.0000000000000000,0.0000000000000000,null,'Skillsmatter','test',1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'N','Europe','Amsterdam','test','test@test.com',NULL,0,2,0)");
        $this->eventId = mysqli_insert_id($this->db);
    }

    /**
     * @Given I have already added a talk named :talkName
     * @When I add a talk named :talkName
     * @When I add a another talk named :talkName
     */
    public function iAddATalkNamed($talkName)
    {
        $this->getSession()->visit('talk/add/event/'.$this->eventId);

        $page = $this->getSession()->getPage();
        $page->fillField('talk_title', $talkName);
        $page->fillField('speaker_row[new_1]', 'Marcello');
        $page->fillField('talk_desc', 'What my talk is about');
        $page->pressButton('Add Session');

        $this->lastAddedTalk = $talkName;
    }

    /**
     * @Then the talk :talkName should be listed for this event
     */
    public function thisTalkShouldBeListedOnTheEventPage($talkName)
    {
        $this->getSession()->getPage()->clickLink('View Event');

        $this->assertSession()->elementsCount('css', '#talks table tr', 2);
        $this->assertSession()->elementTextContains('css', '#talks table tr.row1 td:nth-child(2) a', $talkName);
    }

    /**
     * @Then I should be informed that the talk was successfully added
     */
    public function iShouldBeInformedTheTalkSuccessfullyAdded()
    {
        $this->assertSession()->pageTextContains(' Talk information successfully added');
    }

    /**
     * @Then I should be informed that a talk with the same name already exists
     */
    public function iShouldBeInformedThatATalkWithTheSameNameAlreadyExists()
    {
        $this->assertSession()->pageTextContains('There was an error adding the talk information! (Duplicate talk)');
    }

    /**
     * @Then there should only be one talk listed for this event
     */
    public function thereShouldOnlyBeOneTalkListed()
    {
        $this->getSession()->getPage()->clickLink('View Event');

        $this->assertSession()->elementsCount('css', '#talks table tr', 2);
    }

    /**
     * @Then I should be informed that the talk title is missing
     */
    public function iShouldBeInformedThatTheTalkTitleIsMissing()
    {
        $this->assertSession()->pageTextContains('The Talk Title field is required');
    }

    /**
     * @Then there should be no talks listed for this event
     */
    public function thereShouldBeNoTalksListedOnTheEventPage()
    {
        $this->getSession()->visit('event/view/'.$this->eventId);

        $this->assertSession()->elementsCount('css', '#talks table', 0);
    }

    /**
     * @Then the second talk listed for this event should be :talkName
     */
    public function theSecondTalkListedOnItsEventPageShouldBe($talkName)
    {
        $this->getSession()->getPage()->clickLink('View Event');

        $this->assertSession()->elementsCount('css', '#talks tr', 3);
        $this->assertSession()->elementTextContains('css', '#talks table tr.row2 td:nth-child(2) a', $talkName);
    }

    /**
     * @Given this event has a track named :trackName
     */
    public function thisEventHasATrackNamed($trackName)
    {
        mysqli_query($this->db, "INSERT INTO `event_track` VALUES ($this->eventId,\"$trackName\",\"$trackName\",NULL, '')");
    }

    /**
     * @When I add a talk named :talkName to the track :trackName
     */
    public function iAddATalkNamedToTheTrack($talkName, $trackName)
    {
        throw new PendingException();
    }

    /**
     * @Then its track should be :trackName
     */
    public function itsTrackShouldBe($trackName)
    {
        throw new PendingException();
    }

    /**
     * @When change the title of my talk to :newTitle
     */
    public function changeTheTitleOfMyTalkTo($newTitle)
    {
        $result = mysqli_query($this->db, "SELECT ID FROM `talks` WHERE talk_title=\"{$this->lastAddedTalk}\"");
        $cols = mysqli_fetch_assoc($result);

        $this->getSession()->visit('/talk/edit/'.$cols['ID']);

        $page = $this->getSession()->getPage();
        $page->fillField('talk_title', $newTitle);
        $page->pressButton('Save Edits');

        $this->lastAddedTalk = $newTitle;
    }

    /**
     * @Then I should be informed that the talk information was successfully updated
     */
    public function iShouldBeInformedThatTheTalkInformationWasSuccessfullyUpdated()
    {
        $this->assertSession()->pageTextContains('Talk information successfully updated');
    }

    /**
     * @Then the new title of the talk should be :newTitle
     */
    public function theNewTitleOfTheTalkShouldBe($newTitle)
    {
        $this->assertSession()->fieldValueEquals('talk_title', $newTitle);
    }
}
```
