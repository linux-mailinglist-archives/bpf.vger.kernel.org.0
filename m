Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31A1132EEB
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAGTBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 14:01:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:46496 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGTBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 14:01:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 11:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="223297319"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2020 11:01:45 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.41]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.176]) with mapi id 14.03.0439.000;
 Tue, 7 Jan 2020 11:01:45 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@amacapital.net" <luto@amacapital.net>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "namit@vmware.com" <namit@vmware.com>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Thread-Topic: [PATCH bpf-next] bpf: Make trampolines W^X
Thread-Index: AQHVwpjLpCzVLdPZ5Em9CS0HIZ/iOKfewVwAgAA1aoCAASP/gA==
Date:   Tue, 7 Jan 2020 19:01:44 +0000
Message-ID: <cdd157ef011efda92c9434f76141fc3aef174d85.camel@intel.com>
References: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
         <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net>
In-Reply-To: <DB882EE8-20B2-4631-A808-E5C968B24CEB@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE01A131372B9D4684BF9EC8078CC1AB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Q0MgTmFkYXYgYW5kIEplc3NpY2EuDQoNCk9uIE1vbiwgMjAyMC0wMS0wNiBhdCAxNTozNiAtMTAw
MCwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiA+IE9uIEphbiA2LCAyMDIwLCBhdCAxMjoyNSBQ
TSwgRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IHdy
b3RlOg0KPiA+IA0KPiA+IO+7v09uIFNhdCwgMjAyMC0wMS0wNCBhdCAwOTo0OSArMDkwMCwgQW5k
eSBMdXRvbWlyc2tpIHdyb3RlOg0KPiA+ID4gPiA+IE9uIEphbiA0LCAyMDIwLCBhdCA4OjQ3IEFN
LCBLUCBTaW5naCA8a3BzaW5naEBjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+
ID4g77u/RnJvbTogS1AgU2luZ2ggPGtwc2luZ2hAZ29vZ2xlLmNvbT4NCj4gPiA+ID4gDQo+ID4g
PiA+IFRoZSBpbWFnZSBmb3IgdGhlIEJQRiB0cmFtcG9saW5lcyBpcyBhbGxvY2F0ZWQgd2l0aA0K
PiA+ID4gPiBicGZfaml0X2FsbG9jX2V4ZV9wYWdlIHdoaWNoIG1hcmtzIHRoaXMgYWxsb2NhdGVk
IHBhZ2UgZXhlY3V0YWJsZS4gVGhpcw0KPiA+ID4gPiBtZWFucyB0aGF0IHRoZSBhbGxvY2F0ZWQg
bWVtb3J5IGlzIFcgYW5kIFggYXQgdGhlIHNhbWUgdGltZSBtYWtpbmcgaXQNCj4gPiA+ID4gc3Vz
Y2VwdGlibGUgdG8gV1ggYmFzZWQgYXR0YWNrcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpbmNlIHRo
ZSBhbGxvY2F0ZWQgbWVtb3J5IGlzIHNoYXJlZCBiZXR3ZWVuIHR3byB0cmFtcG9saW5lcyAodGhl
DQo+ID4gPiA+IGN1cnJlbnQgYW5kIHRoZSBuZXh0KSwgMiBwYWdlcyBtdXN0IGJlIGFsbG9jYXRl
ZCB0byBhZGhlcmUgdG8gV15YIGFuZA0KPiA+ID4gPiB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIGlz
IG9iZXllZCB3aGVyZSB0cmFtcG9saW5lcyBhcmUgbW9kaWZpZWQ6DQo+ID4gPiANCj4gPiA+IENh
biB3ZSBwbGVhc2UgZG8gYmV0dGVyIHJhdGhlciB0aGFuIHBpbGluZyBnYXJiYWdlIG9uIHRvcCBv
ZiBnYXJiYWdlPw0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAtIE1hcmsgbWVtb3J5IGFzIG5v
biBleGVjdXRhYmxlIChzZXRfbWVtb3J5X254KS4gV2hpbGUgbW9kdWxlX2FsbG9jIGZvcg0KPiA+
ID4gPiB4ODYgYWxsb2NhdGVzIHRoZSBtZW1vcnkgYXMgUEFHRV9LRVJORUwgYW5kIG5vdCBQQUdF
X0tFUk5FTF9FWEVDLCBub3QNCj4gPiA+ID4gYWxsIGltcGxlbWVudGF0aW9ucyBvZiBtb2R1bGVf
YWxsb2MgZG8gc28NCj4gPiA+IA0KPiA+ID4gSG93IGFib3V0IGZpeGluZyB0aGlzIGluc3RlYWQ/
DQo+ID4gPiANCj4gPiA+ID4gLSBNYXJrIHRoZSBtZW1vcnkgYXMgcmVhZC93cml0ZSAoc2V0X21l
bW9yeV9ydykNCj4gPiA+IA0KPiA+ID4gUHJvYmFibHkgaGFybWxlc3MsIGJ1dCBzZWUgYWJvdmUg
YWJvdXQgZml4aW5nIGl0Lg0KPiA+ID4gDQo+ID4gPiA+IC0gTW9kaWZ5IHRoZSB0cmFtcG9saW5l
DQo+ID4gPiANCj4gPiA+IFNlZW1zIHJlYXNvbmFibGUuIEl04oCZcyB3b3J0aCBub3RpbmcgdGhh
dCB0aGlzIHdob2xlIGFwcHJvYWNoIGlzDQo+ID4gPiBzdWJvcHRpbWFsOg0KPiA+ID4gdGhlIOKA
nG1vZHVsZeKAnSBhbGxvY2F0b3Igc2hvdWxkIHJlYWxseSBiZSByZXR1cm5pbmcgYSBsaXN0IG9m
IHBhZ2VzIHRvIGJlDQo+ID4gPiB3cml0dGVuIChub3QgYXQgdGhlIGZpbmFsIGFkZHJlc3MhKSB3
aXRoIHRoZSBhY3R1YWwgZXhlY3V0YWJsZSBtYXBwaW5nIHRvDQo+ID4gPiBiZQ0KPiA+ID4gbWF0
ZXJpYWxpemVkIGxhdGVyLCBidXQgdGhhdOKAmXMgYSBiaWdnZXIgcHJvamVjdCB0aGF0IHlvdeKA
mXJlIHdlbGNvbWUgdG8NCj4gPiA+IGlnbm9yZQ0KPiA+ID4gZm9yIG5vdy4gIChDb25jcmV0ZWx5
LCBpdCBzaG91bGQgcHJvZHVjZSBhIHZtYXAgYWRkcmVzcyB3aXRoIGJhY2tpbmcgcGFnZXMNCj4g
PiA+IGJ1dA0KPiA+ID4gd2l0aCB0aGUgdm1hcCBhbGlhcyBlaXRoZXIgZW50aXJlbHkgdW5tYXBw
ZWQgb3IgcmVhZC1vbmx5LiBBIHN1YnNlcXVlbnQNCj4gPiA+IGhlYWxlcg0KPiA+ID4gd291bGQs
IGFsbCBhdCBvbmNlLCBtYWtlIHRoZSBkaXJlY3QgbWFwIHBhZ2VzIFJPIG9yIG5vdC1wcmVzZW50
IGFuZCBtYWtlDQo+ID4gPiB0aGUNCj4gPiA+IHZtYXAgYWxpYXMgUlguKQ0KPiA+ID4gPiAtIE1h
cmsgdGhlIG1lbW9yeSBhcyByZWFkLW9ubHkgKHNldF9tZW1vcnlfcm8pDQo+ID4gPiA+IC0gTWFy
ayB0aGUgbWVtb3J5IGFzIGV4ZWN1dGFibGUgKHNldF9tZW1vcnlfeCkNCj4gPiA+IA0KPiA+ID4g
Tm8sIHRoYW5rcy4gVGhlcmXigJlzIHZlcnkgbGl0dGxlIGV4Y3VzZSBmb3IgZG9pbmcgdHdvIElQ
SSBmbHVzaGVzIHdoZW4gb25lDQo+ID4gPiB3b3VsZCBzdWZmaWNlLg0KPiA+ID4gDQo+ID4gPiBB
cyBmYXIgYXMgSSBrbm93LCBhbGwgYXJjaGl0ZWN0dXJlcyBjYW4gZG8gdGhpcyB3aXRoIGEgc2lu
Z2xlIGZsdXNoDQo+ID4gPiB3aXRob3V0DQo+ID4gPiByYWNlcyAgeDg2IGNlcnRhaW5seSBjYW4u
IFRoZSBtb2R1bGUgZnJlZWluZyBjb2RlIGdldHMgdGhpcyBzZXF1ZW5jZQ0KPiA+ID4gcmlnaHQu
DQo+ID4gPiBQbGVhc2UgcmV1c2UgaXRzIG1lY2hhbmlzbSBvciwgaWYgbmVlZGVkLCBleHBvcnQg
dGhlIHJlbGV2YW50IGludGVyZmFjZXMuDQo+ID4gDQo+ID4gU28gaWYgSSB1bmRlcnN0YW5kIHRo
aXMgcmlnaHQsIHNvbWUgdHJhbXBvbGluZXMgaGF2ZSBiZWVuIGFkZGVkIHRoYXQgYXJlDQo+ID4g
Y3VycmVudGx5IHNldCBhcyBSV1ggYXQgbW9kaWZpY2F0aW9uIHRpbWUgQU5EIGxlZnQgdGhhdCB3
YXkgZHVyaW5nIHJ1bnRpbWU/DQo+ID4gVGhlDQo+ID4gZGlzY3Vzc2lvbiBvbiB0aGUgb3JkZXIg
b2Ygc2V0X21lbW9yeV8oKSBjYWxscyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgbWFkZSBtZQ0KPiA+
IHRoaW5rIHRoYXQgdGhpcyB3YXMganVzdCBhIG1vZGlmaWNhdGlvbiB0aW1lIHRoaW5nIGF0IGZp
cnN0Lg0KPiANCj4gSeKAmW0gbm90IHN1cmUgd2hhdCB0aGUgc3RhdHVzIHF1byBpcy4NCj4gDQo+
IFdlIHJlYWxseSBvdWdodCB0byBoYXZlIGEgZ2VudWluZWx5IGdvb2QgQVBJIGZvciBhbGxvY2F0
aW9uIGFuZCBpbml0aWFsaXphdGlvbg0KPiBvZiB0ZXh0LiAgV2UgY2FuIGRvIHNvIG11Y2ggYmV0
dGVyIHRoYW4gc2V0X21lbW9yeV9ibGFoYmxhaC4NCj4gDQo+IEZXSVcsIEkgaGF2ZSBzb21lIGlk
ZWFzIGFib3V0IG1ha2luZyBrZXJuZWwgZmx1c2hlcyBjaGVhcGVyLiBJdOKAmXMgY3VycmVudGx5
DQo+IGJsb2NrZWQgb24gZmluZGluZyBzb21lIHRpbWUgYW5kIG9uIHRnbHjigJlzIGlycXRyYWNl
IHdvcmsuDQo+IA0KDQpNYWtlcyBzZW5zZSB0byBtZS4gSSBndWVzcyB0aGVyZSBhcmUgNiB0eXBl
cyBvZiB0ZXh0IGFsbG9jYXRpb25zIG5vdzoNCiAtIFRoZXNlIHR3byBCUEYgdHJhbXBvbGluZXMN
CiAtIEJQRiBKSVRzDQogLSBNb2R1bGVzDQogLSBLcHJvYmVzDQogLSBGdHJhY2UNCg0KQWxsIGRv
aW5nIChvciBzaG91bGQgYmUgZG9pbmcpIHByZXR0eSBtdWNoIHRoZSBzYW1lIHRoaW5nLiBJIGJl
bGlldmUgSmVzc2ljYSBoYWQNCnNhaWQgYXQgb25lIHBvaW50IHRoYXQgc2hlIGRpZG4ndCBsaWtl
IGFsbCB0aGUgb3RoZXIgZmVhdHVyZXMgdXNpbmcNCm1vZHVsZV9hbGxvYygpIGFzIGl0IHdhcyBz
dXBwb3NlZCB0byBiZSBqdXN0IGZvciByZWFsIG1vZHVsZXMuIFdoZXJlIHdvdWxkIHRoZQ0KQVBJ
IGxpdmU/DQoNCj4gPiANCj4gPiBBbHNvLCBpcyB0aGVyZSBhIHJlYXNvbiB5b3UgY291bGRuJ3Qg
dXNlIHRleHRfcG9rZSgpIHRvIG1vZGlmeSB0aGUNCj4gPiB0cmFtcG9saW5lDQo+ID4gd2l0aCBh
IHNpbmdsZSBmbHVzaD8NCj4gPiANCj4gDQo+IERvZXMgdGV4dF9wb2tlIHRvIGFuIElQSSB0aGVz
ZSBkYXlzPw0KDQpJIGRvbid0IHRoaW5rIHNvIHNpbmNlIHRoZSBSVyBtYXBwaW5nIGlzIGp1c3Qg
b24gYSBzaW5nbGUgQ1BVLiBUaGF0IHdhcyBvbmUgb2YNCnRoZSBiZW5lZml0cyBvZiB0aGUgdGVt
cG9yYXJ5IG1tIHN0cnVjdCBiYXNlZCB0aGluZyBOYWRhdiBkaWQuIEkgaGF2ZW4ndCBsb29rZWQN
CmludG8gUGV0ZXJaJ3MgY2hhbmdlcyB0aG91Z2guDQo=
