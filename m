Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CC587A4C
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiHBKHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiHBKHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 06:07:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7732CE31
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 03:07:20 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LxrBp3FgZz67N6g;
        Tue,  2 Aug 2022 18:02:26 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 12:07:17 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Tue, 2 Aug 2022 12:07:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Topic: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
Thread-Index: AQHYoZEjMBI1olYJVEOQ/pvQfthTZq2TaAQAgAAI9nD//+cNAIAABMaAgAeUDICAAHkaoA==
Date:   Tue, 2 Aug 2022 10:07:17 +0000
Message-ID: <99f39e29a9ca416cb005ba690c7d7e51@huawei.com>
References: <20220727081559.24571-1-memxor@gmail.com>
 <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com>
 <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
 <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
 <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com>
In-Reply-To: <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.210.42]
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
aWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMiwgMjAyMiA2OjQ2IEFNDQo+IA0KPiBP
biBUaHUsIEp1bCAyOCwgMjAyMiBhdCAyOjAyIEFNIEt1bWFyIEthcnRpa2V5YSBEd2l2ZWRpDQo+
IDxtZW14b3JAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgMjggSnVsIDIwMjIg
YXQgMTA6NDUsIEt1bWFyIEthcnRpa2V5YSBEd2l2ZWRpIDxtZW14b3JAZ21haWwuY29tPg0KPiB3
cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDI4IEp1bCAyMDIyIGF0IDEwOjE4LCBSb2JlcnRv
IFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiA+IEZyb206IFJvYmVydG8gU2Fzc3UgW21haWx0bzpyb2JlcnRvLnNhc3N1QGh1YXdlaS5j
b21dDQo+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMjgsIDIwMjIgOTo0NiBBTQ0KPiA+
ID4gPiA+ID4gRnJvbTogS3VtYXIgS2FydGlrZXlhIER3aXZlZGkgW21haWx0bzptZW14b3JAZ21h
aWwuY29tXQ0KPiA+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI3LCAyMDIyIDEwOjE2
IEFNDQo+ID4gPiA+ID4gPiBTaW1pbGFyIHRvIGhvdyB3ZSBkZXRlY3QgbWVtLCBzaXplIHBhaXJz
IGluIGtmdW5jLCB0ZWFjaCB2ZXJpZmllciB0bw0KPiA+ID4gPiA+ID4gdHJlYXQgX19yZWYgc3Vm
Zml4IG9uIGFyZ3VtZW50IG5hbWUgdG8gaW1wbHkgdGhhdCBpdCBtdXN0IGJlIGEgdHJ1c3RlZA0K
PiA+ID4gPiA+ID4gYXJnIHdoZW4gcGFzc2VkIHRvIGtmdW5jLCBzaW1pbGFyIHRvIHRoZSBlZmZl
Y3Qgb2YgS0ZfVFJVU1RFRF9BUkdTDQo+IGZsYWcNCj4gPiA+ID4gPiA+IGJ1dCBsaW1pdGVkIHRv
IHRoZSBzcGVjaWZpYyBwYXJhbWV0ZXIuIFRoaXMgaXMgcmVxdWlyZWQgdG8gZW5zdXJlIHRoYXQN
Cj4gPiA+ID4gPiA+IGtmdW5jIHRoYXQgb3BlcmF0ZSBvbiBzb21lIG9iamVjdCBvbmx5IHdvcmsg
b24gYWNxdWlyZWQgcG9pbnRlcnMgYW5kDQo+IG5vdA0KPiA+ID4gPiA+ID4gbm9ybWFsIFBUUl9U
T19CVEZfSUQgd2l0aCBzYW1lIHR5cGUgd2hpY2ggY2FuIGJlIG9idGFpbmVkIGJ5DQo+IHBvaW50
ZXINCj4gPiA+ID4gPiA+IHdhbGtpbmcuIFJlbGVhc2UgZnVuY3Rpb25zIG5lZWQgbm90IHNwZWNp
Znkgc3VjaCBzdWZmaXggb24gcmVsZWFzZQ0KPiA+ID4gPiA+ID4gYXJndW1lbnRzIGFzIHRoZXkg
YXJlIGFscmVhZHkgZXhwZWN0ZWQgdG8gcmVjZWl2ZSBvbmUgcmVmZXJlbmNlZA0KPiA+ID4gPiA+
ID4gYXJndW1lbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MsIEt1bWFyLiBJIHdpbGwg
dHJ5IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBVaG0uIEkgcmVhbGl6ZWQgdGhhdCBJIHdhcyBhbHJl
YWR5IHVzaW5nIGFub3RoZXIgc3VmZml4LA0KPiA+ID4gPiBfX21heWJlX251bGwsIHRvIGluZGlj
YXRlIHRoYXQgYSBjYWxsZXIgY2FuIHBhc3MgTlVMTCBhcw0KPiA+ID4gPiBhcmd1bWVudC4NCj4g
PiA+ID4NCj4gPiA+ID4gV291bGRuJ3QgcHJvYmFibHkgd29yayB3ZWxsIHdpdGggdHdvIHN1ZmZp
eGVzLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFRoZW4geW91IGNhbiBtYXliZSBleHRlbmQgaXQg
dG8gcGFyc2UgdHdvIHN1ZmZpeGVzIGF0IG1vc3QgKGZvciBub3cNCj4gYXRsZWFzdCk/DQo+ID4g
Pg0KPiA+ID4gPiBIYXZlIHlvdSBjb25zaWRlcmVkIHRvIGV4dGVuZCBCVEZfSURfRkxBR1MgdG8g
dGFrZSBmaXZlDQo+ID4gPiA+IGV4dHJhIGFyZ3VtZW50cywgdG8gc2V0IGZsYWdzIGZvciBlYWNo
IGtmdW5jIHBhcmFtZXRlcj8NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJIGRpZG4ndCB1bmRlcnN0
YW5kIHRoaXMuIEZsYWdzIHBhcmFtZXRlciBpcyBhbiBPUiBvZiB0aGUgZmxhZ3MgeW91DQo+ID4g
PiBzZXQsIHdoeSB3b3VsZCB3ZSB3YW50IHRvIGV4dGVuZCBpdCB0byB0YWtlIDUgYXJncz8NCj4g
PiA+IFlvdSBjYW4ganVzdCBvciBmMSB8IGYyIHwgZjMgfCBmNCB8IGY1LCBhcyBtYW55IGFzIHlv
dSB3YW50Lg0KPiA+DQo+ID4gT2gsIHNvIHlvdSBtZWFuIGhhdmluZyA1IG1vcmUgYXJncyB0byBp
bmRpY2F0ZSBmbGFncyBvbiBlYWNoDQo+ID4gcGFyYW1ldGVyPyBJdCBpcyBwb3NzaWJsZSwgYnV0
IEkgdGhpbmsgdGhlIHNjaGVtZSBmb3Igbm93IHdvcmtzIG9rLiBJZg0KPiA+IHlvdSBleHRlbmQg
aXQgdG8gcGFyc2UgdHdvIHN1ZmZpeGVzLCBpdCBzaG91bGQgYmUgZmluZS4gWWVzLCB0aGUNCj4g
PiB2YXJpYWJsZSBuYW1lIHdvdWxkIGJlIHVnbHksIGJ1dCB5b3UgY2FuIGp1c3QgbWFrZSBhIGNv
cHkgaW50byBhDQo+ID4gcHJvcGVybHkgbmFtZWQgb25lLiBUaGlzIGlzIHRoZSBiZXN0IHdlIGNh
biBkbyB3aXRob3V0IHN3aXRjaGluZyB0bw0KPiA+IEJURiB0YWdzLiBXZSBjYW4gcmV2aXNpdCB0
aGlzIHdoZW4gd2Ugc3RhcnQgaGF2aW5nIDQgb3IgNSB0YWdzIG9uIGENCj4gPiBzaW5nbGUgcGFy
YW1ldGVyLg0KPiA+DQo+ID4gVG8gbWFrZSBpdCBhIGJpdCBsZXNzIHZlcmJvc2UgeW91IGNvdWxk
IHByb2JhYmx5IGNhbGwgbWF5YmVfbnVsbCBqdXN0IG51bGw/DQo+IA0KPiBUaGFuayB5b3UgZm9y
IHBvc3RpbmcgdGhlIHBhdGNoLg0KPiBJdCBzdGlsbCBmZWVscyB0aGF0IHRoaXMgZXh0cmEgZmxl
eGliaWxpdHkgZ2V0cyBjb252b2x1dGVkLg0KPiBJJ20gbm90IHN1cmUgUm9iZXJ0bydzIGtmdW5j
IGFjdHVhbGx5IG5lZWRzIF9fcmVmLg0KPiBBbGwgcG9pbnRlcnMgc2hvdWxkIGJlIHBvaW50ZXJz
LiBIYWNraW5nIC0xIGFuZCAtMiBpbnRvIGEgcG9pbnRlcg0KPiBpcyBzb21ldGhpbmcgdGhhdCBr
ZXkgaW5mcmEgZGlkLCBidXQgaXQgZG9lc24ndCBtZWFuIHRoYXQNCj4gd2UgaGF2ZSB0byBjYXJy
eSBvdmVyIGl0IGludG8gYnBmIGtmdW5jLg0KDQpUaGVyZSBpcyBhIHNlcGFyYXRlIHBhcmFtZXRl
ciBmb3IgdGhlIGtleXJpbmcgSURzIHRoYXQgb25seQ0KdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZSgp
IHVuZGVyc3RhbmRzLiBUeXBlIGNhc3RpbmcgaXMgZG9uZQ0KaW50ZXJuYWxseSBpbiB0aGUgYnBm
X3ZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSBrZnVuYy4NCiANClRoZSBvdGhlciBpcyBhbHdheXMg
YSB2YWxpZCBzdHJ1Y3Qga2V5IHBvaW50ZXIgb3IgTlVMTCwgY29taW5nDQpmcm9tIGJwZl9sb29r
dXBfdXNlcl9rZXkoKSAoYWNxdWlyZSBmdW5jdGlvbikuIEkgZXh0ZW5kZWQNCkt1bWFyJ3MgcGF0
Y2ggZnVydGhlciB0byBhbm5vdGF0ZSB0aGUgc3RydWN0IGtleSBwYXJhbWV0ZXINCndpdGggdGhl
IF9yZWZfbnVsbCBzdWZmaXgsIHRvIGFjY2VwdCBhIHJlZmVyZW5jZWQgcG9pbnRlciBvciBOVUxM
LA0KaW5zdGVhZCBvZiBqdXN0IHJlZmVyZW5jZWQuDQoNClJvYmVydG8NCg==
