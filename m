Return-Path: <bpf+bounces-29703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4B8C5832
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F82CB22C90
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D017BB31;
	Tue, 14 May 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="RxryBjc+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="RJvrkE0y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gbbQvHuv"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D7158213
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697828; cv=none; b=Qv7oEWrb2ksE8dYRhvFrena2aTYWz6Pbh1WDW2jsVxWq4ZavZROcEtz+wZSOYdMQXBVbF/NDvPTAJD3AO+pSKFQdrYurCiXPhJ+dHO15SCv8NQwk2mQhrEyZ3+JfBAqe2g2nLukgz0Jnu7ecQkznBCW0vu7yy73lsh/k2ccQc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697828; c=relaxed/simple;
	bh=dq1kPiJdd+4gA/Mkf5mO9+SYVHHGKB+cHbInD9iRCAY=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=j7t6oVtYBYaC+geLWyJTNT8Sn/lqA/muX8pTNJ8vmIeby1JL48sUbj2+0wGyN2wbNrJkYrfTP2h6qyBnXHcXEwq43qTOGHOUI3MocanYs3aGZLA7yCGUvTA4t5Fi6heIY6WEfx1avNfWiZExaeUIuAhMM1LI2bOiGdrUChzPXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=RxryBjc+; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=RJvrkE0y reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gbbQvHuv reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0FB92C151525
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1715697306; bh=dq1kPiJdd+4gA/Mkf5mO9+SYVHHGKB+cHbInD9iRCAY=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RxryBjc+d1R5RNiO7PnjUG6HOlkQYTgOLAnMKC07BPMeGY6pAqjBr3+mQc656fkqI
	 8gXmx0BWdAapdXhndsg/ID1seIZSzwU106SSkKRvd5KgEU54k9IQ3M1wssYwhgbLip
	 hrxfRSNbrWoHLI2QWYonRXPtF3wlaAzPO95Nuhn0=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id E7271C180B53
 for <bpf@vger.kernel.org>; Tue, 14 May 2024 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1715697305; bh=dq1kPiJdd+4gA/Mkf5mO9+SYVHHGKB+cHbInD9iRCAY=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=RJvrkE0yOxFOJxaa5/QlEvvu1TBJj2tgVPyhanOdDrTSbTSu5ey69RaFObjAym2Vc
 agdRPki02XDhQ2kFN9kwcs7vwcNtPcqLkiUbW2QkQCRsWljker4pJr7RkiXvJSjxvT
 wRoyRj/3YOt65WuKAoowc7lOMxZOmkCsP7i69ZpI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1D78AC14F609
 for <bpf@ietfa.amsl.com>; Tue, 14 May 2024 07:34:56 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06IyiMkegH3v for <bpf@ietfa.amsl.com>;
 Tue, 14 May 2024 07:34:52 -0700 (PDT)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 69CA5C1CADE3
 for <bpf@ietf.org>; Tue, 14 May 2024 07:33:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f457853950so4411331b3a.0
 for <bpf@ietf.org>; Tue, 14 May 2024 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1715697238; x=1716302038;
 darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Iq8lh+ioOW1FpEAVtAaznZbqqApHq44z6sdGCsyHXFA=;
 b=gbbQvHuv0ai7ZeNCuTy2SFdzm9P1Cj/weyahArQGqDXr/3i0uAQrssOGGUcQcRIUyA
 n37lRd/3MY9rtBWu/cy34dtMqlE5xo0VdgRIe0UkG8cmFDfWynLXF3PCoUVlMFTp/62T
 ZlkAe8zqaLyGGe2AnFfB6IkAjrzF3xdPSkkayuPczJ977zdS8FV24pO8G2c++QajKiaJ
 coMQ75IyAdZ38LOhMZy2SyT0uj0N+2jGQBahaFJAeQGU479L2bxS9DTaMSKMbLPiLsC/
 icBcaK6WwsylD5PKCIIanqREIUDZ5jbE7X7TYvd/yuX3B7RAAWbTLvpK4ZOe46p/uMbQ
 bQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715697238; x=1716302038;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iq8lh+ioOW1FpEAVtAaznZbqqApHq44z6sdGCsyHXFA=;
 b=W629MP2tOWgc5pQvV1Kyc+Q5+tath+QP/78nLEcq/2tPG6tlyDrLakh7jk1zNjqF+l
 CPIC5ya75ZkOfuSXOzOfqUPNchoOgHsjUSiFLFlrczT+hz157tCBnQbGWyb/BJG7NVno
 iajzqG7phecArcQcsnajVYYakENEFXUY2SbHjswbEi2q03x/qd3FW7n2UgbhWsoPRX9k
 LYbHv8Gl6d8QXCoTyAbiVwR39Cf6lmeInV6IrOBLeNmK1ut4Rfto91/ixT/N3J5TadOX
 /JX4bH5YWlNeUQynmx/ogg2JhneFrP82XiYbGS8ypBdQCLfuTY3K4DmoIVlqIyOBSwrl
 XhZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx0NK42xSpZp5NJIdZhesPOczqKwlgEsplJRcvMYGxCjRK8jK0eICTClQN/iJTBeBQXcSio1oixcukF/Y=
X-Gm-Message-State: AOJu0Yy/aUHTCKBkXH9NOff//9KrbQg0kMf9yoFBgOI5difSDbhzGesW
 CM7/KCKElmZ+y2eCM+w3L7Ow2xLCPQC42YlyTbhc02Am+qkuxVEU
X-Google-Smtp-Source: AGHT+IEhEBfxmSCDQ+qNmAfruffGpVnoNO3Uk5u3oWLvN0oE6s/d9cI16dDjXJDX2fpa2A9RSrERMQ==
X-Received: by 2002:a17:90a:7103:b0:2b6:215b:e236 with SMTP id
 98e67ed59e1d1-2b6c76f97b7mr19309942a91.23.1715697237523;
 Tue, 14 May 2024 07:33:57 -0700 (PDT)
Received: from ArmidaleLaptop ([50.204.89.30])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b99c5eea97sm976337a91.52.2024.05.14.07.33.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2024 07:33:57 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Puranjay Mohan'" <puranjay@kernel.org>,
 "'David Vernet'" <void@manifault.com>,
 "'Alexei Starovoitov'" <ast@kernel.org>,
 "'Daniel Borkmann'" <daniel@iogearbox.net>,
 "'Andrii Nakryiko'" <andrii@kernel.org>,
 "'Martin KaFai Lau'" <martin.lau@linux.dev>,
 "'Eduard Zingerman'" <eddyz87@gmail.com>, "'Song Liu'" <song@kernel.org>,
 "'Yonghong Song'" <yonghong.song@linux.dev>,
 "'John Fastabend'" <john.fastabend@gmail.com>,
 "'KP Singh'" <kpsingh@kernel.org>, "'Stanislav Fomichev'" <sdf@google.com>,
 "'Hao Luo'" <haoluo@google.com>, "'Jiri Olsa'" <jolsa@kernel.org>,
 "'Jonathan Corbet'" <corbet@lwn.net>,
 "'Dave Thaler'" <dthaler1968@googlemail.com>,
 "'Will Hawkins'" <hawkinsw@obs.cr>, <bpf@vger.kernel.org>, <bpf@ietf.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240514130303.113607-1-puranjay@kernel.org>
In-Reply-To: <20240514130303.113607-1-puranjay@kernel.org>
Date: Tue, 14 May 2024 08:33:55 -0600
Message-ID: <019c01daa60b$c08873b0$41995b10$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMgS3ITkG+5x2/Y13ejOoDX0Q3k4K8LgGnA
Content-Language: en-us
Message-ID-Hash: PDI4IOXPSE74H6XEJJOK2VHBEQMAODC2
X-Message-ID-Hash: PDI4IOXPSE74H6XEJJOK2VHBEQMAODC2
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: puranjay12@gmail.com
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf=5D_bpf=2C_docs=3A_Fix_the_description?=
 =?utf-8?q?_of_=27src=27_in_ALU_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/SsxwrHc_oEUSE-Jxbka5Ur6kyMo>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

UHVyYW5qYXkgTW9oYW4gPHB1cmFuamF5QGtlcm5lbC5vcmc+IHdyb3RlOiANCj4gQW4gQUxVIGlu
c3RydWN0aW9uJ3Mgc291cmNlIG9wZXJhbmQgY2FuIGJlIHRoZSB2YWx1ZSBpbiB0aGUgc291cmNl
DQpyZWdpc3RlciBvciB0aGUNCj4gMzItYml0IGltbWVkaWF0ZSB2YWx1ZSBlbmNvZGVkIGluIHRo
ZSBpbnN0cnVjdGlvbi4gVGhpcyBpcyBjb250cm9sbGVkIGJ5DQp0aGUgJ3MnIGJpdCBvZg0KPiB0
aGUgJ29wY29kZScuDQo+IA0KPiBUaGUgY3VycmVudCBkZXNjcmlwdGlvbiBleHBsaWNpdGx5IHVz
ZXMgdGhlIHBocmFzZSAndmFsdWUgb2YgdGhlIHNvdXJjZQ0KcmVnaXN0ZXInDQo+IHdoZW4gZGVm
aW5pbmcgdGhlIG1lYW5pbmcgb2YgJ3NyYycuDQo+IA0KPiBDaGFuZ2UgdGhlIGRlc2NyaXB0aW9u
IHRvIHVzZSAnc291cmNlIG9wZXJhbmQnIGluIHBsYWNlIG9mICd2YWx1ZSBvZiB0aGUNCnNvdXJj
ZQ0KPiByZWdpc3RlcicuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQdXJhbmpheSBNb2hhbiA8cHVy
YW5qYXlAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IERhdmUgVGhhbGVyIDxkdGhhbGVyMTk2OEBn
bWFpbC5jb20+DQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24v
aW5zdHJ1Y3Rpb24tc2V0LnJzdCB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gYi9Eb2N1bWVudGF0
aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdA0KPiBpbmRleCBhNWFi
MDBhYzBiMTQuLjJlMTdiMzY1Mzg4ZSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9icGYv
c3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QNCj4gQEAgLTI5Miw4ICsy
OTIsOSBAQCBBcml0aG1ldGljIGluc3RydWN0aW9ucyAgYGBBTFVgYCB1c2VzIDMyLWJpdCB3aWRl
DQo+IG9wZXJhbmRzIHdoaWxlIGBgQUxVNjRgYCB1c2VzIDY0LWJpdCB3aWRlIG9wZXJhbmRzIGZv
ciAgb3RoZXJ3aXNlDQppZGVudGljYWwNCj4gb3BlcmF0aW9ucy4gYGBBTFU2NGBgIGluc3RydWN0
aW9ucyBiZWxvbmcgdG8gdGhlDQo+ICBiYXNlNjQgY29uZm9ybWFuY2UgZ3JvdXAgdW5sZXNzIG5v
dGVkIG90aGVyd2lzZS4NCj4gLVRoZSAnY29kZScgZmllbGQgZW5jb2RlcyB0aGUgb3BlcmF0aW9u
IGFzIGJlbG93LCB3aGVyZSAnc3JjJyBhbmQgJ2RzdCcNCnJlZmVyIC10byB0aGUNCj4gdmFsdWVz
IG9mIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHJlZ2lzdGVycywgcmVzcGVjdGl2ZWx5Lg0K
PiArVGhlICdjb2RlJyBmaWVsZCBlbmNvZGVzIHRoZSBvcGVyYXRpb24gYXMgYmVsb3csIHdoZXJl
ICdzcmMnIHJlZmVycyB0bw0KPiArdGhlIHRoZSBzb3VyY2Ugb3BlcmFuZCBhbmQgJ2RzdCcgcmVm
ZXJzIHRvIHRoZSB2YWx1ZSBvZiB0aGUgZGVzdGluYXRpb24NCj4gK3JlZ2lzdGVyLg0KPiANCj4g
ID09PT09ICA9PT09PSAgPT09PT09PQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICBuYW1lICAgY29kZSAgIG9mZnNldCAgIGRl
c2NyaXB0aW9uDQo+IC0tDQo+IDIuNDAuMQ0KDQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJw
ZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRm
Lm9yZwo=

