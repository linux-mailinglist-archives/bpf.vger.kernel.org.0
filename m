Return-Path: <bpf+bounces-27494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6748ADB0E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 02:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C371C20DF3
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947D20B20;
	Tue, 23 Apr 2024 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="myrMmX1U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="myrMmX1U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuW8kJkp"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F22208AD
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831580; cv=none; b=AybWUJim03bxgp9tqvqLusfCYD/G/UW48FqjdkfKp0xBAhzvLYCCXzPvisQ3cRB3t04pOZcU9+tClHQHq/D53FMxRXfxL1vBIEW/NafXUecrtlrg1M58+Asd5wOvt6jWPs2ZvU/uGhYeDkoSn++GBFheOS2sJEfrQ4RdJmKA/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831580; c=relaxed/simple;
	bh=6JuFBIMzY1huTE3S6ULvs0XuSLte+sYpTma1XG/l3vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=UAw0JbXSy5l/RDq1J4GWR1sg8GiYBaw4majZ1cyqiFwclpbddQ5HbC5OqCHFhBYiwksoyZGf0uytygCyLZ1M8qf4BUUKtA1IKwul+OvG92VDDob40hmXAa7AZVqqfT5DlgcwyENZsZMMG76s9fcCYHqbjSOi5o02tZtzV0xMx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=myrMmX1U; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=myrMmX1U; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuW8kJkp reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E1E0DC1C411F
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713831577; bh=6JuFBIMzY1huTE3S6ULvs0XuSLte+sYpTma1XG/l3vA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=myrMmX1UFkMZmkz8bnXfkvi5FBDtDSmcBYBaaBDiELsOIxrxSAfjB/U8fl5iGKulX
	 303zW9ZOMnDKnZGyqvJvhOArt6wgbjFlGJIQhB7QdsxwZszBWnh1S3rFl+7afeDjJL
	 qf+3C8HQeONqVG/e99x4fue2oPJDtULxlY+2V9vY=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 17:19:37 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C4BA0C1C410C;
	Mon, 22 Apr 2024 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713831577; bh=6JuFBIMzY1huTE3S6ULvs0XuSLte+sYpTma1XG/l3vA=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=myrMmX1UFkMZmkz8bnXfkvi5FBDtDSmcBYBaaBDiELsOIxrxSAfjB/U8fl5iGKulX
	 303zW9ZOMnDKnZGyqvJvhOArt6wgbjFlGJIQhB7QdsxwZszBWnh1S3rFl+7afeDjJL
	 qf+3C8HQeONqVG/e99x4fue2oPJDtULxlY+2V9vY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2348EC1C410C
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 17:19:37 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-Jm5j3eJOkZ for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 17:19:36 -0700 (PDT)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 664B9C14F6BF
 for <bpf@ietf.org>; Mon, 22 Apr 2024 17:19:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41aa15ae26dso4877255e9.3
 for <bpf@ietf.org>; Mon, 22 Apr 2024 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713831575; x=1714436375; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLlzRTFAcFtl98xJoEUnAY+WWTCHtrEIDgh4Q1C0lFs=;
 b=cuW8kJkpnENmSDsufpIM/O4Jdi7D2lpg8Fum9kUkuEzXn+RjkbsBe/9WGD4+rQDOpY
 c0DfMGDoQYlPGqOTDrV8xC+EdyPmvzfZtpSFmIJrd8jju47IoxLTudW/+bT1jlcCk1Hb
 H7qajOXl4a0rLk5smGYBRZYjLz0iY1R8OtedK+bpY7VPRvxDnZ09TpwOJqQ0u6RASyrq
 VzIbTbhbmqlbmfe/pjFgnNhUK6TJLUBYW1VvJlQJPaxW6EbhbkGDUWN3jrHnokB10uBg
 RE2xVkdoHQhCZP4f9UnrxtsiTispQN/f+qQHGxlaM+RIYXb7FCxy5dcb3/Dwl+JdcS38
 ImSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713831575; x=1714436375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLlzRTFAcFtl98xJoEUnAY+WWTCHtrEIDgh4Q1C0lFs=;
 b=wbLOzvdHoKdmx/Ie2HzgPD3WYhlrAJYlNd/nTvDJZ6f3cPDL5sLbD4KZVsCrj6rrqp
 QKTAf9hk01RWnThuBw+kIqc3uy4G6+p2oaieI1c+tsXnGKhdqvINsaYClpapD4zPf8i4
 qASyfdZzZbYQJuEkkEjJq5MJIAxw6Mv/0AlqrXhey9u1SYaHAe3AHrSZUonnXOF6HV85
 9XN+R0nPI7C5aRiNfmHPlZHsbLlaO0qfNwgOS9YYKA5b31Fg3LbhIGsSL76AtZq6pOuM
 MccmTn2gbbDuBqijwm2xCHVJ/RPaD14oIAzgvZ4Cv6EHSpa45nEnzHD1sb6rUo6VMOEw
 UiuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQOEywmXo7FSfhuEyJFzMTLnVWSqIl19ifwPq52VclkD2mPwNtYE8u/Ti/3LyiXY32JpoJ/OwRXfycOmQ=
X-Gm-Message-State: AOJu0YxeZs2ZFp4EyLW7beFZ8rNYnffSaNlRwCAMa/1k2HXDDsflqc+r
 o1keCH1MqnyA81nlT7ZhUQi76jsDIusFYW15BGHYr27K9zAUpcJY6JB+q+x62AZTv9vuFrNAEd3
 C/5Lv6YrK/+rMJtJ0gsVKpsnCgZ8=
X-Google-Smtp-Source: AGHT+IFpw/AmZClbJHnALGmqym9VavRccgjWEVVVlOYo5V7O1P09NK+Dz+F8SLtTPPB4RPnxBbZB+jc6QWY/JasBYNA=
X-Received: by 2002:adf:a4c7:0:b0:347:1c20:f262 with SMTP id
 h7-20020adfa4c7000000b003471c20f262mr7250276wrb.16.1713831574461; Mon, 22 Apr
 2024 17:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge>
 <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge> <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
 <160f01da94f4$31201c50$936054f0$@gmail.com>
In-Reply-To: <160f01da94f4$31201c50$936054f0$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 17:19:23 -0700
Message-ID: <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: dthaler1968@googlemail.com, David Vernet <void@manifault.com>, bpf@ietf.org,
 bpf@vger.kernel.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/CDzjNgaMzhDz0z5Dde9kXDZMvvk>
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

T24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgMTozMuKAr1BNCjxkdGhhbGVyMTk2OD00MGdvb2dsZW1h
aWwuY29tQGRtYXJjLmlldGYub3JnPiB3cm90ZToKPgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KPiA+IEZyb206IGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tIDxkdGhhbGVyMTk2OEBn
b29nbGVtYWlsLmNvbT4KPiA+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIwMjQgMToyNiBQTQo+
ID4gVG86ICdEYXZpZCBWZXJuZXQnIDx2b2lkQG1hbmlmYXVsdC5jb20+OyBkdGhhbGVyMTk2OEBn
b29nbGVtYWlsLmNvbQo+ID4gQ2M6IGJwZkBpZXRmLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZwo+
ID4gU3ViamVjdDogUkU6IEJQRiBJU0EgU2VjdXJpdHkgQ29uc2lkZXJhdGlvbnMgc2VjdGlvbgo+
ID4KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+ID4gRnJvbTogRGF2aWQgVmVy
bmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+Cj4gPiA+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIw
MjQgMTI6MzUgUE0KPiA+ID4gVG86IGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tCj4gPiA+IENj
OiBicGZAaWV0Zi5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmcKPiA+ID4gU3ViamVjdDogUmU6IEJQ
RiBJU0EgU2VjdXJpdHkgQ29uc2lkZXJhdGlvbnMgc2VjdGlvbgo+ID4gPgo+ID4gPiBPbiBNb24s
IEFwciAyMiwgMjAyNCBhdCAxMTozNzo0OEFNIC0wNzAwLCBkdGhhbGVyMTk2OEBnb29nbGVtYWls
LmNvbQo+ID4gd3JvdGU6Cj4gPiA+ID4gRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+
IHdyb3RlOgo+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHdyaXRpbmcgdGhpcyB1cC4gT3ZlcmFsbCBp
dCBsb29rcyBncmVhdCwganVzdCBoYWQgb25lCj4gPiA+ID4gPiA+IGNvbW1lbnQKPiA+ID4gPiA+
IGJlbG93Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gU2VjdXJpdHkgQ29uc2lkZXJhdGlv
bnMKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBCUEYgcHJvZ3JhbXMgY291bGQgdXNl
IEJQRiBpbnN0cnVjdGlvbnMgdG8gZG8gbWFsaWNpb3VzCj4gPiA+ID4gPiA+ID4gPiB0aGluZ3Mg
d2l0aCBtZW1vcnksIENQVSwgbmV0d29ya2luZywgb3Igb3RoZXIgc3lzdGVtCj4gPiA+ID4gPiA+
ID4gPiByZXNvdXJjZXMuIFRoaXMgaXMgbm90IGZ1bmRhbWVudGFsbHkgZGlmZmVyZW50ICBmcm9t
IGFueQo+ID4gPiA+ID4gPiA+ID4gb3RoZXIgdHlwZSBvZiBzb2Z0d2FyZSB0aGF0IG1heSBydW4g
b24gYSBkZXZpY2UuIEV4ZWN1dGlvbgo+ID4gPiA+ID4gPiA+ID4gZW52aXJvbm1lbnRzIHNob3Vs
ZCBiZSBjYXJlZnVsbHkgZGVzaWduZWQgdG8gb25seSBydW4gQlBGCj4gPiA+ID4gPiA+ID4gPiBw
cm9ncmFtcyB0aGF0IGFyZSB0cnVzdGVkIG9yIHZlcmlmaWVkLCBhbmQgc2FuZGJveGluZyBhbmQK
PiA+ID4gPiA+ID4gPiA+IHByaXZpbGVnZSBsZXZlbCBzZXBhcmF0aW9uIGFyZSBrZXkgc3RyYXRl
Z2llcyBmb3IgbGltaXRpbmcKPiA+ID4gPiA+ID4gPiA+IHNlY3VyaXR5IGFuZCBhYnVzZSBpbXBh
Y3QuIEZvciBleGFtcGxlLCBCUEYgdmVyaWZpZXJzIGFyZQo+ID4gPiA+ID4gPiA+ID4gd2VsbC1r
bm93biBhbmQgd2lkZWx5IGRlcGxveWVkIGFuZCBhcmUgcmVzcG9uc2libGUgZm9yCj4gPiA+ID4g
PiA+ID4gPiBlbnN1cmluZyB0aGF0IEJQRiBwcm9ncmFtcyB3aWxsIHRlcm1pbmF0ZSB3aXRoaW4g
YQo+ID4gPiA+ID4gPiA+ID4gcmVhc29uYWJsZSB0aW1lLCBvbmx5IGludGVyYWN0IHdpdGggbWVt
b3J5IGluIHNhZmUgd2F5cywgYW5kCj4gPiA+ID4gPiA+ID4gPiBhZGhlcmUgdG8gcGxhdGZvcm0t
c3BlY2lmaWVkIEFQSSBjb250cmFjdHMuIFRoZSBkZXRhaWxzIGFyZQo+ID4gPiA+ID4gPiA+ID4g
b3V0IG9mIHNjb3BlIG9mIHRoaXMgZG9jdW1lbnQgKGJ1dCBzZWUgW0xJTlVYXSBhbmQKPiA+ID4g
PiA+ID4gPiA+IFtQUkVWQUlMXSksIGJ1dCB0aGlzIGxldmVsIG9mIHZlcmlmaWNhdGlvbiBjYW4g
b2Z0ZW4gcHJvdmlkZQo+ID4gPiA+ID4gPiA+ID4gYSBzdHJvbmdlciBsZXZlbCBvZiBzZWN1cml0
eSBhc3N1cmFuY2UgdGhhbiBmb3IKPiA+IG90aGVyIHNvZnR3YXJlCj4gPiA+IGFuZCBvcGVyYXRp
bmcgc3lzdGVtIGNvZGUuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gRXhlY3V0aW5n
IHByb2dyYW1zIHVzaW5nIHRoZSBCUEYgaW5zdHJ1Y3Rpb24gc2V0IGFsc28KPiA+ID4gPiA+ID4g
PiA+IHJlcXVpcmVzIGVpdGhlciBhbiBpbnRlcnByZXRlciBvciBhIEpJVCBjb21waWxlciB0bwo+
ID4gPiA+ID4gPiA+ID4gdHJhbnNsYXRlIHRoZW0gdG8gaGFyZHdhcmUgcHJvY2Vzc29yIG5hdGl2
ZSBpbnN0cnVjdGlvbnMuIEluCj4gPiA+ID4gPiA+ID4gPiBnZW5lcmFsLCBpbnRlcnByZXRlcnMg
YXJlIGNvbnNpZGVyZWQgYSBzb3VyY2Ugb2YgaW5zZWN1cml0eQo+ID4gPiA+ID4gPiA+ID4gKGUu
Zy4sIGdhZGdldHMgc3VzY2VwdGlibGUgdG8gc2lkZS1jaGFubmVsIGF0dGFja3MgZHVlIHRvCj4g
PiA+ID4gPiA+ID4gPiBzcGVjdWxhdGl2ZQo+ID4gPiA+ID4gPiA+ID4gZXhlY3V0aW9uKSBhbmQg
YXJlIG5vdCByZWNvbW1lbmRlZC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRG8gd2UgbmVlZCB0
byBzYXkgdGhhdCBpdCdzIG5vdCByZWNvbW1lbmRlZCB0byB1c2UgSklUIGVuZ2luZXM/Cj4gPiA+
ID4gPiA+IEdpdmVuIHRoYXQgdGhpcyBpcyBleHBsYWluaW5nIGhvdyBCUEYgcHJvZ3JhbXMgYXJl
IGV4ZWN1dGVkLCB0bwo+ID4gPiA+ID4gPiBtZSBpdCByZWFkcyBhIGJpdCBhcyBzYXlpbmcsICJJ
dCdzIG5vdCByZWNvbW1lbmRlZCB0byB1c2UgQlBGLiIKPiA+ID4gPiA+ID4gSXMgaXQgbm90IHN1
ZmZpY2llbnQgdG8ganVzdCBleHBsYWluIHRoZSByaXNrcz8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBJ
dCBzYXlzIGl0J3Mgbm90IHJlY29tbWVuZGVkIHRvIHVzZSBpbnRlcnByZXRlcnMuICBJIGNvdWxk
bid0IHRlbGwKPiA+ID4gPiA+IGlmIHlvdXIgY29tbWVudCB3YXMgYSB0eXBvLCBkaWQgeW91IG1l
YW4gaW50ZXJwcmV0ZXJzIG9yIEpJVAo+ID4gPiA+ID4gZW5naW5lcz8gIEl0IHNob3VsZCByZWFk
IGFzIHNheWluZyBpdCdzIHJlY29tbWVuZGVkIHRvIHVzZSBhIEpJVAo+ID4gPiA+ID4gZW5naW5l
IHJhdGhlciB0aGFuIGFuIGludGVycHJldGVyLgo+ID4gPgo+ID4gPiBTb3JyeSwgeWVzLCBJIG1l
YW50IHRvIHNheSBpbnRlcnByZXRlcnMuIFdoYXQgSSByZWFsbHkgbWVhbnQgdGhvdWdoIGlzCj4g
PiB0aGF0IGRpc2N1c3NpbmcKPiA+ID4gdGhlIHNhZmV0eSBvZiBKSVQgZW5naW5lcyB2cy4gaW50
ZXJwcmV0ZXJzIHNlZW1zIGEgYml0IG91dCBvZiBzY29wZQo+ID4gPiBmb3IKPiA+IHRoaXMgU2Vj
dXJpdHkKPiA+ID4gQ29uc2lkZXJhdGlvbnMgc2VjdGlvbi4gSXQncyBub3QgYXMgdGhvdWdoIEpJ
VCBpcyBhIGZvb2xwcm9vZiBtZXRob2QKPiA+ID4gaW4KPiA+IGFuZCBvZiBpdHNlbGYuCj4gPiA+
Cj4gPiA+ID4gPiBEbyB5b3UgaGF2ZSBhIHN1Z2dlc3RlZCBhbHRlcm5hdGUgd29yZGluZz8KPiA+
ID4KPiA+ID4gSG93IGFib3V0IHRoaXM6Cj4gPiA+Cj4gPiA+IEV4ZWN1dGluZyBwcm9ncmFtcyB1
c2luZyB0aGUgQlBGIGluc3RydWN0aW9uIHNldCBhbHNvIHJlcXVpcmVzIGVpdGhlcgo+ID4gPiBh
bgo+ID4gaW50ZXJwcmV0ZXIKPiA+ID4gb3IgYSBKSVQgY29tcGlsZXIgdG8gdHJhbnNsYXRlIHRo
ZW0gdG8gaGFyZHdhcmUgcHJvY2Vzc29yIG5hdGl2ZQo+ID4gaW5zdHJ1Y3Rpb25zLiBJbgo+ID4g
PiBnZW5lcmFsLCBpbnRlcnByZXRlcnMgYW5kIEpJVCBlbmdpbmVzIGNhbiBiZSBhIHNvdXJjZSBv
ZiBpbnNlY3VyaXR5Cj4gPiA+IChlLmcuLAo+ID4gZ2FkZ2V0cwo+ID4gPiBzdXNjZXB0aWJsZSB0
byBzaWRlLWNoYW5uZWwgYXR0YWNrcyBkdWUgdG8gc3BlY3VsYXRpdmUgZXhlY3V0aW9uLCBvcgo+
ID4gPiBXXlgKPiA+IG1hcHBpbmdzKSwKPiA+ID4gYW5kIHNob3VsZCBiZSBhdWRpdGVkIGNhcmVm
dWxseSBmb3IgdnVsbmVyYWJpbGl0aWVzLgo+ID4KPiA+IEkndmUgaGFkIHNlY3VyaXR5IHJlc2Vh
cmNoZXJzIHRlbGwgbWUgdGhhdCB1c2luZyBhbiBpbnRlcnByZXRlciBpbiB0aGUKPiBzYW1lIGFk
ZHJlc3MKPiA+IHNwYWNlIGFzIG90aGVyIGNvbmZpZGVudGlhbCBkYXRhIGlzIGluaGVyZW50bHkg
YSB2dWxuZXJhYmlsaXR5LCBpLmUuLCBubwo+IG9uZSBjYW4gcHJvdmUKPiA+IHRoYXQgaXQncyBu
b3QgYSBzaWRlIGNoYW5uZWwgYXR0YWNrIHdhaXRpbmcgdG8gaGFwcGVuIGFuZCBhbGwgZXZpZGVu
Y2UgaXMKPiB0aGF0IGl0IGNhbm5vdAo+ID4gYmUgcHJvdGVjdGVkLiAgT25seSBhbiBpbnRlcnBy
ZXRlciBpbiBhIHNlcGFyYXRlIGFkZHJlc3Mgc3BhY2UgZnJvbSBhbnkKPiBzZWNyZXRzIGNhbgo+
ID4gYmUgc2FmZSBpbiB0aGF0IHJlc3BlY3QuICBTbyBJIGJlbGlldmUganVzdCBzYXlpbmcgdGhh
dCBpbnRlcnByZXRlcnMKPiAic2hvdWxkIGJlIGF1ZGl0ZWQKPiA+IGNhcmVmdWxseSBmb3IgdnVs
bmVyYWJpbGl0aWVzIiB3b3VsZCBub3QgcGFzcyBzZWN1cml0eSBtdXN0ZXIgYnkgc3VjaAo+IGZv
bGtzLgo+ID4KPiA+ID4gPiBIb3cgYWJvdXQ6Cj4gPiA+ID4KPiA+ID4gPiBPTEQ6IEluIGdlbmVy
YWwsIGludGVycHJldGVycyBhcmUgY29uc2lkZXJlZCBhCj4gPiA+ID4gT0xEOiBzb3VyY2Ugb2Yg
aW5zZWN1cml0eSAoZS5nLiwgZ2FkZ2V0cyBzdXNjZXB0aWJsZSB0byBzaWRlLWNoYW5uZWwKPiA+
ID4gPiBhdHRhY2tzIGR1ZSB0byBzcGVjdWxhdGl2ZSBleGVjdXRpb24pCj4gPiA+ID4gT0xEOiBh
bmQgYXJlIG5vdCByZWNvbW1lbmRlZC4KPiA+ID4gPgo+ID4gPiA+IE5FVzogSW4gZ2VuZXJhbCwg
aW50ZXJwcmV0ZXJzIGFyZSBjb25zaWRlcmVkIGEKPiA+ID4gPiBORVc6IHNvdXJjZSBvZiBpbnNl
Y3VyaXR5IChlLmcuLCBnYWRnZXRzIHN1c2NlcHRpYmxlIHRvIHNpZGUtY2hhbm5lbAo+ID4gPiA+
IGF0dGFja3MgZHVlIHRvIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbikKPiA+ID4gPiBORVc6IHNvIHVz
ZSBvZiBhIEpJVCBjb21waWxlciBpcyByZWNvbW1lbmRlZCBpbnN0ZWFkLgo+ID4gPgo+ID4gPiBU
aGlzIGlzIGZpbmUgdG9vLiBNeSBvbmx5IHdvcnJ5IGlzIHRoYXQgdGhlcmUgaGF2ZSBhbHNvIGJl
ZW4gcGxlbnR5IG9mCj4gPiB2dWxuZXJhYmlsaXRpZXMKPiA+ID4gZXhwbG9pdGVkIGFnYWluc3Qg
SklUIGVuZ2luZXMgYXMgd2VsbCwgc28gaXQgbWlnaHQgYmUgbW9yZSBwcnVkZW50IHRvCj4gPiA+
IGp1c3QKPiA+IHdhcm4gdGhlCj4gPiA+IHJlYWRlciBvZiB0aGUgcmlza3Mgb2YgaW50ZXJwcmV0
ZXJzL0pJVHMgaW4gZ2VuZXJhbCBhcyBvcHBvc2VkIHRvCj4gPiBwcmVzY3JpYmluZyBvbmUgb3Zl
cgo+ID4gPiB0aGUgb3RoZXIuCj4gPiA+Cj4gPiA+IFdoYXQgZG8geW91IHRoaW5rPwo+ID4KPiA+
IEkgdGhpbmsgdGhlICJzaG91bGQgYmUgYXVkaXRlZCBjYXJlZnVsbHkgZm9yIHZ1bG5lcmFiaWxp
dGllcyIgcGhyYXNlIHdvdWxkCj4gYXBwbHkgdG8gSklUcwo+ID4gZm9yIHN1cmUuICBIb3dldmVy
IGl0IHdvdWxkIGFsc28gYXBwbHkgdG8gYW55IG5vbi1CUEYgY29kZSBpbiBhIHByaXZpbGVnZWQK
PiBjb250ZXh0Cj4gPiBzdWNoIGFzIGEga2VybmVsLCBzbyBpdCB3b3VsZCBzZWVtIG9kZCB0byBj
YWxsIGl0IG91dCBoZXJlIGFuZCBub3QgaW4gYWxsCj4gb3RoZXIgUkZDcwo+ID4gdGhhdCB3b3Vs
ZCBhcHBseSB0byBrZXJuZWwgY29kZSAoZS5nLiwgVENQL0lQKS4gIEJ1dCBpZiBvdGhlcnMgcmVh
bGx5IHdhbnQKPiB0aGF0LCB3ZQo+ID4gY291bGQgY2VydGFpbmx5IHNheSB0aGF0Lgo+Cj4gVXBk
YXRlZCBwcm9wb3NlZCB0ZXh0LCBiYXNlZCBvbiBEYXZpZCdzIGFuZCBXYXRzb24ncyBmZWVkYmFj
azoKPgo+IEV4ZWN1dGluZyBwcm9ncmFtcyB1c2luZyB0aGUgQlBGIGluc3RydWN0aW9uIHNldCBh
bHNvIHJlcXVpcmVzIGVpdGhlciBhbgo+IGludGVycHJldGVyIG9yIGEgSklUIGNvbXBpbGVyCj4g
dG8gdHJhbnNsYXRlIHRoZW0gdG8gaGFyZHdhcmUgcHJvY2Vzc29yIG5hdGl2ZSBpbnN0cnVjdGlv
bnMuICBJbiBnZW5lcmFsLAo+IGludGVycHJldGVycyBhcmUgY29uc2lkZXJlZCBhCj4gc291cmNl
IG9mIGluc2VjdXJpdHkgKGUuZy4sIGdhZGdldHMgc3VzY2VwdGlibGUgdG8gc2lkZS1jaGFubmVs
IGF0dGFja3MgZHVlCj4gdG8gc3BlY3VsYXRpdmUgZXhlY3V0aW9uLAo+IG9yIFdeWCBtYXBwaW5n
cykgd2hlbmV2ZXIgb25lIGlzIHVzZWQgaW4gdGhlIHNhbWUgbWVtb3J5IGFkZHJlc3Mgc3BhY2Ug
YXMKPiBkYXRhIHdpdGggY29uZmlkZW50aWFsaXR5Cj4gY29uY2VybnMuICBBcyBzdWNoLCB1c2Ug
b2YgYSBKSVQgY29tcGlsZXIgaXMgcmVjb21tZW5kZWQgaW5zdGVhZC4gIEpJVAo+IGNvbXBpbGVy
cyBzaG91bGQgYmUgYXVkaXRlZAo+IGNhcmVmdWxseSBmb3IgdnVsbmVyYWJpbGl0aWVzIHRvIGVu
c3VyZSB0aGF0IEpJVCBjb21waWxhdGlvbiBvZiBhIHRydXN0ZWQKPiBhbmQgdmVyaWZpZWQgQlBG
IHByb2dyYW0KPiBkb2VzIG5vdCBpbnRyb2R1Y2UgdnVsbmVyYWJpbGl0aWVzLgoKQnV0IFdeWCBt
YXBwaW5ncyBhcmUgZm9yIEpJVCAoYW5kIGF2b2lkYWJsZSBieSB3cml0aW5nLCB0aGVuIHJlbWFw
cGluZwphbmQgZXhlY3V0aW5nKSwgbm90IGludGVycHJldGVycy4gSG93IGFib3V0IHdlIGp1c3Qg
c2F5ICJFeGVjdXRpbmcgdGhlCnByb2dyYW0gcmVxdWlyZXMgYW4gaW50ZXJwcmV0ZXIgb3IgSklU
IGNvbXBpbGVyIGluIHRoZSBzYW1lIG1lbW9yeQpzcGFjZSBhcyB0aGUgc3lzdGVtIGJlaW5nIHBy
b2JlZCBvciBleHRlbmRlZC4gVGhpcyBjcmVhdGVzIHJpc2tzIG9mCnRyYW5zaWVudCBleGVjdXRp
b24gYXR0YWNrcyB0aGF0IGNhbiByZXZlYWwgZGF0YSB3aXRoIGNvbmZpZGVudGlhbGl0eQpjb25j
ZXJucy4gTWV0aG9kcyBmb3IgYXZvaWRpbmcgdGhlc2UgYXR0YWNrcyBhcmUgdW5kZXIgYWN0aXZl
IHJlc2VhcmNoCmFuZCBmcmVxdWVudGx5IGRlcGVuZCBvbiBtaWNyb2FyY2hpdGVjdHVyYWwgZGV0
YWlscy4iCgpTaW5jZXJlbHksCldhdHNvbgo+Cj4gRGF2ZQo+Cj4gLS0KPiBCcGYgbWFpbGluZyBs
aXN0Cj4gQnBmQGlldGYub3JnCj4gaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYKCgoKLS0gCkFzdHJhIG1vcnRlbXF1ZSBwcmFlc3RhcmUgZ3JhZGF0aW0KCi0tIApCcGYg
bWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2JwZgo=

