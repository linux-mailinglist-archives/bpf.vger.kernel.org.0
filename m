Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4693D57C037
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGTWoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGTWoZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 18:44:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A148CAA;
        Wed, 20 Jul 2022 15:44:23 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp9dx5rNPz67KX2;
        Thu, 21 Jul 2022 06:40:53 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 00:44:21 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 21 Jul 2022 00:44:20 +0200
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
Thread-Index: AQHYm6d/RXaIdRF8qEmfFsB1DNrrP62GBpoAgADe8JCAAGROAIAAjdQg///iSICAACHbgA==
Date:   Wed, 20 Jul 2022 22:44:20 +0000
Message-ID: <0c284e09817e4e699aa448aa25af5d79@huawei.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
 <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
 <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com>
 <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
In-Reply-To: <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
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
dDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgMTI6MzggQU0NCj4gT24gV2VkLCBKdWwgMjAsIDIw
MjIgYXQgMzozMCBQTSBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBTdGFuaXNsYXYgRm9taWNoZXYgW21haWx0bzpzZGZA
Z29vZ2xlLmNvbV0NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyMCwgMjAyMiA1OjU3IFBN
DQo+ID4gPiBPbiBXZWQsIEp1bCAyMCwgMjAyMiBhdCAxOjAyIEFNIFJvYmVydG8gU2Fzc3UNCj4g
PHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiA+IEZyb206IFN0YW5pc2xhdiBGb21pY2hldiBbbWFpbHRvOnNkZkBnb29nbGUuY29tXQ0KPiA+
ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTksIDIwMjIgMTA6NDAgUE0NCj4gPiA+ID4gPiBP
biBUdWUsIEp1bCAxOSwgMjAyMiBhdCAxMjo0MCBQTSBKb2UgQnVydG9uDQo+IDxqZXZidXJ0b24u
a2VybmVsQGdtYWlsLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBGcm9tOiBKb2UgQnVydG9uIDxqZXZidXJ0b25AZ29vZ2xlLmNvbT4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBBZGQgYW4gZXh0ZW5zaWJsZSB2YXJpYW50IG9mIGJwZl9vYmpfZ2V0KCkg
Y2FwYWJsZSBvZiBzZXR0aW5nIHRoZQ0KPiA+ID4gPiA+ID4gYGZpbGVfZmxhZ3NgIHBhcmFtZXRl
ci4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIHBhcmFtZXRlciBpcyBuZWVkZWQgdG8g
ZW5hYmxlIHVucHJpdmlsZWdlZCBhY2Nlc3MgdG8gQlBGIG1hcHMuDQo+ID4gPiA+ID4gPiBXaXRo
b3V0IGEgbWV0aG9kIGxpa2UgdGhpcywgdXNlcnMgbXVzdCBtYW51YWxseSBtYWtlIHRoZSBzeXNj
YWxsLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvZSBCdXJ0b24g
PGpldmJ1cnRvbkBnb29nbGUuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6
IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBGb3IgY29udGV4dDoNCj4gPiA+ID4gPiBXZSd2ZSBmb3VuZCB0aGlzIG91dCB3aGlsZSB3ZSB3
ZXJlIHRyeWluZyB0byBhZGQgc3VwcG9ydCBmb3IgdW5wcml2DQo+ID4gPiA+ID4gcHJvY2Vzc2Vz
IHRvIG9wZW4gcGlubmVkIHIteCBtYXBzLg0KPiA+ID4gPiA+IE1heWJlIHRoaXMgZGVzZXJ2ZXMg
YSB0ZXN0IGFzIHdlbGw/IE5vdCBzdXJlLg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBTdGFuaXNsYXYs
IEpvZQ0KPiA+ID4gPg0KPiA+ID4gPiBJIG5vdGljZWQgbm93IHRoaXMgcGF0Y2guIEknbSBkb2lu
ZyBhIGJyb2FkZXIgd29yayB0byBhZGQgb3B0cw0KPiA+ID4gPiB0byBicGZfKl9nZXRfZmRfYnlf
aWQoKS4gSSBhbHNvIGFkanVzdGVkIHBlcm1pc3Npb25zIG9mIGJwZnRvb2wNCj4gPiA+ID4gZGVw
ZW5kaW5nIG9uIHRoZSBvcGVyYXRpb24gdHlwZSAoZS5nLiBzaG93LCBkdW1wOiBCUEZfRl9SRE9O
TFkpLg0KPiA+ID4gPg0KPiA+ID4gPiBXaWxsIHNlbmQgaXQgc29vbiAoSSdtIHRyeWluZyB0byBz
b2x2ZSBhbiBpc3N1ZSB3aXRoIHRoZSBDSSwgd2hlcmUNCj4gPiA+ID4gbGliYmZkIGlzIG5vdCBh
dmFpbGFibGUgaW4gdGhlIFZNIGRvaW5nIGFjdHVhbCB0ZXN0cykuDQo+ID4gPg0KPiA+ID4gSXMg
c29tZXRoaW5nIGxpa2UgdGhpcyBwYXRjaCBpbmNsdWRlZCBpbiB5b3VyIHNlcmllcyBhcyB3ZWxs
PyBDYW4geW91DQo+ID4gPiB1c2UgdGhpcyBuZXcgaW50ZXJmYWNlIG9yIGRvIHlvdSBuZWVkIHNv
bWV0aGluZyBkaWZmZXJlbnQ/DQo+ID4NCj4gPiBJdCBpcyB2ZXJ5IHNpbWlsYXIuIEV4Y2VwdCB0
aGF0IEkgY2FsbGVkIGl0IGJwZl9nZXRfZmRfb3B0cywgYXMgaXQNCj4gPiBpcyBzaGFyZWQgd2l0
aCB0aGUgYnBmXypfZ2V0X2ZkX2J5X2lkKCkgZnVuY3Rpb25zLiBUaGUgbWVtYmVyDQo+ID4gbmFt
ZSBpcyBqdXN0IGZsYWdzLCBwbHVzIGFuIGV4dHJhIHUzMiBmb3IgYWxpZ25tZW50Lg0KPiANCj4g
V2UgY2FuIGJpa2VzaGVkIHRoZSBuYW1pbmcsIGJ1dCB3ZSd2ZSBiZWVuIHVzaW5nIGV4aXN0aW5n
IGNvbnZlbnRpb25zDQo+IHdoZXJlIG9wdHMgZmllbGRzIG1hdGNoIHN5c2NhbGwgZmllbGRzLCB0
aGF0IHNlZW1zIGxpa2UgYSBzZW5zaWJsZQ0KPiB0aGluZyB0byBkbz8NCg0KVGhlIG9ubHkgcHJv
YmxlbSBpcyB0aGF0IGJwZl8qX2dldF9mZF9ieV9pZCgpIGZ1bmN0aW9ucyB3b3VsZA0Kc2V0IHRo
ZSBvcGVuX2ZsYWdzIG1lbWJlciBvZiBicGZfYXR0ci4NCg0KRmxhZ3Mgd291bGQgYmUgZ29vZCBm
b3IgYm90aCwgZXZlbiBpZiBub3QgZXhhY3QuIEJlbGlldmUgbWUsDQpkdXBsaWNhdGluZyB0aGUg
b3B0cyB3b3VsZCBqdXN0IGNyZWF0ZSBtb3JlIGNvbmZ1c2lvbi4NCg0KPiA+IEl0IG5lZWRzIHRv
IGJlIHNoYXJlZCwgYXMgdGhlcmUgYXJlIGZ1bmN0aW9ucyBpbiBicGZ0b29sIGNhbGxpbmcNCj4g
PiBib3RoLiBTaW5jZSB0aGUgbWVhbmluZyBvZiBmbGFncyBpcyB0aGUgc2FtZSwgc2VlbXMgb2sg
c2hhcmluZy4NCj4gDQo+IFNvIEkgZ3Vlc3MgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMgdG8gdGhl
IGN1cnJlbnQgcGF0Y2g/IElmIGl0IGdldHMNCj4gYWNjZXB0ZWQsIHlvdSBzaG91bGQgYmUgYWJs
ZSB0byBkcm9wIHNvbWUgb2YgeW91ciBjb2RlIGFuZCB1c2UgdGhpcw0KPiBuZXcgYnBmX29ial9n
ZXRfb3B0cy4uDQoNCklmIHlvdSB1c2UgYSBuYW1lIGdvb2QgYWxzbyBmb3IgYnBmXypfZ2V0X2Zk
X2J5X2lkKCkgYW5kIGZsYWdzDQphcyBzdHJ1Y3R1cmUgbWVtYmVyIG5hbWUsIHRoYXQgd291bGQg
YmUgb2suDQoNClJvYmVydG8NCg0KPiA+IFJvYmVydG8NCj4gPg0KPiA+ID4gPiBSb2JlcnRvDQo+
ID4gPiA+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICB0b29scy9saWIvYnBmL2JwZi5j
ICAgICAgfCAxMCArKysrKysrKysrDQo+ID4gPiA+ID4gPiAgdG9vbHMvbGliL2JwZi9icGYuaCAg
ICAgIHwgIDkgKysrKysrKysrDQo+ID4gPiA+ID4gPiAgdG9vbHMvbGliL2JwZi9saWJicGYubWFw
IHwgIDEgKw0KPiA+ID4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2JwZi5j
IGIvdG9vbHMvbGliL2JwZi9icGYuYw0KPiA+ID4gPiA+ID4gaW5kZXggNWViMGRmOTBlYjJiLi41
YWNiMGU4YmQxM2MgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5j
DQo+ID4gPiA+ID4gPiArKysgYi90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+ID4gPiBAQCAt
NTc4LDEyICs1NzgsMjIgQEAgaW50IGJwZl9vYmpfcGluKGludCBmZCwgY29uc3QgY2hhcg0KPiAq
cGF0aG5hbWUpDQo+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICBpbnQg
YnBmX29ial9nZXQoY29uc3QgY2hhciAqcGF0aG5hbWUpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4g
PiA+ID4gKyAgICAgICBMSUJCUEZfT1BUUyhicGZfb2JqX2dldF9vcHRzLCBvcHRzKTsNCj4gPiA+
ID4gPiA+ICsgICAgICAgcmV0dXJuIGJwZl9vYmpfZ2V0X29wdHMocGF0aG5hbWUsICZvcHRzKTsN
Cj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAraW50IGJwZl9vYmpf
Z2V0X29wdHMoY29uc3QgY2hhciAqcGF0aG5hbWUsIGNvbnN0IHN0cnVjdA0KPiA+ID4gYnBmX29i
al9nZXRfb3B0cw0KPiA+ID4gPiA+ICpvcHRzKQ0KPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+
ICAgICAgICAgdW5pb24gYnBmX2F0dHIgYXR0cjsNCj4gPiA+ID4gPiA+ICAgICAgICAgaW50IGZk
Ow0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICsgICAgICAgaWYgKCFPUFRTX1ZBTElEKG9wdHMs
IGJwZl9vYmpfZ2V0X29wdHMpKQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBs
aWJicGZfZXJyKC1FSU5WQUwpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gICAgICAgICBt
ZW1zZXQoJmF0dHIsIDAsIHNpemVvZihhdHRyKSk7DQo+ID4gPiA+ID4gPiAgICAgICAgIGF0dHIu
cGF0aG5hbWUgPSBwdHJfdG9fdTY0KCh2b2lkICopcGF0aG5hbWUpOw0KPiA+ID4gPiA+ID4gKyAg
ICAgICBhdHRyLmZpbGVfZmxhZ3MgPSBPUFRTX0dFVChvcHRzLCBmaWxlX2ZsYWdzLCAwKTsNCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgICAgICAgIGZkID0gc3lzX2JwZl9mZChCUEZfT0JKX0dF
VCwgJmF0dHIsIHNpemVvZihhdHRyKSk7DQo+ID4gPiA+ID4gPiAgICAgICAgIHJldHVybiBsaWJi
cGZfZXJyX2Vycm5vKGZkKTsNCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBm
L2JwZi5oIGIvdG9vbHMvbGliL2JwZi9icGYuaA0KPiA+ID4gPiA+ID4gaW5kZXggODhhN2NjNGJk
NzZmLi5mMzFiNDkzYjVmOWEgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS90b29scy9saWIvYnBm
L2JwZi5oDQo+ID4gPiA+ID4gPiArKysgYi90b29scy9saWIvYnBmL2JwZi5oDQo+ID4gPiA+ID4g
PiBAQCAtMjcwLDggKzI3MCwxNyBAQCBMSUJCUEZfQVBJIGludCBicGZfbWFwX3VwZGF0ZV9iYXRj
aChpbnQgZmQsDQo+ID4gPiBjb25zdA0KPiA+ID4gPiA+IHZvaWQgKmtleXMsIGNvbnN0IHZvaWQg
KnZhbHVlcw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
X191MzIgKmNvdW50LA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgc3RydWN0IGJwZl9tYXBfYmF0Y2hfb3B0cyAqb3B0cyk7DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gK3N0cnVjdCBicGZfb2JqX2dldF9vcHRzIHsNCj4gPiA+ID4gPiA+ICsg
ICAgICAgc2l6ZV90IHN6OyAvKiBzaXplIG9mIHRoaXMgc3RydWN0IGZvciBmb3J3YXJkL2JhY2t3
YXJkIGNvbXBhdGliaWxpdHkNCj4gKi8NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAg
ICAgX191MzIgZmlsZV9mbGFnczsNCj4gPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+ID4gKyNkZWZp
bmUgYnBmX29ial9nZXRfb3B0c19fbGFzdF9maWVsZCBmaWxlX2ZsYWdzDQo+ID4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gPiAgTElCQlBGX0FQSSBpbnQgYnBmX29ial9waW4oaW50IGZkLCBjb25zdCBj
aGFyICpwYXRobmFtZSk7DQo+ID4gPiA+ID4gPiAgTElCQlBGX0FQSSBpbnQgYnBmX29ial9nZXQo
Y29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ID4gPiA+ID4gK0xJQkJQRl9BUEkgaW50IGJwZl9v
YmpfZ2V0X29wdHMoY29uc3QgY2hhciAqcGF0aG5hbWUsDQo+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBicGZfb2JqX2dldF9vcHRzICpvcHRz
KTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgc3RydWN0IGJwZl9wcm9nX2F0dGFjaF9vcHRz
IHsNCj4gPiA+ID4gPiA+ICAgICAgICAgc2l6ZV90IHN6OyAvKiBzaXplIG9mIHRoaXMgc3RydWN0
IGZvciBmb3J3YXJkL2JhY2t3YXJkIGNvbXBhdGliaWxpdHkNCj4gKi8NCj4gPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5tYXAgYi90b29scy9saWIvYnBmL2xpYmJw
Zi5tYXANCj4gPiA+ID4gPiA+IGluZGV4IDA2MjVhZGI5ZTg4OC4uMTE5ZTZlMWVhN2YxIDEwMDY0
NA0KPiA+ID4gPiA+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYubWFwDQo+ID4gPiA+ID4g
PiArKysgYi90b29scy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiA+ID4gPiA+IEBAIC0zNTUsNiAr
MzU1LDcgQEAgTElCQlBGXzAuOC4wIHsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgTElCQlBG
XzEuMC4wIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgZ2xvYmFsOg0KPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGJwZl9vYmpfZ2V0X29wdHM7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAg
YnBmX3Byb2dfcXVlcnlfb3B0czsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBicGZfcHJv
Z3JhbV9fYXR0YWNoX2tzeXNjYWxsOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGJ0Zl9f
YWRkX2VudW02NDsNCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiAyLjM3LjAuMTcwLmc0NDRk
MWVhYmQwLWdvb2cNCj4gPiA+ID4gPiA+DQo=
