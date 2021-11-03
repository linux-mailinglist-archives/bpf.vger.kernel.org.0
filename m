Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC7443B56
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 03:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKCC1x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 22:27:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30907 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCC1x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 22:27:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkVqM37Dczcb3Q;
        Wed,  3 Nov 2021 10:20:31 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 10:25:15 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 10:25:15 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Wed, 3 Nov 2021 10:25:15 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Topic: [PATCH bpf-next v4 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Index: AdfQWgMDvyYgLEBsV02Bu8t6VBuCgQ==
Date:   Wed, 3 Nov 2021 02:25:15 +0000
Message-ID: <9ed289892e1448c69f58f0268c395167@huawei.com>
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

PiBPbiBUdWUsIE5vdiAyLCAyMDIxIGF0IDE6MTEgUE0gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNv
bT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gLXN0YXRpYyBpbnQgc29ja19tYXBfcHJvZ191cGRhdGUo
c3RydWN0IGJwZl9tYXAgKm1hcCwgc3RydWN0IGJwZl9wcm9nDQo+ICpwcm9nLA0KPiA+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJwZl9wcm9nICpvbGQsIHUzMiB3aGlj
aCkNCj4gPiA+ICtzdGF0aWMgaW50IHNvY2tfbWFwX3Byb2dfbG9va3VwKHN0cnVjdCBicGZfbWFw
ICptYXAsIHN0cnVjdCBicGZfcHJvZw0KPiAqKnBwcm9nW10sDQo+ID4NCj4gPiBDYW4gd2UganVz
dCBjaGFuZ2UgIioqcHByb2dbXSIgdG8gIioqKnBwcm9nIj8gSW4gdGhlIGNvZGUsIHlvdSByZWFs
bHkNCj4gPiBqdXN0IHBhc3MgdGhlIGFkZHJlc3Mgb2YgdGhlIGRlY2wgInN0cnVjdCBicGZfcHJv
ZyAqKnBwcm9nOyIgdG8gdGhlDQo+ID4gZnVuY3Rpb24uDQo+IA0KPiBEaSwNCj4gDQo+IHRoaXMg
ZmVlZGJhY2sgd2FzIGdpdmVuIHR3aWNlIGFscmVhZHkuDQo+IFlvdSBhbHNvIGRpZG4ndCBhZGRy
ZXNzIHNldmVyYWwgb3RoZXIgcG9pbnRzIGZyb20gdGhlIGVhcmxpZXIgcmV2aWV3cy4NCj4gUGxl
YXNlIGRvIG5vdCByZXN1Ym1pdCB1bnRpbCB5b3UgYWRkcmVzcyBhbGwgcG9pbnRzLg0KDQpNYXli
ZSBpIG1pc3Mgc29tZXRoaW5nLi4uDQpJIHdpbGwgcmVjaGVjayB0aGUgcmV2aWV3IGNvbW1lbnRz
Lg0K
