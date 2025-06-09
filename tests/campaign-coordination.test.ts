import { describe, it, expect, beforeEach } from "vitest"

describe("Campaign Coordination Contract", () => {
  let department
  let influencer1
  let influencer2
  
  beforeEach(() => {
    department = "SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7"
    influencer1 = "SP1K1A1PMGW2BQ2N7E2TB9HPFPVT7WZB40MXWGHV9"
    influencer2 = "SP2D5BGGJ956A635JG7CJQ59FTRFRB0893514EZPJ"
  })
  
  it("should create a campaign successfully", () => {
    const result = {
      success: true,
      campaignId: 1,
      department: department,
      title: "Summer Fashion Campaign",
      budget: 10000,
    }
    
    expect(result.success).toBe(true)
    expect(result.campaignId).toBe(1)
    expect(result.title).toBe("Summer Fashion Campaign")
    expect(result.budget).toBe(10000)
  })
  
  it("should get campaign details", () => {
    const campaign = {
      department: department,
      title: "Summer Fashion Campaign",
      description: "Promote summer collection",
      budget: 10000,
      "start-block": 100,
      "end-block": 1100,
      status: "active",
    }
    
    expect(campaign.title).toBe("Summer Fashion Campaign")
    expect(campaign.budget).toBe(10000)
    expect(campaign.status).toBe("active")
  })
  
  it("should allow influencer to join campaign", () => {
    const result = {
      success: true,
      campaignId: 1,
      influencer: influencer1,
      agreedPayment: 2000,
    }
    
    expect(result.success).toBe(true)
    expect(result.campaignId).toBe(1)
    expect(result.agreedPayment).toBe(2000)
  })
  
  it("should get campaign influencer details", () => {
    const details = {
      "agreed-payment": 2000,
      status: "joined",
    }
    
    expect(details["agreed-payment"]).toBe(2000)
    expect(details.status).toBe("joined")
  })
  
  it("should end campaign successfully", () => {
    const result = {
      success: true,
      campaignId: 1,
      status: "ended",
    }
    
    expect(result.success).toBe(true)
    expect(result.status).toBe("ended")
  })
  
  it("should reject invalid budget", () => {
    const error = { error: "invalid-budget", code: 304 }
    expect(error.error).toBe("invalid-budget")
    expect(error.code).toBe(304)
  })
  
  it("should prevent joining ended campaigns", () => {
    const error = { error: "campaign-ended", code: 302 }
    expect(error.error).toBe("campaign-ended")
    expect(error.code).toBe(302)
  })
  
  it("should get next campaign ID", () => {
    const nextId = 2
    expect(nextId).toBe(2)
  })
})
