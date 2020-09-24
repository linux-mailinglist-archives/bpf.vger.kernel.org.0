Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6242773C8
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgIXOUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 10:20:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55392 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727859AbgIXOUO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 10:20:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-218-ndXhimk2PgyG-5cmTZlPGg-1; Thu, 24 Sep 2020 15:20:10 +0100
X-MC-Unique: ndXhimk2PgyG-5cmTZlPGg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 24 Sep 2020 15:20:09 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 24 Sep 2020 15:20:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'YiFei Zhu' <zhuyifei1999@gmail.com>
CC:     "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: RE: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Thread-Topic: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Thread-Index: AQHWknD17ZW/yCPmvkCTJZb3HlQhMal3ymow///6ngCAABEUAA==
Date:   Thu, 24 Sep 2020 14:20:09 +0000
Message-ID: <665ea57e360a421c958fffa08da77920@AcuMS.aculab.com>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
 <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com>
 <CABqSeASWf_CArdOzASLeRBPZQ-S_vtinhZLteYng4iAof4py+w@mail.gmail.com>
In-Reply-To: <CABqSeASWf_CArdOzASLeRBPZQ-S_vtinhZLteYng4iAof4py+w@mail.gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RnJvbTogWWlGZWkgWmh1DQo+IFNlbnQ6IDI0IFNlcHRlbWJlciAyMDIwIDE1OjE3DQo+IA0KPiBP
biBUaHUsIFNlcCAyNCwgMjAyMCBhdCA4OjQ3IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+IEkgZG91YnQgdGhlIGNvbXBpbGVyIHdpbGwgZG8gd2hh
dCB5b3Ugd2FudC4NCj4gPiBMb29raW5nIGF0IGl0LCBpbiBtb3N0IGNhc2VzIHRoZXJlIGFyZSBv
bmUgb3IgdHdvIGVudHJpZXMuDQo+ID4gSSB0aGluayBvbmx5IE1JUFMgaGFzIHRocmVlLg0KPiAN
Cj4gSXQgZG9lcyA7KSBHQ0MgMTAuMi4wOg0KPiANCj4gJCBvYmpkdW1wIC1kIGtlcm5lbC9zZWNj
b21wLm8gfCBsZXNzDQo+IFsuLi5dDQo+IDAwMDAwMDAwMDAwMDE1MjAgPF9fc2VjY29tcF9maWx0
ZXI+Og0KPiBbLi4uXQ0KPiAgICAgMTU4NzogICAgICAgNDEgOGIgNTQgMjQgMDQgICAgICAgICAg
bW92ICAgIDB4NCglcjEyKSwlZWR4DQo+ICAgICAxNThjOiAgICAgICBiOSAwOCAwMSAwMCAwMCAg
ICAgICAgICBtb3YgICAgJDB4MTA4LCVlY3gNCj4gICAgIDE1OTE6ICAgICAgIDgxIGZhIDNlIDAw
IDAwIGMwICAgICAgIGNtcCAgICAkMHhjMDAwMDAzZSwlZWR4DQo+ICAgICAxNTk3OiAgICAgICA3
NSAyZSAgICAgICAgICAgICAgICAgICBqbmUgICAgMTVjNyA8X19zZWNjb21wX2ZpbHRlcisweGE3
Pg0KPiBbLi4uXQ0KPiAgICAgMTVjNzogICAgICAgODEgZmEgMDMgMDAgMDAgNDAgICAgICAgY21w
ICAgICQweDQwMDAwMDAzLCVlZHgNCj4gICAgIDE1Y2Q6ICAgICAgIGI5IDQwIDAxIDAwIDAwICAg
ICAgICAgIG1vdiAgICAkMHgxNDAsJWVjeA0KPiAgICAgMTVkMjogICAgICAgNzQgYzUgICAgICAg
ICAgICAgICAgICAgamUgICAgIDE1OTkgPF9fc2VjY29tcF9maWx0ZXIrMHg3OT4NCj4gICAgIDE1
ZDQ6ICAgICAgIDBmIDBiICAgICAgICAgICAgICAgICAgIHVkMg0KPiBbLi4uXQ0KPiAwMDAwMDAw
MDAwMDAxY2IwIDxzZWNjb21wX2NhY2hlX3ByZXBhcmU+Og0KPiBbLi4uXQ0KPiAgICAgMWNjNDog
ICAgICAgNDEgYjkgM2UgMDAgMDAgYzAgICAgICAgbW92ICAgICQweGMwMDAwMDNlLCVyOWQNCj4g
Wy4uLl0NCj4gICAgIDFkYmE6ICAgICAgIDQxIGI5IDAzIDAwIDAwIDQwICAgICAgIG1vdiAgICAk
MHg0MDAwMDAwMywlcjlkDQo+IFsuLi5dDQo+IDAwMDAwMDAwMDAwMDJlMzAgPHByb2NfcGlkX3Nl
Y2NvbXBfY2FjaGU+Og0KPiBbLi4uXQ0KPiAgICAgMmU3MjogICAgICAgYmEgM2UgMDAgMDAgYzAg
ICAgICAgICAgbW92ICAgICQweGMwMDAwMDNlLCVlZHgNCj4gWy4uLl0NCj4gICAgIDJlYjU6ICAg
ICAgIGJhIDAzIDAwIDAwIDQwICAgICAgICAgIG1vdiAgICAkMHg0MDAwMDAwMywlZWR4DQo+IA0K
PiBHcmFudGVkLCBJIGhhdmUgQ0NfT1BUSU1JWkVfRk9SX1BFUkZPUk1BTkNFIHJhdGhlciB0aGFu
DQo+IENDX09QVElNSVpFX0ZPUl9TSVpFLCBidXQgdGhpcyBwYXRjaCBpdHNlbGYgaXMgdHJ5aW5n
IHRvIHNhY3JpZmljZQ0KPiBzb21lIG9mIHRoZSBtZW1vcnkgZm9yIHNwZWVkLg0KDQpEb24ndCBi
b3RoIENDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRSAoLT8/KSBhbmQgQ0NfT1BUSU1JWkVfRk9S
X1NJWkUgKC1zKQ0KZ2VuZXJhdGUgdGVycmlibGUgY29kZT8NCg0KVHJ5IHdpdGggYSBzbGdodGx5
IG9sZGVyIGdjYy4NCkkgdGhpbmsgdGhhdCBlbnRpcmUgb3B0aW1pc2F0aW9uIChkaXNjYXJkaW5n
IGNvbnN0IGFycmF5cykNCmlzIHZlcnkgcmVjZW50Lg0KDQoJRGF2aWQNCiANCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

