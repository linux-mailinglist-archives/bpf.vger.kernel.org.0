Return-Path: <bpf+bounces-21387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95684C249
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2BB1F23665
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D0DF4E;
	Wed,  7 Feb 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="H6RXbUbz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="H6RXbUbz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4encC5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5623DDC7
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271923; cv=none; b=Y3kRdI2mKoIruCFpEuLbrnEtXn+xiDtwvX/nnhLZzg9QoQP2Qjz5U25mEBKm12YEoT87QH+Ac97Tmk2pHlStW03MGJPuyE4kKQc4TiyQKvv2OFACHkkQn33bhE2Kwy01Uqh6b2m13XXxzXa4Sf3sdlhXxCrYprLlD3KEFpt2svQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271923; c=relaxed/simple;
	bh=eHoHa2/MuuMoS66YUB1t4SozdtELxa0AruzWARBjrws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=Q1hBN8d1Bd3ZZpZSkJfGLRhPZdCynPRLlou3UVkwpICPekPbEdUYnL/kXb7ULTvpj6eTx0tVmMOBkU0YrGSRk0t7KdF39f5odJqE10yUu2XGXUb+EhCOP1teS3GaPoyJBMYJaZhs9HPLpRUqhBT/XvQfCHWx0sPmKREu45kqgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=H6RXbUbz; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=H6RXbUbz; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4encC5x reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 3AE92C151520
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707271921; bh=eHoHa2/MuuMoS66YUB1t4SozdtELxa0AruzWARBjrws=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=H6RXbUbz2q/LBuBTyvy/C9pMLLv9ZrTurc1bOfqUlR3dLRr4Ika9wgTD7fKK2LjyA
	 NitTdsPgDZ3uuFI9/VvC/OmEVJen9roPZdS052xLLGYDd55CjmB+3bzPY9Dph2N0GE
	 SkHvwzkQZABL2n+OhkaIvf0o7TWUonBrjqiikmgo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Feb  6 18:12:01 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 03BD8C14F6E1;
	Tue,  6 Feb 2024 18:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707271921; bh=eHoHa2/MuuMoS66YUB1t4SozdtELxa0AruzWARBjrws=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=H6RXbUbz2q/LBuBTyvy/C9pMLLv9ZrTurc1bOfqUlR3dLRr4Ika9wgTD7fKK2LjyA
	 NitTdsPgDZ3uuFI9/VvC/OmEVJen9roPZdS052xLLGYDd55CjmB+3bzPY9Dph2N0GE
	 SkHvwzkQZABL2n+OhkaIvf0o7TWUonBrjqiikmgo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 093E2C14F6E1
 for <bpf@ietfa.amsl.com>; Tue,  6 Feb 2024 18:11:59 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CeRa4IwQzf7k for <bpf@ietfa.amsl.com>;
 Tue,  6 Feb 2024 18:11:58 -0800 (PST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 467AEC14F61B
 for <bpf@ietf.org>; Tue,  6 Feb 2024 18:11:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b436dbdcfso132538f8f.0
 for <bpf@ietf.org>; Tue, 06 Feb 2024 18:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707271917; x=1707876717; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SEHEUNvhqJwK6/Tus4sUiPtU6RclW7cz5I6oxUd24I=;
 b=E4encC5x5f4l++7bUxuXcksTYNPUUaDNzbq19rzKBzJwTwoXEGwGj8C8cEFluRvPvy
 WyIW3sHgzY3o9JiBocMNk3QrHpcAV29tN7uHkI681YSmPzp647ZJt6/mgXxh1HqLdo/5
 ovdZ+uGyixiZJ7IIhVwQ5RHzLPq7k1p1Q+S3FWUP4wIdlUP3nZ6cQqPB7AoywwZmm+q+
 H4rAjy9NGAKt0QUmJdZzqu6hLCPYkJ/KfQyErjX180TRMv/vMJDyu5CjGHHzWz2yKvYs
 oIw1qOtFFrlo1lMA52Vrpj24lLizjnZZJI1PtBjwiXrH6pvu11z17J6+wSCHoZU0vLKO
 u2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707271917; x=1707876717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SEHEUNvhqJwK6/Tus4sUiPtU6RclW7cz5I6oxUd24I=;
 b=fEQWfyaYqQfapiwEQopTD5N6sK11WEzdV8Eoguo+51451HeKEmLsPnnEaq+dCszI2e
 bU3qCDUCDiQAEGHl5+xYfJBBkdF5SvkF2z6/TBU/J9oytiKzAM3GB7ll0/46MzVaqWzS
 uooHfg+Ff/a5FlBsIBWaOfo9v7oV+Oydy7eLWTQVhJU5HrRE0/Cw+mfjE1lvMoTomXgd
 7q2WmyaSwcpFz7jtVI1iOQbO2VVEawS2pk1F3vAt1lOCwEvZpPPfVfuR/KEn0d2jWyxy
 uXABwvETRT9w935X+3PnN+DEQnSDOdUg2jsXVy4Qspo0oP8JaAAsnPN/zU0F3zd08/ZD
 tsGw==
X-Gm-Message-State: AOJu0YxfvETIHrhhzJaFVJ5CkPop6aaoq7SggqtlRniClXKbLrGtekD2
 j9yoDl1yhrVyHK4N3Nu7yXVEaccQOLIobhp1+0oHXIR7F4WNcN4HvAu+5ufcUwH7CJNyW4HOiWm
 kC4+C8IrLyBqagjrKIR7xZ/nM2So=
X-Google-Smtp-Source: AGHT+IHWxRyU7SSfyjNbfwwbAjXdZnqDPnxUOdhFythjw6BU/kCMiJfQUeZV8uoEIfwV7mDORzrgfBhR4+pIkiFhMiM=
X-Received: by 2002:adf:ce8b:0:b0:33b:4d5e:ace4 with SMTP id
 r11-20020adfce8b000000b0033b4d5eace4mr516863wrn.36.1707271916411; Tue, 06 Feb
 2024 18:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
 <87wmrqiotx.fsf@oracle.com>
 <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
 <0d8301da591b$813d05a0$83b710e0$@gmail.com>
In-Reply-To: <0d8301da591b$813d05a0$83b710e0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Feb 2024 18:11:44 -0800
Message-ID: <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/XUz0ptvfLRxN9tWk8Ul1BSkHxIM>
Subject: Re: [Bpf] ISA: BPF_CALL | BPF_X
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

T24gVHVlLCBGZWIgNiwgMjAyNCBhdCA4OjQy4oCvQU0gPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwu
Y29tPiB3cm90ZToKPgo+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUsIEphbiAzMCwgMjAyNCBhdCAxMTo0OeKAr0FNIEpv
c2UgRS4gTWFyY2hlc2kKPiA+IDxqb3NlLm1hcmNoZXNpQG9yYWNsZS5jb20+IHdyb3RlOgo+ID4g
PiA+IGNsYW5nIGdlbmVyYXRlcyBCUEYgY29kZSB3aXRoIG9wY29kZSAweDhkIChCUEZfQ0FMTCB8
IEJQRl9YLCB3aGljaAo+ID4gPiA+IGl0IGNhbGxzICJjYWxseCIpLCB3aGVuIGNvbXBpbGluZyB3
aXRoIC1PMCBvciAtTzEuICBPZiBjb3Vyc2UgLU8yIGlzCj4gPiA+ID4gcmVjb21tZW5kZWQsIGJ1
dCBpZiBhbnlvbmUgbGF0ZXIgZGVmaW5lcyBvcGNvZGUgMHg4ZCBmb3IgYW55dGhpbmcKPiA+ID4g
PiBvdGhlciB0aGFuIHdoYXQgY2xhbmcgbWVhbnMgYnkgaXQsIGl0IGNvdWxkIGNhdXNlIHByb2Js
ZW1zLgo+ID4gPgo+ID4gPiBHQ0MgYWxzbyBnZW5lcmF0ZXMgQlBGX0NBTEx8QlBGX1ggYWxzbyBu
YW1lZCBjYWxseCwgYnV0IG9ubHkgaWYgdGhlCj4gPiA+IGV4cGVyaW1lbnRhbCAtbXhicGYgb3B0
aW9uIGlzIHBhc3NlZCB0byB0aGUgY29tcGlsZXIuCj4gPiA+Cj4gPiA+IEkgcmVjb21tZW5kIHRo
aXMgcGFydGljdWxhciBlbmNvZGluZyB0byBiZSBzcGVjaWZpY2FsbHkgcmVzZXJ2ZWQgZm9yIGEK
PiA+ID4gZnV0dXJlIGBjYWxsIFJFRycgZm9yIHdoZW4vaWYgYSB0aW1lIGNvbWVzIHdoZW4gdGhl
IEJQRiB2ZXJpZmllcgo+ID4gPiBzdXBwb3J0cyBzb21lIGZvcm0gb2YgaW5kaXJlY3QgY2FsbHMu
Cj4gPgo+ID4gKzEuCj4gPiBTYW1lIHRoaW5raW5nIGZyb20gbGx2bSBwb3YuCj4gPiBDQUxMfFgg
aXMgd2hhdCB3ZSB3aWxsIHVzZSB3aGVuIHRoZSBrZXJuZWwgc3VwcG9ydHMgaW5kaXJlY3QgY2Fs
bHMuCj4gPiBJIHRoaW5rIGl0IG1lYW5zIHdlIG5lZWQgdG8gYWRkIGEgJ3Jlc2VydmVkJyBjYXRl
Z29yeSB0byB0aGUgc3BlYy4KPgo+IE15IHJlYWRpbmcgb2YgdGhpcyB0aHJlYWQgaXMgdGhhdCB0
aGVyZSBzZWVtcyB0byBiZSBjb25zZW5zdXMgdGhhdDoKPiAxKSBDQUxMfFggc2hvdWxkIGhhdmUg
YW4gZW50cnkgaW4gdGhlIElBTkEgcmVnaXN0cnkgd2l0aCBpdHMgb3duIGNvbmZvcm1hbmNlIGdy
b3VwLAo+IDIpIFRoZSBpbnRlbmRlZCBtZWFuaW5nIGlzIHVuZGVyc3Rvb2QsCj4gMykgY2xhbmcg
YW5kIGdjYyBib3RoIGltcGxlbWVudCBpdCBhbHJlYWR5IHdpdGggdGhlIGludGVuZGVkIG1lYW5p
bmcsCj4gNCkgVGhlIExpbnV4IGtlcm5lbCBtaWdodCBzdXBwb3J0IGl0IHNvbWVkYXkuCj4KPiBJ
J2QgcHJvcG9zZSB3ZSBtYWtlIGl0IGl0cyBvd24gY29uZm9ybWFuY2UgZ3JvdXAgY2FsbGVkICJj
YWxseCIsCj4gd2hpY2ggb2YgY291cnNlIHRoZSBMaW51eCBrZXJuZWwgZG9lcyBub3QgeWV0IHN1
cHBvcnQsIGJ1dCBjbGFuZyBhbmQgZ2NjIGRvLgo+Cj4gUmF0aW9uYWxlOgo+ICogVGhlcmUgbWF5
IGJlIG90aGVyIGluc3RydWN0aW9ucyByZXNlcnZlZCBvdmVyIHRpbWUgaW4gdGhlIGZ1dHVyZSBz
bwo+ICAgIHVzaW5nIGEgbW9yZSBzcGVjaWZpYyBuYW1lIHRoYW4ganVzdCAicmVzZXJ2ZWQiIGlz
IGdvb2Qgc2luY2UgbGF0ZXIKPiAgICBhZGRpdGlvbnMgcmVxdWlyZSBuZXcgZ3JvdXBzIHdpdGgg
ZGlmZmVyZW50IG5hbWVzLgo+ICogRGVmaW5pbmcgaXQgbm93IHdpdGggdGhlIG1lYW5pbmcgYWxy
ZWFkeSBpbXBsZW1lbnRlZCBieSBjbGFuZyAmIGdjYwo+ICAgIG1lYW5zIHRoYXQgbm8gY2hhbmdl
cyBhcmUgbmVlZGVkIGxhdGVyIG9uY2UgTGludXggc3VwcG9ydHMgaXQuCj4gKiBlYnBmLWZvci13
aW5kb3dzIGlzIGxpa2VseSB0byBzdGFydCBzdXBwb3J0aW5nIGl0IGluIHRoZSB2ZXJ5IG5lYXIg
ZnV0dXJlCj4gICAgYXMgYSByZXN1bHQgb2YgdGhpcyB0aHJlYWQuIFRoZXJlIGlzIGFscmVhZHkg
YSBnaXRodWIgcHVsbCByZXF1ZXN0IHVuZGVyCj4gICAgcmV2aWV3IHRvIGFkZCBzdXBwb3J0IGZv
ciBpdCBpbiB0aGUgUFJFVkFJTCB2ZXJpZmllci4KCkFsbCBtYWtlcyBzZW5zZSB0byBtZS4KQ291
bGQgeW91IHNoYXJlIGEgcHJldmFpbCBwdWxsIGxpbms/CkknbSBjdXJpb3VzIHdoYXQgaXQgbWVh
bnMgdG8gc3VwcG9ydCBpdCBpbiB0aGF0IHZlcmlmaWVyPwoKLS0gCkJwZiBtYWlsaW5nIGxpc3QK
QnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

