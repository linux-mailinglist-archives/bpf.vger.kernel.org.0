Return-Path: <bpf+bounces-41617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2D99926B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DB1F25D98
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13B1CF29E;
	Thu, 10 Oct 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="wjENIJtr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927C19DFA2
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588893; cv=none; b=Bi/RNExtV18ligaTT8ftnDTh1jA/t7ivfQdm3sHEu2fihSxLuTFEUuzdtrtU2Lmb8b49DvHUVl8KMyMvZ6RlKNwBGQztGRm/uganlQAhj37trNHM+mjM2F7XIGIUjK3yHNHLp4fvvPBTWyAm5Gdm6gq9FQGUIr0Wxs4b8i5qP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588893; c=relaxed/simple;
	bh=GZX3uz/a3NTcX3DrAUxwXyXX/OSe3A+XpDTEkT3o/Tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wl8W0QqsH/TsEtPZwtawp5yNTEc3hmhka4zebqNyX8RZj6a6mTHtsiL8K8oUKpOVciyQbNHhZMunMXGUj7cQKuRmVwp3fFjUS06ut/web9fgOPdVp7hQQrux6494A/50PlRq5Pyn1pdiQHOzWhxOiM4HegpCC6LlYlKrrEM2pKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=wjENIJtr; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AIX7FA014157;
	Thu, 10 Oct 2024 19:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-id:content-transfer-encoding:content-type:date
	:from:in-reply-to:message-id:mime-version:references:subject:to;
	 s=default; bh=GZX3uz/a3NTcX3DrAUxwXyXX/OSe3A+XpDTEkT3o/Tk=; b=w
	jENIJtr/OOQ97IHwT6xiXARc95Kck5fG3gNMiRXWfO0rp5pBILqR94JyfoYSK93o
	OpbjMGvUVetfFvQFcVRY9hXQOZAwKCVnSPkQWI1RvmJ7dFd4JPnk594idSsIfaI4
	Zk7pUeUvQhAsKU6kD5G0/FxQ/QafVUVIJJoHcEmUQiQcKov9svMj9pObwFF+PhFH
	akjJy5vnID3azZzv+1CSuVHVu+iVP5m4gvQ5EjQDCdvkWPOrS3yjRk5ImOKunqpw
	D3pBHzTbZ2PZJHT0WDeRIDsqu7CyZsh9YFgDpM7kDFt+0aJRQDZXCOWRLkM9ePpd
	eK2Omy9eyMKkY1MMzxboA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 426bss9pg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 19:34:29 +0000 (GMT)
Received: from 04wpexch06.crowdstrike.sys (10.100.11.99) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 19:34:28 +0000
Received: from 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc]) by
 04wpexch06.crowdstrike.sys ([fe80::d7a2:a8e9:1f62:58cc%9]) with mapi id
 15.02.1544.009; Thu, 10 Oct 2024 19:34:28 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC: "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [External] Re: [PATCH bpf-next] bpf: update docs on
 CONFIG_FUNCTION_ERROR_INJECTION
Thread-Topic: [External] Re: [PATCH bpf-next] bpf: update docs on
 CONFIG_FUNCTION_ERROR_INJECTION
Thread-Index: AQHbG0ZL9Vj/p8x43EOLydJsAAj4vrKAWJkAgAAHsQA=
Date: Thu, 10 Oct 2024 19:34:28 +0000
Message-ID: <38f24c8803639d14c955da40205a44ee4a2ac45f.camel@crowdstrike.com>
References: <20241010184556.985660-1-martin.kelly@crowdstrike.com>
	 <CAADnVQ+=eb7V6EYYZXghOCqYHcuP4=uNL2DtVghK-7WOHJa0Jw@mail.gmail.com>
	 <e4207aaa1cfbb00b3cb73d2a77c04623ca34a40b.camel@crowdstrike.com>
	 <CAADnVQ+CkMuDx6oheKABR7esjeo-A=szAOLM-0MbaJnfTsqZ5A@mail.gmail.com>
In-Reply-To: <CAADnVQ+CkMuDx6oheKABR7esjeo-A=szAOLM-0MbaJnfTsqZ5A@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-disclaimer: USA
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE20D1C7E62ED4CABA1DFD97E381412@crowdstrike.sys>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: oo2J-2EV1C3VWVKZmNH6qWN6WDqDKgtT
X-Authority-Analysis: v=2.4 cv=K6FwHDWI c=1 sm=1 tr=0 ts=67082c46 cx=c_pps a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17 a=xqWC_Br6kY4A:10 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=pl6vuDidAAAA:8 a=G9qKUTHDGM5LUaA1JoMA:9
 a=QEXdDO2ut3YA:10 a=OQ9wDFn-JVknq3Hth19w:22
X-Proofpoint-GUID: oo2J-2EV1C3VWVKZmNH6qWN6WDqDKgtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=956 clxscore=1015
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100128

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDEyOjA2IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFRodSwgT2N0IDEwLCAyMDI0IGF0IDExOjU34oCvQU0gTWFydGluIEtlbGx5DQo+
IDxtYXJ0aW4ua2VsbHlAY3Jvd2RzdHJpa2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUs
IDIwMjQtMTAtMTAgYXQgMTE6NTQgLTA3MDAsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4g
PiA+IE9uIFRodSwgT2N0IDEwLCAyMDI0IGF0IDExOjQ34oCvQU0gTWFydGluIEtlbGx5DQo+ID4g
PiA8bWFydGluLmtlbGx5QGNyb3dkc3RyaWtlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4g
PiBUaGUgZG9jdW1lbnRhdGlvbiBzYXlzIENPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT04g
aXMNCj4gPiA+ID4gc3VwcG9ydGVkDQo+ID4gPiA+IG9ubHkNCj4gPiA+ID4gb24geDg2LiBUaGlz
IHdhcyBwcmVzdW1hYmx5IHRydWUgYXQgdGhlIHRpbWUgb2Ygd3JpdGluZywgYnV0DQo+ID4gPiA+
IGl0J3MNCj4gPiA+ID4gbm93DQo+ID4gPiA+IHN1cHBvcnRlZCBvbiBtYW55IG90aGVyIGFyY2hp
dGVjdHVyZXMgdG9vLCBzbyBkcm9wIHRoZSBwYXJ0IG9mDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBz
dGF0ZW1lbnQgbWVudGlvbmluZyB4ODYuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXJ0aW4gS2VsbHkgPG1hcnRpbi5rZWxseUBjcm93ZHN0cmlrZS5jb20+DQo+ID4gPiA+IC0t
LQ0KPiA+ID4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8IDMgKy0t
DQo+ID4gPiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHwgMyArLS0NCj4gPiA+
ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4g
PiA+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiA+ID4gaW5kZXggOGFiNGQ4MTg0
YjlkLi5hMmRkZmM4YzhlZDkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51
eC9icGYuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiA+ID4g
QEAgLTMxMDUsOCArMzEwNSw3IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4gPiA+ID4gwqAgKsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqKkFMTE9XX0VSUk9SX0lOSkVDVElPTioqIGluIHRoZSBrZXJu
ZWwgY29kZS4NCj4gPiA+ID4gwqAgKg0KPiA+ID4gPiDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEFsc28sIHRoZSBoZWxwZXIgaXMgb25seSBhdmFpbGFibGUgZm9yIHRoZQ0KPiA+ID4gPiBh
cmNoaXRlY3R1cmVzIGhhdmluZw0KPiA+ID4gPiAtICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dGhlIENPTkZJR19GVU5DVElPTl9FUlJPUl9JTkpFQ1RJT04gb3B0aW9uLiBBcw0KPiA+ID4gPiBv
Zg0KPiA+ID4gPiB0aGlzIHdyaXRpbmcsDQo+ID4gPiA+IC0gKsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB4ODYgYXJjaGl0ZWN0dXJlIGlzIHRoZSBvbmx5IG9uZSB0byBzdXBwb3J0DQo+ID4gPiA+
IHRoaXMNCj4gPiA+ID4gZmVhdHVyZS4NCj4gPiA+ID4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRoZSBDT05GSUdfRlVOQ1RJT05fRVJST1JfSU5KRUNUSU9OIG9wdGlvbi4NCj4gPiA+IA0K
PiA+ID4gU29tZXRoaW5nIGxpa2UgdGhpcyBpcyBnb29kIHRvIGFkZCB0bw0KPiA+ID4gRG9jdW1l
bnRhdGlvbi9mYXVsdC1pbmplY3Rpb24vZmF1bHQtaW5qZWN0aW9uLnJzdA0KPiA+ID4gYW5kIG1h
eSBiZSBhIGxpbmsgdG8gaXQgc29tZXdoZXJlIGluIERvY3VtZW50YXRpb24vYnBmLy4NCj4gPiA+
IA0KPiA+ID4gQnV0IHVhcGkvYnBmLmggaXMgbm90IHN1Y2ggcGxhY2UuDQo+ID4gPiANCj4gPiA+
IHB3LWJvdDogY3INCj4gPiANCj4gPiBXb3VsZCB5b3UgcHJlZmVyIHRvIGp1c3QgcmVtb3ZlIHRo
ZSBzZW50ZW5jZSBhbHRvZ2V0aGVyPyBDdXJyZW50bHksDQo+ID4gdGhpcyBzdGF0ZW1lbnQgaXMg
YWxyZWFkeSBpbiB0aGUgaGVhZGVycywgc28gSSB0aGluayBpdCdzIGJlc3QgdG8NCj4gPiBlaXRo
ZXIgY29ycmVjdCBpdCBvciByZW1vdmUgaXQsIGJ1dCBub3QgbGVhdmUgaXQgdGhlIHdheSBpdCBp
cw0KPiA+ICh3aGljaA0KPiA+IGlzIG5vdCB2ZXJ5IGFjY3VyYXRlKS4NCj4gDQo+IEkgc2F5IGxl
dCdzIHJlbW92ZSB0aGUgd2hvbGUgcGFyYWdyYXBoIHRoZW4uDQo+IA0KPiAuaCBhbHJlYWR5IHNh
eXMNCj4gIkl0IGlzIG9ubHkgYXZhaWxhYmxlIGlmIHRoZSBrZXJuZWwgd2FzIGNvbXBpbGVkDQo+
IMKgd2l0aCB0aGUgKipDT05GSUdfQlBGX0tQUk9CRV9PVkVSUklERSoqIGNvbmZpZ3VyYXRpb24N
Cj4gwqBvcHRpb24sIg0KPiANCj4gd2hpY2ggaW4gdHVybiBkZXBlbmRzIG9uOg0KPiANCj4gY29u
ZmlnIEJQRl9LUFJPQkVfT1ZFUlJJREUNCj4gwqDCoMKgwqDCoMKgwqAgYm9vbCAiRW5hYmxlIEJQ
RiBwcm9ncmFtcyB0byBvdmVycmlkZSBhIGtwcm9iZWQgZnVuY3Rpb24iDQo+IMKgwqDCoMKgwqDC
oMKgIGRlcGVuZHMgb24gQlBGX0VWRU5UUw0KPiDCoMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIEZV
TkNUSU9OX0VSUk9SX0lOSkVDVElPTg0KPiANCj4gTm8gbmVlZCB0byBkdXBsaWNhdGUga2NvbmZp
ZyBkZXBlbmRlbmNpZXMgYXMgYSBkb2MgaW4gLmgNCg0KQWdyZWVkLiBJIHNlbnQgYSB2MiB3aXRo
IHRoZSBwYXJhZ3JhcGggcmVtb3ZlZC4NCg==

