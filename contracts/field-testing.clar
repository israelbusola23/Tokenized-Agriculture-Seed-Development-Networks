;; Field Testing Contract
;; Manages seed field testing and results

(define-constant err-not-authorized (err u300))
(define-constant err-not-found (err u301))
(define-constant err-test-exists (err u302))

;; Field test data structure
(define-map field-tests
  { test-id: uint }
  {
    variety-id: uint,
    location: (string-ascii 100),
    tester: principal,
    start-date: uint,
    end-date: (optional uint),
    status: (string-ascii 20),
    conditions: (string-ascii 200)
  }
)

;; Test results data structure
(define-map test-results
  { test-id: uint }
  {
    yield: uint,
    quality-score: uint,
    disease-resistance: uint,
    environmental-adaptation: uint,
    notes: (string-ascii 500)
  }
)

(define-data-var next-test-id uint u1)

;; Test statuses
(define-constant status-active "active")
(define-constant status-completed "completed")
(define-constant status-cancelled "cancelled")

;; Start a field test
(define-public (start-field-test
  (variety-id uint)
  (location (string-ascii 100))
  (conditions (string-ascii 200))
)
  (let ((test-id (var-get next-test-id)))
    (map-set field-tests
      { test-id: test-id }
      {
        variety-id: variety-id,
        location: location,
        tester: tx-sender,
        start-date: block-height,
        end-date: none,
        status: status-active,
        conditions: conditions
      }
    )
    (var-set next-test-id (+ test-id u1))
    (ok test-id)
  )
)

;; Complete field test with results
(define-public (complete-field-test
  (test-id uint)
  (yield uint)
  (quality-score uint)
  (disease-resistance uint)
  (environmental-adaptation uint)
  (notes (string-ascii 500))
)
  (match (map-get? field-tests { test-id: test-id })
    test-data
    (begin
      ;; Verify tester authorization
      (asserts! (is-eq tx-sender (get tester test-data)) err-not-authorized)

      ;; Update test status
      (map-set field-tests
        { test-id: test-id }
        (merge test-data {
          status: status-completed,
          end-date: (some block-height)
        })
      )

      ;; Store results
      (map-set test-results
        { test-id: test-id }
        {
          yield: yield,
          quality-score: quality-score,
          disease-resistance: disease-resistance,
          environmental-adaptation: environmental-adaptation,
          notes: notes
        }
      )
      (ok true)
    )
    err-not-found
  )
)

;; Get field test information
(define-read-only (get-field-test (test-id uint))
  (map-get? field-tests { test-id: test-id })
)

;; Get test results
(define-read-only (get-test-results (test-id uint))
  (map-get? test-results { test-id: test-id })
)
