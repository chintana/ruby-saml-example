class Account < ActiveRecord::Base
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = OneLogin::RubySaml::Settings.new

    url_base ||= "http://localhost:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true

    #SP section
    settings.issuer                         = "railsapp"
    settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    # IdP section
    settings.idp_entity_id                  = "localhost"
    settings.idp_sso_target_url             = "https://localhost:9443/samlsso"
    settings.idp_slo_target_url             = "https://localhost:9443/samlsso"
    settings.idp_cert                       = "-----BEGIN CERTIFICATE-----
MIICNTCCAZ6gAwIBAgIES343gjANBgkqhkiG9w0BAQUFADBVMQswCQYDVQQGEwJV
UzELMAkGA1UECAwCQ0ExFjAUBgNVBAcMDU1vdW50YWluIFZpZXcxDTALBgNVBAoM
BFdTTzIxEjAQBgNVBAMMCWxvY2FsaG9zdDAeFw0xMDAyMTkwNzAyMjZaFw0zNTAy
MTMwNzAyMjZaMFUxCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJDQTEWMBQGA1UEBwwN
TW91bnRhaW4gVmlldzENMAsGA1UECgwEV1NPMjESMBAGA1UEAwwJbG9jYWxob3N0
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCUp/oV1vWc8/TkQSiAvTousMzO
M4asB2iltr2QKozni5aVFu818MpOLZIr8LMnTzWllJvvaA5RAAdpbECb+48FjbBe
0hseUdN5HpwvnH/DW8ZccGvk53I6Orq7hLCv1ZHtuOCokghz/ATrhyPq+QktMfXn
RS4HrKGJTzxaCcU7OQIDAQABoxIwEDAOBgNVHQ8BAf8EBAMCBPAwDQYJKoZIhvcN
AQEFBQADgYEAW5wPR7cr1LAdq+IrR44iQlRG5ITCZXY9hI0PygLP2rHANh+PYfTm
xbuOnykNGyhM6FjFLbW2uZHQTY1jMrPprjOrmyK5sjJRO4d1DeGHT/YnIjs9JogR
Kv4XHECwLtIVdAbIdWHEtVZJyMSktcyysFcvuhPQK8Qc/E/Wq8uHSCo=
-----END CERTIFICATE-----"
    # or settings.idp_cert_fingerprint           = "3B:05:BE:0A:EC:84:CC:D4:75:97:B3:A2:22:AC:56:21:44:EF:59:E6"
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings.certificate                    = "-----BEGIN CERTIFICATE-----
MIICfjCCAeegAwIBAgIEFFIb3DANBgkqhkiG9w0BAQsFADByMQswCQYDVQQGEwJV
UzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEN
MAsGA1UEChMEV1NPMjELMAkGA1UECxMCU0ExGjAYBgNVBAMTEUNoaW50YW5hIFdp
bGFtdW5hMB4XDTE2MDYwMTIyMTUyOVoXDTE2MDgzMDIyMTUyOVowcjELMAkGA1UE
BhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDU1vdW50YWluIFZp
ZXcxDTALBgNVBAoTBFdTTzIxCzAJBgNVBAsTAlNBMRowGAYDVQQDExFDaGludGFu
YSBXaWxhbXVuYTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAltt+IuIn/vQx
mulpyzZPGgd3r2ljUCdgBfATyqRYGh6foYXdWUEsx2Bvu4QglyVO6t3tNpYUkcqe
WLHfF6SLgyAenQ94iBt6NdlcIRslCInsdfKIzTelc+zj/nb9jZqPUJQVt9hedYKe
cyRV71b71tyu+zKojWTLSMEvqzCyJNkCAwEAAaMhMB8wHQYDVR0OBBYEFN7hCwJZ
Q17bPUvysjmvqTyhngJuMA0GCSqGSIb3DQEBCwUAA4GBAD51BlRzK765uaJGoFyF
n7IbATzkieqYkpo8huActbUDTMR9AO+zSyZb3nHuQqAHeu3Ba+X9zrndixca03jS
hrcmXC/0ERgg/Ejxad0BJkjyZJ1g9diWBeeepVuaDBTtdGZu+MitwZZon9dodHGu
WMDFIT3pCXpqDQSj45Vtuh/i
-----END CERTIFICATE-----"
    settings.private_key                    = "-----BEGIN PRIVATE KEY-----
MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJbbfiLiJ/70MZrp
acs2TxoHd69pY1AnYAXwE8qkWBoen6GF3VlBLMdgb7uEIJclTurd7TaWFJHKnlix
3xeki4MgHp0PeIgbejXZXCEbJQiJ7HXyiM03pXPs4/52/Y2aj1CUFbfYXnWCnnMk
Ve9W+9bcrvsyqI1ky0jBL6swsiTZAgMBAAECgYB8pfoQSrvvfsgqDuk6XrJ3eGod
R0AnL5G49kj0LF0bn+gYZ2qg4ChmyTkpQKBJIyuVBzCE5Pc0C65Q7Q/AElavCbt2
WgQYJeHnXO3bWL8+T9kv86SJ1NYbKEYT4GxhCgjFXoOruL6pvVJrX9IRihv50D9m
87VQRV4JiUnAjB86AQJBAM8cz4X0eEEGyret150BTfQPEFHatSvCV6lFc4J9FV4g
S9mzr/Aiac/RNYjMFJtf5o1r7Tjdpao51LpKIRLfoJkCQQC6d1owKKxmi8TPB0ze
u/WggkP38DX3E6+LJUWOs/IJ6CUl5pgdDtzL+ZrrEnzPcrcQIS0di6uC2SCsqnI/
cg5BAkB/n4FBSiPP7h98j+MNHICso5uq1NpO3LKn2+QRxIImPkB/JfqEPrB1HrWe
ViNcmvu2qYrEP9CV1I0BPiyjNKoBAkBTqFabQrROcajD5ZeUWqnR8H/EDk534qog
eIFji9Ispa18+p8GcnOXRA5AJxQ+Ek6Vevz9w3sYgofJT9NgKbDBAkEAx1df5ENU
egX/jCAH0NKCOm5JXKa6ighF93+U9whO6q0+OBvJoSNsXH20H37mp1OBi2qTYYys
9RZzf2a3bIjz4g==
-----END PRIVATE KEY-----"

    settings
  end
end
