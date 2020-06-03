Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFD1EC883
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 06:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFCEvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 00:51:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCEvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 00:51:38 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id CD7BA67876921A873E0A;
        Wed,  3 Jun 2020 12:51:35 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 3 Jun 2020 12:51:35 +0800
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 dggema755-chm.china.huawei.com (10.1.198.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 12:51:35 +0800
Received: from dggema758-chm.china.huawei.com ([10.9.48.193]) by
 dggema758-chm.china.huawei.com ([10.9.48.193]) with mapi id 15.01.1913.007;
 Wed, 3 Jun 2020 12:51:35 +0800
From:   "zhujianwei (C)" <zhujianwei7@huawei.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        =?utf-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
        <zbyszek@in.waw.pl>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogbmV3IHNlY2NvbXAgbW9kZSBhaW1z?=
 =?utf-8?Q?_to_improve_performance?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IG5ldyBzZWNjb21wIG1vZGUgYWltcyB0byBpbXBy?=
 =?utf-8?Q?ove_performance?=
Thread-Index: AdY1q17j91IY6CMiRsq40mFg/pmPz///wxIAgAAHIgCAADc1gP/7503AgAfEWYD//fXnAIADmuoA//74EOD//e1ysP/75+mA//aekTA=
Date:   Wed, 3 Jun 2020 04:51:35 +0000
Message-ID: <8fb6782a829a4d79b73c189756086630@huawei.com>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook> <202005291043.A63D910A8@keescook>
 <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
 <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
 <7dacac003a9949ea8163fca5125a2cae@huawei.com>
 <20200602032446.7sn2fmzsea2v2wbs@ast-mbp.dhcp.thefacebook.com>
 <07ce4c1273054955a350e67f2dc35812@huawei.com>
 <202006021111.947830EC@keescook>
In-Reply-To: <202006021111.947830EC@keescook>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.166.215.96]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBHaXZlbiB0aGF0IHlvdSdyZSBzdGlsbCBkb2luZyB0aGlzIGluIHN5c2NhbGxfdHJhY2VfZW50
ZXIoKSwgSSBpbWFnaW5lDQo+IGl0IGNvdWxkIGxpdmUgaW4gc2VjdXJlX2NvbXB1dGluZygpLg0K
DQpJbmRlZWQsIFdlIGFncmVlIHdpdGggdGhhdCBhZGRpbmcgbGlnaHRfc3lzY2FsbF9maWx0ZXIg
aW4gc2VjY29tcF9jb21wdXRpbmcoKS4gDQoNCj4gSSB3b25kZXIgaWYgYWFyY2g2NCBoYXMgaGln
aGVyIG92ZXJoZWFkIGZvciBjYWxsaW5nIGludG8gdGhlIFRJRl9XT1JLDQo+IHRyYWNlIHN0dWZm
PyAoT3IgaWYgYWFyY2g2NCdzIEJQRiBKSVQgaXMgbm90IGFzIGVmZmljaWVudCBhcyB4ODY/KQ0K
DQpXZSBhbHNvIGd1ZXNzIHRoYXQgdGhlcmUgYXJlIG1hbnkgcG9zc2libGUgcmVhc29ucy4NCkFu
ZCB3ZSB0aGluayB0aGF0IHBsYWNpbmcgdGhlIGJpdG1hcCBmaWx0ZXIgdGhlIGZ1cnRoZXIgZm9y
d2FyZCB0aGUgYmV0dGVyLiBPdXIgdGVzdCByZXN1bHRzIHNob3cgdGhhdCBwbGFjaW5nIHRoZSBi
aXRtYXAgZmlsdGVyIGZvcndhcmQgY2FuIHNvbHZlIHNpbmdsZSBmaWx0ZXIgdG90YWwgb3Zlcmhl
YWQuIFdoYXQgaXMgeW91ciBvcGluaW9uIGFib3V0IHRoYXQ/DQoNCj4gQW55d2F5LCB0aGUgZnVu
Y3Rpb25hbGl0eSBoZXJlIGlzIHNpbWlsYXIgdG8gd2hhdCBJJ3ZlIGJlZW4gd29ya2luZw0KPiBv
biBmb3IgYml0bWFwcyAoaGF2aW5nIGEgZ2xvYmFsIHByZWFsbG9jYXRlZCBiaXRtYXAgaXNuJ3Qg
Z29pbmcgdG8gYmUNCj4gdXBzdHJlYW1hYmxlLCBidXQgaXQncyBnb29kIGZvciBQb0MpLiBUaGUg
Y29tcGxpY2F0aW9ucyBhcmUgd2l0aCBoYW5kbGluZw0KPiBkaWZmZXJpbmcgYXJjaGl0ZWN0dXJl
IChmb3IgY29tcGF0IHN5c3RlbXMpLCB0cmFja2luZy9jaG9vc2luZyBiZXR3ZWVuDQo+IHRoZSB2
YXJpb3VzIGJhc2ljIFNFQ0NPTVBfUkVUXyogYmVoYXZpb3JzLCBldGMuDQoNCkZpcnN0bHksIHRo
YW5rIHlvdSBmb3IgY29ycmVjdGlvbiBpbiBjb2RlLCB5ZXMsIGl0IGlzIGp1c3QgYSBQb0MgZm9y
IHBlcmZvcm1hbmNlIHRlc3QuDQpJbmRlZWQsIHlvdXIgYml0bWFwIGlkZWEgaXMgYmFzaWNseSBz
YW1lIHdpdGggdXMuIEFuZCwgd2UgYXJlIHRyeWluZyB0byBmaW5kIGEgc29sdXRpb24gdG8gaW1w
cm92ZSB0aGUgc2VjY29tcCBwZXJmb3JtYW5jZSBmb3IgcHJvZHVjdCB1c2UuIA0KU28gV2hhdCBp
cyB5b3VyIHBsYW4gdG8gaGF2ZSBpdCBkb25lPyANCkNvdWxkIHdlIGRvIHNvbWV0aGluZyB0byBo
ZWxwIHlvdSBwcm9jZWVkIGl0Pw0K
