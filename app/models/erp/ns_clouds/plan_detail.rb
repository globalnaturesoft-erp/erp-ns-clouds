module Erp::NsClouds
  class PlanDetail < ApplicationRecord
    belongs_to :plan, optional: true
  end
end
