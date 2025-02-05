Return-Path: <bpf+bounces-50463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74935A28007
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15DD1667E6
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C380B;
	Wed,  5 Feb 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="xvhANHd6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0D163;
	Wed,  5 Feb 2025 00:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714459; cv=none; b=ZJx6PN+UMQEDqJhdosh4Ee5outJID+FtxlCWDdAf4sartmDxAA6MwUu5sFt3afLygY2XmY05pEYw6DgC7X/E2SXUVrXMygY3XPQU0MK4kpPCANhUB9L1NJ2BAHmubz1m6SjO21k36PQvDjdZN4cWjNQBEQ9KLxpOAUIU3IpU9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714459; c=relaxed/simple;
	bh=PoMSsUfaTp2XGK37F2q4r7oB4qwqDq26iNYJKGa7rA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sriBq4Ta1qFjAOe7CqWNp5ak3q7FTCenIzg9IRvm92XTs1jAi6jU3Wb4j9Xt+/GwRz9fEg8f7ndQBh9PSs0xpJUMHR8rYmurGNh8bgVR4HvKpU8g6mY/03iJf002AzElsB2XaS23gnTGU+trgMCPwO7kqzLAn1oM2DFRpAyR7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=xvhANHd6; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514N2vfT028175;
	Wed, 5 Feb 2025 00:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=PoMSsUfaTp2XGK37F2q4r7oB4qwqDq26iNYJKGa7rA0=; b=x
	vhANHd6RjrEbKAjsS9nlKy7Zeo9MMNhjE4nZ+KwJEnTg7UIeuyP9EDIhqwGG9YqI
	bIgsRXWRAY8gEzweR6jUfZr80V9Em5RN+d40SHGXQnXkxh04qsdBiPlMwsE0DShU
	jNXnPsrkofuHPUdnQKn2e5QAv4MsMpn3CVxVBFZXkE4TUHwwoZ9jipab3n8/3NP4
	hC+miN8ZEoWU5EtaevqDlmaFQaC8BoIoWptQvwZl1TxcVMBGbqI7JuVxqGuqfAQ0
	2vu1+WLPhU4pd0219wFex7Le40UxZYlOjvY3fsXlzvAmE9V1TbJp+ynx9DHnnjgx
	0aLzit6ZPoYZ5qyoDPHaA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 44kv7hr57t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 00:13:27 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 00:13:26 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138]) by
 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138%11]) with mapi id
 15.02.1544.009; Wed, 5 Feb 2025 00:13:26 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>
CC: "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "mhiramat@kernel.org"
	<mhiramat@kernel.org>,
        "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "zhengyejian1@huawei.com"
	<zhengyejian1@huawei.com>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Thread-Topic: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Thread-Index: AQHbd2LGURzmIpDu8kKWzgK+3/K/Ow==
Date: Wed, 5 Feb 2025 00:13:26 +0000
Message-ID: <aba52935dc06a1fe69f05309f5d9828a297ad787.camel@crowdstrike.com>
References: <20250102232609.529842248@goodmis.org>
	 <20250102232651.347490863@goodmis.org>
In-Reply-To: <20250102232651.347490863@goodmis.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F130E4754162E479CB6F51E3DE51EF3@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=ZI0tmW7b c=1 sm=1 tr=0 ts=67a2ad27 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=meVymXHHAAAA:8 a=AvkiO76Ye04or-2dPXIA:9
 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: wGCdR5zMQzEhVkM0jYhv7VehxaEXwqPp
X-Proofpoint-ORIG-GUID: wGCdR5zMQzEhVkM0jYhv7VehxaEXwqPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_10,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=857 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040181

T24gVGh1LCAyMDI1LTAxLTAyIGF0IDE4OjI2IC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gRnJvbTogU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQo+IA0KPiBXaGVu
IGEgZnVuY3Rpb24gaXMgYW5ub3RhdGVkIGFzICJ3ZWFrIiBhbmQgaXMgb3ZlcnJpZGRlbiwgdGhl
IGNvZGUgaXMNCj4gbm90DQo+IHJlbW92ZWQuIElmIGl0IGlzIHRyYWNlZCwgdGhlIGZlbnRyeS9t
Y291bnQgbG9jYXRpb24gaW4gdGhlIHdlYWsNCj4gZnVuY3Rpb24NCj4gd2lsbCBiZSByZWZlcmVu
Y2VkIGJ5IHRoZSAiX19tY291bnRfbG9jIiBzZWN0aW9uLiBUaGlzIHdpbGwgdGhlbiBiZQ0KPiBh
ZGRlZA0KPiB0byB0aGUgYXZhaWxhYmxlX2ZpbHRlcl9mdW5jdGlvbnMgbGlzdC4gU2luY2Ugb25s
eSB0aGUgYWRkcmVzcyBvZiB0aGUNCj4gZnVuY3Rpb25zIGFyZSBsaXN0ZWQsIHRvIGZpbmQgdGhl
IG5hbWUgdG8gc2hvdywgYSBzZWFyY2ggb2Yga2FsbHN5bXMNCj4gaXMNCj4gdXNlZC4NCj4gDQo+
IFNpbmNlIGthbGxzeW1zIHdpbGwgcmV0dXJuIHRoZSBmdW5jdGlvbiBieSBzaW1wbHkgZmluZGlu
ZyB0aGUNCj4gZnVuY3Rpb24NCj4gdGhhdCB0aGUgYWRkcmVzcyBpcyBhZnRlciBidXQgYmVmb3Jl
IHRoZSBuZXh0IGZ1bmN0aW9uLCBhbiBhZGRyZXNzIG9mDQo+IGENCj4gd2VhayBmdW5jdGlvbiB3
aWxsIHNob3cgdXAgYXMgdGhlIGZ1bmN0aW9uIGJlZm9yZSBpdC4gVGhpcyBpcyBiZWNhdXNlDQo+
IGthbGxzeW1zIGRvZXMgbm90IHNhdmUgbmFtZXMgb2Ygd2VhayBmdW5jdGlvbnMuIFRoaXMgaGFz
IGNhdXNlZA0KPiBpc3N1ZXMgaW4NCj4gdGhlIHBhc3QsIGFzIG5vdyB0aGUgdHJhY2VkIHdlYWsg
ZnVuY3Rpb24gd2lsbCBiZSBsaXN0ZWQgaW4NCj4gYXZhaWxhYmxlX2ZpbHRlcl9mdW5jdGlvbnMg
d2l0aCB0aGUgbmFtZSBvZiB0aGUgZnVuY3Rpb24gYmVmb3JlIGl0Lg0KPiANCg0KSSdtIG5vdCBu
ZWNlc3NhcmlseSBhIHF1YWxpZmllZCByZXZpZXdlciBmb3IgdGhpcyBwYXRjaCwgYnV0IEknbSB2
ZXJ5DQppbnRlcmVzdGVkIGluIHNlZWluZyBpdCBvciBhIHNpbWlsYXIgc29sdXRpb24gZ2V0IG1l
cmdlZCwgYXMgdGhlIGltcGFjdA0Kd2hlbiBpdCBoaXRzIGlzIHNpZ25pZmljYW50IChzaWxlbnQg
ZmFpbHVyZSkgYW5kIG5vdCBlYXN5IHRvIGRldGVjdCBvcg0Kd29yayBhcm91bmQuIElzIHRoZXJl
IGFueSBvYnN0YWNsZSBsZWZ0IGluIGdldHRpbmcgdGhpcyBvbmUgbWVyZ2VkDQpvdGhlciB0aGFu
IGZ1cnRoZXIgcmV2aWV3cz8NCg==

