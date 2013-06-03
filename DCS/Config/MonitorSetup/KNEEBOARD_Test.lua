_  = function(p) return p; end;
name = _('KNEEBOARD Test');
Description = 'KNEEBOARD Test'
Viewports =
{
     Center =
     {
          x = 0;
          y = 0;
          width = screen.width;
          height = screen.height;
          viewDx = 0;
          viewDy = 0;
          aspect = screen.aspect;
     }
}

KNEEBOARD =
-- right aspect is 2:3  -  example: width = 200; height = 300;
     {
          x = 100;
          y = 100;
          width = 300;
          height = 450;
     }
	 
UIMainView = Viewports.Center	 