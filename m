Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5777C49006D
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 03:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiAQC76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Jan 2022 21:59:58 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31094 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiAQC75 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Jan 2022 21:59:57 -0500
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jcc3x3rPgz1FChT;
        Mon, 17 Jan 2022 10:56:13 +0800 (CST)
Received: from kwepeml500003.china.huawei.com (7.221.188.182) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:59:55 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 kwepeml500003.china.huawei.com (7.221.188.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:59:55 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.020;
 Mon, 17 Jan 2022 10:59:55 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Topic: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Index: AdgLTktk3At/PtlUThCT0czbKVqVNQ==
Date:   Mon, 17 Jan 2022 02:59:55 +0000
Message-ID: <7ac10b7b68b94337971f6d755f735e68@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.114.155]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBPbiBGcmksIEphbiAxNCwgMjAyMiBhdCA2OjM0IFBNIHpodWRpIChFKSA8emh1ZGkyQGh1YXdl
aS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBPbiBUaHUsIEphbiAxMywgMjAyMiBhdCAxOjAxIEFN
IERpIFpodSA8emh1ZGkyQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQg
dGVzdCBmb3IgcXVlcnlpbmcgcHJvZ3MgYXR0YWNoZWQgdG8gc29ja21hcC4gd2UgdXNlIGFuIGV4
aXN0aW5nDQo+ID4gPiA+IGxpYmJwZiBxdWVyeSBpbnRlcmZhY2UgdG8gcXVlcnkgcHJvZyBjbnQg
YmVmb3JlIGFuZCBhZnRlciBwcm9ncw0KPiA+ID4gPiBhdHRhY2hpbmcgdG8gc29ja21hcCBhbmQg
Y2hlY2sgd2hldGhlciB0aGUgcXVlcmllZCBwcm9nIGlkIGlzIHJpZ2h0Lg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaSBaaHUgPHpodWRpMkBodWF3ZWkuY29tPg0KPiA+ID4gPiBB
Y2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NvY2ttYXBfYmFzaWMuYyAgfCA3MA0KPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAuLi4vYnBmL3Byb2dzL3Rlc3Rfc29ja21hcF9w
cm9nc19xdWVyeS5jICAgICAgfCAyNCArKysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDk0IGluc2VydGlvbnMoKykNCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3Rfc29ja21hcF9wcm9nc19xdWVyeS5j
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvcHJvZ190ZXN0cy9zb2NrbWFwX2Jhc2ljLmMNCj4gPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+ID4gPiA+IGluZGV4IDg1ZGIw
ZjRjZGQ5NS4uMDY5MjNlYTQ0YmFkIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zb2NrbWFwX2Jhc2ljLmMNCj4gPiA+ID4gKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29ja21hcF9iYXNpYy5jDQo+
ID4gPiA+IEBAIC04LDYgKzgsNyBAQA0KPiA+ID4gPiAgI2luY2x1ZGUgInRlc3Rfc29ja21hcF91
cGRhdGUuc2tlbC5oIg0KPiA+ID4gPiAgI2luY2x1ZGUgInRlc3Rfc29ja21hcF9pbnZhbGlkX3Vw
ZGF0ZS5za2VsLmgiDQo+ID4gPiA+ICAjaW5jbHVkZSAidGVzdF9zb2NrbWFwX3NrYl92ZXJkaWN0
X2F0dGFjaC5za2VsLmgiDQo+ID4gPiA+ICsjaW5jbHVkZSAidGVzdF9zb2NrbWFwX3Byb2dzX3F1
ZXJ5LnNrZWwuaCINCj4gPiA+ID4gICNpbmNsdWRlICJicGZfaXRlcl9zb2NrbWFwLnNrZWwuaCIN
Cj4gPiA+ID4NCj4gPiA+ID4gICNkZWZpbmUgVENQX1JFUEFJUiAgICAgICAgICAgICAxOSAgICAg
IC8qIFRDUCBzb2NrIGlzIHVuZGVyIHJlcGFpcg0KPiA+ID4gcmlnaHQgbm93ICovDQo+ID4gPiA+
IEBAIC0zMTUsNiArMzE2LDY5IEBAIHN0YXRpYyB2b2lkDQo+IHRlc3Rfc29ja21hcF9za2JfdmVy
ZGljdF9hdHRhY2goZW51bQ0KPiA+ID4gYnBmX2F0dGFjaF90eXBlIGZpcnN0LA0KPiA+ID4gPiAg
ICAgICAgIHRlc3Rfc29ja21hcF9za2JfdmVyZGljdF9hdHRhY2hfX2Rlc3Ryb3koc2tlbCk7DQo+
ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgX191MzIgcXVlcnlfcHJvZ19pZChp
bnQgcHJvZ19mZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgYnBmX3Byb2df
aW5mbyBpbmZvID0ge307DQo+ID4gPiA+ICsgICAgICAgX191MzIgaW5mb19sZW4gPSBzaXplb2Yo
aW5mbyk7DQo+ID4gPiA+ICsgICAgICAgaW50IGVycjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAg
ICAgIGVyciA9IGJwZl9vYmpfZ2V0X2luZm9fYnlfZmQocHJvZ19mZCwgJmluZm8sICZpbmZvX2xl
bik7DQo+ID4gPiA+ICsgICAgICAgaWYgKCFBU1NFUlRfT0soZXJyLCAiYnBmX29ial9nZXRfaW5m
b19ieV9mZCIpIHx8DQo+ID4gPiA+ICsgICAgICAgICAgICFBU1NFUlRfRVEoaW5mb19sZW4sIHNp
emVvZihpbmZvKSwNCj4gImJwZl9vYmpfZ2V0X2luZm9fYnlfZmQiKSkNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIGlu
Zm8uaWQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHRlc3Rf
c29ja21hcF9wcm9nc19xdWVyeShlbnVtIGJwZl9hdHRhY2hfdHlwZQ0KPiBhdHRhY2hfdHlwZSkN
Cj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdGVzdF9zb2NrbWFwX3Byb2dzX3F1
ZXJ5ICpza2VsOw0KPiA+ID4gPiArICAgICAgIGludCBlcnIsIG1hcF9mZCwgdmVyZGljdF9mZCwg
ZHVyYXRpb24gPSAwOw0KPiA+ID4gPiArICAgICAgIF9fdTMyIGF0dGFjaF9mbGFncyA9IDA7DQo+
ID4gPiA+ICsgICAgICAgX191MzIgcHJvZ19pZHNbM10gPSB7fTsNCj4gPiA+ID4gKyAgICAgICBf
X3UzMiBwcm9nX2NudCA9IDM7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBza2VsID0gdGVz
dF9zb2NrbWFwX3Byb2dzX3F1ZXJ5X19vcGVuX2FuZF9sb2FkKCk7DQo+ID4gPiA+ICsgICAgICAg
aWYgKCFBU1NFUlRfT0tfUFRSKHNrZWwsDQo+ID4gPiAidGVzdF9zb2NrbWFwX3Byb2dzX3F1ZXJ5
X19vcGVuX2FuZF9sb2FkIikpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgICAgICBtYXBfZmQgPSBicGZfbWFwX19mZChza2VsLT5tYXBzLnNv
Y2tfbWFwKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChhdHRhY2hfdHlwZSA9PSBC
UEZfU0tfTVNHX1ZFUkRJQ1QpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICB2ZXJkaWN0X2ZkID0N
Cj4gPiA+IGJwZl9wcm9ncmFtX19mZChza2VsLT5wcm9ncy5wcm9nX3NrbXNnX3ZlcmRpY3QpOw0K
PiA+ID4gPiArICAgICAgIGVsc2UNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHZlcmRpY3RfZmQg
PQ0KPiA+ID4gYnBmX3Byb2dyYW1fX2ZkKHNrZWwtPnByb2dzLnByb2dfc2tiX3ZlcmRpY3QpOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZXJyID0gYnBmX3Byb2dfcXVlcnkobWFwX2ZkLCBh
dHRhY2hfdHlwZSwgMCAvKiBxdWVyeSBmbGFncyAqLywNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmYXR0YWNoX2ZsYWdzLCBwcm9nX2lkcywgJnByb2dfY250KTsNCj4gPiA+
ID4gKyAgICAgICBpZiAoIUFTU0VSVF9PSyhlcnIsICJicGZfcHJvZ19xdWVyeSBmYWlsZWQiKSkN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgICAgaWYgKCFBU1NFUlRfRVEoYXR0YWNoX2ZsYWdzLCAgMCwgIndyb25nIGF0dGFjaF9mbGFn
cyBvbiBxdWVyeSIpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyAgICAgICBpZiAoIUFTU0VSVF9FUShwcm9nX2NudCwgMCwgIndyb25nIHBy
b2dyYW0gY291bnQgb24gcXVlcnkiKSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0
Ow0KPiANCj4gSSBtZWFuIGhlcmUgdGhhdCB5b3UgY2FuIGRvIGp1c3QNCj4gDQo+IEFTU0VSVF9P
SyhlcnIsIC4uLik7DQo+IEFTU0VSVF9FUShhdHRhY2hfZmxhZ3MsIC4uLik7DQo+IEFTU0VSVF9F
UShwcm9nX2NudCwgLi4uKTsNCj4gDQo+IE5vIGlmICsgZ290byBuZWNlc3NhcnkuDQoNCkkgc2Vl
IHdoYXQgeW91IG1lYW4uIEknbGwgbW9kaWZ5IHRoZSBjb2RlLCB0aGFua3MNCg0KPiANCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIGVyciA9IGJwZl9wcm9nX2F0dGFjaCh2ZXJkaWN0X2ZkLCBt
YXBfZmQsIGF0dGFjaF90eXBlLCAwKTsNCj4gPiA+ID4gKyAgICAgICBpZiAoIUFTU0VSVF9PSyhl
cnIsICJicGZfcHJvZ19hdHRhY2ggZmFpbGVkIikpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBn
b3RvIG91dDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHByb2dfY250ID0gMTsNCj4gPiA+
ID4gKyAgICAgICBlcnIgPSBicGZfcHJvZ19xdWVyeShtYXBfZmQsIGF0dGFjaF90eXBlLCAwIC8q
IHF1ZXJ5IGZsYWdzICovLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICZh
dHRhY2hfZmxhZ3MsIHByb2dfaWRzLCAmcHJvZ19jbnQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgICAgQVNTRVJUX09LKGVyciwgImJwZl9wcm9nX3F1ZXJ5IGZhaWxlZCIpOw0KPiA+ID4gPiAr
ICAgICAgIEFTU0VSVF9FUShhdHRhY2hfZmxhZ3MsIDAsICJ3cm9uZyBhdHRhY2hfZmxhZ3Mgb24g
cXVlcnkiKTsNCj4gPiA+ID4gKyAgICAgICBBU1NFUlRfRVEocHJvZ19jbnQsIDEsICJ3cm9uZyBw
cm9ncmFtIGNvdW50IG9uIHF1ZXJ5Iik7DQo+ID4gPiA+ICsgICAgICAgQVNTRVJUX0VRKHByb2df
aWRzWzBdLCBxdWVyeV9wcm9nX2lkKHZlcmRpY3RfZmQpLA0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAid3JvbmcgcHJvZ19pZHMgb24gcXVlcnkiKTsNCj4gPiA+DQo+ID4gPiBTZWUgaG93IG11
Y2ggZWFzaWVyIGl0IGlzIHRvIGZvbGxvdyB0aGVzZSB0ZXN0cywgd2h5IGRpZG4ndCB5b3UgZG8g
dGhlDQo+ID4gPiBzYW1lIHdpdGggZXJyLCBhdHRhY2hfZmxhZ3MgYW5kIHByb2cgYWJvdmU/DQo+
ID4NCj4gPiBJdCBpcyByZWNvbW1lbmRlZCBieSBZb25naG9uZyBTb25nIHRvIGluY3JlYXNlIHRo
ZSB0ZXN0IGNvdmVyYWdlLg0KPiANCj4gc2VlIGFib3ZlDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGJwZl9wcm9nX2RldGFjaDIodmVyZGljdF9mZCwg
bWFwX2ZkLCBhdHRhY2hfdHlwZSk7DQo+ID4gPiA+ICtvdXQ6DQo+ID4gPiA+ICsgICAgICAgdGVz
dF9zb2NrbWFwX3Byb2dzX3F1ZXJ5X19kZXN0cm95KHNrZWwpOw0KPiA+ID4gPiArfQ0KPiA+ID4g
PiArDQo+ID4gPiA+ICB2b2lkIHRlc3Rfc29ja21hcF9iYXNpYyh2b2lkKQ0KPiA+ID4gPiAgew0K
PiA+ID4gPiAgICAgICAgIGlmICh0ZXN0X19zdGFydF9zdWJ0ZXN0KCJzb2NrbWFwIGNyZWF0ZV91
cGRhdGVfZnJlZSIpKQ0KPiA+ID4gPiBAQCAtMzQxLDQgKzQwNSwxMCBAQCB2b2lkIHRlc3Rfc29j
a21hcF9iYXNpYyh2b2lkKQ0KPiA+ID4gPg0KPiA+ID4gdGVzdF9zb2NrbWFwX3NrYl92ZXJkaWN0
X2F0dGFjaChCUEZfU0tfU0tCX1NUUkVBTV9WRVJESUNULA0KPiA+ID4gPg0KPiA+ID4gQlBGX1NL
X1NLQl9WRVJESUNUKTsNCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ICsgICAgICAgaWYgKHRl
c3RfX3N0YXJ0X3N1YnRlc3QoInNvY2ttYXAgcHJvZ3MgcXVlcnkiKSkgew0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgdGVzdF9zb2NrbWFwX3Byb2dzX3F1ZXJ5KEJQRl9TS19NU0dfVkVSRElDVCk7
DQo+ID4gPiA+ICsNCj4gPiA+IHRlc3Rfc29ja21hcF9wcm9nc19xdWVyeShCUEZfU0tfU0tCX1NU
UkVBTV9QQVJTRVIpOw0KPiA+ID4gPiArDQo+ID4gPiB0ZXN0X3NvY2ttYXBfcHJvZ3NfcXVlcnko
QlBGX1NLX1NLQl9TVFJFQU1fVkVSRElDVCk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB0ZXN0
X3NvY2ttYXBfcHJvZ3NfcXVlcnkoQlBGX1NLX1NLQl9WRVJESUNUKTsNCj4gPiA+DQo+ID4gPiBX
aHkgYXJlIHRoZXNlIG5vdCBzZXBhcmF0ZSBzdWJ0ZXN0cz8gV2hhdCdzIHRoZSBiZW5lZml0IG9m
IGJ1bmRsaW5nDQo+ID4gPiB0aGVtIGludG8gb25lIHN1YnRlc3Q/DQo+ID4gPg0KPiA+DQo+ID4g
VGhlc2UgYXJlIGVzc2VudGlhbGx5IGRvaW5nIHRoZSBzYW1lIHRoaW5nLCBqdXN0IGZvciBkaWZm
ZXJlbnQgcHJvZ3JhbSBhdHRhY2gNCj4gdHlwZXMuDQo+IA0KPiBSaWdodCwgc28gdGhleSBhcmUg
aW5kZXBlbmRlbnQgc3VidGVzdHMsIG5vPyBOb3Qgc2VwYXJhdGUgdGVzdHMsIGJ1dA0KPiBub3Qg
b25lIHN1YnRlc3QgZWl0aGVyLg0KDQpPaywgSSdsbCBzcGxpdCBpdCBpbnRvIHNldmVyYWwgc3Vi
c2V0cy4NCg0KPiA+DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiAgfQ0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3Rfc29ja21hcF9w
cm9nc19xdWVyeS5jDQo+ID4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90
ZXN0X3NvY2ttYXBfcHJvZ3NfcXVlcnkuYw0KPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjlkNThkNjFjMGRlZQ0KPiA+ID4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90
ZXN0X3NvY2ttYXBfcHJvZ3NfcXVlcnkuYw0KPiA+ID4gPiBAQCAtMCwwICsxLDI0IEBADQo+ID4g
PiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4gPiArI2luY2x1
ZGUgInZtbGludXguaCINCj4gPiA+ID4gKyNpbmNsdWRlIDxicGYvYnBmX2hlbHBlcnMuaD4NCj4g
PiA+ID4gKw0KPiA+ID4gPiArc3RydWN0IHsNCj4gPiA+ID4gKyAgICAgICBfX3VpbnQodHlwZSwg
QlBGX01BUF9UWVBFX1NPQ0tNQVApOw0KPiA+ID4gPiArICAgICAgIF9fdWludChtYXhfZW50cmll
cywgMSk7DQo+ID4gPiA+ICsgICAgICAgX190eXBlKGtleSwgX191MzIpOw0KPiA+ID4gPiArICAg
ICAgIF9fdHlwZSh2YWx1ZSwgX191NjQpOw0KPiA+ID4gPiArfSBzb2NrX21hcCBTRUMoIi5tYXBz
Iik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK1NFQygic2tfc2tiIikNCj4gPiA+ID4gK2ludCBwcm9n
X3NrYl92ZXJkaWN0KHN0cnVjdCBfX3NrX2J1ZmYgKnNrYikNCj4gPiA+ID4gK3sNCj4gPiA+ID4g
KyAgICAgICByZXR1cm4gU0tfUEFTUzsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
U0VDKCJza19tc2ciKQ0KPiA+ID4gPiAraW50IHByb2dfc2ttc2dfdmVyZGljdChzdHJ1Y3Qgc2tf
bXNnX21kICptc2cpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIFNLX1BBU1M7
DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2NoYXIgX2xpY2Vuc2VbXSBTRUMoImxp
Y2Vuc2UiKSA9ICJHUEwiOw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI3LjANCj4gPiA+ID4NCg==
