<?php
/**
 * Talk pages controller.
 *
 * PHP version 5
 *
 * @category  Joind.in
 * @package   Controllers
 * @copyright 2009 - 2010 Joind.in
 * @license   http://github.com/joindin/joind.in/blob/master/doc/LICENSE JoindIn
 * @link      http://github.com/joindin/joind.in
 */
use Joindin\EventManager;

/**
 * Talk pages controller.
 *
 * Responsible for displaying talk related pages.
 *
 * @category  Joind.in
 * @package   Controllers
 * @copyright 2009 - 2010 Joind.in
 * @license   http://github.com/joindin/joind.in/blob/master/doc/LICENSE JoindIn
 * @link      http://github.com/joindin/joind.in
 *
 * @property  CI_Config   $config
 * @property  CI_Loader   $load
 * @property  CI_Template $template
 * @property  CI_Input    $input
 * @property  User_model  $user_model
 */
class Talk extends Controller
{
    var $auth = false;

    /**
     * Constructor, checks whether the user is logged in and passes this to
     * the template.
     *
     * @return void
     */
    function Talk()
    {
        parent::Controller();
        $this->auth = ($this->user_model->isAuth()) ? true : false;

        // check login status and fill the 'logged' parameter in the template
        $this->user_model->logStatus();
    }

    /**
     * Displays a list of popular and recent talks.
     *
     * @return void
     */
    function index()
    {
        $this->load->helper('form');
        $this->load->library('validation');
        $this->load->model('talks_model');

        $talks = array(
            'popular' => $this->talks_model->getPopularTalks(),
            'recent'  => $this->talks_model->getRecentTalks()
        );

        $this->template->write_view(
            'content', 'talk/main', array(
                'talks' => $talks
            ), true
        );
        $this->template->render();
    }

    /**
     * Displays the add and edit page and processes the submit.
     *
     * @param mixed|null $id  Either the string 'event' or the id of the talk
     * @param mixed|null $opt Id of the event if $id = 'event'
     *
     * @return void
     */
    function add($id = null, $opt = null)
    {
        $tracks = array();

        $this->load->model('talks_model');
        $this->load->model('event_model');
        $this->load->model('categories_model');
        $this->load->model('lang_model');
        $this->load->helper('form');
        $this->load->library('validation');
        $this->load->library('timezone');
        $this->load->model('event_track_model', 'eventTracks');
        $this->load->model('talk_track_model', 'talkTracks');
        $this->load->model('talk_speaker_model', 'talkSpeakers');

        if (isset($id) && $id == 'event') {
            $eid = $opt;
            $id  = null;

        } elseif ($id) {
            $this->edit_id = $id;

            $det = $this->talks_model->getTalks($id);
            $eid = $det[0]->eid;

        } elseif (!$id && !$opt) {
            //no options specified!
            redirect();
        }

        $rules  = array(
            'event_id'     => 'required',
            'talk_title'   => 'required',
            'talk_desc'    => 'required',
            'given_mo'     => 'callback_given_mo_check',
            'slides_link'  => 'callback_slides_link_check'
        );
        $fields = array(
            'event_id'     => 'Event Name',
            'talk_title'   => 'Talk Title',
            'given_mo'     => 'Given Month',
            'given_day'    => 'Given Day',
            'given_yr'     => 'Given Year',
            'given_hour'   => 'Given Hour',
            'given_min'    => 'Given Minute',
            'duration'     => 'Session Length',
            'slides_link'  => 'Slides Link',
            'talk_desc'    => 'Talk Description',
            'session_track' => 'Session Track'
        );
        $this->validation->set_rules($rules);
        $this->validation->set_fields($fields);

        // if we have the event ID in our option...
        if ($id == null && $opt != null) {
            $tracks = $this->eventTracks->getEventTracks($opt);
        }

        if ($id) {
            $thisTalk = $det[0];
            $det      = $this->talks_model->getTalks($id);

            $events = $this->event_model->getEventDetail($thisTalk->event_id);
            $tracks = $this->eventTracks->getEventTracks($thisTalk->eid);

            $thisTalksEvent = (isset($events[0])) ? $events[0] : array();
            $thisTalksTrack = (isset($tracks[0])) ? $tracks[0] : array();

            $track_info = $this->talkTracks->getSessionTrackInfo($thisTalk->ID);
            $is_private = ($thisTalksEvent->private == 'Y') ? true : false;

            $this->validation->session_track = (empty($track_info))
                ? null : $track_info[0]->ID;

            foreach ($thisTalk as $k => $v) {
                $this->validation->$k = $v;
            }

            // set our speaker information
            $this->validation->speaker
                = $this->talkSpeakers->getSpeakerByTalkId($id);

            $this->validation->eid        = $thisTalk->eid;
            $this->validation->given_day  = $this->timezone
                ->formattedEventDatetimeFromUnixtime(
                    $thisTalk->date_given,
                    $thisTalk->event_tz_cont . '/' . $thisTalk->event_tz_place,
                    'd'
                );
            $this->validation->given_mo   = $this->timezone
                ->formattedEventDatetimeFromUnixtime(
                    $thisTalk->date_given,
                    $thisTalk->event_tz_cont . '/' . $thisTalk->event_tz_place,
                    'm'
                );
            $this->validation->given_yr   = $this->timezone
                ->formattedEventDatetimeFromUnixtime(
                    $thisTalk->date_given,
                    $thisTalk->event_tz_cont . '/' . $thisTalk->event_tz_place,
                    'Y'
                );
            $this->validation->given_hour = $this->timezone
                ->formattedEventDatetimeFromUnixtime(
                    $thisTalk->date_given,
                    $thisTalk->event_tz_cont . '/' . $thisTalk->event_tz_place,
                    'H'
                );
            $this->validation->given_min  = $this->timezone
                ->formattedEventDatetimeFromUnixtime(
                    $thisTalk->date_given,
                    $thisTalk->event_tz_cont . '/' . $thisTalk->event_tz_place,
                    'i'
                );

            $this->validation->talkDate = $this->validation->given_yr . '-' .
                $this->validation->given_mo . '-' .
                $this->validation->given_day;

            $this->validation->session_lang = $thisTalk->lang_id;
            $this->validation->session_type = $thisTalk->tcid;
        } else {
            $events         = $this->event_model->getEventDetail($eid);
            $thisTalksEvent = $events[0];
            $det            = array();

            //set the date to the start date of the event
            $this->validation->given_mo   = date('m', $thisTalksEvent->event_start);
            $this->validation->given_day  = date('d', $thisTalksEvent->event_start);
            $this->validation->given_yr   = date('Y', $thisTalksEvent->event_start);
            $this->validation->given_hour = date('H', $thisTalksEvent->event_start);
            $this->validation->given_min  = date('i', $thisTalksEvent->event_start);

            $this->validation->session_track = null;
            $this->validation->speaker       = array();

            // If we have an error but have posted speakers, load them...
            if ($posted_speakers = $this->input->post('speaker_row')) {
                foreach ($posted_speakers as $speaker) {
                    $obj = new stdClass();

                    $obj->speaker_name           = $speaker;
                    $this->validation->speaker[] = $obj;
                    unset($obj);
                }
            }

            $is_private = false;
        }

        if (isset($eid)) {
            $this->validation->event_id = $eid;
        }

        if ($this->validation->run() != false) {
            // store the session length in the session, as a handy shortcut
            $this->session->set_userdata(
                'duration',
                (int)$this->input->post('duration')
            );

            if (!empty($thisTalksEvent->event_tz_cont)
                && !empty($thisTalksEvent->event_tz_place)
            ) {
                $talk_timezone = new DateTimeZone(
                    $thisTalksEvent->event_tz_cont . '/' .
                    $thisTalksEvent->event_tz_place
                );
            } else {
                $talk_timezone = new DateTimeZone('UTC');
            }

            $talk_datetime = new DateTime(
                $this->input->post('talkDate') . ' ' .
                $this->input->post('given_hour') . ':' .
                $this->input->post('given_min'), $talk_timezone
            );

            $unix_timestamp = $talk_datetime->format("U");

            $arr = array(
                'talk_title'  => $this->input->post('talk_title'),
                'slides_link' => $this->input->post('slides_link'),
                'date_given'  => $unix_timestamp,
                'duration'    => (int)$this->input->post('duration'),
                'event_id'    => $this->input->post('event_id'),
                'talk_desc'   => $this->input->post('talk_desc'),
                'active'      => '1',
                'lang'        => $this->input->post('session_lang')
            );

            if ($id) {
                // update the speaker information
                $this->talkSpeakers->handleSpeakerData(
                    $id, $this->input->post('speaker_row')
                );

                $this->db->where('id', $id);
                $this->db->update('talks', $arr);

                // remove the current reference for the talk category and
                // add a new one
                $this->db->delete(
                    'talk_cat', array(
                        'talk_id' => $id
                    )
                );

                $this->validation->speaker = $this->talkSpeakers
                    ->getTalkSpeakers($id);

                // check to see if we have a track and it's not the "none"
                if ($this->input->post('session_track') != 'none') {
                    $curr_track = (isset($track_info[0]->ID))
                        ? $track_info[0]->ID : null;
                    $new_track  = $this->input->post('session_track');
                    $this->talkTracks->updateSessionTrack(
                        $id, $curr_track, $new_track
                    );
                    $this->validation->session_track = $new_track;
                } elseif ($this->input->post('session_track') == 'none') {
                    //remove the track for the session
                    if (is_array($track_info) && count($track_info) > 0
                        && is_object($thisTalksTrack)
                    ) {
                        $curr_track = $thisTalksTrack->ID;
                        $this->talkTracks->deleteSessionTrack($id, $curr_track);
                    }
                }

                $msg   = 'Talk information successfully updated! ' .
                    '<a href="/talk/view/' . $id . '">Return to talk</a>';
                $pass  = true;
            } else {
                //check to be sure its unique
                $q   = $this->db->get_where('talks', $arr);
                $ret = $q->result();

                // check to be sure that all of the talk information is new
                $this->talks_model->isTalkDataUnique(
                    $arr, $this->input->post('speaker_row')
                );

                if (count($ret) == 0) {
                    $this->db->insert('talks', $arr);
                    $tc_id = $this->db->insert_id();

                    $this->event_model->cacheTalkCount($thisTalksEvent->ID);

                    // Add the new speakers
                    $this->talkSpeakers->handleSpeakerData(
                        $tc_id, $this->input->post('speaker_row')
                    );
                    $this->validation->speaker = $this->talkSpeakers
                        ->getTalkSpeakers($tc_id);

                    // check to see if we have a track and it's not the "none"
                    if ($this->input->post('session_track') != 'none') {
                        $this->talkTracks->setSessionTrack(
                            $tc_id, $this->input->post('session_track')
                        );
                    }

                    $msg  = 'Talk information successfully added!</br>' .
                        '<a href="/talk/add/event/' . $thisTalksEvent->ID . '">' .
                        'Add another</a> ';
                    $msg .= 'or <a href="/event/view/' . $thisTalksEvent->ID .
                        '">View Event</a>';
                } else {
                    $err  = 'There was an error adding the talk information! ' .
                        '(Duplicate talk)<br/>';
                    $err .= '<a href="/event/view/' . $thisTalksEvent->ID .
                        '">View Event</a>';
                }
            }

        }

        $det = $this->talks_model->setDisplayFields($det);
        $out = array(
            'msg'            => (isset($msg)) ? $msg : '',
            'err'            => (isset($err)) ? $err : '',
            'timezone'       => $this->timezone,
            'events'         => $events,
            'cats'           => $cats,
            'langs'          => $langs,
            'detail'         => $det,
            'evt_priv'       => $is_private,
            'tracks'         => $tracks,
            'thisTalksEvent' => $thisTalksEvent
        );
        $this->template->write_view('content', 'talk/add', $out, true);
        $this->template->render();
    }

    /**
     * Displays and processes the edit action.
     *
     * Actually uses the add action.
     *
     * @param integer $id The id of the talks
     *
     * @see Talk::add()
     *
     * @return void
     */
    function edit($id)
    {
        $this->add($id);
    }

    /**
     * Displays and processes the delete action.
     *
     * @param integer $id The id of the talks
     *
     * @return void
     */
    function delete($id)
    {
        $this->load->model('talks_model');
        $this->load->model('event_model');
        $this->load->model('user_model');
        $this->load->model('talk_track_model', 'talkTracks');

        // check to see if they're supposed to be here
        if (!$this->auth) {
            redirect('/user/login', 'refresh');
        }

        $talk_detail = $this->talks_model->getTalks($id);
        if (empty($talk_detail)) {
            redirect('talk');
        }

        $arr = array(
            'error' => ''
        );

        if ($this->user_model->isAdminEvent($talk_detail[0]->eid)) {
            $this->load->helper('form');
            $this->load->library('validation');
            $this->load->model('talks_model');

            $arr['tid'] = $id;
            if (isset($_POST['answer']) && ($_POST['answer'] == 'yes')) {
                $this->talks_model->deleteTalk($id);

                $this->event_model->cacheTalkCount($talk_detail[0]->eid);

                // delete any records in the tracks table too
                $this->talkTracks->deleteSessionTrack($id);
                unset($arr['tid']);
            }
        } else {
            $arr['error'] = 'No event administration rights';
        }

        $this->template->write_view('content', 'talk/delete', $arr, true);
        $this->template->render();
    }

    /**
     * Displays the details for a talk.
     *
     * @param integer     $id      the id of the talk
     * @param string|null $add_act if 'claim' tries to claim the talk
     * @param string|null $code    code to claim talk with
     *
     * @return void
     */
    function view($id, $add_act = null, $code = null)
    {
        $this->load->model('talks_model');
        $this->load->model('event_model');
        $this->load->model('event_comments_model');
        $this->load->model('invite_list_model', 'ilm');
        $this->load->model('user_attend_model');
        $this->load->model('talk_track_model', 'talkTracks');
        $this->load->model('talk_comments_model', 'tcm');
        $this->load->model('talk_speaker_model', 'talkSpeakers');
        $this->load->helper('form');
        $this->load->helper('events');
        $this->load->helper('talk');
        $this->load->helper('reqkey');
        $this->load->plugin('captcha');
        $this->load->library('spamcheckservice', array('api_key' => $this->config->item('akismet_key')));
        $this->load->library('spam');
        $this->load->library('validation');
        $this->load->library('timezone');
        $this->load->library('sendemail');

        $msg = '';

        // filter it down to just the numeric characters
        if (preg_match('/[0-9]+/', $id, $m)) {
            $id = $m[0];
        } else {
            redirect('talk');
        }

        $talk_detail   = $this->talks_model->getTalks($id);
        if (empty($talk_detail)) {
            redirect('talk');
        }

        $claim_status = false;
        $claim_msg    = '';
        if (isset($add_act) && $add_act == 'claim') {
            // be sure they're loged in first...
            if (!$this->user_model->isAuth()) {
                //redirect to the login form
                $this->session->set_userdata(
                    'ref_url', '/talk/view/' . $id . '/claim/' . $code
                );
                redirect('user/login');
            } else {
                $sp = explode(',', $talk_detail[0]->speaker);

                $codes = array();

                //loop through the speakers to make the codes
                foreach ($sp as $k => $v) {
                    // we should be logged in now... lets check and
                    // see if the code is right

                    $str = buildCode(
                        $id, $talk_detail[0]->event_id,
                        $talk_detail[0]->talk_title, trim($v)
                    );

                    $codes[] = $str;
                }

            }
        }

        $cl = ($r = $this->talks_model->talkClaimDetail($id)) ? $r : array();

        $already_rated = false;
        if ($this->user_model->isAuth()) {
            // Find out if there is at least 1 comment that is made by our
            // user for this talk
            foreach ($this->talks_model
                ->getUserComments($this->user_model->getId()) as $comment) {
                if ($comment->talk_id == $id) {
                    $already_rated = $comment->ID;
                    break;
                }
            }
        }

        // build array of userIds with claim to this talk
        $claim_user_ids = array();
        foreach ($cl as $claim_item) {
            $claim_user_ids[] = $claim_item->userid;
        }

        $current_comment_id = 0;
        if ($this->input->post('edit_comment')) {
            $current_comment_id = $this->input->post('edit_comment');
        }

        // comment form validation rules:
        // rating:
        //      1. rating_check to ensure between 0 and 5
        //      2. required field if not already commented
        // comment:
        //      1. duplicate_comment_check to ensure exact comment isn't posted twice
        $rating_rule = 'callback_rating_check';

        $rules = array(
            'rating' => $rating_rule,
            'comment' => "callback_duplicate_comment_check[$id!$current_comment_id]",
        );

        $fields = array(
            'comment' => 'Comment',
            'rating'  => 'Rating'
        );

        // this is for the CAPTACHA - it was disabled for authenticated users
        if (!$this->user_model->isAuth()) {
            $rules['cinput']  = 'required|callback_cinput_check';
            $fields['cinput'] = 'Captcha';
        }
        $this->validation->set_rules($rules);
        $this->validation->set_fields($fields);

        if ($this->validation->run() == false) {
            // vote processing code removed
        } else {
            $is_auth = $this->user_model->isAuth();
            $arr     = array(
                'comment_type'    => 'comment',
                'comment_content' => $this->input->post('your_com')
            );

            $priv = $this->input->post('private');
            $priv = (empty($priv)) ? 0 : 1;

            $anonymous = $this->input->post('anonymous');
            $anonymous = (empty($anonymous)) ? 0 : 1;

            if (!$is_auth) {
                $sp_ret = $this->spam->check(
                    'regex', $this->input->post('comment')
                );
                error_log('sp: ' . $sp_ret);


                $ec['user_id'] = 0;
                $ec['cname']   = $this->input->post('cname');

                $ec['comment']      = $this->input->post('comment');
                $acceptable_comment = $this->spamcheckservice->isCommentAcceptable(array(
                    'comment' => $ec['comment'],
                ));
            } else {
                // They're logged in, let their comments through
                $acceptable_comment = true;
                $is_spam             = false;
                $sp_ret              = true;
            }

            if ($acceptable_comment && $sp_ret == true) {

                $arr = array(
                    'talk_id'   => $id,
                    'rating'    => $this->input->post('rating'),
                    'comment'   => $this->input->post('comment'),
                    'date_made' => time(), 'private' => $priv,
                    'active'    => 1,
                    'user_id'   => ($this->user_model->isAuth() && !$anonymous)
                    ? $this->session->userdata('ID') : '0'
                );

                $out = '';
                if ($this->input->post('edit_comment')) {
                    $cid = $this->input->post('edit_comment');
                    $uid = $this->session->userdata('ID');

                    // be sure they have the right to update the comment
                    $com_detail = $this->tcm->getCommentDetail($cid);
                    if (isset($com_detail[0])
                        && ($com_detail[0]->user_id == $uid)
                    ) {

                        // if the user has already rated and we're not editing that comment,
                        // then the rating for this comment is zero
                        if ($already_rated && $already_rated != $cid) {
                            $arr['rating'] = 0;
                        }

                        $commentEditTime = $com_detail[0]->date_made +
                            $this->config->item('comment_edit_time');
                        if (time() >= $commentEditTime) {
                            $out = 'This comment has passed its edit-time.'.
                               ' You cannot edit this comment anymore.';
                        } else {
                            $this->db->where('ID', $cid);
                            // unset date made.
                            unset($arr['date_made']);
                            if ($com_detail[0]->rating == 0) {
                                $arr['rating'] = 0;
                            }
                            $this->db->update('talk_comments', $arr);
                            $out = 'Comment updated!';
                        }
                    } else {
                        $out = 'Error on updating comment!';
                    }
                } else {
                    $this->db->insert('talk_comments', $arr);
                    $out = 'Comment added!';
                }

                //send an email when a comment's made
                $msg         = '';
                $arr['spam'] = ($is_spam == 'false') ? 'spam' : 'not spam';
                foreach ($arr as $ak => $av) {
                    $msg .= '[' . $ak . '] => ' . $av . "\n";
                }

                //if its claimed, be sure to send an email to the person to tell them
                if ($cl) {
                    $this->sendemail->sendTalkComment(
                        $id, $cl[0]->email, $talk_detail, $arr
                    );
                }

                $this->session->set_flashdata('msg', $out);
            }
            redirect(
                'talk/view/' . $talk_detail[0]->tid . '#comments', 'location', 302
            );
        }

        $captcha = create_captcha();
        $this->session->set_userdata(array('cinput' => $captcha['value']));

        $reqkey      = buildReqKey();
        $talk_detail = $this->talks_model->setDisplayFields($talk_detail);

        // catch this early...if it's not a valid session...
        if (empty($talk_detail)) {
            redirect('talk');
        }

        $is_talk_admin = $this->user_model->isAdminTalk($id);

        // Retrieve ALL comments, then Reformat and filter out private comments
        $all_talk_comments = $this->talks_model->getTalkComments(
            $id,
            null,
            true
        );
        $talk_comments     = splitCommentTypes(
            $all_talk_comments, $is_talk_admin, $this->session->userdata('ID')
        );

        // also given only makes sense if there's a speaker set
        if (!empty($talk_detail[0]->speaker)) {
            $also_given = $this->talks_model->talkAlsoGiven(
                $id, $talk_detail[0]->event_id
            );
            $also_given = array(
                'talks' => $also_given,
                'title' => 'Talk Also Given At...'
            );
        }

        $user_id  = ($this->user_model->isAuth())
            ? $this->session->userdata('ID') : null;
        $speakers = $this->talkSpeakers->getSpeakerByTalkId($id);
        // check if current user is one of the approved speakers
        $is_claim_approved = false;
        foreach ( $speakers as $speaker ) {
            if ( $speaker->speaker_id && $speaker->speaker_id == $user_id ) {
                $is_claim_approved = true;
            }
        }

        if (isset($talk_comments['comment'])) {
            for ($i = 0; $i < count($talk_comments['comment']); $i++) {
                if ($talk_comments['comment'][$i]->user_id != 0) {
                    $talk_comments['comment'][$i]->user_comment_count =
                        $this->event_comments_model->getUserCommentCount(
                            $talk_comments['comment'][$i]->user_id
                        ) +
                        $this->tcm->getUserCommentCount(
                            $talk_comments['comment'][$i]->user_id
                        );
                }
            }
        }

        $arr = array(
            'detail'         => $talk_detail[0],
            'comments'       => (isset($talk_comments['comment']))
            ? $talk_comments['comment'] : array(),
                'admin'          => ($is_talk_admin) ? true : false,
                'site_admin'     => ($this->user_model->isSiteAdmin())
                    ? true : false,
                'auth'           => $this->auth,
                'claimed'        => $this->talks_model->talkClaimDetail($id),
                'claim_status'   => $claim_status, 'claim_msg' => $claim_msg,
                'is_claimed'      => $this->talks_model->hasUserClaimed($id)
                    || $is_claim_approved,
                'speakers'       => $speakers,
                'reqkey'         => $reqkey, 'seckey' => buildSecFile($reqkey),
                'user_attending' => ($this->user_attend_model->chkAttend(
                    $currentUserId, $talk_detail[0]->event_id
                )) ? true : false,
                'msg'            => $msg,
                'track_info'     => $this->talkTracks->getSessionTrackInfo($id),
                'user_id'        => ($this->user_model->isAuth())
                ? $this->session->userdata('ID') : null,
                    'captcha'        => $captcha,
                    'alreadyRated'   => $already_rated,
                );

        $this->template->write('feedurl', '/feed/talk/' . $id);
        if (!empty($also_given['talks'])) {
            $this->template->write_view(
                'sidebar2', 'talk/_also_given', $also_given, true
            );
        }

        if (!isTalkClaimFull($arr['speakers'])) {
            $this->template->write_view(
                'sidebar3',
                'main/_sidebar-block',
                array(
                    'title'=>'Claiming Talks',
                    'content'=>'<p>Is this your talk? Claim it! By doing so it
                    lets us know you are the speaker. Once your claim is
                    verified by event administration it will be linked to your
                    account.</p>'
                )
            );
        }

        if ($is_talk_admin) {
            $this->template
                ->write_view('sidebar3', 'talk/modules/_talk_howto', $arr);
        }

        $this->template->write_view('content', 'talk/detail', $arr, true);
        $this->template->render();
    }

    /**
     * Claims a talk with the currently logged in user.
     *
     * @param int $talkId  Talk Id to claim
     * @param int $claimId Claim Id
     *
     * @return void
     */
    function claim($talkId, $claimId=null)
    {
        if ($claimId == null) {
            $claimId = $this->input->post('claim_name_select');
        }

        $this->load->model('talk_speaker_model', 'talkSpeaker');

        $this->load->model('pending_talk_claims_model', 'pendingClaims');

        $this->pendingClaims->addClaim($talkId, $claimId);

        $this->session->set_flashdata(
            'msg',
            'Thanks for claiming this talk! You will be emailed when the '.
            'claim is approved!'
        );
        redirect('talk/view/'.$talkId);

        return false;

        // OLD CODE IS BELOW......

        if (!$this->user_model->isAuth()) {
            redirect('talk/view/'.$talkId);
        }

        $userId      = $this->session->userdata('ID');
        $speakerName = $this->session->userdata('full_name');

        // Ie we have no $claimId, look in post for it
        if ($claimId == null) {
            $claimId = $this->input->post('claim_name_select');
        }

        if ($this->talkSpeaker->isTalkClaimed($talkId)) {
            $errorData = array(
                'msg' => sprintf(
                    'This talk has already been claimed! If you believe this '.
                    'is in error, please contact the please '.
                    '<a style="color:#FFFFFF" href="/event/contact/">'.
                    'contact this event\'s admins</a>.'
                )
            );
            $this->template->write_view('content', 'msg_error', $errorData);
            $this->template->render();
        }

        // look at the claimId (talk_speaker.id) and talkId for a speaker
        $where         = array(
            'ID'       => $claimId,
            'talk_id'    => $talkId,
            'status'   => null
        );
        $query         = $this->db->get_where('talk_speaker', $where);
        $speakerRecord = $query->result();

        // if we found a row, update it with the ID of the currently
        // logged in user and set it to pending
        if (count($speakerRecord) == 1) {

            $updateData = array(
                'status'      => 'pending',
                'speaker_id'   => $userId
            );
            $this->db->where('ID', $claimId);
            $this->db->update('talk_speaker', $updateData);

            $this->session->set_flashdata(
                'msg',
                'Thanks for claiming this talk! You will be emailed when '.
                'the claim is approved!'
            );
            redirect('talk/view/'.$talkId);
        } else {
            $errorData = array(
                'msg'=>sprintf(
                    'There was an error in your attempt to claim the talk ID #%s
                    <br/>
                    There might already be a pending claim for this session.
                    <br/><br/>
                    If you would like more information on this error, please
                    <a style="color:#FFFFFF" href="/event/contact/">contact
                        this event\'s admins</a>.',
                    $talkId
                ));
            $this->template->write_view('content', 'msg_error', $errorData);
            $this->template->render();
        }
    }

    /**
     * Unlink a talk claim from a speaker
     *
     * @param int $talkId    Talk ID
     * @param int $speakerId Speaker ID
     *
     * @return null
     */
    public function unlink($talkId, $speakerId)
    {
        if (!$this->user_model->isAuth()) {
            redirect('talk/view/' . $talkId);
        }

        // get the event the talk is a part of
        $this->load->model('talks_model');
        $this->load->model('user_model');

        $talks = $this->talks_model->getTalks($talkId);
        if ( count($talks) ) {
            $talk = $talks[0];
        }

        // ensure that the user is either a site admin or event admin
        if ($this->user_model->isSiteAdmin()
            || $this->user_model->isAdminEvent($talk->event_id)
        ) {
            $data = array(
                'talkId'    => $talkId,
                'speakerId' => $speakerId
            );

            $this->template->write_view('content', 'talk/unlink', $data);

            if (isset($_POST['answer']) && ($_POST['answer'] == 'yes')) {

                $this->load->model('talk_speaker_model');
                $user = $this->user_model->getUserById($speakerId);

                $this->talk_speaker_model->unlinkSpeaker($talkId, $user[0]->ID);
                redirect('talk/view/' . $talkId);
            }

            $this->template->render();
        } else {
            redirect('talk/view/' . $talkId);
        }
    }

    /**
     * Validates whether the given date is within the event's period.
     *
     * @param string $str The string to validate.
     *
     * @return bool
     */
    function given_mo_check($str)
    {
        $t = mktime(
            $this->input->post('given_hour'),
            $this->input->post('given_min'),
            0,
            $this->input->post('given_mo'),
            $this->input->post('given_day'),
            $this->input->post('given_yr')
        );

        //get the duration of the selected event
        $det      = $this->event_model
            ->getEventDetail($this->validation->event_id);
        $thisTalk = $det[0];

        $day_start = mktime(
            0,
            0,
            0,
            date('m', $thisTalk->event_start),
            date('d', $thisTalk->event_start),
            date('Y', $thisTalk->event_start)
        );
        $day_end   = mktime(
            23,
            59,
            59,
            date('m', $thisTalk->event_end),
            date('d', $thisTalk->event_end),
            date('Y', $thisTalk->event_end)
        );

        if (($t >= $day_start) && ($t <= $day_end)) {
            return true;
        } else {
            $this->validation->set_message(
                'given_mo_check', 'Talk date must be during the event!'
            );

            return false;
        }
    }

    /**
     * Slide link is not required but if one is provided we need to make sure it has
     * a valid url including the scheme (http|https|etc).
     *
     * @param string $str The slides url to validate.
     *
     * @return bool
     */
    public function slides_link_check($str)
    {
        // having a value is not required so we just return true if they didn't
        // give a slide link
        if (!empty($str)) {
            $parts = parse_url($str);

            //make sure that the link provided has a scheme in it.
            if (!array_key_exists('scheme', $parts)) {
                $this->validation->set_message(
                    'slides_link_check',
                    'Your slide link url must be a full url (http://foo.bar).'
                );

                return false;
            }
        }

        return true;
    }


    /**
     * Validates whether the captcha is correct.
     *
     * @param string $str The captcha input string
     *
     * @return bool
     */
    function cinput_check($str)
    {
        $str = $this->input->post('cinput');
        if (! is_numeric($str)) {
            // If the user input is not numeric, convert it to a numeric value
            $this->load->plugin('captcha');
            $digits = captcha_get_digits(true);
            $str    = array_search(strtolower($str), $digits);
        }

        if ($str != $this->session->userdata('cinput')) {
            $this->validation->_error_messages['cinput_check']
                = 'Incorrect captcha.';
            return false;
        }

        return true;
    }

    /**
     * Validates whether the given rating is between 0 and 5
     *
     * @param string $str The string to validate.
     *
     * @return bool
     */
    function rating_check($str)
    {
        if (is_numeric($str)) {
            if ($str >= 0 && $str <= 5) {
                return true;
            }
        }
        
        $this->validation->set_message(
            'rating_check',
            'Please choose a rating.'
        );

        return false;
    }

    /**
     * Validates whether the given comment is identical to one that this user
     * has given before for this talk
     *
     * @param string $str    The string to validate.
     * @param number $talkId The current talk id
     *
     * @return bool
     */
    function duplicate_comment_check($str, $params)
    {
        $newComment = trim($str);
        list($talkId, $currentCommentId) = explode('!', $params);
        
        if ($this->user_model->isAuth()) {
            // Find out if there is at least 1 comment that is made by our
            // user for this talk
            $userId = $this->user_model->getId();
            foreach ($this->talks_model->getUserComments($userId) as $comment) {
                if ($comment->talk_id == $talkId) {
                    $thisCommentId = $comment->ID;
                    $thisComment = trim($comment->comment);
                    if ($thisComment == $newComment && $thisCommentId != $currentCommentId) {
                        $this->validation->set_message(
                            'duplicate_comment_check',
                            'Duplicate comment.'
                        );
                        return false;
                    }
                }
            }
        }
        return true;
    }
}

