Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6EB36A302
	for <lists+bpf@lfdr.de>; Sat, 24 Apr 2021 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhDXUoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Apr 2021 16:44:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:55768 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233485AbhDXUoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 24 Apr 2021 16:44:12 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-38-cob5SrwlO66mazRem5lY2w-1; Sat, 24 Apr 2021 21:43:31 +0100
X-MC-Unique: cob5SrwlO66mazRem5lY2w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 24 Apr 2021 21:43:30 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sat, 24 Apr 2021 21:43:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexei Starovoitov' <alexei.starovoitov@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>
CC:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: RE: [RFC] bpf.2: Use standard types and attributes
Thread-Topic: [RFC] bpf.2: Use standard types and attributes
Thread-Index: AQHXOJdJ6YNcCKeqkEK6KUcQdn8TZarEIdzg
Date:   Sat, 24 Apr 2021 20:43:30 +0000
Message-ID: <78af3c302dd5447887f4a14cd4629119@AcuMS.aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
In-Reply-To: <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RnJvbTogQWxleGVpIFN0YXJvdm9pdG92DQo+IFNlbnQ6IDI0IEFwcmlsIDIwMjEgMDA6MjANCj4g
DQo+IE9uIEZyaSwgQXByIDIzLCAyMDIxIGF0IDQ6MTUgUE0gQWxlamFuZHJvIENvbG9tYXINCj4g
PGFseC5tYW5wYWdlc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU29tZSBtYW51YWwgcGFn
ZXMgYXJlIGFscmVhZHkgdXNpbmcgQzk5IHN5bnRheCBmb3IgaW50ZWdyYWwNCj4gPiB0eXBlcyAn
dWludDMyX3QnLCBidXQgc29tZSBhcmVuJ3QuICBUaGVyZSBhcmUgc29tZSB1c2luZyBrZXJuZWwN
Cj4gPiBzeW50YXggJ19fdTMyJy4gIEZpeCB0aG9zZS4NCj4gPg0KPiA+IFNvbWUgcGFnZXMgYWxz
byBkb2N1bWVudCBhdHRyaWJ1dGVzLCB1c2luZyBHTlUgc3ludGF4DQo+ID4gJ19fYXR0cmlidXRl
X18oKHh4eCkpJy4gIFVwZGF0ZSB0aG9zZSB0byB1c2UgdGhlIHNob3J0ZXIgYW5kIG1vcmUNCj4g
PiBwb3J0YWJsZSBDMnggc3ludGF4LCB3aGljaCBoYXNuJ3QgYmVlbiBzdGFuZGFyZGl6ZWQgeWV0
LCBidXQgaXMNCj4gPiBhbHJlYWR5IGltcGxlbWVudGVkIGluIEdDQywgYW5kIGF2YWlsYWJsZSB0
aHJvdWdoIGVpdGhlciAtLXN0ZD1jMngNCj4gPiBvciBhbnkgb2YgdGhlIC0tc3RkPWdudS4uLiBv
cHRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxlamFuZHJvIENvbG9tYXIgPGFseC5t
YW5wYWdlc0BnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1hbjIvYnBmLjIgfCA0NyArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvbWFuMi9icGYuMiBiL21hbjIvYnBmLjINCj4gPiBpbmRleCA2ZTFmZmExOTguLjIwNGYw
MWJmYyAxMDA2NDQNCj4gPiAtLS0gYS9tYW4yL2JwZi4yDQo+ID4gKysrIGIvbWFuMi9icGYuMg0K
PiA+IEBAIC0xODgsMzkgKzE4OCwzOCBAQCBjb21tYW5kczoNCj4gPiAgLkVYDQo+ID4gIHVuaW9u
IGJwZl9hdHRyIHsNCj4gPiAgICAgIHN0cnVjdCB7ICAgIC8qIFVzZWQgYnkgQlBGX01BUF9DUkVB
VEUgKi8NCj4gPiAtICAgICAgICBfX3UzMiAgICAgICAgIG1hcF90eXBlOw0KPiA+IC0gICAgICAg
IF9fdTMyICAgICAgICAga2V5X3NpemU7ICAgIC8qIHNpemUgb2Yga2V5IGluIGJ5dGVzICovDQo+
ID4gLSAgICAgICAgX191MzIgICAgICAgICB2YWx1ZV9zaXplOyAgLyogc2l6ZSBvZiB2YWx1ZSBp
biBieXRlcyAqLw0KPiA+IC0gICAgICAgIF9fdTMyICAgICAgICAgbWF4X2VudHJpZXM7IC8qIG1h
eGltdW0gbnVtYmVyIG9mIGVudHJpZXMNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbiBhIG1hcCAqLw0KPiA+ICsgICAgICAgIHVpbnQzMl90ICAgIG1hcF90eXBl
Ow0KPiA+ICsgICAgICAgIHVpbnQzMl90ICAgIGtleV9zaXplOyAgICAvKiBzaXplIG9mIGtleSBp
biBieXRlcyAqLw0KPiA+ICsgICAgICAgIHVpbnQzMl90ICAgIHZhbHVlX3NpemU7ICAvKiBzaXpl
IG9mIHZhbHVlIGluIGJ5dGVzICovDQo+ID4gKyAgICAgICAgdWludDMyX3QgICAgbWF4X2VudHJp
ZXM7IC8qIG1heGltdW0gbnVtYmVyIG9mIGVudHJpZXMNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW4gYSBtYXAgKi8NCj4gDQo+IE5hY2suDQo+IFRoZSBtYW4gcGFn
ZSBzaG91bGQgZGVzY3JpYmUgdGhlIGtlcm5lbCBhcGkgdGhlIHdheSBpdCBpcyBpbiAuaCBmaWxl
Lg0KDQpBbmQgdGhlIGNvZGUgYmVsb3cgaXMgbm8gbW9yZSBwb3J0YWJsZSB0aGF0IGEgI3ByYWdt
YScuDQpJdCBpcyBwcm9iYWJseSB3b3JzZSB0aGFuIF9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkp
KQ0KKyAgICAgICAgICAgIHVpbnQ2NF90IFtbZ251OjphbGlnbmVkKDgpXV0gdmFsdWU7DQpUaGUg
c3RhbmRhcmRzIGNvbW1pdHRlZSBhcmUgc21va2luZyBkb3BlIGFnYWluLg0KQXQgbGVhc3QgdGhl
ICdfX2FsaWduZWRfdTY0IHZhbHVlOycgZm9ybSBzdGFuZHMgYSByZWFzb25hYmxlDQpjaGFuY2Ug
b2YgYmVpbmcgY29udmVydGVkIGJ5IGNwcCBpbnRvIHdoYXRldmVyIHlvdXIgY29tcGlsZXIgc3Vw
cG9ydHMuDQoNCk9UT0ggdGhlIGJmcCBkZXZlbG9wZXJzIHdhbnQgc2hvb3RpbmcgZm9yIGRlZmlu
aW5nIGEgc3RydWN0dXJlDQp3aXRoIGhpZGRlbiBwYWRkaW5nIGZpZWxkcy4NCkl0IHRoZXkgZW5z
dXJlZCB0aGF0IGFsbCA2NGJpdCBmaWVsZHMgd2VyZSBhbGlnbmVkIHRoZXkgd291bGRuJ3QNCm5l
ZWQgdGhlIF9fYWxpZ25lZF91NjQgYXQgYWxsLg0KQW5kIHdvdWxkIGJlIG11Y2ggbGVzcyBsaWtl
bHkgdG8gbGVhayBrZXJuZWwgc3RhY2sgdG8gdXNlcnNwYWNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

