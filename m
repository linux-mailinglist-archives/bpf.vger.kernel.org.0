Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C221436F56
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 03:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJVBYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 21:24:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVBYJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 21:24:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hb5zw1DBGzbhJv;
        Fri, 22 Oct 2021 09:17:16 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 09:21:50 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 09:21:50 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Fri, 22 Oct 2021 09:21:50 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGJwZjogc3VwcG9ydCBCUEZfUFJPR19RVUVSWSBm?=
 =?utf-8?Q?or_progs_attached_to_sockmap?=
Thread-Topic: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to
 sockmap
Thread-Index: AQHXxOkchxQzV9/PNEig//CNsgG3kavdqaYAgACSU+A=
Date:   Fri, 22 Oct 2021 01:21:50 +0000
Message-ID: <41d41a6026e243bca11ccfefb50b11c0@huawei.com>
References: <20211019125856.2566882-1-zhudi2@huawei.com>
 <CAADnVQ+MLy8Ub8FL4ak92Wh+LqUg5npfHc_u3bgDqk-U7LB3Ww@mail.gmail.com>
In-Reply-To: <CAADnVQ+MLy8Ub8FL4ak92Wh+LqUg5npfHc_u3bgDqk-U7LB3Ww@mail.gmail.com>
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

U29ycnksIGl0J3MgbXkgY2FyZWxlc3NuZXNzLiBJJ2xsIGFkYXB0IGl0IG9uIHRoZSBsYXRlc3Qg
a2VybmVsLg0KDQpUaGFua3MuDQoNCj4gT24gVHVlLCBPY3QgMTksIDIwMjEgYXQgNTo1OSBBTSBE
aSBaaHUgPHpodWRpMkBodWF3ZWkuY29tPiB3cm90ZToNCj4gPiArICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19CUEZfU1RSRUFNX1BBUlNFUikNCj4gPiAr
ICAgICAgIGNhc2UgQlBGX1NLX1NLQl9TVFJFQU1fUEFSU0VSOg0KPiA+ICsgICAgICAgICAgICAg
ICAqcHJvZyA9IFJFQURfT05DRShwcm9ncy0+c2tiX3BhcnNlcik7DQo+IA0KPiBza2JfcGFyc2Vy
Pw0KPiBQbGVhc2UgZG9uJ3Qgc3VibWl0IHBhdGNoZXMgdGhhdCBkb24ndCBldmVuIGJ1aWxkLg0K
