Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049C457C0B1
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 01:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiGTXMh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 19:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiGTXMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 19:12:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53B6249D;
        Wed, 20 Jul 2022 16:12:33 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LpBJN6kNmz682sK;
        Thu, 21 Jul 2022 07:10:44 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 01:12:31 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 21 Jul 2022 01:12:30 +0200
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
Thread-Index: AQHYm6d/RXaIdRF8qEmfFsB1DNrrP62GBpoAgADe8JCAAGROAIAAjdQg///iSICAACHbgP//4O0AgAAkrmD//+EIgAAER8xw
Date:   Wed, 20 Jul 2022 23:12:30 +0000
Message-ID: <bf326b7c927a475cae33b89416c1b082@huawei.com>
References: <20220719194028.4180569-1-jevburton.kernel@gmail.com>
 <CAKH8qBsm0QqE-7Pmhhz=tRYAfgpirbu6K1deQ6cQTU+GTykLNA@mail.gmail.com>
 <179cfb89be0e4f928a55d049fe62aa9e@huawei.com>
 <CAKH8qBt0yR+mtCjAp=8jQL4M6apWQk0wH7Zf4tPDCf3=m+gAKA@mail.gmail.com>
 <31473ddf364f4f16becfd5cd4b9cd7d2@huawei.com>
 <CAKH8qBsFg5gQ0bqpVtYhiQx=TqJG31c8kfsbCG4X57QGLOhXvw@mail.gmail.com>
 <0c284e09817e4e699aa448aa25af5d79@huawei.com>
 <CAKH8qBvwzVPY1yJM_FjdH5QptVkZz=j9Ph7pTPCbTLdY1orKJg@mail.gmail.com>
 <c9c203821a854e33970fd10e01632cb7@huawei.com>
 <CAKH8qBuazK5PwDYAG2bPGfyASAMQAd4_dpFjcW0KYz4ON+kj3g@mail.gmail.com>
In-Reply-To: <CAKH8qBuazK5PwDYAG2bPGfyASAMQAd4_dpFjcW0KYz4ON+kj3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.208.238]
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
dDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgMTowOSBBTQ0KPiBPbiBXZWQsIEp1bCAyMCwgMjAy
MiBhdCA0OjAyIFBNIFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IFN0YW5pc2xhdiBGb21pY2hldiBbbWFpbHRvOnNkZkBn
b29nbGUuY29tXQ0KPiA+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgMTI6NDggQU0N
Cj4gPiA+IE9uIFdlZCwgSnVsIDIwLCAyMDIyIGF0IDM6NDQgUE0gUm9iZXJ0byBTYXNzdQ0KPiA8
cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
ID4gRnJvbTogU3RhbmlzbGF2IEZvbWljaGV2IFttYWlsdG86c2RmQGdvb2dsZS5jb21dDQo+ID4g
PiA+ID4gU2VudDogVGh1cnNkYXksIEp1bHkgMjEsIDIwMjIgMTI6MzggQU0NCj4gPiA+ID4gPiBP
biBXZWQsIEp1bCAyMCwgMjAyMiBhdCAzOjMwIFBNIFJvYmVydG8gU2Fzc3UNCj4gPiA+IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBGcm9tOiBTdGFuaXNsYXYgRm9taWNoZXYgW21haWx0bzpzZGZAZ29vZ2xlLmNv
bV0NCj4gPiA+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIwLCAyMDIyIDU6NTcgUE0N
Cj4gPiA+ID4gPiA+ID4gT24gV2VkLCBKdWwgMjAsIDIwMjIgYXQgMTowMiBBTSBSb2JlcnRvIFNh
c3N1DQo+ID4gPiA+ID4gPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gPiA+ID4gPiA+ID4g
d3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IEZyb206IFN0YW5pc2xh
diBGb21pY2hldiBbbWFpbHRvOnNkZkBnb29nbGUuY29tXQ0KPiA+ID4gPiA+ID4gPiA+ID4gU2Vu
dDogVHVlc2RheSwgSnVseSAxOSwgMjAyMiAxMDo0MCBQTQ0KPiA+ID4gPiA+ID4gPiA+ID4gT24g
VHVlLCBKdWwgMTksIDIwMjIgYXQgMTI6NDAgUE0gSm9lIEJ1cnRvbg0KPiA+ID4gPiA+IDxqZXZi
dXJ0b24ua2VybmVsQGdtYWlsLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBKb2UgQnVydG9uIDxqZXZi
dXJ0b25AZ29vZ2xlLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gQWRkIGFuIGV4dGVuc2libGUgdmFyaWFudCBvZiBicGZfb2JqX2dldCgpIGNhcGFibGUgb2Yg
c2V0dGluZyB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gYGZpbGVfZmxhZ3NgIHBhcmFtZXRlci4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXJhbWV0ZXIg
aXMgbmVlZGVkIHRvIGVuYWJsZSB1bnByaXZpbGVnZWQgYWNjZXNzIHRvIEJQRg0KPiA+ID4gbWFw
cy4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gV2l0aG91dCBhIG1ldGhvZCBsaWtlIHRoaXMsIHVzZXJz
IG11c3QgbWFudWFsbHkgbWFrZSB0aGUNCj4gc3lzY2FsbC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9lIEJ1cnRvbiA8amV2YnVydG9u
QGdvb2dsZS5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gUmV2aWV3
ZWQtYnk6IFN0YW5pc2xhdiBGb21pY2hldiA8c2RmQGdvb2dsZS5jb20+DQo+ID4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gRm9yIGNvbnRleHQ6DQo+ID4gPiA+ID4gPiA+ID4gPiBX
ZSd2ZSBmb3VuZCB0aGlzIG91dCB3aGlsZSB3ZSB3ZXJlIHRyeWluZyB0byBhZGQgc3VwcG9ydCBm
b3INCj4gdW5wcml2DQo+ID4gPiA+ID4gPiA+ID4gPiBwcm9jZXNzZXMgdG8gb3BlbiBwaW5uZWQg
ci14IG1hcHMuDQo+ID4gPiA+ID4gPiA+ID4gPiBNYXliZSB0aGlzIGRlc2VydmVzIGEgdGVzdCBh
cyB3ZWxsPyBOb3Qgc3VyZS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEhpIFN0
YW5pc2xhdiwgSm9lDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBJIG5vdGljZWQg
bm93IHRoaXMgcGF0Y2guIEknbSBkb2luZyBhIGJyb2FkZXIgd29yayB0byBhZGQgb3B0cw0KPiA+
ID4gPiA+ID4gPiA+IHRvIGJwZl8qX2dldF9mZF9ieV9pZCgpLiBJIGFsc28gYWRqdXN0ZWQgcGVy
bWlzc2lvbnMgb2YgYnBmdG9vbA0KPiA+ID4gPiA+ID4gPiA+IGRlcGVuZGluZyBvbiB0aGUgb3Bl
cmF0aW9uIHR5cGUgKGUuZy4gc2hvdywgZHVtcDoNCj4gQlBGX0ZfUkRPTkxZKS4NCj4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFdpbGwgc2VuZCBpdCBzb29uIChJJ20gdHJ5aW5nIHRv
IHNvbHZlIGFuIGlzc3VlIHdpdGggdGhlIENJLCB3aGVyZQ0KPiA+ID4gPiA+ID4gPiA+IGxpYmJm
ZCBpcyBub3QgYXZhaWxhYmxlIGluIHRoZSBWTSBkb2luZyBhY3R1YWwgdGVzdHMpLg0KPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBJcyBzb21ldGhpbmcgbGlrZSB0aGlzIHBhdGNoIGluY2x1
ZGVkIGluIHlvdXIgc2VyaWVzIGFzIHdlbGw/IENhbiB5b3UNCj4gPiA+ID4gPiA+ID4gdXNlIHRo
aXMgbmV3IGludGVyZmFjZSBvciBkbyB5b3UgbmVlZCBzb21ldGhpbmcgZGlmZmVyZW50Pw0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEl0IGlzIHZlcnkgc2ltaWxhci4gRXhjZXB0IHRoYXQgSSBj
YWxsZWQgaXQgYnBmX2dldF9mZF9vcHRzLCBhcyBpdA0KPiA+ID4gPiA+ID4gaXMgc2hhcmVkIHdp
dGggdGhlIGJwZl8qX2dldF9mZF9ieV9pZCgpIGZ1bmN0aW9ucy4gVGhlIG1lbWJlcg0KPiA+ID4g
PiA+ID4gbmFtZSBpcyBqdXN0IGZsYWdzLCBwbHVzIGFuIGV4dHJhIHUzMiBmb3IgYWxpZ25tZW50
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2UgY2FuIGJpa2VzaGVkIHRoZSBuYW1pbmcsIGJ1dCB3
ZSd2ZSBiZWVuIHVzaW5nIGV4aXN0aW5nIGNvbnZlbnRpb25zDQo+ID4gPiA+ID4gd2hlcmUgb3B0
cyBmaWVsZHMgbWF0Y2ggc3lzY2FsbCBmaWVsZHMsIHRoYXQgc2VlbXMgbGlrZSBhIHNlbnNpYmxl
DQo+ID4gPiA+ID4gdGhpbmcgdG8gZG8/DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBvbmx5IHByb2Js
ZW0gaXMgdGhhdCBicGZfKl9nZXRfZmRfYnlfaWQoKSBmdW5jdGlvbnMgd291bGQNCj4gPiA+ID4g
c2V0IHRoZSBvcGVuX2ZsYWdzIG1lbWJlciBvZiBicGZfYXR0ci4NCj4gPiA+ID4NCj4gPiA+ID4g
RmxhZ3Mgd291bGQgYmUgZ29vZCBmb3IgYm90aCwgZXZlbiBpZiBub3QgZXhhY3QuIEJlbGlldmUg
bWUsDQo+ID4gPiA+IGR1cGxpY2F0aW5nIHRoZSBvcHRzIHdvdWxkIGp1c3QgY3JlYXRlIG1vcmUg
Y29uZnVzaW9uLg0KPiA+ID4NCj4gPiA+IFdhaXQsIHRoYXQncyBjb21wbGV0ZWx5IGRpZmZlcmVu
dCwgcmlnaHQ/IFdlIGFyZSB0YWxraW5nIGhlcmUgYWJvdXQNCj4gPiA+IEJQRl9PQkpfR0VUICh3
aGljaCBoYXMgcmVsYXRlZCBCUEZfT0JKX1BJTikuDQo+ID4gPiBZb3VyIEdFVF9YWFhfQllfSUQg
YXJlIGRpZmZlcmVudCBzbyB5b3UnbGwgc3RpbGwgaGF2ZSB0byBoYXZlIGFub3RoZXINCj4gPiA+
IHdyYXBwZXIgd2l0aCBvcHRzPw0KPiA+DQo+ID4gWWVzLCB0aGV5IGhhdmUgZGlmZmVyZW50IHdy
YXBwZXJzLCBqdXN0IGFjY2VwdCB0aGUgc2FtZSBvcHRzIGFzDQo+ID4gb2JqX2dldCgpLiBGcm9t
IGJwZnRvb2wgc3ViY29tbWFuZHMgeW91IHdhbnQgdG8gc2V0IHRoZSBjb3JyZWN0DQo+ID4gcGVy
bWlzc2lvbiwgYW5kIHByb3BhZ2F0ZSBpdCB1bmlmb3JtbHkgdG8gYnBmXypfZ2V0X2ZkX2J5X2lk
KCkNCj4gPiBvciBvYmpfZ2V0KCkuIFNlZSBtYXBfcGFyc2VfZmRzKCkuDQo+IA0KPiBJIGRvbid0
IHRoaW5rIHRoZXkgYXJlIGFjY2VwdGluZyB0aGUgc2FtZSBvcHRzLg0KPiANCj4gRm9yIG91ciBj
YXNlLCB3ZSBjYXJlIGFib3V0Og0KPiANCj4gICAgICAgICBzdHJ1Y3QgeyAvKiBhbm9ueW1vdXMg
c3RydWN0IHVzZWQgYnkgQlBGX09CSl8qIGNvbW1hbmRzICovDQo+ICAgICAgICAgICAgICAgICBf
X2FsaWduZWRfdTY0ICAgcGF0aG5hbWU7DQo+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAgICAg
ICAgYnBmX2ZkOw0KPiAgICAgICAgICAgICAgICAgX191MzIgICAgICAgICAgIGZpbGVfZmxhZ3M7
DQo+ICAgICAgICAgfTsNCj4gDQo+IEZvciB5b3VyIGNhc2UsIHlvdSBjYXJlIGFib3V0Og0KPiAN
Cj4gICAgICAgICBzdHJ1Y3QgeyAvKiBhbm9ueW1vdXMgc3RydWN0IHVzZWQgYnkgQlBGXypfR0VU
XypfSUQgKi8NCj4gICAgICAgICAgICAgICAgIHVuaW9uIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgX191MzIgICAgICAgICAgIHN0YXJ0X2lkOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBfX3UzMiAgICAgICAgICAgcHJvZ19pZDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX191
MzIgICAgICAgICAgIG1hcF9pZDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX191MzIgICAg
ICAgICAgIGJ0Zl9pZDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgX191MzIgICAgICAgICAg
IGxpbmtfaWQ7DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiAgICAgICAgICAgICAgICAgX191MzIg
ICAgICAgICAgIG5leHRfaWQ7DQo+ICAgICAgICAgICAgICAgICBfX3UzMiAgICAgICAgICAgb3Bl
bl9mbGFnczsNCj4gICAgICAgICB9Ow0KPiANCj4gU28geW91ciBuZXcgX29wdHMgbGliYnBmIHJv
dXRpbmUgc2hvdWxkIGJlIGluZGVwZW5kZW50IG9mIHdoYXQgSm9lIGlzDQo+IGRvaW5nIGhlcmUu
DQoNCkl0IGlzLiBKdXN0IEkgdXNlIHRoZSBzYW1lIG9wdHMgdG8gc2V0IGZpbGVfZmxhZ3Mgb3Ig
b3Blbl9mbGFncy4NCg0KUm9iZXJ0bw0KDQo+ID4gUm9iZXJ0bw0KPiA+DQo+ID4gPiA+ID4gPiBJ
dCBuZWVkcyB0byBiZSBzaGFyZWQsIGFzIHRoZXJlIGFyZSBmdW5jdGlvbnMgaW4gYnBmdG9vbCBj
YWxsaW5nDQo+ID4gPiA+ID4gPiBib3RoLiBTaW5jZSB0aGUgbWVhbmluZyBvZiBmbGFncyBpcyB0
aGUgc2FtZSwgc2VlbXMgb2sgc2hhcmluZy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIEkgZ3Vl
c3MgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMgdG8gdGhlIGN1cnJlbnQgcGF0Y2g/IElmIGl0IGdl
dHMNCj4gPiA+ID4gPiBhY2NlcHRlZCwgeW91IHNob3VsZCBiZSBhYmxlIHRvIGRyb3Agc29tZSBv
ZiB5b3VyIGNvZGUgYW5kIHVzZSB0aGlzDQo+ID4gPiA+ID4gbmV3IGJwZl9vYmpfZ2V0X29wdHMu
Lg0KPiA+ID4gPg0KPiA+ID4gPiBJZiB5b3UgdXNlIGEgbmFtZSBnb29kIGFsc28gZm9yIGJwZl8q
X2dldF9mZF9ieV9pZCgpIGFuZCBmbGFncw0KPiA+ID4gPiBhcyBzdHJ1Y3R1cmUgbWVtYmVyIG5h
bWUsIHRoYXQgd291bGQgYmUgb2suDQo+ID4gPiA+DQo+ID4gPiA+IFJvYmVydG8NCj4gPiA+ID4N
Cj4gPiA+ID4gPiA+IFJvYmVydG8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gUm9iZXJ0
bw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
PiA+ID4gPiAgdG9vbHMvbGliL2JwZi9icGYuYyAgICAgIHwgMTAgKysrKysrKysrKw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiAgdG9vbHMvbGliL2JwZi9icGYuaCAgICAgIHwgIDkgKysrKysrKysrDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ICB0b29scy9saWIvYnBmL2xpYmJwZi5tYXAgfCAgMSArDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPiA+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xp
Yi9icGYvYnBmLmMgYi90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGlu
ZGV4IDVlYjBkZjkwZWIyYi4uNWFjYjBlOGJkMTNjIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiA+ID4g
PiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL3Rv
b2xzL2xpYi9icGYvYnBmLmMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTU3OCwxMiArNTc4LDIy
IEBAIGludCBicGZfb2JqX3BpbihpbnQgZmQsIGNvbnN0IGNoYXINCj4gPiA+ID4gPiAqcGF0aG5h
bWUpDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gPiA+ICBpbnQgYnBmX29ial9nZXQoY29uc3QgY2hhciAqcGF0aG5hbWUpDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgTElCQlBGX09Q
VFMoYnBmX29ial9nZXRfb3B0cywgb3B0cyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
cmV0dXJuIGJwZl9vYmpfZ2V0X29wdHMocGF0aG5hbWUsICZvcHRzKTsNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gK30NCj4gPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAraW50
IGJwZl9vYmpfZ2V0X29wdHMoY29uc3QgY2hhciAqcGF0aG5hbWUsIGNvbnN0IHN0cnVjdA0KPiA+
ID4gPiA+ID4gPiBicGZfb2JqX2dldF9vcHRzDQo+ID4gPiA+ID4gPiA+ID4gPiAqb3B0cykNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICB1bmlvbiBi
cGZfYXR0ciBhdHRyOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIGludCBmZDsNCj4gPiA+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoIU9QVFNfVkFM
SUQob3B0cywgYnBmX29ial9nZXRfb3B0cykpDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gbGliYnBmX2VycigtRUlOVkFMKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIG1lbXNldCgmYXR0ciwgMCwgc2l6ZW9mKGF0
dHIpKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICBhdHRyLnBhdGhuYW1lID0gcHRyX3Rv
X3U2NCgodm9pZCAqKXBhdGhuYW1lKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBhdHRy
LmZpbGVfZmxhZ3MgPSBPUFRTX0dFVChvcHRzLCBmaWxlX2ZsYWdzLCAwKTsNCj4gPiA+ID4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICBmZCA9IHN5c19icGZfZmQoQlBG
X09CSl9HRVQsICZhdHRyLCBzaXplb2YoYXR0cikpOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgIHJldHVybiBsaWJicGZfZXJyX2Vycm5vKGZkKTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvYnBmLmggYi90b29scy9saWIvYnBmL2JwZi5oDQo+ID4g
PiA+ID4gPiA+ID4gPiA+IGluZGV4IDg4YTdjYzRiZDc2Zi4uZjMxYjQ5M2I1ZjlhIDEwMDY0NA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0gYS90b29scy9saWIvYnBmL2JwZi5oDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICsrKyBiL3Rvb2xzL2xpYi9icGYvYnBmLmgNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
QEAgLTI3MCw4ICsyNzAsMTcgQEAgTElCQlBGX0FQSSBpbnQNCj4gYnBmX21hcF91cGRhdGVfYmF0
Y2goaW50DQo+ID4gPiBmZCwNCj4gPiA+ID4gPiA+ID4gY29uc3QNCj4gPiA+ID4gPiA+ID4gPiA+
IHZvaWQgKmtleXMsIGNvbnN0IHZvaWQgKnZhbHVlcw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX3UzMiAqY291bnQsDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVj
dCBicGZfbWFwX2JhdGNoX29wdHMgKm9wdHMpOw0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiArc3RydWN0IGJwZl9vYmpfZ2V0X29wdHMgew0KPiA+ID4gPiA+ID4gPiA+
ID4gPiArICAgICAgIHNpemVfdCBzejsgLyogc2l6ZSBvZiB0aGlzIHN0cnVjdCBmb3IgZm9yd2Fy
ZC9iYWNrd2FyZA0KPiA+ID4gY29tcGF0aWJpbGl0eQ0KPiA+ID4gPiA+ICovDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBfX3UzMiBmaWxlX2ZsYWdz
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gPiArfTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyNkZWZpbmUg
YnBmX29ial9nZXRfb3B0c19fbGFzdF9maWVsZCBmaWxlX2ZsYWdzDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gIExJQkJQRl9BUEkgaW50IGJwZl9vYmpfcGluKGlu
dCBmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgTElCQlBG
X0FQSSBpbnQgYnBmX29ial9nZXQoY29uc3QgY2hhciAqcGF0aG5hbWUpOw0KPiA+ID4gPiA+ID4g
PiA+ID4gPiArTElCQlBGX0FQSSBpbnQgYnBmX29ial9nZXRfb3B0cyhjb25zdCBjaGFyICpwYXRo
bmFtZSwNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3QgYnBmX29ial9nZXRfb3B0cyAqb3B0cyk7DQo+ID4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICBzdHJ1Y3QgYnBmX3Byb2dfYXR0YWNoX29wdHMgew0K
PiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHNpemVfdCBzejsgLyogc2l6ZSBvZiB0aGlzIHN0
cnVjdCBmb3IgZm9yd2FyZC9iYWNrd2FyZA0KPiA+ID4gY29tcGF0aWJpbGl0eQ0KPiA+ID4gPiA+
ICovDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJw
Zi5tYXAgYi90b29scy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiA+ID4gPiA+ID4gPiA+ID4gaW5k
ZXggMDYyNWFkYjllODg4Li4xMTllNmUxZWE3ZjEgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gPiA+
IC0tLSBhL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcA0KPiA+ID4gPiA+ID4gPiA+ID4gPiArKysg
Yi90b29scy9saWIvYnBmL2xpYmJwZi5tYXANCj4gPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTM1NSw2
ICszNTUsNyBAQCBMSUJCUEZfMC44LjAgew0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiAgTElCQlBGXzEuMC4wIHsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICBn
bG9iYWw6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBicGZfb2JqX2dldF9v
cHRzOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgYnBmX3Byb2dfcXVlcnlf
b3B0czsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGJwZl9wcm9ncmFtX19h
dHRhY2hfa3N5c2NhbGw7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBidGZf
X2FkZF9lbnVtNjQ7DQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IDIuMzcuMC4xNzAuZzQ0NGQxZWFiZDAtZ29vZw0KPiA+ID4gPiA+ID4gPiA+ID4gPg0K
