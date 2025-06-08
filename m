Return-Path: <bpf+bounces-60013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC70AD12B0
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717547A1F6D
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD224E00F;
	Sun,  8 Jun 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="w0V1wIEW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="w0V1wIEW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lBPJ766E"
X-Original-To: bpf@vger.kernel.org
Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F21FFC7B
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393699; cv=none; b=sKQ4HDN5qQKMzgVjB8YGxr5hGkRNHVSmgK70IFBFPLhwT+40PNTcvpWrm+Loo+BrsyOw8677fbITS+qlyH7D17u2jmEhc4vgew6VRKKRDzhURCw8Ud3LavfZZQz/8mZfZYN6bZKLfwK2V2cERFgTiEYTbKsA0JQTYsoF/b4/CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393699; c=relaxed/simple;
	bh=/a1jI8Ci3i1GxFxpapm1vhh0OG4twAQlwuWo7nzbMIM=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:CC:
	 Subject:Content-Type; b=Qa8cBiX9QDX+EVVI2aGc32mmxAiOrTrvOkNAy2QxB23/q+QYotqgJtdT+L+EiI/LHfa67K/fdb8jLcmw4js2wxNpA4AcECaE5Ar9R6JHebDzsWq0b0z538OJc02KqWfmrIPEO2rj4Fv2epg6uMGea7R8Q1+6wPOuPKKSsPvqSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=w0V1wIEW; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=w0V1wIEW; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lBPJ766E reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 2C319325DA9B
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1749393149; bh=/a1jI8Ci3i1GxFxpapm1vhh0OG4twAQlwuWo7nzbMIM=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=w0V1wIEWrRYHU6hbewcTWRNYOuODFyMqvT/Xb+XuSocAl01zVRNbW8QUbci8hTBkg
	 d08SnF4S+7KCa37JlTW+wfITvTBgM86tflhEV+DBUWL34DQN44eHjSXYkarhoEZKwX
	 g3j/NDJccZ9c7Byd29+ydscUN069NBZqr96X2l1Y=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Sun Jun  8 07:32:29 2025
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 26B01325DA9A
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1749393149; bh=/a1jI8Ci3i1GxFxpapm1vhh0OG4twAQlwuWo7nzbMIM=;
	h=Date:To:References:From:In-Reply-To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=w0V1wIEWrRYHU6hbewcTWRNYOuODFyMqvT/Xb+XuSocAl01zVRNbW8QUbci8hTBkg
	 d08SnF4S+7KCa37JlTW+wfITvTBgM86tflhEV+DBUWL34DQN44eHjSXYkarhoEZKwX
	 g3j/NDJccZ9c7Byd29+ydscUN069NBZqr96X2l1Y=
X-Original-To: bpf@mail2.ietf.org
Delivered-To: bpf@mail2.ietf.org
Received: from localhost (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id F17EC325D9B5
	for <bpf@mail2.ietf.org>; Sun,  8 Jun 2025 07:32:18 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (1024-bit key)
	header.d=linux.dev
Received: from mail2.ietf.org ([166.84.6.31])
	by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c3beZEQjfpYH for <bpf@mail2.ietf.org>;
	Sun,  8 Jun 2025 07:32:18 -0700 (PDT)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail2.ietf.org (Postfix) with ESMTPS id 781FC325D9B0
	for <bpf@ietf.org>; Sun,  8 Jun 2025 07:32:18 -0700 (PDT)
Message-ID: <a09cbf07-f6b9-4808-a955-2f506c320585@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749393136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWGpWO4XZip3DDSvOV06d85tUhqZHEdZ1brs1WQyrzs=;
	b=lBPJ766EukbyvQ1Uy3PN+0uY9B4zWhk2+1hmw7Di08Jm1Y96qWA61F7pvalbdATyGGFTHL
	hbl+V/kkq9+xiuymQsk5Q4TyXFAuaRPkdh4pFjTOsp5ujCYfabn5iVm7Cw9L0/ZeRRsYco
	cJ7JVRJ2crhdwuZPWrcGZsmDV7WNd7w=
Date: Sun, 8 Jun 2025 07:32:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: Eslam Khafagy <eslam.medhat1993@gmail.com>
References: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
X-Migadu-Flow: FLOW_OUT
Message-ID-Hash: TTAOP5WQ34FZGCVULZLD3IONRV2A3MRE
X-Message-ID-Hash: TTAOP5WQ34FZGCVULZLD3IONRV2A3MRE
X-MailFrom: yonghong.song@linux.dev
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: skhan@linuxfoundation.org, David Vernet <void@manifault.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Dave Thaler <dthaler1968@googlemail.com>,
 "open list:BPF [DOCUMENTATION] (Related to Standardization)"
 <bpf@vger.kernel.org>,
 "open list:BPF [DOCUMENTATION] (Related to Standardization)" <bpf@ietf.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_Documentation=3A_Enhance_read?=
	=?utf-8?q?ability_in_BPF_docs?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/XGjGxS-WlLnpq8qrJDRwC2jMxGo>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDYvNy8yNSAzOjI0IFBNLCBFc2xhbSBLaGFmYWd5IHdyb3RlOg0KPiBUaGUgcGhyYXNl
ICJkaXZpZGluZyAtMSIgaXMgb25lIEkgZmluZCBjb25mdXNpbmcuICBFLmcuLA0KPiAiSU5UX01J
TiBkaXZpZGluZyAtMSIgc291bmRzIGxpa2UgIi0xIC8gSU5UX01JTiIgcmF0aGVyIHRoYW4gdGhl
IGludmVyc2UuDQo+ICJkaXZpZGVkIGJ5IiBpbnN0ZWFkIG9mICJkaXZpZGluZyIgYXNzdW1pbmcg
dGhlIGludmVyc2UgaXMgbWVhbnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEVzbGFtIEtoYWZhZ3kg
PGVzbGFtLm1lZGhhdDE5OTNAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8
eW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY+DQoNCj4gLS0tDQo+ICAgRG9jdW1lbnRhdGlvbi9icGYv
c3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgfCA0ICsrLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3Qg
Yi9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0K
PiBpbmRleCBhYzk1MGE1YmI2YWQuLjM5Yzc0NjExNzUyYiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4g
QEAgLTM1MCw4ICszNTAsOCBAQCBVbmRlcmZsb3cgYW5kIG92ZXJmbG93IGFyZSBhbGxvd2VkIGR1
cmluZyBhcml0aG1ldGljIG9wZXJhdGlvbnMsIG1lYW5pbmcNCj4gICB0aGUgNjQtYml0IG9yIDMy
LWJpdCB2YWx1ZSB3aWxsIHdyYXAuIElmIEJQRiBwcm9ncmFtIGV4ZWN1dGlvbiB3b3VsZA0KPiAg
IHJlc3VsdCBpbiBkaXZpc2lvbiBieSB6ZXJvLCB0aGUgZGVzdGluYXRpb24gcmVnaXN0ZXIgaXMg
aW5zdGVhZCBzZXQgdG8gemVyby4NCj4gICBPdGhlcndpc2UsIGZvciBgYEFMVTY0YGAsIGlmIGV4
ZWN1dGlvbiB3b3VsZCByZXN1bHQgaW4gYGBMTE9OR19NSU5gYA0KPiAtZGl2aWRpbmcgLTEsIHRo
ZSBkZXN0aW5hdGlvbiByZWdpc3RlciBpcyBpbnN0ZWFkIHNldCB0byBgYExMT05HX01JTmBgLiBG
b3INCj4gLWBgQUxVYGAsIGlmIGV4ZWN1dGlvbiB3b3VsZCByZXN1bHQgaW4gYGBJTlRfTUlOYGAg
ZGl2aWRpbmcgLTEsIHRoZQ0KPiArZGl2aWRlZCBieSAtMSwgdGhlIGRlc3RpbmF0aW9uIHJlZ2lz
dGVyIGlzIGluc3RlYWQgc2V0IHRvIGBgTExPTkdfTUlOYGAuIEZvcg0KPiArYGBBTFVgYCwgaWYg
ZXhlY3V0aW9uIHdvdWxkIHJlc3VsdCBpbiBgYElOVF9NSU5gYCBkaXZpZGVkIGJ5IC0xLCB0aGUN
Cj4gICBkZXN0aW5hdGlvbiByZWdpc3RlciBpcyBpbnN0ZWFkIHNldCB0byBgYElOVF9NSU5gYC4N
Cj4gICANCj4gICBJZiBleGVjdXRpb24gd291bGQgcmVzdWx0IGluIG1vZHVsbyBieSB6ZXJvLCBm
b3IgYGBBTFU2NGBgIHRoZSB2YWx1ZSBvZg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZA
aWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5v
cmcK

