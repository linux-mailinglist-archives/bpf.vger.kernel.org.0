Return-Path: <bpf+bounces-75857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E8C9A085
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 05:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55EA04E23AE
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 04:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6182D2F5A3F;
	Tue,  2 Dec 2025 04:49:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C615B2DE1F0
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 04:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650985; cv=none; b=AeEqf9wZwzwLKwmWU6ePLt6TbQ9t4QzgXnQfGH7Wg9XD81v0P1haF8wSCkV8k0qMa96HbcPGWITpHS08frIqDaHbO77IU2uNN+fTmCEQK6kCCD1s8FwCyf+jEuDWiBDP8TXz6et9iYmaiYaa1q22zJIGHyH4yCfcaRMlwTcJ0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650985; c=relaxed/simple;
	bh=S3Cqu/zaIGTleGUb52Ki3cfLz+xwFe3h6iL1CInn+dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=oaq2PRytOlwsskZYQZLJykMA+LuzVmemFIbGUD6/j9/5fKw1qVXWg+QYlTkfgR6ILQ3FZOk6x62SoN0VMUbqNuXmIPrG8IIptxPdZ2Lj0anDrtKQEp0HrchFknSUKoQJ8IMQBZAW0o8EGbzKp/uec5iODDpze9X0yjN3lJ6pFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from kaiyanm$hust.edu.cn ( [10.12.190.56] ) by ajax-webmail-app1
 (Coremail) ; Tue, 2 Dec 2025 12:48:43 +0800 (GMT+08:00)
Date: Tue, 2 Dec 2025 12:48:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
To: "martin kafai lau" <martin.lau@linux.dev>
Cc: "stanislav fomichev" <sdf@fomichev.me>, daniel@iogearbox.net, 
	hust-os-kernel-patches@googlegroups.com, dddddd@hust.edu.cn, 
	dzm91@hust.edu.cn, ast@kernel.org, bpf@vger.kernel.org
Subject: Re: Re: bpf: Race condition in bpf_trampoline_unlink_cgroup_shim
 during concurrent cgroup LSM link release
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2025 www.mailtech.cn hust
In-Reply-To: <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
References: <3c4ebb0b.46ff8.19abab8abe2.Coremail.kaiyanm@hust.edu.cn>
 <dd71a6ff-929d-4958-ac73-99b4852808e4@linux.dev>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49eaf903.4c28b.19add6435cf.Coremail.kaiyanm@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:HgEQrADXCcqrby5pMLygBg--.7629W
X-CM-SenderInfo: bpsqjkixssiio6kx23oohg3hdfq/1tbiAQkEAmkuaDMBKQAAs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTWFydGluIEthRmFpIExh
dSIgPG1hcnRpbi5sYXVAbGludXguZGV2Pgo+IOWPkemAgeaXtumXtDogMjAyNS0xMi0wMiAwNDoy
MTo1NyAo5pif5pyf5LqMKQo+IOaUtuS7tuS6ujogIuaiheW8gOW9piIgPGthaXlhbm1AaHVzdC5l
ZHUuY24+LCAiU3RhbmlzbGF2IEZvbWljaGV2IiA8c2RmQGZvbWljaGV2Lm1lPgo+IOaKhOmAgTog
ZGFuaWVsQGlvZ2VhcmJveC5uZXQsIGh1c3Qtb3Mta2VybmVsLXBhdGNoZXNAZ29vZ2xlZ3JvdXBz
LmNvbSwgZGRkZGRkQGh1c3QuZWR1LmNuLCBkem05MUBodXN0LmVkdS5jbiwgYXN0QGtlcm5lbC5v
cmcsIGJwZkB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFJlOiBicGY6IFJhY2UgY29uZGl0aW9u
IGluIGJwZl90cmFtcG9saW5lX3VubGlua19jZ3JvdXBfc2hpbSBkdXJpbmcgY29uY3VycmVudCBj
Z3JvdXAgTFNNIGxpbmsgcmVsZWFzZQo+IAo+IE9uIDExLzI1LzI1IDM6MTQgQU0sIOaiheW8gOW9
piB3cm90ZToKPiA+IE91ciBmdXp6ZXIgZGlzY292ZXJlZCBhIHJhY2UgY29uZGl0aW9uIHZ1bG5l
cmFiaWxpdHkgaW4gdGhlIEJQRiBzdWJzeXN0ZW0sIHNwZWNpZmljYWxseSBpbiB0aGUgcmVsZWFz
ZSBwYXRoIGZvciBjZ3JvdXAtYXR0YWNoZWQgTFNNIHByb2dyYW1zLiBXaGVuIG11bHRpcGxlIEJQ
RiBjZ3JvdXAgbGlua3MgYXR0YWNoZWQgdG8gdGhlIHNhbWUgTFNNIGhvb2sgYXJlIHJlbGVhc2Vk
IGNvbmN1cnJlbnRseSwgYSByYWNlIGNvbmRpdGlvbiBpbiBgYnBmX3RyYW1wb2xpbmVfdW5saW5r
X2Nncm91cF9zaGltYCBjYW4gbGVhZCB0byBzdGF0ZSBjb3JydXB0aW9uLCB0cmlnZ2VyaW5nIGEg
a2VybmVsIHdhcm5pbmcgKGBPREVCVUcgYnVnIGluIF9faW5pdF93b3JrYCkgYW5kIGEgc3Vic2Vx
dWVudCBrZXJuZWwgcGFuaWMuCj4gPiAKPiA+IFJlcG9ydGVkLWJ5OiBLYWl5YW4gTWVpIDxNMjAy
NDcyMjEwQGh1c3QuZWR1LmNuPgo+ID4gUmVwb3J0ZWQtYnk6IFlpbmhhbyBIdSA8ZGRkZGRkQGh1
c3QuZWR1LmNuPgo+ID4gUmV2aWV3ZWQtYnk6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUu
Y24+Cj4gPiAKPiA+ICMjIFZ1bG5lcmFiaWxpdHkgRGVzY3JpcHRpb24KPiA+IAo+ID4gVGhlIHZ1
bG5lcmFiaWxpdHkgaXMgdHJpZ2dlcmVkIHdoZW4gbXVsdGlwbGUgdGhyZWFkcyBjb25jdXJyZW50
bHkgY2xvc2UgZmlsZSBkZXNjcmlwdG9ycyBjb3JyZXNwb25kaW5nIHRvIGBicGZfY2dyb3VwX2xp
bmtgcyB0aGF0IHNoYXJlIGEgY29tbW9uIHVuZGVybHlpbmcgYGJwZl9zaGltX3RyYW1wX2xpbmtg
LiBUaGUgYGJwZl9saW5rX3B1dGAgZnVuY3Rpb24sIHdoaWNoIGlzIGNhbGxlZCBkdXJpbmcgdGhl
IHJlbGVhc2UgcGF0aCwgaXMgbm90IGRlc2lnbmVkIHRvIGhhbmRsZSBjb25jdXJyZW50IGNhbGxz
IG9uIHRoZSBzYW1lIGxpbmsgaW5zdGFuY2Ugd2hlbiBpdHMgcmVmZXJlbmNlIGNvdW50IGlzIGxv
dy4gVGhpcyByYWNlIGxlYWRzIHRvIHRoZSByZS1pbml0aWFsaXphdGlvbiBvZiBhbiBhbHJlYWR5
LWFjdGl2ZSBgd29ya19zdHJ1Y3RgLCBhIG1lbW9yeSBzdGF0ZSBjb3JydXB0aW9uIHRoYXQgaXMg
ZGV0ZWN0ZWQgYnkgdGhlIGtlcm5lbCdzIGRlYnVnIG9iamVjdHMgZmVhdHVyZS4KPiAKPiBJIGRv
bid0IHRoaW5rIGNvbmN1cnJlbnQgYnBmX2xpbmtfcHV0KHNhbWVfbGluaykgaXMgdGhlIGlzc3Vl
LiAKPiBicGZfbGlua19wdXQgdXNlcyBhbiBhdG9taWMgbGluay0+cmVmY250IHRvIGhhbmRsZSB0
aGlzIHNpdHVhdGlvbi4KPiAKPiBUaGUgcmFjZSBzaG91bGQgYmUgYmV0d2VlbiB0aGUgYnBmX2xp
bmtfcHV0KCkgaW4gCj4gYnBmX3RyYW1wb2xpbmVfdW5saW5rX2Nncm91cF9zaGltKCkgYW5kIHRo
ZSBjZ3JvdXBfc2hpbV9maW5kKCkgaW4gCj4gYnBmX3RyYW1wb2xpbmVfbGlua19jZ3JvdXBfc2hp
bSgpLiBUaGUgY2dyb3VwX3NoaW1fZmluZCgpIGluIAo+IGJwZl90cmFtcG9saW5lX2xpbmtfY2dy
b3VwX3NoaW0oKSBnZXRzIGEgc2hpbV9saW5rIHdpdGggYSByZWZjbnQgMCwgdGhlbiAKPiBhIFVB
Ri4KPiAKPiBUaGUgY2hhbmdlcyBpbiBjb21taXQgYWI1ZDQ3YmQ0MWIxICgiYnBmOiBSZW1vdmUg
aW5fYXRvbWljKCkgZnJvbSAKPiBicGZfbGlua19wdXQoKS4iKSBtYWRlIHRoaXMgYnVnIGVhc2ll
ciB0byBtYW5pZmVzdCBhcyBpbiB0aGUgcmVwcm9kdWNlciAKPiBiZWNhdXNlIHRoZSBicGZfdHJh
bXBvbGluZV91bmxpbmtfcHJvZygpIGlzIGFsd2F5cyBkZWxheWVkLgo+IAo+IEEgcG90ZW50aWFs
IGZpeCBpcyB0byBjaGVjayB0aGUgbGluay0+cmVmY250IGluIAo+IGJwZl90cmFtcG9saW5lX3Vu
bGlua19jZ3JvdXBfc2hpbSgpIGFuZCBjYWxsIAo+IGJwZl90cmFtcG9saW5lX3VubGlua19wcm9n
KCkgd2hlbiBuZWVkZWQgaW5zaWRlIHRoZSAKPiBtdXRleF9sb2NrKCZ0ci0+bXV0ZXgpLiBDYzog
U3RhbmlzbGF2CgpUaGFuayB5b3UgZm9yIHRoZSBjb3JyZWN0aW9uIGFuZCBhbmFseXNpc+OAggpU
aGlzIGlzIHN1cGVyIGhlbHBmdWwgZm9yIG91ciBzdWJzZXF1ZW50IHdvcmsh

