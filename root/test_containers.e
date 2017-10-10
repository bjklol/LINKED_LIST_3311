note
	description: "container application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONTAINERS

inherit
	ES_SUITE

create
	make

feature -- Adding test classes.

	make
			-- Run application.
		do
			add_test (create {LL_TEST}.make)

			show_browser
			run_espec
		end

end
