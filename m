Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB358678E
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiHAKda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 06:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHAKda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 06:33:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE810A8
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 03:33:28 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LxDrK2smlz687Z8;
        Mon,  1 Aug 2022 18:29:21 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 12:33:24 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Mon, 1 Aug 2022 12:33:24 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "jevburton.kernel@gmail.com" <jevburton.kernel@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
Thread-Topic: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
Thread-Index: AQHYne8hPBc0wtMTI0aMw6b0/5e6fq2Kiw4AgAQjoRCABuuxgIAETdng
Date:   Mon, 1 Aug 2022 10:33:24 +0000
Message-ID: <d3b9f2e1cb4a4fb5b5e47ea45df4be5c@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-3-roberto.sassu@huawei.com>
 <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
 <5c5cdf397a6e4523845d0a16117e3b81@huawei.com>
 <CAEf4BzYmomMAEEQYH+fGQeH-_+4oxsFYc+qbZyf1DgF1E_CuSw@mail.gmail.com>
In-Reply-To: <CAEf4BzYmomMAEEQYH+fGQeH-_+4oxsFYc+qbZyf1DgF1E_CuSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.205.114]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gW21haWx0bzphbmRyaWkubmFrcnlpa29AZ21haWwuY29t
XQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjksIDIwMjIgODo0OSBQTQ0KPiBPbiBNb24sIEp1bCAy
NSwgMjAyMiBhdCAxMjoxMCBBTSBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgW21haWx0
bzphbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tXQ0KPiA+ID4gU2VudDogRnJpZGF5LCBKdWx5
IDIyLCAyMDIyIDc6NTUgUE0NCj4gPiA+IE9uIEZyaSwgSnVsIDIyLCAyMDIyIGF0IDA3OjE4OjIz
UE0gKzAyMDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gPiA+IFRoZSBicGYoKSBzeXN0ZW0g
Y2FsbCB2YWxpZGF0ZXMgdGhlIGJwZl9hdHRyIHN0cnVjdHVyZSByZWNlaXZlZCBhcw0KPiA+ID4g
PiBhcmd1bWVudCwgYW5kIGNvbnNpZGVycyBkYXRhIHVudGlsIHRoZSBsYXN0IGZpZWxkLCBkZWZp
bmVkIGZvciBlYWNoDQo+ID4gPiA+IG9wZXJhdGlvbi4gVGhlIHJlbWFpbmcgc3BhY2UgbXVzdCBi
ZSBmaWxsZWQgd2l0aCB6ZXJvcy4NCj4gPiA+ID4NCj4gPiA+ID4gQ3VycmVudGx5LCBmb3IgYnBm
XypfZ2V0X2ZkX2J5X2lkKCkgZnVuY3Rpb25zIGV4Y2VwdA0KPiBicGZfbWFwX2dldF9mZF9ieV9p
ZCgpDQo+ID4gPiA+IHRoZSBsYXN0IGZpZWxkIGlzICpfaWQuIFNldHRpbmcgb3Blbl9mbGFncyB0
byBCUEZfRl9SRE9OTFkgZnJvbSB1c2VyIHNwYWNlDQo+ID4gPiA+IHdpbGwgcmVzdWx0IGluIGJw
ZigpIHJlamVjdGluZyB0aGUgYXJndW1lbnQuDQo+ID4gPg0KPiA+ID4gVGhlIGtlcm5lbCBpcyBk
b2luZyB0aGUgcmlnaHQgdGhpbmcuIEl0IHNob3VsZCBub3QgaWdub3JlIGZpZWxkcy4NCj4gPg0K
PiA+IEV4YWN0bHkuIEFzIEFuZHJpaSByZXF1ZXN0ZWQgdG8gYWRkIG9wdHMgdG8gYWxsIGJwZl8q
X2dldF9mZF9ieV9pZCgpDQo+ID4gZnVuY3Rpb25zLCB0aGUgbGFzdCBmaWVsZCBpbiB0aGUga2Vy
bmVsIG5lZWRzIHRvIGJlIHVwZGF0ZWQgYWNjb3JkaW5nbHkuDQo+ID4NCj4gDQo+IEl0J3MgYmVl
biBhIHdoaWxlIGFnbyBzbyBkZXRhaWxzIGFyZSBoYXp5LiBCdXQgdGhlIGlkZWEgd2FzIHRoYXQg
aWYgd2UNCj4gYWRkIF9vcHRzIHZhcmlhbnQgZm9yIGJwZl9tYXBfZ2V0X2ZkX2J5X2lkKCkgZm9y
IGludGVyZmFjZSBjb25zaXN0ZW5jeQ0KPiBhbGwgdGhlIG90aGVyIGJwZl8qX2dldF9mZF9ieV9p
ZCgpIHByb2JhYmx5IHNob3VsZCBnZXQgX29wdHMgdmFyaWFudA0KPiBhbmQgdXNlIHRoZSBzYW1l
IG9wdHMgc3RydWN0LiBSaWdodCBub3cga2VybmVsIGRvZXNuJ3Qgc3VwcG9ydA0KPiBzcGVjaWZ5
aW5nIGZsYWdzIGZvciBub24tbWFwcyBhbmQgdGhhdCdzIGZpbmUuIEkgYWdyZWUgd2l0aCBBbGV4
ZWkNCj4gdGhhdCBrZXJuZWwgc2hvdWxkbid0IGp1c3QgaWdub3JlIHVucmVjb2duaXplZCBmaWVs
ZCBzaWxlbnRseS4NCj4gDQo+IEkgdGhpbmsgd2Ugc3RpbGwgY2FuIGFkZCBfb3B0cygpIGZvciBh
bGwgQVBJcywgYnV0IHVzZXIgd2lsbCBuZWVkIHRvDQo+IGtub3cgdGhhdCBub24tbWFwIHZhcmlh
bnRzIGV4cGVjdCAwIGFzIGZsYWdzLiBGb3Igbm93LiBJZiB3ZQ0KPiBldmVudHVhbGx5IGFkZCBh
YmlsaXR5IHRvIHNwZWNpZnkgZmxhZ3MgZm9yLCBzYXksIGxpbmtzLCB0aGVuIGV4aXN0aW5nDQo+
IEFQSSB3aWxsIGp1c3Qgd29yay4gT25lIGNhbiBzZWUgaG93IHRoaXMgZ2V0X2ZkX2J5X2lkKCkg
Y2FuIHVzZQ0KPiByZWFkLW9ubHkgZmxhZ3MgdG8gcmV0dXJuIEZEcyB0aGF0IG9ubHkgc3VwcG9y
dCByZWFkLW9ubHkgb3BlcmF0aW9ucw0KPiBvbiBvYmplY3RzIChlLmcuLCBmZXRjaGluZyBsaW5r
IGluZm8gZm9yIGxpbmtzLCBkdW1waW5nIHByb2cNCj4gaW5zdHJ1Y3Rpb25zIGZvciBwcm9ncmFt
cyksIGJ1dCBub3QgbW9kaWZpY2F0aW9uIG9wZXJhdGlvbnMgKGUuZy4sDQo+IHVwZGF0aW5nIHBy
b2cgZm9yIGxpbmtzLCBvciB3aGF0ZXZlciB3cml0ZSBvcGVyYXRpb24gY291bGQgYmUgZm9yDQo+
IHByb2dyYW1zKS4NCj4gDQo+IFNvIEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgY29udHJhZGljdGlv
biBoZXJlLiBXZSBtaWdodCBjaG9vc2UgdG8gYWRkDQo+IGJwZl9tYXBfZ2V0X2ZkX2J5X2lkX29w
dHMoKSBvbmx5LCBidXQgd2UgcHJvYmFibHkgc3RpbGwgc2hvdWxkIHVzZQ0KPiBjb21tb24gc3Ry
dWN0IG5hbWUgYXMgaWYgYWxsIGJwZl8qX2dldF9mZF9ieV9pZF9vcHRzKCkgZXhpc3QuDQoNCk9r
LCB1bmRlcnN0b29kLg0KDQpUaGFua3MNCg0KUm9iZXJ0bw0K
