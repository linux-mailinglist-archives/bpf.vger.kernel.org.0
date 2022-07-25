Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7A57FA0B
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiGYHSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiGYHSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:18:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28DB11A3C
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:18:35 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lrrr24GHnz67xfy;
        Mon, 25 Jul 2022 15:13:54 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 09:18:34 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Mon, 25 Jul 2022 09:18:33 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
CC:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Joe Burton <jevburton.kernel@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: RE: [RFC][PATCH v3 07/15] libbpf: Introduce bpf_obj_get_opts()
Thread-Topic: [RFC][PATCH v3 07/15] libbpf: Introduce bpf_obj_get_opts()
Thread-Index: AQHYne9QbI3DWpUSlUirK/E5YEiLuq2Ki+IAgAAA3YCABCMpUA==
Date:   Mon, 25 Jul 2022 07:18:33 +0000
Message-ID: <0af18af66d7c4efb866d0bbf2057caf1@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-8-roberto.sassu@huawei.com>
 <CAKH8qBuU4TORtzu-SQg-2y8iAgFe31fLBX2joby2eWJdoXGd2A@mail.gmail.com>
 <CAADnVQ+9xYy+tAiTrQudS+gTo-VxqUs4y576-DNCbPKASv9RXg@mail.gmail.com>
In-Reply-To: <CAADnVQ+9xYy+tAiTrQudS+gTo-VxqUs4y576-DNCbPKASv9RXg@mail.gmail.com>
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

PiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgW21haWx0bzphbGV4ZWkuc3Rhcm92b2l0b3ZAZ21h
aWwuY29tXQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjIsIDIwMjIgODowMiBQTQ0KPiBPbiBGcmks
IEp1bCAyMiwgMjAyMiBhdCAxMDo1OCBBTSBTdGFuaXNsYXYgRm9taWNoZXYgPHNkZkBnb29nbGUu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgSnVsIDIyLCAyMDIyIGF0IDEwOjIwIEFNIFJv
YmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gSW50cm9kdWNlIGJwZl9vYmpfZ2V0X29wdHMoKSwgdG8gbGV0IHRoZSBjYWxsZXIgcGFz
cyB0aGUgbmVlZGVkIHBlcm1pc3Npb25zDQo+ID4gPiBmb3IgdGhlIG9wZXJhdGlvbi4gS2VlcCB0
aGUgZXhpc3RpbmcgYnBmX29ial9nZXQoKSB0byByZXF1ZXN0IHJlYWQtd3JpdGUNCj4gPiA+IHBl
cm1pc3Npb25zLg0KPiA+ID4NCj4gPiA+IGJwZl9vYmpfZ2V0KCkgYWxsb3dzIHRoZSBjYWxsZXIg
dG8gZ2V0IGEgZmlsZSBkZXNjcmlwdG9yIGZyb20gYSBwaW5uZWQNCj4gPiA+IG9iamVjdCB3aXRo
IHRoZSBwcm92aWRlZCBwYXRobmFtZS4gU3BlY2lmeWluZyBwZXJtaXNzaW9ucyBoYXMgb25seSBl
ZmZlY3QNCj4gPiA+IG9uIG1hcHMgKGZvciBsaW5rcywgdGhlIHBlcm1pc3Npb24gbXVzdCBiZSBh
bHdheXMgcmVhZC13cml0ZSkuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBT
YXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgdG9vbHMv
bGliL2JwZi9icGYuYyAgICAgIHwgMTIgKysrKysrKysrKystDQo+ID4gPiAgdG9vbHMvbGliL2Jw
Zi9icGYuaCAgICAgIHwgIDIgKysNCj4gPiA+ICB0b29scy9saWIvYnBmL2xpYmJwZi5tYXAgfCAg
MSArDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmMgYi90b29s
cy9saWIvYnBmL2JwZi5jDQo+ID4gPiBpbmRleCA1ZjI3ODVhNGMzNTguLjBkZjA4ODg5MDg2NCAx
MDA2NDQNCj4gPiA+IC0tLSBhL3Rvb2xzL2xpYi9icGYvYnBmLmMNCj4gPiA+ICsrKyBiL3Rvb2xz
L2xpYi9icGYvYnBmLmMNCj4gPiA+IEBAIC01NzcsMTggKzU3NywyOCBAQCBpbnQgYnBmX29ial9w
aW4oaW50IGZkLCBjb25zdCBjaGFyICpwYXRobmFtZSkNCj4gPiA+ICAgICAgICAgcmV0dXJuIGxp
YmJwZl9lcnJfZXJybm8ocmV0KTsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gLWludCBicGZfb2Jq
X2dldChjb25zdCBjaGFyICpwYXRobmFtZSkNCj4gPiA+ICtpbnQgYnBmX29ial9nZXRfb3B0cyhj
b25zdCBjaGFyICpwYXRobmFtZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0
cnVjdCBicGZfZ2V0X2ZkX29wdHMgKm9wdHMpDQo+ID4NCj4gPiBJJ20gc3RpbGwgbm90IHN1cmUg
d2hldGhlciBpdCdzIGEgZ29vZCBpZGVhIHRvIG1peCBnZXRfZmQgd2l0aA0KPiA+IG9ial9nZXQv
cGluIG9wZXJhdGlvbnM/IFsxXSBzZWVtcyBtb3JlIGNsZWFyLg0KPiANCj4gKzENCg0KSSB0aGlu
ayBzby4gQm90aCB0eXBlcyBvZiBmdW5jdGlvbnMgYXJlIGFjY2Vzc2luZyB0aGUgc2FtZSBvYmpl
Y3QsDQpqdXN0IGluIGEgZGlmZmVyZW50IHdheTogb25lIGJ5IElELCBhbmQgYW5vdGhlciBieSBw
YXRoLg0KDQpDb25zaWRlciB0aGUgY2FzZSBJIG1lbnRpb25lZCwgbWFwX3BhcnNlX2ZkcygpIGlu
IGJwZnRvb2wuIEl0IGNhbGxzDQpib3RoIHR5cGUgb2YgZnVuY3Rpb25zLiBXaGF0IG9wdHMgYSBj
YWxsZXIgb2YgdGhpcyBmdW5jdGlvbiBzaG91bGQNCnByb3ZpZGUsIGlmIHRoZXkgYXJlIGRpZmZl
cmVudD8NCg0KPiA+IEl0IGp1c3Qgc28gaGFwcGVucyB0aGF0IChkaWZmZXJlbnRseSBuYW1lZCkg
ZmxhZ3MgaW4gQlBGX09CSl9HRVQgYW5kDQo+ID4gQlBGX1hYWF9HRVRfRkRfQllfSUQgYWxpZ24s
IGJ1dCBtYXliZSB3ZSBzaG91bGRuJ3QgZGVwZW5kIG9uIGl0Pw0KPiA+DQo+ID4gQWxzbywgaXQg
c2VlbXMgb25seSBicGZfbWFwX2dldF9mZF9ieV9pZCBjdXJyZW50bHkgYWNjZXB0cyBmbGFncz8g
U28NCj4gPiB0aGlzIHNoYXJpbmcgbWFrZXMgZXZlbiBtb3JlIHNlbnNlPw0KDQpBcyBJIG1lbnRp
b25lZCBpbiBhbm90aGVyIGVtYWlsLCBBbmRyaWkgcmVxdWVzdGVkIG1lIGluIHYyIHRvIGFkZA0K
b3B0cyB0byBhbGwgYnBmXypfZ2V0X2ZkX2J5X2lkKCkgZnVuY3Rpb25zLg0KDQo+ICsxDQo+IA0K
PiBSb2JlcnRvLCB0aGUgcGF0Y2ggc2V0IGlzIGJyb2tlbiBpbiBtYW55IHdheXMuDQoNCkNvdWxk
IHlvdSBwbGVhc2UgZXhwbGFpbj8NCg0KVGhhbmtzDQoNClJvYmVydG8NCg==
