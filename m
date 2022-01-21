Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F84959D1
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 07:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiAUGTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 01:19:25 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31173 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378646AbiAUGTY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 01:19:24 -0500
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jg8K85KYwz8wKy;
        Fri, 21 Jan 2022 14:16:28 +0800 (CST)
Received: from kwepeml100004.china.huawei.com (7.221.188.19) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 14:19:20 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 kwepeml100004.china.huawei.com (7.221.188.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 14:19:20 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.020;
 Fri, 21 Jan 2022 14:19:19 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Topic: [PATCH bpf-next v6 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Index: AdgOjsCnZ7gsBn94CUmhFdecz7qCWw==
Date:   Fri, 21 Jan 2022 06:19:19 +0000
Message-ID: <6853c9b97c334daeb7c2c1b35661f5a2@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.114.155]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiA+IEFkZCB0ZXN0IGZvciBxdWVyeWluZyBwcm9ncyBhdHRhY2hlZCB0byBzb2NrbWFwLiB3ZSB1
c2UgYW4gZXhpc3RpbmcNCj4gPiBsaWJicGYgcXVlcnkgaW50ZXJmYWNlIHRvIHF1ZXJ5IHByb2cg
Y250IGJlZm9yZSBhbmQgYWZ0ZXIgcHJvZ3MNCj4gPiBhdHRhY2hpbmcgdG8gc29ja21hcCBhbmQg
Y2hlY2sgd2hldGhlciB0aGUgcXVlcmllZCBwcm9nIGlkIGlzIHJpZ2h0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogRGkgWmh1IDx6aHVkaTJAaHVhd2VpLmNvbT4NCj4gPiBBY2tlZC1ieTogWW9u
Z2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3NlbGZ0ZXN0cy9icGYv
cHJvZ190ZXN0cy9zb2NrbWFwX2Jhc2ljLmMgIHwgNjYgKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAuLi4vYnBmL3Byb2dzL3Rlc3Rfc29ja21hcF9wcm9nc19xdWVyeS5jICAgICAgfCAyNCArKysr
KysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3Rfc29j
a21hcF9wcm9nc19xdWVyeS5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+IGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+ID4gaW5kZXggODVk
YjBmNGNkZDk1Li4xYWI1N2NkYzRhZTQgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+ID4gKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+ID4gQEAg
LTgsNiArOCw3IEBADQo+ID4gICNpbmNsdWRlICJ0ZXN0X3NvY2ttYXBfdXBkYXRlLnNrZWwuaCIN
Cj4gPiAgI2luY2x1ZGUgInRlc3Rfc29ja21hcF9pbnZhbGlkX3VwZGF0ZS5za2VsLmgiDQo+ID4g
ICNpbmNsdWRlICJ0ZXN0X3NvY2ttYXBfc2tiX3ZlcmRpY3RfYXR0YWNoLnNrZWwuaCINCj4gPiAr
I2luY2x1ZGUgInRlc3Rfc29ja21hcF9wcm9nc19xdWVyeS5za2VsLmgiDQo+ID4gICNpbmNsdWRl
ICJicGZfaXRlcl9zb2NrbWFwLnNrZWwuaCINCj4gPg0KPiA+ICAjZGVmaW5lIFRDUF9SRVBBSVIg
ICAgICAgICAgICAgMTkgICAgICAvKiBUQ1Agc29jayBpcyB1bmRlciByZXBhaXINCj4gcmlnaHQg
bm93ICovDQo+ID4gQEAgLTMxNSw2ICszMTYsNjMgQEAgc3RhdGljIHZvaWQgdGVzdF9zb2NrbWFw
X3NrYl92ZXJkaWN0X2F0dGFjaChlbnVtDQo+IGJwZl9hdHRhY2hfdHlwZSBmaXJzdCwNCj4gPiAg
ICAgICAgIHRlc3Rfc29ja21hcF9za2JfdmVyZGljdF9hdHRhY2hfX2Rlc3Ryb3koc2tlbCk7DQo+
ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgX191MzIgcXVlcnlfcHJvZ19pZChpbnQgcHJvZ19mZCkN
Cj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGJwZl9wcm9nX2luZm8gaW5mbyA9IHt9Ow0KPiA+
ICsgICAgICAgX191MzIgaW5mb19sZW4gPSBzaXplb2YoaW5mbyk7DQo+ID4gKyAgICAgICBpbnQg
ZXJyOw0KPiA+ICsNCj4gPiArICAgICAgIGVyciA9IGJwZl9vYmpfZ2V0X2luZm9fYnlfZmQocHJv
Z19mZCwgJmluZm8sICZpbmZvX2xlbik7DQo+ID4gKyAgICAgICBpZiAoIUFTU0VSVF9PSyhlcnIs
ICJicGZfb2JqX2dldF9pbmZvX2J5X2ZkIikgfHwNCj4gPiArICAgICAgICAgICAhQVNTRVJUX0VR
KGluZm9fbGVuLCBzaXplb2YoaW5mbyksICJicGZfb2JqX2dldF9pbmZvX2J5X2ZkIikpDQo+ID4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBpbmZv
LmlkOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCB0ZXN0X3NvY2ttYXBfcHJvZ3Nf
cXVlcnkoZW51bSBicGZfYXR0YWNoX3R5cGUgYXR0YWNoX3R5cGUpDQo+ID4gK3sNCj4gPiArICAg
ICAgIHN0cnVjdCB0ZXN0X3NvY2ttYXBfcHJvZ3NfcXVlcnkgKnNrZWw7DQo+ID4gKyAgICAgICBp
bnQgZXJyLCBtYXBfZmQsIHZlcmRpY3RfZmQsIGR1cmF0aW9uID0gMDsNCj4gDQo+IFRoZSAnZHVy
YXRpb24nIGlzIHVudXNlZC4NCj4gWW91IHNob3VsZCBoYXZlIHNlZW4gYSB3YXJuaW5nIHdoaWxl
IGNvbXBpbGluZyB0aGUgc2VsZnRlc3RzPw0KPiANCj4gQW55d2F5LiBJJ3ZlIGZpeGVkIGl0IHdo
aWxlIGFwcGx5aW5nLg0KDQpUaGFuayB5b3UuIEknbGwgYmUgbW9yZSBjYXJlZnVsIG5leHQgdGlt
ZS4NCg0K
