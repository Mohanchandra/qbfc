require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module QBFC::Test
  class TxnFind < QBFC::Transaction
    def qb_name
      "Check"
    end
  end
end

describe QBFC::Transaction do

  before(:each) do 
    @sess = mock(QBFC::Session)
    @ole_wrapper = mock(QBFC::OLEWrapper)
    @txn = QBFC::Test::Txn.new(@sess, @ole_wrapper)
  end

  describe ".find" do
    it "should find_by_ref_or_id if the first argument is neither :all nor :first"
    it "should return only first entry if first argument is :first"
    it "should set request#max_returned to 1 if :first"
    it "should return an array if first argument is :all"
    it "should return nil if no elements are found unless finding :all"
    it "should return an empty array if no elements are found when finding :all"
    it "can accept a Request object"
    it "generates a Request object if not given one"
    it "accepts conditions"
    it "passes additional arguments to Request"
    it "should get request#response"
    
    describe ".find(for base_class Lists)" do 
      it "should request only TxnID"
      it "should send class ChildList::find_by_id with TxnID and find options for each"
    end  
  end
  
  describe ".find_by_ref" do
    it "should set up Request, specifying RefNumberList"
    it "should process Request"
  end
  
  describe ".find_by_id" do
    it "should set up Request, specifying TxnIDList"
    it "should process Request"
  end
  
  describe ".find_by_ref_or_id" do
    it "should try to find_by_id"
    it "should try to find_by_ref if id fails"
    it "should return nil if both ref and id return nil"
  end
  
end