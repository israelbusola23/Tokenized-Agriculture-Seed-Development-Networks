;; Licensing Management Contract
;; Manages seed licensing agreements and royalties

(define-constant err-not-authorized (err u500))
(define-constant err-not-found (err u501))
(define-constant err-license-exists (err u502))
(define-constant err-insufficient-payment (err u503))

;; License agreement data structure
(define-map license-agreements
  { license-id: uint }
  {
    variety-id: uint,
    licensor: principal,
    licensee: principal,
    license-type: (string-ascii 50),
    royalty-rate: uint,
    territory: (string-ascii 100),
    start-date: uint,
    end-date: uint,
    status: (string-ascii 20)
  }
)

;; Royalty payments tracking
(define-map royalty-payments
  { payment-id: uint }
  {
    license-id: uint,
    amount: uint,
    payment-date: uint,
    period: (string-ascii 50)
  }
)

(define-data-var next-license-id uint u1)
(define-data-var next-payment-id uint u1)

;; License types
(define-constant license-exclusive "exclusive")
(define-constant license-non-exclusive "non-exclusive")
(define-constant license-research "research")

;; License statuses
(define-constant status-active "active")
(define-constant status-expired "expired")
(define-constant status-terminated "terminated")

;; Create license agreement
(define-public (create-license
  (variety-id uint)
  (licensee principal)
  (license-type (string-ascii 50))
  (royalty-rate uint)
  (territory (string-ascii 100))
  (duration uint)
)
  (let ((license-id (var-get next-license-id)))
    ;; In a full implementation, verify variety ownership
    (map-set license-agreements
      { license-id: license-id }
      {
        variety-id: variety-id,
        licensor: tx-sender,
        licensee: licensee,
        license-type: license-type,
        royalty-rate: royalty-rate,
        territory: territory,
        start-date: block-height,
        end-date: (+ block-height duration),
        status: status-active
      }
    )
    (var-set next-license-id (+ license-id u1))
    (ok license-id)
  )
)

;; Record royalty payment
(define-public (record-royalty-payment
  (license-id uint)
  (amount uint)
  (period (string-ascii 50))
)
  (match (map-get? license-agreements { license-id: license-id })
    license-data
    (begin
      ;; Verify licensee authorization
      (asserts! (is-eq tx-sender (get licensee license-data)) err-not-authorized)

      (let ((payment-id (var-get next-payment-id)))
        (map-set royalty-payments
          { payment-id: payment-id }
          {
            license-id: license-id,
            amount: amount,
            payment-date: block-height,
            period: period
          }
        )
        (var-set next-payment-id (+ payment-id u1))
        (ok payment-id)
      )
    )
    err-not-found
  )
)

;; Terminate license
(define-public (terminate-license (license-id uint))
  (match (map-get? license-agreements { license-id: license-id })
    license-data
    (begin
      ;; Verify licensor authorization
      (asserts! (is-eq tx-sender (get licensor license-data)) err-not-authorized)

      (map-set license-agreements
        { license-id: license-id }
        (merge license-data { status: status-terminated })
      )
      (ok true)
    )
    err-not-found
  )
)

;; Get license agreement
(define-read-only (get-license (license-id uint))
  (map-get? license-agreements { license-id: license-id })
)

;; Get royalty payment
(define-read-only (get-royalty-payment (payment-id uint))
  (map-get? royalty-payments { payment-id: payment-id })
)
