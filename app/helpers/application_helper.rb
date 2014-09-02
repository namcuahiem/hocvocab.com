module ApplicationHelper
	def alert_bootstrap3(name)
		case name
		when "alert"
			"alert-danger"
		when "error"
			"alert-danger"
		when "notice"
			"alert-info"
		else
			"alert-#{name}"
		end
	end
end
