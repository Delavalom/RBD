package util

import (
	"fmt"
	"net/mail"
	"regexp"
)

var (
	isValidUsername = regexp.MustCompile(`^[a-z0-9_]+$`).MatchString
	isValidFullName = regexp.MustCompile(`^[a-zA-Z\s]+$`).MatchString
)

type Validator interface {
	ValidateString(value string, minLength, maxLength int) error
	ValidateUsername(value string) error
	ValidateFullName(value string) error
	ValidatePassword(value string) error
	ValidateEmail(value string) error
	ValidateEmailId(value int64) error
	ValidateSecretCode(value string) error
}

type Fields struct{}

func NewValidator() Validator {
	return &Fields{}
}

func (*Fields) ValidateString(value string, minLength, maxLength int) error {
	n := len(value)
	if n < minLength || n > maxLength {
		return fmt.Errorf("must contain from %d-%d characters", minLength, maxLength)
	}
	return nil
}

func (fields *Fields) ValidateUsername(value string) error {
	if err := fields.ValidateString(value, 3, 100); err != nil {
		return err
	}
	if !isValidUsername(value) {
		return fmt.Errorf("must contain only lowercase letters, digits, or underscore")
	}
	return nil
}

func (fields *Fields) ValidateFullName(value string) error {
	if err := fields.ValidateString(value, 3, 100); err != nil {
		return err
	}
	if !isValidFullName(value) {
		return fmt.Errorf("must contain only letters or spaces")
	}
	return nil
}

func (fields *Fields) ValidatePassword(value string) error {
	return fields.ValidateString(value, 6, 100)
}

func (fields *Fields) ValidateEmail(value string) error {
	if err := fields.ValidateString(value, 3, 200); err != nil {
		return err
	}
	if _, err := mail.ParseAddress(value); err != nil {
		return fmt.Errorf("is not a valid email address")
	}
	return nil
}

func (fields *Fields) ValidateEmailId(value int64) error {
	if value <= 0 {
		return fmt.Errorf("must be a positive interger")
	}
	return nil
}

func (fields *Fields) ValidateSecretCode(value string) error {
	return fields.ValidateString(value, 32, 64)
}
