;; Campaign Coordination Contract
;; Manages influencer marketing campaigns

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u300))
(define-constant err-campaign-not-found (err u301))
(define-constant err-campaign-ended (err u302))
(define-constant err-not-authorized (err u303))
(define-constant err-invalid-budget (err u304))

;; Data variables
(define-data-var next-campaign-id uint u1)

;; Data maps
(define-map campaigns uint {
  department: principal,
  title: (string-ascii 100),
  description: (string-ascii 500),
  budget: uint,
  start-block: uint,
  end-block: uint,
  status: (string-ascii 20)
})

(define-map campaign-influencers { campaign-id: uint, influencer: principal } {
  agreed-payment: uint,
  status: (string-ascii 20)
})

;; Read-only functions
(define-read-only (get-campaign (campaign-id uint))
  (map-get? campaigns campaign-id)
)

(define-read-only (get-campaign-influencer (campaign-id uint) (influencer principal))
  (map-get? campaign-influencers { campaign-id: campaign-id, influencer: influencer })
)

(define-read-only (get-next-campaign-id)
  (var-get next-campaign-id)
)

;; Public functions
(define-public (create-campaign
  (department principal)
  (title (string-ascii 100))
  (description (string-ascii 500))
  (budget uint)
  (duration-blocks uint))
  (let ((campaign-id (var-get next-campaign-id)))
    (asserts! (> budget u0) err-invalid-budget)
    (map-set campaigns campaign-id {
      department: department,
      title: title,
      description: description,
      budget: budget,
      start-block: block-height,
      end-block: (+ block-height duration-blocks),
      status: "active"
    })
    (var-set next-campaign-id (+ campaign-id u1))
    (ok campaign-id)
  )
)

(define-public (join-campaign (campaign-id uint) (agreed-payment uint))
  (match (map-get? campaigns campaign-id)
    campaign (begin
      (asserts! (< block-height (get end-block campaign)) err-campaign-ended)
      (map-set campaign-influencers
        { campaign-id: campaign-id, influencer: tx-sender }
        { agreed-payment: agreed-payment, status: "joined" }
      )
      (ok true)
    )
    err-campaign-not-found
  )
)

(define-public (end-campaign (campaign-id uint))
  (match (map-get? campaigns campaign-id)
    campaign (begin
      (asserts! (is-eq tx-sender (get department campaign)) err-not-authorized)
      (map-set campaigns campaign-id (merge campaign { status: "ended" }))
      (ok true)
    )
    err-campaign-not-found
  )
)
