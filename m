Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64A1EBA2E
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFBLNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 07:13:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgFBLNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 07:13:04 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 54A711A1897B9FC0BEC9;
        Tue,  2 Jun 2020 19:13:01 +0800 (CST)
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 2 Jun 2020 19:13:00 +0800
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 dggema758-chm.china.huawei.com (10.1.198.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 2 Jun 2020 19:13:00 +0800
Received: from dggema758-chm.china.huawei.com ([10.9.48.193]) by
 dggema758-chm.china.huawei.com ([10.9.48.193]) with mapi id 15.01.1913.007;
 Tue, 2 Jun 2020 19:13:00 +0800
From:   "zhujianwei (C)" <zhujianwei7@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Kees Cook <keescook@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        =?utf-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
        <zbyszek@in.waw.pl>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IG5ldyBzZWNjb21wIG1vZGUgYWltcyB0byBpbXBy?=
 =?utf-8?Q?ove_performance?=
Thread-Topic: =?utf-8?B?562U5aSNOiBuZXcgc2VjY29tcCBtb2RlIGFpbXMgdG8gaW1wcm92ZSBwZXJm?=
 =?utf-8?Q?ormance?=
Thread-Index: AdY1q17j91IY6CMiRsq40mFg/pmPz///wxIAgAAHIgCAADc1gP/7503AgAfEWYD//fXnAIADmuoA//74EOA=
Date:   Tue, 2 Jun 2020 11:13:00 +0000
Message-ID: <717a06e7f35740ccb4c70470ec70fb2f@huawei.com>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook>
 <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
 <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
 <7dacac003a9949ea8163fca5125a2cae@huawei.com>
 <20200602032446.7sn2fmzsea2v2wbs@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200602032446.7sn2fmzsea2v2wbs@ast-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.215.96]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiA+IFRoaXMgaXMgdGhlIHRlc3QgcmVzdWx0IG9uIGxpbnV4IDUuNy4wLXJjNyBmb3IgYWFyY2g2
NC4NCj4gPiBBbmQgcmV0cG9saW5lIGRpc2FibGVkIGRlZmF1bHQuDQo+ID4gI2NhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS92dWxuZXJhYmlsaXRpZXMvc3BlY3RyZV92Mg0KPiA+IE5vdCBhZmZl
Y3RlZA0KPiA+DQo+ID4gYnBmX2ppdF9lbmFibGUgMQ0KPiA+IGJwZl9qaXRfaGFyZGVuIDANCj4g
Pg0KPiA+IFdlIHJ1biB1bml4YmVuY2ggc3lzY2FsbCBiZW5jaG1hcmsgb24gdGhlIG9yaWdpbmFs
IGtlcm5lbCBhbmQgdGhlIG5ldyBvbmUocmVwbGFjZSBicGZfcHJvZ19ydW5fcGluX29uX2NwdSgp
IHdpdGggaW1tZWRpYXRlbHkgcmV0dXJuaW5nICdhbGxvdycgb25lKS4NCj4gPiBUaGUgdW5peGJl
bmNoIHN5c2NhbGwgdGVzdGNhc2UgcnVucyA1IHN5c3RlbSBjYWxsc++8iGNsb3NlL3VtYXNrL2R1
cC9nZXRwaWQvZ2V0dWlkLCBleHRyYSAxNSBzeXNjYWxscyBuZWVkZWQgdG8gcnVuIGl077yJIGlu
IGEgbG9vcCBmb3IgMTAgc2Vjb25kcywgY291bnRzIHRoZSBudW1iZXIgYW5kIGZpbmFsbHkgb3V0
cHV0IGl0LiBXZSBhbHNvIGFkZCBzb21lIG1vcmUgZmlsdGVycyAoZWFjaCB3aXRoIHRoZSBzYW1l
IHJ1bGVzKSB0byBldmFsdWF0ZSB0aGUgc2l0dWF0aW9uIGp1c3QgbGlrZSBrZWVzIG1lbnRpb25l
ZChjYXNlIGxpa2Ugc3lzdGVtZC1yZXNvbHZlKSwgYW5kIHdlIGZpbmQgaXQgaXMgcmlnaHQ6IG1v
cmUgZmlsdGVycywgbW9yZSBvdmVyaGVhZC4gVGhlIGZvbGxvd2luZyBpcyBvdXIgcmVzdWx0ICgu
L3N5c2NhbGwgMTAgbSk6DQo+ID4NCj4gPiBvcmlnaW5hbDoNCj4gPiAgICAgICAgIHNlY2NvbXBf
b2ZmOiAgICAgICAgICAgICAgICAgICAgMTA2ODQ5MzkNCj4gPiAgICAgICAgIHNlY2NvbXBfb25f
MV9maWx0ZXJzOiAgIDg1MTM4MDUgICAgICAgICBvdmVyaGVhZO+8mjE5LjglDQo+ID4gICAgICAg
ICBzZWNjb21wX29uXzRfZmlsdGVyczogICA3MTA1NTkyICAgICAgICAgb3ZlcmhlYWTvvJozMy4w
JQ0KPiA+ICAgICAgICAgc2VjY29tcF9vbl8zMl9maWx0ZXJzOiAgMjMwODY3NyAgICAgICAgIG92
ZXJoZWFk77yaNzguMyUNCj4gPg0KPiA+IGFmdGVyIHJlcGxhY2luZyBicGZfcHJvZ19ydW5fcGlu
X29uX2NwdToNCj4gPiAgICAgICAgIHNlY2NvbXBfb2ZmOiAgICAgICAgICAgICAgICAgICAgMTA2
ODUyNDQNCj4gPiAgICAgICAgIHNlY2NvbXBfb25fMV9maWx0ZXJzOiAgIDkxNDY0ODMgICAgICAg
ICBvdmVyaGVhZO+8mjE0LjElDQo+ID4gICAgICAgICBzZWNjb21wX29uXzRfZmlsdGVyczogICA4
OTY5ODg2ICAgICAgICAgb3ZlcmhlYWTvvJoxNi4wJQ0KPiA+ICAgICAgICAgc2VjY29tcF9vbl8z
Ml9maWx0ZXJzOiAgNjQ1NDM3MiAgICAgICAgIG92ZXJoZWFk77yaMzkuNiUNCj4gPg0KPiA+IE4t
ZmlsdGVyIGJwZiBvdmVyaGVhZDoNCj4gPiAgICAgICAgIDFfZmlsdGVyczogICAgICAgICAgICAg
IDUuNyUNCj4gPiAgICAgICAgIDRfZmlsdGVyczogICAgICAgICAgICAgIDE3LjAlDQo+ID4gICAg
ICAgICAzMl9maWx0ZXJzOiAgICAgMzguNyUNCj4gPg0KPiA+IC8vIGtlcm5lbCBjb2RlIG1vZGlm
aWNhdGlvbiBwbGFjZQ0KPiA+IHN0YXRpYyBub2lubGluZSB1MzIgYnBmX3Byb2dfcnVuX3Bpbl9v
bl9jcHVfYWxsb3coY29uc3Qgc3RydWN0IA0KPiA+IGJwZl9wcm9nICpwcm9nLCBjb25zdCB2b2lk
ICpjdHgpIHsNCj4gPiAgICAgICAgIHJldHVybiBTRUNDT01QX1JFVF9BTExPVzsNCj4gPiB9DQo+
IA0KPiA+VGhpcyBpcyBhcHBsZXMgdG8gb3Jhbmdlcy4NCj4gPkFzIGV4cGxhaW5lZCBlYXJsaWVy
Og0KPiA+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjAwNTMxMTcxOTE1LndzeHZk
amVldG1ocHNkdjJAYXN0LW1iDQo+ID5wLmRoY3AudGhlZmFjZWJvb2suY29tL1QvI3UgUGxlYXNl
IHVzZSBfX3dlYWsgaW5zdGVhZCBvZiBzdGF0aWMgYW5kIA0KPiA+cmVkbyB0aGUgbnVtYmVycy4N
Cj4gDQo+IA0KPiB3ZSBoYXZlIHJlcGxhY2VkIOKAmHN0YXRpY+KAmSB3aXRoIOKAmF9fd2Vha+KA
mSwgdGVzdGVkIHdpdGggdGhlIHNhbWUgd2F5LCBhbmQgZ290IGFsbW9zdGx5IHRoZSBzYW1lIHJl
c3VsdCwgaW4gb3VyIHRlc3QgZW52aXJvbm1lbnQoYWFyY2g2NCkuDQo+IA0KPiAtc3RhdGljIG5v
aW5saW5lIHUzMiBicGZfcHJvZ19ydW5fcGluX29uX2NwdV9hbGxvdyhjb25zdCBzdHJ1Y3QgDQo+
IGJwZl9wcm9nICpwcm9nLCBjb25zdCB2b2lkICpjdHgpDQo+ICtfX3dlYWsgbm9pbmxpbmUgdTMy
IGJwZl9wcm9nX3J1bl9waW5fb25fY3B1X2FsbG93KGNvbnN0IHN0cnVjdCANCj4gK2JwZl9wcm9n
ICpwcm9nLCBjb25zdCB2b2lkICpjdHgpDQo+IA0KPiBvcmlnaW5hbDoNCj4gCXNlY2NvbXBfb2Zm
OgkJCTEwNjg0OTM5DQo+IAlzZWNjb21wX29uXzFfZmlsdGVyczoJODUxMzgwNQkJb3ZlcmhlYWTv
vJoxOS44JQ0KPiAJc2VjY29tcF9vbl80X2ZpbHRlcnM6CTcxMDU1OTIJCW92ZXJoZWFk77yaMzMu
MCUNCj4gCXNlY2NvbXBfb25fMzJfZmlsdGVyczoJMjMwODY3NwkJb3ZlcmhlYWTvvJo3OC4zJQ0K
PiAJDQo+IGFmdGVyIHJlcGxhY2luZyBicGZfcHJvZ19ydW5fcGluX29uX2NwdToNCj4gCXNlY2Nv
bXBfb2ZmOgkJCTEwNjY3MTk1DQo+IAlzZWNjb21wX29uXzFfZmlsdGVyczoJOTE0NzQ1NAkJb3Zl
cmhlYWTvvJoxNC4yJQ0KPiAJc2VjY29tcF9vbl80X2ZpbHRlcnM6CTg5Mjc2MDUJCW92ZXJoZWFk
77yaMTYuMSUNCj4gCXNlY2NvbXBfb25fMzJfZmlsdGVyczoJNjM1NTQ3NgkJb3ZlcmhlYWTvvJo0
MC42JQ0KDQo+IGFyZSB5b3Ugc2F5aW5nIHRoYXQgYnkgcmVwbGFjaW5nICdzdGF0aWMnIHdpdGgg
J19fd2VhaycgaXQgZ290IHNsb3dlcj8hDQo+IFNvbWV0aGluZyBkb2Vzbid0IGFkZCB1cC4gUGxl
YXNlIGNoZWNrIGdlbmVyYXRlZCBhc3NlbWJseS4NCj4gQnkgaGF2aW5nIHN1Y2ggJ3N0YXRpYyBu
b2lubGluZSBicGZfcHJvZ19ydW5fcGluX29uX2NwdScgeW91J3JlIHRlbGxpbmcgY29tcGlsZXIg
dG8gcmVtb3ZlIG1vc3Qgb2Ygc2VjY29tcF9ydW5fZmlsdGVycygpIGNvZGUgd2hpY2ggbm93IHdp
bGwgcmV0dXJuIG9ubHkgdHdvIHBvc3NpYmxlIHZhbHVlcy4gV2hpY2ggZnVydGhlciBtZWFucyB0
aGF0IGxhcmdlICdzd2l0Y2gnDQo+IHN0YXRlbWVudCBpbiBfX3NlY2NvbXBfZmlsdGVyKCkgaXMg
YWxzbyBvcHRpbWl6ZWQuIHBvcHVsYXRlX3NlY2NvbXBfZGF0YSgpIGlzIHJlbW92ZWQuIEV0Yywg
ZXRjLiBUaGF0IGV4cGxhaW5zIDE0JSB2cyAxOSUgZGlmZmVyZW5jZS4NCj4gTWF5IGJlIHlvdSBo
YXZlIHNvbWUgZGVidWcgb24/IExpa2UgY2FudF9taWdyYXRlKCkgaXMgbm90IGEgbm9wPw0KPiBP
ciBzdGF0aWNfYnJhbmNoIGlzIG5vdCBzdXBwb3J0ZWQ/DQo+IFRoZSBzdXJlIHdheSBpcyB0byBj
aGVjayBhc3NlbWJseS4NCg0KTm8sIHdlIHNheSB0aGF0IGJ5IHJlcGxhY2luZyAnc3RhdGljJyB3
aXRoICdfX3dlYWsnIGl0IGdvdCB0aGUgc2FtZSByZXN1bHQsIGluIG91ciB0ZXN0Y2FzZSB3aGlj
aCBmaWx0ZXJzIDIwIGFsbG93ZWQgc3lzY2FsbCBudW0gKGZvciBkZXRhaWxzLCBzZWUgdGhlIHBy
ZXZpb3VzIHBvc3QpLiANCg0Kc3RhdGljIGNhc2U6DQoJTi1maWx0ZXIgYnBmIG92ZXJoZWFkOg0K
CTFfZmlsdGVyczoJCTUuNyUNCgk0X2ZpbHRlcnM6CQkxNy4wJQ0KCTMyX2ZpbHRlcnM6CTM4Ljcl
DQoNCl9fd2VhayBjYXNlOg0KCU4tZmlsdGVyIGJwZiBvdmVyaGVhZDoNCgkxX2ZpbHRlcnM6CQk1
LjYlDQoJNF9maWx0ZXJzOgkJMTYuOSUNCgkzMl9maWx0ZXJzOgkzNy43JQ0K
