Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922C9587FA6
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHBQCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiHBQBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 12:01:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE12BC25
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 09:01:11 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ly05y65Pxz6GD4x;
        Tue,  2 Aug 2022 23:58:46 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:01:09 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 2 Aug 2022 18:01:09 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Topic: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Index: AQHYoZEjMBI1olYJVEOQ/pvQfthTZq2TaAQAgAAI9nD//+cNAIAABMaAgAeUDICAAHkaoIAANAAAgAAm2MA=
Date:   Tue, 2 Aug 2022 16:01:09 +0000
Message-ID: <b6250985924a4741845b099c7db0ca27@huawei.com>
References: <20220727081559.24571-1-memxor@gmail.com>
 <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com>
 <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
 <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
 <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com>
 <99f39e29a9ca416cb005ba690c7d7e51@huawei.com>
 <CAADnVQLgCmyJ1RpjuDe7-6NA_wu20NkGsLjD9B8WzShiXyiV5w@mail.gmail.com>
In-Reply-To: <CAADnVQLgCmyJ1RpjuDe7-6NA_wu20NkGsLjD9B8WzShiXyiV5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.203.54]
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
aWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMiwgMjAyMiA1OjA2IFBNDQo+IE9uIFR1
ZSwgQXVnIDIsIDIwMjIgYXQgMzowNyBBTSBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1
YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
W21haWx0bzphbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tXQ0KPiA+ID4gU2VudDogVHVlc2Rh
eSwgQXVndXN0IDIsIDIwMjIgNjo0NiBBTQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwgSnVsIDI4LCAy
MDIyIGF0IDI6MDIgQU0gS3VtYXIgS2FydGlrZXlhIER3aXZlZGkNCj4gPiA+IDxtZW14b3JAZ21h
aWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gVGh1LCAyOCBKdWwgMjAyMiBhdCAx
MDo0NSwgS3VtYXIgS2FydGlrZXlhIER3aXZlZGkNCj4gPG1lbXhvckBnbWFpbC5jb20+DQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFRodSwgMjggSnVsIDIwMjIgYXQgMTA6
MTgsIFJvYmVydG8gU2Fzc3UNCj4gPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gPiA+IHdy
b3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gRnJvbTogUm9iZXJ0byBTYXNzdSBbbWFp
bHRvOnJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbV0NCj4gPiA+ID4gPiA+ID4gU2VudDogVGh1cnNk
YXksIEp1bHkgMjgsIDIwMjIgOTo0NiBBTQ0KPiA+ID4gPiA+ID4gPiA+IEZyb206IEt1bWFyIEth
cnRpa2V5YSBEd2l2ZWRpIFttYWlsdG86bWVteG9yQGdtYWlsLmNvbV0NCj4gPiA+ID4gPiA+ID4g
PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjcsIDIwMjIgMTA6MTYgQU0NCj4gPiA+ID4gPiA+ID4g
PiBTaW1pbGFyIHRvIGhvdyB3ZSBkZXRlY3QgbWVtLCBzaXplIHBhaXJzIGluIGtmdW5jLCB0ZWFj
aCB2ZXJpZmllciB0bw0KPiA+ID4gPiA+ID4gPiA+IHRyZWF0IF9fcmVmIHN1ZmZpeCBvbiBhcmd1
bWVudCBuYW1lIHRvIGltcGx5IHRoYXQgaXQgbXVzdCBiZSBhDQo+IHRydXN0ZWQNCj4gPiA+ID4g
PiA+ID4gPiBhcmcgd2hlbiBwYXNzZWQgdG8ga2Z1bmMsIHNpbWlsYXIgdG8gdGhlIGVmZmVjdCBv
Zg0KPiBLRl9UUlVTVEVEX0FSR1MNCj4gPiA+IGZsYWcNCj4gPiA+ID4gPiA+ID4gPiBidXQgbGlt
aXRlZCB0byB0aGUgc3BlY2lmaWMgcGFyYW1ldGVyLiBUaGlzIGlzIHJlcXVpcmVkIHRvIGVuc3Vy
ZSB0aGF0DQo+ID4gPiA+ID4gPiA+ID4ga2Z1bmMgdGhhdCBvcGVyYXRlIG9uIHNvbWUgb2JqZWN0
IG9ubHkgd29yayBvbiBhY3F1aXJlZCBwb2ludGVycw0KPiBhbmQNCj4gPiA+IG5vdA0KPiA+ID4g
PiA+ID4gPiA+IG5vcm1hbCBQVFJfVE9fQlRGX0lEIHdpdGggc2FtZSB0eXBlIHdoaWNoIGNhbiBi
ZSBvYnRhaW5lZCBieQ0KPiA+ID4gcG9pbnRlcg0KPiA+ID4gPiA+ID4gPiA+IHdhbGtpbmcuIFJl
bGVhc2UgZnVuY3Rpb25zIG5lZWQgbm90IHNwZWNpZnkgc3VjaCBzdWZmaXggb24gcmVsZWFzZQ0K
PiA+ID4gPiA+ID4gPiA+IGFyZ3VtZW50cyBhcyB0aGV5IGFyZSBhbHJlYWR5IGV4cGVjdGVkIHRv
IHJlY2VpdmUgb25lIHJlZmVyZW5jZWQNCj4gPiA+ID4gPiA+ID4gPiBhcmd1bWVudC4NCj4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhhbmtzLCBLdW1hci4gSSB3aWxsIHRyeSBpdC4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBVaG0uIEkgcmVhbGl6ZWQgdGhhdCBJIHdhcyBhbHJlYWR5
IHVzaW5nIGFub3RoZXIgc3VmZml4LA0KPiA+ID4gPiA+ID4gX19tYXliZV9udWxsLCB0byBpbmRp
Y2F0ZSB0aGF0IGEgY2FsbGVyIGNhbiBwYXNzIE5VTEwgYXMNCj4gPiA+ID4gPiA+IGFyZ3VtZW50
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFdvdWxkbid0IHByb2JhYmx5IHdvcmsgd2VsbCB3
aXRoIHR3byBzdWZmaXhlcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVu
IHlvdSBjYW4gbWF5YmUgZXh0ZW5kIGl0IHRvIHBhcnNlIHR3byBzdWZmaXhlcyBhdCBtb3N0IChm
b3Igbm93DQo+ID4gPiBhdGxlYXN0KT8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGF2ZSB5b3Ug
Y29uc2lkZXJlZCB0byBleHRlbmQgQlRGX0lEX0ZMQUdTIHRvIHRha2UgZml2ZQ0KPiA+ID4gPiA+
ID4gZXh0cmEgYXJndW1lbnRzLCB0byBzZXQgZmxhZ3MgZm9yIGVhY2gga2Z1bmMgcGFyYW1ldGVy
Pw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgZGlkbid0IHVuZGVyc3RhbmQg
dGhpcy4gRmxhZ3MgcGFyYW1ldGVyIGlzIGFuIE9SIG9mIHRoZSBmbGFncyB5b3UNCj4gPiA+ID4g
PiBzZXQsIHdoeSB3b3VsZCB3ZSB3YW50IHRvIGV4dGVuZCBpdCB0byB0YWtlIDUgYXJncz8NCj4g
PiA+ID4gPiBZb3UgY2FuIGp1c3Qgb3IgZjEgfCBmMiB8IGYzIHwgZjQgfCBmNSwgYXMgbWFueSBh
cyB5b3Ugd2FudC4NCj4gPiA+ID4NCj4gPiA+ID4gT2gsIHNvIHlvdSBtZWFuIGhhdmluZyA1IG1v
cmUgYXJncyB0byBpbmRpY2F0ZSBmbGFncyBvbiBlYWNoDQo+ID4gPiA+IHBhcmFtZXRlcj8gSXQg
aXMgcG9zc2libGUsIGJ1dCBJIHRoaW5rIHRoZSBzY2hlbWUgZm9yIG5vdyB3b3JrcyBvay4gSWYN
Cj4gPiA+ID4geW91IGV4dGVuZCBpdCB0byBwYXJzZSB0d28gc3VmZml4ZXMsIGl0IHNob3VsZCBi
ZSBmaW5lLiBZZXMsIHRoZQ0KPiA+ID4gPiB2YXJpYWJsZSBuYW1lIHdvdWxkIGJlIHVnbHksIGJ1
dCB5b3UgY2FuIGp1c3QgbWFrZSBhIGNvcHkgaW50byBhDQo+ID4gPiA+IHByb3Blcmx5IG5hbWVk
IG9uZS4gVGhpcyBpcyB0aGUgYmVzdCB3ZSBjYW4gZG8gd2l0aG91dCBzd2l0Y2hpbmcgdG8NCj4g
PiA+ID4gQlRGIHRhZ3MuIFdlIGNhbiByZXZpc2l0IHRoaXMgd2hlbiB3ZSBzdGFydCBoYXZpbmcg
NCBvciA1IHRhZ3Mgb24gYQ0KPiA+ID4gPiBzaW5nbGUgcGFyYW1ldGVyLg0KPiA+ID4gPg0KPiA+
ID4gPiBUbyBtYWtlIGl0IGEgYml0IGxlc3MgdmVyYm9zZSB5b3UgY291bGQgcHJvYmFibHkgY2Fs
bCBtYXliZV9udWxsIGp1c3QgbnVsbD8NCj4gPiA+DQo+ID4gPiBUaGFuayB5b3UgZm9yIHBvc3Rp
bmcgdGhlIHBhdGNoLg0KPiA+ID4gSXQgc3RpbGwgZmVlbHMgdGhhdCB0aGlzIGV4dHJhIGZsZXhp
YmlsaXR5IGdldHMgY29udm9sdXRlZC4NCj4gPiA+IEknbSBub3Qgc3VyZSBSb2JlcnRvJ3Mga2Z1
bmMgYWN0dWFsbHkgbmVlZHMgX19yZWYuDQo+ID4gPiBBbGwgcG9pbnRlcnMgc2hvdWxkIGJlIHBv
aW50ZXJzLiBIYWNraW5nIC0xIGFuZCAtMiBpbnRvIGEgcG9pbnRlcg0KPiA+ID4gaXMgc29tZXRo
aW5nIHRoYXQga2V5IGluZnJhIGRpZCwgYnV0IGl0IGRvZXNuJ3QgbWVhbiB0aGF0DQo+ID4gPiB3
ZSBoYXZlIHRvIGNhcnJ5IG92ZXIgaXQgaW50byBicGYga2Z1bmMuDQo+ID4NCj4gPiBUaGVyZSBp
cyBhIHNlcGFyYXRlIHBhcmFtZXRlciBmb3IgdGhlIGtleXJpbmcgSURzIHRoYXQgb25seQ0KPiA+
IHZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSB1bmRlcnN0YW5kcy4gVHlwZSBjYXN0aW5nIGlzIGRv
bmUNCj4gPiBpbnRlcm5hbGx5IGluIHRoZSBicGZfdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZSgpIGtm
dW5jLg0KPiA+DQo+ID4gVGhlIG90aGVyIGlzIGFsd2F5cyBhIHZhbGlkIHN0cnVjdCBrZXkgcG9p
bnRlciBvciBOVUxMLCBjb21pbmcNCj4gPiBmcm9tIGJwZl9sb29rdXBfdXNlcl9rZXkoKSAoYWNx
dWlyZSBmdW5jdGlvbikuIEkgZXh0ZW5kZWQNCj4gPiBLdW1hcidzIHBhdGNoIGZ1cnRoZXIgdG8g
YW5ub3RhdGUgdGhlIHN0cnVjdCBrZXkgcGFyYW1ldGVyDQo+ID4gd2l0aCB0aGUgX3JlZl9udWxs
IHN1ZmZpeCwgdG8gYWNjZXB0IGEgcmVmZXJlbmNlZCBwb2ludGVyIG9yIE5VTEwsDQo+ID4gaW5z
dGVhZCBvZiBqdXN0IHJlZmVyZW5jZWQuDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0J3MgYSBnb29k
IHRyYWRlb2ZmIGNvbXBsZXhpdHkgd2lzZS4NCj4gIT1udWxsIGNoZWNrIGNhbiBiZSBkb25lIGlu
IHJ1bnRpbWUgYnkgdGhlIGhlbHBlci4NCg0KTm90IHN1cmUgSSBmb2xsb3cuIGJwZl9sb29rdXBf
dXNlcl9rZXkoKSBtaWdodCBub3QgZmluZA0KdGhlIGtleSB5b3UgYXNrZWQgZm9yLCBzbyBpdCB3
aWxsIHJldHVybiBOVUxMLg0KDQpEaWQgeW91IG1lYW4gdGhhdCBJIHNob3VsZCBub3Qgc2V0IEtG
X1JFVF9OVUxMIGZvcg0KYnBmX2xvb2t1cF91c2VyX2tleSgpPw0KDQpUaGF0IGFueXdheSB3b27i
gJl0IGhlbHAgaWYgeW91IHVzZSB0aGUgc3lzdGVtIGtleXJpbmcsDQp0aGUgYWx0ZXJuYXRpdmUg
cGFyYW1ldGVyLiBUaGUgdXNlciBrZXlyaW5nIGlzIHRoZSBvdGhlcg0Kb25lLCByZXR1cm5lZCBi
eSBicGZfbG9va3VwX3VzZXJfa2V5KCkuDQoNCldoZW4geW91IHNwZWNpZnkgYSBzeXN0ZW0ga2V5
cmluZywgdGhlIHVzZXIga2V5cmluZyBzaG91bGQNCmJlIE5VTEwsIHRvIGluZGljYXRlIHRoYXQg
dGhlIHBhcmFtZXRlciBzaG91bGQgbm90IGJlDQp1c2VkLiBUaGlzIHdhcyBzdWdnZXN0ZWQgYnkg
Ym90aCBKb2huIGFuZCBEYW5pZWwuDQoNClNvLCBpdCBzZWVtcyB1bmF2b2lkYWJsZSB0byBhbm5v
dGF0ZSB0aGUga2V5cmluZyBwYXJhbWV0ZXINCndpdGggX19yZWZfbnVsbCwgb3IgYXQgbGVhc3Qg
d2l0aCBfX251bGwuIF9fcmVmX251bGwgd291bGQgYmUNCmJldHRlciwgdG8gcmVxdWlyZSBhIHJl
ZmVyZW5jZWQgcGFyYW1ldGVyLg0KDQo+IFRoZSB0eXBlIGNhc3QgaXMgYSBzaWduIG9mIHNvbWV0
aGluZyBmaXNoeSBpbiB0aGUgZGVzaWduLg0KDQpTaW5jZSB0aGlzIGlzIHdoYXQgdmVyaWZ5X3Br
Y3M3X3NpZ25hdHVyZSgpIGFjY2VwdHMsIEkgZ3Vlc3MNCml0IGlzIHRoZSBvbmx5IG9wdGlvbi4N
Cg0KUm9iZXJ0bw0K
