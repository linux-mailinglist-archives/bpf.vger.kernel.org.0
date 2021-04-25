Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6301D36A961
	for <lists+bpf@lfdr.de>; Sun, 25 Apr 2021 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhDYVKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Apr 2021 17:10:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54202 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhDYVKF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Apr 2021 17:10:05 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-PkwKK9X8NdyBSIEz6JCoUA-1; Sun, 25 Apr 2021 22:09:22 +0100
X-MC-Unique: PkwKK9X8NdyBSIEz6JCoUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sun, 25 Apr 2021 22:09:21 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Sun, 25 Apr 2021 22:09:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zack Weinberg' <zackw@panix.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] bpf.2: Use standard types and attributes
Thread-Topic: [RFC] bpf.2: Use standard types and attributes
Thread-Index: AQHXOJdJ6YNcCKeqkEK6KUcQdn8TZarEIdzggAFrTACAAC7GAA==
Date:   Sun, 25 Apr 2021 21:09:21 +0000
Message-ID: <600f0f5de9ff4bc887eec42d38113a8c@AcuMS.aculab.com>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <CAADnVQLf4qe3Hj7cjBUCY4wXb9t2ZjUt=Z=JuygRY0LNNHWAoA@mail.gmail.com>
 <78af3c302dd5447887f4a14cd4629119@AcuMS.aculab.com>
 <CAKCAbMgJBRKc+kszT-foDtOQC6Q1veOuxC_a1aX_Qt4PTCpEkg@mail.gmail.com>
In-Reply-To: <CAKCAbMgJBRKc+kszT-foDtOQC6Q1veOuxC_a1aX_Qt4PTCpEkg@mail.gmail.com>
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

RnJvbTogWmFjayBXZWluYmVyZw0KPiBTZW50OiAyNSBBcHJpbCAyMDIxIDIwOjE3DQo+IA0KPiBP
biBTYXQsIEFwciAyNCwgMjAyMSBhdCA0OjQzIFBNIERhdmlkIExhaWdodCB2aWEgTGliYy1hbHBo
YQ0KPiA8bGliYy1hbHBoYUBzb3VyY2V3YXJlLm9yZz4gd3JvdGU6DQo+ID4gRnJvbTogQWxleGVp
IFN0YXJvdm9pdG92DQo+ID4gPiBPbiBGcmksIEFwciAyMywgMjAyMSBhdCA0OjE1IFBNIEFsZWph
bmRybyBDb2xvbWFyIDxhbHgubWFucGFnZXNAZ21haWwuY29tPiB3cm90ZToNCj4gLi4uDQo+ID4g
PiA+IFNvbWUgcGFnZXMgYWxzbyBkb2N1bWVudCBhdHRyaWJ1dGVzLCB1c2luZyBHTlUgc3ludGF4
DQo+ID4gPiA+ICdfX2F0dHJpYnV0ZV9fKCh4eHgpKScuICBVcGRhdGUgdGhvc2UgdG8gdXNlIHRo
ZSBzaG9ydGVyIGFuZCBtb3JlDQo+ID4gPiA+IHBvcnRhYmxlIEMyeCBzeW50YXgsIHdoaWNoIGhh
c24ndCBiZWVuIHN0YW5kYXJkaXplZCB5ZXQsIGJ1dCBpcw0KPiA+ID4gPiBhbHJlYWR5IGltcGxl
bWVudGVkIGluIEdDQywgYW5kIGF2YWlsYWJsZSB0aHJvdWdoIGVpdGhlciAtLXN0ZD1jMngNCj4g
PiA+ID4gb3IgYW55IG9mIHRoZSAtLXN0ZD1nbnUuLi4gb3B0aW9ucy4NCj4gLi4NCj4gPiBBbmQg
dGhlIGNvZGUgYmVsb3cgaXMgbm8gbW9yZSBwb3J0YWJsZSB0aGF0IGEgI3ByYWdtYScuDQo+ID4g
SXQgaXMgcHJvYmFibHkgd29yc2UgdGhhbiBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKDgpKSkNCj4g
PiArICAgICAgICAgICAgdWludDY0X3QgW1tnbnU6OmFsaWduZWQoOCldXSB2YWx1ZTsNCj4gPiBU
aGUgc3RhbmRhcmRzIGNvbW1pdHRlZSBhcmUgc21va2luZyBkb3BlIGFnYWluLg0KPiA+IEF0IGxl
YXN0IHRoZSAnX19hbGlnbmVkX3U2NCB2YWx1ZTsnIGZvcm0gc3RhbmRzIGEgcmVhc29uYWJsZQ0K
PiA+IGNoYW5jZSBvZiBiZWluZyBjb252ZXJ0ZWQgYnkgY3BwIGludG8gd2hhdGV2ZXIgeW91ciBj
b21waWxlciBzdXBwb3J0cy4NCj4gDQo+IElzIGl0IGFjdHVhbGx5IG5lY2Vzc2FyeSB0byBtZW50
aW9uIHRoZSBhbGlnbm1lbnQgb3ZlcnJpZGVzIGF0IGFsbCBpbg0KPiB0aGUgbWFucGFnZXM/ICBU
aGV5IGFyZSBvbmx5IHJlbGV2YW50IHRvIHBlb3BsZSB3b3JraW5nIGF0IHRoZSBsZXZlbA0KPiBv
ZiBwaHlzaWNhbCBsYXlvdXQgb2YgdGhlIGRhdGEgaW4gUkFNLCBhbmQgdGhvc2UgcGVvcGxlIGFy
ZSBwcm9iYWJseQ0KPiBnb2luZyB0byBoYXZlIHRvIGNvbnN1bHQgdGhlIGhlYWRlciBmaWxlIGFu
eXdheS4NCg0KRGVwZW5kcywgaWYgdGhlIG1hbiBwYWdlIGRlZmluZXMgdGhlIHN0cnVjdHVyZSAt
IGl0IG5lZWRzIHRvDQpjb250YWluIGl0cyBkZWZpbml0aW9uLg0KSWYgdGhlb3J5IHRoZSBtYW4g
cGFnZSBvdWdodCB0byBiZSB0aGUgZGVmaW5pdGlvbiwgYW5kIHRoZSBjb2RlDQpkbyB3aGF0IHRo
ZSBtYW4gcGFnZSBzYXlzIGhhcHBlbnMuDQoNCkFuIGFsdGVybmF0aXZlIGlzIGZvciB0aGUgbWFu
IHBhZ2UgdG8gc2F5IHRoYXQgdGhlIHN0cnVjdHVyZQ0KY29udGFpbnMgc29tZSBmaWVsZHMgLSB3
aXRob3V0IHByZXNjcmliaW5nIHRoZSBvcmRlciwgb3INCnN0b3BwaW5nIHRoZSBpbXBsZW1lbnRh
dGlvbiBhZGRpbmcgYWRkaXRpb25hbCBmaWVsZHMgKG9yIGV2ZW4NCmNoYW5naW5nIHRoZSBhY3R1
YWwgbnVtZXJpYyB0eXBlKS4NClRoaXMgaXMgbW9yZSBjb21tb24gaW4gdGhlIHN0YW5kYXJkcyBk
b2N1bWVudHMuDQpJTUhPIFRoZSBMaW51eCBwYWdlcyByZWFsbHkgb3VnaHQgdG8gc2F5IGhvdyBs
aW51eCBkb2VzIHRoaW5ncy4NCihXaXRoIG5vdGVzIGFib3V0IHBvcnRhYmlsaXR5LikNCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

