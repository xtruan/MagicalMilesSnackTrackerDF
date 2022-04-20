import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
//import Toybox.System;

class MagicalMilesSnackTrackerView extends WatchUi.DataField {
	
	hidden var ICE_CREAM_BAR_CALS = 330.0f;
	hidden var CHURRO_CALS = 240.0f;
	hidden var SOFT_PRETZEL_CALS = 500.0f;
	hidden var DOLE_WHIP_CALS = 110.0f;
	hidden var TURKEY_LEG_CALS = 1000.0f;
	
	hidden var mCalories = 0.0f;
	hidden var mDisplayItem = 0;
	hidden var mMotivationItem = 0;

    hidden var mIceCreamBarField;
    hidden var mChurroField;
    hidden var mSoftPretzelField;
    hidden var mDoleWhipField;
    hidden var mTurkeyLegField;
    
    hidden var ICE_CREAM_BAR_FIELD = 0;
	hidden var CHURRO_FIELD = 1;
	hidden var SOFT_PRETZEL_FIELD = 2;
	hidden var DOLE_WHIP_FIELD = 3;
	hidden var TURKEY_LEG_FIELD = 4;

    function initialize() {
        DataField.initialize();
        
        mIceCreamBarField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_one),
            ICE_CREAM_BAR_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_one_unit)}
        );
        mIceCreamBarField.setData(0.0);
        
        mChurroField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_two),
            CHURRO_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_two_unit)}
        );
        mChurroField.setData(0.0);
        
        mSoftPretzelField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_thr),
            SOFT_PRETZEL_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_thr_unit)}
        );
        mSoftPretzelField.setData(0.0);
        
        mDoleWhipField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_fou),
            DOLE_WHIP_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_fou_unit)}
        );
        mDoleWhipField.setData(0.0);
        
        mTurkeyLegField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_fiv),
            TURKEY_LEG_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_fiv_unit)}
        );
        mTurkeyLegField.setData(0.0);
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc as Dc) as Void {
        var obscurityFlags = DataField.getObscurityFlags();

        // Top left quadrant so we'll use the top left layout
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

        // Top right quadrant so we'll use the top right layout
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

        // Bottom left quadrant so we'll use the bottom left layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

        // Bottom right quadrant so we'll use the bottom right layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            var valueView = View.findDrawableById("value");
            
            var height = dc.getHeight();
            if (height < 200) {
            	labelView.locY = labelView.locY - (height / 5);
            	valueView.locY = valueView.locY + (height / 5);
            } else {
            	labelView.locY = labelView.locY - (height / 8);
            	valueView.locY = valueView.locY + (height / 8);
            }
            
            //System.println(height);
        }

        (View.findDrawableById("label") as Text).setText(Rez.Strings.label);
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void {
        // See Activity.Info in the documentation for available information.
        // Get calories if available.
        if (info has :calories) {
            if (info.calories != null) {
                mCalories = info.calories;
            }
        }
        
        // Set data field with calories and multiplier.
        mIceCreamBarField.setData(mCalories / ICE_CREAM_BAR_CALS);
        mChurroField.setData(mCalories / CHURRO_CALS);
        mSoftPretzelField.setData(mCalories / SOFT_PRETZEL_CALS);
        mDoleWhipField.setData(mCalories / DOLE_WHIP_CALS);
        mTurkeyLegField.setData(mCalories / TURKEY_LEG_CALS);
    }
    
    function getDisplayText() as String {
    	mDisplayItem++;
		if (mDisplayItem > 5*6) {
			mDisplayItem = 1;
		}
        
        if (mDisplayItem <= 1*5) {
        	return (mCalories / ICE_CREAM_BAR_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_one_unit_sm);
        } else if (mDisplayItem <= 2*5) {
        	return (mCalories / CHURRO_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_two_unit_sm);
        } else if (mDisplayItem <= 3*5) {
        	return (mCalories / SOFT_PRETZEL_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_thr_unit_sm);
        } else if (mDisplayItem <= 4*5) {
        	return (mCalories / DOLE_WHIP_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_fou_unit_sm);
        } else if (mDisplayItem <= 5*5) {
			return (mCalories / TURKEY_LEG_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_fiv_unit_sm);
		} else {
			return getMotivationText();
		}
    }
    
    function getMotivationText() as String {
    	mMotivationItem++;
		if (mMotivationItem > 5*5) {
			mMotivationItem = 1;
		}
		
		if (mMotivationItem <= 1*5) {
        	return WatchUi.loadResource(Rez.Strings.motivation_one);
        } else if (mMotivationItem <= 2*5) {
        	return WatchUi.loadResource(Rez.Strings.motivation_two);
        } else if (mMotivationItem <= 3*5) {
        	return WatchUi.loadResource(Rez.Strings.motivation_thr);
        } else if (mMotivationItem <= 4*5) {
        	return WatchUi.loadResource(Rez.Strings.motivation_fou);
        } else if (mMotivationItem <= 5*5) {
			return WatchUi.loadResource(Rez.Strings.motivation_fiv);
		} else {
			return "";
		}
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void {
    
    	var bg = (View.findDrawableById("Background") as Text);
        var label = View.findDrawableById("label") as Text;
        var value = View.findDrawableById("value") as Text;
        var text = getDisplayText();
        
        if (dc.getHeight() < 200) {
	        if (text.length() < 9) {
	        	value.setFont(Graphics.FONT_MEDIUM);
	        } else if (text.length() < 11) {
	        	value.setFont(Graphics.FONT_SMALL);
	        } else if (text.length() < 13) {
	        	value.setFont(Graphics.FONT_TINY);
	        } else {
	        	value.setFont(Graphics.FONT_TINY);
	        }
        } else {
        	label.setFont(Graphics.FONT_LARGE);
        	if (text.length() < 12) {
	        	value.setFont(Graphics.FONT_LARGE);
	        } else if (text.length() < 14) {
	        	value.setFont(Graphics.FONT_MEDIUM);
	        } else if (text.length() < 16) {
	        	value.setFont(Graphics.FONT_SMALL);
	        } else {
	        	value.setFont(Graphics.FONT_SMALL);
	        }
        }
        value.setText(text);
        
        if (text.equals(WatchUi.loadResource(Rez.Strings.motivation_one))) {
        	bg.setColor(Graphics.COLOR_RED);
        	label.setColor(Graphics.COLOR_BLACK);
        	label.setText(Rez.Strings.motivation_one_label);
            value.setColor(Graphics.COLOR_BLACK);
        } else if (text.equals(WatchUi.loadResource(Rez.Strings.motivation_two))) {
        	bg.setColor(Graphics.COLOR_GREEN);
        	label.setColor(Graphics.COLOR_BLACK);
        	label.setText(Rez.Strings.motivation_two_label);
            value.setColor(Graphics.COLOR_BLACK);
        } else if (text.equals(WatchUi.loadResource(Rez.Strings.motivation_thr))) {
        	bg.setColor(Graphics.COLOR_YELLOW);
        	label.setColor(Graphics.COLOR_BLACK);
        	label.setText(Rez.Strings.motivation_thr_label);
            value.setColor(Graphics.COLOR_BLACK);
        } else if (text.equals(WatchUi.loadResource(Rez.Strings.motivation_fou))) {
        	bg.setColor(Graphics.COLOR_PURPLE);
        	label.setColor(Graphics.COLOR_BLACK);
        	label.setText(Rez.Strings.motivation_fou_label);
            value.setColor(Graphics.COLOR_BLACK);
        } else if (text.equals(WatchUi.loadResource(Rez.Strings.motivation_fiv))) {
        	bg.setColor(Graphics.COLOR_BLUE);
            label.setColor(Graphics.COLOR_BLACK);
            label.setText(Rez.Strings.motivation_fiv_label);
            value.setColor(Graphics.COLOR_BLACK);
        } else if (getBackgroundColor() == Graphics.COLOR_BLACK) {
        	bg.setColor(Graphics.COLOR_DK_BLUE);
            label.setColor(Graphics.COLOR_LT_GRAY);
            label.setText(Rez.Strings.label);
            value.setColor(Graphics.COLOR_WHITE);
        } else {
        	bg.setColor(Graphics.COLOR_BLUE);
            label.setColor(Graphics.COLOR_DK_GRAY);
            label.setText(Rez.Strings.label);
            value.setColor(Graphics.COLOR_BLACK);
        }

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
