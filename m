Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6E6BBA37
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjCOQvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 12:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjCOQvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 12:51:33 -0400
Received: from faui40.informatik.uni-erlangen.de (faui40.informatik.uni-erlangen.de [131.188.34.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8877E042;
        Wed, 15 Mar 2023 09:51:27 -0700 (PDT)
Received: from [10.188.34.202] (i4laptop35.informatik.uni-erlangen.de [10.188.34.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gerhorst)
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTPSA id 4PcGcm3WFLznkbm;
        Wed, 15 Mar 2023 17:51:20 +0100 (CET)
Message-ID: <ff8135a6-506f-330f-89fb-f98672467b27@cs.fau.de>
Date:   Wed, 15 Mar 2023 17:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Luis Gerhorst <gerhorst@cs.fau.de>
Subject: bpf: misleading spec_v1 check on variable-offset stack read?
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms070705070308050000020908"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070705070308050000020908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

is there any way to introduce variable-offset (stack) pointers without 
using pointer arithmetic (BPF_ADD/SUB)? If yes, I believe this is a 
security issue because these can be used in stack writes. If not, I 
think the patch sent in reply to this mail should be applied. (I was not 
able to find any indication that the former is the case.)

Best regards,
Luis


--------------ms070705070308050000020908
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
EeswggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWsMIIElKADAgECAgcbY7rQHiw9MA0GCSqGSIb3DQEBCwUAMIGVMQswCQYD
VQQGEwJERTFFMEMGA1UEChM8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hl
biBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLEwdERk4tUEtJMS0wKwYDVQQDEyRE
Rk4tVmVyZWluIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IDIwHhcNMTYwNTI0MTEzODQwWhcN
MzEwMjIyMjM1OTU5WjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJ07eRxH3h+Gy8Zp1xCeOdfZojDbchwFfylf
S2jxrRnWTOFrG7ELf6Gr4HuLi9gtzm6IOhDuV+UefwRRNuu6cG1joL6WLkDh0YNMZj0cZGnl
m6Stcq5oOVGHecwX064vXWNxSzl660Knl5BpBb+Q/6RAcL0D57+eGIgfn5mITQ5HjUhfZZkQ
0tkqSe3BuS0dnxLLFdM/fx5ULzquk1enfnjK1UriGuXtQX1TX8izKvWKMKztFwUkP7agCwf9
TRqaA1KgNpzeJIdl5Of6x5ZzJBTN0OgbaJ4YWa52fvfRCng8h0uwN89Tyjo4EPPLR22MZD08
WkVKusqAfLjz56dMTM0CAwEAAaOCAgUwggIBMBIGA1UdEwEB/wQIMAYBAf8CAQEwDgYDVR0P
AQH/BAQDAgEGMCkGA1UdIAQiMCAwDQYLKwYBBAGBrSGCLB4wDwYNKwYBBAGBrSGCLAEBBDAd
BgNVHQ4EFgQUazqYi/nyU4na4K2yMh4JH+iqO3QwHwYDVR0jBBgwFoAUk+PYMiba1fFKpZFK
4OpL4qIMz+EwgY8GA1UdHwSBhzCBhDBAoD6gPIY6aHR0cDovL2NkcDEucGNhLmRmbi5kZS9n
bG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDBAoD6gPIY6aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1jYS9wdWIvY3JsL2NhY3JsLmNybDCB3QYIKwYB
BQUHAQEEgdAwgc0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1T
ZXJ2ZXIvT0NTUDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDEucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSgYIKwYBBQUHMAKGPmh0dHA6Ly9j
ZHAyLnBjYS5kZm4uZGUvZ2xvYmFsLXJvb3QtZzItY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0
MA0GCSqGSIb3DQEBCwUAA4IBAQCBeEWkTqR/DlXwCbFqPnjMaDWpHPOVnj/z+N9rOHeJLI21
rT7H8pTNoAauusyosa0zCLYkhmI2THhuUPDVbmCNT1IxQ5dGdfBi5G5mUcFCMWdQ5UnnOR7L
n8qGSN4IFP8VSytmm6A4nwDO/afr0X9XLchMX9wQEZc+lgQCXISoKTlslPwQkgZ7nu7YRrQb
tQMMONncsKk/cQYLsgMHM8KNSGMlJTx6e1du94oFOO+4oK4v9NsH1VuEGMGpuEvObJAaguS5
Pfp38dIfMwK/U+d2+dwmJUFvL6Yb+qQTkPp8ftkLYF3sv8pBoGH7EUkp2KgtdRXYShjqFu9V
NCIaE40GMIIHITCCBgmgAwIBAgIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBCwUAMIGNMQsw
CQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRz
Y2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQD
DBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBMB4XDTIyMDExMTEwNDgyN1oXDTI1MDEx
MDEwNDgyN1owgakxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVy
bGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJpY2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxh
bmdlbi1OdWVybmJlcmcxETAPBgNVBAQMCEdlcmhvcnN0MQ0wCwYDVQQqDARMdWlzMRYwFAYD
VQQDDA1MdWlzIEdlcmhvcnN0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyaD9
1GYQ1cfsamslbh08nQ3JIeQo6BDEyRCMmxeUK8be1LXhDn/smIAcDoGR6gbBvMcG2w8v8y+p
lA1N8FLsWUygfkUPHzt18W28Z9cVURI17Y5EffXrKxWO3rHBEVhL/KVREibnMwCtI+9lG9nW
ktUhHscygUP/GFjH9OFZrNBhChwOcMmBUkdbGsN9JNFR/IC91UG4l0uUe4HTLBjn3SBvA2Ku
4CcfE9+0PpwMc3U/ysUv58AKNP5xOdXd41mNH6C4lpbLU9RfIqtWcMBNrSRiuQXf+kAMsJZ3
QdvRAeOmYGnfnotQv50dldQlDLzL5yM+hnF2dMc3sHYfN+jffzvvPRPFfMRAAabWTAMpDr+e
Wg0xVuuhc3/qfp3HfD4ImC14D8PIq/HfTDwpfnngn86Tfw1+NlKcsFO2E2zo8ehR7fIZ4m5J
EjJN0TAmrXdfkSfnTi+u7S3mTnm/8hSG1n0tGz8ChlNK4bQvjfbHDgDSNVYLiJ7mwvd2ezMU
3O6GWO2Rkh2ajWz0wKsZj/c+qEah3vVK//hyAU5ZrUMBen0CC2VxDvrTqK5T9U3o2dlnRntH
2mlBnAKZRPjXbqiZPaUafxGl3Ei4kucYqM7uGlRnuuoPHRdbHYl43LpVm3PrAznEio/T8RVQ
oVsW0+bXBwNI0M6crOThU9VRC6vnABUCAwEAAaOCAmEwggJdMD4GA1UdIAQ3MDUwDwYNKwYB
BAGBrSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEECjAQBg4rBgEEAYGtIYIsAgEECjAJBgNVHRME
AjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYD
VR0OBBYEFHKMa3m3JJ+2DN8JQfcfTTPnmog0MB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIe
CR/oqjt0MDMGA1UdEQQsMCqBEmdlcmhvcnN0QGNzLmZhdS5kZYEUbHVpcy5nZXJob3JzdEBm
YXUuZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4t
Y2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2FjcmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2Eu
ZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHViL2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEB
BIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVy
L09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2Jh
bC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZI
hvcNAQELBQADggEBAJtkku/mMKt7UG2ghvD//mIuCVhB36VqetpOm0o8RaEIi/KA5jf8q2F+
JihuV11chvT6Sie8UtGGu/V1l18LexvFmQIDMT31z1bbo7SzfHCRq+NZaCbUwECYKcewWa9u
UUw+FQuZ4QzooMMMNvtNxCW5M1esjYbLonOoydT+FTva5RWJNAo4t4LgRJLX0WYUaM58viqb
2Z6bweG+AnjpB2TwTwJ8NdlwpNN/q2aWQWYVUedK2X3vLetyIlyDY2z1lsWHvtGyU/PriEz/
UDv7CMQphqhYobsg05DNs31hmW75XxfXXyXvOaLrjhUeSY6el04/a5Q6/fL7LXkcCivnMZMx
ggUrMIIFJwIBATCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9l
cmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UE
CwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfze
CQJGjR2GicgiMA0GCWCGSAFlAwQCAwUAoIICXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMTUxNjUxMTlaME8GCSqGSIb3DQEJBDFCBECZPwPiBvZQ
YHJYTURv6lyUVMNmcoTYAMk+E0JT41eHNdbESZhRg5445HF/Jx49M42aQoN8XhfPxUo2qSkP
a0uOMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcN
AwICASgwga8GCSsGAQQBgjcQBDGBoTCBnjCBjTELMAkGA1UEBhMCREUxRTBDBgNVBAoMPFZl
cmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4gRm9yc2NodW5nc25ldHplcyBl
LiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZOLVZlcmVpbiBHbG9iYWwgSXNz
dWluZyBDQQIMJfzeCQJGjR2GicgiMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCBjTELMAkGA1UE
BhMCREUxRTBDBgNVBAoMPFZlcmVpbiB6dXIgRm9lcmRlcnVuZyBlaW5lcyBEZXV0c2NoZW4g
Rm9yc2NodW5nc25ldHplcyBlLiBWLjEQMA4GA1UECwwHREZOLVBLSTElMCMGA1UEAwwcREZO
LVZlcmVpbiBHbG9iYWwgSXNzdWluZyBDQQIMJfzeCQJGjR2GicgiMA0GCSqGSIb3DQEBAQUA
BIICAIamIF8FUAedjuQ66a++9vogDf6YHfvkDRON9r98D+u1MkfLDAwjr5XBIMyO7hst4Nj1
iKkDOuAlA0SKfTNo3c14fdODZ23nj/T+PI+lLNQsaqOhfayF69iBzGbeBcarsi4iv4OWwB8u
1H+kW0VmwT4TeIrn89ZoDSLzW5lKQ6+/HkbxgmrqY6DUd7ifcewNG1W62Wnn9aYSoiKQ3JU8
CAK/TEQCE+WgyMlg2o4OVbXFbsHAZpMJ9+Pion+FiFwpn+jUQJiyR+dQOwUti5yy5NkRuHFM
ig1PcEJeQkYNmJg83fII3wuPUdbnHkRp+ku7nLHgNmseYMLYnJtt3Bzwckb+2bh2EGygf7tW
QKf1g/OQsa2iTeAgKG2ATD4CrA07/KgJC3iQuVE6y4Jvmiv6uGBQhJ499cu8Nba/VWGpcp0u
oXQzIZaCyCPAW/cH2LtLs3urzMthATFoQjffItLg+GiAAmuJoCw6nJm9IBCjInhhec/bqwvk
1Esfa2hOlSqFIlMuFqmrykB+mm7Fw1SkWlhz2JSwS1r0duzvGQeTf5P8ayxkI/mZ0Jp6lljI
ZhfRfY/925IGwf3VLz2cGYIUd6N+l57ldvydEV1/aqV70afyhQLAszclT3/5QH8w99CwODaF
kymq91RLsavHhdwSnXaLjAeAcupfJELBVOpqoiLWAAAAAAAA
--------------ms070705070308050000020908--
