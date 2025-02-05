Return-Path: <bpf+bounces-50533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7DEA29679
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA7F7A20CC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648961DDA32;
	Wed,  5 Feb 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YHeV919j"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A31DAC95;
	Wed,  5 Feb 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773388; cv=none; b=Vv9lO7D7hmk+yrk5qnJQnKNH0zwi3ZZSrQqX0Ce8XNagW1Sx9UzWD7stdNQgB4vDrpO/rqOyg4Xv0wDLjzPcY13H+DiVFPhwbknt3NTFdYIWwrXYPNEQmHOdtS+Q7XAJSb6PQ+mXzS2QHP8yl4r//KblKT9yoVW2XFGDRD7tm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773388; c=relaxed/simple;
	bh=KQAjdNXPn0DfadHsCm5XjQMXRiXHNgA7KxiZn4px+3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XRN1k6SwbqPu8djkomJyb0EyCRP6d5ISSuhqfMktTtYuxgrUOgUcbiReyXFvhHMY19WiEIyb9dd4UMMEk97If2qQeQa0N8jIZhBkPQR9SGffDwqODFW5E0/kqyQPgYXfT3+arvCVUuehY/t3xPRc/h9zqieLThb3fkB+akjL4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YHeV919j; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515FQCIx024083;
	Wed, 5 Feb 2025 16:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=KQAjdNXPn0DfadHsCm5XjQMXRiXHNgA7KxiZn4px+3o=; b=Y
	HeV919jwJAKBcZ9DZYoJZ746xXdNm2KJ++Nw6WaGqiiyhKDtNfUghTJeY3x/Qdm1
	lPWXA1t9+oHuXjf8cHgfQFjGwqxzeOhJpV7fzoOSniIPt31uwiTe9145bBzlynWl
	B1pDyp8D9OLUl38VgOHHHQ6QiUTE1GZrTm2iPvXQWn2qZgzIj2tDY+wM8LyHho4a
	R945pTtGxTRlhDd7gTWdJiB7wjhwB1X8KYVltOhU6bPZ38VBLAVH1J2HUE5ZgN2x
	8zqbBuD1EX58SrGkQJNzczp6kffEQ1lN8YnFH2Yzu5PuqFNAnOAaorTzcWLBaXnE
	q545s4quSSUrqQNnRl2VA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 44mammg3t0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 16:00:04 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH005.crowdstrike.sys (10.100.11.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 16:00:00 +0000
Received: from 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138]) by
 04WPEXCH006.crowdstrike.sys ([fe80::a97d:6ad:c239:d138%11]) with mapi id
 15.02.1544.009; Wed, 5 Feb 2025 16:00:00 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "masahiroy@kernel.org"
	<masahiroy@kernel.org>,
        "zhengyejian1@huawei.com" <zhengyejian1@huawei.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: Re: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Thread-Topic: Re: [PATCH v2 16/16] scripts/sorttable: ftrace: Do not add weak
 functions to available_filter_functions
Thread-Index: AQHbd+cCrpRl49KJ0EiNa9urqmBbFA==
Date: Wed, 5 Feb 2025 16:00:00 +0000
Message-ID: <c4c7f0931742c8636a82f2ae3b3c492c93266c93.camel@crowdstrike.com>
References: <20250102232609.529842248@goodmis.org>
	 <20250102232651.347490863@goodmis.org>
	 <aba52935dc06a1fe69f05309f5d9828a297ad787.camel@crowdstrike.com>
	 <20250204193559.1f87b4ea@gandalf.local.home>
In-Reply-To: <20250204193559.1f87b4ea@gandalf.local.home>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0BB0A2C680BEB4980905CE6486592F2@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 6e_pcGkFVcXTbb8vvYC3lg2INop8zK62
X-Authority-Analysis: v=2.4 cv=NvQrc9dJ c=1 sm=1 tr=0 ts=67a38b04 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=pl6vuDidAAAA:8 a=lqAKrMhzrGgqgS63txUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6e_pcGkFVcXTbb8vvYC3lg2INop8zK62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 mlxlogscore=949
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502050124

T24gVHVlLCAyMDI1LTAyLTA0IGF0IDE5OjM1IC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gV2VkLCA1IEZlYiAyMDI1IDAwOjEzOjI2ICswMDAwDQo+IE1hcnRpbiBLZWxseSA8bWFy
dGluLmtlbGx5QGNyb3dkc3RyaWtlLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEknbSBub3QgbmVjZXNz
YXJpbHkgYSBxdWFsaWZpZWQgcmV2aWV3ZXIgZm9yIHRoaXMgcGF0Y2gsIGJ1dCBJJ20NCj4gPiB2
ZXJ5DQo+ID4gaW50ZXJlc3RlZCBpbiBzZWVpbmcgaXQgb3IgYSBzaW1pbGFyIHNvbHV0aW9uIGdl
dCBtZXJnZWQsIGFzIHRoZQ0KPiA+IGltcGFjdA0KPiA+IHdoZW4gaXQgaGl0cyBpcyBzaWduaWZp
Y2FudCAoc2lsZW50IGZhaWx1cmUpIGFuZCBub3QgZWFzeSB0byBkZXRlY3QNCj4gPiBvcg0KPiA+
IHdvcmsgYXJvdW5kLiBJcyB0aGVyZSBhbnkgb2JzdGFjbGUgbGVmdCBpbiBnZXR0aW5nIHRoaXMg
b25lIG1lcmdlZA0KPiA+IG90aGVyIHRoYW4gZnVydGhlciByZXZpZXdzPw0KPiANCj4gQSB2ZXJz
aW9uIG9mIHRoZSBwYXRjaGVzIDEtMTQgd2FzIG1lcmdlZCB0aGlzIG1lcmdlIHdpbmRvdywgd2l0
aCBzb21lDQo+IHR3ZWFrcy4gSSBwbGFuIG9uIHJlYmFzaW5nIHBhdGNoZXMgMTUgYW5kIDE2IG9u
IHRvcCBvZiB0aGF0IGFuZA0KPiByZXN1Ym1pdHRpbmcuIEkganVzdCBoYXZlIHNvbWUgb3RoZXIg
dGhpbmdzIEknbSBmaW5pc2hpbmcgdXAuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtLSBTdGV2ZQ0K
DQpBd2Vzb21lLCB0aGFua3MhDQo=

