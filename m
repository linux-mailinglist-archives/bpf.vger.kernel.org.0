Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744771F118D
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 04:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgFHCxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Jun 2020 22:53:41 -0400
Received: from smtpcn01.kuaishou.com ([221.122.20.39]:45671 "EHLO
        spam1.kuaishou.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728065AbgFHCxl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Jun 2020 22:53:41 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 22:53:38 EDT
Received: from bjfk-pm-mail06.kuaishou.com ([172.29.5.22])
        by spam1.kuaishou.com with ESMTPS id 0582pq2m055591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 10:51:52 +0800 (GMT-8)
        (envelope-from wangli09@kuaishou.com)
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-ID: <775F4668A596044A9F25AB10F7E60B3E@kuaishou.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1591584713; h=from:subject:to:date:message-id;
        bh=j8IzUceX/4uUt39Iv7QUq2LS1++F+6XFRVGB9k6+eME=;
        b=nBjIeGEpRqZdhqRjXL9wJzuCv/+OdIehASkFTwyj9d4iTA65GytQoewXjsY7+GOxcMOLAd0W8lt
        ibOAH53eq7t30Ku9mxXJX03KNzqMwOGyIdHaUTZoEK9HNodcreJ3ZCQ0o1VyuZCuUvIqbxrMTPa6F
        7KY1bzRfdRXyTi+fMMQ=
Received: from KS-B15-MAIL10.kuaishou.com (192.168.44.42) by
 bjfk-pm-mail06.kuaishou.com (172.29.5.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 8 Jun 2020 10:51:52 +0800
Received: from KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19]) by
 KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19%17]) with mapi id
 15.01.1979.003; Mon, 8 Jun 2020 10:51:52 +0800
From:   =?gb2312?B?zfXA6A==?= <wangli09@kuaishou.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Sitnicki <jakub@cloudflare.com>,
        Wang Li <wangli8850@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        =?gb2312?B?u8bRp8mt?= <huangxuesen@kuaishou.com>,
        =?gb2312?B?0e7Qy87k?= <yangxingwu@kuaishou.com>
Subject: Re: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Topic: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Index: AQHWPT/DbxZ9dRARDEmUveJutd+uHQ==
Date:   Mon, 8 Jun 2020 02:51:52 +0000
Message-ID: <7D37DCA5-CA8E-43D2-9734-E271D3BA5431@kuaishou.com>
References: <20200605124011.71043-1-wangli09@kuaishou.com>
 <875zc536o1.fsf@cloudflare.com>
 <d24c64f3-ed56-213d-028a-4f8168be6f33@iogearbox.net>
In-Reply-To: <d24c64f3-ed56-213d-028a-4f8168be6f33@iogearbox.net>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.44.31]
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam1.kuaishou.com 0582pq2m055591
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

RGFuaWVsLCB0aGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQoNCmJwZl9nZXRfbmV0bnNfY29va2ll
X3NvY2sgcmVhbGx5IHNvdW5kcyBiZXR0ZXIuIA0KDQpCdXQgSSBzdGlsbCBoYXZlIGFub3RoZXIg
cXVlc3Rpb24gdGhhdCBpcyBob3cgY2FuIEkgZ2V0IHRoZSBuZXRucyBjb29raWUgd2hlbiBJIGlu
dm9rZSB0aGUgZnVuY3Rpb24gobBtc2dfcmVkaXJlY3RfaGFzaCIgYmVjYXVzZSBpdHMgcGFyYW1l
dGVyICJzdHJ1Y3Qgc2tfbXNnX21kobEgZG9lcyBub3QgaGF2ZSBhbnkgbmV0bnMgaW5mb3JtYXRp
b24sIGFuZCB0aGVyZSBpcyBubyAic3RydWN0IHNvY2sgKiBjdHihsSB0byBiZSB1c2VkIGZvciB0
aGUgaGVscGVyIGZ1bmN0aW9uIKGwYnBmX2dldF9uZXRuc19jb29raWVfc29jayIgdG9vLiBBZGQg
YSBmaWVsZCBmb3Igc2tfbXNnX21kID8gQW5kIGp1c3QgbGlrZSBJIGRpZCBmb3IgYnBmX3NvY2tf
b3BzID8NCg0KDQoNCj4g1NogMjAyMMTqNtTCNcjVo6zPws7nMTE6MjKjrERhbmllbCBCb3JrbWFu
biA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+INC0tcCjug0KPiANCj4gT24gNi81LzIwIDQ6NTMgUE0s
IEpha3ViIFNpdG5pY2tpIHdyb3RlOg0KPj4gT24gRnJpLCBKdW4gMDUsIDIwMjAgYXQgMDI6NDAg
UE0gQ0VTVCwgV2FuZyBMaSB3cm90ZToNCj4+PiBTb21ldGltZXMgd2UgbmVlZCBuZXQgbmFtZXNw
YWNlIGFzIHBhcnQgb2YgdGhlIGtleSBmb3IgQlBGX01BUF9UWVBFX1NPQ0tIQVNIIHRvDQo+Pj4g
ZGlzdGluZ3Vpc2ggdGhlIGNvbm5lY3Rpb25zIHdpdGggc2FtZSBmaXZlLXR1cGxlcywgZm9yIGV4
YW1wbGUgd2hlbiB3ZSBkbyB0aGUNCj4+PiBzb2NrX21hcCBhY2NlbGVyYXRpb24gZm9yIHRoZSBw
cm94eSB0aGF0IHVzZXMgMTI3LjAuMC4xIHRvIDEyNy4wLjAuMSBjb25uZWN0aW9ucw0KPj4+IGlu
IGRpZmZlcmVudCBjb250YWluZXJzIG9uIHNhbWUgbm9kZS4NCj4+PiBBbmQgd2UgZXhwb3J0IHRo
ZSBuZXRucyBpbnVtIGluc3RlYWQgb2YgdGhlIHJlYWwgcG9pbnRlciBvZiBzdHJ1Y3QgbmV0IHRv
IGF2b2lkDQo+Pj4gdGhlIHBvdGVudGlhbCBzZWN1cml0eSBpc3N1ZS4NCj4+PiANCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBXYW5nIExpIDx3YW5nbGkwOUBrdWFpc2hvdS5jb20+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogaHVhbmd4dWVzZW4gPGh1YW5neHVlc2VuQGt1YWlzaG91LmNvbT4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiB5YW5neGluZ3d1IDx5YW5neGluZ3d1QGt1YWlzaG91LmNvbT4NCj4+PiAtLS0NCj4+
PiAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgICAgIHwgIDIgKysNCj4+PiAgbmV0L2NvcmUv
ZmlsdGVyLmMgICAgICAgICAgICAgIHwgMTcgKysrKysrKysrKysrKysrKysNCj4+PiAgdG9vbHMv
aW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHwgIDIgKysNCj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4+IGluZGV4IGM2NWIzNzRhNTA5
MC4uMGZlN2U0NTlmMDIzIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9icGYu
aA0KPj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4+IEBAIC0zOTQ3LDYgKzM5
NDcsOCBAQCBzdHJ1Y3QgYnBmX3NvY2tfb3BzIHsNCj4+PiAgCQkJCSAqIHRoZXJlIGlzIGEgZnVs
bCBzb2NrZXQuIElmIG5vdCwgdGhlDQo+Pj4gIAkJCQkgKiBmaWVsZHMgcmVhZCBhcyB6ZXJvLg0K
Pj4+ICAJCQkJICovDQo+Pj4gKwlfX3UzMiBuZXRuc19pbnVtOwkvKiBUaGUgbmV0IG5hbWVzcGFj
ZSB0aGlzIHNvY2sgYmVsb25ncyB0byAqLw0KPj4+ICsNCj4+IEluIHVhcGkvbGludXgvYnBmLmgg
d2UgaGF2ZSBhIGZpZWxkIGBuZXRuc19pbm9gIGZvciBzdG9yaW5nIG5ldA0KPj4gbmFtZXNwYWNl
IGlub2RlIG51bWJlciBpbiBhIGNvdXBsZSBzdHJ1Y3RzIChicGZfcHJvZ19pbmZvLA0KPj4gYnBm
X21hcF9pbmZvKS4gV291bGQgYmUgbmljZSB0byBrZWVwIHRoZSBuYW1pbmcgY29uc3RlbnQuDQo+
IA0KPiBBZGRpbmcgaW4gdGhlIG1pZGRsZSB3aWxsIGJyZWFrIHByb2dyYW1zLiBBbHNvLCBjdXJy
ZW50bHkgd2UgaGF2ZSB0aGUNCj4gbWVyZ2Ugd2luZG93IG9wZW4gYW5kIGFzIHN1Y2ggYnBmLW5l
eHQgaXMgY2xvc2VkLiBDaGVjayBzdGF0dXMgaGVyZSBbMF0uDQo+IA0KPiBSZWdhcmRpbmcgYWJv
dmUsIHdlIHJlY2VudGx5IGFkZGVkIGJwZl9nZXRfbmV0bnNfY29va2llKCkgaGVscGVyLCBoYXZl
DQo+IHlvdSB0cmllZCB0byBlbmFibGUgdGhpcyBvbmUgaW5zdGVhZD8NCj4gDQo+ICBbMF0gaHR0
cDovL3ZnZXIua2VybmVsLm9yZy9+ZGF2ZW0vbmV0LW5leHQuaHRtbA0KPiANCj4+PiBkaWZmIC0t
Z2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0ZXIuYw0KPj4+IGluZGV4IGQw
MWEyNDRiNTA4Ny4uYmZlNDQ4YWNlMjVmIDEwMDY0NA0KPj4+IC0tLSBhL25ldC9jb3JlL2ZpbHRl
ci5jDQo+Pj4gKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMNCj4+PiBAQCAtODQ1MCw2ICs4NDUwLDIz
IEBAIHN0YXRpYyB1MzIgc29ja19vcHNfY29udmVydF9jdHhfYWNjZXNzKGVudW0gYnBmX2FjY2Vz
c190eXBlIHR5cGUsDQo+Pj4gIAkJCQkJICAgICAgIGlzX2Z1bGxzb2NrKSk7DQo+Pj4gIAkJYnJl
YWs7DQo+Pj4gDQo+Pj4gKwljYXNlIG9mZnNldG9mKHN0cnVjdCBicGZfc29ja19vcHMsIG5ldG5z
X2ludW0pOg0KPj4+ICsjaWZkZWYgQ09ORklHX05FVF9OUw0KPj4+ICsJCSppbnNuKysgPSBCUEZf
TERYX01FTShCUEZfRklFTERfU0laRU9GKA0KPj4+ICsJCQkJCQlzdHJ1Y3QgYnBmX3NvY2tfb3Bz
X2tlcm4sIHNrKSwNCj4+PiArCQkJCSAgICAgIHNpLT5kc3RfcmVnLCBzaS0+c3JjX3JlZywNCj4+
PiArCQkJCSAgICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc29ja19vcHNfa2Vybiwgc2spKTsNCj4+
PiArCQkqaW5zbisrID0gQlBGX0xEWF9NRU0oQlBGX0ZJRUxEX1NJWkVPRigNCj4+PiArCQkJCQkJ
c3RydWN0IHNvY2tfY29tbW9uLCBza2NfbmV0KSwNCj4+PiArCQkJCSAgICAgIHNpLT5kc3RfcmVn
LCBzaS0+ZHN0X3JlZywNCj4+PiArCQkJCSAgICAgIG9mZnNldG9mKHN0cnVjdCBzb2NrX2NvbW1v
biwgc2tjX25ldCkpOw0KPj4+ICsJCSppbnNuKysgPSBCUEZfTERYX01FTShCUEZfVywgc2ktPmRz
dF9yZWcsIHNpLT5kc3RfcmVnLA0KPj4+ICsJCQkJICAgICAgb2Zmc2V0b2Yoc3RydWN0IG5ldCwg
bnMuaW51bSkpOw0KPj4+ICsjZWxzZQ0KPj4+ICsJCSppbnNuKysgPSBCUEZfTU9WMzJfSU1NKHNp
LT5kc3RfcmVnLCAwKTsNCj4+PiArI2VuZGlmDQo+Pj4gKwkJYnJlYWs7DQo+Pj4gKw0KPj4+ICAJ
Y2FzZSBvZmZzZXRvZihzdHJ1Y3QgYnBmX3NvY2tfb3BzLCBzdGF0ZSk6DQo+Pj4gIAkJQlVJTERf
QlVHX09OKHNpemVvZl9maWVsZChzdHJ1Y3Qgc29ja19jb21tb24sIHNrY19zdGF0ZSkgIT0gMSk7
DQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCBi
L3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4+IGluZGV4IGM2NWIzNzRhNTA5MC4u
MGZlN2U0NTlmMDIzIDEwMDY0NA0KPj4+IC0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9i
cGYuaA0KPj4+ICsrKyBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4+IEBAIC0z
OTQ3LDYgKzM5NDcsOCBAQCBzdHJ1Y3QgYnBmX3NvY2tfb3BzIHsNCj4+PiAgCQkJCSAqIHRoZXJl
IGlzIGEgZnVsbCBzb2NrZXQuIElmIG5vdCwgdGhlDQo+Pj4gIAkJCQkgKiBmaWVsZHMgcmVhZCBh
cyB6ZXJvLg0KPj4+ICAJCQkJICovDQo+Pj4gKwlfX3UzMiBuZXRuc19pbnVtOwkvKiBUaGUgbmV0
IG5hbWVzcGFjZSB0aGlzIHNvY2sgYmVsb25ncyB0byAqLw0KPj4+ICsNCj4+PiAgCV9fdTMyIHNu
ZF9jd25kOw0KPj4+ICAJX191MzIgc3J0dF91czsJCS8qIEF2ZXJhZ2VkIFJUVCA8PCAzIGluIHVz
ZWNzICovDQo+Pj4gIAlfX3UzMiBicGZfc29ja19vcHNfY2JfZmxhZ3M7IC8qIGZsYWdzIGRlZmlu
ZWQgaW4gdWFwaS9saW51eC90Y3AuaCAqLw0KPiANCg0K
