Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2751F1201
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFHEOG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 00:14:06 -0400
Received: from smtpcn01.kuaishou.com ([221.122.20.39]:26875 "EHLO
        spam1.kuaishou.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726256AbgFHEOG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 00:14:06 -0400
Received: from bjfk-pm-mail07.kuaishou.com ([172.29.5.23])
        by spam1.kuaishou.com with ESMTPS id 0584CMI1079404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 12:12:22 +0800 (GMT-8)
        (envelope-from wangli09@kuaishou.com)
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-ID: <9260C63E5356CC48BBC5763762611A67@kuaishou.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1591589543; h=from:subject:to:date:message-id;
        bh=Rh3WEsXuCz6Icy0/hlYDvieh/ffOwn8niM0BDjVg3uU=;
        b=bDIsrcy6XVdClt5DXYoUuRsLQ91nTBLcDz5IpbpzEaJ7F+aJUVgAsSOuD20ahKOcwZFI1vgfxo+
        XTDtnGZ5ZAJR0KjXHZzSl+KUPgJ+dY59h52b6yYqPKMecV/PA39QMBrawt4ly8Mz55O8+VJT8ASrq
        rD5y04BqRKPiDi8/pKc=
Received: from KS-B15-MAIL10.kuaishou.com (192.168.44.42) by
 bjfk-pm-mail07.kuaishou.com (172.29.5.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 8 Jun 2020 12:12:23 +0800
Received: from KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19]) by
 KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19%17]) with mapi id
 15.01.1979.003; Mon, 8 Jun 2020 12:12:23 +0800
From:   =?gb2312?B?zfXA6A==?= <wangli09@kuaishou.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Sitnicki <jakub@cloudflare.com>,
        Wang Li <wangli8850@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        =?gb2312?B?u8bRp8mt?= <huangxuesen@kuaishou.com>,
        =?gb2312?B?0e7Qy87k?= <yangxingwu@kuaishou.com>
Subject: Re: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Topic: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Index: AQHWPT/Dl06KdbuYOESNk2iKBc2+dKjNlWgA
Date:   Mon, 8 Jun 2020 04:12:23 +0000
Message-ID: <413B2C6D-3235-4ACC-B593-2F3E8FBE8C58@kuaishou.com>
References: <20200605124011.71043-1-wangli09@kuaishou.com>
 <875zc536o1.fsf@cloudflare.com>
 <d24c64f3-ed56-213d-028a-4f8168be6f33@iogearbox.net>
 <7D37DCA5-CA8E-43D2-9734-E271D3BA5431@kuaishou.com>
In-Reply-To: <7D37DCA5-CA8E-43D2-9734-E271D3BA5431@kuaishou.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.44.31]
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam1.kuaishou.com 0584CMI1079404
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SSBqdXN0IHNhdyB0aGUgY29tbWl0IDEzZDcwZjVhNWVjZmYzNjdkYjJmYjE4ZWQ0ZWJlNDMzZWFi
OGE3NGMgU3VuIE1heSAyNCAwOTo1MToxNSAyMDIwIHRoYXQgYWxyZWFkeSBhZGRlZCAic3RydWN0
IGJwZl9zb2NrICosIHNrobEgZm9yIHNrX21zZ19tZC4NCg0KU28gSnVzdCBpZ25vcmUgbXkgcXVl
c3Rpb24uIFRoYW5rIHlvdSBhbGwgYW55d2F5Lg0KDQo+INTaIDIwMjDE6jbUwjjI1aOsyc/O5zEw
OjUxo6zN9cDoIDx3YW5nbGkwOUBrdWFpc2hvdS5jb20+INC0tcCjug0KPiANCj4gRGFuaWVsLCB0
aGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQo+IA0KPiBicGZfZ2V0X25ldG5zX2Nvb2tpZV9zb2Nr
IHJlYWxseSBzb3VuZHMgYmV0dGVyLiANCj4gDQo+IEJ1dCBJIHN0aWxsIGhhdmUgYW5vdGhlciBx
dWVzdGlvbiB0aGF0IGlzIGhvdyBjYW4gSSBnZXQgdGhlIG5ldG5zIGNvb2tpZSB3aGVuIEkgaW52
b2tlIHRoZSBmdW5jdGlvbiChsG1zZ19yZWRpcmVjdF9oYXNoIiBiZWNhdXNlIGl0cyBwYXJhbWV0
ZXIgInN0cnVjdCBza19tc2dfbWShsSBkb2VzIG5vdCBoYXZlIGFueSBuZXRucyBpbmZvcm1hdGlv
biwgYW5kIHRoZXJlIGlzIG5vICJzdHJ1Y3Qgc29jayAqIGN0eKGxIHRvIGJlIHVzZWQgZm9yIHRo
ZSBoZWxwZXIgZnVuY3Rpb24gobBicGZfZ2V0X25ldG5zX2Nvb2tpZV9zb2NrIiB0b28uIEFkZCBh
IGZpZWxkIGZvciBza19tc2dfbWQgPyBBbmQganVzdCBsaWtlIEkgZGlkIGZvciBicGZfc29ja19v
cHMgPw0KPiANCj4gDQo+IA0KPj4g1NogMjAyMMTqNtTCNcjVo6zPws7nMTE6MjKjrERhbmllbCBC
b3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+INC0tcCjug0KPj4gDQo+PiBPbiA2LzUvMjAg
NDo1MyBQTSwgSmFrdWIgU2l0bmlja2kgd3JvdGU6DQo+Pj4gT24gRnJpLCBKdW4gMDUsIDIwMjAg
YXQgMDI6NDAgUE0gQ0VTVCwgV2FuZyBMaSB3cm90ZToNCj4+Pj4gU29tZXRpbWVzIHdlIG5lZWQg
bmV0IG5hbWVzcGFjZSBhcyBwYXJ0IG9mIHRoZSBrZXkgZm9yIEJQRl9NQVBfVFlQRV9TT0NLSEFT
SCB0bw0KPj4+PiBkaXN0aW5ndWlzaCB0aGUgY29ubmVjdGlvbnMgd2l0aCBzYW1lIGZpdmUtdHVw
bGVzLCBmb3IgZXhhbXBsZSB3aGVuIHdlIGRvIHRoZQ0KPj4+PiBzb2NrX21hcCBhY2NlbGVyYXRp
b24gZm9yIHRoZSBwcm94eSB0aGF0IHVzZXMgMTI3LjAuMC4xIHRvIDEyNy4wLjAuMSBjb25uZWN0
aW9ucw0KPj4+PiBpbiBkaWZmZXJlbnQgY29udGFpbmVycyBvbiBzYW1lIG5vZGUuDQo+Pj4+IEFu
ZCB3ZSBleHBvcnQgdGhlIG5ldG5zIGludW0gaW5zdGVhZCBvZiB0aGUgcmVhbCBwb2ludGVyIG9m
IHN0cnVjdCBuZXQgdG8gYXZvaWQNCj4+Pj4gdGhlIHBvdGVudGlhbCBzZWN1cml0eSBpc3N1ZS4N
Cj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFdhbmcgTGkgPHdhbmdsaTA5QGt1YWlzaG91LmNv
bT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogaHVhbmd4dWVzZW4gPGh1YW5neHVlc2VuQGt1YWlzaG91
LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogeWFuZ3hpbmd3dSA8eWFuZ3hpbmd3dUBrdWFpc2hv
dS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmggICAgICAgfCAg
MiArKw0KPj4+PiBuZXQvY29yZS9maWx0ZXIuYyAgICAgICAgICAgICAgfCAxNyArKysrKysrKysr
KysrKysrKw0KPj4+PiB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggfCAgMiArKw0KPj4+
PiAzIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgN
Cj4+Pj4gaW5kZXggYzY1YjM3NGE1MDkwLi4wZmU3ZTQ1OWYwMjMgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
YnBmLmgNCj4+Pj4gQEAgLTM5NDcsNiArMzk0Nyw4IEBAIHN0cnVjdCBicGZfc29ja19vcHMgew0K
Pj4+PiAJCQkJICogdGhlcmUgaXMgYSBmdWxsIHNvY2tldC4gSWYgbm90LCB0aGUNCj4+Pj4gCQkJ
CSAqIGZpZWxkcyByZWFkIGFzIHplcm8uDQo+Pj4+IAkJCQkgKi8NCj4+Pj4gKwlfX3UzMiBuZXRu
c19pbnVtOwkvKiBUaGUgbmV0IG5hbWVzcGFjZSB0aGlzIHNvY2sgYmVsb25ncyB0byAqLw0KPj4+
PiArDQo+Pj4gSW4gdWFwaS9saW51eC9icGYuaCB3ZSBoYXZlIGEgZmllbGQgYG5ldG5zX2lub2Ag
Zm9yIHN0b3JpbmcgbmV0DQo+Pj4gbmFtZXNwYWNlIGlub2RlIG51bWJlciBpbiBhIGNvdXBsZSBz
dHJ1Y3RzIChicGZfcHJvZ19pbmZvLA0KPj4+IGJwZl9tYXBfaW5mbykuIFdvdWxkIGJlIG5pY2Ug
dG8ga2VlcCB0aGUgbmFtaW5nIGNvbnN0ZW50Lg0KPj4gDQo+PiBBZGRpbmcgaW4gdGhlIG1pZGRs
ZSB3aWxsIGJyZWFrIHByb2dyYW1zLiBBbHNvLCBjdXJyZW50bHkgd2UgaGF2ZSB0aGUNCj4+IG1l
cmdlIHdpbmRvdyBvcGVuIGFuZCBhcyBzdWNoIGJwZi1uZXh0IGlzIGNsb3NlZC4gQ2hlY2sgc3Rh
dHVzIGhlcmUgWzBdLg0KPj4gDQo+PiBSZWdhcmRpbmcgYWJvdmUsIHdlIHJlY2VudGx5IGFkZGVk
IGJwZl9nZXRfbmV0bnNfY29va2llKCkgaGVscGVyLCBoYXZlDQo+PiB5b3UgdHJpZWQgdG8gZW5h
YmxlIHRoaXMgb25lIGluc3RlYWQ/DQo+PiANCj4+IFswXSBodHRwOi8vdmdlci5rZXJuZWwub3Jn
L35kYXZlbS9uZXQtbmV4dC5odG1sDQo+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Zp
bHRlci5jIGIvbmV0L2NvcmUvZmlsdGVyLmMNCj4+Pj4gaW5kZXggZDAxYTI0NGI1MDg3Li5iZmU0
NDhhY2UyNWYgMTAwNjQ0DQo+Pj4+IC0tLSBhL25ldC9jb3JlL2ZpbHRlci5jDQo+Pj4+ICsrKyBi
L25ldC9jb3JlL2ZpbHRlci5jDQo+Pj4+IEBAIC04NDUwLDYgKzg0NTAsMjMgQEAgc3RhdGljIHUz
MiBzb2NrX29wc19jb252ZXJ0X2N0eF9hY2Nlc3MoZW51bSBicGZfYWNjZXNzX3R5cGUgdHlwZSwN
Cj4+Pj4gCQkJCQkgICAgICAgaXNfZnVsbHNvY2spKTsNCj4+Pj4gCQlicmVhazsNCj4+Pj4gDQo+
Pj4+ICsJY2FzZSBvZmZzZXRvZihzdHJ1Y3QgYnBmX3NvY2tfb3BzLCBuZXRuc19pbnVtKToNCj4+
Pj4gKyNpZmRlZiBDT05GSUdfTkVUX05TDQo+Pj4+ICsJCSppbnNuKysgPSBCUEZfTERYX01FTShC
UEZfRklFTERfU0laRU9GKA0KPj4+PiArCQkJCQkJc3RydWN0IGJwZl9zb2NrX29wc19rZXJuLCBz
ayksDQo+Pj4+ICsJCQkJICAgICAgc2ktPmRzdF9yZWcsIHNpLT5zcmNfcmVnLA0KPj4+PiArCQkJ
CSAgICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc29ja19vcHNfa2Vybiwgc2spKTsNCj4+Pj4gKwkJ
Kmluc24rKyA9IEJQRl9MRFhfTUVNKEJQRl9GSUVMRF9TSVpFT0YoDQo+Pj4+ICsJCQkJCQlzdHJ1
Y3Qgc29ja19jb21tb24sIHNrY19uZXQpLA0KPj4+PiArCQkJCSAgICAgIHNpLT5kc3RfcmVnLCBz
aS0+ZHN0X3JlZywNCj4+Pj4gKwkJCQkgICAgICBvZmZzZXRvZihzdHJ1Y3Qgc29ja19jb21tb24s
IHNrY19uZXQpKTsNCj4+Pj4gKwkJKmluc24rKyA9IEJQRl9MRFhfTUVNKEJQRl9XLCBzaS0+ZHN0
X3JlZywgc2ktPmRzdF9yZWcsDQo+Pj4+ICsJCQkJICAgICAgb2Zmc2V0b2Yoc3RydWN0IG5ldCwg
bnMuaW51bSkpOw0KPj4+PiArI2Vsc2UNCj4+Pj4gKwkJKmluc24rKyA9IEJQRl9NT1YzMl9JTU0o
c2ktPmRzdF9yZWcsIDApOw0KPj4+PiArI2VuZGlmDQo+Pj4+ICsJCWJyZWFrOw0KPj4+PiArDQo+
Pj4+IAljYXNlIG9mZnNldG9mKHN0cnVjdCBicGZfc29ja19vcHMsIHN0YXRlKToNCj4+Pj4gCQlC
VUlMRF9CVUdfT04oc2l6ZW9mX2ZpZWxkKHN0cnVjdCBzb2NrX2NvbW1vbiwgc2tjX3N0YXRlKSAh
PSAxKTsNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgv
YnBmLmggYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4+Pj4gaW5kZXggYzY1YjM3
NGE1MDkwLi4wZmU3ZTQ1OWYwMjMgMTAwNjQ0DQo+Pj4+IC0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFw
aS9saW51eC9icGYuaA0KPj4+PiArKysgYi90b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgN
Cj4+Pj4gQEAgLTM5NDcsNiArMzk0Nyw4IEBAIHN0cnVjdCBicGZfc29ja19vcHMgew0KPj4+PiAJ
CQkJICogdGhlcmUgaXMgYSBmdWxsIHNvY2tldC4gSWYgbm90LCB0aGUNCj4+Pj4gCQkJCSAqIGZp
ZWxkcyByZWFkIGFzIHplcm8uDQo+Pj4+IAkJCQkgKi8NCj4+Pj4gKwlfX3UzMiBuZXRuc19pbnVt
OwkvKiBUaGUgbmV0IG5hbWVzcGFjZSB0aGlzIHNvY2sgYmVsb25ncyB0byAqLw0KPj4+PiArDQo+
Pj4+IAlfX3UzMiBzbmRfY3duZDsNCj4+Pj4gCV9fdTMyIHNydHRfdXM7CQkvKiBBdmVyYWdlZCBS
VFQgPDwgMyBpbiB1c2VjcyAqLw0KPj4+PiAJX191MzIgYnBmX3NvY2tfb3BzX2NiX2ZsYWdzOyAv
KiBmbGFncyBkZWZpbmVkIGluIHVhcGkvbGludXgvdGNwLmggKi8NCj4+IA0KPiANCg0K
