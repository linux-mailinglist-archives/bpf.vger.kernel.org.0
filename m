Return-Path: <bpf+bounces-9437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06A797A3A
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04FF1C20BFA
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7713AEC;
	Thu,  7 Sep 2023 17:33:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3713ADD
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 17:33:58 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13C2125
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 10:33:33 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387BDWtV032561;
	Thu, 7 Sep 2023 17:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type; s=default; bh=0X2wy6vDMqny7o58g9AwlHC
	rmBWaRBGEgxIwfXvPT8g=; b=csNd+toZ0JEFR7fA3KKLWaeGJX7Kl/OlJ+ZRo3Y
	MlVBGFxw2Z+kaI/l4hBDX3UvxzzajmPPdp+KM5Z0oXKgztyHOBI6ZRu4rKO3IiIx
	PjO2uuEa5PFeuKgQIAYsFoHeGGMWnAQ3qxqQSVawxxlUJoFCyJ1V4XInSr6I1fLb
	kA+Krgsrxnh2OW0f3mzZR3TmVuQ+NKN2iM8jt/XRGNxEEnysG7qKZqnTNDfXtwR+
	H6sYiRGqtubFkMZ5ZnIjol/VCJAnQHPsB8iQ0QdtiDz0pGc5nv3iv6VRMu9MAg4n
	yTyioyDMAoI8XR0JvYQDlDQRqMQoCrZOAjdRJhRmL5OQ78Q==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3sydf1ry6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Sep 2023 17:32:01 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Thu, 7 Sep
 2023 17:31:59 +0000
Message-ID: <d616e7c0-4655-85b3-c288-7c5b5fba665f@crowdstrike.com>
Date: Thu, 7 Sep 2023 10:31:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Re: [PATCH bpf] libbpf: soften BTF map error
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
 <5806e499-069f-18f4-2af0-5d9bd8bfa05e@iogearbox.net>
 <2e6c5f26-7ef9-f97f-44dc-03967b3326ea@crowdstrike.com>
 <c109eeeb-9db7-3a7a-f815-412f412968a3@crowdstrike.com>
 <CAEf4BzY1ZPmyyG3T+hSms7Avbb+4CmMJo13v5yZMz824wLt2iw@mail.gmail.com>
Content-Language: en-US
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <CAEf4BzY1ZPmyyG3T+hSms7Avbb+4CmMJo13v5yZMz824wLt2iw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha-256; boundary="------------ms000300050902020508020806"
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH11.crowdstrike.sys (10.100.11.115) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: ewIiqiHyeNnn-XqY4kApwfEX7OD6SM2y
X-Proofpoint-ORIG-GUID: ewIiqiHyeNnn-XqY4kApwfEX7OD6SM2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309070155
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--------------ms000300050902020508020806
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/23 17:29, Andrii Nakryiko wrote:
> On Mon, Aug 28, 2023 at 1:22 PM Martin Kelly
> <martin.kelly@crowdstrike.com> wrote:
>> On 8/17/23 10:07, Martin Kelly wrote:
>>> On 8/17/23 07:17, Daniel Borkmann wrote:
>>>> On 8/16/23 7:30 PM, Martin Kelly wrote:
>>>>> For map-in-map types, the first time the map is loaded, we get a scary
>>>>> error looking like this:
>>>>>
>>>>> libbpf: bpf_create_map_xattr(map_name):ERROR:
>>>>> strerror_r(-524)=22(-524). Retrying without BTF.
>>>>>
>>>>> On the second try without BTF, everything works fine. However, as this
>>>>> is logged at error level, it looks needlessly scary to users. Soften
>>>>> this to be at debug level; if the second attempt still fails, we'll
>>>>> still get an error as expected.
>>>>>
>>>>> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
>>>> nit: $subj should be for bpf-next instead of bpf
>>> I had purposefully sent to "bpf" instead of "bpf-next" as it felt like
>>> a fix, but I'm fine with "bpf-next" instead if that's better.
>>>
>>>>> ---
>>>>>    tools/lib/bpf/libbpf.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>>> index b14a4376a86e..0ca0c8d01707 100644
>>>>> --- a/tools/lib/bpf/libbpf.c
>>>>> +++ b/tools/lib/bpf/libbpf.c
>>>>> @@ -5123,7 +5123,7 @@ static int bpf_object__create_map(struct
>>>>> bpf_object *obj, struct bpf_map *map, b
>>>>>              err = -errno;
>>>>>            cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
>>>>> -        pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying
>>>>> without BTF.\n",
>>>>> +        pr_debug("bpf_create_map_xattr(%s):%s(%d). Retrying without
>>>>> BTF.\n",
>>>>>                map->name, cp, err);
>>>> There are also several other places with pr_warns about BTF when
>>>> loading an obj. Did
>>>> you audit them as well under !BTF kernel? nit: Why changing the fmt
>>>> string itself,
>>>> looked ok as-is, no?
>>> This message is actually printed even for a BTF-supported kernel.
>>> Basically, the first call to bpf_create_map_xattr using BTF *always*
>>> fails for map-in-map types, printing this message, and then the second
>>> always succeeds. So this isn't really about BTF support but simply
>>> about an over-zealous message.
>>>
>>> I changed the format string because calling this an "Error" feels (to
>>> me) unnecessarily alarming, given that this is totally normal
>>> behavior. I'm OK keeping the "Error in" part if you think that's
>>> better. The most important thing to me was that, when the program
>>> loads successfully, we shouldn't be logging to stderr and scaring the
>>> user.
>>>
>>> Let me know if you'd like me to keep the "Error in" part for a v2 patch.
>>>
>>>> There is also libbpf_needs_btf(obj), perhaps this could be left as
>>>> pr_warn similar
>>>> as in bpf_object__init_btf() - or would this still trigger in your case?
>>> I think this one should stay as a warning, as it looks like the code
>>> path is a fatal error, and if you try to load a BTF-requiring program
>>> but don't have BTF, that seems like an error to me. This patch was
>>> more about an error being logged 100% of the time in a totally normal,
>>> non-fatal, BTF-supported case due to the quirks of map-in-map types
>>> and BTF.
>>>
>>>>>            create_attr.btf_fd = 0;
>>>>>            create_attr.btf_key_type_id = 0;
>>>>>
>>>> Thanks,
>>>> Daniel
>> (ping) any thoughts on the above? I'm happy to send a v2 patch but want
>> to make sure we're on the same page with what should be in it.
>>
> map creation failing due to having a BTF information should be a
> rather exception than the norm, for two reasons: 1) libbpf sanitizes
> BTF, so even older kernels can still retain some (modified) BTF
> information, and 2) libbpf drops BTF for maps that don't support BTF
> type info for keys/values. So if you see this, then it would be useful
> to actually look into why this is happening.
>
> So I'd prefer this to keep pretty visible. Can you try to debug what
> makes the kernel reject your BTF information?

I'm happy to report that the issue that prompted this patch doesn't 
repro anymore on latest bpf-next; I originally wrote this some time 
back, so something must have changed in either the BPF code or libbpf. 
Thanks for following up; let's drop this patch.


--------------ms000300050902020508020806
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Cn8wggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEU
MBIGA1UEChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0
OCBpbmNvcnAuIGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVu
dHJ1c3QubmV0IExpbWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24g
QXV0aG9yaXR5ICgyMDQ4KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1
c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykg
MjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0je
rm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOtcUnzqBwfqzQZIE5LVOkAk75wCDHeiVOs
V7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV2MWJGTxlPbno1KUtwizT6oMxogg8
XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFAFveU9ksZNMmX5iKcSN5koIML
WAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzOr+/0fBjOMAvKh/jVXx9Z
UdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/BAQDAgGGMB0GA1Ud
JQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEAMDMGCCsGAQUF
BwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYDVR0fBCsw
KTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0MDIw
MAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmh
JAkWuXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9C
k6QKr0wR7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+h
APANSxRRRvRocbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0
CIfLiwqDXKojK+n/uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYK
W8zYXWsWkUwVlWrj5PzeBnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4x
ELH2l47+IIO9TUowggViMIIESqADAgECAhEA08tQuGADKTUAAAAATD0rOTANBgkqhkiG9w0B
AQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsT
MHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0G
A1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAy
IENsaWVudCBDQTAeFw0yMzA2MjAxNzIwNTVaFw0yNDA2MjAxNzUwNTVaMIGhMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEPMA0GA1UEBxMGSXJ2aW5lMRowGAYDVQQKExFD
cm93ZFN0cmlrZSwgSW5jLjFQMCMGA1UEAwwcbWFydGluLmtlbGx5QGNyb3dkc3RyaWtlLmNv
bTApBgkqhkiG9w0BCQEWHG1hcnRpbi5rZWxseUBjcm93ZHN0cmlrZS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNA2/NGaQa5lSMUmccV1LLbYtqs/nWOHqgNwCcmKCz
H8nUJbQfQ6zTD1+azeD3yXyNh0/ZA0VC2+viSX8tEEKfUs6xog6dOYh1nPmn65M2NY/FfEP2
SuvrjXRRy21Pl5C9Fg6hhPqSFpZghY1gY02ur6t+mMp1If+5Cfre4Z8kSQR5QCLSsfhV1HgT
ugzXJRYeQVzaiqoFzrVL/IzWL9zkoQZyayC1yUTJNCuHF7jLbxU96S9E2eaCsXb1uh3fL7uo
zDLTd1LlmAFbgpPY9pvg42TZBt8R8HhZz60xO6eWd559Kr1BiSfN6/ljEKf6dbqZhQ5YeQX5
0vOtRULdAgKpAgMBAAGjggGNMIIBiTAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMEIGA1UdIAQ7MDkwNwYLYIZIAYb6bAoBBAIwKDAmBggrBgEFBQcC
ARYaaHR0cDovL3d3dy5lbnRydXN0Lm5ldC9ycGEwagYIKwYBBQUHAQEEXjBcMCMGCCsGAQUF
BzABhhdodHRwOi8vb2NzcC5lbnRydXN0Lm5ldDA1BggrBgEFBQcwAoYpaHR0cDovL2FpYS5l
bnRydXN0Lm5ldC8yMDQ4Y2xhc3Myc2hhMi5jZXIwNAYDVR0fBC0wKzApoCegJYYjaHR0cDov
L2NybC5lbnRydXN0Lm5ldC9jbGFzczJjYS5jcmwwJwYDVR0RBCAwHoEcbWFydGluLmtlbGx5
QGNyb3dkc3RyaWtlLmNvbTAfBgNVHSMEGDAWgBQJkaW66fIuKnXfzX7+d8ry3mubJDAdBgNV
HQ4EFgQUkn2sFfaEEaPL26WPi54nFGuQfiAwCQYDVR0TBAIwADANBgkqhkiG9w0BAQsFAAOC
AQEAoGF01JRkMwGCNNuxH42WwS+Ynqf4eIjMylH46nNml/hUbZaEI67ibqYgIwRjuiij3eRX
aqeLtpl7veL7ZoUikhx7wCM/9BU0xxkiMDVSwevpacMF5CqHdcHkvIAb4oFKbv3F9169XKRK
nmtd5cTBEoP0WWvM7/8Jm6Z7R575e2kb7vq2qFvIo2GhZLjVBhgAKr3lpe/TSY0/FlPf23Wt
UeyPcuEbmiTnGKCaYrAZatALpkPRfSp+A8jigq3o7wgf+yek6yv0SOlPQFnzlIwb7UigF476
vgkX3jbK07h4ev/cnmmMc4BKiH7kqhFDxW2oMbZyLtvTengQ3434PKNQljGCBGIwggReAgEB
MIG7MIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMw
d3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYD
VQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIg
Q2xpZW50IENBAhEA08tQuGADKTUAAAAATD0rOTANBglghkgBZQMEAgEFAKCCAncwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwOTA3MTczMTU4WjAvBgkq
hkiG9w0BCQQxIgQgiV6wyg2+2jG/mTjIqzVNsXt6sLypWpCWeKlKSoQJR0kwbAYJKoZIhvcN
AQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBzAYJKwYB
BAGCNxAEMYG+MIG7MIGlMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjE5
MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBvcmF0ZWQgYnkgcmVmZXJl
bmNlMR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYDVQQDExlFbnRydXN0
IENsYXNzIDIgQ2xpZW50IENBAhEA08tQuGADKTUAAAAATD0rOTCBzgYLKoZIhvcNAQkQAgsx
gb6ggbswgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQL
EzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAd
BgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3Mg
MiBDbGllbnQgQ0ECEQDTy1C4YAMpNQAAAABMPSs5MA0GCSqGSIb3DQEBAQUABIIBACzLnFFj
zxRlKV39MgY1HzEY2l7OI73wEAnfJqYXHsquaFMqNH4bc/Rj+/JgMGmrZvwNGjs2aZGYj28J
mZ3tpxZqxN+5xIeSpE4e9t1hL6NPBTcUCeK175kGaiGtcoR0c/EkRU5HS1Rgq01xgCG5ObQs
Glq4fxcuQGq2JMSag8a04XI93gpWi4htI34j6TrnxZ8BIdBaV4u4slJD/g6sxYAxlZ6FZgru
wuiH1drtwqnBCuuAKJGQSTNOfHO7e+wIq6hQUJV+ULPiTqTSrAskM5O2gqq0DS8vYJTn9AC3
7u9EWLA01T56FgfLHkS0TtZhZWPMT3kYn9DH6fgD7ECGr+sAAAAAAAA=
--------------ms000300050902020508020806--

