Return-Path: <bpf+bounces-70498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26790BC12E5
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 13:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1BF19A0D31
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0DE2DC333;
	Tue,  7 Oct 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="UHZ07eBF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469B2D979B;
	Tue,  7 Oct 2025 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835972; cv=none; b=qurhNayQFSABBU9OiXFjHrgERN4pMB7NecqGmkEsH5LgcczSx6cBtDWjfmCrVeq9dyJQKTLysQvXjpMR42lfSzVnjMfsfg5l/VuZ2eIimfIfDaxIb+DqmQ0PXronjYg8/WP59xpYPb9lw0Ye9c0VgT8xjnlksVn7UCZTa+AO8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835972; c=relaxed/simple;
	bh=i2/mIJZywNFRDzg/L8D1NE6gFQ2BKhRmpA3TA90foLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLItfWJosY9sovURGOEPl1oawCm+XqFgEKGFataawqakZbPc0n3f0GhH3HExeL6rs9KtnsrdYVgRhdr50R8sqCtpeaUYtBy6SqTs94N/uOWnJ8kt7maHMNI07SezygyHAfZhM4xGoBhu+7isSQGOiEbuLw2njEMgoAhpureTOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=UHZ07eBF; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 441871050FB6;
	Tue,  7 Oct 2025 14:19:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 441871050FB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1759835960; bh=i2/mIJZywNFRDzg/L8D1NE6gFQ2BKhRmpA3TA90foLk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=UHZ07eBFT7U1enM5SLzkO5DhLNgV6zxrFfnOKr/xMNAoDTUQKL1G+6ElA6WjV0x8m
	 vE9/PMe2a4ByPgyN+C2o4lMYukaOSFXWA4IIckRt7JVrhAGh2csDhemEBn0WnirKhW
	 AaeaH47bllfR6RI/GrX4Dgmp74u3H5iPfyuU0Akc=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 3F00931118DB;
	Tue,  7 Oct 2025 14:19:20 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
	<davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor
 validation@@
Thread-Topic: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor
 validation@@
Thread-Index: AQHcN3w5Ve3VV/I+jk+9of8ehLdFkg==
Date: Tue, 7 Oct 2025 11:19:19 +0000
Message-ID: <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
In-Reply-To: <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <56B79B3E998EB0499C802CA4B2F65111@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/07 08:54:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/07 08:21:00 #27888622
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTAvNi8yNSAxODoxOSwgQWxleGFuZGVyIExvYmFraW4gd3JvdGU6DQo+IEZyb206IElsaWEg
R2F2cmlsb3YgPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnU+DQo+IERhdGU6IE1vbiwgNiBPY3Qg
MjAyNSAwODo1MzoxNyArMDAwMA0KPiANCj4+IFRoZSBkZXNjLT5sZW4gdmFsdWUgY2FuIGJlIHNl
dCB1cCB0byBVMzJfTUFYLiBJZiB1bWVtIHR4X21ldGFkYXRhX2xlbg0KPiANCj4gSW4gdGhlb3J5
LiBOZXZlciBpbiBwcmFjdGljZS4NCj4gDQoNCkhpIEFsZXhhbmRlciwNClRoYW5rIHlvdSBmb3Ig
dGhlIHJldmlldy4NCg0KSXQgc2VlbXMgdG8gbWUgdGhhdCB0aGlzIHByb2JsZW0gc2hvdWxkIGJl
IGNvbnNpZGVyZWQgbm90IGZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2YgcHJhY3RpY2FsIHVzZSwg
DQpidXQgZnJvbSB0aGUgcG9pbnQgb2YgdmlldyBvZiBzZWN1cml0eS4gQW4gYXR0YWNrZXIgY2Fu
IHNldCBhbnkgbGVuZ3RoIG9mIHRoZSBwYWNrZXQgaW4gdGhlIGRlc2NyaXB0b3IgDQpmcm9tIHRo
ZSB1c2VyIHNwYWNlIGFuZCBkZXNjcmlwdG9yIHZhbGlkYXRpb24gd2lsbCBwYXNzLg0KDQoNCj4+
IG9wdGlvbiBpcyBhbHNvIHNldCwgdGhlbiB0aGUgdmFsdWUgb2YgdGhlIGV4cHJlc3Npb24NCj4+
ICdkZXNjLT5sZW4gKyBwb29sLT50eF9tZXRhZGF0YV9sZW4nIGNhbiBvdmVyZmxvdyBhbmQgdmFs
aWRhdGlvbg0KPj4gb2YgdGhlIGluY29ycmVjdCBkZXNjcmlwdG9yIHdpbGwgYmUgc3VjY2Vzc2Z1
bGx5IHBhc3NlZC4NCj4+IFRoaXMgY2FuIGxlYWQgdG8gYSBzdWJzZXF1ZW50IGNoYWluIG9mIGFy
aXRobWV0aWMgb3ZlcmZsb3dzDQo+PiBpbiB0aGUgeHNrX2J1aWxkX3NrYigpIGZ1bmN0aW9uIGFu
ZCBpbmNvcnJlY3Qgc2tfYnVmZiBhbGxvY2F0aW9uLg0KPj4NCj4+IEZvdW5kIGJ5IEluZm9UZUNT
IG9uIGJlaGFsZiBvZiBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyDQo+PiAobGludXh0ZXN0aW5n
Lm9yZykgd2l0aCBTVkFDRS4NCj4gDQo+IEkgdGhpbmsgdGhlIGdlbmVyYWwgcnVsZSBmb3Igc2Vu
ZGluZyBmaXhlcyBpcyB0aGF0IGEgZml4IG11c3QgZml4IGEgcmVhbA0KPiBidWcgd2hpY2ggY2Fu
IGJlIHJlcHJvZHVjZWQgaW4gcmVhbCBsaWZlIHNjZW5hcmlvcy4NCg0KSSBhZ3JlZSB3aXRoIHRo
YXQsIHNvIEkgbWFrZSBhIHRlc3QgcHJvZ3JhbSAoUG9DKS4gU29tZXRoaW5nIGxpa2UgdGhhdDoN
Cg0KCXN0cnVjdCB4ZHBfdW1lbV9yZWcgdW1lbV9yZWc7DQoJdW1lbV9yZWcuYWRkciA9IChfX3U2
NCkodm9pZCAqKXVtZW07DQoJLi4uDQoJdW1lbV9yZWcuY2h1bmtfc2l6ZSA9IDQwOTY7DQoJdW1l
bV9yZWcudHhfbWV0YWRhdGFfbGVuID0gMTY7DQoJdW1lbV9yZWcuZmxhZ3MgPSBYRFBfVU1FTV9U
WF9NRVRBREFUQV9MRU47DQoJc2V0c29ja29wdChzZmQsIFNPTF9YRFAsIFhEUF9VTUVNX1JFRywg
JnVtZW1fcmVnLCBzaXplb2YodW1lbV9yZWcpKTsNCgkuLi4NCgkNCgl4c2tfcmluZ19wcm9kX19y
ZXNlcnZlKHRxLCBiYXRjaF9zaXplLCAmaWR4KTsNCg0KCWZvciAoaSA9IDA7IGkgPCBucl9wYWNr
ZXRzOyArK2kpIHsNCgkJc3RydWN0IHhkcF9kZXNjICp0eF9kZXNjID0geHNrX3JpbmdfcHJvZF9f
dHhfZGVzYyh0cSwgaWR4ICsgaSk7DQoJCXR4X2Rlc2MtPmFkZHIgPSBwYWNrZXRzW2ldLmFkZHI7
DQoJCXR4X2Rlc2MtPmFkZHIgKz0gdW1lbS0+dHhfbWV0YWRhdGFfbGVuOw0KCQl0eF9kZXNjLT5v
cHRpb25zID0gWERQX1RYX01FVEFEQVRBOw0KCQl0eF9kZXNjLT5sZW4gPSBVSU5UMzJfTUFYOw0K
CX0NCg0KCXhza19yaW5nX3Byb2RfX3N1Ym1pdCh0cSwgbnJfcGFja2V0cyk7DQoJLi4uDQoJc2Vu
ZHRvKHNmZCwgTlVMTCwgMCwgTVNHX0RPTlRXQUlULCBOVUxMLCAwKTsNCg0KU2luY2UgdGhlIGNo
ZWNrIG9mIGFuIGludmFsaWQgZGVzY3JpcHRvciBoYXMgcGFzc2VkLCBrZXJuZWwgdHJ5IHRvIGFs
bG9jYXRlDQphIHNrYiB3aXRoIHNpemUgb2YgJ2hyICsgbGVuICsgdHInIGluIHRoZSBzb2NrX2Fs
bG9jX3NlbmRfcHNrYigpIGZ1bmN0aW9uDQphbmQgdGhpcyBpcyB3aGVyZSB0aGUgbmV4dCBvdmVy
ZmxvdyBvY2N1cnMuDQpza2IgYWxsb2NhdGVzIHdpdGggYSBzaXplIG9mIDYzLiBOZXh0IHRoZSBz
a2JfcHV0KCkgaXMgY2FsbGVkLCB3aGljaCBhZGRzIFUzMl9NQVggdG8gc2tiLT50YWlsIGFuZCBz
a2ItPmVuZC4NCk5leHQgdGhlIHNrYl9zdG9yZV9iaXRzKCkgdHJpZXMgdG8gY29weSAtMSBieXRl
cywgYnV0IGZhaWxzLg0KDQogX194c2tfZ2VuZXJpY194bWl0DQoJeHNrX2J1aWxkX3NrYg0KCQls
ZW4gPSBkZXNjLT5sZW47IC8vIGZyb20gZGVzY3JpcHRvcg0KCQlzb2NrX2FsbG9jX3NlbmRfc2ti
KC4uLiwgaHIgKyBsZW4gKyB0ciwgLi4uKSAvLyB0aGUgbmV4dCBvdmVyZmxvdw0KCQkJc29ja19h
bGxvY19zZW5kX3Bza2INCgkJCQlhbGxvY19za2Jfd2l0aF9mcmFncw0KCQlza2JfcHV0KHNrYiwg
bGVuKSAgLy8gbGVuIGNhc3RzIHRvIGludA0KCQlza2Jfc3RvcmVfYml0cyhza2IsIDAsIGJ1ZmZl
ciwgbGVuKQ0KDQo+IFN0YXRpYyBBbmFseXNpcyBUb29scyBoYXZlIG5vIGlkZWEgdGhhdCBub2Jv
ZHkgc2VuZHMgNCBHYiBzaXplZCBuZXR3b3JrDQo+IHBhY2tldHMuDQo+IA0KDQpUaGF0J3Mgcmln
aHQuIFN0YXRpYyBhbmFseXplciBpcyBvbmx5IGEgdG9vbCwgYnV0IGluIHRoaXMgY2FzZSwgdGhl
IG92ZXJmbG93DQpoaWdobGlnaHRlZCBieSB0aGUgc3RhdGljIGFuYWx5emVyIGNhbiBiZSB1c2Vk
IGZvciBtYWxpY2lvdXMgcHVycG9zZXMuDQogDQoNCj4+DQo+PiBGaXhlczogMzQxYWM5ODBlYWI5
ICgieHNrOiBTdXBwb3J0IHR4X21ldGFkYXRhX2xlbiIpDQo+PiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogSWxpYSBHYXZyaWxvdiA8SWxpYS5HYXZyaWxvdkBp
bmZvdGVjcy5ydT4NCj4+IC0tLQ0KPj4gIG5ldC94ZHAveHNrX3F1ZXVlLmggfCA0ICsrLS0NCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiBUaGFu
a3MsDQo+IE9sZWsNCg0KVGhhbmtzLCANCklsaWENCg0K

