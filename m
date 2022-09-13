Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF735B663A
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 05:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIMDky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 23:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiIMDkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 23:40:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60A5282E;
        Mon, 12 Sep 2022 20:40:51 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRThm5lBszHntv;
        Tue, 13 Sep 2022 11:38:48 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 11:40:49 +0800
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 11:40:49 +0800
Received: from dggpeml500010.china.huawei.com ([7.185.36.155]) by
 dggpeml500010.china.huawei.com ([7.185.36.155]) with mapi id 15.01.2375.031;
 Tue, 13 Sep 2022 11:40:49 +0800
From:   "Liuxin(EulerOS)" <liuxin350@huawei.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "854182924@qq.com" <854182924@qq.com>,
        "Yanan (Euler)" <yanan@huawei.com>,
        "Wuchangye (EulerOS)" <wuchangye@huawei.com>,
        Xiesongyang <xiesongyang@huawei.com>,
        "zhudi (E)" <zhudi2@huawei.com>,
        "kongweibin (A)" <kongweibin2@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIGxpYmJwZjogQ2xlYW4gdXAgbGVnYWN5IGJw?=
 =?utf-8?Q?f_maps_declaration_in_bpf=5Fhelpers?=
Thread-Topic: [PATCH v2] libbpf: Clean up legacy bpf maps declaration in
 bpf_helpers
Thread-Index: AdjCY85HjE9yfqFYRLS5SLbbKPstawCB444AAK2612A=
Date:   Tue, 13 Sep 2022 03:40:49 +0000
Message-ID: <9bf6d58f55c44c28ab809c2a014a2570@huawei.com>
References: <94275aa1e5af4efea53f322f91b27380@huawei.com>
 <CAEf4BzZw8R1UH4R_FmeAVAXAALmh0ETtMVkOKytvDTs_GxqbLg@mail.gmail.com>
In-Reply-To: <CAEf4BzZw8R1UH4R_FmeAVAXAALmh0ETtMVkOKytvDTs_GxqbLg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.113.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIHRvIFNvbmcgYW5kIEFuZHJpaSBmb3IgdGhlaXIgYWR2aWNlLCBJIHdpbGwgZml4IGl0
IGluIFYzLg0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEFuZHJpaSBOYWty
eWlrbyBbbWFpbHRvOmFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb21dIA0K5Y+R6YCB5pe26Ze0OiAy
MDIy5bm0OeaciDEw5pelIDg6NDQNCuaUtuS7tuS6ujogTGl1eGluKEV1bGVyT1MpIDxsaXV4aW4z
NTBAaHVhd2VpLmNvbT4NCuaKhOmAgTogYW5kcmlpQGtlcm5lbC5vcmc7IGRhbmllbEBpb2dlYXJi
b3gubmV0OyBhc3RAa2VybmVsLm9yZzsgbWFydGluLmxhdUBsaW51eC5kZXY7IHNvbmdAa2VybmVs
Lm9yZzsgeWhzQGZiLmNvbTsgam9obi5mYXN0YWJlbmRAZ21haWwuY29tOyBrcHNpbmdoQGtlcm5l
bC5vcmc7IHNkZkBnb29nbGUuY29tOyBoYW9sdW9AZ29vZ2xlLmNvbTsgam9sc2FAa2VybmVsLm9y
ZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgODU0
MTgyOTI0QHFxLmNvbTsgWWFuYW4gKEV1bGVyKSA8eWFuYW5AaHVhd2VpLmNvbT47IFd1Y2hhbmd5
ZSAoRXVsZXJPUykgPHd1Y2hhbmd5ZUBodWF3ZWkuY29tPjsgWGllc29uZ3lhbmcgPHhpZXNvbmd5
YW5nQGh1YXdlaS5jb20+OyB6aHVkaSAoRSkgPHpodWRpMkBodWF3ZWkuY29tPjsga29uZ3dlaWJp
biAoQSkgPGtvbmd3ZWliaW4yQGh1YXdlaS5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0ggdjJdIGxp
YmJwZjogQ2xlYW4gdXAgbGVnYWN5IGJwZiBtYXBzIGRlY2xhcmF0aW9uIGluIGJwZl9oZWxwZXJz
DQoNCk9uIFR1ZSwgU2VwIDYsIDIwMjIgYXQgNzo1MSBQTSBMaXV4aW4oRXVsZXJPUykgPGxpdXhp
bjM1MEBodWF3ZWkuY29tPiB3cm90ZToNCj4NCj4gTGVnYWN5IGJwZiBtYXBzIGRlY2xhcmF0aW9u
IHdlcmUgbm8gbG9uZ2VyIHN1cHBvcnRlZCBpbiBMaWJicGYgMS4wLCBzbyBpdCB3YXMgdGltZSB0
byByZW1vdmUgdGhlIGRlZmluaXRpb24gb2YgYnBmX21hcF9kZWYgaW4gYnBmX2hlbHBlcnMuaC4N
Cg0KcGxlYXNlIG1ha2Ugc3VyZSB0aGF0IGNvbW1pdCBsb2cgbGluZXMgYXJlIHdyYXBwZWQgYXQg
PDgwIGNoYXJhY3RlcnMNCj4NCj4gTElOSzpbMV0gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJi
cGYvbGliYnBmL3dpa2kvTGliYnBmOi10aGUtcm9hZC10by12MS4wDQoNCmRvbid0IGFkZCAiTElO
SyIsIGp1c3QgdHdvIHNwYWNlcyBhbmQgdGhlbiBbMF0gYW5kIHRoZW4gcmVmZXIgdG8gaXQgZnJv
bSB0aGUgYWJvdmUgYXMgInN1cHBvcnRlZCBpbiBMaWJicGYgMS4wIChbMF0pIg0KDQoNCj4NCj4g
QWNrZWQtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFhp
biBMaXU8bGl1eGluMzUwQGh1YXdlaS5jb20+DQoNCnNwYWNlIGFmdGVyIG5hbWUgYW5kIGJlZm9y
ZSBvcGVuaW5nIDwgaXMgbWlzc2luZw0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgICAg
LSBGaXggc3RyYW5nZSBzaWduYXR1cmVzDQo+DQoNCkl0IGxvb2tzIGdvb2Qgb3ZlcmFsbCwgYnV0
IHlvdXIgcGF0Y2ggZG9lc24ndCBhcHBseS4gUGxlYXNlIG1ha2Ugc3VyZSB5b3UgYmFzZSBpdCBv
biB0b3Agb2YgYnBmLW5leHQncyBtYXN0ZXIgYW5kIHlvdSB1c2UgZ2l0IHNlbmQtZW1haWwgd2hp
Y2ggd29uJ3QgY2xvYmJlciB0aGUgcGF0Y2guIFRoYW5rcy4NCg0KPiBWMTogDQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2JwZi9DQVBoc3VXN0VtNnE1aHFpS1dFWnBKT2FVNURUclpFK0JQUEhx
K0NoeXoNCj4gMC0rLXlRX1pBQG1haWwuZ21haWwuY29tL1QvI3QNCj4NCj4gdG9vbHMvbGliL2Jw
Zi9icGZfaGVscGVycy5oIHwgMTIgLS0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAxMiBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmX2hlbHBlcnMu
aCBiL3Rvb2xzL2xpYi9icGYvYnBmX2hlbHBlcnMuaCANCj4gaW5kZXggODY3YjczNDgzLi45Y2Fk
MTNlN2YgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9icGYvYnBmX2hlbHBlcnMuaA0KPiArKysg
Yi90b29scy9saWIvYnBmL2JwZl9oZWxwZXJzLmgNCj4gQEAgLTE2NywxOCArMTY3LDYgQEAgYnBm
X3RhaWxfY2FsbF9zdGF0aWModm9pZCAqY3R4LCBjb25zdCB2b2lkICptYXAsIA0KPiBjb25zdCBf
X3UzMiBzbG90KSB9ICNlbmRpZg0KPg0KPiAtLyoNCj4gLSAqIEhlbHBlciBzdHJ1Y3R1cmUgdXNl
ZCBieSBlQlBGIEMgcHJvZ3JhbQ0KPiAtICogdG8gZGVzY3JpYmUgQlBGIG1hcCBhdHRyaWJ1dGVz
IHRvIGxpYmJwZiBsb2FkZXINCj4gLSAqLw0KPiAtc3RydWN0IGJwZl9tYXBfZGVmIHsNCj4gLSAg
ICAgICB1bnNpZ25lZCBpbnQgdHlwZTsNCj4gLSAgICAgICB1bnNpZ25lZCBpbnQga2V5X3NpemU7
DQo+IC0gICAgICAgdW5zaWduZWQgaW50IHZhbHVlX3NpemU7DQo+IC0gICAgICAgdW5zaWduZWQg
aW50IG1heF9lbnRyaWVzOw0KPiAtICAgICAgIHVuc2lnbmVkIGludCBtYXBfZmxhZ3M7DQo+IC19
IF9fYXR0cmlidXRlX18oKGRlcHJlY2F0ZWQoInVzZSBCVEYtZGVmaW5lZCBtYXBzIGluIC5tYXBz
IA0KPiBzZWN0aW9uIikpKTsNCj4gLQ0KPiBlbnVtIGxpYmJwZl9waW5fdHlwZSB7DQo+ICAgICAg
ICAgTElCQlBGX1BJTl9OT05FLA0KPiAgICAgICAgIC8qIFBJTl9CWV9OQU1FOiBwaW4gbWFwcyBi
eSBuYW1lIChpbiAvc3lzL2ZzL2JwZiBieSBkZWZhdWx0KSANCj4gKi8NCj4gLS0NCj4gMi4zMy4w
DQo=
