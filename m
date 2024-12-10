Return-Path: <bpf+bounces-46553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CE9EB9F8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61062167525
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264921423A;
	Tue, 10 Dec 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Q5WLWETe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8D1BC9E2;
	Tue, 10 Dec 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858256; cv=none; b=tqn1S5aHJ4gbyKEVB2qm0anNEq7itXammtGxbkbq79F1SCRC7FEadzuINVZ6tE/3UcJc3v11eUeUPFq6p8kt1nCopJYQlNzLwOAAX9rJNcXBEoHsTZ9hLVvK57gxu7J8txuNkVzJZztRaKAPjjzeSak+i7OR306+V4ozipgNW+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858256; c=relaxed/simple;
	bh=B1adUjR1VE80f1PTstNu785YA4jDE4rVDXmLSCYT2aI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTjXL6YtlcBzVdPq3dFpahLcUlE4PLJEgZYm85rQhNx+szyxUaUdczonyr4yjyej+h97BCYGiZObXlXKOZKKkx/NGcCZ4iNfhQOWwpMwZEftYVKzlYVHFv+ao5fOl32Uq+VP45q6ds0H41tyjVVuV5tSg/U5LaCMzPYCFUZKU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Q5WLWETe; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGAf2t018432;
	Tue, 10 Dec 2024 19:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=B1adUjR1VE80f1PTstNu785YA4jDE4rVDXmLSCYT2aI=; b=Q
	5WLWETej/0uKO6cQ1WldX4CJ3IaLH90EjGr1lkk0cGOEJj9n5PVIBgjR9chPXsbh
	WXfczIGo4DVHR8tSYL60ElqL20UzdQeCSsvKfZtraVBvxMfQNWA7GJ/+SG0UnDNz
	aKyYPDoWR4XmnBmuqNDUlpXmXzhsu7tfSKi8/HI7jvRVcAEOEgNbqvgw9dFh+4zI
	mwo5kSulGhKEyf1/Qm32CpBkx88bzZXpktbqg7i1aCI4I3PP2pU9IC1qmoqodYQA
	abjRiSXTTPxt3IO7dNESBuZUu7pikklfjV20zIHwzNeudEq0BlTJggjPmdZvr173
	tg/P8MaftEbtGDXHPrYtg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 43erxfgjqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 19:15:15 +0000 (GMT)
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04wpexch05.crowdstrike.sys (10.100.11.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Dec 2024 19:15:13 +0000
Received: from 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5]) by
 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5%9]) with mapi id
 15.02.1544.009; Tue, 10 Dec 2024 19:15:13 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ojeda@kernel.org"
	<ojeda@kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nathan@kernel.org"
	<nathan@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "surenb@google.com"
	<surenb@google.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "zhengyejian@huaweicloud.com" <zhengyejian@huaweicloud.com>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "bp@alien8.de"
	<bp@alien8.de>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC: Amit Dang <amit.dang@crowdstrike.com>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix
 weak function issue
Thread-Topic: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix
 weak function issue
Thread-Index: AQHbSzfWIbF4ko3yU0yIDGnRxekZ5w==
Date: Tue, 10 Dec 2024 19:15:13 +0000
Message-ID: <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
In-Reply-To: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <894EEA24DDE3DA4C924E664F311AA9D3@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=Td5stQQh c=1 sm=1 tr=0 ts=67589343 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=pl6vuDidAAAA:8 a=eHuGQ7gFT_7OOu_YEIIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mM4J9j6hWFAPRFjVNI4NhQBKWaTtiq1Z
X-Proofpoint-GUID: mM4J9j6hWFAPRFjVNI4NhQBKWaTtiq1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=658
 adultscore=0 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412100140

T24gVHVlLCAyMDI0LTA3LTIzIGF0IDE0OjMyICswODAwLCBaaGVuZyBZZWppYW4gd3JvdGU6DQo+
IEJhY2tncm91bmQgb2YgdGhpcyBwYXRjaCBzZXQgY2FuIGJlIGZvdW5kIGluIHYxOg0KPiANCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNjEzMTMzNzExLjI4Njc3NDUtMS16aGVu
Z3llamlhbjFAaHVhd2VpLmNvbS8NCj4gwqANCj4gDQo+IEhlcmUgYWRkIGEgcmVwcm9kdWN0aW9u
IHRvIHNob3cgdGhlIGltcGFjdCB0byBsaXZlcGF0Y2g6DQo+IDEuIEFkZCBmb2xsb3dpbmcgaGFj
ayB0byBtYWtlIGxpdmVwYXRjaC1zYW1wbGUua28gZG8gcGF0Y2ggb24NCj4gZG9fb25lX2luaXRj
YWxsKCkNCj4gwqDCoCB3aGljaCBoYXMgYW4gb3ZlcnJpZGVuIHdlYWsgZnVuY3Rpb24gYmVoaW5k
IGluIHZtbGludXgsIHRoZW4gcHJpbnQNCj4gdGhlDQo+IMKgwqAgYWN0dWFsbHkgdXNlZCBfX2Zl
bnRyeV9fIGxvY2F0aW9uOg0KPiANCg0KSGkgYWxsLCB3aGF0IGlzIHRoZSBzdGF0dXMgb2YgdGhp
cyBwYXRjaCBzZXJpZXM/IEknZCByZWFsbHkgbGlrZSB0byBzZWUNCml0IG9yIHNvbWUgb3RoZXIg
Zml4IHRvIHRoaXMgaXNzdWUgbWVyZ2VkLiBUaGUgdW5kZXJseWluZyBidWcgaXMgYQ0Kc2lnbmlm
aWNhbnQgb25lIHRoYXQgY2FuIGNhdXNlIGZ0cmFjZS9saXZlcGF0Y2gvQlBGIGZlbnRyeSB0byBm
YWlsDQpzaWxlbnRseS4gSSd2ZSBub3RpY2VkIHRoaXMgYnVnIGluIGFub3RoZXIgY29udGV4dFsx
XSBhbmQgcmVhbGl6ZWQNCnRoZXkncmUgdGhlIHNhbWUgaXNzdWUuDQoNCkknbSBoYXBweSB0byBo
ZWxwIHdpdGggdGhpcyBwYXRjaCBzZXJpZXMgdG8gYWRkcmVzcyBhbnkgaXNzdWVzIGFzDQpuZWVk
ZWQuDQoNClsxXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzcxMzY2MDVkMjRkZTliMWZj
NjJkMDJhMzU1ZWYxMWM5NTBhOTQxNTMuY2FtZWxAY3Jvd2RzdHJpa2UuY29tL1QvI21iN2U2Zjg0
YWM5MGZhNzg5ODllOWUyYzNjZDhkMjlmNjVhNzg4NDViDQo=

