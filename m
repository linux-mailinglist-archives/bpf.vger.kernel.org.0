Return-Path: <bpf+bounces-44392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A69C26A0
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B481C21E93
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A221C3F00;
	Fri,  8 Nov 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yklToKvU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yklToKvU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjrGAJPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1D1AA1FA
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098073; cv=none; b=nF3d0ggmqY9KYWt4XsueZU6WNd9LcFBH76wC//kNTjH1nijuTptsDLu/dVqLJITtH30GUMV3boLiWonnR6/jfCmCyNYCVwRq+n8aUAFxttenQSQ4Bf9wJWBkiy8366Cl8/dDU+/7JAaxjKzp/RxfnV8yeZK1+LMUp6gf7m3WtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098073; c=relaxed/simple;
	bh=aH4E3xOUNmDXehEPnN14wySc7CWnsHAq4rKXteTp950=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=Ufp+HWtXTyHj4YasdDJ629i0KsH8871qfDa7A98iREUNB48vXHYnMTv0yBijYHU9Ln0qEewY3K58OJD9GMQu2ZgVTR415knLIZM64SjVfs8vPrNoB78MoFyWysRwlSwNK1AbTIxdUJHXKKRrgPgehtPwn/Y8PY6Pf9fYKgb2SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yklToKvU; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yklToKvU; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjrGAJPx reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7F909C1E0D80
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731098070; bh=aH4E3xOUNmDXehEPnN14wySc7CWnsHAq4rKXteTp950=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=yklToKvUfB0AUr2MnTHpfg3aHp+YOiND7e7cyMDKrSQEdx8U0OCuynZhMHG7dsGlX
	 HzkKvkrEYNqY3tGzNMSImhKuRN8/lYSh3s0seecN7paYUTzbkcT/+BG3bzq2mL48OI
	 lBLAe6OmfxXP8+/1E6AxfFzYh2bK5dmifF0RDaow=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Fri Nov  8 12:34:30 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 511E4C1E0D96
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1731098070; bh=aH4E3xOUNmDXehEPnN14wySc7CWnsHAq4rKXteTp950=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=yklToKvUfB0AUr2MnTHpfg3aHp+YOiND7e7cyMDKrSQEdx8U0OCuynZhMHG7dsGlX
	 HzkKvkrEYNqY3tGzNMSImhKuRN8/lYSh3s0seecN7paYUTzbkcT/+BG3bzq2mL48OI
	 lBLAe6OmfxXP8+/1E6AxfFzYh2bK5dmifF0RDaow=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
	by ietfa.amsl.com (Postfix) with ESMTP id 6A80DC14F6F3
	for <bpf@ietfa.amsl.com>; Fri,  8 Nov 2024 12:34:19 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.104
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
	by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47aEshaL4k-F for <bpf@ietfa.amsl.com>;
	Fri,  8 Nov 2024 12:34:15 -0800 (PST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by ietfa.amsl.com (Postfix) with ESMTPS id 946EDC1516F8
	for <bpf@ietf.org>; Fri,  8 Nov 2024 12:34:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so29762205e9.2
        for <bpf@ietf.org>; Fri, 08 Nov 2024 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098054; x=1731702854; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5qH54nQAIEd/FZEboYHabkBp2OxI8z+hX3S+2K65CA=;
        b=VjrGAJPxhyMrFKjmGeu56ciOK8YGlVGUZrUFv1AEGQ9Iyj7ZQG8dwa9Dthmi1fWYSd
         UVowip+RKJ7zGMvjmGArPiErFnwbwXcLW8UqKBC5qcEISLnqbvcJmQIkRD2StzwGUBBo
         ZEfXufXbgq7Sf8+upGBFE07yEKNrTp+Nny0B5CyJM4RNcLmHc6Gf8kUOyfSLCOjrU21h
         rMYe6vUjcbN2V/kf9queB24m6ebQmn2K4R5hbiNjKj/xkxAf4f2V8jUve9t/r8zPWujF
         3J6D1HL0f0+w2fu4Vc/7+x03hoD2NmB8rpX5d0r86JpWAZSvK2Y3qRWYsV5zuY1UIdZX
         9UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098054; x=1731702854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5qH54nQAIEd/FZEboYHabkBp2OxI8z+hX3S+2K65CA=;
        b=H/XK9yIuN8TgMJMHytp0FLwXRQzQEVrOFldC1tsy6Zv7aZuD3JEACbReRh9LcY8OzU
         FJlWDH9g8DUrB7TA8Fu5MyGMpRg8s4nvdWnR9Gdeq7p8BWvuysJGC8Yu+12TBoEXlM0f
         VxFyKpJWktVsR150uIBTVMrWR7U+Tt6AwLfYNazKuSomtFHwC2J8iWTrn33WJsoqQCm1
         oUsesN5yolLhAtfiyILssunYay7wZcuPkzCMbMHWqxKwPSpM+2EJUEggQMb3MwWVBLxx
         jX9v/hHdoSZk0phJ0NhOpNEaQYwYy0hp+9/X+L3/2JVP1FYd8ZxcGccPddHpJ3QGwkiO
         74tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHzGT4/sxd5wBhAoMqaX5mYdq3wcIXcpSdWzLvfY4az/qSUkUSWyOaDqeLwgcSb3jRnYI=@ietf.org
X-Gm-Message-State: AOJu0Ywgz3HtdAEB9SUBkUrGa93T7J5DSqQF1jV33bJfzH5GS7NUt3Jn
	djGDkumv56YBZ8jIk/9LFmB8cqMUkP1xUl/NhU9GYAkS21dgA1eOziKc5k20E3mb7d6xUGRnwvu
	GRUvNUVbEhvGrCxngx2w/fzgor48=
X-Google-Smtp-Source: 
 AGHT+IFAI5rkjwf1qSkM1nPz7ZF1K2LzjOZH6ZWfrLKk3ZNN/1SCNN3lfVwdqwAIvZfgLCSWzgSlKquxukpYnXl0fAU=
X-Received: by 2002:a05:600c:458d:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-432b7505acemr44716725e9.12.1731098053536; Fri, 08 Nov 2024
 12:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927033904.2702474-1-yonghong.song@linux.dev>
 <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com>
 <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
 <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
 <CAADnVQKDwZ0+Fjiz21AFAbOgEonVojvpojU1ZyQDu8V4Jm0DYQ@mail.gmail.com>
 <000c01db3186$1dd30930$59791b90$@gmail.com>
 <CAADnVQKHHvrJjAMuXC5-wQHfMfxoSXnOBnqrZ5PC7p3C8ut3rQ@mail.gmail.com>
 <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
In-Reply-To: <09ee01db320f$8d37bc60$a7a73520$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 12:34:02 -0800
Message-ID: 
 <CAADnVQLbk9ogKn8kHBGiq8yNuugNQTfMcd5m9RHc9KmZhrxmNw@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Message-ID-Hash: SM5UVCT4S6KW572ULOF3JYH4ZXJHW6PG
X-Message-ID-Hash: SM5UVCT4S6KW572ULOF3JYH4ZXJHW6PG
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Yonghong Song <yonghong.song@linux.dev>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_docs/bpf=3A_Document_some_spe?=
	=?utf-8?q?cial_sdiv/smod_operations?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/E4vJjzjzj1txlHe-MjDYyEDyhZ0>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBOb3YgOCwgMjAyNCBhdCAxMDo1M+KAr0FNIERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2
OEBnb29nbGVtYWlsLmNvbT4gd3JvdGU6DQo+DQo+ID4gPg0KPiA+ID4gTXkgY29uY2VybiBpcyB0
aGF0IGluZGV4LnJzdCBzYXlzOg0KPiA+ID4gPiBUaGlzIGRpcmVjdG9yeSBjb250YWlucyBkb2N1
bWVudHMgdGhhdCBhcmUgYmVpbmcgaXRlcmF0ZWQgb24gYXMgcGFydA0KPiA+ID4gPiBvZiB0aGUg
QlBGIHN0YW5kYXJkaXphdGlvbiBlZmZvcnQgd2l0aCB0aGUgSUVURi4gU2VlIHRoZSBgSUVURiBC
UEYNCj4gPiA+ID4gV29ya2luZyBHcm91cGBfIHBhZ2UgZm9yIHRoZSB3b3JraW5nIGdyb3VwIGNo
YXJ0ZXIsIGRvY3VtZW50cywgYW5kIG1vcmUuDQo+ID4gPg0KPiA+ID4gU28gaGF2aW5nIGEgZG9j
dW1lbnQgdGhhdCBpcyBOT1QgcGFydCBvZiB0aGUgSUVURiBCUEYgV29ya2luZyBHcm91cA0KPiA+
ID4gd291bGQgc2VlbSBvdXQgb2YgcGxhY2UgYW5kLCBpbiBteSB2aWV3LCBiZXR0ZXIgbG9jYXRl
ZCB1cCBhIGxldmVsIChvdXRzaWRlDQo+ID4gc3RhbmRhcmRpemF0aW9uKS4NCj4gPg0KPiA+IEl0
J3MgYSBwYXJ0IG9mIGJwZiB3Zy4gSXQncyBub3QgYSBuZXcgZG9jdW1lbnQuDQo+DQo+IFJGQyA5
NjY5IGlzIGltbXV0YWJsZS4gIEFueSBhZGRpdGlvbnMgcmVxdWlyZSBhIG5ldyBkb2N1bWVudCwg
aW4NCj4gSUVURiB0ZXJtaW5vbG9neSwgc2luY2Ugd291bGQgcmVzdWx0IGluIGEgbmV3IFJGQyBu
dW1iZXIuDQoNClN1cmUuIEl0J3MgYW4gSUVURiBwcm9jZXNzLiBOb3QgYXJndWluZyBhYm91dCB0
aGF0Lg0KDQo+ID4gPiBIZXJl4oCZcyBzb21lIGV4YW1wbGVzIG9mIGRlbHRhLWJhc2VkIFJGQ3Mg
d2hpY2ggZXhwbGFpbiB0aGUgZ2FwIGFuZA0KPiA+ID4gcHJvdmlkZSB0aGUgYWRkaXRpb24gb3Ig
Y2xhcmlmaWNhdGlvbiwgYW5kIGZvcm1hbGx5IFVwZGF0ZSAobm90DQo+ID4gPiByZXBsYWNlL29i
c29sZXRlKSB0aGUgb3JpZ2luYWwNCj4gPiA+IFJGQzoNCj4gPiA+ICogaHR0cHM6Ly93d3cucmZj
LWVkaXRvci5vcmcvcmZjL3JmYzY1ODUuaHRtbDogQWRkaXRpb25hbCBIVFRQIFN0YXR1cw0KPiA+
ID4gQ29kZXMNCj4gPiA+ICogaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzY4NDAu
aHRtbDogQ2xhcmlmaWNhdGlvbnMgYW5kIEltcGxlbWVudGF0aW9uDQo+ID4gTm90ZXMNCj4gPiA+
ICAgIGZvciBETlMgU2VjdXJpdHkgKEROU1NFQykNCj4gPiA+ICogaHR0cHM6Ly93d3cucmZjLWVk
aXRvci5vcmcvcmZjL3JmYzkyOTUuaHRtbDogQ2xhcmlmaWNhdGlvbnMgZm9yIEVkMjU1MTksIEVk
NDQ4LA0KPiA+ID4gICAgWDI1NTE5LCBhbmQgWDQ0OCBBbGdvcml0aG0gSWRlbnRpZmllcnMNCj4g
PiA+ICogaHR0cHM6Ly93d3cucmZjLWVkaXRvci5vcmcvcmZjL3JmYzU3NTYuaHRtbDogVXBkYXRl
cyBmb3IgUlNBRVMtT0FFUCBhbmQNCj4gPiA+ICAgIFJTQVNTQS1QU1MgQWxnb3JpdGhtIFBhcmFt
ZXRlcnMNCj4gPiA+DQo+ID4gPiBIYXZpbmcgYSBmdWxsIGRvY3VtZW50IHRvbyBpcyB2YWx1YWJs
ZSBidXQgdW5sZXNzIHRoZSBJRVRGIEJQRiBXRw0KPiA+ID4gZGVjaWRlcyB0byB0YWtlIG9uIGEg
LWJpcyBkb2N1bWVudCwgSSdkIHN1Z2dlc3Qga2VlcGluZyBpdCBvdXQgb2YgdGhlDQo+ID4gInN0
YW5kYXJkaXphdGlvbiINCj4gPiA+IChzYXkgdXAgMSBsZXZlbCkgdG8gYXZvaWQgY29uZnVzaW9u
LCBhbmQganVzdCBoYXZlIG9uZSBvciBtb3JlDQo+ID4gPiBkZWx0YS1iYXNlZCByc3QgZmlsZXMg
aW4gdGhlIHN0YW5kYXJkaXphdGlvbiBkaXJlY3RvcnkuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGlz
IGVmZmVjdGl2ZWx5IGEgZml4IHRvIHRoZSBzdGFuZGFyZC4NCj4NCj4gVHdvIG9mIHRoZSBleGFt
cGxlcyBJIHByb3ZpZGVkIGFib3ZlIGZpdCBpbnRvIHRoYXQgY2F0ZWdvcnkuDQo+IFR3byBhcmUg
ZXhhbXBsZXMgb2YgYWRkaW5nIG5ldyBjb2RlcG9pbnRzLg0KPg0KPiA+IEl0J3MgYSBzdGFuZGFy
ZCBnaXQgZGV2ZWxvcG1lbnQgcHJvY2VzcyB3aGVuIGZpeGVzIGFyZSBhcHBsaWVkIHRvIHRoZSBl
eGlzdGluZw0KPiA+IGRvY3VtZW50Lg0KPiA+IEZvcmtpbmcgdGhlIHdob2xlIGRvYyBpbnRvIGEg
ZGlmZmVyZW50IGZpbGUganVzdCB0byBhcHBseSBmaXhlcyBtYWtlcyBubyBzZW5zZSB0byBtZS4N
Cj4NCj4gV2VsY29tZSB0byB0aGUgSUVURiBhbmQgaW1tdXRhYmxlIFJGQ3Mg8J+Yig0KPg0KPiA+
IFRoZSBmb3JtYWwgZGVsdGEtcyBmb3IgSUVURiBjYW4gYmUgY3JlYXRlZCBvdXQgb2YgZ2l0Lg0K
Pg0KPiBOb3QgaW4gdGhlIElFVEYgcGVyIHNlLCBzaW5jZSBhIG5ldyBkb2N1bWVudCBuZWVkcyBu
ZXcgYm9pbGVycGxhdGUsIHdpdGgNCj4gYSBuZXcgYWJzdHJhY3QsIGludHJvZHVjdGlvbiwgZXRj
LiAgQXQgbW9zdCwgcGFydCBvZiB0aGUgZG9jdW1lbnQgY291bGQgYmUgY3JlYXRlZA0KPiBvdXQg
b2YgZ2l0LCBidXQgSSdtIG5vdCBjb252aW5jZWQgdGhhdCBnaXQgZGlmZnMgYWxvbmUgKGFzIG9w
cG9zZWQgdG8gc29tZSBFbmdsaXNoDQo+IHByb3NlIHRvbyBmb3IgZWFjaCwgYXMgaW4gdGhlIGV4
YW1wbGVzIEkgY2l0ZWQpIG1ha2UgZm9yIGdvb2QgY29udGVudCBpbiBhbiBJRVRGIGRvY3VtZW50
Lg0KDQpnaXQgZGlmZiBtaWdodCBuZWVkIGFub3RoZXIgc2NyaXB0IDopDQpKdXN0IGxpa2UgeW91
IGRpZCBlYXJsaWVyIHdpdGggYW4gb2xkIHNjcmlwdCB0aGF0IHRvb2sgdGhpcyAucnN0DQphbmQg
Y29udmVydGVkIGl0IHRvIElFVEYgc3VpdGFibGUgZm9ybWF0Lg0KDQpOb3cgd2UnZCBuZWVkIGEg
bmV3IHNjcmlwdCB0aGF0IHdpbGwgdGFrZSBnaXQgZGlmZiB3aXRoIG5ldyBoZWFkZXIvZm9vdGVy
DQphbmQgd2hhdGV2ZXIgZXh0cmEgd29yZHMgbmVjZXNzYXJ5Lg0KDQo+ID4gV2Ugb25seSBuZWVk
IHRvIHRhZyB0aGUgY3VycmVudCB2ZXJzaW9uIGFuZCB0aGVuIGdpdCBkaWZmIHJmYzk2NjlfdGFn
Li5IRUFEIHdpbGwgZ2l2ZQ0KPiA+IHVzIHRoYXQgZGVsdGEuDQo+ID4gVGhhdCB3aWxsIHNhdGlz
ZnkgSUVURiBwcm9jZXNzIGFuZCB3b24ndCBtZXNzIHVwIG5vcm1hbCBnaXQgc3R5bGUga2VybmVs
DQo+ID4gZGV2ZWxvcG1lbnQuDQo+DQo+IEkgYW0gbm90IGNvbnZpbmNlZCBpdCBpcyBzdWZmaWNp
ZW50LiAgQ2FuIHlvdSBwb2ludCB0byBhbnkgcHJlY2VkZW50cyBpbiB0aGUgSUVURiBmb3INCj4g
c3VjaCBhbiBhcHByb2FjaD8gIEkgY2FuJ3Qgb2ZmaGFuZC4uLiBTZWUgdGhlIFJGQyA1NzU2IHJl
ZmVyZW5jZSBhYm92ZSBmb3Igd2hhdA0KPiBJIG1lYW4gYnkgRW5nbGlzaCBwcm9zZSBmb3IgZWFj
aCBkaWZmLg0KDQpJdCdzIGFsbCBhIG1hdHRlciBvZiBhZGRpdGlvbmFsIHNjcmlwdGluZy4NCldl
J3JlIG5vdCBnb2luZyB0byBhc2sgZXZlcnkga2VybmVsIGRldmVsb3BlciB0byBsZWFybiBJRVRG
IHByb2Nlc3MuDQpQZW9wbGUgd2lsbCBiZSBzZW5kaW5nIHBhdGNoZXMgZm9yIGluc3RydWN0aW9u
LXNldC5yc3QgYW5kDQp0aGlzIGZpbGUgd2lsbCBrZWVwIGV2b2x2aW5nLg0KQXMgc29vbiBhcyB3
ZSBsYW5kIFlvbmdob25nJ3MgcGF0Y2ggaXQgd29uJ3QgYmUgMS0xIHdpdGggUkZDOTY2OSBhbmQN
Cml0J3MgZmluZS4NCkV2ZW4gdG9kYXkgaXQncyBub3QgMS0xIGVpdGhlci4gSXQgbmVlZHMgdG8g
Z28gdGhyb3VnaCB5b3VyDQpleGlzdGluZyBzY3JpcHQgdG8gZml0IElFVEYgcnVsZXMuDQpUaGUg
bmV3IHBhdGNoZXMgd2lsbCBrZWVwIGxhbmRpbmcgYW5kIHRoZSBmaWxlIHdpbGwgYmVjb21lIGEg
d29ya2luZw0KZG9jdW1lbnQgdG93YXJkcyB0aGUgbmV4dCBkZWx0YSBSRkMuDQoNCj4gPiBidHcg
ZG8gd2Ugc3RpbGwgbmVlZCB0byBkbyBhbnkgbWlub3IgZWRpdC9maXhlcyB0byBpbnN0cnVjdGlv
bi1zZXQucnN0IGJlZm9yZSB0YWdnaW5nIGl0DQo+ID4gYXMgUkZDOTY2OSA/DQo+DQo+IFllcywg
d2UgbmVlZCB0byBiYWNrcG9ydCB0aGUgZm9ybWF0dGluZy9uaXRzIGZyb20gdGhlIFJGQyBlZGl0
b3IgcGFzcy4NCg0KT2suIFBsZWFzZSBzZW5kIHRoZSBwYXRjaC4gV2lsbCB3YWl0IGZvciB0aGF0
IGZpcnN0Lg0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZAaWV0Zi5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5vcmcK

