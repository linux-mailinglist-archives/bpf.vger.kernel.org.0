Return-Path: <bpf+bounces-30040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02F8CA320
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A95E1F2178C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D07D138497;
	Mon, 20 May 2024 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WgBjlB5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WgBjlB5k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5URUcBG"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78A26AC1
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235736; cv=none; b=RCr+806IBqxAw8HMKEwZss5AFgr1TF9b7o73F7G52F8mnz0rDTXUiJ3BUDUA86QYrzHFPzRSuxG9GLKnt5DltBb5IRK4X+GIUMqz0t5KlVc38nD65T8tIE/hvYhXxy7K8nMQfNUUgkEnOirsL2qdD8QJk0VyiSwAOxXzt761EeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235736; c=relaxed/simple;
	bh=W/1hPqISmkp/Ieb/wB6/XhplRqEk/tLJKJn9wzDRiok=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=jqJYuCGiVvW3mrBwvhMEEiK5QpN7nJsbb6GcRWdyz8JtT99hum6MAvwagGZfsl1SAdniipr2JENmj8R4q+4Snu9H7wsMFHAHtayrBGM5/N3xxvVw59kIhVZx1vpNrNgjq/PsuulBrime+9qZImt9zN7/NTbaTYXI176yA7cZg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WgBjlB5k; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WgBjlB5k; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5URUcBG reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8FECDC18DBA4
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716235728; bh=W/1hPqISmkp/Ieb/wB6/XhplRqEk/tLJKJn9wzDRiok=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=WgBjlB5k3rtOjy1UpmMR+H4BFMeX+hHL5WJGTjfdphPIBGCiJXLzdN/UIsxhd95fP
	 rZq6V2TUapgt5xI9YL+ayvgnSVnFfRno07b0Bjc9ohnSIvfAzRBG9VamT37opKm8qp
	 OQnIlJ3GDQUQThm4lIwCVonDDosMwPn+rSGuD8BY=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Mon May 20 13:08:48 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6D60BC18DB95
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716235728; bh=W/1hPqISmkp/Ieb/wB6/XhplRqEk/tLJKJn9wzDRiok=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=WgBjlB5k3rtOjy1UpmMR+H4BFMeX+hHL5WJGTjfdphPIBGCiJXLzdN/UIsxhd95fP
	 rZq6V2TUapgt5xI9YL+ayvgnSVnFfRno07b0Bjc9ohnSIvfAzRBG9VamT37opKm8qp
	 OQnIlJ3GDQUQThm4lIwCVonDDosMwPn+rSGuD8BY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8DFD6C14F6F7
	for <bpf@ietfa.amsl.com>; Mon, 20 May 2024 13:08:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vmFnDAFaubp0 for <bpf@ietfa.amsl.com>;
	Mon, 20 May 2024 13:08:35 -0700 (PDT)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 4A76DC14F726
	for <bpf@ietf.org>; Mon, 20 May 2024 13:08:34 -0700 (PDT)
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716235713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA6XH729d4apsCX8A+BcKu8efDxZnu41fyBNQ5jOQL0=;
	b=b5URUcBGGCGn8j8ShZDG5QEQ1fkAFNBzaUdOiLglULJs3AaEaCIUF0MHObMeL1BcCyM82S
	yCjkmoUKbfTTOrJfkwiXqGXQw36bPCplVHXKME0b9IAX7OABq6jJcjPbiNig64t9AGpHET
	rS8XCBZlb1B7xZRb2BIGUxqrpoRksM0=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <3f5949c8-6dcc-4348-9cda-4813c5e2455b@linux.dev>
Date: Mon, 20 May 2024 13:08:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
References: <20240517161612.4385-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240517161612.4385-1-dthaler1968@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: NCFNUZUPTDW6K3YYGURHIWSMBBRTJXPV
X-Message-ID-Hash: NCFNUZUPTDW6K3YYGURHIWSMBBRTJXPV
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_clarify_sign_e?=
 =?utf-8?q?xtension_of_64-bit_use_of_32-bit_imm?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/20Ou74Ik3aU-OwzOC-pUF3hTg6g>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA1LzE3LzI0IDEwOjE2IEFNLCBEYXZlIFRoYWxlciB3cm90ZToNCj4gaW1tIGlzIGRlZmlu
ZWQgYXMgYSAzMi1iaXQgc2lnbmVkIGludGVnZXIuDQo+DQo+IHtNT1YsIEssIEFMVTY0fSBzYXlz
IGl0IGRvZXMgImRzdCA9IHNyYyIgKHdoZXJlIHNyYyBpcyAnaW1tJykgYnV0IGl0IGRvZXMNCj4g
bm90IHNpZ24gZXh0ZW5kLCBidXQgaW5zdGVhZCBkb2VzIGRzdCA9ICh1MzIpc3JjLiAgVGhlICJK
dW1wIGluc3RydWN0aW9ucyINCg0KSSBhbSBub3Qgc3VyZSBhYm91dCB0aGlzLiBJbiBrZXJuZWwv
YnBmL2NvcmUuYywgd2UgaGF2ZQ0KICAgICAgICAgQUxVNjRfTU9WX0s6DQogICAgICAgICAgICAg
ICAgIERTVCA9IElNTTsNCiAgICAgICAgICAgICAgICAgQ09OVDsNCmhlcmUgRFNUIGlzIHU2NCBh
bmQgSU1NIGlzIHMzMi4gSUlVQywgSU1NIG5lZWRzIHRvIGV4dGVuZCB0byBzNjQgYW5kIHRoZW4N
CmNvbnZlcnQgdG8gdTY0Lg0KDQo+IHNlY3Rpb24gaGFzICJ1bnNpZ25lZCIgYnkgc29tZSBpbnN0
cnVjdGlvbnMsIGJ1dCB0aGUgIkFyaXRobWV0aWMgaW5zdHJ1Y3Rpb25zIg0KPiBzZWN0aW9uIGhh
cyBubyBzdWNoIG5vdGUgYWJvdXQgdGhlIE1PViBpbnN0cnVjdGlvbiwgc28gYWRkZWQgYW4gZXhh
bXBsZSB0bw0KPiBtYWtlIHRoaXMgbW9yZSBjbGVhci4NCj4NCj4ge0pMRSwgSywgSk1QfSBzYXlz
IGl0IGRvZXMgIlBDICs9IG9mZnNldCBpZiBkc3QgPD0gc3JjIiAod2hlcmUgc3JjIGlzICdpbW0n
LA0KPiBhbmQgdGhlIGNvbXBhcmlzb24gaXMgdW5zaWduZWQpLiBUaGlzIHdhcyBhcHBhcmVudGx5
IGFtYmlndW91cyB0byBzb21lDQo+IHJlYWRlcnMgYXMgdG8gd2hldGhlciB0aGUgY29tcGFyaXNv
biB3YXMgImRzdCA8PSAodTY0KSh1MzIpaW1tIiBvcg0KPiAiZHN0IDw9ICh1NjQpKHM2NClpbW0i
LCBzaW5jZSB0aGUgY29ycmVjdCBhc3N1bXB0aW9uIHdvdWxkIGJlIHRoZSBsYXR0ZXINCj4gZXhj
ZXB0IHRoYXQgdGhlIE1PViBpbnN0cnVjdGlvbiBkb2Vzbid0IGZvbGxvdyB0aGF0LCBzbyBhZGRl
ZCBhbiBleGFtcGxlDQo+IHRvIG1ha2UgdGhpcyBtb3JlIGNsZWFyLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEYXZlIFRoYWxlciA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+DQo+IC0tLQ0KPiAg
IC4uLi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICAgICAgfCAxNSAr
KysrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRp
emF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgYi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6
YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiBpbmRleCA5OTc1NjBhYmEuLmY5NmViYjE2OSAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0
aW9uLXNldC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2lu
c3RydWN0aW9uLXNldC5yc3QNCj4gQEAgLTM3OCwxMyArMzc4LDIyIEBAIGV0Yy4gVGhpcyBzcGVj
aWZpY2F0aW9uIHJlcXVpcmVzIHRoYXQgc2lnbmVkIG1vZHVsbyB1c2UgdHJ1bmNhdGVkIGRpdmlz
aW9uDQo+ICAgDQo+ICAgICAgYSAlIG4gPSBhIC0gbiAqIHRydW5jKGEgLyBuKQ0KPiAgIA0KPiAt
VGhlIGBgTU9WU1hgYCBpbnN0cnVjdGlvbiBkb2VzIGEgbW92ZSBvcGVyYXRpb24gd2l0aCBzaWdu
IGV4dGVuc2lvbi4NCj4gK1RoZSBgYE1PVmBgIGluc3RydWN0aW9uIGRvZXMgYSBtb3ZlIG9wZXJh
dGlvbiB3aXRob3V0IHNpZ24gZXh0ZW5zaW9uLCB3aGVyZWFzDQo+ICt0aGUgYGBNT1ZTWGBgIGlu
c3RydWN0aW9uIGRvZXMgYSBtb3ZlIG9wZXJhdGlvbiB3aXRoIHNpZ24gZXh0ZW5zaW9uLg0KPiAg
IGBge01PVlNYLCBYLCBBTFV9YGAgOnRlcm06YHNpZ24gZXh0ZW5kczxTaWduIEV4dGVuZD5gIDgt
Yml0IGFuZCAxNi1iaXQgb3BlcmFuZHMgaW50bw0KPiAgIDMyLWJpdCBvcGVyYW5kcywgYW5kIHpl
cm9lcyB0aGUgcmVtYWluaW5nIHVwcGVyIDMyIGJpdHMuDQo+ICAgYGB7TU9WU1gsIFgsIEFMVTY0
fWBgIDp0ZXJtOmBzaWduIGV4dGVuZHM8U2lnbiBFeHRlbmQ+YCA4LWJpdCwgMTYtYml0LCBhbmQg
MzItYml0DQo+ICAgb3BlcmFuZHMgaW50byA2NC1iaXQgb3BlcmFuZHMuICBVbmxpa2Ugb3RoZXIg
YXJpdGhtZXRpYyBpbnN0cnVjdGlvbnMsDQo+ICAgYGBNT1ZTWGBgIGlzIG9ubHkgZGVmaW5lZCBm
b3IgcmVnaXN0ZXIgc291cmNlIG9wZXJhbmRzIChgYFhgYCkuDQo+ICAgDQo+ICtgYHtNT1YsIEss
IEFMVX1gYCBtZWFuczo6DQo+ICsNCj4gKyAgZHN0ID0gKHUzMikgaW1tDQo+ICsNCj4gK2Bge01P
VlNYLCBYLCBBTFV9YGAgd2l0aCAnb2Zmc2V0JyAzMiBtZWFuczo6DQo+ICsNCj4gKyAgZHN0ID0g
KHMzMikgc3JjDQoNCkZvciB7TU9WU1gsIFgsIEFMVX0sIG9mZnNldCAzMiBpcyBub3Qgc3VwcG9y
dGVkLiBUaGUgY29ycmVjdCBvZmZzZXQgdmFsdWUNCmlzIDggYW5kIDE2LiBGb3IgZXhhbXBsZSBm
b3Igb2Zmc2V0IDgsIHdlIGhhdmUgZHN0ID0gKHUzMikoczgpc3JjLg0KDQo+ICsNCj4gICBUaGUg
YGBORUdgYCBpbnN0cnVjdGlvbiBpcyBvbmx5IGRlZmluZWQgd2hlbiB0aGUgc291cmNlIGJpdCBp
cyBjbGVhcg0KPiAgIChgYEtgYCkuDQo+ICAgDQo+IEBAIC00ODYsNiArNDk1LDEwIEBAIEV4YW1w
bGU6DQo+ICAgDQo+ICAgd2hlcmUgJ3M+PScgaW5kaWNhdGVzIGEgc2lnbmVkICc+PScgY29tcGFy
aXNvbi4NCj4gICANCj4gK2Bge0pMRSwgSywgSk1QfWBgIG1lYW5zOjoNCj4gKw0KPiArICBpZiBk
c3QgPD0gKHU2NCkoczY0KWltbSBnb3RvICtvZmZzZXQNCj4gKw0KPiAgIGBge0pBLCBLLCBKTVAz
Mn1gYCBtZWFuczo6DQo+ICAgDQo+ICAgICBnb3RvbCAraW1tDQoNCi0tIApCcGYgbWFpbGluZyBs
aXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1s
ZWF2ZUBpZXRmLm9yZwo=

