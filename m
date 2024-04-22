Return-Path: <bpf+bounces-27460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C642F8AD48E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512141F25250
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A301552E8;
	Mon, 22 Apr 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ksOzgxK2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="mHTMnilY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBa84No0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEE219E0
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812575; cv=none; b=aoYR9A3nm6xOyWNjk7s7m4Gs5BjJsqjaP9q52+Wz2oT9Qp1fDlHGUD0kly9ZcD/8Iz27XgnphxjWFJqLNDmW5Jjo/mbQEnlmpdw2j9t26no1wQAR4Kojj4YX7/4mZZ92d9u7TH7EKmQ2TEieHLroRcgYjSOc6ZyPVY6pyIcHwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812575; c=relaxed/simple;
	bh=F8oG3P0L8sXrEDlQ0izlSpa1j2DqNReGd01mAM/YyZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=pTG1d/Dd5TwajvPOhboZ2gZEzpYQd2+jSv/5kNEuhOblDRFfUmL0cayxahd/pUg8CGCjZ3qWO2YuSIvUz/EebZ6DStwFfiTa87XmET+p/z98POwSABsAWItnWWNFexvYJlLKY4QlIZsU+eCupk1ZPw6uIJo4rx7do7HwFac1B64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ksOzgxK2; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=mHTMnilY; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBa84No0 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 25D5CC1D4A86
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713812573; bh=F8oG3P0L8sXrEDlQ0izlSpa1j2DqNReGd01mAM/YyZ0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ksOzgxK2cJl6JIl2kxGhnEzNfAzgRiFFjSv/VlE8Jf1GCg7QYHub67OAnvLOcLu3W
	 2SzqxWkbXqL2s+Xaw96+zwtR1fB3a+7LopBbRfjF5XJybWvMCbvqY9LZ7sYTP/cmh4
	 I4lsfg2EqoWxG2A0VFYo6MucDF4Er6uyRnrXWFkA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 12:02:53 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DB8DEC1840FE;
	Mon, 22 Apr 2024 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713812572; bh=F8oG3P0L8sXrEDlQ0izlSpa1j2DqNReGd01mAM/YyZ0=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=mHTMnilYkbfuzSGyQHqw29xHIcwaCqPxBC5JcZL7z9nYba58vIOPBdiFy6YL4sm/N
	 Mxde33uUuv909WLWAz/YZmcD6ppkzR56K58qbV9caZSsa+qZ3UCPUUdw/3AKDtwzRM
	 b9mLyaE20ZBaDfGw5LCId+/AEWLsTg3+Aqs4Tdcg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 992E4C1840D9
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 12:02:51 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEhF-aoJd_Gi for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 12:02:51 -0700 (PDT)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id E6602C1CAF4D
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:01:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41a72f3a20dso8101095e9.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713812506; x=1714417306; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUfQzjh5+xIuRNiKyJ8NbutxlsICHqqDcLaERMfZook=;
 b=cBa84No0y4McIecEvl64u/JWFNHyLhi4rQw9d+FG3prK8tNY4QgBh8C/jMtnEm1GVo
 efevCda+c4IsA4Uodw3K+WXZCQARJV56WQYqGz65gPKa7fzadNHPdOQsz5dUhRHcgp4K
 yX0XoZ6KrK39zDwgVem+uO2OL+va14D4wUKC4ZbAhvokc9so61qb3R1Sg9j5s9hyknDw
 z8b37eLLXA/hzoBmWN/fazTNFiG7faRWLm+J0VaFgtpy2ecO6zwZwwQIsTaXL+v7Zti/
 JrOhAGR+hIB5wNgmflccJ5EJ9N9Q8yInAHHvVHL2cYTtgpwT4OKOXSfbA+4YHOYPB7VK
 nM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713812506; x=1714417306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUfQzjh5+xIuRNiKyJ8NbutxlsICHqqDcLaERMfZook=;
 b=EdHg+CYg/rVn8SabFfJiNWPPIEcEqc9pa01aepXLWZhxPunI8yoisCG8Eg3FRaTGPS
 XRfk4GpYWmQCGmMcYhDJYl+PUI4LmB55nYhD79/WBtFaihrX1X/tEgQF6W5PCD2fpMmT
 mmQZwEQ9uRS6RioRewkxJpR0AuIuxO2Puy06lWbPLYuB95x+hUPPSAZJYFxfVLh3kCQl
 WkvC15peHZa3eq5L+SWl9dfXIRu8R+fMDvGPlBv2UhuPoVX9e+B9RXmRkCH0xX/jvBbP
 JqfxiS6uyg6eJMuszEe77D0rbYIA5ZdanmJ83k8TUyLDHPWnkjnISZywSFMr3YdamLAN
 ZIKQ==
X-Gm-Message-State: AOJu0Yxsb9aNUUmm91gReXKUIUdYE41rthfoACQu79ZCTWtSMVxqxgSy
 8meU8ZYr9/LNQDHXjPowYpM0Qs0MwfaW3oIQhouSC1CK30fG9higg0MZ6kTIdODIzHUxyFpY22Q
 HkKe634zI5JSMQYsw+Y5+nkAKgog=
X-Google-Smtp-Source: AGHT+IH/8dEhCWbw/CH5S8l8yh0CzyTyogFe6tRxXEQfqQO2r1LBdjIJo2S6MT+QzY+8I51hB/vvCuqq2iqB3JTyp/c=
X-Received: by 2002:a05:600c:5405:b0:418:fa03:ca68 with SMTP id
 he5-20020a05600c540500b00418fa03ca68mr7380092wmb.17.1713812505758; Mon, 22
 Apr 2024 12:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com>
In-Reply-To: <093301da933d$0d478510$27d68f30$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 12:01:34 -0700
Message-ID: <CACsn0ckPptm05-G6tXPaJJSvKmP3e-nCKPJJCdkmzZOYkQX-Tw@mail.gmail.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@ietf.org, bpf@vger.kernel.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/4c9dOl6wl91AI2BrVS5Lx9CxkjA>
Subject: Re: [Bpf] BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gU2F0LCBBcHIgMjAsIDIwMjQgYXQgOTowOeKAr0FNCjxkdGhhbGVyMTk2OD00MGdvb2dsZW1h
aWwuY29tQGRtYXJjLmlldGYub3JnPiB3cm90ZToKPgo+IFBlciBodHRwczovL2F1dGhvcnMuaWV0
Zi5vcmcvZW4vcmVxdWlyZWQtY29udGVudCNzZWN1cml0eS1jb25zaWRlcmF0aW9ucywKPiB0aGUg
QlBGIElTQSBkcmFmdCBpcyByZXF1aXJlZCB0byBoYXZlIGEgU2VjdXJpdHkgQ29uc2lkZXJhdGlv
bnMgc2VjdGlvbgo+IGJlZm9yZQo+IGl0IGNhbiBiZWNvbWUgYW4gUkZDLgo+Cj4gQmVsb3cgaXMg
c3RyYXdtYW4gdGV4dCB0aGF0IHRyaWVzIHRvIHN0cmlrZSBhIGJhbGFuY2UgYmV0d2VlbiBkaXNj
dXNzaW5nCj4gc2VjdXJpdHkgaXNzdWVzIGFuZCBzb2x1dGlvbnMgdnMga2VlcGluZyBkZXRhaWxz
IG91dCBvZiBzY29wZSB0aGF0IGJlbG9uZyBpbgo+IG90aGVyCj4gZG9jdW1lbnRzIGxpa2UgdGhl
ICJ2ZXJpZmllciBleHBlY3RhdGlvbnMgYW5kIGJ1aWxkaW5nIGJsb2NrcyBmb3IgYWxsb3dpbmcK
PiBzYWZlCj4gZXhlY3V0aW9uIG9mIHVudHJ1c3RlZCBCUEYgcHJvZ3JhbXMiIGRvY3VtZW50IHRo
YXQgaXMgYSBzZXBhcmF0ZSBpdGVtIG9uIHRoZQo+IElFVEYgV0cgY2hhcnRlci4KPgo+IFByb3Bv
c2VkIHRleHQ6Cj4KPiA+IFNlY3VyaXR5IENvbnNpZGVyYXRpb25zCj4gPgo+ID4gQlBGIHByb2dy
YW1zIGNvdWxkIHVzZSBCUEYgaW5zdHJ1Y3Rpb25zIHRvIGRvIG1hbGljaW91cyB0aGluZ3Mgd2l0
aAo+IG1lbW9yeSwKPiA+IENQVSwgbmV0d29ya2luZywgb3Igb3RoZXIgc3lzdGVtIHJlc291cmNl
cy4gVGhpcyBpcyBub3QgZnVuZGFtZW50YWxseQo+IGRpZmZlcmVudAo+ID4gZnJvbSBhbnkgb3Ro
ZXIgdHlwZSBvZiBzb2Z0d2FyZSB0aGF0IG1heSBydW4gb24gYSBkZXZpY2UuIEV4ZWN1dGlvbgo+
IGVudmlyb25tZW50cwo+ID4gc2hvdWxkIGJlIGNhcmVmdWxseSBkZXNpZ25lZCB0byBvbmx5IHJ1
biBCUEYgcHJvZ3JhbXMgdGhhdCBhcmUgdHJ1c3RlZCBvcgo+IHZlcmlmaWVkLAo+ID4gYW5kIHNh
bmRib3hpbmcgYW5kIHByaXZpbGVnZSBsZXZlbCBzZXBhcmF0aW9uIGFyZSBrZXkgc3RyYXRlZ2ll
cyBmb3IKPiBsaW1pdGluZwo+ID4gc2VjdXJpdHkgYW5kIGFidXNlIGltcGFjdC4gRm9yIGV4YW1w
bGUsIEJQRiB2ZXJpZmllcnMgYXJlIHdlbGwta25vd24gYW5kCj4gd2lkZWx5Cj4gPiBkZXBsb3ll
ZCBhbmQgYXJlIHJlc3BvbnNpYmxlIGZvciBlbnN1cmluZyB0aGF0IEJQRiBwcm9ncmFtcyB3aWxs
IHRlcm1pbmF0ZQo+ID4gd2l0aGluIGEgcmVhc29uYWJsZSB0aW1lLCBvbmx5IGludGVyYWN0IHdp
dGggbWVtb3J5IGluIHNhZmUgd2F5cywgYW5kCj4gYWRoZXJlIHRvCj4gPiBwbGF0Zm9ybS1zcGVj
aWZpZWQgQVBJIGNvbnRyYWN0cy4gVGhlIGRldGFpbHMgYXJlIG91dCBvZiBzY29wZSBvZiB0aGlz
Cj4gZG9jdW1lbnQKPiA+IChidXQgc2VlIFtMSU5VWF0gYW5kIFtQUkVWQUlMXSksIGJ1dCB0aGlz
IGxldmVsIG9mIHZlcmlmaWNhdGlvbiBjYW4gb2Z0ZW4KPiBwcm92aWRlIGEKPiA+IHN0cm9uZ2Vy
IGxldmVsIG9mIHNlY3VyaXR5IGFzc3VyYW5jZSB0aGFuIGZvciBvdGhlciBzb2Z0d2FyZSBhbmQg
b3BlcmF0aW5nCj4gc3lzdGVtCj4gPiBjb2RlLgoKSSB3b3VsZCBwdXQgYSByZWZlcmVuY2UgdG8g
dGhlIG90aGVyIGRlbGl2ZXJhYmxlIHRvIHNheSBtb3JlLiBJZiB3ZQp0aGluayB0aGF0J3Mgc3Vi
b3B0aW1hbCBmb3IgcHVibGljYXRpb24gc3RyYXRlZ3ksIG1heWJlIHdlIGNhbiBiZSBtb3JlCmdl
bmVyaWMgYWJvdXQgaXQuCgpPZnRlbiBCUEYgcHJvZ3JhbXMgYXJlIGV4ZWN1dGVkIG9uIHRoZSBv
dGhlciBzaWRlIG9mIGEgcmVsaWFiaWxpdHkKYm91bmRhcnksIGUuZy4gaWYgeW91IGV4ZWN1dGUg
YSBCUEYgZmlsdGVyIHNheWluZyBkcm9wIGFsbCBvbiB5b3VyCm5ldHdvcmsgY2FyZCwgaGF2ZSBm
dW4uIFRoaXMgaXNuJ3QgZGlmZmVyZW50IGZyb20gZmlyZXdhbGxzIGFuZCB0aGUKbGlrZSwgYnV0
IGl0J3MgYSBuZXcgcmlzayB0aGF0IHBlb3BsZSBhcmVuJ3QgZXhwZWN0aW5nLiBJIHRoaW5rIHdl
Cm1pZ2h0IGFsc28gbmVlZCB0byBjYWxsIG91dCB0aGF0IEJQRiBzZWN1cml0eSBhc3N1cmFuY2Ug
cmVxdWlyZXMKY2FyZWZ1bCBkZXNpZ24gYW5kIHRob3VnaHQgYWJvdXQgd2hhdCBpcyBleHBvc2Vk
IHZpYSBCUEYuCgpTaW5jZXJlbHksCldhdHNvbgoKPiBCcGZAaWV0Zi5vcmcKPiBodHRwczovL3d3
dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgoKCgotLSAKQXN0cmEgbW9ydGVtcXVlIHBy
YWVzdGFyZSBncmFkYXRpbQoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBz
Oi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

