Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2921F11A3
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 05:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFHDMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Jun 2020 23:12:35 -0400
Received: from smtpcn01.kuaishou.com ([221.122.20.39]:25637 "EHLO
        spam2.kuaishou.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728065AbgFHDMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Jun 2020 23:12:34 -0400
Received: from spam2.kuaishou.com (localhost [127.0.0.2] (may be forged))
        by spam2.kuaishou.com with ESMTP id 0582lQxS029922
        for <bpf@vger.kernel.org>; Mon, 8 Jun 2020 10:47:26 +0800 (GMT-8)
        (envelope-from wangli09@kuaishou.com)
Received: from KS-MAIL02.kuaishou.com ([192.168.44.22])
        by spam2.kuaishou.com with ESMTPS id 0582jcll028954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 10:45:38 +0800 (GMT-8)
        (envelope-from wangli09@kuaishou.com)
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-ID: <E3533D552B7BB14A9991FE02A7C394C3@kuaishou.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1591584339; h=from:subject:to:date:message-id;
        bh=2+vOpHiMvjF5UW8HIJhrF98hmlxru7T174CtZmyDHEE=;
        b=fUK0j1b1oLS07GhkeUretcCsRl3+0s4WRuo+BJVj7PWKrnADlB2H6ovN7AfzX9VC9bB4M/XgiJd
        ZrtMjVJtx7w8/FQ9mTgLiHBscsQNS+11AO8Jl3vCb1yd4EybROsH+Mu9DA16MpxmyhnyLE5QVuBsf
        PcGqgzCBPOfsv5pI6vM=
Received: from KS-B15-MAIL10.kuaishou.com (192.168.44.42) by
 KS-MAIL02.kuaishou.com (192.168.44.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 8 Jun 2020 10:45:38 +0800
Received: from KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19]) by
 KS-B15-MAIL10.kuaishou.com ([fe80::9c5b:7686:ff56:3a19%17]) with mapi id
 15.01.1979.003; Mon, 8 Jun 2020 10:45:38 +0800
From:   =?gb2312?B?zfXA6A==?= <wangli09@kuaishou.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
CC:     Wang Li <wangli8850@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        =?gb2312?B?u8bRp8mt?= <huangxuesen@kuaishou.com>,
        =?gb2312?B?0e7Qy87k?= <yangxingwu@kuaishou.com>
Subject: Re: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Topic: [PATCH] bpf: export the net namespace for bpf_sock_ops
Thread-Index: AQHWPT7kcdM5lU3L1EmqXFhY33gFPA==
Date:   Mon, 8 Jun 2020 02:45:38 +0000
Message-ID: <213474E6-1BCD-4CA6-92D1-AE74EB8F556A@kuaishou.com>
References: <20200605124011.71043-1-wangli09@kuaishou.com>
 <875zc536o1.fsf@cloudflare.com>
In-Reply-To: <875zc536o1.fsf@cloudflare.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.44.31]
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam2.kuaishou.com 0582jcll028954
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SmFrdWIsIHRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KPiDU2iAyMDIwxOo21MI1yNWjrM/C
zucxMDo1M6OsSmFrdWIgU2l0bmlja2kgPGpha3ViQGNsb3VkZmxhcmUuY29tPiDQtLXAo7oNCj4g
DQo+IE9uIEZyaSwgSnVuIDA1LCAyMDIwIGF0IDAyOjQwIFBNIENFU1QsIFdhbmcgTGkgd3JvdGU6
DQo+PiBTb21ldGltZXMgd2UgbmVlZCBuZXQgbmFtZXNwYWNlIGFzIHBhcnQgb2YgdGhlIGtleSBm
b3IgQlBGX01BUF9UWVBFX1NPQ0tIQVNIIHRvDQo+PiBkaXN0aW5ndWlzaCB0aGUgY29ubmVjdGlv
bnMgd2l0aCBzYW1lIGZpdmUtdHVwbGVzLCBmb3IgZXhhbXBsZSB3aGVuIHdlIGRvIHRoZQ0KPj4g
c29ja19tYXAgYWNjZWxlcmF0aW9uIGZvciB0aGUgcHJveHkgdGhhdCB1c2VzIDEyNy4wLjAuMSB0
byAxMjcuMC4wLjEgY29ubmVjdGlvbnMNCj4+IGluIGRpZmZlcmVudCBjb250YWluZXJzIG9uIHNh
bWUgbm9kZS4NCj4+IEFuZCB3ZSBleHBvcnQgdGhlIG5ldG5zIGludW0gaW5zdGVhZCBvZiB0aGUg
cmVhbCBwb2ludGVyIG9mIHN0cnVjdCBuZXQgdG8gYXZvaWQNCj4+IHRoZSBwb3RlbnRpYWwgc2Vj
dXJpdHkgaXNzdWUuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFdhbmcgTGkgPHdhbmdsaTA5QGt1
YWlzaG91LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IGh1YW5neHVlc2VuIDxodWFuZ3h1ZXNlbkBr
dWFpc2hvdS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiB5YW5neGluZ3d1IDx5YW5neGluZ3d1QGt1
YWlzaG91LmNvbT4NCj4+IC0tLQ0KPj4gaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgICAgIHwg
IDIgKysNCj4+IG5ldC9jb3JlL2ZpbHRlci5jICAgICAgICAgICAgICB8IDE3ICsrKysrKysrKysr
KysrKysrDQo+PiB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggfCAgMiArKw0KPj4gMyBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4+IGluZGV4
IGM2NWIzNzRhNTA5MC4uMGZlN2U0NTlmMDIzIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBp
L2xpbnV4L2JwZi5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4+IEBAIC0z
OTQ3LDYgKzM5NDcsOCBAQCBzdHJ1Y3QgYnBmX3NvY2tfb3BzIHsNCj4+IAkJCQkgKiB0aGVyZSBp
cyBhIGZ1bGwgc29ja2V0LiBJZiBub3QsIHRoZQ0KPj4gCQkJCSAqIGZpZWxkcyByZWFkIGFzIHpl
cm8uDQo+PiAJCQkJICovDQo+PiArCV9fdTMyIG5ldG5zX2ludW07CS8qIFRoZSBuZXQgbmFtZXNw
YWNlIHRoaXMgc29jayBiZWxvbmdzIHRvICovDQo+PiArDQo+IA0KPiBJbiB1YXBpL2xpbnV4L2Jw
Zi5oIHdlIGhhdmUgYSBmaWVsZCBgbmV0bnNfaW5vYCBmb3Igc3RvcmluZyBuZXQNCj4gbmFtZXNw
YWNlIGlub2RlIG51bWJlciBpbiBhIGNvdXBsZSBzdHJ1Y3RzIChicGZfcHJvZ19pbmZvLA0KPiBi
cGZfbWFwX2luZm8pLiBXb3VsZCBiZSBuaWNlIHRvIGtlZXAgdGhlIG5hbWluZyBjb25zdGVudC4N
Cj4gDQo+PiAJX191MzIgc25kX2N3bmQ7DQo+PiAJX191MzIgc3J0dF91czsJCS8qIEF2ZXJhZ2Vk
IFJUVCA8PCAzIGluIHVzZWNzICovDQo+PiAJX191MzIgYnBmX3NvY2tfb3BzX2NiX2ZsYWdzOyAv
KiBmbGFncyBkZWZpbmVkIGluIHVhcGkvbGludXgvdGNwLmggKi8NCj4+IGRpZmYgLS1naXQgYS9u
ZXQvY29yZS9maWx0ZXIuYyBiL25ldC9jb3JlL2ZpbHRlci5jDQo+PiBpbmRleCBkMDFhMjQ0YjUw
ODcuLmJmZTQ0OGFjZTI1ZiAxMDA2NDQNCj4+IC0tLSBhL25ldC9jb3JlL2ZpbHRlci5jDQo+PiAr
KysgYi9uZXQvY29yZS9maWx0ZXIuYw0KPj4gQEAgLTg0NTAsNiArODQ1MCwyMyBAQCBzdGF0aWMg
dTMyIHNvY2tfb3BzX2NvbnZlcnRfY3R4X2FjY2VzcyhlbnVtIGJwZl9hY2Nlc3NfdHlwZSB0eXBl
LA0KPj4gCQkJCQkgICAgICAgaXNfZnVsbHNvY2spKTsNCj4+IAkJYnJlYWs7DQo+PiANCj4+ICsJ
Y2FzZSBvZmZzZXRvZihzdHJ1Y3QgYnBmX3NvY2tfb3BzLCBuZXRuc19pbnVtKToNCj4+ICsjaWZk
ZWYgQ09ORklHX05FVF9OUw0KPj4gKwkJKmluc24rKyA9IEJQRl9MRFhfTUVNKEJQRl9GSUVMRF9T
SVpFT0YoDQo+PiArCQkJCQkJc3RydWN0IGJwZl9zb2NrX29wc19rZXJuLCBzayksDQo+PiArCQkJ
CSAgICAgIHNpLT5kc3RfcmVnLCBzaS0+c3JjX3JlZywNCj4+ICsJCQkJICAgICAgb2Zmc2V0b2Yo
c3RydWN0IGJwZl9zb2NrX29wc19rZXJuLCBzaykpOw0KPj4gKwkJKmluc24rKyA9IEJQRl9MRFhf
TUVNKEJQRl9GSUVMRF9TSVpFT0YoDQo+PiArCQkJCQkJc3RydWN0IHNvY2tfY29tbW9uLCBza2Nf
bmV0KSwNCj4+ICsJCQkJICAgICAgc2ktPmRzdF9yZWcsIHNpLT5kc3RfcmVnLA0KPj4gKwkJCQkg
ICAgICBvZmZzZXRvZihzdHJ1Y3Qgc29ja19jb21tb24sIHNrY19uZXQpKTsNCj4+ICsJCSppbnNu
KysgPSBCUEZfTERYX01FTShCUEZfVywgc2ktPmRzdF9yZWcsIHNpLT5kc3RfcmVnLA0KPj4gKwkJ
CQkgICAgICBvZmZzZXRvZihzdHJ1Y3QgbmV0LCBucy5pbnVtKSk7DQo+PiArI2Vsc2UNCj4+ICsJ
CSppbnNuKysgPSBCUEZfTU9WMzJfSU1NKHNpLT5kc3RfcmVnLCAwKTsNCj4+ICsjZW5kaWYNCj4+
ICsJCWJyZWFrOw0KPj4gKw0KPj4gCWNhc2Ugb2Zmc2V0b2Yoc3RydWN0IGJwZl9zb2NrX29wcywg
c3RhdGUpOg0KPj4gCQlCVUlMRF9CVUdfT04oc2l6ZW9mX2ZpZWxkKHN0cnVjdCBzb2NrX2NvbW1v
biwgc2tjX3N0YXRlKSAhPSAxKTsNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUv
dWFwaS9saW51eC9icGYuaCBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPj4gaW5k
ZXggYzY1YjM3NGE1MDkwLi4wZmU3ZTQ1OWYwMjMgMTAwNjQ0DQo+PiAtLS0gYS90b29scy9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmgNCj4+ICsrKyBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9i
cGYuaA0KPj4gQEAgLTM5NDcsNiArMzk0Nyw4IEBAIHN0cnVjdCBicGZfc29ja19vcHMgew0KPj4g
CQkJCSAqIHRoZXJlIGlzIGEgZnVsbCBzb2NrZXQuIElmIG5vdCwgdGhlDQo+PiAJCQkJICogZmll
bGRzIHJlYWQgYXMgemVyby4NCj4+IAkJCQkgKi8NCj4+ICsJX191MzIgbmV0bnNfaW51bTsJLyog
VGhlIG5ldCBuYW1lc3BhY2UgdGhpcyBzb2NrIGJlbG9uZ3MgdG8gKi8NCj4+ICsNCj4+IAlfX3Uz
MiBzbmRfY3duZDsNCj4+IAlfX3UzMiBzcnR0X3VzOwkJLyogQXZlcmFnZWQgUlRUIDw8IDMgaW4g
dXNlY3MgKi8NCj4+IAlfX3UzMiBicGZfc29ja19vcHNfY2JfZmxhZ3M7IC8qIGZsYWdzIGRlZmlu
ZWQgaW4gdWFwaS9saW51eC90Y3AuaCAqLw0KDQo=
