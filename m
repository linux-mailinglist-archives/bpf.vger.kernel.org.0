Return-Path: <bpf+bounces-70973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B7FBDD5A8
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 10:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E989188074E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51662D9EE6;
	Wed, 15 Oct 2025 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="ZQFEL+RV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFC239E7D;
	Wed, 15 Oct 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516462; cv=none; b=cSse+qE0LUjYmaNalXqGxo6wTpWyF97WEJvzyGQ/WKqd2sYH8/RQH+E4C3HhfB+70LTQwGf02OYZpoO/tU0goOzT71GMlPElZLTZFjHVVMYxymFqiBwUuxKnKeEzIactqNwF/dH3SkUbUSAbMuNmPMVJ+xylXjG1Jod2LCayofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516462; c=relaxed/simple;
	bh=6Y9OWvGkDg6udQj9djR1XfdCUChWLBwBawqaHBCUZaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRyLCZTnMWshXhjRMPhv5IzNIEyNaKVHZVkmLazRBWvshS2prQIV6MXhUJzMK2nUsF9u80hXdk3pKp7wPTCyp/VzVu8yXrMCmjq5rHGOCLhD6ehE/yYq7Nxuj2N4Pay+QMMKwr6Ig1EZIpHsMjmZzoVxr/MtY3aSujy8F8RpX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=ZQFEL+RV; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 95EF310D5E84;
	Wed, 15 Oct 2025 11:12:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 95EF310D5E84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1760515940; bh=6Y9OWvGkDg6udQj9djR1XfdCUChWLBwBawqaHBCUZaU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZQFEL+RVTDeVYNBc2ZKlpkhCH01BExjbcWXu+SvB/q+dUrhs4OIEtD4JiVSEw+K41
	 IcooUfzZ5phrf2eisHx0HYNB27wZjJPgh4ia/i/tcWu1gbTQwbxBIqU/v9IwUKVz/7
	 A9B4fRA3hbpzui70dcV0XMqO9rZqSMLO4wZYV7xM=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 9240E30CD6E5;
	Wed, 15 Oct 2025 11:12:20 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>
CC: Song Yoong Siang <yoong.siang.song@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH net v2] xsk: Fix overflow in descriptor
 validation
Thread-Topic: [lvc-project] [PATCH net v2] xsk: Fix overflow in descriptor
 validation
Thread-Index: AQHcN5OdnXCPK8VDDEqW23qLq6U3NbTCtWYA
Date: Wed, 15 Oct 2025 08:12:20 +0000
Message-ID: <9e946bb9-2629-485e-ae89-5aa8c4930a4d@infotecs.ru>
References: <20251007140645.3199133-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20251007140645.3199133-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <A836548593C0764CAC3250F390BF7D56@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/10/15 07:33:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/15 04:14:00 #27914565
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTAvNy8yNSAxNzowNiwgSWxpYSBHYXZyaWxvdiB3cm90ZToNCj4gVGhlIGRlc2MtPmxlbiB2
YWx1ZSBjYW4gYmUgc2V0IHVwIHRvIFUzMl9NQVguIElmIHVtZW0gdHhfbWV0YWRhdGFfbGVuDQo+
IG9wdGlvbiBpcyBhbHNvIHNldCwgdGhlIHZhbHVlIG9mIHRoZSBleHByZXNzaW9uDQo+ICdkZXNj
LT5sZW4gKyBwb29sLT50eF9tZXRhZGF0YV9sZW4nIGNhbiBvdmVyZmxvdyBhbmQgdmFsaWRhdGlv
bg0KPiBvZiB0aGUgaW5jb3JyZWN0IGRlc2NyaXB0b3Igd2lsbCBiZSBzdWNjZXNzZnVsbHkgcGFz
c2VkLg0KPiBUaGlzIGNhbiBsZWFkIHRvIGEgc3Vic2VxdWVudCBjaGFpbiBvZiBhcml0aG1ldGlj
IG92ZXJmbG93cw0KPiBpbiB0aGUgeHNrX2J1aWxkX3NrYigpIGZ1bmN0aW9uIGFuZCBpbmNvcnJl
Y3Qgc2tfYnVmZiBhbGxvY2F0aW9uLg0KPiANCj4gVG8gcmVwcm9kdWNlIHRoZSBvdmVyZmxvdywg
dGhpcyBwaWVjZSBvZiB1c2Vyc3BhY2UgY29kZSBjYW4gYmUgdXNlZDoNCj4gICAgICAgIHN0cnVj
dCB4ZHBfdW1lbV9yZWcgdW1lbV9yZWc7DQo+ICAgICAgICB1bWVtX3JlZy5hZGRyID0gKF9fdTY0
KSh2b2lkICopdW1lbTsNCj4gICAgICAgIC4uLg0KPiAgICAgICAgdW1lbV9yZWcuY2h1bmtfc2l6
ZSA9IDQwOTY7DQo+ICAgICAgICB1bWVtX3JlZy50eF9tZXRhZGF0YV9sZW4gPSAxNjsNCj4gICAg
ICAgIHVtZW1fcmVnLmZsYWdzID0gWERQX1VNRU1fVFhfTUVUQURBVEFfTEVOOw0KPiAgICAgICAg
c2V0c29ja29wdChzZmQsIFNPTF9YRFAsIFhEUF9VTUVNX1JFRywgJnVtZW1fcmVnLCBzaXplb2Yo
dW1lbV9yZWcpKTsNCj4gICAgICAgIC4uLg0KPiANCj4gICAgICAgIHhza19yaW5nX3Byb2RfX3Jl
c2VydmUodHEsIGJhdGNoX3NpemUsICZpZHgpOw0KPiANCj4gICAgICAgIGZvciAoaSA9IDA7IGkg
PCBucl9wYWNrZXRzOyArK2kpIHsNCj4gICAgICAgICAgICAgICAgc3RydWN0IHhkcF9kZXNjICp0
eF9kZXNjID0geHNrX3JpbmdfcHJvZF9fdHhfZGVzYyh0cSwgaWR4ICsgaSk7DQo+ICAgICAgICAg
ICAgICAgIHR4X2Rlc2MtPmFkZHIgPSBwYWNrZXRzW2ldLmFkZHI7DQo+ICAgICAgICAgICAgICAg
IHR4X2Rlc2MtPmFkZHIgKz0gdW1lbS0+dHhfbWV0YWRhdGFfbGVuOw0KPiAgICAgICAgICAgICAg
ICB0eF9kZXNjLT5vcHRpb25zID0gWERQX1RYX01FVEFEQVRBOw0KPiAgICAgICAgICAgICAgICB0
eF9kZXNjLT5sZW4gPSBVSU5UMzJfTUFYOw0KPiAgICAgICAgfQ0KPiANCj4gICAgICAgIHhza19y
aW5nX3Byb2RfX3N1Ym1pdCh0cSwgbnJfcGFja2V0cyk7DQo+ICAgICAgICAuLi4NCj4gICAgICAg
IHNlbmR0byhzZmQsIE5VTEwsIDAsIE1TR19ET05UV0FJVCwgTlVMTCwgMCk7DQo+IA0KPiBGb3Vu
ZCBieSBJbmZvVGVDUyBvbiBiZWhhbGYgb2YgTGludXggVmVyaWZpY2F0aW9uIENlbnRlcg0KPiAo
bGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCj4gDQo+IEZpeGVzOiAzNDFhYzk4MGVhYjkg
KCJ4c2s6IFN1cHBvcnQgdHhfbWV0YWRhdGFfbGVuIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogSWxpYSBHYXZyaWxvdiA8SWxpYS5HYXZyaWxvdkBpbmZv
dGVjcy5ydT4NCj4gLS0tDQo+IHYyOiBBZGQgYSByZXBybw0KPiAgbmV0L3hkcC94c2tfcXVldWUu
aCB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQveGRwL3hza19xdWV1ZS5oIGIvbmV0L3hkcC94
c2tfcXVldWUuaA0KPiBpbmRleCBmMTZmMzkwMzcwZGMuLmIyMDZhODgzOWIzOSAxMDA2NDQNCj4g
LS0tIGEvbmV0L3hkcC94c2tfcXVldWUuaA0KPiArKysgYi9uZXQveGRwL3hza19xdWV1ZS5oDQo+
IEBAIC0xNDQsNyArMTQ0LDcgQEAgc3RhdGljIGlubGluZSBib29sIHhwX2FsaWduZWRfdmFsaWRh
dGVfZGVzYyhzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwNCj4gIAkJCQkJICAgIHN0cnVjdCB4
ZHBfZGVzYyAqZGVzYykNCj4gIHsNCj4gIAl1NjQgYWRkciA9IGRlc2MtPmFkZHIgLSBwb29sLT50
eF9tZXRhZGF0YV9sZW47DQo+IC0JdTY0IGxlbiA9IGRlc2MtPmxlbiArIHBvb2wtPnR4X21ldGFk
YXRhX2xlbjsNCj4gKwl1NjQgbGVuID0gKHU2NClkZXNjLT5sZW4gKyBwb29sLT50eF9tZXRhZGF0
YV9sZW47DQo+ICAJdTY0IG9mZnNldCA9IGFkZHIgJiAocG9vbC0+Y2h1bmtfc2l6ZSAtIDEpOw0K
PiAgDQo+ICAJaWYgKCFkZXNjLT5sZW4pDQo+IEBAIC0xNjUsNyArMTY1LDcgQEAgc3RhdGljIGlu
bGluZSBib29sIHhwX3VuYWxpZ25lZF92YWxpZGF0ZV9kZXNjKHN0cnVjdCB4c2tfYnVmZl9wb29s
ICpwb29sLA0KPiAgCQkJCQkgICAgICBzdHJ1Y3QgeGRwX2Rlc2MgKmRlc2MpDQo+ICB7DQo+ICAJ
dTY0IGFkZHIgPSB4cF91bmFsaWduZWRfYWRkX29mZnNldF90b19hZGRyKGRlc2MtPmFkZHIpIC0g
cG9vbC0+dHhfbWV0YWRhdGFfbGVuOw0KPiAtCXU2NCBsZW4gPSBkZXNjLT5sZW4gKyBwb29sLT50
eF9tZXRhZGF0YV9sZW47DQo+ICsJdTY0IGxlbiA9ICh1NjQpZGVzYy0+bGVuICsgcG9vbC0+dHhf
bWV0YWRhdGFfbGVuOw0KPiAgDQo+ICAJaWYgKCFkZXNjLT5sZW4pDQo+ICAJCXJldHVybiBmYWxz
ZTsNCg0KSGksIEFsZXhhbmRlciwgTWFnbnVzIQ0KDQpJJ20gc29ycnkgdG8gYm90aGVyIHlvdS4N
CldpbGwgdGhpcyBwYXRjaCBiZSBhcHBsaWVkIG9yIHJlamVjdGVkPw0K

