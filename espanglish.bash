#!/bin/bash
#▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
# Create a new English(US) keyboard layout compatible with Spanish(ES) symbols
#▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
>/usr/share/X11/xkb/symbols/espanglish cat << EOF

default  partial alphanumeric_keys modifier_keys
xkb_symbols "basic" {

    name[Group1]= "English (US, Espanglish)";

    include "us(basic)"

    key <TLDE> { [ dead_acute, dead_tilde, grave ] };
    
    key <AD03> {[   e, E, EuroSign      ]};
    key <AD04> {[   r, R, registered    ]};
    key <AD05> {[   t, T, trademark     ]};
    key <AD09> {[   o, O, masculine     ]};

    key <AC01> {[   a, A, ordfeminine   ]};

    key <AC10> {[   semicolon, colon, dead_diaeresis	]};
    key <AC11> {[   apostrophe, quotedbl, grave    	  ]};

    key <AB10> {[   slash, question, questiondown	]};

    include "level3(ralt_switch)"

};

EOF

newLayout='</layout>\
    <layout>\
     <configItem>\
       <name>espanglish</name>\
       <shortDescription>espanglish</shortDescription>\
       <description>English (US, Espanglish)</description>\
       <languageList>\
          <iso639Id>eng</iso639Id>\
       </languageList>\
     </configItem>\
     <variantList/>\
    </layout>'

# Add new layout to the system
sudo sed -e "0,/<\/layout>/ s#</layout>#$newLayout#" -i /usr/share/X11/xkb/rules/evdev.xml

# Test it
setxkbmap espanglish -option grp:alt_shift_toggle -print #| xkbcomp - $DISPLAY

# Reload
sudo dpkg-reconfigure xkb-data
