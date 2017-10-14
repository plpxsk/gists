TMUX basic commands
===============================================================================
> Scroll down for more

	tmux ls                     # list sessions

	tmux new -s mysession       # create new

	tmux attach -t mysession    # or, attach recent:  tmux a
	
	tmux detach                 # or Ctrl-b d

	tmux kill-session -t session-name


`tmux` manages your terminal windows to help you organize your projects.

Install with `brew install tmux`

From https://danielmiessler.com/study/tmux/ :

**Sessions** are for an overall theme, such as work, or experimentation, or
sysadmin.

**Windows** are for projects within that theme. So perhaps within your
experimentation session you have a window titled noderestapi, and one titled
lua sample.

**Panes** are for views within your current project. So within your sysadmin
session, which has a logs window, you may have a few panes for access logs,
error logs, and system logs.



Tmux shortcuts 1 of 2 (basics)
===============================================================================
*Commands in the same group are equivalent. ctrl commands work inside tmux
session; tmux commands run from terminal*

	tmux ls
	ctrl + b, s

	tmux attach -t mysession 
	tmux a -t mysession
	tmux a	                # attach most recently used session
	
	tmux detach 
	ctrl + b, d

	tmux kill-session -t session-name

SCROLL mode:

	ctrl + b, [		# now, you can use PgUp/PgDown. q to exit	


Tmux shortcuts 2 of 2 (more)
==============================================================================
*All of the following start with prefix (Ctrl + b):*

Basics

	c  create new window
	w  list current windows

	?  get help

Session management
	
	s list sessions
	$ rename the current session
	d detach from the current session

Windows 
	
	. MOVE window position

	c create a new window
	, rename the current window
	x kill the current window
	w list windows

	% split horizontally
	" split vertically

	n change to the next window
	p change to the previous window
	0 to 9 select windows 0 through 9

Panes
	
	% create a horizontal pane
	" create a vertical pane
	h move to the left pane
	j move to the pane below
	l move to the right pane
	k move to the pane above
	k move to the pane above
	q show pane numbers
	o toggle between panes
	} swap with next pane
	{ swap with previous pane
	! break the pane out of the window
	x kill the current pane


References
===============================================================================

My `.tmux.conf` config file is in [my dotfiles repo](https://github.com/pavopax/dotfiles).

If you run on local and restart your machine, then `tmux` is gone. The solution
is: https://github.com/tmux-plugins/tmux-resurrect

Its key bindings:

	prefix + Ctrl-s - save
	prefix + Ctrl-r - restore


https://robots.thoughtbot.com/a-tmux-crash-course

https://danielmiessler.com/study/tmux/
