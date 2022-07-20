Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB457C013
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 00:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiGTWan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 18:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTWal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 18:30:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705013DF5;
        Wed, 20 Jul 2022 15:30:40 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp9N32qzxz67yQq;
        Thu, 21 Jul 2022 06:28:51 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 00:30:37 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 21 Jul 2022 00:30:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Stanislav Fomichev <sdf@google.com>
CC:     Joe Burton <jevburton.kernel@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
Subject: RE: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Thread-Topic: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Thread-Index: AQHYm6d/RXaIdRF8qEmfFsB1DNrrP62GBpoAgADe8JCAAGROAIAAjdQg
Date:   Wed, 20 Jul 2022 22:30:37 +0000
Message-ID: <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
 <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
In-Reply-To: <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.206.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBGcm9tOiBTdGFuaXNsYXYgRm9taWNoZXYgW21haWx0bzpzZGZAZ29vZ2xlLmNvbV0NCj4gU2Vu
dDogV2VkbmVzZGF5LCBKdWx5IDIwLCAyMDIyIDU6NTcgUE0NCj4gT24gV2VkLCBKdWwgMjAsIDIw
MjIgYXQgMTowMiBBTSBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBTdGFuaXNsYXYgRm9taWNoZXYgW21haWx0bzpzZGZA
Z29vZ2xlLmNvbV0NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTksIDIwMjIgMTA6NDAgUE0N
Cj4gPiA+IE9uIFR1ZSwgSnVsIDE5LCAyMDIyIGF0IDEyOjQwIFBNIEpvZSBCdXJ0b24gPGpldmJ1
cnRvbi5rZXJuZWxAZ21haWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZy
b206IEpvZSBCdXJ0b24gPGpldmJ1cnRvbkBnb29nbGUuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBB
ZGQgYW4gZXh0ZW5zaWJsZSB2YXJpYW50IG9mIGJwZl9vYmpfZ2V0KCkgY2FwYWJsZSBvZiBzZXR0
aW5nIHRoZQ0KPiA+ID4gPiBgZmlsZV9mbGFnc2AgcGFyYW1ldGVyLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIHBhcmFtZXRlciBpcyBuZWVkZWQgdG8gZW5hYmxlIHVucHJpdmlsZWdlZCBhY2Nlc3Mg
dG8gQlBGIG1hcHMuDQo+ID4gPiA+IFdpdGhvdXQgYSBtZXRob2QgbGlrZSB0aGlzLCB1c2VycyBt
dXN0IG1hbnVhbGx5IG1ha2UgdGhlIHN5c2NhbGwuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEpvZSBCdXJ0b24gPGpldmJ1cnRvbkBnb29nbGUuY29tPg0KPiA+ID4NCj4gPiA+IFJl
dmlld2VkLWJ5OiBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBnb29nbGUuY29tPg0KPiA+ID4NCj4g
PiA+IEZvciBjb250ZXh0Og0KPiA+ID4gV2UndmUgZm91bmQgdGhpcyBvdXQgd2hpbGUgd2Ugd2Vy
ZSB0cnlpbmcgdG8gYWRkIHN1cHBvcnQgZm9yIHVucHJpdg0KPiA+ID4gcHJvY2Vzc2VzIHRvIG9w
ZW4gcGlubmVkIHIteCBtYXBzLg0KPiA+ID4gTWF5YmUgdGhpcyBkZXNlcnZlcyBhIHRlc3QgYXMg
d2VsbD8gTm90IHN1cmUuDQo+ID4NCj4gPiBIaSBTdGFuaXNsYXYsIEpvZQ0KPiA+DQo+ID4gSSBu
b3RpY2VkIG5vdyB0aGlzIHBhdGNoLiBJJ20gZG9pbmcgYSBicm9hZGVyIHdvcmsgdG8gYWRkIG9w
dHMNCj4gPiB0byBicGZfKl9nZXRfZmRfYnlfaWQoKS4gSSBhbHNvIGFkanVzdGVkIHBlcm1pc3Np
b25zIG9mIGJwZnRvb2wNCj4gPiBkZXBlbmRpbmcgb24gdGhlIG9wZXJhdGlvbiB0eXBlIChlLmcu
IHNob3csIGR1bXA6IEJQRl9GX1JET05MWSkuDQo+ID4NCj4gPiBXaWxsIHNlbmQgaXQgc29vbiAo
SSdtIHRyeWluZyB0byBzb2x2ZSBhbiBpc3N1ZSB3aXRoIHRoZSBDSSwgd2hlcmUNCj4gPiBsaWJi
ZmQgaXMgbm90IGF2YWlsYWJsZSBpbiB0aGUgVk0gZG9pbmcgYWN0dWFsIHRlc3RzKS4NCj4gDQo+
IElzIHNvbWV0aGluZyBsaWtlIHRoaXMgcGF0Y2ggaW5jbHVkZWQgaW4geW91ciBzZXJpZXMgYXMg
d2VsbD8gQ2FuIHlvdQ0KPiB1c2UgdGhpcyBuZXcgaW50ZXJmYWNlIG9yIGRvIHlvdSBuZWVkIHNv
bWV0aGluZyBkaWZmZXJlbnQ/DQoNCkl0IGlzIHZlcnkgc2ltaWxhci4gRXhjZXB0IHRoYXQgSSBj
YWxsZWQgaXQgYnBmX2dldF9mZF9vcHRzLCBhcyBpdA0KaXMgc2hhcmVkIHdpdGggdGhlIGJwZl8q
X2dldF9mZF9ieV9pZCgpIGZ1bmN0aW9ucy4gVGhlIG1lbWJlcg0KbmFtZSBpcyBqdXN0IGZsYWdz
LCBwbHVzIGFuIGV4dHJhIHUzMiBmb3IgYWxpZ25tZW50Lg0KDQpJdCBuZWVkcyB0byBiZSBzaGFy
ZWQsIGFzIHRoZXJlIGFyZSBmdW5jdGlvbnMgaW4gYnBmdG9vbCBjYWxsaW5nDQpib3RoLiBTaW5j
ZSB0aGUgbWVhbmluZyBvZiBmbGFncyBpcyB0aGUgc2FtZSwgc2VlbXMgb2sgc2hhcmluZy4NCg0K
Um9iZXJ0bw0KDQo+ID4gUm9iZXJ0bw0KPiA+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgdG9vbHMv
bGliL2JwZi9icGYuYyAgICAgIHwgMTAgKysrKysrKysrKw0KPiA+ID4gPiAgdG9vbHMvbGliL2Jw
Zi9icGYuaCAgICAgIHwgIDkgKysrKysrKysrDQo+ID4gPiA+ICB0b29scy9saWIvYnBmL2xpYmJw
Zi5tYXAgfCAgMSArDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykN
Cj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmMgYi90b29s
cy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+IGluZGV4IDVlYjBkZjkwZWIyYi4uNWFjYjBlOGJkMTNj
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+ICsrKyBi
L3Rvb2xzL2xpYi9icGYvYnBmLmMNCj4gPiA+ID4gQEAgLTU3OCwxMiArNTc4LDIyIEBAIGludCBi
cGZfb2JqX3BpbihpbnQgZmQsIGNvbnN0IGNoYXIgKnBhdGhuYW1lKQ0KPiA+ID4gPiAgfQ0KPiA+
ID4gPg0KPiA+ID4gPiAgaW50IGJwZl9vYmpfZ2V0KGNvbnN0IGNoYXIgKnBhdGhuYW1lKQ0KPiA+
ID4gPiArew0KPiA+ID4gPiArICAgICAgIExJQkJQRl9PUFRTKGJwZl9vYmpfZ2V0X29wdHMsIG9w
dHMpOw0KPiA+ID4gPiArICAgICAgIHJldHVybiBicGZfb2JqX2dldF9vcHRzKHBhdGhuYW1lLCAm
b3B0cyk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2ludCBicGZfb2JqX2dldF9v
cHRzKGNvbnN0IGNoYXIgKnBhdGhuYW1lLCBjb25zdCBzdHJ1Y3QNCj4gYnBmX29ial9nZXRfb3B0
cw0KPiA+ID4gKm9wdHMpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAgICAgICAgdW5pb24gYnBmX2F0
dHIgYXR0cjsNCj4gPiA+ID4gICAgICAgICBpbnQgZmQ7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAg
ICAgaWYgKCFPUFRTX1ZBTElEKG9wdHMsIGJwZl9vYmpfZ2V0X29wdHMpKQ0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGxpYmJwZl9lcnIoLUVJTlZBTCk7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gICAgICAgICBtZW1zZXQoJmF0dHIsIDAsIHNpemVvZihhdHRyKSk7DQo+ID4gPiA+ICAgICAg
ICAgYXR0ci5wYXRobmFtZSA9IHB0cl90b191NjQoKHZvaWQgKilwYXRobmFtZSk7DQo+ID4gPiA+
ICsgICAgICAgYXR0ci5maWxlX2ZsYWdzID0gT1BUU19HRVQob3B0cywgZmlsZV9mbGFncywgMCk7
DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgZmQgPSBzeXNfYnBmX2ZkKEJQRl9PQkpfR0VULCAm
YXR0ciwgc2l6ZW9mKGF0dHIpKTsNCj4gPiA+ID4gICAgICAgICByZXR1cm4gbGliYnBmX2Vycl9l
cnJubyhmZCk7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2JwZi5oIGIvdG9v
bHMvbGliL2JwZi9icGYuaA0KPiA+ID4gPiBpbmRleCA4OGE3Y2M0YmQ3NmYuLmYzMWI0OTNiNWY5
YSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9icGYuaA0KPiA+ID4gPiArKysg
Yi90b29scy9saWIvYnBmL2JwZi5oDQo+ID4gPiA+IEBAIC0yNzAsOCArMjcwLDE3IEBAIExJQkJQ
Rl9BUEkgaW50IGJwZl9tYXBfdXBkYXRlX2JhdGNoKGludCBmZCwNCj4gY29uc3QNCj4gPiA+IHZv
aWQgKmtleXMsIGNvbnN0IHZvaWQgKnZhbHVlcw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBfX3UzMiAqY291bnQsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBicGZfbWFwX2JhdGNoX29wdHMgKm9wdHMp
Ow0KPiA+ID4gPg0KPiA+ID4gPiArc3RydWN0IGJwZl9vYmpfZ2V0X29wdHMgew0KPiA+ID4gPiAr
ICAgICAgIHNpemVfdCBzejsgLyogc2l6ZSBvZiB0aGlzIHN0cnVjdCBmb3IgZm9yd2FyZC9iYWNr
d2FyZCBjb21wYXRpYmlsaXR5ICovDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBfX3UzMiBm
aWxlX2ZsYWdzOw0KPiA+ID4gPiArfTsNCj4gPiA+ID4gKyNkZWZpbmUgYnBmX29ial9nZXRfb3B0
c19fbGFzdF9maWVsZCBmaWxlX2ZsYWdzDQo+ID4gPiA+ICsNCj4gPiA+ID4gIExJQkJQRl9BUEkg
aW50IGJwZl9vYmpfcGluKGludCBmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ID4gPiAg
TElCQlBGX0FQSSBpbnQgYnBmX29ial9nZXQoY29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ID4g
PiArTElCQlBGX0FQSSBpbnQgYnBmX29ial9nZXRfb3B0cyhjb25zdCBjaGFyICpwYXRobmFtZSwN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgYnBm
X29ial9nZXRfb3B0cyAqb3B0cyk7DQo+ID4gPiA+DQo+ID4gPiA+ICBzdHJ1Y3QgYnBmX3Byb2df
YXR0YWNoX29wdHMgew0KPiA+ID4gPiAgICAgICAgIHNpemVfdCBzejsgLyogc2l6ZSBvZiB0aGlz
IHN0cnVjdCBmb3IgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmlsaXR5ICovDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5tYXAgYi90b29scy9saWIvYnBmL2xpYmJw
Zi5tYXANCj4gPiA+ID4gaW5kZXggMDYyNWFkYjllODg4Li4xMTllNmUxZWE3ZjEgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcA0KPiA+ID4gPiArKysgYi90b29s
cy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiA+ID4gQEAgLTM1NSw2ICszNTUsNyBAQCBMSUJCUEZf
MC44LjAgew0KPiA+ID4gPg0KPiA+ID4gPiAgTElCQlBGXzEuMC4wIHsNCj4gPiA+ID4gICAgICAg
ICBnbG9iYWw6DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBicGZfb2JqX2dldF9vcHRzOw0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgYnBmX3Byb2dfcXVlcnlfb3B0czsNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIGJwZl9wcm9ncmFtX19hdHRhY2hfa3N5c2NhbGw7DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICBidGZfX2FkZF9lbnVtNjQ7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzcuMC4xNzAu
ZzQ0NGQxZWFiZDAtZ29vZw0KPiA+ID4gPg0K
