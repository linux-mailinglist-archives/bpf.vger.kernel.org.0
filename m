Return-Path: <bpf+bounces-46563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BF9EBBA9
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0625A1889C64
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21A230278;
	Tue, 10 Dec 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="KcwrhxSb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79057153BF6;
	Tue, 10 Dec 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865286; cv=none; b=n38iK4XlbV6F7Qrl75qWnkR1WuiO3HthudX+MfUWMgXbUpps1NHLx3ENMdAPcdbZ1IkEowQE3tUJbVBQ8xQN+saWPqD4uI+HUmxnp9OYamZ9LEty5K+Lnpaz8RbP+FDw0Y0qRdDd/yRo2rwmvzJx0IYeQxu/MSEQgVNsDHk0+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865286; c=relaxed/simple;
	bh=uWWb82MfPtRjjHyxXIswpvSWMmUlqgSV9x5gdwMFw2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XEnlc10fCY+Kt4W1BOs6ZNfEEz3CAIKvXGs4RTqCm31N1yke5ERCkSlrhjb3rHGWPV6eJd6Ft9TDOTek9DgReR9v/XhDjsPWRelrAY0ZOcbNr9uUDFaMFmUOd0hRDjYGEVZTROdbKHHWD4IlBRL4tCWdp+FDi6YM79dZ/QHS80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=KcwrhxSb; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJn2AF006248;
	Tue, 10 Dec 2024 20:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=uWWb82MfPtRjjHyxXIswpvSWMmUlqgSV9x5gdwMFw2Y=; b=K
	cwrhxSbtEYBRvzsvsdx1itGQHsRJHy9PNRLA66zz6oyTYnQVI4c1q6FUCu9xMPRJ
	x0sAFGTiqVpRUS1SpETm2fRLQ/m1uglh5GD2r43bUKz3rGW28EvMRm8p4o+NC4tC
	h4lDRk+xz2rzDJfXliu7ZUCvW43PKN/YME0gxCX6zj+RcR7aLx7D6DWBN6w0Mz2l
	uzjY4YVow0UhdvthHLIJkmc2TrD2MFIV4qkETzPE1q8RletPrvfLIQhEt/EyicLy
	wW1C8eXBIGk7cxfwmGw6tyrSUH2ku/gOHcA1gY2p9uFvB/ssGOW+VTovtgSmKYTf
	erSvpHH7AVT+6jFL/bhFQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 43enarhfqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 20:49:53 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04wpexch08.crowdstrike.sys (10.100.11.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Dec 2024 20:49:52 +0000
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Dec 2024 12:49:51 -0800
Received: from 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5]) by
 04wpexch06.crowdstrike.sys ([fe80::9386:41e4:ec25:9fd5%9]) with mapi id
 15.02.1544.009; Tue, 10 Dec 2024 20:49:51 +0000
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
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nathan@kernel.org"
	<nathan@kernel.org>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "surenb@google.com" <surenb@google.com>,
        "zhengyejian@huaweicloud.com" <zhengyejian@huaweicloud.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>,
        "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>,
        "bp@alien8.de" <bp@alien8.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>
CC: Amit Dang <amit.dang@crowdstrike.com>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and
 fix weak function issue
Thread-Topic: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and
 fix weak function issue
Thread-Index: AQHbS0UOy5EKb9eED0ygRLeYfQd4Mg==
Date: Tue, 10 Dec 2024 20:49:51 +0000
Message-ID: <d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
	 <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
	 <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
In-Reply-To: <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <B02A2CB1C4F11649B171690F94820629@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: PMYGstxHIcTVLjDkxVGTLGYbNtmnvdZh
X-Authority-Analysis: v=2.4 cv=d6sPyQjE c=1 sm=1 tr=0 ts=6758a971 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8
 a=PLFCH0Z3ytBysqgyJFcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PMYGstxHIcTVLjDkxVGTLGYbNtmnvdZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=831
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100150

T24gVHVlLCAyMDI0LTEyLTEwIGF0IDIxOjAxICswMTAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiA+IA0KPiA+IEhpIGFsbCwgd2hhdCBpcyB0aGUgc3RhdHVzIG9mIHRoaXMgcGF0Y2ggc2Vy
aWVzPyBJJ2QgcmVhbGx5IGxpa2UgdG8NCj4gPiBzZWUNCj4gPiBpdCBvciBzb21lIG90aGVyIGZp
eCB0byB0aGlzIGlzc3VlIG1lcmdlZC4gVGhlIHVuZGVybHlpbmcgYnVnIGlzIGENCj4gPiBzaWdu
aWZpY2FudCBvbmUgdGhhdCBjYW4gY2F1c2UgZnRyYWNlL2xpdmVwYXRjaC9CUEYgZmVudHJ5IHRv
IGZhaWwNCj4gPiBzaWxlbnRseS4gSSd2ZSBub3RpY2VkIHRoaXMgYnVnIGluIGFub3RoZXIgY29u
dGV4dFsxXSBhbmQgcmVhbGl6ZWQNCj4gPiB0aGV5J3JlIHRoZSBzYW1lIGlzc3VlLg0KPiA+IA0K
PiA+IEknbSBoYXBweSB0byBoZWxwIHdpdGggdGhpcyBwYXRjaCBzZXJpZXMgdG8gYWRkcmVzcyBh
bnkgaXNzdWVzIGFzDQo+ID4gbmVlZGVkLg0KPiANCj4gQXMgZmFyIGFzIEkgY2FuIHNlZSB0aGVy
ZSBhcmUgcHJvYmxlbXMgb24gYnVpbGQgd2l0aCBwYXRjaCAxLCBzZWUgDQo+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tb2R1bGVzL3BhdGNoLzIwMjQwNzIzMDYz
MjU4LjIyNDA2MTAtMi16aGVuZ3llamlhbkBodWF3ZWljbG91ZC5jb20vDQo+IMKgDQo+IA0KPiAN
Cg0KWWVhaCwgSSBzZWUgdGhvc2UuIEFkZGl0aW9uYWxseSwgdGhpcyBwYXRjaCBubyBsb25nZXIg
YXBwbGllcyBjbGVhbmx5DQp0byBjdXJyZW50IG1hc3RlciwgdGhvdWdoIGZpeGluZyBpdCB1cCB0
byBkbyBzbyBpcyBwcmV0dHkgZWFzeS4gSGF2aW5nDQpkb25lIHRoYXQsIHRoaXMgc2VyaWVzIGFw
cGVhcnMgdG8gcmVzb2x2ZSB0aGUgaXNzdWVzIEkgc2F3IGluIHRoZSBvdGhlcg0KbGlua2VkIHRo
cmVhZC4NCg0KWmhlbmcsIGRvIHlvdSBwbGFuIHRvIHNlbmQgYSB2Mz8gSSdkIGJlIGhhcHB5IHRv
IGhlbHAgb3V0IHdpdGggdGhpcw0KcGF0Y2ggc2VyaWVzIGlmIHlvdSdkIGxpa2UsIGFzIEknbSBo
b3BpbmcgdG8gZ2V0IHRoaXMgaXNzdWUgcmVzb2x2ZWQNCih0aG91Z2ggSSBhbSBub3QgYW4gZnRy
YWNlIGV4cGVydCkuDQo=

