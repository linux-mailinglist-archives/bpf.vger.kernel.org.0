Return-Path: <bpf+bounces-30493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944958CE6CD
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4BDB20FDE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422C12C47E;
	Fri, 24 May 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="PHc06FDm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="O4Sjc5eq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DBF1h+IO"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BE63CB
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560129; cv=none; b=hxoLjiZVrhfEW7j2wkIB7RYqWv2iMRvi/5r+bqBI3i7Crul9ZZsfO9KVygm27m+uHwKQEGzIdKP3O6YHfIQrU9exUrM3VB/L/N1373BsG63LgSWr5WGC5YdpI802dhTOrzuSwbN3sU1FrQTpet4rQb5gqK5mKtubVd4OIqBF7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560129; c=relaxed/simple;
	bh=kZmFlMjG+bx0DVaR7cJn7YbQzchMMbhu1Der2rDS7zU=;
	h=To:References:In-Reply-To:Date:Message-ID:MIME-Version:CC:Subject:
	 Content-Type:From; b=U5DP8BKrgZQrGzUAZwxzUBj1zYKBPZbOl9K0a784qjWkqBtWVrvIMHRHpI1HwKSxfFuz/2HHhD6iPQaqmEADun41biJXbmQQl+p/6xKeZypVVaRr/zT8iSN0aSAY2RfYNqv6Tkj+MZUPTbPnsVeM6gG3gE247AYcH44T5juQMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=PHc06FDm; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=O4Sjc5eq reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DBF1h+IO reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 52128C1DA1ED
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716560121; bh=kZmFlMjG+bx0DVaR7cJn7YbQzchMMbhu1Der2rDS7zU=;
	h=To:References:In-Reply-To:Date:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=PHc06FDmRln+GmR9yKiEVjO/vpfybYlmgL/NPSxO28oxyo23Tp2SuZXgAL6M5dzTB
	 r9kBowjVV7NIFVj7NQB8isernNSFiYprZermJ+YOF/dXn9bHtG5i+kFUgOI7zdbf5A
	 RCrJ3ta/jXwagIrAaWw4Iaky7i4a/ab9AFq4e5VI=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 43029C1930B0
 for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716560121; bh=kZmFlMjG+bx0DVaR7cJn7YbQzchMMbhu1Der2rDS7zU=;
 h=From:To:References:In-Reply-To:Date:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=O4Sjc5eqbU0+3wQ3yzc9EeYEOS0RPd1AY01I7nYi2DYeYzcdV/XsTyHj/UiI4p6HB
 PBwHkhlocgd8b0r43Rw8fZ42PY1F/fgiJENzK1UNM0I3rWWyBWD+uODHFeaiNIVLLm
 jW0HSd+J64Y/Ktg3v1TyM/qkPcCUrX2rznacq1M8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1453BC1D6FCE;
 Fri, 24 May 2024 07:15:16 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.846
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FUkDZ72SiItA; Fri, 24 May 2024 07:15:11 -0700 (PDT)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6ADE2C1930B0;
 Fri, 24 May 2024 07:15:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f449ed4b89so6628085ad.0;
 Fri, 24 May 2024 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1716560110; x=1717164910;
 darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KSpHyoXQyrWQ7YpniL++kWwmn1IU/Ue+KamaV2Z1ewg=;
 b=DBF1h+IObqj6SMQjqsS4CTtINvFb38RQaQo1T48ROLCk1b3Mp8tGM+OcKaA3jrOa4r
 zlaDoP5dYXicU4MLpWZdGBPJjqIPegrgnZLQlvmktrIODUns2fMr60CBLMbo6vq6UrRb
 fhgrbbnzW4tlbYe7Jidz3qpyaI9iMdxaCbzuxAxsL0f7KnJbhGSGKOH9F5ttxAH79GNN
 MYL9wmt80H4HlQFoItJtYrxzfjwZDhOYgpMVRDXjxvtO/Rvk9TASmHaAIZcG6P+/7TA+
 Uhigm6uGWg+7rXpKIecnwf8in0vtHhnZiDchuV0ATAIqW7HeZr8HNdD4xPj3imzXgbk+
 J1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560110; x=1717164910;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSpHyoXQyrWQ7YpniL++kWwmn1IU/Ue+KamaV2Z1ewg=;
 b=rUweJcw4QKUFtNmflUH1iTt5xKpiDLGWEUjk1dlJA7kvaHf0NfESGFOmmhxG5XHDI1
 Gf5SFn+BLzbOo82FB57oP1Z+fE6FbxKNvrKv4JuH/aYGIjww/977QQzDG0ABX3Tax0V1
 bXUJam4WxN9XFaNYvszzFfOph+aoAg9BMqsXmgM9WqGsS8JraX/lV1AJDFtICKggqcie
 HxYjafufK8FvXCGrog5/iXGOVGZIsVwj6Ou0CI3ZozBoKoUg/MWyF+mxoDFEyUvw9uxy
 8HPvRJCDK3g/mxvlNtP0k5hubFUZPbnOVQ03+CxOx595dwUWwoalcAkkWf2SznqoIjVd
 YZ0w==
X-Gm-Message-State: AOJu0YzhPgO8NF6JAvPtdEfuWBXVpdAnEQMrRT5gbu425laJoosa/isS
 jMlp6XAsefCGvmBVqfdcFcIlQjxEVDhVG5H1YhhT5RtxwKv5BPp03JKLhKnt
X-Google-Smtp-Source: AGHT+IHxaxG3/nqN+f1ZywQsH++WuHgrLdfQcwjzXk7qipY/6uFHmnx/buQ4Ri15+XVWmTuHBCSYMw==
X-Received: by 2002:a17:902:e749:b0:1f3:642:9f5a with SMTP id
 d9443c01a7336-1f339ef522cmr76574365ad.6.1716560110109;
 Fri, 24 May 2024 07:15:10 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7c379dsm14353155ad.102.2024.05.24.07.15.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 May 2024 07:15:09 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <171588680595.59757.9400896368334392439@ietfa.amsl.com>
In-Reply-To: <171588680595.59757.9400896368334392439@ietfa.amsl.com>
Date: Fri, 24 May 2024 07:15:07 -0700
Message-ID: <0ce301daade4$c8a890d0$59f9b270$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHhYwHWHvkDI0nYzQ93mgSzZBpWQrGZAimg
Message-ID-Hash: E3GMLPBVIMUPREOU4XLTDTUVDFDJVRH2
X-Message-ID-Hash: E3GMLPBVIMUPREOU4XLTDTUVDFDJVRH2
X-MailFrom: dthaler1968@googlemail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: draft-ietf-bpf-isa.all@ietf.org,
 'Ines Robles' <mariainesrobles@googlemail.com>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_Genart_last_call_review_of_draft-ietf-bpf-isa-02?=
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbmVzIFJvYmxlcyB2aWEgRGF0
YXRyYWNrZXIgPG5vcmVwbHlAaWV0Zi5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTYsIDIw
MjQgMTI6MTMgUE0NCj4gVG86IGdlbi1hcnRAaWV0Zi5vcmcNCj4gQ2M6IGJwZkBpZXRmLm9yZzsg
ZHJhZnQtaWV0Zi1icGYtaXNhLmFsbEBpZXRmLm9yZzsgbGFzdC1jYWxsQGlldGYub3JnDQo+IFN1
YmplY3Q6IEdlbmFydCBsYXN0IGNhbGwgcmV2aWV3IG9mIGRyYWZ0LWlldGYtYnBmLWlzYS0wMg0K
PiANCj4gUmV2aWV3ZXI6IEluZXMgUm9ibGVzDQo+IFJldmlldyByZXN1bHQ6IFJlYWR5IHdpdGgg
Tml0cw0KPiANCj4gSSBhbSB0aGUgYXNzaWduZWQgR2VuLUFSVCByZXZpZXdlciBmb3IgdGhpcyBk
cmFmdC4gVGhlIEdlbmVyYWwgQXJlYSBSZXZpZXcNCj4gVGVhbSAoR2VuLUFSVCkgcmV2aWV3cyBh
bGwgSUVURiBkb2N1bWVudHMgYmVpbmcgcHJvY2Vzc2VkIGJ5IHRoZSBJRVNHIGZvcg0KPiB0aGUg
SUVURiBDaGFpci4gIFBsZWFzZSB0cmVhdCB0aGVzZSBjb21tZW50cyBqdXN0IGxpa2UgYW55IG90
aGVyIGxhc3QgY2FsbA0KPiBjb21tZW50cy4NCj4gDQo+IEZvciBtb3JlIGluZm9ybWF0aW9uLCBw
bGVhc2Ugc2VlIHRoZSBGQVEgYXQNCj4gDQo+IDxodHRwczovL3dpa2kuaWV0Zi5vcmcvZW4vZ3Jv
dXAvZ2VuL0dlbkFydEZBUT4uDQo+IA0KPiBEb2N1bWVudDogZHJhZnQtaWV0Zi1icGYtaXNhLTAy
DQo+IFJldmlld2VyOiBJbmVzIFJvYmxlcw0KPiBSZXZpZXcgRGF0ZTogMjAyNC0wNS0xNg0KPiBJ
RVRGIExDIEVuZCBEYXRlOiAyMDI0LTA1LTE2DQo+IElFU0cgVGVsZWNoYXQgZGF0ZTogTm90IHNj
aGVkdWxlZCBmb3IgYSB0ZWxlY2hhdA0KPiANCj4gU3VtbWFyeToNCj4gDQo+IFRoaXMgZG9jdW1l
bnQgc3BlY2lmaWVzIHRoZSBCUEYgaW5zdHJ1Y3Rpb24gc2V0IGFyY2hpdGVjdHVyZSAoSVNBKS4g
VGhlIGRvY3VtZW50DQo+IGlzIGNsZWFyIGFuZCB3ZWxsLXdyaXR0ZW4uIE5vIG1ham9yIGlzc3Vl
cyB3ZXJlIGZvdW5kLCBqdXN0IHNvbWUgbWlub3INCj4gc3VnZ2VzdGlvbnMuDQo+IA0KPiBNYWpv
ciBpc3N1ZXM6IE5vbmUNCj4gTWlub3IgaXNzdWVzOiBOb25lDQo+IE5pdHMvZWRpdG9yaWFsIGNv
bW1lbnRzOg0KPiANCj4gKiBJbiB0aGUgaW50cm9kdWN0aW9uLCBtYXliZT86ICJlQlBGICh3aGlj
aCBpcyBubyBsb25nZXIgYW4gYWNyb255bSBmb3IgYW55dGhpbmcpLA0KPiBhbHNvIGNvbW1vbmx5
IHJlZmVycmVkIHRvIGFzIEJQRiIgLS0+IGVCUEYgKHdoaWNoIG9yaWdpbmFsbHkgc3Rvb2QgZm9y
ICJleHRlbmRlZA0KPiBCZXJrZWxleSBQYWNrZXQgRmlsdGVyIiBidXQgaXMgbm8gbG9uZ2VyIGFu
IGFjcm9ueW0pLCBhbHNvIGNvbW1vbmx5IHJlZmVycmVkIHRvIGFzDQo+IEJQRi4uLg0KDQpUaGlz
IHNvdW5kcyByZWFzb25hYmxlIHRvIG1lIGJ1dCBhdCBvbmUgcG9pbnQgdGhlIEJQRiBTdGVlcmlu
ZyBDb21taXR0ZWUgKEJTQykNCmRpc2N1c3NlZCB0aGUgdGV4dCB0byBhcHBlYXIgb24gdGhlIGVC
UEYgRm91bmRhdGlvbiB3ZWJzaXRlIGF0DQpodHRwczovL2VicGYuZm91bmRhdGlvbi9lYnBmLXJl
c291cmNlcy8NCih3aGljaCBpcyB3aGVyZSB0aGUgcHJlc2VudCB0ZXh0IHRoZXJlIGNhbWUgZnJv
bSksIGFuZCBhdCB0aGUgdGltZSB0aGV5IGRpZCBub3Qgd2FudA0KdG8gc3RhdGUgdGhlIGV4cGFu
c2lvbi4NCg0KaHR0cHM6Ly9lYnBmLmlvL3doYXQtaXMtZWJwZi8jd2hhdC1kby1lYnBmLWFuZC1i
cGYtc3RhbmQtZm9yIG9uIHRoZSBvdGhlciBoYW5kIGRvZXMuDQoNCldoYXQgZG8gb3RoZXJzIHRo
aW5rIGFib3V0IEluZXMncyBzdWdnZXN0aW9uPw0KIA0KPiAqIEl0IHdvdWxkIGJlIG5pY2UgdG8g
YWRkIGNhcHRpb24gdG8gdGhlIHRhYmxlcyAoZnJvbSBUYWJsZSAzIHRvIFRhYmxlIDE4KS4NCg0K
Q2FuIGRvLg0KDQo+IFRoYW5rcyBmb3IgdGhpcyBkb2N1bWVudCwNCj4gDQo+IEluZXMNCg0KVGhh
bmtzIGZvciB0aGUgcmV2aWV3LA0KRGF2ZQ0KDQotLSAKQnBmIG1haWxpbmcgbGlzdCAtLSBicGZA
aWV0Zi5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBicGYtbGVhdmVAaWV0Zi5v
cmcK

