Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3D438200
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 08:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhJWGHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 02:07:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13971 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWGHq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 02:07:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HbrHm5lr5zZcMD;
        Sat, 23 Oct 2021 14:03:32 +0800 (CST)
Received: from dggpeml100009.china.huawei.com (7.185.36.95) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 23 Oct 2021 14:05:23 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml100009.china.huawei.com (7.185.36.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 23 Oct 2021 14:05:22 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Sat, 23 Oct 2021 14:05:22 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Thread-Topic: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to
 sockmap
Thread-Index: AdfH0/TDAfHp1aB0QGa6f+j4ePyoWg==
Date:   Sat, 23 Oct 2021 06:05:22 +0000
Message-ID: <dc528a28011c47d1896950f19b3f0fdb@huawei.com>
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

PiBPbiBGcmksIE9jdCAyMiwgMjAyMSBhdCAzOjM0IEFNIERpIFpodSA8emh1ZGkyQGh1YXdlaS5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gUmlnaHQgbm93IHRoZXJlIGlzIG5vIHdheSB0byBxdWVyeSB3
aGV0aGVyIEJQRiBwcm9ncmFtcyBhcmUNCj4gPiBhdHRhY2hlZCB0byBhIHNvY2ttYXAgb3Igbm90
Lg0KPiA+DQo+ID4gd2UgY2FuIHVzZSB0aGUgc3RhbmRhcmQgaW50ZXJmYWNlIGluIGxpYmJwZiB0
byBxdWVyeSwgc3VjaCBhczoNCj4gPiBicGZfcHJvZ19xdWVyeShtYXBGZCwgQlBGX1NLX1NLQl9T
VFJFQU1fUEFSU0VSLCAwLCBOVUxMLCAuLi4pOw0KPiA+IHRoZSBtYXBGZCBpcyB0aGUgZmQgb2Yg
c29ja21hcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERpIFpodSA8emh1ZGkyQGh1YXdlaS5j
b20+DQo+IA0KPiBUaGUgZmVhdHVyZSBsb29rcyBmaW5lLCBidXQgaXQgbmVlZHMgYSBzZWxmdGVz
dC4NCg0KSSB3aWxsIGFkZCBpdCBpbiBteSBwYXRjaCwgdGhhbmtzDQo=
