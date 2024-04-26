Return-Path: <bpf+bounces-27970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499558B4019
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0074B282A0F
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F4171A1;
	Fri, 26 Apr 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="bm6lSssQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="vm1p+Km3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGJWpitD"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C621173F
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159358; cv=none; b=fV3KKPiiXiv9E3DmzkTiptFTMFjemqq7xlmZJzZON2+VcoBELDe9YYoMHaahLcEfAu7BFOakDZ1B7zN1Bj4Ds4MiWoi65B2nMeiiC0yMlw9KKfSyXKjU799B2NvXB4Q5IqILwCHeQfWwGuPmoLaLsqBA2/JmhyRVa5ZAoH/zSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159358; c=relaxed/simple;
	bh=GdPaJ/JGG+iFCX15+UUXcM5jfPBJzeCVOe5YAN+bdN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=Lq60STsTiOsVPVuHHtfP9nTi1fMjOeEILoFSdX5Da704F8fbXqRZhhOb5kCEARn7XIv6RW0uyf7sEG/XwmIMs3DuXNtukT5HPGw1Pyw2x9vRRzBZGP/Kv1tTCFQnQgCDmMvd1lb13gX/UIkvhowIuG1mavWp3G7BtJYcMEWRMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=bm6lSssQ; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=vm1p+Km3; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGJWpitD reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1543FC1840CD
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714159356; bh=GdPaJ/JGG+iFCX15+UUXcM5jfPBJzeCVOe5YAN+bdN4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=bm6lSssQAhi2D+nDLj/wPNFE5XOWcaV8+mTvd6kjWfZohK8yL+pPWDAcbHl9Np14l
	 i4nIO2ChN3zdqsIAwFlU0q9o234eEv3owfDtFCDlo94aWqTPEeIsRtsOdOSy9cCwJ9
	 vJ3ZDdAMLEnD/VnZhaV0z3iC67RdS9H95QBF0cUg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Apr 26 12:22:36 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DC16BC14F73E;
	Fri, 26 Apr 2024 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1714159355; bh=GdPaJ/JGG+iFCX15+UUXcM5jfPBJzeCVOe5YAN+bdN4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=vm1p+Km3Q8hWGygajD1mcj1kctNVaVkrFd1JDXnwG8HNbUJPPUYodGEcbsRaY4QGi
	 K0N9TYbQPgl1CYnDH3pcGpFXEdViNdaAYRMdBdO62LSxk+7GjtLxGAbvvMrzYeNMHS
	 xg9GG5KRJind+O3iTtVNOD3e+Cn5Nt7w6Ehy7PfE=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6C206C14F6A4
 for <bpf@ietfa.amsl.com>; Fri, 26 Apr 2024 12:22:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.098
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6b9578N1aAj for <bpf@ietfa.amsl.com>;
 Fri, 26 Apr 2024 12:22:32 -0700 (PDT)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id BBC8CC180B71
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:21:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41b782405d5so12743485e9.2
 for <bpf@ietf.org>; Fri, 26 Apr 2024 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714159315; x=1714764115; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvXnIn/XDuJAQsm3VwD/VgmBSl2ZQcQJR0lrhNHqgko=;
 b=TGJWpitDOwRPMOcBAONI2/FL/pj0X6LriLlYEog00o+rjvCTkHqKguLI8BqPBMivvb
 8wKRWwaA1tB5YZ8N4YqD1fcO3NnBkZIop/XW/bLJ5HLZINEMuHZcS7x5+iDTo5IBYRcN
 7Crrgxfd2TLrYABbqb0lmCN2BY2vFw9RYIqTYEiyN+O2CZsy9Lb2B1i0WvhmYukZHAR8
 ToAGKcXWM3rZfqVLvyAexbxv+uzoX58ACac9CGr++5bJizLPFT3MdVi1EvrbDRJh6rU8
 dtxxO1wcBf9l6O6JM46SbjURwZ22l7T2BZ9pz+uNRpqnzwu6S2qAwjSFvBdgDAYTMPS3
 ejDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714159315; x=1714764115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvXnIn/XDuJAQsm3VwD/VgmBSl2ZQcQJR0lrhNHqgko=;
 b=C96HfA/+m9rlNzw6S0bwLaAg+aflb/6ywFQTIUML1byFrrI3Xq4XGowgF+dn0g/dFL
 E+10Am6cPVTDZdtswANra5DwNr2TBqENwxwXpYfwiKgA6gFWbhM7WrOt6EHt0pJjRq+4
 pbcTy5JrKdmCm2+WlvVYOLIghfEAU7Hk679vHb0TCbqUe2iPyte9m8dR3/w//HYpSOie
 SN++b+OGNj2uKuQ4Ttgz5cfWIEsCk3vVbgDpLe13IWAqj5iNwrq7DWgd6uCLbIl6htXG
 gnRsj2z3knpfgyPXGXf2cO+NcRJTLTWke3beGrKvIzng+AT2ZslxaTMq7uN8rvpzbLv1
 LUig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz4DLIPNPZssRSOT9PI/ohztnBU7Yc9Q1v4HlhD6uQHIQjuXNs+mPk+yrY4dtDVehFvNxXyy/AJBPiX7Q=
X-Gm-Message-State: AOJu0YyroccmcBhGqvH0ul2K+3jscNe1ce7d9RxSVzrpVf2jPdj/LSST
 x6F2Aaqw8i9rp7IPYeudwWc/yQ1mlwQlun2kd7lVbPPBHZ0mzPA9jeRYSG9Ni6NDtqaFAbiSrOD
 HZSlLGqlvMRIsH2YVT6p0Q2YmNiY=
X-Google-Smtp-Source: AGHT+IH0MLG0SVP4mrXSBuAu8KABnzQTBrtqHEbXi4UMP6EvI2jnDFoYCj5B9kf3O7PRo8R7RKIqh13ChOAsi9o5Vk0=
X-Received: by 2002:a5d:6306:0:b0:34c:7410:d6c8 with SMTP id
 i6-20020a5d6306000000b0034c7410d6c8mr1837093wru.49.1714159315386; Fri, 26 Apr
 2024 12:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426171103.3496-1-dthaler1968@gmail.com>
In-Reply-To: <20240426171103.3496-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 12:21:43 -0700
Message-ID: <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org,
 Dave Thaler <dthaler1968@gmail.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/ruB01SVBL_mhM4hAI0DNNElqAjY>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify PC use in instruction-set.rst
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMTA6MTHigK9BTSBEYXZlIFRoYWxlciA8ZHRoYWxlcjE5
NjhAZ29vZ2xlbWFpbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBlbGFib3JhdGVzIG9uIHRo
ZSB1c2Ugb2YgUEMgYnkgZXhwYW5kaW5nIHRoZSBQQyBhY3JvbnltLAo+IGV4cGxhaW5pbmcgdGhl
IHVuaXRzLCBhbmQgdGhlIHJlbGF0aXZlIHBvc2l0aW9uIHRvIHdoaWNoIHRoZSBvZmZzZXQKPiBh
cHBsaWVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2ds
ZW1haWwuY29tPgo+IC0tLQo+ICBEb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5z
dHJ1Y3Rpb24tc2V0LnJzdCB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9p
bnN0cnVjdGlvbi1zZXQucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYvc3RhbmRhcmRpemF0aW9uL2lu
c3RydWN0aW9uLXNldC5yc3QKPiBpbmRleCBiNDRiZGFjZDAuLjU1OTI2MjBjZiAxMDA2NDQKPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJz
dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1z
ZXQucnN0Cj4gQEAgLTQ2OSw2ICs0NjksMTEgQEAgSlNMVCAgICAgIDB4YyAgICBhbnkgICAgICBQ
QyArPSBvZmZzZXQgaWYgZHN0IDwgc3JjICAgICAgICAgIHNpZ25lZAo+ICBKU0xFICAgICAgMHhk
ICAgIGFueSAgICAgIFBDICs9IG9mZnNldCBpZiBkc3QgPD0gc3JjICAgICAgICAgc2lnbmVkCj4g
ID09PT09PT09ICA9PT09PSAgPT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
Pgo+ICt3aGVyZSAnUEMnIGRlbm90ZXMgdGhlIHByb2dyYW0gY291bnRlciwgYW5kIHRoZSBvZmZz
ZXQgdG8gaW5jcmVtZW50IGJ5Cj4gK2lzIGluIHVuaXRzIG9mIDY0LWJpdCBpbnN0cnVjdGlvbnMg
cmVsYXRpdmUgdG8gdGhlIGluc3RydWN0aW9uIGZvbGxvd2luZwo+ICt0aGUganVtcCBpbnN0cnVj
dGlvbi4gIFRodXMgJ1BDICs9IDEnIHJlc3VsdHMgaW4gdGhlIG5leHQgaW5zdHJ1Y3Rpb24KPiAr
dG8gZXhlY3V0ZSBiZWluZyB0d28gNjQtYml0IGluc3RydWN0aW9ucyBsYXRlci4KClRoZSBsYXN0
IHBhcnQgaXMgY29uZnVzaW5nLgoidHdvIDY0LWJpdCBpbnN0cnVjdGlvbnMgbGF0ZXIiCkknbSBz
dHJ1Z2dsaW5nIHRvIHVuZGVyc3RhbmQgdGhhdC4KTWF5YmUgc2F5IHRoYXQgJ1BDICs9IDEnIHNr
aXBzIGV4ZWN1dGlvbiBvZiB0aGUgbmV4dCBpbnNuPwoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBm
QGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

