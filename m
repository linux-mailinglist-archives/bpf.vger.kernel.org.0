Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD857B23B
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiGTICd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 04:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGTICc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 04:02:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34822237F2;
        Wed, 20 Jul 2022 01:02:31 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lnp6M6V2hz688nt;
        Wed, 20 Jul 2022 16:00:43 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 10:02:28 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 20 Jul 2022 10:02:28 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
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
Thread-Index: AQHYm6d/RXaIdRF8qEmfFsB1DNrrP62GBpoAgADe8JA=
Date:   Wed, 20 Jul 2022 08:02:28 +0000
Message-ID: <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
In-Reply-To: <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
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
dDogVHVlc2RheSwgSnVseSAxOSwgMjAyMiAxMDo0MCBQTQ0KPiBPbiBUdWUsIEp1bCAxOSwgMjAy
MiBhdCAxMjo0MCBQTSBKb2UgQnVydG9uIDxqZXZidXJ0b24ua2VybmVsQGdtYWlsLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBKb2UgQnVydG9uIDxqZXZidXJ0b25AZ29vZ2xlLmNvbT4N
Cj4gPg0KPiA+IEFkZCBhbiBleHRlbnNpYmxlIHZhcmlhbnQgb2YgYnBmX29ial9nZXQoKSBjYXBh
YmxlIG9mIHNldHRpbmcgdGhlDQo+ID4gYGZpbGVfZmxhZ3NgIHBhcmFtZXRlci4NCj4gPg0KPiA+
IFRoaXMgcGFyYW1ldGVyIGlzIG5lZWRlZCB0byBlbmFibGUgdW5wcml2aWxlZ2VkIGFjY2VzcyB0
byBCUEYgbWFwcy4NCj4gPiBXaXRob3V0IGEgbWV0aG9kIGxpa2UgdGhpcywgdXNlcnMgbXVzdCBt
YW51YWxseSBtYWtlIHRoZSBzeXNjYWxsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9lIEJ1
cnRvbiA8amV2YnVydG9uQGdvb2dsZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogU3RhbmlzbGF2
IEZvbWljaGV2IDxzZGZAZ29vZ2xlLmNvbT4NCj4gDQo+IEZvciBjb250ZXh0Og0KPiBXZSd2ZSBm
b3VuZCB0aGlzIG91dCB3aGlsZSB3ZSB3ZXJlIHRyeWluZyB0byBhZGQgc3VwcG9ydCBmb3IgdW5w
cml2DQo+IHByb2Nlc3NlcyB0byBvcGVuIHBpbm5lZCByLXggbWFwcy4NCj4gTWF5YmUgdGhpcyBk
ZXNlcnZlcyBhIHRlc3QgYXMgd2VsbD8gTm90IHN1cmUuDQoNCkhpIFN0YW5pc2xhdiwgSm9lDQoN
Ckkgbm90aWNlZCBub3cgdGhpcyBwYXRjaC4gSSdtIGRvaW5nIGEgYnJvYWRlciB3b3JrIHRvIGFk
ZCBvcHRzDQp0byBicGZfKl9nZXRfZmRfYnlfaWQoKS4gSSBhbHNvIGFkanVzdGVkIHBlcm1pc3Np
b25zIG9mIGJwZnRvb2wNCmRlcGVuZGluZyBvbiB0aGUgb3BlcmF0aW9uIHR5cGUgKGUuZy4gc2hv
dywgZHVtcDogQlBGX0ZfUkRPTkxZKS4NCg0KV2lsbCBzZW5kIGl0IHNvb24gKEknbSB0cnlpbmcg
dG8gc29sdmUgYW4gaXNzdWUgd2l0aCB0aGUgQ0ksIHdoZXJlDQpsaWJiZmQgaXMgbm90IGF2YWls
YWJsZSBpbiB0aGUgVk0gZG9pbmcgYWN0dWFsIHRlc3RzKS4NCg0KUm9iZXJ0bw0KDQo+ID4gLS0t
DQo+ID4gIHRvb2xzL2xpYi9icGYvYnBmLmMgICAgICB8IDEwICsrKysrKysrKysNCj4gPiAgdG9v
bHMvbGliL2JwZi9icGYuaCAgICAgIHwgIDkgKysrKysrKysrDQo+ID4gIHRvb2xzL2xpYi9icGYv
bGliYnBmLm1hcCB8ICAxICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9icGYuYyBiL3Rvb2xzL2xpYi9i
cGYvYnBmLmMNCj4gPiBpbmRleCA1ZWIwZGY5MGViMmIuLjVhY2IwZThiZDEzYyAxMDA2NDQNCj4g
PiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gKysrIGIvdG9vbHMvbGliL2JwZi9icGYu
Yw0KPiA+IEBAIC01NzgsMTIgKzU3OCwyMiBAQCBpbnQgYnBmX29ial9waW4oaW50IGZkLCBjb25z
dCBjaGFyICpwYXRobmFtZSkNCj4gPiAgfQ0KPiA+DQo+ID4gIGludCBicGZfb2JqX2dldChjb25z
dCBjaGFyICpwYXRobmFtZSkNCj4gPiArew0KPiA+ICsgICAgICAgTElCQlBGX09QVFMoYnBmX29i
al9nZXRfb3B0cywgb3B0cyk7DQo+ID4gKyAgICAgICByZXR1cm4gYnBmX29ial9nZXRfb3B0cyhw
YXRobmFtZSwgJm9wdHMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgYnBmX29ial9nZXRfb3B0
cyhjb25zdCBjaGFyICpwYXRobmFtZSwgY29uc3Qgc3RydWN0IGJwZl9vYmpfZ2V0X29wdHMNCj4g
Km9wdHMpDQo+ID4gIHsNCj4gPiAgICAgICAgIHVuaW9uIGJwZl9hdHRyIGF0dHI7DQo+ID4gICAg
ICAgICBpbnQgZmQ7DQo+ID4NCj4gPiArICAgICAgIGlmICghT1BUU19WQUxJRChvcHRzLCBicGZf
b2JqX2dldF9vcHRzKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGxpYmJwZl9lcnIoLUVJ
TlZBTCk7DQo+ID4gKw0KPiA+ICAgICAgICAgbWVtc2V0KCZhdHRyLCAwLCBzaXplb2YoYXR0cikp
Ow0KPiA+ICAgICAgICAgYXR0ci5wYXRobmFtZSA9IHB0cl90b191NjQoKHZvaWQgKilwYXRobmFt
ZSk7DQo+ID4gKyAgICAgICBhdHRyLmZpbGVfZmxhZ3MgPSBPUFRTX0dFVChvcHRzLCBmaWxlX2Zs
YWdzLCAwKTsNCj4gPg0KPiA+ICAgICAgICAgZmQgPSBzeXNfYnBmX2ZkKEJQRl9PQkpfR0VULCAm
YXR0ciwgc2l6ZW9mKGF0dHIpKTsNCj4gPiAgICAgICAgIHJldHVybiBsaWJicGZfZXJyX2Vycm5v
KGZkKTsNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9icGYuaCBiL3Rvb2xzL2xpYi9i
cGYvYnBmLmgNCj4gPiBpbmRleCA4OGE3Y2M0YmQ3NmYuLmYzMWI0OTNiNWY5YSAxMDA2NDQNCj4g
PiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5oDQo+ID4gKysrIGIvdG9vbHMvbGliL2JwZi9icGYu
aA0KPiA+IEBAIC0yNzAsOCArMjcwLDE3IEBAIExJQkJQRl9BUEkgaW50IGJwZl9tYXBfdXBkYXRl
X2JhdGNoKGludCBmZCwgY29uc3QNCj4gdm9pZCAqa2V5cywgY29uc3Qgdm9pZCAqdmFsdWVzDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX191MzIgKmNvdW50LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBicGZfbWFw
X2JhdGNoX29wdHMgKm9wdHMpOw0KPiA+DQo+ID4gK3N0cnVjdCBicGZfb2JqX2dldF9vcHRzIHsN
Cj4gPiArICAgICAgIHNpemVfdCBzejsgLyogc2l6ZSBvZiB0aGlzIHN0cnVjdCBmb3IgZm9yd2Fy
ZC9iYWNrd2FyZCBjb21wYXRpYmlsaXR5ICovDQo+ID4gKw0KPiA+ICsgICAgICAgX191MzIgZmls
ZV9mbGFnczsNCj4gPiArfTsNCj4gPiArI2RlZmluZSBicGZfb2JqX2dldF9vcHRzX19sYXN0X2Zp
ZWxkIGZpbGVfZmxhZ3MNCj4gPiArDQo+ID4gIExJQkJQRl9BUEkgaW50IGJwZl9vYmpfcGluKGlu
dCBmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ICBMSUJCUEZfQVBJIGludCBicGZfb2Jq
X2dldChjb25zdCBjaGFyICpwYXRobmFtZSk7DQo+ID4gK0xJQkJQRl9BUEkgaW50IGJwZl9vYmpf
Z2V0X29wdHMoY29uc3QgY2hhciAqcGF0aG5hbWUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBzdHJ1Y3QgYnBmX29ial9nZXRfb3B0cyAqb3B0cyk7DQo+ID4NCj4g
PiAgc3RydWN0IGJwZl9wcm9nX2F0dGFjaF9vcHRzIHsNCj4gPiAgICAgICAgIHNpemVfdCBzejsg
Lyogc2l6ZSBvZiB0aGlzIHN0cnVjdCBmb3IgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmlsaXR5
ICovDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcCBiL3Rvb2xzL2xp
Yi9icGYvbGliYnBmLm1hcA0KPiA+IGluZGV4IDA2MjVhZGI5ZTg4OC4uMTE5ZTZlMWVhN2YxIDEw
MDY0NA0KPiA+IC0tLSBhL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcA0KPiA+ICsrKyBiL3Rvb2xz
L2xpYi9icGYvbGliYnBmLm1hcA0KPiA+IEBAIC0zNTUsNiArMzU1LDcgQEAgTElCQlBGXzAuOC4w
IHsNCj4gPg0KPiA+ICBMSUJCUEZfMS4wLjAgew0KPiA+ICAgICAgICAgZ2xvYmFsOg0KPiA+ICsg
ICAgICAgICAgICAgICBicGZfb2JqX2dldF9vcHRzOw0KPiA+ICAgICAgICAgICAgICAgICBicGZf
cHJvZ19xdWVyeV9vcHRzOw0KPiA+ICAgICAgICAgICAgICAgICBicGZfcHJvZ3JhbV9fYXR0YWNo
X2tzeXNjYWxsOw0KPiA+ICAgICAgICAgICAgICAgICBidGZfX2FkZF9lbnVtNjQ7DQo+ID4gLS0N
Cj4gPiAyLjM3LjAuMTcwLmc0NDRkMWVhYmQwLWdvb2cNCj4gPg0K
