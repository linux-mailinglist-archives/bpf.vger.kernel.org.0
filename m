Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB2588EB8
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHCOfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiHCOfB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 10:35:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C51275FF
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 07:34:59 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LyZ5775WZz67nHV;
        Wed,  3 Aug 2022 22:30:03 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 16:34:56 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 3 Aug 2022 16:34:56 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Topic: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Index: AQHYoZEjMBI1olYJVEOQ/pvQfthTZq2TaAQAgAAI9nD//+cNAIAABMaAgAeUDICAAHkaoIAANAAAgAAm2MCAAYQw8A==
Date:   Wed, 3 Aug 2022 14:34:56 +0000
Message-ID: <b76cb0a465c34dd98b4eecad0d69fcf2@huawei.com>
References: <20220727081559.24571-1-memxor@gmail.com>
 <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com>
 <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
 <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
 <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com>
 <99f39e29a9ca416cb005ba690c7d7e51@huawei.com>
 <CAADnVQLgCmyJ1RpjuDe7-6NA_wu20NkGsLjD9B8WzShiXyiV5w@mail.gmail.com>
 <b6250985924a4741845b099c7db0ca27@huawei.com>
In-Reply-To: <b6250985924a4741845b099c7db0ca27@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.204.206]
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

PiBGcm9tOiBSb2JlcnRvIFNhc3N1IFttYWlsdG86cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tXQ0K
PiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMiwgMjAyMiA2OjAxIFBNDQo+ID4gRnJvbTogQWxleGVp
IFN0YXJvdm9pdG92IFttYWlsdG86YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbV0NCj4gPiBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMiwgMjAyMiA1OjA2IFBNDQo+ID4gT24gVHVlLCBBdWcgMiwg
MjAyMiBhdCAzOjA3IEFNIFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4N
Cj4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEZyb206IEFsZXhlaSBTdGFyb3ZvaXRvdiBbbWFp
bHRvOmFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb21dDQo+ID4gPiA+IFNlbnQ6IFR1ZXNkYXks
IEF1Z3VzdCAyLCAyMDIyIDY6NDYgQU0NCj4gPiA+ID4NCj4gPiA+ID4gT24gVGh1LCBKdWwgMjgs
IDIwMjIgYXQgMjowMiBBTSBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaQ0KPiA+ID4gPiA8bWVteG9y
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBUaHUsIDI4IEp1bCAy
MDIyIGF0IDEwOjQ1LCBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaQ0KPiA+IDxtZW14b3JAZ21haWwu
Y29tPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiBUaHUsIDI4
IEp1bCAyMDIyIGF0IDEwOjE4LCBSb2JlcnRvIFNhc3N1DQo+ID4gPHJvYmVydG8uc2Fzc3VAaHVh
d2VpLmNvbT4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4g
RnJvbTogUm9iZXJ0byBTYXNzdSBbbWFpbHRvOnJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbV0NCj4g
PiA+ID4gPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgSnVseSAyOCwgMjAyMiA5OjQ2IEFNDQo+ID4g
PiA+ID4gPiA+ID4gPiBGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSBbbWFpbHRvOm1lbXhv
ckBnbWFpbC5jb21dDQo+ID4gPiA+ID4gPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjcs
IDIwMjIgMTA6MTYgQU0NCj4gPiA+ID4gPiA+ID4gPiA+IFNpbWlsYXIgdG8gaG93IHdlIGRldGVj
dCBtZW0sIHNpemUgcGFpcnMgaW4ga2Z1bmMsIHRlYWNoIHZlcmlmaWVyDQo+IHRvDQo+ID4gPiA+
ID4gPiA+ID4gPiB0cmVhdCBfX3JlZiBzdWZmaXggb24gYXJndW1lbnQgbmFtZSB0byBpbXBseSB0
aGF0IGl0IG11c3QgYmUgYQ0KPiA+IHRydXN0ZWQNCj4gPiA+ID4gPiA+ID4gPiA+IGFyZyB3aGVu
IHBhc3NlZCB0byBrZnVuYywgc2ltaWxhciB0byB0aGUgZWZmZWN0IG9mDQo+ID4gS0ZfVFJVU1RF
RF9BUkdTDQo+ID4gPiA+IGZsYWcNCj4gPiA+ID4gPiA+ID4gPiA+IGJ1dCBsaW1pdGVkIHRvIHRo
ZSBzcGVjaWZpYyBwYXJhbWV0ZXIuIFRoaXMgaXMgcmVxdWlyZWQgdG8gZW5zdXJlDQo+IHRoYXQN
Cj4gPiA+ID4gPiA+ID4gPiA+IGtmdW5jIHRoYXQgb3BlcmF0ZSBvbiBzb21lIG9iamVjdCBvbmx5
IHdvcmsgb24gYWNxdWlyZWQgcG9pbnRlcnMNCj4gPiBhbmQNCj4gPiA+ID4gbm90DQo+ID4gPiA+
ID4gPiA+ID4gPiBub3JtYWwgUFRSX1RPX0JURl9JRCB3aXRoIHNhbWUgdHlwZSB3aGljaCBjYW4g
YmUgb2J0YWluZWQgYnkNCj4gPiA+ID4gcG9pbnRlcg0KPiA+ID4gPiA+ID4gPiA+ID4gd2Fsa2lu
Zy4gUmVsZWFzZSBmdW5jdGlvbnMgbmVlZCBub3Qgc3BlY2lmeSBzdWNoIHN1ZmZpeCBvbiByZWxl
YXNlDQo+ID4gPiA+ID4gPiA+ID4gPiBhcmd1bWVudHMgYXMgdGhleSBhcmUgYWxyZWFkeSBleHBl
Y3RlZCB0byByZWNlaXZlIG9uZSByZWZlcmVuY2VkDQo+ID4gPiA+ID4gPiA+ID4gPiBhcmd1bWVu
dC4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcywgS3VtYXIuIEkgd2ls
bCB0cnkgaXQuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFVobS4gSSByZWFsaXplZCB0
aGF0IEkgd2FzIGFscmVhZHkgdXNpbmcgYW5vdGhlciBzdWZmaXgsDQo+ID4gPiA+ID4gPiA+IF9f
bWF5YmVfbnVsbCwgdG8gaW5kaWNhdGUgdGhhdCBhIGNhbGxlciBjYW4gcGFzcyBOVUxMIGFzDQo+
ID4gPiA+ID4gPiA+IGFyZ3VtZW50Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXb3Vs
ZG4ndCBwcm9iYWJseSB3b3JrIHdlbGwgd2l0aCB0d28gc3VmZml4ZXMuDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhlbiB5b3UgY2FuIG1heWJlIGV4dGVuZCBpdCB0
byBwYXJzZSB0d28gc3VmZml4ZXMgYXQgbW9zdCAoZm9yIG5vdw0KPiA+ID4gPiBhdGxlYXN0KT8N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhhdmUgeW91IGNvbnNpZGVyZWQgdG8gZXh0ZW5k
IEJURl9JRF9GTEFHUyB0byB0YWtlIGZpdmUNCj4gPiA+ID4gPiA+ID4gZXh0cmEgYXJndW1lbnRz
LCB0byBzZXQgZmxhZ3MgZm9yIGVhY2gga2Z1bmMgcGFyYW1ldGVyPw0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgZGlkbid0IHVuZGVyc3RhbmQgdGhpcy4gRmxhZ3Mg
cGFyYW1ldGVyIGlzIGFuIE9SIG9mIHRoZSBmbGFncyB5b3UNCj4gPiA+ID4gPiA+IHNldCwgd2h5
IHdvdWxkIHdlIHdhbnQgdG8gZXh0ZW5kIGl0IHRvIHRha2UgNSBhcmdzPw0KPiA+ID4gPiA+ID4g
WW91IGNhbiBqdXN0IG9yIGYxIHwgZjIgfCBmMyB8IGY0IHwgZjUsIGFzIG1hbnkgYXMgeW91IHdh
bnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPaCwgc28geW91IG1lYW4gaGF2aW5nIDUgbW9yZSBh
cmdzIHRvIGluZGljYXRlIGZsYWdzIG9uIGVhY2gNCj4gPiA+ID4gPiBwYXJhbWV0ZXI/IEl0IGlz
IHBvc3NpYmxlLCBidXQgSSB0aGluayB0aGUgc2NoZW1lIGZvciBub3cgd29ya3Mgb2suIElmDQo+
ID4gPiA+ID4geW91IGV4dGVuZCBpdCB0byBwYXJzZSB0d28gc3VmZml4ZXMsIGl0IHNob3VsZCBi
ZSBmaW5lLiBZZXMsIHRoZQ0KPiA+ID4gPiA+IHZhcmlhYmxlIG5hbWUgd291bGQgYmUgdWdseSwg
YnV0IHlvdSBjYW4ganVzdCBtYWtlIGEgY29weSBpbnRvIGENCj4gPiA+ID4gPiBwcm9wZXJseSBu
YW1lZCBvbmUuIFRoaXMgaXMgdGhlIGJlc3Qgd2UgY2FuIGRvIHdpdGhvdXQgc3dpdGNoaW5nIHRv
DQo+ID4gPiA+ID4gQlRGIHRhZ3MuIFdlIGNhbiByZXZpc2l0IHRoaXMgd2hlbiB3ZSBzdGFydCBo
YXZpbmcgNCBvciA1IHRhZ3Mgb24gYQ0KPiA+ID4gPiA+IHNpbmdsZSBwYXJhbWV0ZXIuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBUbyBtYWtlIGl0IGEgYml0IGxlc3MgdmVyYm9zZSB5b3UgY291bGQg
cHJvYmFibHkgY2FsbCBtYXliZV9udWxsIGp1c3QgbnVsbD8NCj4gPiA+ID4NCj4gPiA+ID4gVGhh
bmsgeW91IGZvciBwb3N0aW5nIHRoZSBwYXRjaC4NCj4gPiA+ID4gSXQgc3RpbGwgZmVlbHMgdGhh
dCB0aGlzIGV4dHJhIGZsZXhpYmlsaXR5IGdldHMgY29udm9sdXRlZC4NCj4gPiA+ID4gSSdtIG5v
dCBzdXJlIFJvYmVydG8ncyBrZnVuYyBhY3R1YWxseSBuZWVkcyBfX3JlZi4NCj4gPiA+ID4gQWxs
IHBvaW50ZXJzIHNob3VsZCBiZSBwb2ludGVycy4gSGFja2luZyAtMSBhbmQgLTIgaW50byBhIHBv
aW50ZXINCj4gPiA+ID4gaXMgc29tZXRoaW5nIHRoYXQga2V5IGluZnJhIGRpZCwgYnV0IGl0IGRv
ZXNuJ3QgbWVhbiB0aGF0DQo+ID4gPiA+IHdlIGhhdmUgdG8gY2Fycnkgb3ZlciBpdCBpbnRvIGJw
ZiBrZnVuYy4NCj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBhIHNlcGFyYXRlIHBhcmFtZXRlciBmb3Ig
dGhlIGtleXJpbmcgSURzIHRoYXQgb25seQ0KPiA+ID4gdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZSgp
IHVuZGVyc3RhbmRzLiBUeXBlIGNhc3RpbmcgaXMgZG9uZQ0KPiA+ID4gaW50ZXJuYWxseSBpbiB0
aGUgYnBmX3ZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSBrZnVuYy4NCj4gPiA+DQo+ID4gPiBUaGUg
b3RoZXIgaXMgYWx3YXlzIGEgdmFsaWQgc3RydWN0IGtleSBwb2ludGVyIG9yIE5VTEwsIGNvbWlu
Zw0KPiA+ID4gZnJvbSBicGZfbG9va3VwX3VzZXJfa2V5KCkgKGFjcXVpcmUgZnVuY3Rpb24pLiBJ
IGV4dGVuZGVkDQo+ID4gPiBLdW1hcidzIHBhdGNoIGZ1cnRoZXIgdG8gYW5ub3RhdGUgdGhlIHN0
cnVjdCBrZXkgcGFyYW1ldGVyDQo+ID4gPiB3aXRoIHRoZSBfcmVmX251bGwgc3VmZml4LCB0byBh
Y2NlcHQgYSByZWZlcmVuY2VkIHBvaW50ZXIgb3IgTlVMTCwNCj4gPiA+IGluc3RlYWQgb2YganVz
dCByZWZlcmVuY2VkLg0KPiA+DQo+ID4gSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCB0cmFkZW9m
ZiBjb21wbGV4aXR5IHdpc2UuDQo+ID4gIT1udWxsIGNoZWNrIGNhbiBiZSBkb25lIGluIHJ1bnRp
bWUgYnkgdGhlIGhlbHBlci4NCj4gDQo+IE5vdCBzdXJlIEkgZm9sbG93LiBicGZfbG9va3VwX3Vz
ZXJfa2V5KCkgbWlnaHQgbm90IGZpbmQNCj4gdGhlIGtleSB5b3UgYXNrZWQgZm9yLCBzbyBpdCB3
aWxsIHJldHVybiBOVUxMLg0KPiANCj4gRGlkIHlvdSBtZWFuIHRoYXQgSSBzaG91bGQgbm90IHNl
dCBLRl9SRVRfTlVMTCBmb3INCj4gYnBmX2xvb2t1cF91c2VyX2tleSgpPw0KPiANCj4gVGhhdCBh
bnl3YXkgd29u4oCZdCBoZWxwIGlmIHlvdSB1c2UgdGhlIHN5c3RlbSBrZXlyaW5nLA0KPiB0aGUg
YWx0ZXJuYXRpdmUgcGFyYW1ldGVyLiBUaGUgdXNlciBrZXlyaW5nIGlzIHRoZSBvdGhlcg0KPiBv
bmUsIHJldHVybmVkIGJ5IGJwZl9sb29rdXBfdXNlcl9rZXkoKS4NCj4gDQo+IFdoZW4geW91IHNw
ZWNpZnkgYSBzeXN0ZW0ga2V5cmluZywgdGhlIHVzZXIga2V5cmluZyBzaG91bGQNCj4gYmUgTlVM
TCwgdG8gaW5kaWNhdGUgdGhhdCB0aGUgcGFyYW1ldGVyIHNob3VsZCBub3QgYmUNCj4gdXNlZC4g
VGhpcyB3YXMgc3VnZ2VzdGVkIGJ5IGJvdGggSm9obiBhbmQgRGFuaWVsLg0KPiANCj4gU28sIGl0
IHNlZW1zIHVuYXZvaWRhYmxlIHRvIGFubm90YXRlIHRoZSBrZXlyaW5nIHBhcmFtZXRlcg0KPiB3
aXRoIF9fcmVmX251bGwsIG9yIGF0IGxlYXN0IHdpdGggX19udWxsLiBfX3JlZl9udWxsIHdvdWxk
IGJlDQo+IGJldHRlciwgdG8gcmVxdWlyZSBhIHJlZmVyZW5jZWQgcGFyYW1ldGVyLg0KPiANCj4g
PiBUaGUgdHlwZSBjYXN0IGlzIGEgc2lnbiBvZiBzb21ldGhpbmcgZmlzaHkgaW4gdGhlIGRlc2ln
bi4NCj4gDQo+IFNpbmNlIHRoaXMgaXMgd2hhdCB2ZXJpZnlfcGtjczdfc2lnbmF0dXJlKCkgYWNj
ZXB0cywgSSBndWVzcw0KPiBpdCBpcyB0aGUgb25seSBvcHRpb24uDQoNCkkgYWRkZWQgdGhpcyB0
b3BpYyBmb3IgdGhlIGFnZW5kYSBvZiBCUEYgb2ZmaWNlIGhvdXJzIHRvbW9ycm93Lg0KDQpSb2Jl
cnRvDQo=
