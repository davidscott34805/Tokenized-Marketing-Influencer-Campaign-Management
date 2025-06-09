;; Influencer Verification Contract
;; Manages verification of social media influencers

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u200))
(define-constant err-already-verified (err u201))
(define-constant err-not-verified (err u202))
(define-constant err-invalid-followers (err u203))

;; Data maps
(define-map verified-influencers principal bool)
(define-map influencer-profiles principal {
  handle: (string-ascii 50),
  platform: (string-ascii 20),
  followers: uint,
  category: (string-ascii 30),
  verified-at: uint
})

;; Read-only functions
(define-read-only (is-influencer-verified (influencer principal))
  (default-to false (map-get? verified-influencers influencer))
)

(define-read-only (get-influencer-profile (influencer principal))
  (map-get? influencer-profiles influencer)
)

;; Public functions
(define-public (verify-influencer
  (influencer principal)
  (handle (string-ascii 50))
  (platform (string-ascii 20))
  (followers uint)
  (category (string-ascii 30)))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (not (is-influencer-verified influencer)) err-already-verified)
    (asserts! (> followers u0) err-invalid-followers)
    (map-set verified-influencers influencer true)
    (map-set influencer-profiles influencer {
      handle: handle,
      platform: platform,
      followers: followers,
      category: category,
      verified-at: block-height
    })
    (ok true)
  )
)

(define-public (update-follower-count (influencer principal) (new-followers uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-influencer-verified influencer) err-not-verified)
    (asserts! (> new-followers u0) err-invalid-followers)
    (match (map-get? influencer-profiles influencer)
      profile (begin
        (map-set influencer-profiles influencer (merge profile { followers: new-followers }))
        (ok true)
      )
      err-not-verified
    )
  )
)
