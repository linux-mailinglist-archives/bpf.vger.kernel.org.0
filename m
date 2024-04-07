Return-Path: <bpf+bounces-26111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568489AEF9
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 08:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3AA1C2110B
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3A23DE;
	Sun,  7 Apr 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HPLH+Uua";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="HPLH+Uua";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4WCiE+0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29A17F0
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473090; cv=none; b=j6tnZlnvMwFsBJpy45iDgl9WqVLiHBBLLZ3Lvui5q/b97Zog8wlIoOeRiF4RhVTB4vwjtZOUpUGPUNU2Z9tcrTE9w65n2ktBqC/hf3Azww8uoDq0HQuLvZQtQsU9hgZXq748SUEO+79/y4XKVw/5FHUQuffD4VvLYUSP8I5gxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473090; c=relaxed/simple;
	bh=HsV4EQ4/kaNEoAv0aMtE7iW7auPcheIYsNIYs+6fgZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=T7YmMlzhL9e3IDH3A+QZOf8MSb4Y1/quCdp4kRnSFiXCKqdfNY4PtAZALSjrYLvSKC6PMCs4ZimMXtzBhfiTdpfdsmgjd0E2Wb98LKGt5N8BRy+lfFQln/omd+GMqvUz8TSFCS5tTo7bGJ314ikeqivMveRISqwWWMjzZxKvloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HPLH+Uua; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=HPLH+Uua; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4WCiE+0 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D500FC14F6E1
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712473082; bh=HsV4EQ4/kaNEoAv0aMtE7iW7auPcheIYsNIYs+6fgZY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HPLH+Uua2Jp+Co9SgIo6KjXxj0J9FD7DE8A2/SNb9hpixw89A3BJfb2fh/5oKIJgr
	 zVUvEAXprcEzGnCyVOW6l3ubTMyQGACmC3HpDUcIor+qCZZxiIdIeGt/IcOV6aNkjR
	 QKRux45lBJxQ+Fq8HwAI+TMTppfe4iqjpYlPDGnA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Apr  6 23:58:02 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A2035C14F6A5;
	Sat,  6 Apr 2024 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712473082; bh=HsV4EQ4/kaNEoAv0aMtE7iW7auPcheIYsNIYs+6fgZY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=HPLH+Uua2Jp+Co9SgIo6KjXxj0J9FD7DE8A2/SNb9hpixw89A3BJfb2fh/5oKIJgr
	 zVUvEAXprcEzGnCyVOW6l3ubTMyQGACmC3HpDUcIor+qCZZxiIdIeGt/IcOV6aNkjR
	 QKRux45lBJxQ+Fq8HwAI+TMTppfe4iqjpYlPDGnA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ABFA4C14F6A5
 for <bpf@ietfa.amsl.com>; Sat,  6 Apr 2024 23:58:01 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nuiQ6O82jDCI for <bpf@ietfa.amsl.com>;
 Sat,  6 Apr 2024 23:57:57 -0700 (PDT)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id D83C3C14F6A2
 for <bpf@ietf.org>; Sat,  6 Apr 2024 23:57:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d717603aa5so42346621fa.0
 for <bpf@ietf.org>; Sat, 06 Apr 2024 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712473075; x=1713077875; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbMdnxbiUtVNhOQOVtmEhywxDVYbSNqfcBpNBSCVW1Y=;
 b=k4WCiE+0j9V7XBS+WNogxhhEHZAK6Bu/Z6SZdYDX8PZb4FSc1aZF0IkVvgqJZAdeGQ
 5H88W6Fk1IPLcc+TY7ewKrYAKsmam0IJgDTp1JxuTFdNZqNEC/ja/VVbeNBuKmTXQUag
 1PvoIgwAb2zuw6dJ53vcInppuVxG6C6SjHRbTuner9AzMf+RkfKmMF0gddcex7W/Ulz/
 9FqUN2GwyhnWcCQ6UxWsbQgqNq7CxLcPATC+JUriYwvX9MOdWL3ZBMTTzd7iGSZN/K1t
 6sp5ZxokpNS0zmYU49qnRRQh4An6wVxgjtQWXcxvu7JNPHqZ1yZYMUWS2H5z1AMnFn1c
 L2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712473075; x=1713077875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbMdnxbiUtVNhOQOVtmEhywxDVYbSNqfcBpNBSCVW1Y=;
 b=UGgTuLGfF2KY//ryNO8lGfhMF2XjwP4A2+aU9HX8fqbry4LBcXW+4v64raBu/wKry8
 81LEZBcBsH2SiZBIZ1OeO6MFsqvDA3z36ZYwkOyGrz1vvDsXRrcUAy00u5wCA2Yt8GRi
 bL9DZYQSF2P3yuq9tukiC5nShN8UvhdgIoFIDTWNlU5zVZajq3ftglG+TGqHuP9I5xSW
 L6szY2mvcI67fCPKrG1sQuvjwzIFAndYYh4UwTbBm1gck+urXB1JkihuC6J3t8Zo46hw
 Q9CakDfeD0cZaJqjybtQJtACB3g8JaCWaijtQFuOgs8gb4pH+R6qGQKgDsmQrLx63qNA
 vF3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVESJTCau6928gzeLZK6EyOHzcMTgdXRTVAXZwbbT8SHOfkP0qB49nbM3sSuTN9iC0RrRY5eRHi0BLo+Rw=
X-Gm-Message-State: AOJu0YzjzQATds4iHsqm17po+jqE6G2DO3nlrYPgZPAZe6kVn0Gmprph
 HXD4whk4vvXTwN06RMCoKj4yieTdWcA72InoTOI6014L2m2IDv5a0Vaf+l1AKyVTBezzB2TUdbQ
 zFSNK35OQ0a5oOl1wCNfyqxDEJTI=
X-Google-Smtp-Source: AGHT+IHRKbh1gq9cx1Up4Xd4KeqXF6KfAWPuvKtbSXbTaU82E1ACigNlK2IcjqYnvUtQ3AGAgEAaaY+ygf3t213o8IY=
X-Received: by 2002:a2e:98d9:0:b0:2d6:d351:78ae with SMTP id
 s25-20020a2e98d9000000b002d6d35178aemr4526570ljj.29.1712473075170; Sat, 06
 Apr 2024 23:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
 <20240405215044.GC19691@maniforge>
In-Reply-To: <20240405215044.GC19691@maniforge>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Sat, 6 Apr 2024 23:57:43 -0700
Message-ID: <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: dthaler1968=40googlemail.com@dmarc.ietf.org, bpf@vger.kernel.org, 
 bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/p-bKeV2wNiPsPIkg5buEGptJ0BI>
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
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

T24gRnJpLCBBcHIgNSwgMjAyNCBhdCAyOjUw4oCvUE0gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlm
YXVsdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBBcHIgMDUsIDIwMjQgYXQgMDE6MTA6MzhQTSAt
MDcwMCwgZHRoYWxlcjE5Njg9NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZyB3cm90ZToK
PiA+IEF0IElFVEYgMTE5LCB3ZSBhZ3JlZWQgdGhhdCAiYnkgYWRkcmVzcyIgc2hvdWxkIGJlIGNo
YW5nZWQgdG8KPiA+IHNvbWV0aGluZyBlbHNlIGluIHRoZSBJU0EuICBUaGUgdGVybSAibGVnYWN5
IElEIiB3YXMgdXNlZCBkdXJpbmcgdGhlCj4gPiBkaXNjdXNzaW9uIGJ1dCBDaHJpc3RvcGggKGlm
IEkgcmVtZW1iZXIgcmlnaHQpIHBvaW50ZWQgb3V0IHRoYXQgc3VjaAo+ID4gSURzIGFyZSBub3Qg
ZGVwcmVjYXRlZCBwZXIgc2UuICBIZW5jZSAibGVnYWN5IiBtYXkgbm90IGJlIHRoZSByaWdodAo+
ID4gd29yZCBzaW5jZSB3ZSB1c2UgdGhhdCB3b3JkIHdpdGggbGVnYWN5IHBhY2tldCBhY2Nlc3Mg
aW5zdHJ1Y3Rpb25zCj4gPiB0aGF0IGFyZSBkZXByZWNhdGVkLiBXZSBkZWNpZGVkIHRvIHRha2Ug
ZnVydGhlciBkaXNjdXNzaW9uIHRvIHRoZQo+ID4gbGlzdCwgaGVuY2UgdGhpcyBlbWFpbC4KPiA+
Cj4gPiBXZSBuZWVkIHNvbWUgdGVybSB0byBkaXN0aW5ndWlzaCB0aGVtIGZyb20gQlRGIElEcywg
c28gYW5vdGhlcgo+ID4gYWx0ZXJuYXRpdmUgbWlnaHQgYmUgIm5vbi1CVEYgSUQiLgo+Cj4gTm9u
LUJURiBJRCBpcyBmaW5lIHdpdGggbWUuIEFueSBvYmplY3Rpb25zPwoKSWYgc29tZXRoaW5nIGxh
dGVyIGNvbWVzIGFsb25nIHN1cHBsYW50aW5nIEJURiBpdCB3aWxsIGJlIHRoZSBub3QtQlRGCm5v
dC1ub24tQlRGIHRoaW5nLiBUaGlzIGlzIGJhZC4gSG93IGFib3V0IHVudHlwZWQgaWRlbnRpZmll
cnM/Cj4KPiBUaGFua3MsCj4gRGF2aWQKPiAtLQo+IEJwZiBtYWlsaW5nIGxpc3QKPiBCcGZAaWV0
Zi5vcmcKPiBodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgoKCgotLSAK
QXN0cmEgbW9ydGVtcXVlIHByYWVzdGFyZSBncmFkYXRpbQoKLS0gCkJwZiBtYWlsaW5nIGxpc3QK
QnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

