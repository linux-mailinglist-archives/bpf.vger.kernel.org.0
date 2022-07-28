Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8085839E8
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiG1H6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 03:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiG1H6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 03:58:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B550738;
        Thu, 28 Jul 2022 00:58:47 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LtjZx28shz67xvP;
        Thu, 28 Jul 2022 15:54:01 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:58:45 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 28 Jul 2022 09:58:45 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Burton <jevburton.kernel@gmail.com>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joe Burton <jevburton@google.com>
Subject: RE: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Thread-Topic: [PATCH v2 bpf-next] libbpf: Add bpf_obj_get_opts()
Thread-Index: AQHYm6d/RXaIdRF8qEmfFsB1DNrrP62SwR6AgAC2uWA=
Date:   Thu, 28 Jul 2022 07:58:44 +0000
Message-ID: <03011a0506e8474db73c8c1fa9ec0786@huawei.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com>
In-Reply-To: <CAEf4BzbWpQS6js5LfS80PkqwDwcLc+NgzfqqUTG-CkLP16shCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.37]
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

PiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gW21haWx0bzphbmRyaWkubmFrcnlpa29AZ21haWwuY29t
XQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyOCwgMjAyMiAxOjAzIEFNDQo+IE9uIFR1ZSwgSnVs
IDE5LCAyMDIyIGF0IDEyOjQwIFBNIEpvZSBCdXJ0b24gPGpldmJ1cnRvbi5rZXJuZWxAZ21haWwu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEpvZSBCdXJ0b24gPGpldmJ1cnRvbkBnb29n
bGUuY29tPg0KPiA+DQo+ID4gQWRkIGFuIGV4dGVuc2libGUgdmFyaWFudCBvZiBicGZfb2JqX2dl
dCgpIGNhcGFibGUgb2Ygc2V0dGluZyB0aGUNCj4gPiBgZmlsZV9mbGFnc2AgcGFyYW1ldGVyLg0K
PiA+DQo+ID4gVGhpcyBwYXJhbWV0ZXIgaXMgbmVlZGVkIHRvIGVuYWJsZSB1bnByaXZpbGVnZWQg
YWNjZXNzIHRvIEJQRiBtYXBzLg0KPiA+IFdpdGhvdXQgYSBtZXRob2QgbGlrZSB0aGlzLCB1c2Vy
cyBtdXN0IG1hbnVhbGx5IG1ha2UgdGhlIHN5c2NhbGwuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKb2UgQnVydG9uIDxqZXZidXJ0b25AZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMv
bGliL2JwZi9icGYuYyAgICAgIHwgMTAgKysrKysrKysrKw0KPiA+ICB0b29scy9saWIvYnBmL2Jw
Zi5oICAgICAgfCAgOSArKysrKysrKysNCj4gPiAgdG9vbHMvbGliL2JwZi9saWJicGYubWFwIHwg
IDEgKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPg0KPiANCj4g
SSBhZ3JlZSB0aGF0IGJwZl9vYmpfZ2V0X29wdHMgc2hvdWxkIGJlIHNlcGFyYXRlIGZyb20gYnBm
X2dldF9mZF9vcHRzLg0KPiBKdXN0IGJlY2F1c2UgYm90aCBjdXJyZW50bHkgaGF2ZSBmaWxlX2Zs
YWdzIGluIHRoZW0gZG9lc24ndCBtZWFuIHRoYXQNCj4gdGhleSBzaG91bGQvd2lsbCBhbHdheXMg
c3RheSBpbiBzeW5jLiBTbyB0d28gc2VwYXJhdGUgb3B0cyBmb3IgdHdvDQo+IHNlcGFyYXRlIEFQ
SXMgbWFrZXMgc2Vuc2UgdG8gbWUuDQo+IA0KPiBTbyBJJ2QgYWNjZXB0IHRoaXMgcGF0Y2gsIGJ1
dCBwbGVhc2Ugc2VlIGEgZmV3IHNtYWxsIHRoaW5ncyBiZWxvdyBhbmQNCj4gc2VuZCB2My4gVGhh
bmtzIQ0KDQpTaG91bGQgbWFwX3BhcnNlX2ZkcygpIGFjY2VwdCB0d28gb3B0cywgb3IganVzdCB0
aGUgZmxhZ3MNCnRvIGJlIHNldCBvbiBsb2NhbGx5LWRlZmluZWQgdmFyaWFibGVzPw0KDQpUaGFu
a3MNCg0KUm9iZXJ0bw0KDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmMgYi90
b29scy9saWIvYnBmL2JwZi5jDQo+ID4gaW5kZXggNWViMGRmOTBlYjJiLi41YWNiMGU4YmQxM2Mg
MTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9icGYuYw0KPiA+ICsrKyBiL3Rvb2xzL2xp
Yi9icGYvYnBmLmMNCj4gPiBAQCAtNTc4LDEyICs1NzgsMjIgQEAgaW50IGJwZl9vYmpfcGluKGlu
dCBmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUpDQo+ID4gIH0NCj4gPg0KPiA+ICBpbnQgYnBmX29i
al9nZXQoY29uc3QgY2hhciAqcGF0aG5hbWUpDQo+ID4gK3sNCj4gPiArICAgICAgIExJQkJQRl9P
UFRTKGJwZl9vYmpfZ2V0X29wdHMsIG9wdHMpOw0KPiANCj4gaWYgeW91IHdlcmUgZG9pbmcgaXQg
dGhpcyB3YXksIGhlcmUgc2hvdWxkIGJlIGFuIGVtcHR5IGxpbmUuIEJ1dA0KPiByZWFsbHkgeW91
IGNhbi9zaG91bGQganVzdCBwYXNzIE5VTEwgaW5zdGVhZCBvZiBvcHRzIGluIHRoaXMgY2FzZS4N
Cj4gDQo+ID4gKyAgICAgICByZXR1cm4gYnBmX29ial9nZXRfb3B0cyhwYXRobmFtZSwgJm9wdHMp
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgYnBmX29ial9nZXRfb3B0cyhjb25zdCBjaGFyICpw
YXRobmFtZSwgY29uc3Qgc3RydWN0IGJwZl9vYmpfZ2V0X29wdHMNCj4gKm9wdHMpDQo+ID4gIHsN
Cj4gPiAgICAgICAgIHVuaW9uIGJwZl9hdHRyIGF0dHI7DQo+ID4gICAgICAgICBpbnQgZmQ7DQo+
ID4NCj4gPiArICAgICAgIGlmICghT1BUU19WQUxJRChvcHRzLCBicGZfb2JqX2dldF9vcHRzKSkN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGxpYmJwZl9lcnIoLUVJTlZBTCk7DQo+ID4gKw0K
PiA+ICAgICAgICAgbWVtc2V0KCZhdHRyLCAwLCBzaXplb2YoYXR0cikpOw0KPiA+ICAgICAgICAg
YXR0ci5wYXRobmFtZSA9IHB0cl90b191NjQoKHZvaWQgKilwYXRobmFtZSk7DQo+ID4gKyAgICAg
ICBhdHRyLmZpbGVfZmxhZ3MgPSBPUFRTX0dFVChvcHRzLCBmaWxlX2ZsYWdzLCAwKTsNCj4gPg0K
PiA+ICAgICAgICAgZmQgPSBzeXNfYnBmX2ZkKEJQRl9PQkpfR0VULCAmYXR0ciwgc2l6ZW9mKGF0
dHIpKTsNCj4gPiAgICAgICAgIHJldHVybiBsaWJicGZfZXJyX2Vycm5vKGZkKTsNCj4gPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9icGYuaCBiL3Rvb2xzL2xpYi9icGYvYnBmLmgNCj4gPiBp
bmRleCA4OGE3Y2M0YmQ3NmYuLmYzMWI0OTNiNWY5YSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9s
aWIvYnBmL2JwZi5oDQo+ID4gKysrIGIvdG9vbHMvbGliL2JwZi9icGYuaA0KPiA+IEBAIC0yNzAs
OCArMjcwLDE3IEBAIExJQkJQRl9BUEkgaW50IGJwZl9tYXBfdXBkYXRlX2JhdGNoKGludCBmZCwg
Y29uc3QNCj4gdm9pZCAqa2V5cywgY29uc3Qgdm9pZCAqdmFsdWVzDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX191MzIgKmNvdW50LA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBicGZfbWFwX2JhdGNoX29wdHMgKm9w
dHMpOw0KPiA+DQo+ID4gK3N0cnVjdCBicGZfb2JqX2dldF9vcHRzIHsNCj4gPiArICAgICAgIHNp
emVfdCBzejsgLyogc2l6ZSBvZiB0aGlzIHN0cnVjdCBmb3IgZm9yd2FyZC9iYWNrd2FyZCBjb21w
YXRpYmlsaXR5ICovDQo+ID4gKw0KPiA+ICsgICAgICAgX191MzIgZmlsZV9mbGFnczsNCj4gDQo+
IHBsZWFzZSBhZGQgc2l6ZV90IDowOyB0byBhdm9pZCBub24temVyby1pbml0aWFsaXplZCBwYWRk
aW5nICAod2UgZG8gaXQNCj4gaW4gYSBsb3Qgb2Ygb3RoZXIgb3B0cyBzdHJ1Y3RzKQ0KPiANCj4g
DQo+ID4gK307DQo+ID4gKyNkZWZpbmUgYnBmX29ial9nZXRfb3B0c19fbGFzdF9maWVsZCBmaWxl
X2ZsYWdzDQo+ID4gKw0KPiA+ICBMSUJCUEZfQVBJIGludCBicGZfb2JqX3BpbihpbnQgZmQsIGNv
bnN0IGNoYXIgKnBhdGhuYW1lKTsNCj4gPiAgTElCQlBGX0FQSSBpbnQgYnBmX29ial9nZXQoY29u
c3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ICtMSUJCUEZfQVBJIGludCBicGZfb2JqX2dldF9vcHRz
KGNvbnN0IGNoYXIgKnBhdGhuYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3Qgc3RydWN0IGJwZl9vYmpfZ2V0X29wdHMgKm9wdHMpOw0KPiA+DQo+ID4gIHN0cnVj
dCBicGZfcHJvZ19hdHRhY2hfb3B0cyB7DQo+ID4gICAgICAgICBzaXplX3Qgc3o7IC8qIHNpemUg
b2YgdGhpcyBzdHJ1Y3QgZm9yIGZvcndhcmQvYmFja3dhcmQgY29tcGF0aWJpbGl0eSAqLw0KPiA+
IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5tYXAgYi90b29scy9saWIvYnBmL2xp
YmJwZi5tYXANCj4gPiBpbmRleCAwNjI1YWRiOWU4ODguLjExOWU2ZTFlYTdmMSAxMDA2NDQNCj4g
PiAtLS0gYS90b29scy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiArKysgYi90b29scy9saWIvYnBm
L2xpYmJwZi5tYXANCj4gPiBAQCAtMzU1LDYgKzM1NSw3IEBAIExJQkJQRl8wLjguMCB7DQo+ID4N
Cj4gPiAgTElCQlBGXzEuMC4wIHsNCj4gPiAgICAgICAgIGdsb2JhbDoNCj4gPiArICAgICAgICAg
ICAgICAgYnBmX29ial9nZXRfb3B0czsNCj4gPiAgICAgICAgICAgICAgICAgYnBmX3Byb2dfcXVl
cnlfb3B0czsNCj4gPiAgICAgICAgICAgICAgICAgYnBmX3Byb2dyYW1fX2F0dGFjaF9rc3lzY2Fs
bDsNCj4gPiAgICAgICAgICAgICAgICAgYnRmX19hZGRfZW51bTY0Ow0KPiA+IC0tDQo+ID4gMi4z
Ny4wLjE3MC5nNDQ0ZDFlYWJkMC1nb29nDQo+ID4NCg==
