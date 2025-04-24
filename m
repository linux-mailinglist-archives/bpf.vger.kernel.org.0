Return-Path: <bpf+bounces-56578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A9A9A9EE
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6177ADDE4
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6AB221712;
	Thu, 24 Apr 2025 10:19:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD11E9B32;
	Thu, 24 Apr 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489988; cv=none; b=XDAZ0dmNWH4D0sfcsSpKliRwuD5XliG45SYi3Kcit/OC9DHH0N+bnyyJ/tA99ipzAASwbJIT9Oqb43SqBzYjAaD0NIORUBlL4OHFT2K6VVF282LcH38Jq+bg4RZJMZIsq4M90400zfScTulIDnhKyT8EaeJpnFeSXcWOqjec9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489988; c=relaxed/simple;
	bh=8GNCbAnkciZqOac4k7eEDf9GjqfhlA+Yz9at1hSBCz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmhzgNw/NoWLZIFXIheirRII0fiatC2kZhKVAAV/w38IzDwqiKNe2LdcQ4w/BKnpsnpI4fwBWroJMJwc9xc2wHoG2Q8rmB9ukE18cKZrewssBZeWlDituN3xvQgIaZyqg8VVP5rVI58+UpI4UWZtFTTsuPltXc+eR9nUKJcZG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1u7tg9-0002p1-B9; Thu, 24 Apr 2025 12:19:37 +0200
Received: from [2003:f6:af22:6538:f6a8:dff:fe1e:4c1d]
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tobias.boehm@hetzner-cloud.de>)
	id 1u7tg9-00093c-0B;
	Thu, 24 Apr 2025 12:19:37 +0200
Message-ID: <eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de>
Date: Thu, 24 Apr 2025 12:19:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 sdn@hetzner-cloud.de
References: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
 <Z/fWHYETBYQuCno5@localhost.localdomain>
 <ff7ca6ea-a122-4d7d-9ef2-d091cbdd96d2@hetzner-cloud.de>
 <Z/jPgceDT4gRu9/R@localhost.localdomain> <aAEUcXIRnWolGWnA@boxer>
 <b06ede77-541b-453f-9e7a-79f3e5591f66@hetzner-cloud.de>
 <aAkz/+Rx5w3OHH4/@boxer>
Content-Language: en-US
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
Autocrypt: addr=tobias.boehm@hetzner-cloud.de; keydata=
 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
 p0ms75naziM=
Organization: Hetzner Cloud GmbH
In-Reply-To: <aAkz/+Rx5w3OHH4/@boxer>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FBVEsp19lYY6MiVsUylR0Uiq"
X-Authenticated-Sender: tobias.boehm@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27618/Thu Apr 24 10:40:01 2025)

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FBVEsp19lYY6MiVsUylR0Uiq
Content-Type: multipart/mixed; boundary="------------jQtsyF5GJ7I5LYtZkOUCTdnu";
 protected-headers="v1"
From: =?UTF-8?Q?Tobias_B=C3=B6hm?= <tobias.boehm@hetzner-cloud.de>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 sdn@hetzner-cloud.de
Message-ID: <eca1880f-253a-4955-afe6-732d7c6926ee@hetzner-cloud.de>
Subject: Re: [BUG] ixgbe: Detected Tx Unit Hang (XDP)
References: <d33f0ab4-4dc4-49cd-bbd0-055f58dd6758@hetzner-cloud.de>
 <Z/fWHYETBYQuCno5@localhost.localdomain>
 <ff7ca6ea-a122-4d7d-9ef2-d091cbdd96d2@hetzner-cloud.de>
 <Z/jPgceDT4gRu9/R@localhost.localdomain> <aAEUcXIRnWolGWnA@boxer>
 <b06ede77-541b-453f-9e7a-79f3e5591f66@hetzner-cloud.de>
 <aAkz/+Rx5w3OHH4/@boxer>
In-Reply-To: <aAkz/+Rx5w3OHH4/@boxer>
Autocrypt-Gossip: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==

--------------jQtsyF5GJ7I5LYtZkOUCTdnu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMjMuMDQuMjUgdW0gMjA6Mzkgc2NocmllYiBNYWNpZWogRmlqYWxrb3dza2k6DQo+IE9u
IFdlZCwgQXByIDIzLCAyMDI1IGF0IDA0OjIwOjA3UE0gKzAyMDAsIE1hcmN1cyBXaWNoZWxt
YW5uIHdyb3RlOg0KPj4gQW0gMTcuMDQuMjUgdW0gMTY6NDcgc2NocmllYiBNYWNpZWogRmlq
YWxrb3dza2k6DQo+Pj4gT24gRnJpLCBBcHIgMTEsIDIwMjUgYXQgMTA6MTQ6NTdBTSArMDIw
MCwgTWljaGFsIEt1YmlhayB3cm90ZToNCj4+Pj4gT24gVGh1LCBBcHIgMTAsIDIwMjUgYXQg
MDQ6NTQ6MzVQTSArMDIwMCwgTWFyY3VzIFdpY2hlbG1hbm4gd3JvdGU6DQo+Pj4+PiBBbSAx
MC4wNC4yNSB1bSAxNjozMCBzY2hyaWViIE1pY2hhbCBLdWJpYWs6DQo+Pj4+Pj4gT24gV2Vk
LCBBcHIgMDksIDIwMjUgYXQgMDU6MTc6NDlQTSArMDIwMCwgTWFyY3VzIFdpY2hlbG1hbm4g
d3JvdGU6DQo+Pj4+Pj4+IEhpLA0KPj4+Pj4+Pg0KPj4+Pj4+PiBpbiBhIHNldHVwIHdoZXJl
IEkgdXNlIG5hdGl2ZSBYRFAgdG8gcmVkaXJlY3QgcGFja2V0cyB0byBhIGJvbmRpbmcgaW50
ZXJmYWNlDQo+Pj4+Pj4+IHRoYXQncyBiYWNrZWQgYnkgdHdvIGl4Z2JlIHNsYXZlcywgSSBu
b3RpY2VkIHRoYXQgdGhlIGl4Z2JlIGRyaXZlciBjb25zdGFudGx5DQo+Pj4+Pj4+IHJlc2V0
cyB0aGUgTklDIHdpdGggdGhlIGZvbGxvd2luZyBrZXJuZWwgb3V0cHV0Og0KPj4+Pj4+Pg0K
Pj4+Pj4+PiAgICBpeGdiZSAwMDAwOjAxOjAwLjEgaXhnYmUteDUyMC0yOiBEZXRlY3RlZCBU
eCBVbml0IEhhbmcgKFhEUCkNCj4+Pj4+Pj4gICAgICBUeCBRdWV1ZSAgICAgICAgICAgICA8
ND4NCj4+Pj4+Pj4gICAgICBUREgsIFREVCAgICAgICAgICAgICA8MTdlPiwgPDE3ZT4NCj4+
Pj4+Pj4gICAgICBuZXh0X3RvX3VzZSAgICAgICAgICA8MTgxPg0KPj4+Pj4+PiAgICAgIG5l
eHRfdG9fY2xlYW4gICAgICAgIDwxN2U+DQo+Pj4+Pj4+ICAgIHR4X2J1ZmZlcl9pbmZvW25l
eHRfdG9fY2xlYW5dDQo+Pj4+Pj4+ICAgICAgdGltZV9zdGFtcCAgICAgICAgICAgPDA+DQo+
Pj4+Pj4+ICAgICAgamlmZmllcyAgICAgICAgICAgICAgPDEwMDI1YzM4MD4NCj4+Pj4+Pj4g
ICAgaXhnYmUgMDAwMDowMTowMC4xIGl4Z2JlLXg1MjAtMjogdHggaGFuZyAxOSBkZXRlY3Rl
ZCBvbiBxdWV1ZSA0LCByZXNldHRpbmcgYWRhcHRlcg0KPj4+Pj4+PiAgICBpeGdiZSAwMDAw
OjAxOjAwLjEgaXhnYmUteDUyMC0yOiBpbml0aWF0aW5nIHJlc2V0IGR1ZSB0byB0eCB0aW1l
b3V0DQo+Pj4+Pj4+ICAgIGl4Z2JlIDAwMDA6MDE6MDAuMSBpeGdiZS14NTIwLTI6IFJlc2V0
IGFkYXB0ZXINCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhpcyBvbmx5IG9jY3VycyBpbiBjb21iaW5h
dGlvbiB3aXRoIGEgYm9uZGluZyBpbnRlcmZhY2UgYW5kIFhEUCwgc28gSSBkb24ndA0KPj4+
Pj4+PiBrbm93IGlmIHRoaXMgaXMgYW4gaXNzdWUgd2l0aCBpeGdiZSBvciB0aGUgYm9uZGlu
ZyBkcml2ZXIuDQo+Pj4+Pj4+IEkgZmlyc3QgZGlzY292ZXJlZCB0aGlzIHdpdGggTGludXgg
Ni44LjAtNTcsIGJ1dCBrZXJuZWwgNi4xNC4wIGFuZCA2LjE1LjAtcmMxDQo+Pj4+Pj4+IHNo
b3cgdGhlIHNhbWUgaXNzdWUuDQo+Pj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkgbWFuYWdl
ZCB0byByZXByb2R1Y2UgdGhpcyBidWcgaW4gYSBsYWIgZW52aXJvbm1lbnQuIEhlcmUgYXJl
IHNvbWUgZGV0YWlscw0KPj4+Pj4+PiBhYm91dCBteSBzZXR1cCBhbmQgdGhlIHN0ZXBzIHRv
IHJlcHJvZHVjZSB0aGUgYnVnOg0KPj4+Pj4+Pg0KPj4+Pj4+PiBbLi4uXQ0KPj4+Pj4+Pg0K
Pj4+Pj4+PiBEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgd2hhdCBtYXkgYmUgY2F1c2luZyB0aGlz
IGlzc3VlIG9yIHdoYXQgSSBjYW4gZG8gdG8NCj4+Pj4+Pj4gZGlhZ25vc2UgdGhpcyBmdXJ0
aGVyPw0KPj4+Pj4+Pg0KPj4+Pj4+PiBQbGVhc2UgbGV0IG1lIGtub3cgd2hlbiBJIHNob3Vs
ZCBwcm92aWRlIGFueSBtb3JlIGluZm9ybWF0aW9uLg0KPj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+
Pj4+PiBUaGFua3MhDQo+Pj4+Pj4+IE1hcmN1cw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+IFsu
Li5dDQo+Pj4+DQo+Pj4+IEhpIE1hcmN1cywNCj4+Pj4NCj4+Pj4+IHRoYW5rIHlvdSBmb3Ig
bG9va2luZyBpbnRvIGl0LiBBbmQgbm90IGV2ZW4gMjQgaG91cnMgYWZ0ZXIgbXkgcmVwb3J0
LCBJJ20NCj4+Pj4+IHZlcnkgaW1wcmVzc2VkISA7KQ0KPj4+Pg0KPj4+PiBUaGFua3MhIDot
KQ0KPj4+Pg0KPj4+Pj4gSW50ZXJlc3RpbmcuIEkganVzdCB0cmllZCBhZ2FpbiBidXQgaGFk
IG5vIGx1Y2sgeWV0IHdpdGggcmVwcm9kdWNpbmcgaXQNCj4+Pj4+IHdpdGhvdXQgYSBib25k
aW5nIGludGVyZmFjZS4gTWF5IEkgYXNrIGhvdyB5b3VyIHNldHVwIGxvb2tzIGxpa2U/DQo+
Pj4+DQo+Pj4+IEZvciBub3csIEkndmUganVzdCBncmFiYmVkIHRoZSBmaXJzdCBhdmFpbGFi
bGUgc3lzdGVtIHdpdGggdGhlIEhXDQo+Pj4+IGNvbnRyb2xsZWQgYnkgdGhlICJpeGdiZSIg
ZHJpdmVyLiBJbiBteSBjYXNlIGl0IHdhczoNCj4+Pj4NCj4+Pj4gICAgRXRoZXJuZXQgY29u
dHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gRXRoZXJuZXQgQ29udHJvbGxlciBYNTUwDQo+
Pj4+DQo+Pj4+IEFsc28sIGZvciBteSBmaXJzdCBhdHRlbXB0LCBJIGRpZG4ndCB1c2UgdGhl
IHVwc3RyZWFtIGtlcm5lbCAtIEkganVzdCB0cmllZA0KPj4+PiB0aGUga2VybmVsIGluc3Rh
bGxlZCBvbiB0aGF0IHN5c3RlbS4gSXQgd2FzIHRoZSBGZWRvcmEga2VybmVsOg0KPj4+Pg0K
Pj4+PiAgICA2LjEyLjgtMjAwLmZjNDEueDg2XzY0DQo+Pj4+DQo+Pj4+DQo+Pj4+IEkgdGhp
bmsgdGhhdCBtYXkgYmUgdGhlICJiZWF1dHkiIG9mIHRpbWluZyBpc3N1ZXMgLSBzb21ldGlt
ZXMgeW91IGNhbiBjaGFuZ2UNCj4+Pj4ganVzdCBvbmUgcGllY2UgaW4geW91ciBzeXN0ZW0g
YW5kIGdldCBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IHJlcGxpY2F0aW9uIHJhdGlvLg0KPj4+
PiBBbnl3YXksIHRoZSBoaWdoZXIgdGhlIHJlcHJvIHByb2JhYmlsaXR5LCB0aGUgZWFzaWVy
IGl0IGlzIHRvIGRlYnVnDQo+Pj4+IHRoZSB0aW1pbmcgcHJvYmxlbS4gOi0pDQo+Pj4NCj4+
PiBIaSBNYXJjdXMsIHRvIGJyZWFrIHRoZSBzaWxlbmNlIGNvdWxkIHlvdSB0cnkgdG8gYXBw
bHkgdGhlIGRpZmYgYmVsb3cgb24NCj4+PiB5b3VyIHNpZGU/DQo+Pg0KPj4gSGksIHRoYW5r
IHlvdSBmb3IgdGhlIHBhdGNoLiBXZSd2ZSB0cmllZCBpdCBhbmQgd2l0aCB5b3VyIGNoYW5n
ZXMgd2UgY2FuIG5vDQo+PiBsb25nZXIgdHJpZ2dlciB0aGUgZXJyb3IgYW5kIHRoZSBOSUMg
aXMgbm8gbG9uZ2VyIGJlaW5nIHJlc2V0Lg0KPj4NCj4+PiBXZSBzZWUgc2V2ZXJhbCBpc3N1
ZXMgYXJvdW5kIFhEUCBxdWV1ZXMgaW4gaXhnYmUsIGJ1dCBiZWZvcmUgd2UNCj4+PiBwcm9j
ZWVkIGxldCdzIHRoaXMgc21hbGwgY2hhbmdlIG9uIHlvdXIgc2lkZS4NCj4+DQo+PiBIb3cg
Y29uZmlkZW50IGFyZSB5b3UgdGhhdCB0aGlzIHBhdGNoIGlzIHN1ZmZpY2llbnQgdG8gbWFr
ZSB0aGluZ3Mgc3RhYmxlIGVub3VnaA0KPj4gZm9yIHByb2R1Y3Rpb24gdXNlPyBXYXMgaXQg
anVzdCB0aGUgVHggaGFuZyBkZXRlY3Rpb24gdGhhdCB3YXMgbWlzYmVoYXZpbmcgZm9yDQo+
PiB0aGUgWERQIGNhc2UsIG9yIGlzIHRoZXJlIGFuIHVuZGVybHlpbmcgaXNzdWUgd2l0aCB0
aGUgWERQIHF1ZXVlcyB0aGF0IGlzIG5vdA0KPj4gc29sdmVkIGJ5IGRpc2FibGluZyB0aGUg
ZGV0ZWN0aW9uIGZvciBpdD8NCj4gDQo+IEkgYmVsaWV2ZSB0aGF0IGNvcnJlY3Qgd2F5IHRv
IGFwcHJvYWNoIHRoaXMgaXMgdG8gbW92ZSB0aGUgVHggaGFuZw0KPiBkZXRlY3Rpb24gb250
byBpeGdiZV90eF90aW1lb3V0KCkgYXMgdGhhdCBpcyB0aGUgcGxhY2Ugd2hlcmUgdGhpcyBs
b2dpYw0KPiBiZWxvbmdzIHRvLiBCeSBkb2luZyBzbyBJIHN1cHBvc2Ugd2Ugd291bGQga2ls
bCB0d28gYmlyZHMgd2l0aCBvbmUgc3RvbmUNCj4gYXMgbWVudGlvbmVkIG5kbyBpcyBjYWxs
ZWQgdW5kZXIgbmV0ZGV2IHdhdGNoZG9nIHdoaWNoIGlzIG5vdCBhIHN1YmplY3QNCj4gZm9y
IFhEUCBUeCBxdWV1ZXMuDQo+IA0KPj4NCj4+IFdpdGggb3VyIGN1cnJlbnQgc2V0dXAgd2Ug
Y2Fubm90IHZlcmlmeSBhY2N1cmF0ZWx5LCB0aGF0IHdlIGhhdmUgbm8gcGFja2V0IGxvc3MN
Cj4+IG9yIHN0dWNrIHF1ZXVlcy4gV2UgY2FuIGRvIGFkZGl0aW9uYWwgdGVzdHMgdG8gdmVy
aWZ5IHRoYXQuDQoNCg0KSGkgTWFjaWVqLA0KDQpJJ20gYSBjb2xsZWFndWUgb2YgTWFyY3Vz
IGFuZCBpbnZvbHZlZCBpbiB0aGUgdGVzdGluZyBhcyB3ZWxsLg0KPj4+IEFkZGl0aW9uYWwg
cXVlc3Rpb24sIGRvIHlvdSBoYXZlIGVuYWJsZWQgcGF1c2UgZnJhbWVzIG9uIHlvdXIgc2V0
dXA/DQo+Pg0KPj4gUGF1c2UgZnJhbWVzIHdlcmUgZW5hYmxlZCwgYnV0IHdlIGNhbiBhbHNv
IHJlcHJvZHVjZSBpdCBhZnRlciBkaXNhYmxpbmcgdGhlbSwNCj4+IHdpdGhvdXQgeW91ciBw
YXRjaC4NCj4gDQo+IFBsZWFzZSBnaXZlIHlvdXIgc2V0dXAgYSBnbyB3aXRoIHBhdXNlIGZy
YW1lcyBlbmFibGVkIGFuZCBhcHBsaWVkIHBhdGNoDQo+IHRoYXQgaSBzaGFyZWQgcHJldmlv
dXNseSBhbmQgbGV0IHVzIHNlZSB0aGUgcmVzdWx0cy4gQXMgc2FpZCBhYm92ZSBJIGRvDQo+
IG5vdCB0aGluayBpdCBpcyBjb3JyZWN0IHRvIGNoZWNrIGZvciBodW5nIHF1ZXVlcyBpbiBU
eCBkZXNjcmlwdG9yIGNsZWFuaW5nDQo+IHJvdXRpbmUuIFRoaXMgaXMgYSBqb2Igb2YgbmRv
X3R4X3RpbWVvdXQgY2FsbGJhY2suDQo+IA0KDQpXZSBoYXZlIHRlc3RlZCB3aXRoIHBhdXNl
IGZyYW1lcyBlbmFibGVkIGFuZCBhcHBsaWVkIHBhdGNoIGFuZCBjYW4gbm90IA0KdHJpZ2dl
ciB0aGUgZXJyb3IgYW55bW9yZSBpbiBvdXIgbGFiIHNldHVwLg0KDQo+Pg0KPj4gVGhhbmtz
IQ0KPiANCj4gVGhhbmtzIGZvciBmZWVkYmFjayBhbmQgdGVzdGluZy4gSSdsbCBwcm92aWRl
IGEgcHJvcGVyIGZpeCB0b21vcnJvdyBhbmQgQ0MNCj4geW91IHNvIHlvdSBjb3VsZCB0YWtl
IGl0IGZvciBhIHNwaW4uDQo+IA0KDQpUaGF0IHNvdW5kcyBncmVhdC4gV2UnZCBiZSBoYXBw
eSB0byB0ZXN0IHdpdGggdGhlIHByb3BlciBmaXggaW4gb3VyIA0Kb3JpZ2luYWwgc2V0dXAu
DQoNClRoYW5rcywNClRvYmlhcw0K

--------------jQtsyF5GJ7I5LYtZkOUCTdnu--

--------------FBVEsp19lYY6MiVsUylR0Uiq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEEvXs8kNGp4Ny9+HQq4DXakT3pKoFAmgKEDgFAwAAAAAACgkQq4DXakT3pKrd
Ow//ThD6VbEvK2eVdSmvypPE9Yo7A4+Qts7Kq0/RdoWa0KJmvrogu6oL4hMHoGzngptREV4Vai/I
wcCWzhQwRFDwR8e6FKSICtWxQkkRZ1h69C34sI+f3jaYM8ukEOytJttqYvVqI1nih6iZ7mzD/Cw1
bB0sUEh7rL24ZQHYSVgGFZQsfTtNxCPEB9HCUnm9nxhR60uYcyU2DfNNUeoHQgEs1C1Fy4fMWlPb
YUDDV+f08jE5VOxKvOcuizioR+3WzrKi949d99MCuIecOhEGfd239xCtth6q84rTyO6EIDZSa6UD
vxERImn8h8jKWv7bcKUGis2BZPPHViutjZjTkFU8HMOMd/NAgAw4BwcqagJL9ufRi2R6SqY6EZML
Y2LbprOnWy/XyIQEOm4PAB0TjXiSSbpgbvZdpo5FlLmkf8hjQwN81No3GPswqIgZoJWMiwBeGEKk
O0krQiH0syuUgOcj3N/tviFd62Eo1b7BUqPnSc2iQclOPW6CvyQ1lUsXuClxZC2ZxoHJAK8YjxtP
mCrE7bWZz+Ac/mwIV8iGOQQnc3YCuQs0CFAoTWrim/j15n6LUze/LD+tl42a6vxBjJQMBS4ONRfj
bcBzANi+GAyK3KHEvN/zyCydn68nonYdbZRi8P4Lax/5U5yGaGwEhPnw0n/9YZhBM1CipABWZVzr
Hd0=
=d56T
-----END PGP SIGNATURE-----

--------------FBVEsp19lYY6MiVsUylR0Uiq--

