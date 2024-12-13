Return-Path: <bpf+bounces-46889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1279F15E7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6732416A979
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F81EBFF7;
	Fri, 13 Dec 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="uI8Jhstn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB051E8826;
	Fri, 13 Dec 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118380; cv=none; b=ClHdVB41D5aQRtbg2bRZsWzhcvMwQwLlflawSnAfvKCo7Vdz+rG3YHnIT60hyyXkzHw0zk5lmVAKLYe4miTwXvItFxh9t9Mvdd3x56z2czfvOQp/rIRmE/F4ZCUFgKENAJGv9DL8nHs0z38wUmbZUr4FCmBY7EcaC4aK/b8mQqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118380; c=relaxed/simple;
	bh=tPoDDdKr7gE1BldzHLPMcwm+vKnfJGCLwyb1r5quvMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HGlosFbWiqJNV6537xhAL0yWgOkd15wM6DBqGJ8ofZRVwde3Zt+rM4U82bOWTyLD6V7SJxK7YPRMhPX4xKXS/wQ6DjgWV6NRWZYJvsiIZLfegQ7u+KYH7WJQ6QB/5CFIULt/rdpEar3QOCn52ryU+FShGXdT+DG+YPpWLRNedMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=uI8Jhstn; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJ1keI032102;
	Fri, 13 Dec 2024 19:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=tPoDDdKr7gE1BldzHLPMcwm+vKnfJGCLwyb1r5quvMs=; b=u
	I8JhstnPB00WefGtmHgPsqDI0fGArtSLljcKNaqbHCFXYfnqJ1PFbK/niLBCe95q
	HnRcyTLSZbxWAcGKcvDx+HG+YNpVJxjCs3UJCgMPkpQTaGNGjaXTGaPNvjXM16a7
	Q31fMlvUzOnJ6VFUmpooiFW5Ekjs+WKtTvZYszJvUlb1g2oBcq/RclhfKv2U7Q3c
	wZm2wudNzHojQt90PJYv7nj8Uq2VPY9hCvZEEvLiXWn4TOEf1HfZyYE3zomqXKCD
	rPUQyOoTkC6R9X63XyGL+EnpADAWEPDl8AqCA8HOv34aigK1isSnBnFus9L/KBxa
	IhIYUDKAD1xMz4KsSYvqg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 43gtqk81xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 19:31:16 +0000 (GMT)
Received: from 04WPEXCH005.crowdstrike.sys (10.100.11.69) by
 04wpexch15.crowdstrike.sys (10.100.11.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 19:31:14 +0000
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH005.crowdstrike.sys (10.100.11.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 19:31:13 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::f686:3950:aa30:445a]) by
 04WPEXCH006.crowdstrike.sys ([fe80::f686:3950:aa30:445a%11]) with mapi id
 15.02.1544.009; Fri, 13 Dec 2024 19:31:13 +0000
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
        "nicolas@fjasle.eu"
	<nicolas@fjasle.eu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "npiggin@gmail.com"
	<npiggin@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "surenb@google.com" <surenb@google.com>,
        "zhengyejian@huaweicloud.com" <zhengyejian@huaweicloud.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>,
        "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>,
        "bp@alien8.de" <bp@alien8.de>,
        "yeweihua4@huawei.com" <yeweihua4@huawei.com>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
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
Thread-Index: AQHbTZWS+4Gf5OP880OTR/pO30cltA==
Date: Fri, 13 Dec 2024 19:31:13 +0000
Message-ID: <30ee9989044dad1a7083a85316d77b35f838e622.camel@crowdstrike.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
	 <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
	 <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
	 <d25741d8a6f88d5a6c219fb53e8aa0bcc1fea982.camel@crowdstrike.com>
	 <1f11e3c4-e8fd-d4ac-23cd-0ab2de9c1799@huaweicloud.com>
In-Reply-To: <1f11e3c4-e8fd-d4ac-23cd-0ab2de9c1799@huaweicloud.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCF0AA386CCD2A498936894F8CF5CF09@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=675c8b84 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=VwQbUJbxAAAA:8 a=IycRoiFrBpt9NGDnbAcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HhB3chrMN4blfYrmAfJ7pHz4lEANNyfd
X-Proofpoint-GUID: HhB3chrMN4blfYrmAfJ7pHz4lEANNyfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxlogscore=925 clxscore=1011 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130139

T24gVGh1LCAyMDI0LTEyLTEyIGF0IDE3OjUyICswODAwLCBaaGVuZyBZZWppYW4gd3JvdGU6DQo+
IE9uIDIwMjQvMTIvMTEgMDQ6NDksIE1hcnRpbiBLZWxseSB3cm90ZToNCj4gPiANCj4gPiANCj4g
PiBaaGVuZywgZG8geW91IHBsYW4gdG8gc2VuZCBhIHYzPyBJJ2QgYmUgaGFwcHkgdG8gaGVscCBv
dXQgd2l0aCB0aGlzDQo+ID4gcGF0Y2ggc2VyaWVzIGlmIHlvdSdkIGxpa2UsIGFzIEknbSBob3Bp
bmcgdG8gZ2V0IHRoaXMgaXNzdWUNCj4gPiByZXNvbHZlZA0KPiA+ICh0aG91Z2ggSSBhbSBub3Qg
YW4gZnRyYWNlIGV4cGVydCkuDQo+IA0KPiBTb3JyeSB0byByZWx5IHNvIGxhdGUuIFRoYW5rcyBm
b3IgeW91ciBmZWVkYmFjayENCj4gDQo+IFN0ZXZlIHJlY2VudGx5IHN0YXJ0ZWQgYSBkaXNjdXNz
aW9uIG9mIHRoZSBpc3N1ZSBpbjoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MTAxNTEwMDExMS4zN2FkZmIyOEBnYW5kYWxmLmxvY2FsLmhvbWUvDQo+IGJ1dCB0aGVyZSdz
IG5vIGNvbmNsdXNpb24uDQo+IMKgIA0KPiBJIGNhbiByZWJhc2UgdGhpcyBwYXRjaCBzZXJpZXMg
YW5kIHNlbmQgYSBuZXcgdmVyc2lvbiBmaXJzdCwgYW5kDQo+IEknbSBhbHNvIGhvcGluZyB0byBn
ZXQgbW9yZSBmZWVkYmFja3MgYW5kIGhlbHAgdG8gcmVzb2x2ZSB0aGUgaXNzdWUuDQo+IA0KDQpI
aSBaaGVuZywNCg0KSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kLCBidXQgYmFzZWQgb24gdGhlIGZp
bmFsIG1lc3NhZ2UgZnJvbSBTdGV2ZW4sIEkNCmdvdCB0aGUgc2Vuc2UgdGhhdCB0aGUgaWRlYSBs
aXN0ZWQgaW4gdGhhdCB0aHJlYWQgZGlkbid0IHdvcmsgb3V0IGFuZA0Kd2Ugc2hvdWxkIHByb2Nl
ZWQgd2l0aCB5b3VyIGN1cnJlbnQgYXBwcm9hY2guDQoNClBsZWFzZSBjb25zaWRlciBtZSBhbiBp
bnRlcmVzdGVkIHBhcnR5IGZvciB0aGlzIHBhdGNoIHNlcmllcywgYW5kIGxldA0KbWUga25vdyBp
ZiB0aGVyZSdzIGFueXRoaW5nIEkgY2FuIGRvIHRvIGhlbHAgc3BlZWQgaXQgYWxvbmcgKGNvLQ0K
ZGV2ZWxvcCwgdGVzdCwgYW55dGhpbmcgZWxzZSkuIEFuZCBvZiBjb3Vyc2UsIHRoYW5rcyB2ZXJ5
IG11Y2ggZm9yIHlvdXINCndvcmsgdGh1cyBmYXIhDQo=

