Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DE30DB14
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 14:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBCN0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 08:26:13 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59565 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBCN0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 08:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612358761; x=1643894761;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Gp80cUmjGr5/KU8OHavpK+O80xdDpEOr82Q7YsK7mvU=;
  b=C97ijhbXoUd7QLZA6FAclajG0Lju7B8OpFMVWmtu+7enbByFD96vSgzm
   MptHpex0TNjFfooP2nVTfvJ1gTgFtsQIydcyFqyz0RtmhPbvrTNVSGt1B
   snMSNQqc1BmltSZX4Qp4BNQu+U1kNZENy5ull2U5MbEaxsLQPTmsQdl1O
   Q=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="82168623"
Subject: RE: [PATCH v6 bpf-next 0/8] mvneta: introduce XDP multi-buffer support
Thread-Topic: [PATCH v6 bpf-next 0/8] mvneta: introduce XDP multi-buffer support
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Feb 2021 13:25:14 +0000
Received: from EX13D08EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id C5BCFA1E4E;
        Wed,  3 Feb 2021 13:25:09 +0000 (UTC)
Received: from EX13D11EUB003.ant.amazon.com (10.43.166.58) by
 EX13D08EUB003.ant.amazon.com (10.43.166.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 13:25:08 +0000
Received: from EX13D11EUB003.ant.amazon.com ([10.43.166.58]) by
 EX13D11EUB003.ant.amazon.com ([10.43.166.58]) with mapi id 15.00.1497.010;
 Wed, 3 Feb 2021 13:25:08 +0000
From:   "Jubran, Samih" <sameehj@amazon.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "echaudro@redhat.com" <echaudro@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        "Tzalik, Guy" <gtzalik@amazon.com>,
        "Dagan, Noam" <ndagan@amazon.com>
Thread-Index: AQHW7qDbcn7HoHuFvk2/iHkAqaEAkqo0ac+AgA2kkoCABHNUAA==
Date:   Wed, 3 Feb 2021 13:24:52 +0000
Deferred-Delivery: Wed, 3 Feb 2021 13:24:11 +0000
Message-ID: <0e4cc3156ec14f3bac9a58096a2feae4@EX13D11EUB003.ant.amazon.com>
References: <cover.1611086134.git.lorenzo@kernel.org>
 <572556bb-845f-1b4a-8f0a-fb6a4fc286e3@iogearbox.net>
 <20210131172341.GA6003@lore-desk>
In-Reply-To: <20210131172341.GA6003@lore-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTG9yZW56byBCaWFuY29u
aSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkgMzEsIDIwMjEg
NzoyNCBQTQ0KPiBUbzogRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4NCj4g
Q2M6IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxvcmVu
em8uYmlhbmNvbmlAcmVkaGF0LmNvbTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwu
b3JnOw0KPiBhc3RAa2VybmVsLm9yZzsgQWdyb3NraW4sIFNoYXkgPHNoYXlhZ3JAYW1hem9uLmNv
bT47DQo+IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsgZHNhaGVybkBrZXJuZWwub3JnOyBicm91
ZXJAcmVkaGF0LmNvbTsNCj4gZWNoYXVkcm9AcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNv
bTsNCj4gYWxleGFuZGVyLmR1eWNrQGdtYWlsLmNvbTsgc2FlZWRAa2VybmVsLm9yZzsNCj4gbWFj
aWVqLmZpamFsa293c2tpQGludGVsLmNvbTsgSnVicmFuLCBTYW1paCA8c2FtZWVoakBhbWF6b24u
Y29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBbUEFUQ0ggdjYgYnBmLW5leHQgMC84XSBt
dm5ldGE6IGludHJvZHVjZSBYRFANCj4gbXVsdGktYnVmZmVyIHN1cHBvcnQNCj4gDQo+ID4gSGkg
TG9yZW56bywNCj4gDQo+IEhpIERhbmllbCwNCj4gDQo+IHNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+
IA0KPiA+DQo+ID4gT24gMS8xOS8yMSA5OjIwIFBNLCBMb3JlbnpvIEJpYW5jb25pIHdyb3RlOg0K
PiA+ID4gVGhpcyBzZXJpZXMgaW50cm9kdWNlIFhEUCBtdWx0aS1idWZmZXIgc3VwcG9ydC4gVGhl
IG12bmV0YSBkcml2ZXIgaXMNCj4gPiA+IHRoZSBmaXJzdCB0byBzdXBwb3J0IHRoZXNlIG5ldyAi
bm9uLWxpbmVhciIgeGRwX3tidWZmLGZyYW1lfS4NCj4gPiA+IFJldmlld2VycyBwbGVhc2UgZm9j
dXMgb24gaG93IHRoZXNlIG5ldyB0eXBlcyBvZiB4ZHBfe2J1ZmYsZnJhbWV9DQo+ID4gPiBwYWNr
ZXRzIHRyYXZlcnNlIHRoZSBkaWZmZXJlbnQgbGF5ZXJzIGFuZCB0aGUgbGF5b3V0IGRlc2lnbi4g
SXQgaXMNCj4gPiA+IG9uIHB1cnBvc2UgdGhhdCBCUEYtaGVscGVycyBhcmUga2VwdCBzaW1wbGUs
IGFzIHdlIGRvbid0IHdhbnQgdG8NCj4gPiA+IGV4cG9zZSB0aGUgaW50ZXJuYWwgbGF5b3V0IHRv
IGFsbG93IGxhdGVyIGNoYW5nZXMuDQo+ID4gPg0KPiA+ID4gRm9yIG5vdywgdG8ga2VlcCB0aGUg
ZGVzaWduIHNpbXBsZSBhbmQgdG8gbWFpbnRhaW4gcGVyZm9ybWFuY2UsIHRoZQ0KPiA+ID4gWERQ
IEJQRi1wcm9nIChzdGlsbCkgb25seSBoYXZlIGFjY2VzcyB0byB0aGUgZmlyc3QtYnVmZmVyLiBJ
dCBpcw0KPiA+ID4gbGVmdCBmb3IgbGF0ZXIgKGFub3RoZXIgcGF0Y2hzZXQpIHRvIGFkZCBwYXls
b2FkIGFjY2VzcyBhY3Jvc3MgbXVsdGlwbGUNCj4gYnVmZmVycy4NCj4gPg0KPiA+IEkgdGhpbmsg
eG1hcyBicmVhayBoYXMgbW9zdGx5IHdpcGVkIG15IG1lbW9yeSBmcm9tIDIwMjAgOykgc28gaXQg
d291bGQNCj4gPiBiZSBnb29kIHRvIGRlc2NyaWJlIHRoZSBza2V0Y2hlZCBvdXQgZGVzaWduIGZv
ciBob3cgdGhpcyB3aWxsIGxvb2sNCj4gPiBsaWtlIGluc2lkZSB0aGUgY292ZXIgbGV0dGVyIGlu
IHRlcm1zIG9mIHBsYW5uZWQgdWFwaSBleHBvc3VyZS4NCj4gPiAoQWRkaXRpb25hbGx5IGRpc2N1
c3NpbmcgYXBpIGRlc2lnbiBwcm9wb3NhbCBjb3VsZCBhbHNvIGJlIHN0aCBmb3IgQlBGDQo+ID4g
b2ZmaWNlIGhvdXIgdG8gbW92ZSB0aGluZ3MgcXVpY2tlciArIHBvc3RpbmcgYSBzdW1tYXJ5IHRv
IHRoZSBsaXN0IGZvcg0KPiA+IHRyYW5zcGFyZW5jeSBvZiBjb3Vyc2UgLi4ganVzdCBhIHRob3Vn
aHQuKQ0KPiANCj4gSSBndWVzcyB0aGUgbWFpbiBnb2FsIG9mIHRoaXMgc2VyaWVzIGlzIHRvIGFk
ZCB0aGUgbXVsdGktYnVmZmVyIHN1cHBvcnQgdG8gdGhlDQo+IHhkcCBjb3JlIChlLmcuIGluIHhk
cF9mcmFtZS94ZHBfYnVmZiBvciBpbiB4ZHBfcmV0dXJuX3tidWZmL2ZyYW1lfSkgYW5kIHRvDQo+
IHByb3ZpZGUgdGhlIGZpcnN0IGRyaXZlciB3aXRoIHhkcCBtdWx0LWlidWZmIHN1cHBvcnQuIFdl
IHRyaWVkIHRvIG1ha2UgdGhlDQo+IGNoYW5nZXMgaW5kZXBlbmRlbnQgZnJvbSBlQlBGIGhlbHBl
cnMgc2luY2Ugd2UgZG8gbm90IGhhdmUgZGVmaW5lZCB1c2UNCj4gY2FzZXMgZm9yIHRoZW0geWV0
IGFuZCB3ZSBkb24ndCB3YW50IHRvIGV4cG9zZSB0aGUgaW50ZXJuYWwgbGF5b3V0IHRvIGFsbG93
DQo+IGxhdGVyIGNoYW5nZXMuDQo+IE9uZSBwb3NzaWJsZSBleGFtcGxlIGlzIGJwZl94ZHBfYWRq
dXN0X21iX2hlYWRlcigpIGhlbHBlciB3ZSBzZW50IGluIHYyDQo+IHBhdGNoIDYvOSBbMF0gdG8g
dHJ5IHRvIGFkZHJlc3MgdXNlLWNhc2UgZXhwbGFpbmVkIGJ5IEVyaWMgQCBOZXREZXYgMHgxNCBb
MV0uDQo+IEFueXdheSBJIGFncmVlIHRoZXJlIGFyZSBzb21lIG1pc3NpbmcgYml0cyB3ZSBuZWVk
IHRvIGFkZHJlc3MgKGUuZy4gd2hhdCBpcw0KPiB0aGUgYmVoYXZpb3VyIHdoZW4gd2UgcmVkaXJl
Y3QgYSBtYiB4ZHBfZnJhbWUgdG8gYSBkcml2ZXIgbm90IHN1cHBvcnRpbmcNCj4gaXQ/KQ0KPiAN
Cj4gQWNrLCBJIGFncmVlIHdlIGNhbiBkaXNjdXNzIGFib3V0IG1iIGVCUEYgaGVscGVyIEFQSXMg
aW4gQlBGIG9mZmljZSBob3VyIG10Zw0KPiBpbiBvcmRlciB0byBzcGVlZC11cCB0aGUgcHJvY2Vz
cy4NCj4gDQo+ID4NCj4gPiBHbGFuY2luZyBvdmVyIHRoZSBzZXJpZXMsIHdoaWxlIHlvdSd2ZSBh
ZGRyZXNzZWQgdGhlDQo+ID4gYnBmX3hkcF9hZGp1c3RfdGFpbCgpIGhlbHBlciBBUEksIHRoaXMg
c2VyaWVzIHdpbGwgYmUgYnJlYWtpbmcgb25lDQo+ID4gYXNzdW1wdGlvbiBvZiBwcm9ncmFtcyBh
dCBsZWFzdCBmb3IgdGhlIG12bmV0YSBkcml2ZXIgZnJvbSBvbmUga2VybmVsDQo+ID4gdG8gYW5v
dGhlciBpZiB5b3UgdGhlbiB1c2UgdGhlIG11bHRpIGJ1ZmYgbW9kZSwgYW5kIHRoYXQgaXMgYmFz
aWNhbGx5DQo+ID4gYnBmX3hkcF9ldmVudF9vdXRwdXQoKSBBUEk6IHRoZSBhc3N1bXB0aW9uIGlz
IHRoYXQgeW91IGNhbiBkbyBmdWxsDQo+ID4gcGFja2V0IGNhcHR1cmUgYnkgcGFzc2luZyBpbiB0
aGUgeGRwIGJ1ZmYgbGVuIHRoYXQgaXMgZGF0YV9lbmQgLSBkYXRhDQo+ID4gcHRyLiBXZSB1c2Ug
aXQgdGhpcyB3YXkgZm9yIHNhbXBsaW5nICYgb3RoZXJzIG1pZ2h0IGFzIHdlbGwgKGUuZy4NCj4g
PiB4ZHBjYXApLiBCdXQgYnBmX3hkcF9jb3B5KCkgd291bGQgb25seSBjb3B5IHRoZSBmaXJzdCBi
dWZmZXIgdG9kYXkNCj4gPiB3aGljaCB3b3VsZCBicmVhayB0aGUgZnVsbCBwa3QgdmlzaWJpbGl0
eSBhc3N1bXB0aW9uLiBKdXN0IHdhbGtpbmcgdGhlDQo+ID4gZnJhZ3MgaWYNCj4gPiB4ZHAtPm1i
IGJpdCBpcyBzZXQgd291bGQgc3RpbGwgbmVlZCBzb21lIHNvcnQgb2Ygc3RydWN0IHhkcF9tZA0K
PiA+IHhkcC0+ZXhwb3N1cmUgc28NCj4gPiB0aGUgcHJvZyBjYW4gZmlndXJlIG91dCB0aGUgYWN0
dWFsIGZ1bGwgc2l6ZS4uDQo+IA0KPiBhY2ssIHRoeCBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIEkg
d2lsbCB0YWtlIGEgbG9vayB0byBpdC4NCj4gRWVsY28gYWRkZWQgeGRwX2xlbiB0byB4ZHBfbWQg
aW4gdGhlIHByZXZpb3VzIHNlcmllcyAoaGUgaXMgc3RpbGwgd29ya2luZyBvbg0KPiBpdCkuIEFu
b3RoZXIgcG9zc2libGUgYXBwcm9hY2ggd291bGQgYmUgZGVmaW5pbmcgYSBoZWxwZXIsIHdoYXQg
ZG8geW91DQo+IHRoaW5rPw0KPiANCj4gPg0KPiA+ID4gVGhpcyBwYXRjaHNldCBzaG91bGQgc3Rp
bGwgYWxsb3cgZm9yIHRoZXNlIGZ1dHVyZSBleHRlbnNpb25zLiBUaGUNCj4gPiA+IGdvYWwgaXMg
dG8gbGlmdCB0aGUgWERQIE1UVSByZXN0cmljdGlvbiB0aGF0IGNvbWVzIHdpdGggWERQLCBidXQN
Cj4gPiA+IG1haW50YWluIHNhbWUgcGVyZm9ybWFuY2UgYXMgYmVmb3JlLg0KPiA+ID4NCj4gPiA+
IFRoZSBtYWluIGlkZWEgZm9yIHRoZSBuZXcgbXVsdGktYnVmZmVyIGxheW91dCBpcyB0byByZXVz
ZSB0aGUgc2FtZQ0KPiA+ID4gbGF5b3V0IHVzZWQgZm9yIG5vbi1saW5lYXIgU0tCLiBXZSBpbnRy
b2R1Y2VkIGEgInhkcF9zaGFyZWRfaW5mbyINCj4gPiA+IGRhdGEgc3RydWN0dXJlIGF0IHRoZSBl
bmQgb2YgdGhlIGZpcnN0IGJ1ZmZlciB0byBsaW5rIHRvZ2V0aGVyIHN1YnNlcXVlbnQNCj4gYnVm
ZmVycy4NCj4gPiA+IHhkcF9zaGFyZWRfaW5mbyB3aWxsIGFsaWFzIHNrYl9zaGFyZWRfaW5mbyBh
bGxvd2luZyB0byBrZWVwIG1vc3Qgb2YNCj4gPiA+IHRoZSBmcmFncyBpbiB0aGUgc2FtZSBjYWNo
ZS1saW5lICh3aGlsZSB3aXRoIHNrYl9zaGFyZWRfaW5mbyBvbmx5DQo+ID4gPiB0aGUgZmlyc3Qg
ZnJhZ21lbnQgd2lsbCBiZSBwbGFjZWQgaW4gdGhlIGZpcnN0ICJzaGFyZWRfaW5mbyINCj4gPiA+
IGNhY2hlLWxpbmUpLiBNb3Jlb3ZlciB3ZSBpbnRyb2R1Y2VkIHNvbWUgeGRwX3NoYXJlZF9pbmZv
IGhlbHBlcnMNCj4gYWxpZ25lZCB0byBza2JfZnJhZyogb25lcy4NCj4gPiA+IENvbnZlcnRpbmcg
eGRwX2ZyYW1lIHRvIFNLQiBhbmQgZGVsaXZlciBpdCB0byB0aGUgbmV0d29yayBzdGFjayBpcw0K
PiA+ID4gc2hvd24gaW4gY3B1bWFwIGNvZGUgKHBhdGNoIDcvOCkuIEJ1aWxkaW5nIHRoZSBTS0Is
IHRoZQ0KPiA+ID4geGRwX3NoYXJlZF9pbmZvIHN0cnVjdHVyZSB3aWxsIGJlIGNvbnZlcnRlZCBp
biBhIHNrYl9zaGFyZWRfaW5mbyBvbmUuDQo+ID4gPg0KPiA+ID4gQSBtdWx0aS1idWZmZXIgYml0
IChtYikgaGFzIGJlZW4gaW50cm9kdWNlZCBpbiB4ZHBfe2J1ZmYsZnJhbWV9DQo+ID4gPiBzdHJ1
Y3R1cmUgdG8gbm90aWZ5IHRoZSBicGYvbmV0d29yayBsYXllciBpZiB0aGlzIGlzIGEgeGRwDQo+
ID4gPiBtdWx0aS1idWZmZXIgZnJhbWUgKG1iID0gMSkgb3Igbm90IChtYiA9IDApLg0KPiA+ID4g
VGhlIG1iIGJpdCB3aWxsIGJlIHNldCBieSBhIHhkcCBtdWx0aS1idWZmZXIgY2FwYWJsZSBkcml2
ZXIgb25seSBmb3INCj4gPiA+IG5vbi1saW5lYXIgZnJhbWVzIG1haW50YWluaW5nIHRoZSBjYXBh
YmlsaXR5IHRvIHJlY2VpdmUgbGluZWFyDQo+ID4gPiBmcmFtZXMgd2l0aG91dCBhbnkgZXh0cmEg
Y29zdCBzaW5jZSB0aGUgeGRwX3NoYXJlZF9pbmZvIHN0cnVjdHVyZSBhdA0KPiA+ID4gdGhlIGVu
ZCBvZiB0aGUgZmlyc3QgYnVmZmVyIHdpbGwgYmUgaW5pdGlhbGl6ZWQgb25seSBpZiBtYiBpcyBz
ZXQuDQo+ID4gPg0KPiA+ID4gVHlwaWNhbCB1c2UgY2FzZXMgZm9yIHRoaXMgc2VyaWVzIGFyZToN
Cj4gPiA+IC0gSnVtYm8tZnJhbWVzDQo+ID4gPiAtIFBhY2tldCBoZWFkZXIgc3BsaXQgKHBsZWFz
ZSBzZWUgR29vZ2xl4oCZcyB1c2UtY2FzZSBAIE5ldERldkNvbmYNCj4gPiA+IDB4MTQsIFswXSkN
Cj4gPiA+IC0gVFNPDQo+ID4gPg0KPiA+ID4gYnBmX3hkcF9hZGp1c3RfdGFpbCBoZWxwZXIgaGFz
IGJlZW4gbW9kaWZpZWQgdG8gdGFrZSBpbmZvIGFjY291bnQNCj4gPiA+IHhkcCBtdWx0aS1idWZm
IGZyYW1lcy4NCj4gPg0KPiA+IEFsc28gaW4gdGVybXMgb2YgbG9naXN0aWNzIChJIHRoaW5rIG1l
bnRpb25lZCBlYXJsaWVyIGFscmVhZHkpLCBmb3INCj4gPiB0aGUgc2VyaWVzIHRvIGJlIG1lcmdl
ZCAtIGFzIHdpdGggb3RoZXIgbmV0d29ya2luZyBmZWF0dXJlcyBzcGFubmluZw0KPiA+IGNvcmUg
KyBkcml2ZXIgKGV4YW1wbGUNCj4gPiBhZl94ZHApIC0gd2UgYWxzbyBuZWVkIGEgc2Vjb25kIGRy
aXZlciAoaWRlYWxseSBtbHg1LCBpNDBlIG9yIGljZSkNCj4gPiBpbXBsZW1lbnRpbmcgdGhpcyBh
bmQgaWRlYWxseSBiZSBzdWJtaXR0ZWQgdG9nZXRoZXIgaW4gdGhlIHNhbWUgc2VyaWVzDQo+ID4g
Zm9yIHJldmlldy4gRm9yIHRoYXQgaXQgcHJvYmFibHkgYWxzbyBtYWtlcyBzZW5zZSB0byBtb3Jl
IGNsZWFubHkNCj4gPiBzcGxpdCBvdXQgdGhlIGNvcmUgcGllY2VzIGZyb20gdGhlIGRyaXZlciBv
bmVzLiBFaXRoZXIgd2F5LCBob3cgaXMgcHJvZ3Jlc3MNCj4gb24gdGhhdCBzaWRlIGNvbWluZyBh
bG9uZz8NCj4gDQo+IEkgZG8gbm90IGhhdmUgYW55IHVwZGF0ZWQgbmV3cyBhYm91dCBpdCBzbyBm
YXIsIGJ1dCBhZmFpayBhbWF6b24gZm9sa3Mgd2VyZQ0KPiB3b3JraW5nIG9uIGFkZGluZyBtYiBz
dXBwb3J0IHRvIGVuYSBkcml2ZXIsIHdoaWxlIGludGVsIHdhcyBwbGFubmluZyB0byBhZGQNCj4g
aXQgdG8gYWZfeGRwLg0KSGkgYWxsLA0KDQpUaGUgRU5BIFhEUCBNQiBpbXBsZW1lbnRhdGlvbiBp
cyBjdXJyZW50bHkgYmVpbmcgcmViYXNlZCBvbiB0b3Agb2YgdGhpcw0Kc2VyaWVzLiBXZSBhcmUg
aW4gZmluYWwgc3RhZ2VzIG9mIHBvbGlzaGluZyBhbmQgdGVzdGluZyB0aGUgY29kZSBhbmQNCmxv
b2tpbmcgZm9yd2FyZCB0byBzZW5kIGl0IGZvciByZXZpZXcsIGhvcGVmdWxseSB0aWxsIHRoZSBl
bmQgb2YgTWFyY2guDQoNCj4gTW9yZW92ZXIgSmFzb24gd2FzIGxvb2tpbmcgdG8gYWRkIGl0IHRv
IHZpcnRpby1uZXQuDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IERhbmllbA0KPiANCj4gUmVn
YXJkcywNCj4gTG9yZW56bw0KPg0KQmVzdCByZWdhcmRzLA0KU2FtZWVoDQogDQo+IFswXQ0KPiBo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbmV0ZGV2L3BhdGNoL2I3NDc1Njg3
YmIwOWFhYzZlYzA1DQo+IDE1OTZhOGNjYmIzMTFhNTRjYjhhLjE1OTkxNjUwMzEuZ2l0LmxvcmVu
em9Aa2VybmVsLm9yZy8NCj4gWzFdIGh0dHBzOi8vbmV0ZGV2Y29uZi5pbmZvLzB4MTQvc2Vzc2lv
bi5odG1sP3RhbGstdGhlLXBhdGgtdG8tdGNwLTRrLW10dS0NCj4gYW5kLXJ4LXplcm9jb3B5DQo=
