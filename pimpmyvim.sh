#!/bin/bash

vimrc="~/.vimrc"
vim_colors="~/.vim/colors"

# Load output colors for sexiness
green_color="\033[1;32m"
green_color_title="\033[0;32m"
red_color="\033[1;31m"
red_color_title="\033[0;31m"
blue_color="\033[1;34m"
normal_color="\e[1;0m"

function title_page() {
	echo -e"${blue_color}"
	sleep 0.15 && echo -e "  _____ _                   __  __        __      ___"
	sleep 0.15 && echo -e "  |  __ \(_\)               |  \/  |       \ \    / \(_\)"
	sleep 0.15 && echo -e "  | |__) | _ __ ___  _ __   | \  / |_   _   \ \  / / _ _ __ ___"
	sleep 0.15 && echo -e "  |  ___/ | '_ ` _ \| '_ \  | |\/| | | | |   \ \/ / | | '_ ` _ \\"
	sleep 0.15 && echo -e "  | |   | | | | | | | |_) | | |  | | |_| |    \  /  | | | | | | |"
	sleep 0.15 && echo -e "  |_|   |_|_| |_| |_| .__/  |_|  |_|\__, |     \/   |_|_| |_| |_|"
	sleep 0.15 && echo -e "                    | |              __/ |"
	sleep 0.15 && echo -e "                    |_|             |___/${normal_color}"
	print_animated_saucer

function flying_saucer() {
	case ${1} in
			1)
				echo "                                                             "
				echo "                         .   *       _.---._  *              "
				echo "                                   .'       '.       .       "
				echo "                               _.-~===========~-._          *"
				echo "                           *  (___________________)     .    "
				echo "                       .     .      \_______/    *           "
			;;
			2)
				echo "                        *         .  _.---._          .      "
				echo "                              *    .'       '.  .            "
				echo "                               _.-~===========~-._ *         "
				echo "                           .  (___________________)       *  "
				echo "                            *       \_______/        .       "
				echo "                                                             "
			;;
			3)
				echo "                                   *                .        "
				echo "                             *       _.---._              *  "
				echo "                          .        .'       '.       *       "
				echo "                       .       _.-~===========~-._     *     "
				echo "                              (___________________)         ."
				echo "                       *            \_______/ .              "
			;;
			4)
				echo "                        *         .  _.---._          .      "
				echo "                              *    .'       '.  .            "
				echo "                               _.-~===========~-._ *         "
				echo "                           .  (___________________)       *  "
				echo "                            *       \_______/        .       "
				echo "                                                             "
			;;
		esac
	sleep 0.4
}

function print_animated_saucer() {
	echo -e "\033[s"

		for i in $(seq 1 8); do
			if [ "${i}" -le 4 ]; then
				saucer_frame=${i}
			else
				saucer_frame=$((i-4))
			fi
			echo -e "\033[u"
			flying_saucer ${saucer_frame}
	done
}

function release_the_pathogen() {
	echo -e "${red_color_title}Releasing the pathogen..."
    	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
	echo "execute pathogen#infect()" >> $vimrc
	echo -e "${green_color_title}Pathogen injected"
}

function check_vimrc() {
	if [ ! -f $vimrc ]; then
		echo -e "${red_color}Vimrc not found... creating"
		touch ~/.vimrc
		echo -e "${green_color}Done"
	else
		echo -e "${green_color}Vimrc file found, continuing"
	fi
}

function check_vim_colors() {
	if [ ! -f $vim_colors ]; then
		echo -e "${red_color}Vim Colors Directory not found... creating"
		touch ~/.vim/colors
		echo -e "${green_color}Done"	
	else
		echo -e "${green_color}Vim colors folder found, continuing"
	fi		
}

function tab_or_space() {
	echo -e "${green_color_title}Tabs or spaces? (1 = Tabs, 2 = Spaces): "
	read selection
	if [ selection -eq 1]; then
		echo "Tabs it is..."
		echo set autoindent >> $vimrc
		echo set noexpandtab >> $vimrc
		echo tabstop=4 >> $vimrc
		echo shiftwidth=4 >> $vimrc
	else
		echo "Spaces... good man"
		echo set ts=4 >> $vimrc
		echo set expandtab >> $vimrc
		echo set shiftwidth=4 $vimrc
	fi
}

function colorscheme() {
	check_vimrc
	check_vim_colors
	echo -e "${red_color_title}BY THE WAY HOMIE"
	sleep 0.5 && echo "These colors are only a very small sample of what is out there."
    	sleep 0.75 && echo "Use these as a starting point. If you love it, great, if not, check out other ones!"	
	echo -e "${green_color}With that said, select a color scheme"
	echo "-----------------------------------------------------------------------------------------"
	PS3="Select a scheme: "
	schemes=("Gruvbox", "Solarized", "Deus")
	select scheme in schemes
	do
		case $scheme in
			"Deus")	
				echo -e "${green_color_title}Deus Selected... installing"
			    git clone https://github.com/ajmwagar/vim-deus.git ~/.vim/bundle/vim-deus
				echo colorscheme deus >> $vimrc
				echo set background=dark >> $vimrc
				echo -e "${red_color_title}Dark mode set by default, to change this change colorscheme to light (colorscheme=light)"
				;;
			"Solarized")
				echo -e "${green_color_title}Solarized Selected... installing"
				git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/solarized
				echo colorscheme solarized >> $vimrc
				echo set background=dark >> $vimrc
				echo -e "${red_color_title}Dark mode set by default, to change this change colorscheme to light (colorscheme=light)"
				;;
			"Gruvbox")
				echo -e "${green_color_title}Gruvbox selected... installing"
				git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
				echo colorscheme gruvbox >> $vimrc
				echo set background=dark >> $vimrc
				echo -e "${red_color_title}Dark mode set by default, to change this change colorscheme to light (colorscheme=light)"
				;;
		esac
	done
}

function reset() {
	echo "Resetting vimrc"
	cleanup_vimrc
	echo "Running from fresh install"
	fresh_install
}

function fresh_install() {
    	echo "Setting up base configs..."
    	echo set t_Co=256 >> $vimrc
    	echo set encoding=utf-8 >> $vimrc
	tab_or_space
	release_the_pathogen
	colorscheme
	ide_mode
}	

function help_screen() {
	echo -e "${green_color_title}Pimp my vim"
	echo "This is a bash script that pretty much builds your vimrc for you."
	echo "It will give you options and add them to your .vimrc file so you don't have to configure it yourself"
	echo "Re-run this script and let the magic begin"
}

function display_options() {
    PS3="Please select an option: "
    options=("Fresh Install", "Update", "Reset And Rerun", "Quit")
    select value in options
    do
        case $value in
            "Fresh Install")
                fresh_install
                ;;
            "Reset And Rerun")
                reset
                ;;
			"Help")
				help_screen
				;;
			"Quit")
				break
				;;
			*) echo -e "${red_color}Error, invalid option" ;;
        esac
    done
}

function cleanup_vimrc() {
    echo "Wiping existing vim configs"
    echo '' > $vimrc
}

function ide_mode() {
	echo "Would you like to configure VIM with IDE-like features? (y/n): "
	read response

	if [ response = "y" ]; then		
		echo "Grabbing NeoComplete" 
		echo -e "${red_color_title}Warning, a recompile of VIM may be needed for lua support (OSX)"	
		git clone https://github.com/Shougo/neocomplete.vim.git ~/.vim/bundle/neocomplete.vim

		echo "Airline Baby"
		git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline

		echo "Installing NERDTree"
		git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
		
		echo -e "${green_color}IDE Features installed, grabbing configs..."
		load_ide_configs
	elif [ response = "n" ]; then
		echo -e "${green_color}Vim pimper has finished, have a great day. -j"
		break
	else
		echo -e "${red_color}Improper request selected... exiting"
		break
	fi

}

function load_ide_configs() {
	echo "Adding key modifiers"
	echo "map<C-h> <C-w>h" >> $vimrc
	echo "map<C-j> <C-w>j" >> $vimrc
	echo "map<C-k> <C-w>k" >> $vimrc
	echo "map<C-l> <C-w>l" >> $vimrc
}

function welcome() {
	clear
	title_page
	echo "Checking configs..."
	check_vimrc
	check_vim_colors
	display_options
}
