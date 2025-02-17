Return-Path: <bpf+bounces-51736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E985BA38350
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E61188A1C3
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B121B199;
	Mon, 17 Feb 2025 12:45:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A921771F
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796313; cv=none; b=nDp++kr2DG6lTDqVTGDr4WTasIiBb9ZAIyFlap2obydHvTL6udTECX1IWAhP2EY7cf9ncxIo67veWxNucITAT3DIEkHC5EP3Ga5npPXvuNuV29RsfPp4hJEz7Rhgvf35O9rolpMyJrRjWtWYNoAGohPBcoxyclz2wrxYTxYXJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796313; c=relaxed/simple;
	bh=eHbAzdtOLuAhywr3LkL4yqqA8ZTVMdcw5tfbEZaCu2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSqs+iTc5cxL4lPRCVtN0g99AOAvJ7I9XwOXrzHHFrZaLOA4ybjQTI4UPplj+kBqwNsBRCuxKX5cc0SENdKYTkW9q0+wizpSpxvtslA31NdsbRc0nbJIHBHtx+liR7j5ZlTC7MNt6tZR3C4SngdRQK7jro8ppBo+Q2lnz3pl/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YxMhq5p1Nz1ltZf;
	Mon, 17 Feb 2025 20:41:15 +0800 (CST)
Received: from kwepemh500014.china.huawei.com (unknown [7.202.181.147])
	by mail.maildlp.com (Postfix) with ESMTPS id EE4E91A016C;
	Mon, 17 Feb 2025 20:45:07 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (7.202.181.122) by
 kwepemh500014.china.huawei.com (7.202.181.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 20:45:07 +0800
Received: from kwepemh200013.china.huawei.com ([7.202.181.122]) by
 kwepemh200013.china.huawei.com ([7.202.181.122]) with mapi id 15.02.1544.011;
 Mon, 17 Feb 2025 20:45:07 +0800
From: "zhangxiaomeng (A)" <zhangxiaomeng13@huawei.com>
To: Hou Tao <houtao@huaweicloud.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggLW5leHQgMi81XSBicGY6IFJlbW92ZSBtYXBfcHVz?=
 =?utf-8?Q?h=5Felem_callbacks_with_-EOPNOTSUPP?=
Thread-Topic: [PATCH -next 2/5] bpf: Remove map_push_elem callbacks with
 -EOPNOTSUPP
Thread-Index: AQHbgOOKx9QXnFAlvUOKhAqWj3eU47NLca8Q
Date: Mon, 17 Feb 2025 12:45:07 +0000
Message-ID: <1eef746df21f4c5ab0743107b612bdfa@huawei.com>
References: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
 <20250217014122.65645-3-zhangxiaomeng13@huawei.com>
 <a501ad89-9832-21d4-ce9c-ebd5bfa37a79@huaweicloud.com>
In-Reply-To: <a501ad89-9832-21d4-ce9c-ebd5bfa37a79@huaweicloud.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQpBbHRob3VnaCB3aGVuIHRoZSBCUEYgcHJvZ3JhbSBpbnZva2VzIHRoZSBicGZfbWFwX3Bl
ZWtfZWxlbSBoZWxwZXIsIHRoZSB2ZXJpZmllciBpbnRlcmNlcHRzIGl0IGFuZCBlbnN1cmVzIHRo
YXQgdGhpcyBoZWxwZXIgaXMgb25seSBhdmFpbGFibGUgZm9yIHNwZWNpZmljIG1hcCB0eXBlcyB0
aHJvdWdoIGNoZWNrX21hcF9mdW5jX2NvbXBhdGliaWxpdHkoKSwgdGhlcmUgaXMgbm8gc3VjaCB2
ZXJpZmllciBpbnRlcmNlcHRpb24gd2hlbiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBmcm9tIHRo
ZSBzeXNjYWxsIHNpZGUuDQoNClRoZXJlZm9yZSwgaXQgaXMgbmVjZXNzYXJ5IHRvIGluY2x1ZGUg
YXBwcm9wcmlhdGUgY2hlY2tzIGluIHRoZSBzeXNjYWxsIGltcGxlbWVudGF0aW9uIHRvIGhhbmRs
ZSBjYXNlcyB3aGVyZSBtYXAtPm9wcy0+bWFwX3BlZWtfZWxlbSBtYXkgbm90IGJlIHN1cHBvcnRl
ZCBieSBjZXJ0YWluIG1hcCB0eXBlcy4gV2l0aG91dCB0aGVzZSBjaGVja3MsIGNhbGxpbmcgYnBm
X21hcF9wZWVrX2VsZW0gdGhyb3VnaCBzeXNjYWxscyBjb3VsZCBsZWFkIHRvIHVuZGVmaW5lZCBi
ZWhhdmlvciBvciBlcnJvcnMgaWYgdGhlIG1hcCBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgb3BlcmF0
aW9uLg0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEhvdSBUYW8gPGhvdXRh
b0BodWF3ZWljbG91ZC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDI15bm0MuaciDE35pelIDEwOjI4
DQrmlLbku7bkuro6IHpoYW5neGlhb21lbmcgKEEpIDx6aGFuZ3hpYW9tZW5nMTNAaHVhd2VpLmNv
bT47IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCuaKhOmAgTogQWxleGVpIFN0YXJvdm9pdG92IDxhc3RA
a2VybmVsLm9yZz47IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBBbmRy
aWkgTmFrcnlpa28gPGFuZHJpaUBrZXJuZWwub3JnPjsgTWFydGluIEthRmFpIExhdSA8bWFydGlu
LmxhdUBsaW51eC5kZXY+OyBFZHVhcmQgWmluZ2VybWFuIDxlZGR5ejg3QGdtYWlsLmNvbT47IFNv
bmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+OyBZb25naG9uZyBTb25nIDx5b25naG9uZy5zb25nQGxp
bnV4LmRldj47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+OyBLUCBT
aW5naCA8a3BzaW5naEBrZXJuZWwub3JnPjsgU3RhbmlzbGF2IEZvbWljaGV2IDxzZGZAZm9taWNo
ZXYubWU+OyBIYW8gTHVvIDxoYW9sdW9AZ29vZ2xlLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2Vy
bmVsLm9yZz4NCuS4u+mimDogUmU6IFtQQVRDSCAtbmV4dCAyLzVdIGJwZjogUmVtb3ZlIG1hcF9w
dXNoX2VsZW0gY2FsbGJhY2tzIHdpdGggLUVPUE5PVFNVUFANCg0KDQoNCk9uIDIvMTcvMjAyNSA5
OjQxIEFNLCBYaWFvbWVuZyBaaGFuZyB3cm90ZToNCj4gUmVtb3ZlIHJlZHVuZGFudCBtYXBfcHVz
aF9lbGVtIGNhbGxiYWNrcyB3aXRoIHJldHVybiAtRU9QTk9UU1VQUC4gV2UgDQo+IGNhbiBkaXJl
Y3RseSByZXR1cm4gLUVPUE5PVFNVUFAgd2hlbiBjYWxsaW5nIHRoZSB1bmltcGxlbWVudGVkIGNh
bGxiYWNrcy4NCj4NCj4NCj4gIEJQRl9DQUxMXzMoYnBmX21hcF9wdXNoX2VsZW0sIHN0cnVjdCBi
cGZfbWFwICosIG1hcCwgdm9pZCAqLCB2YWx1ZSwgDQo+IHU2NCwgZmxhZ3MpICB7DQo+IC0JcmV0
dXJuIG1hcC0+b3BzLT5tYXBfcHVzaF9lbGVtKG1hcCwgdmFsdWUsIGZsYWdzKTsNCj4gKwlpZiAo
bWFwLT5vcHMtPm1hcF9wdXNoX2VsZW0pDQo+ICsJCXJldHVybiBtYXAtPm9wcy0+bWFwX3B1c2hf
ZWxlbShtYXAsIHZhbHVlLCBmbGFncyk7DQo+ICsJZWxzZQ0KPiArCQlyZXR1cm4gLUVPUE5PVFNV
UFA7DQo+ICB9DQoNClNpbWlsYXIgd2l0aCB0aGUgcHJldmlvdXMgcGF0Y2gsIHRoZSBtb2RpZmlj
YXRpb25zIGluIGJvdGgNCmJwZl9tYXBfcHVzaF9lbGVtKCkgYW5kIGJwZl9tYXBfdXBkYXRlX3Zh
bHUoKSBhcmUgdW5uZWNlc3NhcnkuDQo+ICANCj4gIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90
byBicGZfbWFwX3B1c2hfZWxlbV9wcm90byA9IHsgZGlmZiAtLWdpdCANCj4gYS9rZXJuZWwvYnBm
L3N5c2NhbGwuYyBiL2tlcm5lbC9icGYvc3lzY2FsbC5jIGluZGV4IA0KPiBlNmU4NTlmNzFjNWQu
Ljc5YTExOGVhOTI3MCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2JwZi9zeXNjYWxsLmMNCj4gKysr
IGIva2VybmVsL2JwZi9zeXNjYWxsLmMNCj4gQEAgLTI4MSw3ICsyODEsMTAgQEAgc3RhdGljIGlu
dCBicGZfbWFwX3VwZGF0ZV92YWx1ZShzdHJ1Y3QgYnBmX21hcCAqbWFwLCBzdHJ1Y3QgZmlsZSAq
bWFwX2ZpbGUsDQo+ICAJfSBlbHNlIGlmIChtYXAtPm1hcF90eXBlID09IEJQRl9NQVBfVFlQRV9R
VUVVRSB8fA0KPiAgCQkgICBtYXAtPm1hcF90eXBlID09IEJQRl9NQVBfVFlQRV9TVEFDSyB8fA0K
PiAgCQkgICBtYXAtPm1hcF90eXBlID09IEJQRl9NQVBfVFlQRV9CTE9PTV9GSUxURVIpIHsNCj4g
LQkJZXJyID0gbWFwLT5vcHMtPm1hcF9wdXNoX2VsZW0obWFwLCB2YWx1ZSwgZmxhZ3MpOw0KPiAr
CQlpZiAobWFwLT5vcHMtPm1hcF9wdXNoX2VsZW0pDQo+ICsJCQllcnIgPSBtYXAtPm9wcy0+bWFw
X3B1c2hfZWxlbShtYXAsIHZhbHVlLCBmbGFncyk7DQo+ICsJCWVsc2UNCj4gKwkJCWVyciA9IC1F
T1BOT1RTVVBQOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWVyciA9IGJwZl9vYmpfcGluX3VwdHJzKG1h
cC0+cmVjb3JkLCB2YWx1ZSk7DQo+ICAJCWlmICghZXJyKSB7DQoNCg==

