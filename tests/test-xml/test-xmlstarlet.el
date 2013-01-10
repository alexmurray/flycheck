;;; test-xmlstarlet.el --- Test the xmlstarlet checker

;; Copyright (c) 2013 Sebastian Wiesner <lunaryorn@gmail.com>
;;
;; Author: Sebastian Wiesner <lunaryorn@gmail.com>
;; URL: https://github.com/lunaryorn/flycheck

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'ert)
(require 'flycheck)

(require 'nxml-mode)

(testsuite-module "xml-xmlstarlet")

(ert-deftest xmlstarlet-missing-quote ()
  "Test a missing quote in an attribute value."
  (should-flycheck-checker
   (testsuite-xml-xmlstarlet-resource "missing-quote.xml")
   'nxml-mode 'xml-xmlstarlet
   '(5 1 "Couldn't find end of Start Tag with" error)))

(ert-deftest xmlstarlet-missing-closing-tag ()
  "Test a missing closing tag."
  (should-flycheck-checker
   (testsuite-xml-xmlstarlet-resource "missing-closing-tag.xml")
   'nxml-mode 'xml-xmlstarlet
   '(5 8 "Opening and ending tag mismatch: with line 4 and spam" error)))

(ert-deftest xmlstarlet-lone-closing-tag ()
  "Test a lone closing tag."
  (should-flycheck-checker
   (testsuite-xml-xmlstarlet-resource "lone-closing-tag.xml")
   'nxml-mode 'xml-xmlstarlet
   '(4 10 "Opening and ending tag mismatch: spam line 3 and with" error)))

(ert-deftest xmlstarlet-undefined-entity ()
  "Test an undefined entity."
  (should-flycheck-checker
   (testsuite-xml-xmlstarlet-resource "undefined-entity.xml")
   'nxml-mode 'xml-xmlstarlet
   '(4 25 "Entity 'foo' not defined" error)))

;;; test-xmlstarlet.el ends here
