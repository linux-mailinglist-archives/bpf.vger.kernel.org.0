Return-Path: <bpf+bounces-41613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E49991C7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9984AB2C2F5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31B1CFEC4;
	Thu, 10 Oct 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="hV583S13"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66741CFEA4
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586691; cv=none; b=AOPoAak62LZ2OWLy/nJ/5h07gTsnzT3RQa+wajIyCPCGZLhGNU+/xmJPZFu99g/1HM5VN1vX1CLLhEOzh13LqPLp43PANcMFCsFTbn8I9PGEFF/V5Tt+1t2gXIRTla7OwDx0RWPPC4bX1dopCCS9GLqtZtgYddT1GzwGXQ/8Xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586691; c=relaxed/simple;
	bh=iwTxt2+tCUI7/GsuUxAwOfyjpa7Kg8YlsCGaqH4cHII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQbi6CEBf+JBq+En6+EMoHQAmPDqRKvwOfGflFmyQJ1tM7tHZlMCzCuRThxOakh+xvJgbq4ktwQtaC9XYxVPAxGgtSw77nJPQN6AroRPY3tjtcL/hwldXwHdxVGKjoZ1GKICCBl2lddNpKd0XM/HPTQuG0XelHuok2Eeu3IlXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=hV583S13; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHFvub026172;
	Thu, 10 Oct 2024 18:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=iwTxt2+tCUI7/GsuUxAwOfyjpa7Kg8YlsCGaqH4cHII=; b=h
	V583S13CqyxRM8ZefYtIFwcWXjSwD/CQfYLqGEkTFx1e0Jol4ZKQrxTdyo37jR26
	kFJLSVwQlWWwxxRq6cUCNpcIWZbmuCGkHUNQWEqa1uqBBZz/QjfvsjF76OwcfA5/
	Y0UOvH54VAwh/MAyfXSwXkhhI4BxIV0N7Jwztw7pf63ujhyY+qos3bNSGx2vX5X5
	XaWe+q6AHSPLyjPMe8KmMNHEbj17v+0/Zx2s5bsMkdyz/UKex9vVr4LXSb3PX7XA
	IuD7IwVPO1CbdU3zf+hc0qIf6Viyd+9Jtu0jAs4O87/izTq9xY5hBJRdjmdjA1NT
	SfSGYD5IPL3lmXEPbXPVg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 426fuys1b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 18:57:47 +0000 (GMT)
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 18:57:46 +0000
Received: from 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc]) by
 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc%9]) with mapi id
 15.02.1544.009; Thu, 10 Oct 2024 18:57:46 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: update docs on
 CONFIG_FUNCTION_ERROR_INJECTION
Thread-Topic: [PATCH bpf-next] bpf: update docs on
 CONFIG_FUNCTION_ERROR_INJECTION
Thread-Index: AQHbG0ZL9Vj/p8x43EOLydJsAAj4vg==
Date: Thu, 10 Oct 2024 18:57:46 +0000
Message-ID: <e4207aaa1cfbb00b3cb73d2a77c04623ca34a40b.camel@crowdstrike.com>
References: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
	 <CAADnVQ+=eb7V6EYYZXghOCqYHcuP4=uNL2DtVghK-7WOHJa0Jw@mail.gmail.com>
In-Reply-To: <CAADnVQ+=eb7V6EYYZXghOCqYHcuP4=uNL2DtVghK-7WOHJa0Jw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <13D11A956101DF4982EB03AC7548A711@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-GUID: n6Wg92mFb8yLMWTZHe7bwUJUEUmAVGX4
X-Authority-Analysis: v=2.4 cv=I8o3R8gg c=1 sm=1 tr=0 ts=670823ab cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=pl6vuDidAAAA:8 a=rSCPWcgRQ5dir6CnJzYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n6Wg92mFb8yLMWTZHe7bwUJUEUmAVGX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=786 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100125

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDExOjU0IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFRodSwgT2N0IDEwLCAyMDI0IGF0IDExOjQ34oCvQU0gTWFydGluIEtlbGx5DQo+
IDxtYXJ0aW4ua2VsbHlAY3Jvd2RzdHJpa2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGUgZG9j
dW1lbnRhdGlvbiBzYXlzIENPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT04gaXMgc3VwcG9y
dGVkDQo+ID4gb25seQ0KPiA+IG9uIHg4Ni4gVGhpcyB3YXMgcHJlc3VtYWJseSB0cnVlIGF0IHRo
ZSB0aW1lIG9mIHdyaXRpbmcsIGJ1dCBpdCdzDQo+ID4gbm93DQo+ID4gc3VwcG9ydGVkIG9uIG1h
bnkgb3RoZXIgYXJjaGl0ZWN0dXJlcyB0b28sIHNvIGRyb3AgdGhlIHBhcnQgb2YgdGhlDQo+ID4g
c3RhdGVtZW50IG1lbnRpb25pbmcgeDg2Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcnRp
biBLZWxseSA8bWFydGluLmtlbGx5QGNyb3dkc3RyaWtlLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGlu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8IDMgKy0tDQo+ID4gwqB0b29scy9p
bmNsdWRlL3VhcGkvbGludXgvYnBmLmggfCAzICstLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+IGlu
ZGV4IDhhYjRkODE4NGI5ZC4uYTJkZGZjOGM4ZWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
dWFwaS9saW51eC9icGYuaA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+
IEBAIC0zMTA1LDggKzMxMDUsNyBAQCB1bmlvbiBicGZfYXR0ciB7DQo+ID4gwqAgKsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqKkFMTE9XX0VSUk9SX0lOSkVDVElPTioqIGluIHRoZSBrZXJuZWwg
Y29kZS4NCj4gPiDCoCAqDQo+ID4gwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBbHNvLCB0
aGUgaGVscGVyIGlzIG9ubHkgYXZhaWxhYmxlIGZvciB0aGUNCj4gPiBhcmNoaXRlY3R1cmVzIGhh
dmluZw0KPiA+IC0gKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aGUgQ09ORklHX0ZVTkNUSU9O
X0VSUk9SX0lOSkVDVElPTiBvcHRpb24uIEFzIG9mDQo+ID4gdGhpcyB3cml0aW5nLA0KPiA+IC0g
KsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ODYgYXJjaGl0ZWN0dXJlIGlzIHRoZSBvbmx5IG9u
ZSB0byBzdXBwb3J0IHRoaXMNCj4gPiBmZWF0dXJlLg0KPiA+ICsgKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0aGUgQ09ORklHX0ZVTkNUSU9OX0VSUk9SX0lOSkVDVElPTiBvcHRpb24uDQo+IA0K
PiBTb21ldGhpbmcgbGlrZSB0aGlzIGlzIGdvb2QgdG8gYWRkIHRvDQo+IERvY3VtZW50YXRpb24v
ZmF1bHQtaW5qZWN0aW9uL2ZhdWx0LWluamVjdGlvbi5yc3QNCj4gYW5kIG1heSBiZSBhIGxpbmsg
dG8gaXQgc29tZXdoZXJlIGluIERvY3VtZW50YXRpb24vYnBmLy4NCj4gDQo+IEJ1dCB1YXBpL2Jw
Zi5oIGlzIG5vdCBzdWNoIHBsYWNlLg0KPiANCj4gcHctYm90OiBjcg0KDQpXb3VsZCB5b3UgcHJl
ZmVyIHRvIGp1c3QgcmVtb3ZlIHRoZSBzZW50ZW5jZSBhbHRvZ2V0aGVyPyBDdXJyZW50bHksDQp0
aGlzIHN0YXRlbWVudCBpcyBhbHJlYWR5IGluIHRoZSBoZWFkZXJzLCBzbyBJIHRoaW5rIGl0J3Mg
YmVzdCB0bw0KZWl0aGVyIGNvcnJlY3QgaXQgb3IgcmVtb3ZlIGl0LCBidXQgbm90IGxlYXZlIGl0
IHRoZSB3YXkgaXQgaXMgKHdoaWNoDQppcyBub3QgdmVyeSBhY2N1cmF0ZSkuDQo=

