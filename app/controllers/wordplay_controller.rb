class WordplayController < ApplicationController

	def index
		if params.has_key?(:textblock)
			@textblock = Textblock.new
			@textblock.content = textblock_params[:content]
		end
	end
	
		private

		def textblock_params
			# params require an OBJECT, and permit a VALUE
			params.require(:textblock).permit(:content)
		end

end


