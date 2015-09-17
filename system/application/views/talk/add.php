<script type="text/javascript" src="/inc/js/talk.js"></script>
<?php
$event_list	= array(); 
$dur_list	= array("" => "Not specified");
$cat_list	= array();
$lang_list	= array();

$ev=$events[0];
foreach ($cats as $k=>$v) { $cat_list[$v->ID]=$v->cat_title; }
foreach ($langs as $k=>$v) { $lang_list[$v->ID]=$v->lang_name; }

if (!empty($this->validation->error_string)) {
    $this->load->view('msg_info', array('msg' => $this->validation->error_string));
}

if (isset($this->edit_id)) {
    $actionUrl = 'talk/edit/'.$this->edit_id;
    $sub	= 'Save Edits';
    $title	= 'Edit Session: '.escape($detail[0]->talk_title);
    menu_pagetitle('Edit Session: '.$detail[0]->talk_title);
} else { 
    $actionUrl =  'talk/add/event/'.$ev->ID;
    $sub	= 'Add Session';
    $title	= 'Add Session';
    menu_pagetitle('Add Session');
}

$default_duration = 60;
if($this->validation->duration) {
    $default_duration = $this->validation->duration;
} elseif($this->session->userdata('duration')) {
    $default_duration = $this->session->userdata('duration');
}

// now the form begins
echo '<h2>'.$title.'</h2>';

if (isset($msg) && !empty($msg)) { $this->load->view('msg_info', array('msg' => $msg)); }
if (isset($err) && !empty($err)) { $this->load->view('msg_info', array('msg' => $err)); }
$priv=($evt_priv===true) ? ', Private Event' : '';
?>

<?php echo form_open($actionUrl); ?>

<div id="box">
    
    <div class="row">
    <label for="event"></label>
    <?php
    // create formatted dates for start and end using the timezone of the event.
    $event_start = $timezone->formattedEventDatetimeFromUnixtime(
                    $ev->event_start,
                    $ev->event_tz_cont . '/' . $ev->event_tz_place,
                    'd.M.Y');
    $event_end = $timezone->formattedEventDatetimeFromUnixtime(
                    $ev->event_end,
                    $ev->event_tz_cont . '/' . $ev->event_tz_place,
                    'd.M.Y');

    echo form_hidden('event_id', $ev->ID);
    echo '<b><a href="/event/view/'.$ev->ID.'">'.escape($ev->event_name).'</a> ('.$event_start;
    if ($ev->event_start+86399 != $ev->event_end) echo '- '.$event_end;
    echo ')'.$priv.'</b>';
    ?>
    <div class="clear"></div>
    </div>
    <div class="row">
    <label for="talk_title">Session Title</label>
    <?php echo form_input('talk_title', $this->validation->talk_title);?>
    <div class="clear"></div>
    </div>
    <div class="row">
    <label for="speaker">Speaker</label>

    <span style="color:#3567AC;font-size:11px">
        One speaker per row, add more rows for more than one speaker.<br/>
        To <b>remove</b> a speaker, remove their name from the text field and submit.
    </span>
    <?php
    
    // if editing and already have speakers...
    if (isset($this->validation->speaker) && count($this->validation->speaker) != 0) {
        foreach ($this->validation->speaker as $speakerId => $speaker) {
            echo form_input('speaker_row['.$speakerId.']', $speaker->speaker_name);
        }
    } else {
        echo form_input('speaker_row[new_1]','');
    }
    ?>
    <div id="speaker_row_container">
        
    </div>
    <?php 
    $attr=array(
        'name'	=> 'add_speaker_line',
        'id'	=> 'add_speaker_line',
        'value'	=> '+ more',
        'type'	=> 'button'
    );
    echo form_input($attr);
    ?>
    <noscript>
    <!-- no javascript? no problem... -->
    <?php echo form_input('speaker_row[new_1]'); ?>
    </noscript>
    <div class="clear"></div>
    
    </div>
    <div class="row">
    <label for="session_date">Date and Time of Session</label>
    <?php
    $eventStart = $this->timezone->getDatetimeFromUnixtime($thisTalksEvent->event_start, $thisTalksEvent->timezoneString);
    $eventEnd = $this->timezone->getDatetimeFromUnixtime($thisTalksEvent->event_end, $thisTalksEvent->timezoneString);
    $listData = array();
    
    $eventSelected = $eventStart->format('U'); // modify for existing date
    while ($eventStart->format('U') <= $eventEnd->format('U')) {
        $listData[$eventStart->format('Y-m-d')] = $eventStart->format('jS M Y');
        $eventStart->modify('+1 day');
    }
    $talkDate = (!isset($this->validation->talkDate)) ? $eventSelected : $this->validation->talkDate;

    echo form_dropdown('talkDate', $listData, $talkDate), ' at ';
    foreach (range(0,23) as $v) { $given_hour[$v]=str_pad($v,2,'0', STR_PAD_LEFT); }
    foreach (range(0,55, 5) as $v) { $given_min[$v]=str_pad($v,2,'0', STR_PAD_LEFT); }
    echo form_dropdown('given_hour', $given_hour, $this->validation->given_hour);
    echo form_dropdown('given_min', $given_min, $this->validation->given_min);
    ?>
    <div class="clear"></div>
    </div>
    
    <div class="row">
    <label for="duration">Session Length</label>
    <?php
        echo form_input('duration', $default_duration); 
        echo "in minutes";
    ?>
    <div class="clear"></div>
    </div>

    <?php if (!empty($tracks)): ?>
    <div class="row">
    <label for="session_track">Session Track</label>
    <?php
    $tarr=array('none'=>'No track');
    foreach ($tracks as $track) { $tarr[$track->ID]=$track->track_name; }
    echo form_dropdown('session_track', $tarr, $this->validation->session_track); 
    ?>
    <div class="clear"></div>
    </div>
    <?php endif; ?>

    <div class="row">
    <label for="session_desc">Session Description</label>
    <?php
    $arr=array(
        'name'=>'talk_desc',
        'value'=>$this->validation->talk_desc,
        'cols'=>40,
        'rows'=>10
    );
    echo form_textarea($arr);
    ?>
    <div class="clear"></div>
    </div>

    <div class="row">
    <label for="slides_link">Slides Link</label>
    <td><?php echo form_input('slides_link', $this->validation->slides_link); ?></td>
    <div class="clear"></div>
    </div>
    <div class="row">
    <?php echo form_submit('sub', $sub); ?>
    </div>
</div>

<?php form_close(); ?>

<script type="text/javascript">
$('#add_speaker_line').css('display','block');
$(document).ready(function() {
    talk.init();
})
</script>

