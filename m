Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B5131B45
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2020 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAFWZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jan 2020 17:25:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:46983 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFWZb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jan 2020 17:25:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 14:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="253509785"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2020 14:25:29 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 14:25:28 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.41]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.30]) with mapi id 14.03.0439.000;
 Mon, 6 Jan 2020 14:25:28 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kpsingh@chromium.org" <kpsingh@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "jannh@google.com" <jannh@google.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "thgarnie@chromium.org" <thgarnie@chromium.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "revest@chromium.org" <revest@chromium.org>,
        "jackmanb@chromium.org" <jackmanb@chromium.org>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "mhalcrow@google.com" <mhalcrow@google.com>,
        "andriin@fb.com" <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
Thread-Topic: [PATCH bpf-next] bpf: Make trampolines W^X
Thread-Index: AQHVwpjLpCzVLdPZ5Em9CS0HIZ/iOKfewVwA
Date:   Mon, 6 Jan 2020 22:25:27 +0000
Message-ID: <21bf6bb46544eab79e792980f82520f8fbdae9b5.camel@intel.com>
References: <20200103234725.22846-1-kpsingh@chromium.org>
         <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
In-Reply-To: <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1D761781F8B5E4EBBB83ABF3CB2AE9E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU2F0LCAyMDIwLTAxLTA0IGF0IDA5OjQ5ICswOTAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gT24gSmFuIDQsIDIwMjAsIGF0IDg6NDcgQU0sIEtQIFNpbmdoIDxrcHNpbmdoQGNocm9t
aXVtLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4g77u/RnJvbTogS1AgU2luZ2ggPGtwc2luZ2hAZ29v
Z2xlLmNvbT4NCj4gPiANCj4gPiBUaGUgaW1hZ2UgZm9yIHRoZSBCUEYgdHJhbXBvbGluZXMgaXMg
YWxsb2NhdGVkIHdpdGgNCj4gPiBicGZfaml0X2FsbG9jX2V4ZV9wYWdlIHdoaWNoIG1hcmtzIHRo
aXMgYWxsb2NhdGVkIHBhZ2UgZXhlY3V0YWJsZS4gVGhpcw0KPiA+IG1lYW5zIHRoYXQgdGhlIGFs
bG9jYXRlZCBtZW1vcnkgaXMgVyBhbmQgWCBhdCB0aGUgc2FtZSB0aW1lIG1ha2luZyBpdA0KPiA+
IHN1c2NlcHRpYmxlIHRvIFdYIGJhc2VkIGF0dGFja3MuDQo+ID4gDQo+ID4gU2luY2UgdGhlIGFs
bG9jYXRlZCBtZW1vcnkgaXMgc2hhcmVkIGJldHdlZW4gdHdvIHRyYW1wb2xpbmVzICh0aGUNCj4g
PiBjdXJyZW50IGFuZCB0aGUgbmV4dCksIDIgcGFnZXMgbXVzdCBiZSBhbGxvY2F0ZWQgdG8gYWRo
ZXJlIHRvIFdeWCBhbmQNCj4gPiB0aGUgZm9sbG93aW5nIHNlcXVlbmNlIGlzIG9iZXllZCB3aGVy
ZSB0cmFtcG9saW5lcyBhcmUgbW9kaWZpZWQ6DQo+IA0KPiBDYW4gd2UgcGxlYXNlIGRvIGJldHRl
ciByYXRoZXIgdGhhbiBwaWxpbmcgZ2FyYmFnZSBvbiB0b3Agb2YgZ2FyYmFnZT8NCj4gDQo+ID4g
DQo+ID4gLSBNYXJrIG1lbW9yeSBhcyBub24gZXhlY3V0YWJsZSAoc2V0X21lbW9yeV9ueCkuIFdo
aWxlIG1vZHVsZV9hbGxvYyBmb3INCj4gPiB4ODYgYWxsb2NhdGVzIHRoZSBtZW1vcnkgYXMgUEFH
RV9LRVJORUwgYW5kIG5vdCBQQUdFX0tFUk5FTF9FWEVDLCBub3QNCj4gPiBhbGwgaW1wbGVtZW50
YXRpb25zIG9mIG1vZHVsZV9hbGxvYyBkbyBzbw0KPiANCj4gSG93IGFib3V0IGZpeGluZyB0aGlz
IGluc3RlYWQ/DQo+IA0KPiA+IC0gTWFyayB0aGUgbWVtb3J5IGFzIHJlYWQvd3JpdGUgKHNldF9t
ZW1vcnlfcncpDQo+IA0KPiBQcm9iYWJseSBoYXJtbGVzcywgYnV0IHNlZSBhYm92ZSBhYm91dCBm
aXhpbmcgaXQuDQo+IA0KPiA+IC0gTW9kaWZ5IHRoZSB0cmFtcG9saW5lDQo+IA0KPiBTZWVtcyBy
ZWFzb25hYmxlLiBJdOKAmXMgd29ydGggbm90aW5nIHRoYXQgdGhpcyB3aG9sZSBhcHByb2FjaCBp
cyBzdWJvcHRpbWFsOg0KPiB0aGUg4oCcbW9kdWxl4oCdIGFsbG9jYXRvciBzaG91bGQgcmVhbGx5
IGJlIHJldHVybmluZyBhIGxpc3Qgb2YgcGFnZXMgdG8gYmUNCj4gd3JpdHRlbiAobm90IGF0IHRo
ZSBmaW5hbCBhZGRyZXNzISkgd2l0aCB0aGUgYWN0dWFsIGV4ZWN1dGFibGUgbWFwcGluZyB0byBi
ZQ0KPiBtYXRlcmlhbGl6ZWQgbGF0ZXIsIGJ1dCB0aGF04oCZcyBhIGJpZ2dlciBwcm9qZWN0IHRo
YXQgeW914oCZcmUgd2VsY29tZSB0byBpZ25vcmUNCj4gZm9yIG5vdy4gIChDb25jcmV0ZWx5LCBp
dCBzaG91bGQgcHJvZHVjZSBhIHZtYXAgYWRkcmVzcyB3aXRoIGJhY2tpbmcgcGFnZXMgYnV0DQo+
IHdpdGggdGhlIHZtYXAgYWxpYXMgZWl0aGVyIGVudGlyZWx5IHVubWFwcGVkIG9yIHJlYWQtb25s
eS4gQSBzdWJzZXF1ZW50IGhlYWxlcg0KPiB3b3VsZCwgYWxsIGF0IG9uY2UsIG1ha2UgdGhlIGRp
cmVjdCBtYXAgcGFnZXMgUk8gb3Igbm90LXByZXNlbnQgYW5kIG1ha2UgdGhlDQo+IHZtYXAgYWxp
YXMgUlguKQ0KPiA+IC0gTWFyayB0aGUgbWVtb3J5IGFzIHJlYWQtb25seSAoc2V0X21lbW9yeV9y
bykNCj4gPiAtIE1hcmsgdGhlIG1lbW9yeSBhcyBleGVjdXRhYmxlIChzZXRfbWVtb3J5X3gpDQo+
IA0KPiBObywgdGhhbmtzLiBUaGVyZeKAmXMgdmVyeSBsaXR0bGUgZXhjdXNlIGZvciBkb2luZyB0
d28gSVBJIGZsdXNoZXMgd2hlbiBvbmUNCj4gd291bGQgc3VmZmljZS4NCj4gDQo+IEFzIGZhciBh
cyBJIGtub3csIGFsbCBhcmNoaXRlY3R1cmVzIGNhbiBkbyB0aGlzIHdpdGggYSBzaW5nbGUgZmx1
c2ggd2l0aG91dA0KPiByYWNlcyAgeDg2IGNlcnRhaW5seSBjYW4uIFRoZSBtb2R1bGUgZnJlZWlu
ZyBjb2RlIGdldHMgdGhpcyBzZXF1ZW5jZSByaWdodC4NCj4gUGxlYXNlIHJldXNlIGl0cyBtZWNo
YW5pc20gb3IsIGlmIG5lZWRlZCwgZXhwb3J0IHRoZSByZWxldmFudCBpbnRlcmZhY2VzLg0KDQpT
byBpZiBJIHVuZGVyc3RhbmQgdGhpcyByaWdodCwgc29tZSB0cmFtcG9saW5lcyBoYXZlIGJlZW4g
YWRkZWQgdGhhdCBhcmUNCmN1cnJlbnRseSBzZXQgYXMgUldYIGF0IG1vZGlmaWNhdGlvbiB0aW1l
IEFORCBsZWZ0IHRoYXQgd2F5IGR1cmluZyBydW50aW1lPyBUaGUNCmRpc2N1c3Npb24gb24gdGhl
IG9yZGVyIG9mIHNldF9tZW1vcnlfKCkgY2FsbHMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIG1hZGUg
bWUNCnRoaW5rIHRoYXQgdGhpcyB3YXMganVzdCBhIG1vZGlmaWNhdGlvbiB0aW1lIHRoaW5nIGF0
IGZpcnN0Lg0KDQpBbHNvLCBpcyB0aGVyZSBhIHJlYXNvbiB5b3UgY291bGRuJ3QgdXNlIHRleHRf
cG9rZSgpIHRvIG1vZGlmeSB0aGUgdHJhbXBvbGluZQ0Kd2l0aCBhIHNpbmdsZSBmbHVzaD8NCg0K
DQo=
