
module moon()
{
  difference()
  {
  rotate([0,0,moon_angle])
  difference()
  {
     cylinder(d=moon_d1,h=moon_thick,$fn=96,center=true);
     translate([moon_crescent,0,0])
       cylinder(d=moon_d2,h=moon_thick+0.01,$fn=96,center=true); 
  }
    // hole for thread
    translate([0,-moon_d1/2+levitation_h,0])
      rotate([90,0,90])
      cylinder(d=screw_plastic_tight,h=moon_d1*2,$fn=16,center=true);
  
    // hole for thread
    translate([0,-moon_d1/2+levitation_h,0])
      rotate([90,0,90])
      cylinder(d=2,h=moon_d1*2,$fn=16,center=true);

    // hole for threaded rod
    translate([0,-moon_d1/2+magnet_height,0])
      rotate([90,0,90])
      rotate([0,0,90])
      cylinder(d=screw+clr_screw_hole,h=moon_d1*2,$fn=6,center=true);


  }
}

module magnet()
{
  color([0.5,0.5,1]) // blue, north
  translate([0,0,magnet_h/4])
    cylinder(d=magnet_d,h=magnet_h/2,$fn=cylinder_faces,center=true);
  color([1,0.5,0.5]) // red, south
  translate([0,0,-magnet_h/4])
    cylinder(d=magnet_d,h=magnet_h/2,$fn=cylinder_faces,center=true);
}

module stopper()
{
  inner_d=magnet_d+clr_magnet_d;
  
  difference()
  {
    cylinder(d=inner_d+0.01,h=stop_h,$fn=cylinder_faces,center=true);
    translate([0,0,-stop_h/4])
      cylinder(d2=stop_d,d1=inner_d,h=stop_h/2+0.01,$fn=cylinder_faces,center=true);
    translate([0,0,stop_h/4])
      cylinder(d1=stop_d,d2=inner_d,h=stop_h/2+0.01,$fn=cylinder_faces,center=true);

  }
}

module rocket_tube(holes=0,stoppers=1)
{
  inner_d=magnet_d+clr_magnet_d;
  outer_d=inner_d+tube_wall;
  steps=floor(tube_len/screw_step/2)*2;
  union()
  {
  difference()
  {
    cylinder(d=outer_d,h=tube_len,$fn=cylinder_faces,center=true);
    // tube = inside empty
    cylinder(d=inner_d,h=tube_len+0.01,$fn=cylinder_faces,center=true);
    // adjustment holes
    if(holes>0.5)
    for(i=[-2*steps:2*steps])
      translate([0,0,i*screw_step])
        rotate([90,0,0])
          rotate([0,0,90])
          cylinder(d=screw+clr_screw_hole,h=outer_d*2,$fn=6,center=true);
  }
    if(stoppers>0.5)
    {
      stop_z=tube_len/2-clr_magnet_h-inlet_h-magnet_h;
      translate([0,0,stop_z])
        stopper();
      translate([0,0,-stop_z])
        stopper();
    }
  }
}

module magnet_holder(upper=1,lower=1,magnet=0)
{
  // number of magnet placeholders
  steps=floor(holder_width/magnet_step/2)*2-4;
  difference()
  {
    cube([holder_width,holder_depth,holder_height],center=true);
    // cut slit between
    translate([0,0,-holder_height/2+magnet_height])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_clearance],
      center=true);
    // no upper side
    if(upper<0.5)
      translate([0,0,-holder_height/2+magnet_height+holder_height/2])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_height],
      center=true);
    // no lower side
    if(lower<0.5)
      translate([0,0,-holder_height/2+magnet_height-holder_height/2])
      cube([
            holder_width+0.01,
            holder_depth+0.01,
            holder_height],
      center=true);
    // magnet adjustment holes
    for(i=[-steps/2:steps/2])
        if(i < -1.5 || i > 1.5)
    translate([i*magnet_step,0,-holder_height/2+magnet_height])
        rotate([90,0,0])
          cylinder(d=magnet_d+clr_magnet_d,h=magnet_h+clr_magnet_h,$fn=32,center=true);
    // rod hole
    // hole for threaded rod
    translate([0,0,-holder_height/2+magnet_height])
    rotate([90,0,0])
      rotate([0,0,90])
      cylinder(d=screw+clr_screw_hole,h=holder_depth+0.01,$fn=6,center=true);
    // screw holes left and right
        screw_x=(holder_width/2-screw_plastic_head*0.7);
    for(i=[-1:2:1])
    {
    // screw plastic thread hole thru all
    translate([i*screw_x,0,0])
        cylinder(d=screw_plastic_tight,h=holder_height+0.1,center=true);
    // screw head
    translate([i*screw_x,0,-holder_height/1+magnet_height-screw_plastic_under])
        cylinder(d=screw_plastic_head,h=holder_height+0.1,$fn=16,center=true);
    // screw pass thru hole
    translate([i*screw_x,0,-holder_height/2+magnet_height-screw_plastic_under/2])
        cylinder(d=screw_plastic_loose,h=screw_plastic_under+0.1,$fn=16,center=true);
    // conical transition
    translate([i*screw_x,0,-holder_height/2+magnet_height-screw_plastic_under+screw_plastic_transition/2])
        cylinder(d1=screw_plastic_head,d2=screw_plastic_loose,h=screw_plastic_transition+0.1,$fn=16,center=true);
    }
  }

  {
    // magnets placed in adjustment hole
    if(magnet > 0)
    for(i=[-1:2:1])
    translate([i*magnet_step*(steps/2-magnet+1),0,-holder_height/2+magnet_height])
        rotate([90,0,0])
          magnet();
          // cylinder(d=magnet_d+
        //clr_magnet_d,h=magnet_h+clr_magnet_h,$fn=32,center=true);

  }

}

module head()
{
  inner_d=magnet_d+clr_magnet_d;
  outer_d=inner_d+tube_wall;


  translate([0,0,head_len/2])
  union()
  {
  difference()
  {
    union()
    {
    cylinder(d1=outer_d,d2=head_tip,h=head_len,  $fn=cylinder_faces,center=true);
        // sphere at the tip
        translate([0,0,head_len/2])
        sphere(d=head_tip,$fn=cylinder_faces);
    }
    // cut out inside
      //head_angle=asin(outer_d/2/head_len);
      //movez=tube_wall/tan(head_angle);
    translate([0,0,-tiph/2])
      cylinder(d1=inner_d-head_inlet_clr-tube_wall,d2=0,h=head_len-tiph+0.01,$fn=cylinder_faces,center=true);
  }
    // inlet, magnet diameter
      translate([0,0,-head_len/2-inlet_h/2])
      difference()
      {
        union()
        {
        cylinder(d=inner_d-head_inlet_clr,h=inlet_h,$fn=cylinder_faces,center=true);
          translate([0,0,inlet_h/2-head_transition/2])
            cylinder(d2=outer_d,d1=inner_d-head_inlet_clr,h=head_transition,$fn=cylinder_faces,center=true);

        }
        // cut inside
        cylinder(d=inner_d-head_inlet_clr-tube_wall,h=inlet_h+0.01,$fn=cylinder_faces,center=true);
      }
  }  
}

module tail()
{
  inner_d=magnet_d+clr_magnet_d;
  outer_d=inner_d+tube_wall;
    
  // calculate enclosing cone
  // for the wings
  h1=wing_h1; // outer h
  h2=wing_h2; // inner h
  r1=outer_d/2+wing_width; // outer r 
  r2=outer_d/2; // inner r
  // determine eclosing cone r, h
  r=(h1*r2-h2*r1)/(h1-h2);
  h=r*h1/(r-r1);
  echo(r,h);

  // inside part
    // inlet, magnet diameter
      translate([0,0,inlet_h/2-tail_transition*0.5])
      difference()
      {
        union()
        {
        cylinder(d=inner_d-inlet_clr,h=inlet_h+tail_transition,$fn=cylinder_faces,center=true);
          if(0)
          translate([0,0,-inlet_h/2-tail_transition/2])
            cylinder(d1=outer_d,d2=inner_d-inlet_clr,h=tail_transition,$fn=cylinder_faces,center=true);
        }
        // cut inside
        cylinder(d=inner_d-inlet_clr-tube_wall,h=inlet_h+tail_transition+0.01,$fn=cylinder_faces,center=true);
        // cut transition
          translate([0,0,-inlet_h/2-tail_transition*0])
            cylinder(d2=inner_d-inlet_clr-tube_wall,d1=inner_d-inlet_clr,h=tail_transition,$fn=cylinder_faces,center=true);
      }

  // outside part with wings
  translate([0,0,-wing_h2/2])
  difference()
  {
    union()
    {
      // main cylinder
      // rotate for 4-wing to match on flat side
      rotate([0,0,180/cylinder_faces])
      cylinder(d=outer_d,h=wing_h2,$fn=cylinder_faces,center=true);
    // wings (stabilizers)
    angle=360/wings;
    intersection()
    {
    for(i=[0:wings-1])
    {
      rotate([0,0,angle*i])
        translate([outer_d/2-wing_thick/2+wing_width/2,0,0])
        cube([wing_width+wing_thick,wing_thick,  wing_h2],center=true);
    }
      // enclosing cone
      translate([0,0,h/2-wing_h2/2])
          cylinder(r1=r,r2=0,h=h,$fn=wings < 3 ? 4 : wings,center=true);
    }
  }
    // central hole 
    cylinder(d=outer_d-tube_wall-inlet_clr,h=wing_h2+0.01,$fn=cylinder_faces,center=true);
  }
  // anchorage bar
  translate([0,0,-wing_h2+holder_bar_h/2])
    union()
    {
        for(i=[0:1])
        rotate([0,0,90*i])
    cube([outer_d-tube_wall/2,wing_thick,holder_bar_h],center=true);
    }
}

module full_assembly()
{
  rotate([90,0,0])
  union()
  {
    rocket_tube();
    // magnet head
    translate([0,0,tube_len/2-magnet_h/2-inlet_h-clr_magnet_h/2])
      magnet();
    // magnet tail
    translate([0,0,-tube_len/2+magnet_h/2+inlet_h+clr_magnet_h/2])
      magnet();
    // tail
    translate([0,0,-tube_len/2])
      tail();
    // head
    translate([0,0,tube_len/2])
      head();

    translate([0,holder_height/2-levitation_h,tube_len/2-inlet_h-magnet_h])
      rotate([-90,0,0])
      magnet_holder(upper=0,lower=1,magnet=1);

    translate([0,holder_height/2-levitation_h,-tube_len/2+inlet_h+magnet_h/2])
      rotate([-90,0,0])
      magnet_holder(upper=0,lower=1,magnet=2);
    
    translate([0,moon_d1/2-levitation_h,-90])
    rotate([0,-90,0])
    moon();
  }
}

