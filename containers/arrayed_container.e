note
	description: "A linear container implemented via an array."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_CONTAINER

create
	make

feature {NONE} -- Implementation of container via an array

	imp : LINKED_LIST[STRING]

feature -- Constructors

	make
			-- Initialize an empty container.
		do
			-- This implementation is correct, just given to you.
			create imp.make
		ensure
			empty_container: count=0
		end


feature -- Commands

	assign_at (i: INTEGER; s: STRING)
			-- Change the value at position 'i' to 's'.
		require
			valid_index: True -- Your task
		do
			imp [i] := s
			-- Uncomment this to produce a wrong implementation
--			if i > 1 then
--				imp [1] := s
--			end
		ensure
			size_unchanged: imp.count = (old imp.twin).count
			item_assigned: imp [i] ~ s
			others_unchanged:
				across
					1 |..| imp.count as j
				all
					j.item /= i implies imp [j.item] ~ (old imp.twin) [j.item]
				end
		end

	insert_at (i: INTEGER; s: STRING)
			-- Insert value 's' into index 'i'.
		require
			valid_index: valid_index(i)
		do
--			imp.go_i_th (i)
--			imp.put_left(s)
--			imp.put_i_th (s, i)
			imp.go_i_th (i-1)
			imp.put_right (s)
		ensure
			size_changed: imp.count=(old imp.twin).count+1
			inserted_at_i: imp[i]~s
			left_half_the_same:
			across
				1 |..| (i-1) as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			end
			right_half_the_same: True -- Your task
		end

	delete_at (i: INTEGER)
			-- Delete element stored at index 'i'.
		require
			valid_index: True -- Your task
		do
			-- Your task
		ensure
			size_changed: True -- Your task
			left_half_the_same: True -- Your task
			right_half_the_same: True -- Your task
		end

	insert_last (s: STRING)
			-- Insert 's' as the last element of the container.
		do
			imp.extend (s)
		ensure
			size_changed:imp.count=(old imp.twin).count+1
			last_inserted: imp[imp.count]~s
			others_unchanged:
			across
				1 |..| (imp.count-1) as j
			all
				imp[j.item]~(old imp.twin)[j.item]
			end
		end

	remove_first
			-- Remove first element from the container.
		require
			not_empty:count>0
		do
			imp.start
			imp.remove
		ensure
			size_changed: imp.count = (old imp.twin).count-1
			others_unchanged: across
				1 |..| imp.count as n
			all
				imp[n.item]~(old imp.twin)[n.item]
			end
		end

feature -- Queries

	count: INTEGER
	do
		result:=imp.count
	end
	-- Your task
	  -- Number of items currently stored in the container.
      -- It is up to you to either implement 'count' as an attribute,
      -- or to implement 'count' as a query (uniform access principle).

	valid_index (i: INTEGER): BOOLEAN
			-- Is 'i' a valid index of current container?
		do
			Result:= i <= imp.count and i >= 1
		ensure
			size_unchanged: imp.count =(old imp.twin).count
			result_correct: Result= (i <= imp.count) and (i >= 1)
			no_elements_changed:
			across
				1 |..| (old imp.twin).count as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			--	imp.forth
			end
		end

	get_at (i: INTEGER): STRING
			-- Return the element stored at index 'i'.
		require
			valid_index: valid_index(i)
		do
			--imp.go_i_th (i)
			result:=imp[i]
		ensure
			size_unchanged: imp.count= (old imp.twin).count
			result_correct: result=imp[i]
			no_elements_changed:
			across
				1 |..| (old imp.twin).count as j
			all
				imp[j.item] ~ (old imp.twin)[j.item]
			--	imp.forth
			end
		end

invariant
	-- Size of container and size of implementation array always match.
	consistency: imp.count = count
end
