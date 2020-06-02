Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C71EB375
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 04:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFBCmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 22:42:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgFBCmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 22:42:38 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 17708EF423BB9FEA2E9B;
        Tue,  2 Jun 2020 10:42:36 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 2 Jun 2020 10:42:35 +0800
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 2 Jun 2020 10:42:35 +0800
Received: from dggema758-chm.china.huawei.com ([10.9.48.193]) by
 dggema758-chm.china.huawei.com ([10.9.48.193]) with mapi id 15.01.1913.007;
 Tue, 2 Jun 2020 10:42:35 +0800
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
Subject: =?utf-8?B?562U5aSNOiBuZXcgc2VjY29tcCBtb2RlIGFpbXMgdG8gaW1wcm92ZSBwZXJm?=
 =?utf-8?Q?ormance?=
Thread-Topic: new seccomp mode aims to improve performance
Thread-Index: AdY1q17j91IY6CMiRsq40mFg/pmPz///wxIAgAAHIgCAADc1gP/7503AgAfEWYD//fXnAA==
Date:   Tue, 2 Jun 2020 02:42:35 +0000
Message-ID: <7dacac003a9949ea8163fca5125a2cae@huawei.com>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook>
 <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
 <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
In-Reply-To: <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
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

Pg0KPiBUaGlzIGlzIHRoZSB0ZXN0IHJlc3VsdCBvbiBsaW51eCA1LjcuMC1yYzcgZm9yIGFhcmNo
NjQuDQo+IEFuZCByZXRwb2xpbmUgZGlzYWJsZWQgZGVmYXVsdC4NCj4gI2NhdCAvc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS92dWxuZXJhYmlsaXRpZXMvc3BlY3RyZV92Mg0KPiBOb3QgYWZmZWN0ZWQN
Cj4NCj4gYnBmX2ppdF9lbmFibGUgMQ0KPiBicGZfaml0X2hhcmRlbiAwDQo+DQo+IFdlIHJ1biB1
bml4YmVuY2ggc3lzY2FsbCBiZW5jaG1hcmsgb24gdGhlIG9yaWdpbmFsIGtlcm5lbCBhbmQgdGhl
IG5ldyBvbmUocmVwbGFjZSBicGZfcHJvZ19ydW5fcGluX29uX2NwdSgpIHdpdGggaW1tZWRpYXRl
bHkgcmV0dXJuaW5nICdhbGxvdycgb25lKS4NCj4gVGhlIHVuaXhiZW5jaCBzeXNjYWxsIHRlc3Rj
YXNlIHJ1bnMgNSBzeXN0ZW0gY2FsbHPvvIhjbG9zZS91bWFzay9kdXAvZ2V0cGlkL2dldHVpZCwg
ZXh0cmEgMTUgc3lzY2FsbHMgbmVlZGVkIHRvIHJ1biBpdO+8iSBpbiBhIGxvb3AgZm9yIDEwIHNl
Y29uZHMsIGNvdW50cyB0aGUgbnVtYmVyIGFuZCBmaW5hbGx5IG91dHB1dCBpdC4gV2UgYWxzbyBh
ZGQgc29tZSBtb3JlIGZpbHRlcnMgKGVhY2ggd2l0aCB0aGUgc2FtZSBydWxlcykgdG8gZXZhbHVh
dGUgdGhlIHNpdHVhdGlvbiBqdXN0IGxpa2Uga2VlcyBtZW50aW9uZWQoY2FzZSBsaWtlIHN5c3Rl
bWQtcmVzb2x2ZSksIGFuZCB3ZSBmaW5kIGl0IGlzIHJpZ2h0OiBtb3JlIGZpbHRlcnMsIG1vcmUg
b3ZlcmhlYWQuIFRoZSBmb2xsb3dpbmcgaXMgb3VyIHJlc3VsdCAoLi9zeXNjYWxsIDEwIG0pOg0K
Pg0KPiBvcmlnaW5hbDoNCj4gICAgICAgICBzZWNjb21wX29mZjogICAgICAgICAgICAgICAgICAg
IDEwNjg0OTM5DQo+ICAgICAgICAgc2VjY29tcF9vbl8xX2ZpbHRlcnM6ICAgODUxMzgwNSAgICAg
ICAgIG92ZXJoZWFk77yaMTkuOCUNCj4gICAgICAgICBzZWNjb21wX29uXzRfZmlsdGVyczogICA3
MTA1NTkyICAgICAgICAgb3ZlcmhlYWTvvJozMy4wJQ0KPiAgICAgICAgIHNlY2NvbXBfb25fMzJf
ZmlsdGVyczogIDIzMDg2NzcgICAgICAgICBvdmVyaGVhZO+8mjc4LjMlDQo+DQo+IGFmdGVyIHJl
cGxhY2luZyBicGZfcHJvZ19ydW5fcGluX29uX2NwdToNCj4gICAgICAgICBzZWNjb21wX29mZjog
ICAgICAgICAgICAgICAgICAgIDEwNjg1MjQ0DQo+ICAgICAgICAgc2VjY29tcF9vbl8xX2ZpbHRl
cnM6ICAgOTE0NjQ4MyAgICAgICAgIG92ZXJoZWFk77yaMTQuMSUNCj4gICAgICAgICBzZWNjb21w
X29uXzRfZmlsdGVyczogICA4OTY5ODg2ICAgICAgICAgb3ZlcmhlYWTvvJoxNi4wJQ0KPiAgICAg
ICAgIHNlY2NvbXBfb25fMzJfZmlsdGVyczogIDY0NTQzNzIgICAgICAgICBvdmVyaGVhZO+8mjM5
LjYlDQo+DQo+IE4tZmlsdGVyIGJwZiBvdmVyaGVhZDoNCj4gICAgICAgICAxX2ZpbHRlcnM6ICAg
ICAgICAgICAgICA1LjclDQo+ICAgICAgICAgNF9maWx0ZXJzOiAgICAgICAgICAgICAgMTcuMCUN
Cj4gICAgICAgICAzMl9maWx0ZXJzOiAgICAgMzguNyUNCj4NCj4gLy8ga2VybmVsIGNvZGUgbW9k
aWZpY2F0aW9uIHBsYWNlDQo+IHN0YXRpYyBub2lubGluZSB1MzIgYnBmX3Byb2dfcnVuX3Bpbl9v
bl9jcHVfYWxsb3coY29uc3Qgc3RydWN0IA0KPiBicGZfcHJvZyAqcHJvZywgY29uc3Qgdm9pZCAq
Y3R4KSB7DQo+ICAgICAgICAgcmV0dXJuIFNFQ0NPTVBfUkVUX0FMTE9XOw0KPiB9DQoNCj5UaGlz
IGlzIGFwcGxlcyB0byBvcmFuZ2VzLg0KPkFzIGV4cGxhaW5lZCBlYXJsaWVyOg0KPmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDIwMDUzMTE3MTkxNS53c3h2ZGplZXRtaHBzZHYyQGFz
dC1tYnAuZGhjcC50aGVmYWNlYm9vay5jb20vVC8jdQ0KPlBsZWFzZSB1c2UgX193ZWFrIGluc3Rl
YWQgb2Ygc3RhdGljIGFuZCByZWRvIHRoZSBudW1iZXJzLg0KDQoNCndlIGhhdmUgcmVwbGFjZWQg
4oCYc3RhdGlj4oCZIHdpdGgg4oCYX193ZWFr4oCZLCB0ZXN0ZWQgd2l0aCB0aGUgc2FtZSB3YXks
IGFuZCBnb3QgYWxtb3N0bHkgdGhlIHNhbWUgcmVzdWx0LCBpbiBvdXIgdGVzdCBlbnZpcm9ubWVu
dChhYXJjaDY0KS4NCg0KLXN0YXRpYyBub2lubGluZSB1MzIgYnBmX3Byb2dfcnVuX3Bpbl9vbl9j
cHVfYWxsb3coY29uc3Qgc3RydWN0IGJwZl9wcm9nICpwcm9nLCBjb25zdCB2b2lkICpjdHgpDQor
X193ZWFrIG5vaW5saW5lIHUzMiBicGZfcHJvZ19ydW5fcGluX29uX2NwdV9hbGxvdyhjb25zdCBz
dHJ1Y3QgYnBmX3Byb2cgKnByb2csIGNvbnN0IHZvaWQgKmN0eCkNCg0Kb3JpZ2luYWw6DQoJc2Vj
Y29tcF9vZmY6CQkJMTA2ODQ5MzkNCglzZWNjb21wX29uXzFfZmlsdGVyczoJODUxMzgwNQkJb3Zl
cmhlYWTvvJoxOS44JQ0KCXNlY2NvbXBfb25fNF9maWx0ZXJzOgk3MTA1NTkyCQlvdmVyaGVhZO+8
mjMzLjAlDQoJc2VjY29tcF9vbl8zMl9maWx0ZXJzOgkyMzA4Njc3CQlvdmVyaGVhZO+8mjc4LjMl
DQoJDQphZnRlciByZXBsYWNpbmcgYnBmX3Byb2dfcnVuX3Bpbl9vbl9jcHU6DQoJc2VjY29tcF9v
ZmY6CQkJMTA2NjcxOTUNCglzZWNjb21wX29uXzFfZmlsdGVyczoJOTE0NzQ1NAkJb3ZlcmhlYWTv
vJoxNC4yJQ0KCXNlY2NvbXBfb25fNF9maWx0ZXJzOgk4OTI3NjA1CQlvdmVyaGVhZO+8mjE2LjEl
DQoJc2VjY29tcF9vbl8zMl9maWx0ZXJzOgk2MzU1NDc2CQlvdmVyaGVhZO+8mjQwLjYlDQoNCk4t
ZmlsdGVyIGJwZiBvdmVyaGVhZDoNCgkxX2ZpbHRlcnM6CQk1LjYlDQoJNF9maWx0ZXJzOgkJMTYu
OSUNCgkzMl9maWx0ZXJzOgkzNy43JQ0KDQoNCg0K
