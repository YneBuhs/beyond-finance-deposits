# frozen_string_literal: true

FactoryBot.define do
    factory :deposit do
      tradeline
      date { Date.today }
      amount { 30.54 }
    end
  end
  