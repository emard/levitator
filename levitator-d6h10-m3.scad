include <levitator.scad>

// layer height: 0.2 mm

magnet_h=10;
magnet_d=6;

screw=3; // M3 screw
use_screws=0; // in plastic holders
screw_plastic=2.2; // plastic hole dia
screw_plastic_tight=screw_plastic*0.82; // tight
// echo(screw_plastic_tight);
screw_plastic_loose=screw_plastic*1.1;
screw_plastic_head=screw_plastic*2.2;
screw_plastic_transition=1.5; // cone for easier printing
screw_plastic_under=3; // not counting transition

clr_magnet_d=0.5; // diameter clearance
clr_magnet_h=0.4; // length clearance
clr_screw_hole=0.3; // hole bit bigger
clr_screw_step=1; // screw spacing clearance

tube_wall=1.5; // wall thickness
tube_len=60; // tube length


screw_step=magnet_h+screw+clr_screw_step;

// screw_step=2*screw;

cylinder_faces=32;

holder_depth=15;
// holder_width=60; // obsolete, calculated from magnet_last and screw size
holder_height=8;
holder_thinner=0.5; // factor to make holder bars thinner
magnet_first=[16,12]; // head,tail
magnet_last=magnet_first;
magnet_n=[1,1]; // head,tail
magnet_height=holder_height/2; // in the middle of the holder
holder_clearance=use_screws > 0.5 ? 0.3 : 0;

// head
head_len=12;
inlet_h=4;
head_inlet_clr=-0.08; // head inlet clearance (positve=loose, negative=tight)
head_transition=0.5; // easier printing
tiph=-2; // from tip to cutoff inside cone
head_tip=3; // tip diameter

// tail
tail_inlet_clr=-0.08; // tail inlet clearance (positive=loose, negative=tight)
wings=4;
wing_h1=5; // straignt height of the wing
wing_h2=16; // total wing height
wing_width=7;
wing_thick=tube_wall/2; // thickness
tail_transition=2;
holder_bar_h=4;

// stopper
stop_d=magnet_d-2*clr_magnet_d; // small d
stop_h=1.5;

levitation_h=27;

// moon artwork
moon_d1=2*levitation_h;
moon_d2=moon_d1;
moon_crescent=5; // width of crescent moon
moon_thick=7; // extrusion thickness
moon_angle=12;

if(0)
  head();
if(0)
  rocket_tube();
if(0)
  tail();
if(1)
  printable_holders();
if(0)
  moon();

// cross section
if(0)
    // translate([0,0,55])
difference()
{
    // magnet_holder();
    // head();
    // tail();
    full_assembly();
    if(1)
    translate([magnet_d,0,0])
    cube([magnet_d*2,tube_len,magnet_d*2],center=true);
}

