Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E734759674B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiHQCLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHQCLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 22:11:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDB7822A
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 19:11:17 -0700 (PDT)
Received: from canpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6rxM6GFTzXdXd;
        Wed, 17 Aug 2022 10:07:03 +0800 (CST)
Received: from canpemm500010.china.huawei.com (7.192.105.118) by
 canpemm100009.china.huawei.com (7.192.105.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:11:14 +0800
Received: from canpemm500010.china.huawei.com ([7.192.105.118]) by
 canpemm500010.china.huawei.com ([7.192.105.118]) with mapi id 15.01.2375.024;
 Wed, 17 Aug 2022 10:11:14 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file while
 wait_memory
Thread-Topic: [PATCH bpf-next 1/2] sk_msg: Keep reference on socket file while
 wait_memory
Thread-Index: AQHYsE7+4RUC8e6Zo0eIlwcbIAxeX62xwRoAgACJi2A=
Date:   Wed, 17 Aug 2022 02:11:14 +0000
Message-ID: <3497c978eefd4db7ad0c022fefe14cf6@huawei.com>
References: <20220815023343.295094-1-liujian56@huawei.com>
 <20220815023343.295094-2-liujian56@huawei.com>
 <62fc3c4aad5b2_1cdc820836@john.notmuch>
In-Reply-To: <62fc3c4aad5b2_1cdc820836@john.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.93]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBGYXN0YWJlbmQg
W21haWx0bzpqb2huLmZhc3RhYmVuZEBnbWFpbC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVn
dXN0IDE3LCAyMDIyIDg6NTUgQU0NCj4gVG86IGxpdWppYW4gKENFKSA8bGl1amlhbjU2QGh1YXdl
aS5jb20+OyBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207DQo+IGpha3ViQGNsb3VkZmxhcmUuY29t
OyBlZHVtYXpldEBnb29nbGUuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiB5b3NoZnVqaUBs
aW51eC1pcHY2Lm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBh
YmVuaUByZWRoYXQuY29tOyBhbmRyaWlAa2VybmVsLm9yZzsgbXlrb2xhbEBmYi5jb207IGFzdEBr
ZXJuZWwub3JnOw0KPiBkYW5pZWxAaW9nZWFyYm94Lm5ldDsgbWFydGluLmxhdUBsaW51eC5kZXY7
IHNvbmdAa2VybmVsLm9yZzsgeWhzQGZiLmNvbTsNCj4ga3BzaW5naEBrZXJuZWwub3JnOyBzZGZA
Z29vZ2xlLmNvbTsgaGFvbHVvQGdvb2dsZS5jb207DQo+IGpvbHNhQGtlcm5lbC5vcmc7IHNodWFo
QGtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpdWppYW4gKENFKSA8bGl1
amlhbjU2QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggYnBmLW5leHQgMS8yXSBz
a19tc2c6IEtlZXAgcmVmZXJlbmNlIG9uIHNvY2tldCBmaWxlDQo+IHdoaWxlIHdhaXRfbWVtb3J5
DQo+IA0KPiBMaXUgSmlhbiB3cm90ZToNCj4gPiBGaXggdGhlIGJlbG93IE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZToNCj4gPg0KPiA+IFsgICAxNC40NzEyMDBdIENhbGwgVHJhY2U6DQo+ID4gWyAg
IDE0LjQ3MTU2Ml0gIDxUQVNLPg0KPiA+IFsgICAxNC40NzE4ODJdICBsb2NrX2FjcXVpcmUrMHgy
NDUvMHgyZTANCj4gPiBbICAgMTQuNDcyNDE2XSAgPyByZW1vdmVfd2FpdF9xdWV1ZSsweDEyLzB4
NTANCj4gPiBbICAgMTQuNDczMDE0XSAgPyBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MTcvMHg1
MA0KPiA+IFsgICAxNC40NzM2ODFdICBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4M2QvMHg1MA0K
PiA+IFsgICAxNC40NzQzMThdICA/IHJlbW92ZV93YWl0X3F1ZXVlKzB4MTIvMHg1MA0KPiA+IFsg
ICAxNC40NzQ5MDddICByZW1vdmVfd2FpdF9xdWV1ZSsweDEyLzB4NTANCj4gPiBbICAgMTQuNDc1
NDgwXSAgc2tfc3RyZWFtX3dhaXRfbWVtb3J5KzB4MjBkLzB4MzQwDQo+ID4gWyAgIDE0LjQ3NjEy
N10gID8gZG9fd2FpdF9pbnRyX2lycSsweDgwLzB4ODANCj4gPiBbICAgMTQuNDc2NzA0XSAgZG9f
dGNwX3NlbmRwYWdlcysweDI4Ny8weDYwMA0KPiA+IFsgICAxNC40NzcyODNdICB0Y3BfYnBmX3B1
c2grMHhhYi8weDI2MA0KPiA+IFsgICAxNC40Nzc4MTddICB0Y3BfYnBmX3NlbmRtc2dfcmVkaXIr
MHgyOTcvMHg1MDANCj4gPiBbICAgMTQuNDc4NDYxXSAgPyBfX2xvY2FsX2JoX2VuYWJsZV9pcCsw
eDc3LzB4ZTANCj4gPiBbICAgMTQuNDc5MDk2XSAgdGNwX2JwZl9zZW5kX3ZlcmRpY3QrMHgxMDUv
MHg0NzANCj4gPiBbICAgMTQuNDc5NzI5XSAgdGNwX2JwZl9zZW5kbXNnKzB4MzE4LzB4NGYwDQo+
ID4gWyAgIDE0LjQ4MDMxMV0gIHNvY2tfc2VuZG1zZysweDJkLzB4NDANCj4gPiBbICAgMTQuNDgw
ODIyXSAgX19fX3N5c19zZW5kbXNnKzB4MWI0LzB4MWMwDQo+ID4gWyAgIDE0LjQ4MTM5MF0gID8g
Y29weV9tc2doZHJfZnJvbV91c2VyKzB4NjIvMHg4MA0KPiA+IFsgICAxNC40ODIwNDhdICBfX19z
eXNfc2VuZG1zZysweDc4LzB4YjANCj4gPiBbICAgMTQuNDgyNTgwXSAgPyB2bWZfaW5zZXJ0X3Bm
bl9wcm90KzB4OTEvMHgxNTANCj4gPiBbICAgMTQuNDgzMjE1XSAgPyBfX2RvX2ZhdWx0KzB4MmEv
MHgxYTANCj4gPiBbICAgMTQuNDgzNzM4XSAgPyBkb19mYXVsdCsweDE1ZS8weDVkMA0KPiA+IFsg
ICAxNC40ODQyNDZdICA/IF9faGFuZGxlX21tX2ZhdWx0KzB4NTZiLzB4MTA0MA0KPiA+IFsgICAx
NC40ODQ4NzRdICA/IGxvY2tfaXNfaGVsZF90eXBlKzB4ZGYvMHgxMzANCj4gPiBbICAgMTQuNDg1
NDc0XSAgPyBmaW5kX2hlbGRfbG9jaysweDJkLzB4OTANCj4gPiBbICAgMTQuNDg2MDQ2XSAgPyBf
X3N5c19zZW5kbXNnKzB4NDEvMHg3MA0KPiA+IFsgICAxNC40ODY1ODddICBfX3N5c19zZW5kbXNn
KzB4NDEvMHg3MA0KPiA+IFsgICAxNC40ODcxMDVdICA/IGludGVsX3BtdV9kcmFpbl9wZWJzX2Nv
cmUrMHgzNTAvMHgzNTANCj4gPiBbICAgMTQuNDg3ODIyXSAgZG9fc3lzY2FsbF82NCsweDM0LzB4
ODANCj4gPiBbICAgMTQuNDg4MzQ1XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NjMvMHhjZA0KPiA+DQo+ID4gVGhlIHRlc3Qgc2NlbmUgYXMgZm9sbG93aW5nIGZsb3c6DQo+ID4g
dGhyZWFkMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0aHJlYWQyDQo+ID4gLS0tLS0t
LS0tLS0gICAgICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0NCj4gPiAgdGNw
X2JwZl9zZW5kbXNnDQo+ID4gICB0Y3BfYnBmX3NlbmRfdmVyZGljdA0KPiA+ICAgIHRjcF9icGZf
c2VuZG1zZ19yZWRpciAgICAgICAgICAgICAgc29ja19jbG9zZQ0KPiA+ICAgICB0Y3BfYnBmX3B1
c2hfbG9ja2VkICAgICAgICAgICAgICAgICBfX3NvY2tfcmVsZWFzZQ0KPiA+ICAgICAgdGNwX2Jw
Zl9wdXNoICAgICAgICAgICAgICAgICAgICAgICAgIC8vaW5ldF9yZWxlYXNlDQo+ID4gICAgICAg
ZG9fdGNwX3NlbmRwYWdlcyAgICAgICAgICAgICAgICAgICAgc29jay0+b3BzLT5yZWxlYXNlDQo+
ID4gICAgICAgIHNrX3N0cmVhbV93YWl0X21lbW9yeSAgICAgICAgICAJICAgLy8gdGNwX2Nsb3Nl
DQo+ID4gICAgICAgICAgIHNrX3dhaXRfZXZlbnQgICAgICAgICAgICAgICAgICAgICAgc2stPnNr
X3Byb3QtPmNsb3NlDQo+ID4gICAgICAgICAgICByZWxlYXNlX3NvY2soX19zayk7DQo+ID4gICAg
ICAgICAgICAgKioqDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NrX3NvY2soc2spOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgX190Y3BfY2xvc2UNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc29ja19vcnBoYW4oc2spDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2stPnNrX3dxICA9IE5VTEwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWxlYXNlX3NvY2sNCj4gPiAgICAgICAgICAgICAqKioqDQo+ID4gICAg
ICAgICAgICBsb2NrX3NvY2soX19zayk7DQo+ID4gICAgICAgICAgIHJlbW92ZV93YWl0X3F1ZXVl
KHNrX3NsZWVwKHNrKSwgJndhaXQpOw0KPiA+ICAgICAgICAgICAgICBza19zbGVlcChzaykNCj4g
PiAgICAgICAgICAgICAgLy9OVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UNCj4gPiAgICAgICAgICAg
ICAgJnJjdV9kZXJlZmVyZW5jZV9yYXcoc2stPnNrX3dxKS0+d2FpdA0KPiA+DQo+ID4gV2hpbGUg
d2FpdGluZyBmb3IgbWVtb3J5IGluIHRocmVhZDEsIHRoZSBzb2NrZXQgaXMgcmVsZWFzZWQgd2l0
aCBpdHMNCj4gPiB3YWl0IHF1ZXVlIGJlY2F1c2UgdGhyZWFkMiBoYXMgY2xvc2VkIGl0LiBUaGlz
IGNhdXNlZCBieQ0KPiA+IHRjcF9icGZfc2VuZF92ZXJkaWN0IGRpZG4ndCBpbmNyZWFzZSB0aGUg
Zl9jb3VudCBvZiBwc29jay0+c2tfcmVkaXItDQo+ID5za19zb2NrZXQtPmZpbGUgaW4gdGhyZWFk
MS4NCj4gPg0KPiA+IEF2b2lkIGl0IGJ5IGtlZXBpbmcgYSByZWZlcmVuY2UgdG8gdGhlIHNvY2tl
dCBmaWxlIHdoaWxlIHJlZGlyZWN0IHNvY2sNCj4gPiB3YWl0IHNlbmQgbWVtb3J5LiBSZWZlciB0
byBbMV0uDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
MjAxOTAyMTEwOTA5NDkuMTg1NjAtMS1qYWt1YkBjbG91ZGZsYXJlDQo+ID4gLmNvbS8NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IExpdSBKaWFuIDxsaXVqaWFuNTZAaHVhd2VpLmNvbT4NCj4gDQo+
IFRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIGNvbW1pdCBtZXNzYWdlIGl0cyBuZWNlc3NhcnkgdG8g
dW5kZXJzdGFuZCB0aGUNCj4gcHJvYmxlbSB3aXRob3V0IHNwZW5kaW5nIGhvdXJzIGRlY2lwaGVy
aW5nIGl0IG15c2VsZi4NCj4gDQo+IFdoZW4gSSBsb29rZWQgYXQgWzFdIHdlIHNvbHZlZCBhIHNp
bWxpYXIgcHJvYmxlbSBieSB1c2luZyB0aGUNCj4gTVNHX0RPTlRXQUlUIGZsYWcgc28gdGhhdCB0
aGUgZXJyb3Igd2FzIHB1c2hlZCBiYWNrIHRvIHRoZSBzZW5kaW5nLg0KPiANCj4gQ2FuIHdlIGRv
IHRoZSBzYW1lIHRoaW5nIGhlcmU/IFRoZSBuaWNlIGJpdCBoZXJlIGlzIHRoZSBlcnJvciB3b3Vs
ZCBnZXQgYWxsDQo+IHRoZSB3YXkgYmFjayB0byB0aGUgc2VuZGluZyBzb2NrZXQgc28gdXNlcnNw
YWNlIGNvdWxkIGRlY2lkZSBob3cgdG8gaGFuZGxlDQo+IGl0PyBEaWQgSSBtaXNzIHNvbWV0aGlu
Zz8NCj4gDQpbMV0gd29ya3MgaW4gc2tfcHNvY2tfYmFja2xvZyBmdW5jdGlvbiwgaXQgY2FuIG5v
dCBiZSBkZXRlY3RlZCBieSB0aGUgdXNlcnNwYWNlIGFwcC4NCkJ1dCBoZXJlLCB0aGUgcHJvYmxl
bSBpcyB0aGF0IGFwcCB3YW50cyB0aGlzIHRvIGJlIGEgYmxvY2tlZCBzeXN0ZW0gY2FsbC4NCklm
IHRoZSBNU0dfRE9OVFdBSVQgZmxhZyBpcyBmb3JjaWJseSBhZGRlZCwgdGhpcyBjaGFuZ2VzIHRo
ZSBmdW5jdGlvbiBiZWhhdmlvci4NCg0KPiA+IC0tLQ0KPiA+ICBuZXQvaXB2NC90Y3BfYnBmLmMg
fCA4ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfYnBmLmMgYi9uZXQvaXB2NC90Y3BfYnBmLmMg
aW5kZXgNCj4gPiBhMTYyNmFmZTg3YTEuLjIwMTM3NTgyOTM2NyAxMDA2NDQNCj4gPiAtLS0gYS9u
ZXQvaXB2NC90Y3BfYnBmLmMNCj4gPiArKysgYi9uZXQvaXB2NC90Y3BfYnBmLmMNCj4gPiBAQCAt
MTI1LDkgKzEyNSwxNyBAQCBzdGF0aWMgaW50IHRjcF9icGZfcHVzaF9sb2NrZWQoc3RydWN0IHNv
Y2sgKnNrLA0KPiA+IHN0cnVjdCBza19tc2cgKm1zZywgIHsNCj4gPiAgCWludCByZXQ7DQo+ID4N
Cj4gPiArCS8qIEhvbGQgb24gdG8gc29ja2V0IHdhaXQgcXVldWUuICovDQo+ID4gKwlpZiAoc2st
PnNrX3NvY2tldCAmJiBzay0+c2tfc29ja2V0LT5maWxlKQ0KPiA+ICsJCWdldF9maWxlKHNrLT5z
a19zb2NrZXQtPmZpbGUpOw0KPiA+ICsNCj4gPiAgCWxvY2tfc29jayhzayk7DQo+ID4gIAlyZXQg
PSB0Y3BfYnBmX3B1c2goc2ssIG1zZywgYXBwbHlfYnl0ZXMsIGZsYWdzLCB1bmNoYXJnZSk7DQo+
ID4gIAlyZWxlYXNlX3NvY2soc2spOw0KPiA+ICsNCj4gPiArCWlmIChzay0+c2tfc29ja2V0ICYm
IHNrLT5za19zb2NrZXQtPmZpbGUpDQo+ID4gKwkJZnB1dChzay0+c2tfc29ja2V0LT5maWxlKTsN
Cj4gPiArDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcu
MQ0KPiA+DQo+IA0KDQo=
