##############################################################################
# @attr [Fixnum(11)] id             
# @attr [Fixnum(11)] from_id        
# @attr [Fixnum(11)] to_id          
# @attr [Fixnum(4)] status         
# @attr [Date] approved_date  
# @attr [Date] rejected_date  
# @attr [Date] asked_date     
# @attr [Date] withdraw_date  
# @attr [Time] created_at     
# @attr [Time] updated_at     
##############################################################################
class Request < ActiveRecord::Base
  
  # Enumeration for status
  ASKED = 0
  ACCEPTED = 1
  DECLINED = 2
  WITHDRAWN = 3
  
  # Finds the relevant request object and sets status to accepted
  # @param [Fixnum] to_id
  #     The id of the user to which the request was sent, and who approved it
  # @param [Fixnum] from_id
  #     The id of the user who sent the request.
  def self.set_as_accepted(to_id, from_id)
    req = Request.find_by_from_id_and_to_id(from_id, to_id) rescue nil
    if req
      req.status = ACCEPTED
      req.approved_date = Time.now.to_date
      req.save!
    end
  end
  
  # Finds the relevant request object and sets status to declined
  # @param [Fixnum] to_id
  #     The id of the user to which the request was sent, and who declined it
  # @param [Fixnum] from_id
  #     The id of the user who sent the request.
  def self.set_as_declined(to_id, from_id)
    req = Request.find_by_from_id_and_to_id(from_id, to_id) rescue nil
    if req
      req.status = DECLINED
      req.rejected_date = Time.now.to_date
      req.save!
    end
  end
  
  # Finds the relevant request object and sets status to withdrawn
  # @param [Fixnum] to_id
  #     The id of the user to which the request was sent
  # @param [Fixnum] from_id
  #     The id of the user who sent the request, and who withdrew it
  def self.set_as_withdrawn(to_id, from_id)
    req = Request.find_by_from_id_and_to_id(from_id, to_id) rescue nil
    if req
      req.status = WITHDRAWN
      req.withdraw_date = Time.now.to_date
      req.save!
    end
  end
  
end
