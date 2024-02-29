Return-Path: <bpf+bounces-23089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044386D674
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302B41F23922
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F76D534;
	Thu, 29 Feb 2024 21:59:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833E74C0C
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243951; cv=none; b=RcZspNhM1ADdIm4yV3Eu/dfcmG0XRh74Mpk6ZKqoVUFghNrMJztSB8YBT++aAR52iT+1Q2DXgW+UydgrYf7ddzUuWLKh6elm9h+esrDfdu9DZxRKgsPyGAIthK6XF/VJFg4JBqnU4ayOyLWimdrLTi9bNxIsLsHzfL1+/DmlMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243951; c=relaxed/simple;
	bh=uWXPeF56vr/v339KwbfxnISPdQpiF1+3ZeqWCZRFH/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=g8vXyD/q0EIZ7ExiHmFgjEdU3fKtyykScs0K4tSxept04/ipTusYpp5gs+2t778VwYO7heEB8FVulh/JoOo2hpSIhf0mXOU9kz0IDhGIqnJzz1j0TeUN1SzJvNpT8RohCo3SVTUQGQ4bJrJfZWQKnYBq98KiaXP+n8IPTDVh8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-NmCmjom7Nua_ep9rNF_b0w-1; Thu, 29 Feb 2024 21:59:07 +0000
X-MC-Unique: NmCmjom7Nua_ep9rNF_b0w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Feb
 2024 21:59:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Feb 2024 21:59:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ian Rogers' <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>,
	"Yang Jihong" <yangjihong1@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [PATCH v1 4/6] perf threads: Move threads to its own files
Thread-Topic: [PATCH v1 4/6] perf threads: Move threads to its own files
Thread-Index: AQHaaU4SKMfy+yjiXUyp7JFHrIJbDLEh4dlA
Date: Thu, 29 Feb 2024 21:59:05 +0000
Message-ID: <b60c7731b8a84e01a77fea55c31a77b9@AcuMS.aculab.com>
References: <20240214063708.972376-1-irogers@google.com>
 <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
In-Reply-To: <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogSWFuIFJvZ2Vycw0KPiBTZW50OiAyNyBGZWJydWFyeSAyMDI0IDA3OjI0DQo+IA0KPiBP
biBNb24sIEZlYiAyNiwgMjAyNCBhdCAxMTowN+KAr1BNIE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdA
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEZlYiAxMywgMjAyNCBhdCAxMDoz
N+KAr1BNIElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+
ID4gTW92ZSB0aHJlYWRzIG91dCBvZiBtYWNoaW5lIGFuZCBtb3ZlIHRocmVhZF9yYl9ub2RlIGlu
dG8gdGhlIEMNCj4gPiA+IGZpbGUuIFRoaXMgaGlkZXMgdGhlIGltcGxlbWVudGF0aW9uIG9mIHRo
cmVhZHMgZnJvbSB0aGUgcmVzdCBvZiB0aGUNCj4gPiA+IGNvZGUgYWxsb3dpbmcgZm9yIGl0IHRv
IGJlIHJlZmFjdG9yZWQuDQo+ID4gPg0KPiA+ID4gTG9ja2luZyBkaXNjaXBsaW5lIGlzIHRpZ2h0
ZW5lZCB1cCBpbiB0aGlzIGNoYW5nZS4NCj4gPg0KPiA+IERvZXNuJ3QgbG9vayBsaWtlIGEgc2lt
cGxlIGNvZGUgbW92ZS4gIENhbiB3ZSBzcGxpdCB0aGUgbG9ja2luZw0KPiA+IGNoYW5nZSBmcm9t
IHRoZSBtb3ZlIHRvIG1ha2UgdGhlIHJldmlld2VyJ3MgbGlmZSBhIGJpdCBlYXNpZXI/IDopDQo+
IA0KPiBOb3Qgc3VyZSBJIGZvbGxvdy4gVGFrZSB0aHJlYWRzX25yIGFzIGFuIGV4YW1wbGUuDQo+
IA0KPiBUaGUgb2xkIGNvZGUgaXMgaW4gbWFjaGluZS5jLCBzbzoNCj4gLXN0YXRpYyBzaXplX3Qg
bWFjaGluZV9fdGhyZWFkc19ucihjb25zdCBzdHJ1Y3QgbWFjaGluZSAqbWFjaGluZSkNCj4gLXsN
Cj4gLSAgICAgICBzaXplX3QgbnIgPSAwOw0KPiAtDQo+IC0gICAgICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBUSFJFQURTX19UQUJMRV9TSVpFOyBpKyspDQo+IC0gICAgICAgICAgICAgICBuciArPSBt
YWNoaW5lLT50aHJlYWRzW2ldLm5yOw0KPiAtDQo+IC0gICAgICAgcmV0dXJuIG5yOw0KPiAtfQ0K
PiANCj4gVGhlIG5ldyBjb2RlIGlzIGluIHRocmVhZHMuYzoNCj4gK3NpemVfdCB0aHJlYWRzX19u
cihzdHJ1Y3QgdGhyZWFkcyAqdGhyZWFkcykNCj4gK3sNCj4gKyAgICAgICBzaXplX3QgbnIgPSAw
Ow0KPiArDQo+ICsgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBUSFJFQURTX19UQUJMRV9TSVpF
OyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB0aHJlYWRzX3RhYmxlX2VudHJ5ICp0
YWJsZSA9ICZ0aHJlYWRzLT50YWJsZVtpXTsNCj4gKw0KPiArICAgICAgICAgICAgICAgZG93bl9y
ZWFkKCZ0YWJsZS0+bG9jayk7DQo+ICsgICAgICAgICAgICAgICBuciArPSB0YWJsZS0+bnI7DQo+
ICsgICAgICAgICAgICAgICB1cF9yZWFkKCZ0YWJsZS0+bG9jayk7DQo+ICsgICAgICAgfQ0KPiAr
ICAgICAgIHJldHVybiBucjsNCj4gK30NCj4gDQo+IFNvIGl0IGlzIGEgY29weSBwYXN0ZSBmcm9t
IG9uZSBmaWxlIHRvIHRoZSBvdGhlci4gVGhlIG9ubHkgZGlmZmVyZW5jZQ0KPiBpcyB0aGF0IHRo
ZSBvbGQgY29kZSBmYWlsZWQgdG8gdGFrZSBhIGxvY2sgd2hlbiByZWFkaW5nICJuciIgc28gdGhl
DQo+IGxvY2tpbmcgaXMgYWRkZWQuIEkgd2FudGVkIHRvIG1ha2Ugc3VyZSBhbGwgdGhlIGZ1bmN0
aW9ucyBpbiB0aHJlYWRzLmMNCj4gd2VyZSBwcm9wZXJseSBjb3JyZWN0IHdydCBsb2NraW5nLCBz
ZW1hcGhvcmUgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uLA0KPiBldGMuICBXZSBjb3VsZCBoYXZl
IGEgYnJva2VuIHRocmVhZHMuYyBhbmQgZml4IGl0IGluIHRoZSBuZXh0IGNoYW5nZSwNCj4gYnV0
IGdpdmVuIHRoYXQncyBhIGJ1ZyBpdCBjb3VsZCBtYWtlIGJpc2VjdGlvbiBtb3JlIGRpZmZpY3Vs
dC4NCj4gVWx0aW1hdGVseSBJIHRob3VnaHQgdGhlIGxvY2tpbmcgY2hhbmdlcyB3ZXJlIHNtYWxs
IGVub3VnaCB0byBub3QNCj4gd2FycmFudCBiZWluZyBvbiB0aGVpciBvd24gY29tcGFyZWQgdG8g
dGhlIGFkdmFudGFnZXMgb2YgaGF2aW5nIGEgc2FuZQ0KPiB0aHJlYWRzIGFic3RyYWN0aW9uLg0K
DQpUaGUgbG9jayBpcyBwcmV0dHkgbXVjaCBlbnRpcmVseSBwb2ludGxlc3MuDQpBbGwgaXQgcmVh
bGx5IGRvZXMgaXMgc2xvdyB0aGUgY29kZSBkb3duLg0KVGhlIG1vc3QgeW91IGNvdWxkIHdhbnQg
aXM6DQoJbnIgKz0gUkVBRF9PTkNFKHRhYmxlLT5ucik7DQp0byBhdm9pZCBhbnkgaHlwb3RoZXRp
Y2FsIGRhdGEgdGVhcmluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


