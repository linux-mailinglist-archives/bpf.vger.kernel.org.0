Return-Path: <bpf+bounces-22511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA985FEC1
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC971C223C1
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB8154C12;
	Thu, 22 Feb 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yug736y+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="yug736y+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHpr8ulV"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF914F9FE
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621770; cv=none; b=FKOUJyMt1Mqp4rL6RmOrtROjoKLc+1VmENqTIeWIuL8GLWP2OibSEq25hW42wSgJ3uyc2Z/fwPuwIjwvIxUuhpSOosny6qqFWyKHiW6j0L5ctfFeflvMRefy+vD3X5f2EUeJQYkDcI6qEtCj6ZhAWn12qgCT/aJmm3pe7D925Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621770; c=relaxed/simple;
	bh=JLXFsYL9ms9HxzmtH0iV2k7CFk1i0rPWp6k733KulU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=WDIIs88TChQKJ47GDwVedICGlFLNJhlSZuanWKVUU6X3aUQRv22Ojp+5Gad2KlES3gP/7lTvZAb7BeXWA7c1CB2A25KSjOwrqQt6XBil/DlYt4EkvcgvHNebORzi869g9x19OvNx43J+f8bHyJiKlAPKEsMKbX69y662BixkOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yug736y+; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=yug736y+; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHpr8ulV reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 20EDEC180B62
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708621766; bh=JLXFsYL9ms9HxzmtH0iV2k7CFk1i0rPWp6k733KulU4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yug736y+oUr2DdJ4iaG0qC13iQ1QtGpWn43IYtqa5BFENu9fQrgjZBwO8c2H5Px8S
	 j7GG+z/GnDCvRgG/eBcBuPG9kQAI8l0BFEJ+OXGLuZAuhyyvYRHFXrELe6GMdh8oW5
	 Woq873QDC64FV/NRbtppvxdyLsl8gu9wsUGWmvbo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Feb 22 09:09:26 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id EAEE1C1519BA;
	Thu, 22 Feb 2024 09:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1708621766; bh=JLXFsYL9ms9HxzmtH0iV2k7CFk1i0rPWp6k733KulU4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yug736y+oUr2DdJ4iaG0qC13iQ1QtGpWn43IYtqa5BFENu9fQrgjZBwO8c2H5Px8S
	 j7GG+z/GnDCvRgG/eBcBuPG9kQAI8l0BFEJ+OXGLuZAuhyyvYRHFXrELe6GMdh8oW5
	 Woq873QDC64FV/NRbtppvxdyLsl8gu9wsUGWmvbo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 770B1C1522A0
 for <bpf@ietfa.amsl.com>; Thu, 22 Feb 2024 09:09:24 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yy8ZMDVLq6xr for <bpf@ietfa.amsl.com>;
 Thu, 22 Feb 2024 09:09:24 -0800 (PST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0D0BCC1519AD
 for <bpf@ietf.org>; Thu, 22 Feb 2024 09:09:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-410e820a4feso6932885e9.1
 for <bpf@ietf.org>; Thu, 22 Feb 2024 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708621762; x=1709226562; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWJ5IgaXI9oB8PDuNTR3xa+p/K3crCcJtlVMiaixrBo=;
 b=aHpr8ulV/2nVFNg3nwRHtINA3I6TlkjX3WWwUIgLx8bUpPSjy7nTPIumi6bevTG8Bn
 SXatSndMLm/UrEhyJ4a/sjlCVlys+vradXKCvs6qFu7tBX1vHG9mYu2VloAmLmqYnuk6
 7HA1Q/xwC8yvlsQqRfupvsLjwGcVH3Baq9aIZScg6/McbcdvzYOW2KiWZvHES9Yelyf1
 HckI8p5QKttLBLXw0HAhXJYq+xdkQha405C5cA5CHZGmzzgGp0m4x3YXroZi2s4fFe9+
 h2NpqbvNLOMTA/9OR0MbGwupnBZMonBYjH6qe8MCM79lW+FsTu1dAPljh1ZhAyOKxX8H
 vv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708621762; x=1709226562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWJ5IgaXI9oB8PDuNTR3xa+p/K3crCcJtlVMiaixrBo=;
 b=gG9Spi1QPuE4iVIhjLr5uJYVidNTHJLq2bc0NUEh6Uk2kK5gazRtkYUZiVPno1uCu6
 M56C/SsZi/bFmmAlmr30yy7Pk+AiAICDav/z5D3C8Rz9rAXL+6MOUKmBA6JOvJUSRHYU
 c+3YB5hLauvgMPL13Wl1YiS68Tj0QkDNFevNeGF9sizPzfEst85zGYEuyezGQ5TMRpgb
 II8hQgAzAN33UP/1f703W/t3Ej6ubdOEPRvdulAh/1UD0+HrYM/2I6jjrYhgOrqzX+yN
 O/c0GCGjhvWnU0ktdgNh1M5/DG/kCa6xYHaRPpDTRC4JkXYpophwF8vVKTZdcKOgtCai
 D8fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjw09/gkNO1eRviFU+eO6URYtrM5L8ycwry9TGwdVhxKuHS00P8i7ZHbFJzh2fNd+zpeQ9NKLRjEWzsdQ=
X-Gm-Message-State: AOJu0Yw+yrk/ZwMASEnEkyeMrRu834XBHONQa83R77cUkw4UU5kchONp
 kOuPnd9NVdH/k9n63YpUhQJVMvE+pewecNJk5kKlBTEPYd5eZwWG6hqD89llo241/O4O2Jn/PB0
 ewyrqr2IRZhOt6Zpium7ErSOkz54=
X-Google-Smtp-Source: AGHT+IF3f97DXmYh07Mhi9eTIOYVTqDX1qlnsgRXet803c0Dilvsop6Hz6vFL+FW1Yp0nFNhq7FpGs/jJuQiae2F1rk=
X-Received: by 2002:a5d:59aa:0:b0:33d:9dd9:c23e with SMTP id
 p10-20020a5d59aa000000b0033d9dd9c23emr1485735wrr.0.1708621762222; Thu, 22 Feb
 2024 09:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221173535.16601-1-dthaler1968@gmail.com>
 <20240221180448.GC57258@maniforge>
In-Reply-To: <20240221180448.GC57258@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 09:09:10 -0800
Message-ID: <CAADnVQJsWgaRL-6Ndo9XTuYmDOOiXSFGAMnVmU723=qxE4f3dg@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
 bpf <bpf@vger.kernel.org>, 
 bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/bEO3SiCCbtoE5RD85EdLiw7qUmo>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Fix typos in instruction-set.rst
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

T24gV2VkLCBGZWIgMjEsIDIwMjQgYXQgMTA6MDXigK9BTSBEYXZpZCBWZXJuZXQgPHZvaWRAbWFu
aWZhdWx0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIEZlYiAyMSwgMjAyNCBhdCAwOTozNTozNUFN
IC0wODAwLCBEYXZlIFRoYWxlciB3cm90ZToKPiA+ICogIkJQRiBBREQiIHNob3VsZCBiZSAiQlBG
X0FERCIuCj4gPiAqICJzcmMiIHNob3VsZCBiZSAic3JjX3JlZyIgaW4gc2V2ZXJhbCBwbGFjZXMu
ICBUaGUgbGF0dGVyIGlzIHRoZSBmaWVsZCBuYW1lCj4gPiAgIGluIHRoZSBpbnN0cnVjdGlvbi4g
IFRoZSBmb3JtZXIgcmVmZXJzIHRvIHRoZSB2YWx1ZSBvZiB0aGUgcmVnaXN0ZXIsIG9yIHRoZQo+
ID4gICBpbW1lZGlhdGUuCj4gPiAqIEFkZCAnJyBhcm91bmQgZmllbGQgbmFtZXMgaW4gb25lIHNl
bnRlbmNlLCBmb3IgY29uc2lzdGVuY3kgd2l0aCB0aGUgcmVzdAo+ID4gICBvZiB0aGUgZG9jdW1l
bnQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdtYWls
LmNvbT4KPgo+IFRoYW5rcyBmb3IgdGhlIGNsZWFudXAuCj4KPiBBY2tlZC1ieTogRGF2aWQgVmVy
bmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+Cj4KPiA+IC0tLQo+ID4gIC4uLi9icGYvc3RhbmRhcmRp
emF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QgICB8IDcyICsrKysrKysrKy0tLS0tLS0tLS0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVj
dGlvbi1zZXQucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0
aW9uLXNldC5yc3QKPiA+IGluZGV4IDg2OGQ5ZjYxNy4uNTZiNWU3ZGFkIDEwMDY0NAo+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2luc3RydWN0aW9uLXNldC5yc3QK
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1z
ZXQucnN0Cj4gPiBAQCAtMTc4LDcgKzE3OCw3IEBAIFVudXNlZCBmaWVsZHMgc2hhbGwgYmUgY2xl
YXJlZCB0byB6ZXJvLgo+ID4gIEFzIGRpc2N1c3NlZCBiZWxvdyBpbiBgNjQtYml0IGltbWVkaWF0
ZSBpbnN0cnVjdGlvbnNgXywgYSA2NC1iaXQgaW1tZWRpYXRlCj4gPiAgaW5zdHJ1Y3Rpb24gdXNl
cyB0d28gMzItYml0IGltbWVkaWF0ZSB2YWx1ZXMgdGhhdCBhcmUgY29uc3RydWN0ZWQgYXMgZm9s
bG93cy4KPiA+ICBUaGUgNjQgYml0cyBmb2xsb3dpbmcgdGhlIGJhc2ljIGluc3RydWN0aW9uIGNv
bnRhaW4gYSBwc2V1ZG8gaW5zdHJ1Y3Rpb24KPiA+IC11c2luZyB0aGUgc2FtZSBmb3JtYXQgYnV0
IHdpdGggb3Bjb2RlLCBkc3RfcmVnLCBzcmNfcmVnLCBhbmQgb2Zmc2V0IGFsbCBzZXQgdG8gemVy
bywKPiA+ICt1c2luZyB0aGUgc2FtZSBmb3JtYXQgYnV0IHdpdGggJ29wY29kZScsICdkc3RfcmVn
JywgJ3NyY19yZWcnLCBhbmQgJ29mZnNldCcgYWxsIHNldCB0byB6ZXJvLAo+ID4gIGFuZCBpbW0g
Y29udGFpbmluZyB0aGUgaGlnaCAzMiBiaXRzIG9mIHRoZSBpbW1lZGlhdGUgdmFsdWUuCj4KPiBu
aXQ6IENhbiB3ZSBtYWtlIHN1cmUgdGhlc2UgY29sdW1ucyBhcmUgYWxsIHdyYXBwZWQgdG8gODAg
Y2hhcmFjdGVycz8KPiBUaGlzIGNhbiBiZSBkb25lIGluIGEgZm9sbG93LXVwIGZvciB0aGUgd2hv
bGUgZG9jdW1lbnQgbGF0ZXIuCgpGaXhlZCB1cCB3aGlsZSBhcHBseWluZywKYnV0IGxldCdzIG5v
dCByZWZvcm1hdCB0aGUgd2hvbGUgZG9jLgpNYW55IHRhYmxlcyBhcmUgMTAwKyBjaGFycyBhbmQg
aXQncyBmaW5lLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3
LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

