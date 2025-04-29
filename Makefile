tmux_conf:
	mkdir -p ~/scripts
	touch ~/scripts/tmux_git_status.sh
	cp tmux/scripts/tmux_git_status.sh ~/scripts/
	cp tmux/.tmux.conf ~/
	sudo chmod +x ~/scripts/tmux_git_status.sh

.PHONY: tmux_conf
