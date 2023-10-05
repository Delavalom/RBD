package util

// Constants for all supported currencies
const (
	DOP = "DOP"
	USD = "USD"
	EUR = "EUR"
)

// IsSupportedCurrency returns true if the currency is supported
func IsSupportedCurrency(currency string) bool {
	switch currency {
	case DOP, USD, EUR:
		return true
	default:
		return false
	}
}
