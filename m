Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DD91C049
	for <lists+bpf@lfdr.de>; Tue, 14 May 2019 03:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfENBPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 May 2019 21:15:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:16484 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfENBPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 21:15:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 18:15:08 -0700
X-ExtLoop1: 1
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2019 18:15:08 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 13 May 2019 18:15:08 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.79]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.37]) with mapi id 14.03.0415.000;
 Mon, 13 May 2019 18:15:07 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namit@vmware.com" <namit@vmware.com>
Subject: Re: bpf VM_FLUSH_RESET_PERMS breaks sparc64 boot
Thread-Topic: bpf VM_FLUSH_RESET_PERMS breaks sparc64 boot
Thread-Index: AQHVCZRjj+cySzbkfEOvygRTeV/vmqZpvREAgACJ/AA=
Date:   Tue, 14 May 2019 01:15:07 +0000
Message-ID: <102313756736cf8b34b36b1025102e2b75d16426.camel@intel.com>
References: <4401874b-31b9-42a0-31bd-32bef5b36f2a@linux.ee>
         <b8493de00d9973f6f054814ed69d146b29207d3e.camel@intel.com>
In-Reply-To: <b8493de00d9973f6f054814ed69d146b29207d3e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE5689AC872BB429F5B5826E7DAE2D5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTEzIGF0IDEwOjAxIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gTW9uLCAyMDE5LTA1LTEzIGF0IDE3OjAxICswMzAwLCBNZWVsaXMgUm9vcyB3cm90ZToN
Cj4gPiBJIHRlc3RlZCB5ZXN0ZXJkYXlzIDUuMiBkZXZlbCBnaXQgYW5kIGl0IGZhaWxlZCB0byBi
b290IG9uIG15IFN1biBGaXJlIFY0NDUNCj4gPiAoNHggVWx0cmFTcGFyYyBJSUkpLiBJbml0IGlz
IHN0YXJ0ZWQgYW5kIGl0IGhhbmdzIHRoZXJlOg0KPiA+IA0KPiA+IFsgICAzOC40MTQ0MzZdIFJ1
biAvc2Jpbi9pbml0IGFzIGluaXQgcHJvY2Vzcw0KPiA+IFsgICAzOC41MzA3MTFdIHJhbmRvbTog
ZmFzdCBpbml0IGRvbmUNCj4gPiBbICAgMzkuNTgwNjc4XSBzeXN0ZW1kWzFdOiBJbnNlcnRlZCBt
b2R1bGUgJ2F1dG9mczQnDQo+ID4gWyAgIDM5LjcyMTU3N10gc3lzdGVtZFsxXTogc3lzdGVtZCAy
NDEgcnVubmluZyBpbiBzeXN0ZW0gbW9kZS4gKCtQQU0gK0FVRElUDQo+ID4gK1NFTElOVVggK0lN
QSArQVBQQVJNT1IgK1NNQUNLICtTWVNWSU5JVCArVVRNUCArTElCQ1JZUFRTRVRVUCArR0NSWVBU
DQo+ID4gK0dOVVRMUw0KPiA+ICtBQ0wgK1haICtMWjQgLVNFQ0NPTVAgK0JMS0lEICtFTEZVVElM
UyArS01PRCAtSUROMiArSUROIC1QQ1JFMiBkZWZhdWx0LQ0KPiA+IGhpZXJhcmNoeT1oeWJyaWQp
DQo+ID4gWyAgIDQwLjAyODA2OF0gc3lzdGVtZFsxXTogRGV0ZWN0ZWQgYXJjaGl0ZWN0dXJlIHNw
YXJjNjQuDQo+ID4gDQo+ID4gV2VsY29tZSB0byBEZWJpYW4gR05VL0xpbnV4IDEwIChidXN0ZXIp
IQ0KPiA+IA0KPiA+IFsgICA0MC4xNjg3MTNdIHN5c3RlbWRbMV06IFNldCBob3N0bmFtZSB0byA8
djQ0NT4uDQo+ID4gWyAgIDYxLjMxODAzNF0gcmN1OiBJTkZPOiByY3Vfc2NoZWQgZGV0ZWN0ZWQg
c3RhbGxzIG9uIENQVXMvdGFza3M6DQo+ID4gWyAgIDYxLjQwMzAzOV0gcmN1OiAgICAgMS0uLi4h
OiAoMCB0aWNrcyB0aGlzIEdQKQ0KPiA+IGlkbGU9NjAyLzEvMHg0MDAwMDAwMDAwMDAwMDAwIHNv
ZnRpcnE9ODUvODUgZnFzPTENCj4gPiBbICAgNjEuNTI2NzgwXSByY3U6ICAgICAoZGV0ZWN0ZWQg
YnkgMywgdD01MjUyIGppZmZpZXMsIGc9LTk2NywgcT0yMjgpDQo+ID4gWyAgIDYxLjYxMzAzN10g
ICBDUFVbICAxXTogVFNUQVRFWzAwMDAwMDAwODAwMDE2MDJdIFRQQ1swMDAwMDAwMDAwNDNmMmI4
XQ0KPiA+IFROUENbMDAwMDAwMDAwMDQzZjJiY10gVEFTS1tzeXN0ZW1kLWZzdGFiLWc6OTBdDQo+
ID4gWyAgIDYxLjc2NjgyOF0gICAgICAgICAgICAgIFRQQ1tzbXBfc3luY2hyb25pemVfdGlja19j
bGllbnQrMHgxOC8weDE4MF0NCj4gPiBPN1tfX2RvX211bm1hcCsweDIwNC8weDNlMF0gSTdbeGNh
bGxfc3luY190aWNrKzB4MWMvMHgyY10NCj4gPiBSUENbcGFnZV9ldmljdGFibGUrMHg0LzB4NjBd
DQo+ID4gWyAgIDYxLjk2NjgwN10gcmN1OiByY3Vfc2NoZWQga3RocmVhZCBzdGFydmVkIGZvciA1
MjUwIGppZmZpZXMhIGctOTY3IGYweDANCj4gPiBSQ1VfR1BfV0FJVF9GUVMoNSkgLT5zdGF0ZT0w
eDQwMiAtPmNwdT0yDQo+ID4gWyAgIDYyLjExMzA1OF0gcmN1OiBSQ1UgZ3JhY2UtcGVyaW9kIGt0
aHJlYWQgc3RhY2sgZHVtcDoNCj4gPiBbICAgNjIuMTg1NTU4XSByY3Vfc2NoZWQgICAgICAgSSAg
ICAwICAgIDEwICAgICAgMiAweDA2MDAwMDAwDQo+ID4gWyAgIDYyLjI2NDMxMl0gQ2FsbCBUcmFj
ZToNCj4gPiBbICAgNjIuMjk5MzE2XSAgWzAwMDAwMDAwMDA5MmExZmNdIHNjaGVkdWxlKzB4MWMv
MHg4MA0KPiA+IFsgICA2Mi4zNjgwNzFdICBbMDAwMDAwMDAwMDkyZDNmY10gc2NoZWR1bGVfdGlt
ZW91dCsweDEzYy8weDI4MA0KPiA+IFsgICA2Mi40NDkzMjhdICBbMDAwMDAwMDAwMDRiNmM2NF0g
cmN1X2dwX2t0aHJlYWQrMHg0YzQvMHhhNDANCj4gPiBbICAgNjIuNTI4MDc3XSAgWzAwMDAwMDAw
MDA0N2U5NWNdIGt0aHJlYWQrMHhmYy8weDEyMA0KPiA+IFsgICA2Mi41OTY4MzNdICBbMDAwMDAw
MDAwMDQwNjBhNF0gcmV0X2Zyb21fZm9yaysweDFjLzB4MmMNCj4gPiBbICAgNjIuNjcxODMxXSAg
WzAwMDAwMDAwMDAwMDAwMDBdICAgICAgICAgICAobnVsbCkNCj4gPiANCj4gPiA1LjEuMCB3b3Jr
ZWQgZmluZS4gSSBiaXNlY3RlZCBpdCB0byB0aGUgZm9sbG93aW5nIGNvbW1pdDoNCj4gPiANCj4g
PiBkNTNkMmY3OGNlYWRiYTA4MWZjNzc4NTU3MDc5OGMzYzhkNTBhNzE4IGlzIHRoZSBmaXJzdCBi
YWQgY29tbWl0DQo+ID4gY29tbWl0IGQ1M2QyZjc4Y2VhZGJhMDgxZmM3Nzg1NTcwNzk4YzNjOGQ1
MGE3MTgNCj4gPiBBdXRob3I6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbT4NCj4gPiBEYXRlOiAgIFRodSBBcHIgMjUgMTc6MTE6MzggMjAxOSAtMDcwMA0KPiA+IA0K
PiA+ICAgICAgYnBmOiBVc2Ugdm1hbGxvYyBzcGVjaWFsIGZsYWcNCj4gPiAgICAgIA0KPiA+ICAg
ICAgVXNlIG5ldyBmbGFnIFZNX0ZMVVNIX1JFU0VUX1BFUk1TIGZvciBoYW5kbGluZyBmcmVlaW5n
IG9mIHNwZWNpYWwNCj4gPiAgICAgIHBlcm1pc3Npb25lZCBtZW1vcnkgaW4gdm1hbGxvYyBhbmQg
cmVtb3ZlIHBsYWNlcyB3aGVyZSBtZW1vcnkgd2FzIHNldA0KPiA+IFJXDQo+ID4gICAgICBiZWZv
cmUgZnJlZWluZyB3aGljaCBpcyBubyBsb25nZXIgbmVlZGVkLiBEb24ndCB0cmFjayBpZiB0aGUg
bWVtb3J5IGlzDQo+ID4gUk8NCj4gPiAgICAgIGFueW1vcmUgYmVjYXVzZSBpdCBpcyBub3cgdHJh
Y2tlZCBpbiB2bWFsbG9jLg0KPiA+ICAgICAgDQo+ID4gICAgICBTaWduZWQtb2ZmLWJ5OiBSaWNr
IEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gICAgICBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4g
PiAgICAgIENjOiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiAgICAgIENjOiA8YXJk
LmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gPiAgICAgIENjOiA8ZGVuZWVuLnQuZG9ja0BpbnRl
bC5jb20+DQo+ID4gICAgICBDYzogPGtlcm5lbC1oYXJkZW5pbmdAbGlzdHMub3BlbndhbGwuY29t
Pg0KPiA+ICAgICAgQ2M6IDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiAgICAgIENjOiA8
bGludXhfZHRpQGljbG91ZC5jb20+DQo+ID4gICAgICBDYzogPHdpbGwuZGVhY29uQGFybS5jb20+
DQo+ID4gICAgICBDYzogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz4NCj4gPiAg
ICAgIENjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4gPiAgICAgIENjOiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gPiAgICAgIENjOiBEYW5pZWwgQm9ya21h
bm4gPGRhbmllbEBpb2dlYXJib3gubmV0Pg0KPiA+ICAgICAgQ2M6IERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gICAgICBDYzogSC4gUGV0ZXIgQW52aW4gPGhw
YUB6eXRvci5jb20+DQo+ID4gICAgICBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4
LWZvdW5kYXRpb24ub3JnPg0KPiA+ICAgICAgQ2M6IE5hZGF2IEFtaXQgPG5hZGF2LmFtaXRAZ21h
aWwuY29tPg0KPiA+ICAgICAgQ2M6IFJpayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCj4g
PiAgICAgIENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiAgICAg
IExpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTA0MjYwMDExNDMuNDk4My0xOS1u
YW1pdEB2bXdhcmUuY29tDQo+ID4gICAgICBTaWduZWQtb2ZmLWJ5OiBJbmdvIE1vbG5hciA8bWlu
Z29Aa2VybmVsLm9yZz4NCj4gPiANCj4gPiA6MDQwMDAwIDA0MDAwMCA1ODA2NmRlNTMxMDdlYWIw
NzA1Mzk4YjVkMGM0MDc0MjRjMTM4YTg2DQo+ID4gN2ExMzQ1ZDQzYzRjYWNlZTYwYjkxMzU4OTli
Nzc1ZWNkYjU0ZWE3ZSBNICAgICAgaW5jbHVkZQ0KPiA+IDowNDAwMDAgMDQwMDAwIGQwMjY5MmNm
NTdhMzU5MDU2YjM0ZTYzNmQwZjEwMmQzN2RlNWIyNjQNCj4gPiA4MWM0YzJjNjQwOGI2OGViNTU1
NjczYmQzZjBiYzMwNzFkYjFmN2VkIE0gICAgICBrZXJuZWwNCj4gPiANCj4gDQo+IFRoYW5rcywg
SSdsbCBzZWUgaWYgSSBjYW4gcmVwcm9kdWNlLg0KPiANCj4gUmljaw0KDQpJJ20gaGF2aW5nIHRy
b3VibGUgZ2V0dGluZyBEZWJpYW4gQnVzdGVyIHVwIGFuZCBydW5uaW5nIG9uIHFlbXUtc3lzdGVt
LQ0Kc3BhcmM2NCBhbmQgc28gaGF2ZW4ndCBiZWVuIGFibGUgdG8gcmVwcm9kdWNlLiBJcyB0aGlz
IGN1cnJlbnRseSB3b3JraW5nIGZvcg0KcGVvcGxlPw0KDQpUaGlzIHBhdGNoIGludm9sdmVzIHJl
LXNldHRpbmcgbWVtb3J5IHBlcm1pc3Npb25zIHdoZW4gZnJlZWluZyBleGVjdXRhYmxlDQptZW1v
cnkuIEl0IGxvb2tzIGxpa2UgU3BhcmM2NCBMaW51eCBkb2Vzbid0IGhhdmUgc3VwcG9ydCBmb3Ig
dGhlIHNldF9tZW1vcnlfKCkNCmZ1bmN0aW9ucyBzbyB0aGF0IHBhcnQgc2hvdWxkbid0IGJlIGNo
YW5naW5nIGFueXRoaW5nLiBUaGUgbWFpbiBvdGhlciB0aGluZyB0aGF0DQppcyBjaGFuZ2VkIGhl
cmUgaXMgYWx3YXlzIGRvaW5nIGEgVExCIGZsdXNoIGluIHZmcmVlIHdoZW4gdGhlIEJQRiBKSVRz
IGFyZQ0KZnJlZWQuIEl0IHdpbGwgYWxyZWFkeSBzb21ldGltZXMgaGFwcGVuIHNvIHRoYXQgc2hv
dWxkbid0IGJlIHRvbyBkaWZmZXJlbnQNCmVpdGhlci4NCg0KU28gaXQgZG9lc24ndCBzZWVtIGV4
dHJhIGVzcGVjaWFsbHkgbGlrZWx5IHRvIGNhdXNlIGEgc3BhcmMgc3BlY2lmaWMgcHJvYmxlbQ0K
dGhhdCBJIGNhbiBzZWUuIElzIHRoZXJlIGFueSBjaGFuY2UgdGhpcyBpcyBhbiBpbnRlcm1pdHRl
bnQgaXNzdWU/DQoNCkFsdGVybmF0aXZlbHksIHdlIGNvdWxkIG1heWJlIGp1c3QgZXhlbXB0IGFy
Y2hpdGVjdHVyZXMgd2l0aCBubyBzZXRfbWVtb3J5XygpDQppbXBsZW1lbnRhdGlvbnMgZnJvbSB0
aGlzIG5ldyBiZWhhdmlvci4gVGhhdCB3b3VsZCB1bmZvcnR1bmF0ZWx5IGxvc2UgdGhlDQpiZW5l
Zml0cyBmb3IgYXJjaGl0ZWN0dXJlcyB3aXRoIG5vIHNldF9tZW1vcnlfKCkncyBidXQgdGhhdCBo
YXZlIGV4ZWN1dGFibGUNCnBlcm1pc3Npb24gYml0cy4NCg0KQnV0IHRoZW4gdGhpcyBwYXRjaCB3
b3VsZCBoYXZlIG5vIGVmZmVjdCBvbiBzcGFyYzY0IGFuZCB3b3VsZCBwb3NzaWJseSByZXNvbHZl
DQppdCB3aXRob3V0IHJlYWxseSBkZWJ1Z2dpbmcgaXQuDQoNClRoYW5rcywNCg0KUmljaw0K
