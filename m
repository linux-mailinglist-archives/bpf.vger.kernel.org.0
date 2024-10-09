Return-Path: <bpf+bounces-41485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C37D9975D7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FB5B22273
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F01E1C01;
	Wed,  9 Oct 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="F7ffH9tU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80D1E133F
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502970; cv=none; b=sh1Oy2X5mOvmbCOoyn7BqsuVTMaN8q7l9GwlpLunPO2sWW40buqLBPpk9uqWp7QGievGzo0ORYofU8Fq8S272zlNZVwefgLfWbUsSNcDXBgckwIuV1qgwgRp6kHl/k24DRNr9dhZnpYUzA4B0DsMPoK/he39zlNSUdu3c+unqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502970; c=relaxed/simple;
	bh=FZek8dJVhpzFf5wemh6ZOH75nuUzLlGigqH38gYVr8o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mavb/PzBshG6tbJbS8FfvGOVcszgqbXp6bI7VXrZw0dF+mujscpqwMo1smDzgi78YjPOE/M2CGksyNJqqyCaREpYwDuBxkuPEHtgyh1ggdn2WUtKX2+kyVtFlZM1R6SezpcYSe8hOPhVodrfcymOXeZFYyW9T3eanlT2POWEeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=F7ffH9tU; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IpDQh003464;
	Wed, 9 Oct 2024 18:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:message-id:mime-version:subject:to;
	 s=default; bh=hwcT8Cxi8V+8G2FB0dKh35DdeBP/lp3/RrbTVIxFILQ=; b=F
	7ffH9tUMmqOYb9aScnWXOY+pjIZTjXClIUksGwhBr1ktfXBJp6j99YKLxbTlD0+3
	lGZ5sfwoDDDtZ9Dl+KMe4k7kME/PZHbxgWuDSg4cm1X7FkWrMUcSSqHDbZIE5rqh
	5srXKV/BuvWucBFXtgMe/djk+yVTsvbOjUDrfJieuMfA96Wl76V93ip6ElK1cQAK
	vhMSlX17LoZklHU16DHdTV2XvVY6ds5LgDAmTseXSpXGMqLp59fYp3fm3VbOucqp
	5BO2nFJjzQ8ZOCoCvMEOjY4+XzEqvf1Bn1s/sxXgqI6HNnPTuAZK0f25BH/BXDf0
	lBNvFcaGg+ljUW4Mzd9mw==
Received: from 04wpexch05.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 425vbh0pf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 18:58:55 +0000 (GMT)
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04wpexch05.crowdstrike.sys (10.100.11.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Oct 2024 18:58:53 +0000
Received: from 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc]) by
 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc%9]) with mapi id
 15.02.1544.009; Wed, 9 Oct 2024 18:58:53 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>
Subject: CONFIG_X86_X32_ABI silently breaks some fentry hooks
Thread-Topic: CONFIG_X86_X32_ABI silently breaks some fentry hooks
Thread-Index: AQHbGn1IBv6Qgmi38kyuqgRRJU67tA==
Date: Wed, 9 Oct 2024 18:58:53 +0000
Message-ID: <7136605d24de9b1fc62d02a355ef11c950a94153.camel@crowdstrike.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-NOPPPrF4i02QoXkZ1sK4"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=C/a7yhP+ c=1 sm=1 tr=0 ts=6706d26f cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=DAUX931o1VcA:10 a=KeyApPSgi2vUwj7OLr8A:9 a=QEXdDO2ut3YA:10
 a=0W44CzhA7K9tyo-iDOoA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: pJIsLmkx-VaznUWQNnVJHzd0FNeaxPl-
X-Proofpoint-GUID: pJIsLmkx-VaznUWQNnVJHzd0FNeaxPl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410090119

--=-NOPPPrF4i02QoXkZ1sK4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all, I want to report a very strange issues I found. Specifically,
on latest master, I found that setting CONFIG_X86_X32_ABI=3Dy causes some
fentry BPF hooks to be silently ignored. Most hooks still work fine,
but some do not, and the same function works fine as a kprobe. The
issue appears to be 100% reproducible for a given function hook.

I checked and verified that the hook is not hit according to the BPF
stats (kernel.bpf_stats_enabled=3D1), and I also didn't see the program
getting run when it should in gdb. As far as I can tell from gdb, the
trampoline code is still getting patched in, but the BPF program is not
later getting invoked.

The steps I used to reproduce are as follows:
- Checkout latest master. I tested with 75b607fab38d ("Merge tag
'sched_ext-for-6.12-rc2-fixes'").
- make localmodconfig or similar, enabling relevant BPF options for
trampolines and BTF. I can send the full config I used if that's
helpful, but I think most config options don't affect this.
- Set CONFIG_X86_X32_ABI=3Dy
- Compile and boot the kernel and run the following bpftrace command:
  bpftrace -e 'kfunc:acct_process { printf("acct_process called\n"); }'
- In another terminal, run some processes, which should normally cause
some output from this command. You should get no output.

Note that a similar command (bpftrace -e 'kfunc:acct_collect {
printf("acct_collect called\n"); }'), hooking a similar function called
in the same code path, still produces output, as does a kprobe of
acct_process (sudo bpftrace -e 'kprobe:acct_process {
printf("acct_process called\n"); }'). Also, with CONFIG_X86_X32_ABI=3Dn,
the acct_process hook works correctly.

--=-NOPPPrF4i02QoXkZ1sK4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD70w
ggUVMIID/aADAgECAhEArxwEsqyM/5sAAAAAUc4Y4zANBgkqhkiG9w0BAQsFADCBtDEUMBIGA1UE
ChMLRW50cnVzdC5uZXQxQDA+BgNVBAsUN3d3dy5lbnRydXN0Lm5ldC9DUFNfMjA0OCBpbmNvcnAu
IGJ5IHJlZi4gKGxpbWl0cyBsaWFiLikxJTAjBgNVBAsTHChjKSAxOTk5IEVudHJ1c3QubmV0IExp
bWl0ZWQxMzAxBgNVBAMTKkVudHJ1c3QubmV0IENlcnRpZmljYXRpb24gQXV0aG9yaXR5ICgyMDQ4
KTAeFw0yMDA3MjkxNTQ4MzBaFw0yOTA2MjkxNjE4MzBaMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UE
ChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBv
cmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYD
VQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxDKNQtCeGZ1bkFoQTLUQACG5B0jerm6A1v8UUAboda9rRo7npU+tw4yw+nvgGZH98GOt
cUnzqBwfqzQZIE5LVOkAk75wCDHeiVOsV7wk7yqPQtT36pUlXRR20s2nEvobsrRcYUC9X91Xm0RV
2MWJGTxlPbno1KUtwizT6oMxogg8XlmuEi4qCoxe87MxrgqtfuywSQn8py4iHmhkNJ0W46Y9AzFA
FveU9ksZNMmX5iKcSN5koIMLWAWYxCJGiQX9o772SUxhAxak+AqZHOLAxn5pAjJXkAOvAJShudzO
r+/0fBjOMAvKh/jVXx9ZUdiLC7k4xljCU3zaJtTb8r2QzQIDAQABo4IBLTCCASkwDgYDVR0PAQH/
BAQDAgGGMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjASBgNVHRMBAf8ECDAGAQH/AgEA
MDMGCCsGAQUFBwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwMgYD
VR0fBCswKTAnoCWgI4YhaHR0cDovL2NybC5lbnRydXN0Lm5ldC8yMDQ4Y2EuY3JsMDsGA1UdIAQ0
MDIwMAYEVR0gADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAdBgNV
HQ4EFgQUCZGluunyLip1381+/nfK8t5rmyQwHwYDVR0jBBgwFoAUVeSB0RGAvtiJuQijMfmhJAkW
uXAwDQYJKoZIhvcNAQELBQADggEBAD+96RB180Kn0WyBJqFGIFcSJBVasgwIf91HuT9Ck6QKr0wR
7sxrMPS0LITeCheQ+Xg0rq4mRXYFNSSDwJNzmU+lcnFjtAmIEctsbu+UldVJN8+hAPANSxRRRvRo
cbL+YKE3DyX87yBaM8aph8nqUvbXaUiWzlrPEJv2twHDOiGlyEPAhJ0D+MU0CIfLiwqDXKojK+n/
uN6nSQ5tMhWBMMgn9MD+zxp1zIe7uhGhgmVQBZ/zRZKHoEW4Gedf+EYKW8zYXWsWkUwVlWrj5Pze
BnT2bFTdxCXwaRbW6g4/Wb4BYvlgnx1AszH3EJwv+YpEZthgAk4xELH2l47+IIO9TUowggVOMIIE
NqADAgECAhBsZB83KgwoWAAAAABMPc0/MA0GCSqGSIb3DQEBCwUAMIGlMQswCQYDVQQGEwJVUzEW
MBQGA1UEChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBp
bmNvcnBvcmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMu
MSIwIAYDVQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENBMB4XDTI0MDYyNDE2MTE1NFoXDTI1
MDYyNDE2NDE1M1owgbwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMQ8wDQYDVQQH
EwZJcnZpbmUxGjAYBgNVBAoTEUNyb3dkU3RyaWtlLCBJbmMuMRkwFwYDVQRhExBOVFJVUytERS01
MDMwNzM3MVAwIwYDVQQDDBxtYXJ0aW4ua2VsbHlAY3Jvd2RzdHJpa2UuY29tMCkGCSqGSIb3DQEJ
ARYcbWFydGluLmtlbGx5QGNyb3dkc3RyaWtlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAJHfGNsWnmZY9pkAGm3Kdy9c45xX7Yk5MonIqtOXAVXGjv0E9X0EwGCA/niGjWj+RL4E
seGI6Jb7zawE2RmGkU2Mka+8j6H7NkG+hWoZ6asJKN8iBoMPSO4XADF5l7yaBSTWJJxAM645rU3R
xNdKR3uLCUYJ4Ys5bgB/9Sz7o1FJKJwO8tbDUz/nVUB1X4F2eW8Az3fKcuvAdPN7gcXoQaLS4wwi
QAAin03FaEzTsn9EaHi/FtwD0Ar0KIDllJCJPwNrDepQDgOVzh29cbqGFzcxPvk4hp486UEWXB0D
MWuGiyOf6EIrGXKypYDxvGj4SwTpVilZdAwKWe+9BWQ+IHECAwEAAaOCAV8wggFbMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwB
BQMBMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQw
NQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQG
A1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMCcGA1Ud
EQQgMB6BHG1hcnRpbi5rZWxseUBjcm93ZHN0cmlrZS5jb20wHwYDVR0jBBgwFoAUCZGluunyLip1
381+/nfK8t5rmyQwHQYDVR0OBBYEFHG793l6wNAsDzVvuD1VwtKRCrzIMAkGA1UdEwQCMAAwDQYJ
KoZIhvcNAQELBQADggEBAJ0+w5yt3zNaWXXwdZREN0ciNNUVOXsHedAEafcYnN9QumSvoUmcLd8N
sRmhv5BcXMqKBh3kIPZzn1+B0zdlvvnYFhD2fM6sC2XZukhZXy97w88EUrP3tOWT+lDmFs+7NRur
/KPyH50Ih/+AFaPPfEMY30dZiWUoq0ChqT3p76Y5L1md6pTpn39nSTAFzKaSf3VxaQo4aY4jrCdL
Xo32MVQGwKtbUT3F5tF/cULxGchkopfSceVFyRELFvCRJobaJlASG5fDhnTY56u2WQOLPspaPNUU
gvxlnSdCMNsaR3BFW5cH/Tklw5CttHHvngNKbuxuFax2kSOQpb3r5OlIiQkwggVOMIIENqADAgEC
AhBsZB83KgwoWAAAAABMPc0/MA0GCSqGSIb3DQEBCwUAMIGlMQswCQYDVQQGEwJVUzEWMBQGA1UE
ChMNRW50cnVzdCwgSW5jLjE5MDcGA1UECxMwd3d3LmVudHJ1c3QubmV0L0NQUyBpcyBpbmNvcnBv
cmF0ZWQgYnkgcmVmZXJlbmNlMR8wHQYDVQQLExYoYykgMjAxMCBFbnRydXN0LCBJbmMuMSIwIAYD
VQQDExlFbnRydXN0IENsYXNzIDIgQ2xpZW50IENBMB4XDTI0MDYyNDE2MTE1NFoXDTI1MDYyNDE2
NDE1M1owgbwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMQ8wDQYDVQQHEwZJcnZp
bmUxGjAYBgNVBAoTEUNyb3dkU3RyaWtlLCBJbmMuMRkwFwYDVQRhExBOVFJVUytERS01MDMwNzM3
MVAwIwYDVQQDDBxtYXJ0aW4ua2VsbHlAY3Jvd2RzdHJpa2UuY29tMCkGCSqGSIb3DQEJARYcbWFy
dGluLmtlbGx5QGNyb3dkc3RyaWtlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AJHfGNsWnmZY9pkAGm3Kdy9c45xX7Yk5MonIqtOXAVXGjv0E9X0EwGCA/niGjWj+RL4EseGI6Jb7
zawE2RmGkU2Mka+8j6H7NkG+hWoZ6asJKN8iBoMPSO4XADF5l7yaBSTWJJxAM645rU3RxNdKR3uL
CUYJ4Ys5bgB/9Sz7o1FJKJwO8tbDUz/nVUB1X4F2eW8Az3fKcuvAdPN7gcXoQaLS4wwiQAAin03F
aEzTsn9EaHi/FtwD0Ar0KIDllJCJPwNrDepQDgOVzh29cbqGFzcxPvk4hp486UEWXB0DMWuGiyOf
6EIrGXKypYDxvGj4SwTpVilZdAwKWe+9BWQ+IHECAwEAAaOCAV8wggFbMA4GA1UdDwEB/wQEAwIF
oDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwFAYDVR0gBA0wCzAJBgdngQwBBQMBMGoG
CCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYIKwYB
BQUHMAKGKWh0dHA6Ly9haWEuZW50cnVzdC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQt
MCswKaAnoCWGI2h0dHA6Ly9jcmwuZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMCcGA1UdEQQgMB6B
HG1hcnRpbi5rZWxseUBjcm93ZHN0cmlrZS5jb20wHwYDVR0jBBgwFoAUCZGluunyLip1381+/nfK
8t5rmyQwHQYDVR0OBBYEFHG793l6wNAsDzVvuD1VwtKRCrzIMAkGA1UdEwQCMAAwDQYJKoZIhvcN
AQELBQADggEBAJ0+w5yt3zNaWXXwdZREN0ciNNUVOXsHedAEafcYnN9QumSvoUmcLd8NsRmhv5Bc
XMqKBh3kIPZzn1+B0zdlvvnYFhD2fM6sC2XZukhZXy97w88EUrP3tOWT+lDmFs+7NRur/KPyH50I
h/+AFaPPfEMY30dZiWUoq0ChqT3p76Y5L1md6pTpn39nSTAFzKaSf3VxaQo4aY4jrCdLXo32MVQG
wKtbUT3F5tF/cULxGchkopfSceVFyRELFvCRJobaJlASG5fDhnTY56u2WQOLPspaPNUUgvxlnSdC
MNsaR3BFW5cH/Tklw5CttHHvngNKbuxuFax2kSOQpb3r5OlIiQkxggPxMIID7QIBATCBujCBpTEL
MAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0
Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAg
RW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQbGQfNyoM
KFgAAAAATD3NPzANBglghkgBZQMEAgEFAKCCAgcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjQxMDA5MTg1ODUzWjAvBgkqhkiG9w0BCQQxIgQg4c2xEwbEGpb3/1Z9
0Hveb3EZH6FF/qO0K0snVLrsMAQwgcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkGA1UEBhMCVVMx
FjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMg
aW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5j
LjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQbGQfNyoMKFgAAAAATD3NPzCB
zQYLKoZIhvcNAQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJ
bmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlzIGluY29ycG9yYXRlZCBieSByZWZl
cmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3Qg
Q2xhc3MgMiBDbGllbnQgQ0ECEGxkHzcqDChYAAAAAEw9zT8wDQYJKoZIhvcNAQEBBQAEggEAclC+
pMelb+1AaR1fI4ce+u3t9Eh9seDjX6m0P419yumxYsjZWrt9fbHTbSXrWZ+QgRsiHpdvFd83rMiU
wRg6xvJuoCuHrwat9tREF5ISFNBhpPKBEtxJdLpn4xeYZMEekAC0NmDu+xAh+84gHhwKeZYszkUu
WLqkVx7bU4WocGG0SQtx7eCsPl0NB31ZtneUq0PyGmNAZb0tifLYQQ8TIp13t4dKmyXJvTA4xsmP
ANb3NKVn0qngHCkUcdGc74sTVJRVfdTdMhRepfpIbq0SqhBWYGGEV/0gMuuu/eFtgxOjl/9youGy
ncQW3CSbHaEPyOrZjlm1oLSqb8hBhBaQYQAAAAAAAA==


--=-NOPPPrF4i02QoXkZ1sK4--

