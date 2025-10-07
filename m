Return-Path: <bpf+bounces-70502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC7BC181B
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A53A9010
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7372E0B6A;
	Tue,  7 Oct 2025 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="AU79XZ5v"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF7225785;
	Tue,  7 Oct 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844056; cv=none; b=m5gCiDEkDt2qdA8xhYVhj3/3yN01oD9GcIQgLyZ1zQ14xUKiJO9GALVixB87ABrH5yew59YCPtUrgdsSSYr6TvO46F1Ukqj2EW1mfIgPc3TXiOiYYKwCC/NdZu468y4f8iUFZ/Onny9p88M5/VT+rB9Rb21iizDAObqsenvMS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844056; c=relaxed/simple;
	bh=/So3f5v7PZ2PZ715Z7wHDcqmcfeTwR80CmpDQkIF8Kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObXZ0aZtFolYcjIsSffyLLFCiXJXP63hTTvXG5RuLZGA5yXHCOkb0FDWjNJmsjuszU7yEjcz9vvqZZmdAI0xCVpsaW3hzew6xvioiSt/eg5VNnyzioI45m2ic7b02g9gKdcDZhYFYEp1GRWdTvzjuirji9PgNaa/ocxILJ+Juoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=AU79XZ5v; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 60BBC111323F;
	Tue,  7 Oct 2025 16:34:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 60BBC111323F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1759844051; bh=/So3f5v7PZ2PZ715Z7wHDcqmcfeTwR80CmpDQkIF8Kk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AU79XZ5vsAHDiodBHFxxqEU4sHVV4ed8mBEl1KesOZNxx9ggOB8e4jVR6IISSiadx
	 YTVUnslvjP88m7wNIY8q6Z6ythifKyjTYGcz20nSmDl8vo3Omoj+lutzq9oPyTaXEw
	 4suAxumhIcD8m2ugVpg7hp95HQLS6rPE/GA/n4Y0=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 5D43330DC978;
	Tue,  7 Oct 2025 16:34:11 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
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
Thread-Index: AQHcN3w5L4XpvnmUkkmNj/GbVerG77S2ZU8AgAAJv4CAAA3OAA==
Date: Tue, 7 Oct 2025 13:34:11 +0000
Message-ID: <914ddb6c-79ca-49c2-82b1-33be1986eff5@infotecs.ru>
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com>
 <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
 <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com>
 <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
In-Reply-To: <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA8A8A3A88BB4498256591FB5CBA537@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/07 12:47:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/07 12:37:00 #27889104
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTAvNy8yNSAxNTo0NCwgTWFnbnVzIEthcmxzc29uIHdyb3RlOg0KPiBPbiBUdWUsIDcgT2N0
IDIwMjUgYXQgMTQ6MTEsIEFsZXhhbmRlciBMb2Jha2luDQo+IDxhbGVrc2FuZGVyLmxvYmFraW5A
aW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBJbGlhIEdhdnJpbG92IDxJbGlhLkdhdnJp
bG92QGluZm90ZWNzLnJ1Pg0KPj4gRGF0ZTogVHVlLCA3IE9jdCAyMDI1IDExOjE5OjE5ICswMDAw
DQo+Pg0KPj4+IE9uIDEwLzYvMjUgMTg6MTksIEFsZXhhbmRlciBMb2Jha2luIHdyb3RlOg0KPj4+
PiBGcm9tOiBJbGlhIEdhdnJpbG92IDxJbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1Pg0KPj4+PiBE
YXRlOiBNb24sIDYgT2N0IDIwMjUgMDg6NTM6MTcgKzAwMDANCj4+Pj4NCj4+Pj4+IFRoZSBkZXNj
LT5sZW4gdmFsdWUgY2FuIGJlIHNldCB1cCB0byBVMzJfTUFYLiBJZiB1bWVtIHR4X21ldGFkYXRh
X2xlbg0KPj4+Pg0KPj4+PiBJbiB0aGVvcnkuIE5ldmVyIGluIHByYWN0aWNlLg0KPj4+Pg0KPj4+
DQo+Pj4gSGkgQWxleGFuZGVyLA0KPj4+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4+Pg0K
Pj4+IEl0IHNlZW1zIHRvIG1lIHRoYXQgdGhpcyBwcm9ibGVtIHNob3VsZCBiZSBjb25zaWRlcmVk
IG5vdCBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHByYWN0aWNhbCB1c2UsDQo+Pj4gYnV0IGZy
b20gdGhlIHBvaW50IG9mIHZpZXcgb2Ygc2VjdXJpdHkuIEFuIGF0dGFja2VyIGNhbiBzZXQgYW55
IGxlbmd0aCBvZiB0aGUgcGFja2V0IGluIHRoZSBkZXNjcmlwdG9yDQo+Pj4gZnJvbSB0aGUgdXNl
ciBzcGFjZSBhbmQgZGVzY3JpcHRvciB2YWxpZGF0aW9uIHdpbGwgcGFzcy4NCj4+Pg0KPj4+DQo+
Pj4+PiBvcHRpb24gaXMgYWxzbyBzZXQsIHRoZW4gdGhlIHZhbHVlIG9mIHRoZSBleHByZXNzaW9u
DQo+Pj4+PiAnZGVzYy0+bGVuICsgcG9vbC0+dHhfbWV0YWRhdGFfbGVuJyBjYW4gb3ZlcmZsb3cg
YW5kIHZhbGlkYXRpb24NCj4+Pj4+IG9mIHRoZSBpbmNvcnJlY3QgZGVzY3JpcHRvciB3aWxsIGJl
IHN1Y2Nlc3NmdWxseSBwYXNzZWQuDQo+Pj4+PiBUaGlzIGNhbiBsZWFkIHRvIGEgc3Vic2VxdWVu
dCBjaGFpbiBvZiBhcml0aG1ldGljIG92ZXJmbG93cw0KPj4+Pj4gaW4gdGhlIHhza19idWlsZF9z
a2IoKSBmdW5jdGlvbiBhbmQgaW5jb3JyZWN0IHNrX2J1ZmYgYWxsb2NhdGlvbi4NCj4+Pj4+DQo+
Pj4+PiBGb3VuZCBieSBJbmZvVGVDUyBvbiBiZWhhbGYgb2YgTGludXggVmVyaWZpY2F0aW9uIENl
bnRlcg0KPj4+Pj4gKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+Pj4+DQo+Pj4+IEkg
dGhpbmsgdGhlIGdlbmVyYWwgcnVsZSBmb3Igc2VuZGluZyBmaXhlcyBpcyB0aGF0IGEgZml4IG11
c3QgZml4IGEgcmVhbA0KPj4+PiBidWcgd2hpY2ggY2FuIGJlIHJlcHJvZHVjZWQgaW4gcmVhbCBs
aWZlIHNjZW5hcmlvcy4NCj4+Pg0KPj4+IEkgYWdyZWUgd2l0aCB0aGF0LCBzbyBJIG1ha2UgYSB0
ZXN0IHByb2dyYW0gKFBvQykuIFNvbWV0aGluZyBsaWtlIHRoYXQ6DQo+Pj4NCj4+PiAgICAgICBz
dHJ1Y3QgeGRwX3VtZW1fcmVnIHVtZW1fcmVnOw0KPj4+ICAgICAgIHVtZW1fcmVnLmFkZHIgPSAo
X191NjQpKHZvaWQgKil1bWVtOw0KPj4+ICAgICAgIC4uLg0KPj4+ICAgICAgIHVtZW1fcmVnLmNo
dW5rX3NpemUgPSA0MDk2Ow0KPj4+ICAgICAgIHVtZW1fcmVnLnR4X21ldGFkYXRhX2xlbiA9IDE2
Ow0KPj4+ICAgICAgIHVtZW1fcmVnLmZsYWdzID0gWERQX1VNRU1fVFhfTUVUQURBVEFfTEVOOw0K
Pj4+ICAgICAgIHNldHNvY2tvcHQoc2ZkLCBTT0xfWERQLCBYRFBfVU1FTV9SRUcsICZ1bWVtX3Jl
Zywgc2l6ZW9mKHVtZW1fcmVnKSk7DQo+Pj4gICAgICAgLi4uDQo+Pj4NCj4+PiAgICAgICB4c2tf
cmluZ19wcm9kX19yZXNlcnZlKHRxLCBiYXRjaF9zaXplLCAmaWR4KTsNCj4+Pg0KPj4+ICAgICAg
IGZvciAoaSA9IDA7IGkgPCBucl9wYWNrZXRzOyArK2kpIHsNCj4+PiAgICAgICAgICAgICAgIHN0
cnVjdCB4ZHBfZGVzYyAqdHhfZGVzYyA9IHhza19yaW5nX3Byb2RfX3R4X2Rlc2ModHEsIGlkeCAr
IGkpOw0KPj4+ICAgICAgICAgICAgICAgdHhfZGVzYy0+YWRkciA9IHBhY2tldHNbaV0uYWRkcjsN
Cj4+PiAgICAgICAgICAgICAgIHR4X2Rlc2MtPmFkZHIgKz0gdW1lbS0+dHhfbWV0YWRhdGFfbGVu
Ow0KPj4+ICAgICAgICAgICAgICAgdHhfZGVzYy0+b3B0aW9ucyA9IFhEUF9UWF9NRVRBREFUQTsN
Cj4+PiAgICAgICAgICAgICAgIHR4X2Rlc2MtPmxlbiA9IFVJTlQzMl9NQVg7DQo+Pj4gICAgICAg
fQ0KPj4+DQo+Pj4gICAgICAgeHNrX3JpbmdfcHJvZF9fc3VibWl0KHRxLCBucl9wYWNrZXRzKTsN
Cj4+PiAgICAgICAuLi4NCj4+PiAgICAgICBzZW5kdG8oc2ZkLCBOVUxMLCAwLCBNU0dfRE9OVFdB
SVQsIE5VTEwsIDApOw0KPj4+DQo+Pj4gU2luY2UgdGhlIGNoZWNrIG9mIGFuIGludmFsaWQgZGVz
Y3JpcHRvciBoYXMgcGFzc2VkLCBrZXJuZWwgdHJ5IHRvIGFsbG9jYXRlDQo+Pj4gYSBza2Igd2l0
aCBzaXplIG9mICdociArIGxlbiArIHRyJyBpbiB0aGUgc29ja19hbGxvY19zZW5kX3Bza2IoKSBm
dW5jdGlvbg0KPj4+IGFuZCB0aGlzIGlzIHdoZXJlIHRoZSBuZXh0IG92ZXJmbG93IG9jY3Vycy4N
Cj4+PiBza2IgYWxsb2NhdGVzIHdpdGggYSBzaXplIG9mIDYzLiBOZXh0IHRoZSBza2JfcHV0KCkg
aXMgY2FsbGVkLCB3aGljaCBhZGRzIFUzMl9NQVggdG8gc2tiLT50YWlsIGFuZCBza2ItPmVuZC4N
Cj4+PiBOZXh0IHRoZSBza2Jfc3RvcmVfYml0cygpIHRyaWVzIHRvIGNvcHkgLTEgYnl0ZXMsIGJ1
dCBmYWlscy4NCj4+Pg0KPj4+ICBfX3hza19nZW5lcmljX3htaXQNCj4+PiAgICAgICB4c2tfYnVp
bGRfc2tiDQo+Pj4gICAgICAgICAgICAgICBsZW4gPSBkZXNjLT5sZW47IC8vIGZyb20gZGVzY3Jp
cHRvcg0KPj4+ICAgICAgICAgICAgICAgc29ja19hbGxvY19zZW5kX3NrYiguLi4sIGhyICsgbGVu
ICsgdHIsIC4uLikgLy8gdGhlIG5leHQgb3ZlcmZsb3cNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgc29ja19hbGxvY19zZW5kX3Bza2INCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhbGxvY19za2Jfd2l0aF9mcmFncw0KPj4+ICAgICAgICAgICAgICAgc2tiX3B1dChza2IsIGxl
bikgIC8vIGxlbiBjYXN0cyB0byBpbnQNCj4+PiAgICAgICAgICAgICAgIHNrYl9zdG9yZV9iaXRz
KHNrYiwgMCwgYnVmZmVyLCBsZW4pDQo+Pg0KPj4gT2gsIHNvIHlvdSBhY3R1YWxseSBoYXZlIGEg
cmVwcm8gZm9yIHRoaXMuIFRoaXMgaXMgZ29vZC4gSSBzdWdnZXN0IHlvdQ0KPj4gcmVzdWJtaXR0
aW5nIHRoZSBwYXRjaCBhbmQgaW5jbHVkZSB0aGlzIHJlcHJvIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSwgc28NCj4+IHRoYXQgaXQgd2lsbCBiZSBjbGVhciB0aGF0IGl0J3MgYWN0dWFsbHkgcG9zc2li
bGUgdG8gdHJpZ2dlciB0aGUgcHJvYmxlbQ0KPj4gaW4gdGhlIGtlcm5lbCB1c2luZyBhIG1hbGlj
aW91cy9icm9rZW4gdXNlcnNwYWNlIGFwcGxpY2F0aW9uLg0KPj4NCg0KSSdsbCBhZGQgdGhlIHJl
cHJvIGZyb20gdGhpcyBlLW1haWwgaW4gdGhlIG5leHQgcGF0Y2ggdmVyc2lvbiwNCnRoZSBmdWxs
IHNvdXJjZSBpcyB0b28gbG9uZy4NCg0KPj4gKGFsc28gcGxzIHJlbW92ZSB0aG9zZSBkb3VibGUg
YEBAYCBmcm9tIHRoZSBzdWJqZWN0IG5leHQgdGltZSkNCj4+DQoNCm9rDQoNCj4+IEknZCBhbHNv
IGxpa2UgdG8gaGVhciBmcm9tIE1hY2llaiBhbmQvb3Igb3RoZXJzIHdoYXQgdGhleSB0aGluayBh
Ym91dA0KPj4gdGhpcyBwcm9ibGVtICh0aGF0IHRoZSB1c2Vyc3BhY2UgY2FuIHNldCBwYWNrZXQg
bGVuIHRvIFUzMl9NQVgpLiBTaG91bGQNCj4+IHdlIGp1c3QgZ28gd2l0aCB0aGlzIHByb3Bvc2Vk
IHU2NCBwcm9wYWdhdGlvbiBvciBtYXliZSB3ZSBuZWVkIHRvIGxpbWl0DQo+PiB0aGUgbWF4aW11
bSBsZW5ndGggd2hpY2ggY291bGQgYmUgc2VudCBmcm9tIHRoZSB1c2Vyc3BhY2U/DQo+IA0KPiBJ
IHByZWZlciB0aGF0IHdlIGRvIG5vdCBzZXQgYSBsaW1pdCBvbiBpdCBhbmQgZ28gd2l0aCB0aGUg
cHJvcG9zZWQNCj4gc29sdXRpb24gc2luY2UgSSBkbyBub3Qga25vdyB3aGF0IGEgZnV0dXJlIHBy
b29mIHNpemUgbGltaXQgd291bGQgYmUuDQo+IFNvbWVib2R5IGNvdWxkIGNvbWUgdXAgd2l0aCBh
IG5ldyB2aXJ0dWFsIGRldmljZSB0aGF0IGNhbiBzZW5kIHJlYWxseQ0KPiBsYXJnZSBwYWNrZXRz
LCB3aG8ga25vd3MuDQo+IA0KDQpUaGUgbGltaXQgaXMgYWxyZWFkeSBjaGVja2VkIGluIHRoZSB4
cF9hbGlnbmVkX3ZhbGlkYXRlX2Rlc2MoKSBmdW5jdGlvbjoNCg0Kc3RhdGljIGlubGluZSBib29s
IHhwX2FsaWduZWRfdmFsaWRhdGVfZGVzYyhzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwNCgkJ
CQkJICAgIHN0cnVjdCB4ZHBfZGVzYyAqZGVzYykNCnsNCg0KLi4uDQoJaWYgKG9mZnNldCArIGxl
biA+IHBvb2wtPmNodW5rX3NpemUpDQoJCXJldHVybiBmYWxzZTsNCi4uLg0KfQ0KDQphbmQgcG9v
bC0+Y2h1bmtfc2l6ZSBjYW4ndCBiZSBtb3JlIHRoYW4gUEFHRV9TSVpFOg0KDQpzdGF0aWMgaW50
IHhkcF91bWVtX3JlZyhzdHJ1Y3QgeGRwX3VtZW0gKnVtZW0sIHN0cnVjdCB4ZHBfdW1lbV9yZWcg
Km1yKQ0Kew0KCXUzMiBjaHVua19zaXplID0gbXItPmNodW5rX3NpemUsIGhlYWRyb29tID0gbXIt
PmhlYWRyb29tOw0KCS4uLg0KDQoJaWYgKGNodW5rX3NpemUgPCBYRFBfVU1FTV9NSU5fQ0hVTktf
U0laRSB8fCBjaHVua19zaXplID4gUEFHRV9TSVpFKSB7DQoJCS8qIFN0cmljdGx5IHNwZWFraW5n
IHdlIGNvdWxkIHN1cHBvcnQgdGhpcywgaWY6DQoJCSAqIC0gaHVnZSBwYWdlcywgb3IqDQoJCSAq
IC0gdXNpbmcgYW4gSU9NTVUsIG9yDQoJCSAqIC0gbWFraW5nIHN1cmUgdGhlIG1lbW9yeSBhcmVh
IGlzIGNvbnNlY3V0aXZlDQoJCSAqIGJ1dCBmb3Igbm93LCB3ZSBzaW1wbHkgc2F5ICJjb21wdXRl
ciBzYXlzIG5vIi4NCgkJICovDQoJDQoJCXJldHVybiAtRUlOVkFMOw0KCX0NCgkuLi4NCn0NCg0K
VGhlIHByb2JsZW0gaXMgZXhhY3RseSB0aGUgb3ZlcmZsb3cuDQoNCj4+IEluIGFueSBjYXNlLCB5
b3UgcmFpc2VkIGEgZ29vZCB0b3BpYy4NCj4+DQo+Pj4NCj4+Pj4gU3RhdGljIEFuYWx5c2lzIFRv
b2xzIGhhdmUgbm8gaWRlYSB0aGF0IG5vYm9keSBzZW5kcyA0IEdiIHNpemVkIG5ldHdvcmsNCj4+
Pj4gcGFja2V0cy4NCj4+Pj4NCj4+Pg0KPj4+IFRoYXQncyByaWdodC4gU3RhdGljIGFuYWx5emVy
IGlzIG9ubHkgYSB0b29sLCBidXQgaW4gdGhpcyBjYXNlLCB0aGUgb3ZlcmZsb3cNCj4+PiBoaWdo
bGlnaHRlZCBieSB0aGUgc3RhdGljIGFuYWx5emVyIGNhbiBiZSB1c2VkIGZvciBtYWxpY2lvdXMg
cHVycG9zZXMuDQo+Pg0KPj4gKzENCj4+DQo+PiBBbHNvIEkgcmVhbGx5IGRvIGhvcGUgSW5mb3Rl
Y3Mgc3RheWVkIGluZGVwZW5kZW50IGZyb20gdGhlIGdvdnMgYW5kDQo+PiBkb2Vzbid0IHRha2Ug
cGFydCBpbiBhbnkgZHVhbC1wdXJwb3NlL2dvdi1yZWxhdGVkIHByb2plY3RzLg0KPj4NCj4+IFRo
YW5rcywNCj4+IE9sZWsNCj4+DQoNCg==

