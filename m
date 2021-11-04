Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617D8444EA3
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 07:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDGMK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 02:12:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14714 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhKDGMK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 02:12:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlCpc1B5VzZcmP;
        Thu,  4 Nov 2021 14:07:20 +0800 (CST)
Received: from dggpeml100009.china.huawei.com (7.185.36.95) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 14:09:20 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml100009.china.huawei.com (7.185.36.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 14:09:20 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Thu, 4 Nov 2021 14:09:20 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Yonghong Song <yhs@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Topic: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Thread-Index: AdfRQjV0VZ4AJAhNDki/kj/1FpZ/Zw==
Date:   Thu, 4 Nov 2021 06:09:19 +0000
Message-ID: <3e98a5f5cd9a482fa95acc052484914d@huawei.com>
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

PiBPbiAxMS8zLzIxIDY6MDcgUE0sIERpIFpodSB3cm90ZToNCj4gPiBBZGQgdGVzdCBmb3IgcXVl
cnlpbmcgcHJvZ3MgYXR0YWNoZWQgdG8gc29ja21hcC4gd2UgdXNlIGFuIGV4aXN0aW5nDQo+ID4g
bGliYnBmIHF1ZXJ5IGludGVyZmFjZSB0byBxdWVyeSBwcm9nIGNudCBiZWZvcmUgYW5kIGFmdGVy
IHByb2dzDQo+ID4gYXR0YWNoaW5nIHRvIHNvY2ttYXAgYW5kIGNoZWNrIHdoZXRoZXIgdGhlIHF1
ZXJpZWQgcHJvZyBpZCBpcyByaWdodC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERpIFpodSA8
emh1ZGkyQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3NvY2ttYXBfYmFzaWMuYyAgfCA3NSArKysrKysrKysrKysrKysrKysrDQo+ID4gICAu
Li4vYnBmL3Byb2dzL3Rlc3Rfc29ja21hcF9wcm9nc19xdWVyeS5jICAgICAgfCAyNCArKysrKysN
Cj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3NvY2tt
YXBfcHJvZ3NfcXVlcnkuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NvY2ttYXBfYmFzaWMuYw0KPiBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NvY2ttYXBfYmFzaWMuYw0KPiA+IGluZGV4IDEzNTJl
YzEwNDE0OS4uZGU4ZjkxZDkxMjQwIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NvY2ttYXBfYmFzaWMuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NvY2ttYXBfYmFzaWMuYw0KPiA+IEBAIC04
LDYgKzgsNyBAQA0KPiA+ICAgI2luY2x1ZGUgInRlc3Rfc29ja21hcF91cGRhdGUuc2tlbC5oIg0K
PiA+ICAgI2luY2x1ZGUgInRlc3Rfc29ja21hcF9pbnZhbGlkX3VwZGF0ZS5za2VsLmgiDQo+ID4g
ICAjaW5jbHVkZSAidGVzdF9zb2NrbWFwX3NrYl92ZXJkaWN0X2F0dGFjaC5za2VsLmgiDQo+ID4g
KyNpbmNsdWRlICJ0ZXN0X3NvY2ttYXBfcHJvZ3NfcXVlcnkuc2tlbC5oIg0KPiA+ICAgI2luY2x1
ZGUgImJwZl9pdGVyX3NvY2ttYXAuc2tlbC5oIg0KPiA+DQo+ID4gICAjZGVmaW5lIFRDUF9SRVBB
SVIJCTE5CS8qIFRDUCBzb2NrIGlzIHVuZGVyIHJlcGFpciByaWdodCBub3cgKi8NCj4gPiBAQCAt
MzE1LDYgKzMxNiw3NCBAQCBzdGF0aWMgdm9pZCB0ZXN0X3NvY2ttYXBfc2tiX3ZlcmRpY3RfYXR0
YWNoKGVudW0NCj4gYnBmX2F0dGFjaF90eXBlIGZpcnN0LA0KPiA+ICAgCXRlc3Rfc29ja21hcF9z
a2JfdmVyZGljdF9hdHRhY2hfX2Rlc3Ryb3koc2tlbCk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3Rh
dGljIF9fdTMyIHF1ZXJ5X3Byb2dfaWQoaW50IHByb2dfZmQpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBicGZfcHJvZ19pbmZvIGluZm8gPSB7fTsNCj4gPiArCV9fdTMyIGluZm9fbGVuID0gc2l6ZW9m
KGluZm8pOw0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwllcnIgPSBicGZfb2JqX2dldF9p
bmZvX2J5X2ZkKHByb2dfZmQsICZpbmZvLCAmaW5mb19sZW4pOw0KPiA+ICsJaWYgKENIRUNLX0ZB
SUwoZXJyIHx8IGluZm9fbGVuICE9IHNpemVvZihpbmZvKSkpIHsNCj4gPiArCQlwZXJyb3IoImJw
Zl9vYmpfZ2V0X2luZm9fYnlfZmQiKTsNCj4gDQo+IFBsZWFzZSB1c2UgQVNTRVJUXyogbWFjcm9z
LiBUaGVzZSBtYWNyb3MgYXJlIGRlZmluZWQgaW4gdGVzdF9wcm9ncy5oLg0KPiBXZSBtYXkgaGF2
ZSBzb21lIG9sZCBmaWxlcyBzdGlsbCB1c2luZyBDSEVDSyogd2hpY2ggYXJlIG5vdCBjb252ZXJ0
ZWQNCj4gdG8gQVNTRVJUKiB5ZXQuIEJ1dCBmb3IgbmV3IGNvbnRyaWJ1dGlvbnMsIHdlIHdvdWxk
IGxpa2UgdG8gdXNlDQo+IEFTU0VSVCogZnJvbSBzdGFydC4gWW91IGNhbiBjaGVjayBvdGhlciBw
cm9nX3Rlc3RzLyouYyBmaWxlcyBmb3INCj4gZXhhbXBsZXMuDQo+IA0KPiBGb3IgdGhlIGFib3Zl
IGV4YW1wbGUsIHlvdSBjYW4gZG8NCj4gCWlmICghQVNTRVJUX09LKGVyciwgImJwZl9vYmpfZ2V0
X2luZm9fYnlfZmQiKSB8fA0KPiAJICAgICFBU1NFUlRfRVEoaW5mb19sZW4sIHNpemVvZihpbmZv
KSwgImJwZl9vYmpfZ2V0X2luZm9fYnlfZmQiKSkNCj4gCQlyZXR1cm4gMDsNCg0KSSByZWZlciB0
byB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIG9sZCBjb2RlcywgSSB3aWxsIG1vZGlmeSBpdA0K
VGhhbmtzLA0KDQoNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1
cm4gaW5mby5pZDsNCj4gWy4uLl0NCj4gPiArCWVyciA9IGJwZl9wcm9nX3F1ZXJ5KG1hcF9mZCwg
YXR0YWNoX3R5cGUsIDAgLyogcXVlcnkgZmxhZ3MgKi8sDQo+ID4gKwkJCSAgICAgJmF0dGFjaF9m
bGFncywgcHJvZ19pZHMsICZwcm9nX2NudCk7DQo+ID4gKwlpZiAoQ0hFQ0soZXJyLCAiYnBmX3By
b2dfcXVlcnkiLCAiZmFpbGVkXG4iKSkNCj4gPiArCQlnb3RvIG91dDsNCj4gDQo+IEluIHRoaXMg
Y2FzZSwgeW91IGNhbiB1c2UNCj4gCWlmICghQVNTRVJUX09LKGVyciwgImJwZl9wcm9nX3F1ZXJ5
IikpDQo+IAkJZ290byBvdXQ7DQo+IA0KPiBQbGVhc2UgYWxzbyBjaGFuZ2UgYmVsb3cgb3RoZXIg
Q0hFQ0sgdXNhZ2VzLg0KPiANCj4gPiArDQo+ID4gKwlpZiAoQ0hFQ0soYXR0YWNoX2ZsYWdzICE9
IDAsICJicGZfcHJvZ19xdWVyeSIsDQo+ID4gKwkJICAid3JvbmcgYXR0YWNoX2ZsYWdzIG9uIHF1
ZXJ5OiAldSIsIGF0dGFjaF9mbGFncykpDQo+ID4gKwkJZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsJ
aWYgKENIRUNLKHByb2dfY250ICE9IDAsICJicGZfcHJvZ19xdWVyeSIsDQo+ID4gKwkJICAid3Jv
bmcgcHJvZ3JhbSBjb3VudCBvbiBxdWVyeTogJXUiLCBwcm9nX2NudCkpDQo+ID4gKwkJZ290byBv
dXQ7DQo+ID4gKw0KPiA+ICsJZXJyID0gYnBmX3Byb2dfYXR0YWNoKHZlcmRpY3RfZmQsIG1hcF9m
ZCwgYXR0YWNoX3R5cGUsIDApOw0KPiA+ICsJaWYgKENIRUNLKGVyciwgImJwZl9wcm9nX2F0dGFj
aCIsICJmYWlsZWRcbiIpKQ0KPiA+ICsJCWdvdG8gb3V0Ow0KPiA+ICsNCj4gPiArCXByb2dfY250
ID0gMTsNCj4gPiArCWVyciA9IGJwZl9wcm9nX3F1ZXJ5KG1hcF9mZCwgYXR0YWNoX3R5cGUsIDAg
LyogcXVlcnkgZmxhZ3MgKi8sDQo+ID4gKwkJCSAgICAgJmF0dGFjaF9mbGFncywgcHJvZ19pZHMs
ICZwcm9nX2NudCk7DQo+ID4gKw0KPiA+ICsJQ0hFQ0soZXJyLCAiYnBmX3Byb2dfcXVlcnkiLCAi
ZmFpbGVkXG4iKTsNCj4gPiArCUNIRUNLKGF0dGFjaF9mbGFncyAhPSAwLCAiYnBmX3Byb2dfcXVl
cnkgYXR0YWNoX2ZsYWdzIiwNCj4gPiArCSAgICAgICJ3cm9uZyBhdHRhY2hfZmxhZ3Mgb24gcXVl
cnk6ICV1IiwgYXR0YWNoX2ZsYWdzKTsNCj4gPiArCUNIRUNLKHByb2dfY250ICE9IDEsICJicGZf
cHJvZ19xdWVyeSBwcm9nX2NudCIsDQo+ID4gKwkgICAgICAid3JvbmcgcHJvZ3JhbSBjb3VudCBv
biBxdWVyeTogJXUiLCBwcm9nX2NudCk7DQo+ID4gKwlDSEVDSyhwcm9nX2lkc1swXSAhPSBxdWVy
eV9wcm9nX2lkKHZlcmRpY3RfZmQpLCAiYnBmX3Byb2dfcXVlcnkiLA0KPiA+ICsJICAgICAgIndy
b25nIHByb2dfaWRzIG9uIHF1ZXJ5OiAldSIsIHByb2dfaWRzWzBdKTsNCj4gWy4uLl0NCg==
