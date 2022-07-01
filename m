Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039D562C5B
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiGAHKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 03:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiGAHKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 03:10:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FE677E8
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 00:10:39 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZ5rW2Jthz6H6n8
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 15:08:11 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 09:10:37 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Fri, 1 Jul 2022 09:10:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Hao Luo <haoluo@google.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: libbfd feature autodetection
Thread-Topic: libbfd feature autodetection
Thread-Index: AdiMh7mzfuc144+UTkqQSD6Zj1VxZgADnL6AACCveYA=
Date:   Fri, 1 Jul 2022 07:10:36 +0000
Message-ID: <6f501b451d4a4f3882ee9aa662964310@huawei.com>
References: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
 <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
In-Reply-To: <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBGcm9tOiBIYW8gTHVvIFttYWlsdG86aGFvbHVvQGdvb2dsZS5jb21dDQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDMwLCAyMDIyIDc6MjkgUE0NCj4gSGkgUm9iZXJ0bywNCj4gDQo+IE9uIFRodSwg
SnVuIDMwLCAyMDIyIGF0IDY6NTUgQU0gUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3
ZWkuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIGV2ZXJ5b25lDQo+ID4NCj4gPiBJJ20gdGVz
dGluZyBhIG1vZGlmaWVkIHZlcnNpb24gb2YgYnBmdG9vbCB3aXRoIHRoZSBDSS4NCj4gPg0KPiA+
IFVuZm9ydHVuYXRlbHksIGl0IGRvZXMgbm90IHdvcmsgZHVlIHRvIGF1dG9kZXRlY3Rpb24NCj4g
PiBvZiBsaWJiZmQgaW4gdGhlIGJ1aWxkIGVudmlyb25tZW50LCBidXQgbm90IGluIHRoZSB2aXJ0
dWFsDQo+ID4gbWFjaGluZSB0aGF0IGFjdHVhbGx5IGV4ZWN1dGVzIHRoZSB0ZXN0cy4NCj4gPg0K
PiA+IFdoYXQgdGhlIHByb3BlciBzb2x1dGlvbiBzaG91bGQgYmU/DQo+IA0KPiBDYW4geW91IGVs
YWJvcmF0ZSBieSBub3Qgd29ya2luZz8gZG8geW91IG1lYW4gYnBmdG9vbCBkb2Vzbid0IGJ1aWxk
Pw0KPiBvciBicGZ0b29sIGJ1aWxkcywgYnV0IGRvZXNuJ3QgYmVoYXZlIGFzIHlvdSBleHBlY3Qg
d2hlbiBpdCBydW5zLiBPbg0KPiBteSBzaWRlLCB3aGVuIEkgYnVpbHQgYnBmdG9vbCwgbGliYmZk
IHdhcyBub3QgZGV0ZWN0ZWQsIGJ1dCBJIGNhbg0KPiBzdGlsbCBicGZ0b29sIHN1Y2Nlc3NmdWxs
eS4NCg0KSGkgSGFvDQoNCmluIEdpdGh1YiBBY3Rpb25zLCB0aGUgYnVpbGQgZW52aXJvbm1lbnQg
aGFzIHN1cHBvcnQgZm9yDQpsaWJiZmQuIFdoZW4gYnBmdG9vbCBpcyBjb21waWxlZCwgbGliYmZk
IGlzIGxpbmtlZCB0byBpdC4NCg0KSG93ZXZlciwgdGhlIHJ1bi10aW1lIGVudmlyb25tZW50IGlz
IGRpZmZlcmVudCwgaXMgYW4gYWQgaG9jDQppbWFnZSBtYWRlIGJ5IHRoZSBlQlBGIG1haW50YWlu
ZXJzLCB3aGljaCBkb2VzIG5vdCBoYXZlDQpsaWJiZmQuDQoNCldoZW4gYSB0ZXN0IGV4ZWN1dGVz
IGJwZnRvb2wsIEkgZ2V0IHRoZSBmb2xsb3dpbmcgbWVzc2FnZToNCg0KMjAyMi0wNi0yOFQxNjox
NToxNC44NTQ4NDMyWiAuL2JwZnRvb2xfbm9ib290c3RyYXA6IGVycm9yIHdoaWxlIGxvYWRpbmcg
c2hhcmVkIGxpYnJhcmllczogbGliYmZkLTIuMzQtc3lzdGVtLnNvOiBjYW5ub3Qgb3BlbiBzaGFy
ZWQgb2JqZWN0IGZpbGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCg0KSSBzb2x2ZWQgd2l0
aCB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2Vm
aWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlDQppbmRleCBlMzJhMjhm
ZThiYzEuLmQ0NGY0ZDM0ZjA0NiAxMDA2NDQNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9NYWtlZmlsZQ0KKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxl
DQpAQCAtMjQyLDcgKzI0Miw5IEBAICQoREVGQVVMVF9CUEZUT09MKTogJCh3aWxkY2FyZCAkKEJQ
RlRPT0xESVIpLyouW2NoXSAkKEJQRlRPT0xESVIpL01ha2VmaWxlKSAgICBcDQogCQkgICAgT1VU
UFVUPSQoSE9TVF9CVUlMRF9ESVIpL2JwZnRvb2wvCQkJICAgICAgIFwNCiAJCSAgICBMSUJCUEZf
T1VUUFVUPSQoSE9TVF9CVUlMRF9ESVIpL2xpYmJwZi8JCSAgICAgICBcDQogCQkgICAgTElCQlBG
X0RFU1RESVI9JChIT1NUX1NDUkFUQ0hfRElSKS8JCQkgICAgICAgXA0KLQkJICAgIHByZWZpeD0g
REVTVERJUj0kKEhPU1RfU0NSQVRDSF9ESVIpLyBpbnN0YWxsLWJpbg0KKwkJICAgIHByZWZpeD0g
REVTVERJUj0kKEhPU1RfU0NSQVRDSF9ESVIpLyBpbnN0YWxsLWJpbgkgICAgICAgXA0KKwkJICAg
IEZFQVRVUkVfVEVTVFM9J2Rpc2Fzc2VtYmxlci1mb3VyLWFyZ3MgemxpYiBsaWJjYXAgY2xhbmct
YnBmLWNvLXJlJwlcDQorCQkgICAgRkVBVFVSRV9ESVNQTEFZPSdkaXNhc3NlbWJsZXItZm91ci1h
cmdzIHpsaWIgbGliY2FwIGNsYW5nLWJwZi1jby1yZScNCg0KYnV0IEknbSBub3Qgc3VyZSBpdCBp
cyB0aGUgcmlnaHQgYXBwcm9hY2guDQoNClRoYW5rcw0KDQpSb2JlcnRvDQo=
