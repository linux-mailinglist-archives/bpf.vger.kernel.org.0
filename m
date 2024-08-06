Return-Path: <bpf+bounces-36494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97509498F5
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AD6B23591
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173C73451;
	Tue,  6 Aug 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="elWwBGEa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="iahA3JXR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="md1NlrMY"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165D33086
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975698; cv=none; b=tc9+EL9Tm7/OMCt05Sf/5IeyKZTkv8Ba4DCJZA/Hz2z6Rz8o2jxd6kAVSnUiSO7FixuMlLuHrmmv78NrqazpdIvkiHhIAHEB3V/zaygYyoLYcaZMj1sSG9MYVATMSPfaVw7CX2lR8gwL9eTLxmn97NRMc0FWelmaYRgY+aWaP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975698; c=relaxed/simple;
	bh=x9905iJyPgtfOxEAFM5x/70BkMC+8j6zyG7ycLDe17U=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=ZWpxNsID/InwnGNAUCFyVjLxQ7wP53akF4XhzUxMNwNCI5kjtG5CVFfIKGrCW5y+gRgfPvxe0KHKBFVA7LcmzWvJVw+OdkcVMaULj5Az7C3AYgi7O9i8pHAcJYj4sPxi8D/s2eH9iLDwpdK/E3oGFBeAaewN05lTzNPZf8d/m6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=elWwBGEa; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=iahA3JXR; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=md1NlrMY reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 74C79C18DB8E
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722975690; bh=x9905iJyPgtfOxEAFM5x/70BkMC+8j6zyG7ycLDe17U=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=elWwBGEa+AwEhSfuoKUH/oVV2sLlEhyMvpbw9whlEtkwZkdtru06K67wjCgALickH
	 IVtMgvqDJr9UGxdGSse6+DUGXt4U/XDtAARcKkS2Sumbn6g1yNi+Jsk0tuKg4JaXoT
	 wjOTGuYOfn0fW8TYCo+h+CXCNVYz3Fy10chsc8mo=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Tue Aug  6 13:21:29 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 9B85CC1840F6
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1722975689; bh=x9905iJyPgtfOxEAFM5x/70BkMC+8j6zyG7ycLDe17U=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=iahA3JXRX7qcYdydfVvayFDei+Y/34fQqQorf3BX3HGqgT7RNDtoFILJ7X7+jaTxc
	 8VRAFRi+qVnTSNnGGu5J6ET2roG/b1x057WOzwOZM08qyAj+RfTEPA+IMbcf8hrd5U
	 SGRrwf8aEEbOMXFShrupnLSwpiyFNv664ZDPltS8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id A809CC1840F0
	for <bpf@ietfa.amsl.com>; Tue,  6 Aug 2024 13:21:26 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrdEBfXNqecK for <bpf@ietfa.amsl.com>;
	Tue,  6 Aug 2024 13:21:22 -0700 (PDT)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id D5246C1840ED
	for <bpf@ietf.org>; Tue,  6 Aug 2024 13:21:20 -0700 (PDT)
Message-ID: <130c68ca-fcaf-46db-8bc0-19bb8a87ab90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722975678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDND7TQ4/bBAYAZkRiXbmditHTHsnNM4NtRumlU4FcY=;
	b=md1NlrMYyZRf+OujKB48LKa9M0NHcB0YxP+6Z7ALeAGj4GSaH0YxVth81kceB15BTy9bFw
	ZrDTKDRwqavmsOaP8EzfMgHm9joT57l3jY3Leh3dqWFkWraYqVp7+xyBUpBFzohNi4AAPA
	X34S1e5JGQNAz6MzdrOgAi7GDSP65Og=
Date: Tue, 6 Aug 2024 13:21:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Michael Agun <danielagun@microsoft.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: 
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <CAEf4BzZvMOdL+mL9NxxesyXO-xRCwkJYqQ+GXQVBssF3_jid=w@mail.gmail.com>
 <CY5PR21MB34930570D71160AAD130D7A4D7B32@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: 
 <CY5PR21MB34930570D71160AAD130D7A4D7B32@CY5PR21MB3493.namprd21.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: 6FS6NGKJQTZJI37XVO7QTX2AY3STRKLD
X-Message-ID-Hash: 6FS6NGKJQTZJI37XVO7QTX2AY3STRKLD
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "bpf@ietf.org" <bpf@ietf.org>, dthaler1968 <dthaler1968@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BEXTERNAL=5D_Re=3A_perf=5Fevent=5Foutput_payload?=
	=?utf-8?q?_capture_flags=3F?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/QIwN67PHFu981aHyQ9zsCaqvaJs>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQpPbiA4LzEvMjQgNToxMyBQTSwgTWljaGFlbCBBZ3VuIHdyb3RlOg0KPiBUaGFua3MgQW5kcmlp
LCBJIGhhZCB0byBjb25maXJtIEkgY291bGQgcmVhZCBpdCBhbmQgaXQgbG9va3MgbGlrZSB0aGF0
IGlzIHRoZSBzYW1lIGFzIHRoZSBkb2NzIEkgaGF2ZSBzZWVuLiBJIG5vdyBzZWUgd2hlcmUgdGhl
IGNhcHR1cmUgbGVuZ3RoIGlzIGJlaW5nIHBsYWNlZCwgYnV0IGFtIHN0aWxsIG1pc3Npbmcgc29t
ZXRoaW5nLg0KPg0KPiBEb3duIG5lYXIgdGhlIGJvdHRvbSB0aGVyZSBpcyBhIGZsYWcgY29uc3Rh
bnQgQlBGX0ZfQ1RYTEVOX01BU0suIEl0IGFwcGVhcnMgdGhhdCBpcyBiaXRmaWVsZCBpbiB0aGUg
ZmxhZ3MgdmFsdWUgdGhlIGNhcHR1cmUgbGVuZ3RoIGdvZXMgaW4sIGJ1dCBJIGRvbid0IHNlZSBh
bnkgb3RoZXIgbWVudGlvbiBvZiB0aGF0IGNvbnN0YW50LiBEbyB5b3Uga25vdyB3aGVyZSB0aGF0
IGlzIGRvY3VtZW50ZWQ/DQoNCk9rYXkuIFRoZSBmb2xsb3dpbmcgaW4gdWFwaSBicGYuaDoNCg0K
LyogQlBGX0ZVTkNfcGVyZl9ldmVudF9vdXRwdXQgZm9yIHNrX2J1ZmYgaW5wdXQgY29udGV4dC4g
Ki8NCiAgICAgICAgIEJQRl9GX0NUWExFTl9NQVNLICAgICAgICAgICAgICAgPSAoMHhmZmZmZlVM
TCA8PCAzMiksDQoNClRoYXQgaXMgd2h5IEkgbWlzc2VkIGl0IHNpbmNlIGl0IGlzIGZvciBuZXR3
b3JraW5nIHNpZGUgb2YgcGVyZl9ldmVudF9vdXRwdXQuDQoNClRoZSBuZXR3b3JraW5nIGZsYXZv
cmVkIGJwZl9wZXJmX2V2ZW50X291dHB1dCB0cmllcyB0byBvdXRwdXQNCm5ldHdvcmtpbmcgcGFj
a2V0cyBwbHVzIG1ldGEgZGF0YS4gSXQgaXMgYSBsaXR0bGUgYml0IGRpZmZlcmVudA0KZnJvbSB0
cmFjaW5nIHNpZGUgb2YgYnBmX3BlcmZfZXZlbnRfb3V0cHV0Lg0KVW5mb3J0dW5hdGVseSwgd2Ug
ZG8gbm90IGhhdmUgYSBnb29kIGRvY3VtZW50YXRpb24gZm9yIHRoaXMgeWV0Lg0KDQo+DQo+IFRo
YW5rcywNCj4gTWljaGFlbA0KPg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IEZyb206IEFuZHJpaSBOYWtyeWlrbyA8YW5kcmlpLm5ha3J5aWtvQGdtYWlsLmNv
bT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDI5LCAyMDI0IDE6NTggUE0NCj4gVG86IE1pY2hhZWwg
QWd1biA8ZGFuaWVsYWd1bkBtaWNyb3NvZnQuY29tPg0KPiBDYzogWW9uZ2hvbmcgU29uZyA8eW9u
Z2hvbmcuc29uZ0BsaW51eC5kZXY+OyBicGZAdmdlci5rZXJuZWwub3JnIDxicGZAdmdlci5rZXJu
ZWwub3JnPjsgYnBmQGlldGYub3JnIDxicGZAaWV0Zi5vcmc+OyBkdGhhbGVyMTk2OEBnb29nbGVt
YWlsLmNvbSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhU
RVJOQUxdIFJlOiBwZXJmX2V2ZW50X291dHB1dCBwYXlsb2FkIGNhcHR1cmUgZmxhZ3M/DQo+DQo+
IE9uIEZyaSwgSnVsIDI2LCAyMDI0IGF0IDQ6NDXigK9QTSBNaWNoYWVsIEFndW4gPGRhbmllbGFn
dW5AbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+PiBDQyBEYXZlDQo+Pg0KPj4gVGhhbmsgeW91Lg0K
Pj4NCj4+IER1ZSB0byBNaWNyb3NvZnQgcG9saWNpZXMgd2UgYXZvaWQgcmVhZGluZyBjb2RlIHdp
dGggc3Ryb25nIGxpY2Vuc2luZyAobGlrZSBHUEwgMi4wKS4NCj4gTGludXggVUFQSSBoZWFkZXJz
IGFyZSBsaWNlbnNlZCBhcyBgR1BMLTIuMCBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZWAsDQo+IGFu
ZCBzZWUgWzBdLiBXaWxsIGNpdGUgaXQgaW4gZnVsbCBiZWxvdy4gRG9lc24ndCB0aGlzIG1lYW4g
dGhhdCBpdCdzDQo+IGZpbmUgdG8gcmVhZCBVQVBJIGRlZmluaXRpb25zPw0KPg0KPiBTUERYLUV4
Y2VwdGlvbi1JZGVudGlmaWVyOiBMaW51eC1zeXNjYWxsLW5vdGUNCj4gU1BEWC1VUkw6IGh0dHBz
Oi8vc3BkeC5vcmcvbGljZW5zZXMvTGludXgtc3lzY2FsbC1ub3RlLmh0bWwNCj4gU1BEWC1MaWNl
bnNlczogR1BMLTIuMCwgR1BMLTIuMCssIEdQTC0xLjArLCBMR1BMLTIuMCwgTEdQTC0yLjArLA0K
PiBMR1BMLTIuMSwgTEdQTC0yLjErLCBHUEwtMi4wLW9ubHksIEdQTC0yLjAtb3ItbGF0ZXINCj4g
VXNhZ2UtR3VpZGU6DQo+ICAgIFRoaXMgZXhjZXB0aW9uIGlzIHVzZWQgdG9nZXRoZXIgd2l0aCBv
bmUgb2YgdGhlIGFib3ZlIFNQRFgtTGljZW5zZXMNCj4gICAgdG8gbWFyayB1c2VyIHNwYWNlIEFQ
SSAodWFwaSkgaGVhZGVyIGZpbGVzIHNvIHRoZXkgY2FuIGJlIGluY2x1ZGVkDQo+ICAgIGludG8g
bm9uIEdQTCBjb21wbGlhbnQgdXNlciBzcGFjZSBhcHBsaWNhdGlvbiBjb2RlLg0KPiAgICBUbyB1
c2UgdGhpcyBleGNlcHRpb24gYWRkIGl0IHdpdGggdGhlIGtleXdvcmQgV0lUSCB0byBvbmUgb2Yg
dGhlDQo+ICAgIGlkZW50aWZpZXJzIGluIHRoZSBTUERYLUxpY2Vuc2VzIHRhZzoNCj4gICAgICBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogPFNQRFgtTGljZW5zZT4gV0lUSCBMaW51eC1zeXNjYWxs
LW5vdGUNCj4gTGljZW5zZS1UZXh0Og0KPg0KPiAgICAgTk9URSEgVGhpcyBjb3B5cmlnaHQgZG9l
cyAqbm90KiBjb3ZlciB1c2VyIHByb2dyYW1zIHRoYXQgdXNlIGtlcm5lbA0KPiAgIHNlcnZpY2Vz
IGJ5IG5vcm1hbCBzeXN0ZW0gY2FsbHMgLSB0aGlzIGlzIG1lcmVseSBjb25zaWRlcmVkIG5vcm1h
bCB1c2UNCj4gICBvZiB0aGUga2VybmVsLCBhbmQgZG9lcyAqbm90KiBmYWxsIHVuZGVyIHRoZSBo
ZWFkaW5nIG9mICJkZXJpdmVkIHdvcmsiLg0KPiAgIEFsc28gbm90ZSB0aGF0IHRoZSBHUEwgYmVs
b3cgaXMgY29weXJpZ2h0ZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUNCj4gICBGb3VuZGF0aW9uLCBi
dXQgdGhlIGluc3RhbmNlIG9mIGNvZGUgdGhhdCBpdCByZWZlcnMgdG8gKHRoZSBMaW51eA0KPiAg
IGtlcm5lbCkgaXMgY29weXJpZ2h0ZWQgYnkgbWUgYW5kIG90aGVycyB3aG8gYWN0dWFsbHkgd3Jv
dGUgaXQuDQo+DQo+ICAgQWxzbyBub3RlIHRoYXQgdGhlIG9ubHkgdmFsaWQgdmVyc2lvbiBvZiB0
aGUgR1BMIGFzIGZhciBhcyB0aGUga2VybmVsDQo+ICAgaXMgY29uY2VybmVkIGlzIF90aGlzXyBw
YXJ0aWN1bGFyIHZlcnNpb24gb2YgdGhlIGxpY2Vuc2UgKGllIHYyLCBub3QNCj4gICB2Mi4yIG9y
IHYzLnggb3Igd2hhdGV2ZXIpLCB1bmxlc3MgZXhwbGljaXRseSBvdGhlcndpc2Ugc3RhdGVkLg0K
Pg0KPiAgICAgICAgICAgICAgTGludXMgVG9ydmFsZHMNCj4NCj4NCj4gICAgWzBdIGh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9MSUNFTlNFUy9leGNlcHRpb25z
L0xpbnV4LXN5c2NhbGwtbm90ZQ0KPg0KPj4gSXMgdGhlcmUgc29tZSBvdGhlciBkb2N1bWVudGF0
aW9uIG9mIHRoZSBmbGFncywgb3IgY291bGQgeW91IGV4cGxhaW4gdGhlbSBpbiB3b3Jkcz8NCj4+
IE9yIGlzIHRoYXQgdGhlIGNvbXBsZXRlIGZsYWdzIGRlc2NyaXB0aW9uICh3aGljaCBpcyBpbiBv
dGhlciBkb2N1bWVudGF0aW9uKSBhbmQgSSBhbSBtaXN1bmRlcnN0YW5kaW5nIHRoZSBjb2RlIGJl
bG93Pw0KPj4NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9jaWxpdW0vY2lsaXVtL2Jsb2IvM2ZhNDRi
NTllZWY3OTJlMjhmNzBiMWZkMjNlM2UxN2U0MjY5MDlmNS9icGYvbGliL2RiZy5oI0wyMjkNCj4+
DQo+PiBJdCBsb29rcyB0byBtZSBoZXJlIGxpa2UgdGhlIGNhcHR1cmUgbGVuZ3RoIGlzIGJlaW5n
IE9SJ2QgaW50byB0aGUgZmxhZ3MuDQo+Pg0KPj4gQW55IGluc2lnaHRzIHdvdWxkIGJlIGFwcHJl
Y2lhdGVkLg0KPj4NCj4+IFRoYW5rcywNCj4+IE1pY2hhZWwNCj4+DQo+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBGcm9tOiBZb25naG9uZyBTb25nIDx5b25n
aG9uZy5zb25nQGxpbnV4LmRldj4NCj4+IFNlbnQ6IEZyaWRheSwgSnVseSAyNiwgMjAyNCA5OjU4
IEFNDQo+PiBUbzogTWljaGFlbCBBZ3VuIDxkYW5pZWxhZ3VuQG1pY3Jvc29mdC5jb20+OyBicGZA
dmdlci5rZXJuZWwub3JnIDxicGZAdmdlci5rZXJuZWwub3JnPjsgYnBmQGlldGYub3JnIDxicGZA
aWV0Zi5vcmc+DQo+PiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBwZXJmX2V2ZW50X291dHB1dCBw
YXlsb2FkIGNhcHR1cmUgZmxhZ3M/DQo+Pg0KPj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwg
ZnJvbSB5b25naG9uZy5zb25nQGxpbnV4LmRldi4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50
IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+Pg0K
Pj4gT24gNy8yNS8yNCA2OjQyIFBNLCBNaWNoYWVsIEFndW4gd3JvdGU6DQo+Pj4gQXJlIHRoZSBw
ZXJmX2V2ZW50X291dHB1dCBmbGFncyAoYW5kIHdoYXQgdGhlIGV2ZW50IGJsb2IgbG9va3MgbGlr
ZSkgZG9jdW1lbnRlZD8gRXNwZWNpYWxseSBmb3IgdGhlIHByb2dyYW0gdHlwZSBzcGVjaWZpYyBw
ZXJmX2V2ZW50X291dHB1dCBmdW5jdGlvbnMuDQo+PiBUaGUgZG9jdW1lbnRhdGlvbiBpcyBpbiB1
YXBpL2xpbnV4L2JwZi5oIGhlYWRlci4NCj4+DQo+PiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFs
ZHMvbGludXgvYmxvYi9tYXN0ZXIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oI0wyMzUzLUwyMzk3
DQo+Pg0KPj4gICAgKiAgICAgICAgIFRoZSAqZmxhZ3MqIGFyZSB1c2VkIHRvIGluZGljYXRlIHRo
ZSBpbmRleCBpbiAqbWFwKiBmb3Igd2hpY2gNCj4+ICAgICogICAgICAgICB0aGUgdmFsdWUgbXVz
dCBiZSBwdXQsIG1hc2tlZCB3aXRoICoqQlBGX0ZfSU5ERVhfTUFTSyoqLg0KPj4gICAgKiAgICAg
ICAgIEFsdGVybmF0aXZlbHksICpmbGFncyogY2FuIGJlIHNldCB0byAqKkJQRl9GX0NVUlJFTlRf
Q1BVKioNCj4+ICAgICogICAgICAgICB0byBpbmRpY2F0ZSB0aGF0IHRoZSBpbmRleCBvZiB0aGUg
Y3VycmVudCBDUFUgY29yZSBzaG91bGQgYmUNCj4+ICAgICogICAgICAgICB1c2VkLg0KPj4NCj4+
PiBJJ3ZlIHNlZW4gbm90ZXMgaW4gKGNpbGl1bSkgY29kZSBwYXNzaW5nIHBheWxvYWQgbGVuZ3Ro
cyBpbiB0aGUgZmxhZ3MsIGFuZCBhbSBzcGVjaWZpY2FsbHkgaW50ZXJlc3RlZCBpbiBob3cgdGhl
IGV2ZW50IGJsb2IgaXMgY29uc3RydWN0ZWQgZm9yIHBlcmYgZXZlbnRzIHdpdGggcGF5bG9hZCBj
YXB0dXJlLg0KPj4gQ291bGQgeW91IHNoYXJlIG1vcmUgZGV0YWlscyBhYm91dCAncGFzc2luZyBw
YXlsb2FkIGxlbmd0aHMgaW4gdGhlIGZsYWdzJz8NCj4+IEFGQUlLLCBuZXR3b3JraW5nIGJwZl9w
ZXJmX2V2ZW50X291dHB1dCgpIGFjdHVhbGx5IHV0aWxpemVzIGJwZl9ldmVudF9vdXRwdXRfZGF0
YSgpLA0KPj4gaW4gd2hpY2ggJ2ZsYWdzJyBzZW1hbnRpY3MgaGFzIHRoZSBzYW1lIG1lYW5pbmcg
YXMgdGhlIGFib3ZlLg0KPj4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBNaWNoYWVsDQoNCi0tIApC
cGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=

