class Book < ApplicationRecord
    searchkick word_start: [:name]
end
