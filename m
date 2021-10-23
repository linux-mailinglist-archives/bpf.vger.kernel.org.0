Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8693438202
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 08:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJWGEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 02:04:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14850 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWGEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 02:04:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hbr7r6JCKz90Gb;
        Sat, 23 Oct 2021 13:56:40 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 23 Oct 2021 14:01:39 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 23 Oct 2021 14:01:39 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Sat, 23 Oct 2021 14:01:39 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Thread-Topic: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to
 sockmap
Thread-Index: AdfH02/3xD3qSmbceUSsxel0wkFHzA==
Date:   Sat, 23 Oct 2021 06:01:39 +0000
Message-ID: <53eeb3e084bc4f7b8120516dd87d0517@huawei.com>
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

PiBEaSBaaHUgd3JvdGU6DQo+ID4gUmlnaHQgbm93IHRoZXJlIGlzIG5vIHdheSB0byBxdWVyeSB3
aGV0aGVyIEJQRiBwcm9ncmFtcyBhcmUNCj4gPiBhdHRhY2hlZCB0byBhIHNvY2ttYXAgb3Igbm90
Lg0KPiA+DQo+ID4gd2UgY2FuIHVzZSB0aGUgc3RhbmRhcmQgaW50ZXJmYWNlIGluIGxpYmJwZiB0
byBxdWVyeSwgc3VjaCBhczoNCj4gPiBicGZfcHJvZ19xdWVyeShtYXBGZCwgQlBGX1NLX1NLQl9T
VFJFQU1fUEFSU0VSLCAwLCBOVUxMLCAuLi4pOw0KPiA+IHRoZSBtYXBGZCBpcyB0aGUgZmQgb2Yg
c29ja21hcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERpIFpodSA8emh1ZGkyQGh1YXdlaS5j
b20+DQo+ID4gLS0tDQo+IA0KPiBMR1RNLCBsZXRzIGFkZCBhIHNtYWxsIHRlc3QgaGVyZSBhcyB3
ZWxsDQo+IA0KPiAgIC4vdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvc29j
a21hcF9iYXNpYy5jDQo+IA0KPiBMb29rcyBsaWtlIHdlIGNhbiBqdXN0IGNvcHkgdGhlIHNrX2xv
b2t1cC5jIHRlc3QgY2FzZSB3aGljaCBkb2VzDQo+IHRoZSBxdWVyeSB0ZXN0cyBmb3IgQlBGX1NL
X0xPT0tVUC4NCg0KIFRoYW5rcyBmb3IgeW91ciBhZHZpY2UsIEkgd2lsbCBhZGQgaXQgaW4gbXkg
cGF0Y2guDQoNCj4gQWxzbyBJIGRvbid0IHRoaW5rIGl0cyByZXF1aXJlZCBmb3IgdGhpcyBzZXJp
ZXMsIGJ1dCBhIGJwZnRvb2wNCj4gcGF0Y2ggdG8gcXVlcnkgaXQgd291bGQgYmUgdXNlZnVsIGFz
IHdlbGwgaWYgaXRzIGRvZXNuJ3QganVzdA0KPiB3b3JrIHdpdGggYWJvdmUuDQo+IA0KPiBUaGFu
a3MhDQo+IEpvaG4NCg==
