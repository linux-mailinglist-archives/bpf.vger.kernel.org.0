Return-Path: <bpf+bounces-21424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F6384D151
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 19:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B061C25759
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F583CCC;
	Wed,  7 Feb 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="c2rZazBM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="gIz4cyQM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iiNPRno0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCE839F7
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331192; cv=none; b=XP1v7uu5kkytHCYkt5HeTwO27brZdxu8uY46YZEUkfi02coqTNRXLzm6Pyio9PoA68NyDy1G0WxgWliq3LuVXQQWX3BnI4c0CRqq2wB++ZfmkPbfivpkJjwjqgsID5t4RTccVummkbfCI9MNJVIaMQOnrY8irgeKWcUVAD5g5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331192; c=relaxed/simple;
	bh=JJPSM+CaZwB79GVzeEaWaGeEYt0fyOEmzogF42hLckc=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=eaYYoyXu4ugjQTQgsoQ9vN8swC5GaEWw5zGiahVwi+xP5FfTK/iwz6t0pTFA5YnbPY7CaZIKwhfE/kDCxCHI39DPQnZ2u3RLkLbRavxRUkB8OYlXCF/x3yfiRC+wYQE8QN2dxDgKHgcMJjwAKKHzDcmafODR+G1AvMkJkNC6wQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=c2rZazBM; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=gIz4cyQM reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iiNPRno0 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C3E04C15155F
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1707331184; bh=JJPSM+CaZwB79GVzeEaWaGeEYt0fyOEmzogF42hLckc=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c2rZazBMYma3hzfKxACOA2iNjoI7LY7xSYl+MgrK0qDRWw6AvxEXBp7goc78sCPIL
	 VZPaZM2oFkdWWuarB8UYyGAhuR33S/W+qBlxRAW2UM4mtvxOxjyTzoMNPCSxkm38uw
	 phb4JIvMhSK6m2etUL8enYhn9FKVp9xgPuM5N9G4=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8EA0CC14CE27;
 Wed,  7 Feb 2024 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1707331184; bh=JJPSM+CaZwB79GVzeEaWaGeEYt0fyOEmzogF42hLckc=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=gIz4cyQMuj7X5QoZCLcLLDc22YTxvtGE2vY8GpCAb+E87VZ2wcC0z6FOdxWxgvGIB
 QyluZPdFAJ9vtbJ/P6ixzvHnojka0Dums6fYAXgNvYY2afZW62AN2OXVyyJNcjE3xw
 KVbE20L9pBpwI0Js9/OnfFfWb54AUDMk2vFSw/+0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 38C48C14F699
 for <bpf@ietfa.amsl.com>; Wed,  7 Feb 2024 10:39:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.854
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAS-MtglXpxI for <bpf@ietfa.amsl.com>;
 Wed,  7 Feb 2024 10:39:38 -0800 (PST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B14EBC151065
 for <bpf@ietf.org>; Wed,  7 Feb 2024 10:39:38 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bda4bd14e2so856599b6e.2
 for <bpf@ietf.org>; Wed, 07 Feb 2024 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1707331178; x=1707935978; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xrAbsT0EZ00gT6OWInQSNVdN560BkoUCoMaPJ98KcDc=;
 b=iiNPRno0m8LoKL24KmwHI512eKBRWBB984JF0P/3qmK7/QjRCvsgaL8SLC/FK/Zti1
 6Hc1LZbunMupFEFb+iAXxg4QEHgZ7JUn5oDjNmjrEuyemA/CjoxK497J4Q4tw+iIxXzH
 IfSinB+Ex/S2xD4dvYAMmHVrMmbBGH8PcqNNxtw9nriTPEyenNcwp6XE5G1YLBCgCouC
 QzpTwAYdckREgXbDYtTO1JC7eFF1rW428lue6gcFloMzOoJs3VHXrcii0z2SuPJZkMO7
 nP2pYPZHt/bTFYWydx5uRAEcBRE/LDUZlwspGbeySWEiJLeaKAFC2kJT0/vu2AwVxVty
 9MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707331178; x=1707935978;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrAbsT0EZ00gT6OWInQSNVdN560BkoUCoMaPJ98KcDc=;
 b=i7WeS52u99ZnzllYWB2bWqmGg12mGXm8oXFZ7JSLHPEr6PeyUHi8Vd0wPbBoK0LJk2
 Lp6N/1HziL6PYssT2BOg+lSoApD9vn5oHfSTHxo+0+WVSgeD08/ytHIyZWig5mXNLV9G
 6kpUItxzWHr7oPMjdyLLZzWRBKO3OUo6+bIRPFZ8eYvt/tF9pPBt983cDFMT5u1iGb5D
 Xv+E4ezBZ9RTmTXH+vxN9sqTWsG1exOyruubGO8oY+iMTZyYFM58zqNdI4KibwY7BwgA
 emjRS5ljzWiOstYSTY8i8XymTyP6MIs5TvykzyH8vfIWORapvIZem2NmvS//ID15J47w
 cxZw==
X-Gm-Message-State: AOJu0YwftMZntMl6eJWPHbQpbrFrinc6Pvk7F6ldFbtNbOs7H1zmYw5l
 AZ8wdUpX7k8VfiyAsTmHLHcW6BgM3qkzOytAqg4IlTA0z1ItpWfo
X-Google-Smtp-Source: AGHT+IEIPVIsrUAlnIdEQSYUztKLl95tym+Y+az3x56nYHqaTEZaXDYosBqTfQVjjtrWdj0vJ3e7tA==
X-Received: by 2002:a05:6808:3088:b0:3bf:ee8f:556a with SMTP id
 bl8-20020a056808308800b003bfee8f556amr2325923oib.48.1707331177939; 
 Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYkA0ZcIk2eWWvDOC3koweUSGBcPlB9pYPc65i9vBuKs8WEilFS1gdqOpl6EF6Ht7tXSk5mVDuqaSlL6GFCqWX/9lNlkyiX1eBlZGoFLt9EQKFR+Q05Wqc0QE8+Y=
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d26-20020a05680808fa00b003bed4bba856sm287426oic.13.2024.02.07.10.39.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>
Cc: <bpf@ietf.org>, "'bpf'" <bpf@vger.kernel.org>,
 "'Jose E. Marchesi'" <jose.marchesi@oracle.com>
References: <076001da53a1$9ebfa210$dc3ee630$@gmail.com>
 <87wmrqiotx.fsf@oracle.com>
 <CAADnVQJDDHEVjrDeXyY+GOncnG+CFY=TBspuZUPzDU6nDLyo9Q@mail.gmail.com>
 <0d8301da591b$813d05a0$83b710e0$@gmail.com>
 <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
In-Reply-To: <CAADnVQJUrLh91so59_4F7txVefPnp5mSongXpZAD0R1yvfq7JA@mail.gmail.com>
Date: Wed, 7 Feb 2024 10:39:34 -0800
Message-ID: <123001da59f4$ffebb2a0$ffc317e0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLEYKQbFH8DoKfsRCUXp0fT6URjgIX5UybAepfDAQBGtXGJAH4fYNCsOUVqkA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/eUFqO-WlqgMtGXClqhRuFvxo83Q>
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
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZTog
Cj4gT24gVHVlLCBGZWIgNiwgMjAyNCBhdCA4OjQy4oCvQU0gPGR0aGFsZXIxOTY4QGdvb2dsZW1h
aWwuY29tPiB3cm90ZToKPiA+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDExOjQ54oCv
QU0gSm9zZSBFLiBNYXJjaGVzaQo+ID4gPiA8am9zZS5tYXJjaGVzaUBvcmFjbGUuY29tPiB3cm90
ZToKPiA+ID4gPiA+IGNsYW5nIGdlbmVyYXRlcyBCUEYgY29kZSB3aXRoIG9wY29kZSAweDhkIChC
UEZfQ0FMTCB8IEJQRl9YLAo+ID4gPiA+ID4gd2hpY2ggaXQgY2FsbHMgImNhbGx4IiksIHdoZW4g
Y29tcGlsaW5nIHdpdGggLU8wIG9yIC1PMS4gIE9mCj4gPiA+ID4gPiBjb3Vyc2UgLU8yIGlzIHJl
Y29tbWVuZGVkLCBidXQgaWYgYW55b25lIGxhdGVyIGRlZmluZXMgb3Bjb2RlCj4gPiA+ID4gPiAw
eDhkIGZvciBhbnl0aGluZyBvdGhlciB0aGFuIHdoYXQgY2xhbmcgbWVhbnMgYnkgaXQsIGl0IGNv
dWxkIGNhdXNlCj4gcHJvYmxlbXMuCj4gPiA+ID4KPiA+ID4gPiBHQ0MgYWxzbyBnZW5lcmF0ZXMg
QlBGX0NBTEx8QlBGX1ggYWxzbyBuYW1lZCBjYWxseCwgYnV0IG9ubHkgaWYKPiA+ID4gPiB0aGUg
ZXhwZXJpbWVudGFsIC1teGJwZiBvcHRpb24gaXMgcGFzc2VkIHRvIHRoZSBjb21waWxlci4KPiA+
ID4gPgo+ID4gPiA+IEkgcmVjb21tZW5kIHRoaXMgcGFydGljdWxhciBlbmNvZGluZyB0byBiZSBz
cGVjaWZpY2FsbHkgcmVzZXJ2ZWQKPiA+ID4gPiBmb3IgYSBmdXR1cmUgYGNhbGwgUkVHJyBmb3Ig
d2hlbi9pZiBhIHRpbWUgY29tZXMgd2hlbiB0aGUgQlBGCj4gPiA+ID4gdmVyaWZpZXIgc3VwcG9y
dHMgc29tZSBmb3JtIG9mIGluZGlyZWN0IGNhbGxzLgo+ID4gPgo+ID4gPiArMS4KPiA+ID4gU2Ft
ZSB0aGlua2luZyBmcm9tIGxsdm0gcG92Lgo+ID4gPiBDQUxMfFggaXMgd2hhdCB3ZSB3aWxsIHVz
ZSB3aGVuIHRoZSBrZXJuZWwgc3VwcG9ydHMgaW5kaXJlY3QgY2FsbHMuCj4gPiA+IEkgdGhpbmsg
aXQgbWVhbnMgd2UgbmVlZCB0byBhZGQgYSAncmVzZXJ2ZWQnIGNhdGVnb3J5IHRvIHRoZSBzcGVj
Lgo+ID4KPiA+IE15IHJlYWRpbmcgb2YgdGhpcyB0aHJlYWQgaXMgdGhhdCB0aGVyZSBzZWVtcyB0
byBiZSBjb25zZW5zdXMgdGhhdDoKPiA+IDEpIENBTEx8WCBzaG91bGQgaGF2ZSBhbiBlbnRyeSBp
biB0aGUgSUFOQSByZWdpc3RyeSB3aXRoIGl0cyBvd24KPiA+IGNvbmZvcm1hbmNlIGdyb3VwLAo+
ID4gMikgVGhlIGludGVuZGVkIG1lYW5pbmcgaXMgdW5kZXJzdG9vZCwKPiA+IDMpIGNsYW5nIGFu
ZCBnY2MgYm90aCBpbXBsZW1lbnQgaXQgYWxyZWFkeSB3aXRoIHRoZSBpbnRlbmRlZCBtZWFuaW5n
LAo+ID4gNCkgVGhlIExpbnV4IGtlcm5lbCBtaWdodCBzdXBwb3J0IGl0IHNvbWVkYXkuCj4gPgo+
ID4gSSdkIHByb3Bvc2Ugd2UgbWFrZSBpdCBpdHMgb3duIGNvbmZvcm1hbmNlIGdyb3VwIGNhbGxl
ZCAiY2FsbHgiLCB3aGljaAo+ID4gb2YgY291cnNlIHRoZSBMaW51eCBrZXJuZWwgZG9lcyBub3Qg
eWV0IHN1cHBvcnQsIGJ1dCBjbGFuZyBhbmQgZ2NjIGRvLgo+ID4KPiA+IFJhdGlvbmFsZToKPiA+
ICogVGhlcmUgbWF5IGJlIG90aGVyIGluc3RydWN0aW9ucyByZXNlcnZlZCBvdmVyIHRpbWUgaW4g
dGhlIGZ1dHVyZSBzbwo+ID4gICAgdXNpbmcgYSBtb3JlIHNwZWNpZmljIG5hbWUgdGhhbiBqdXN0
ICJyZXNlcnZlZCIgaXMgZ29vZCBzaW5jZSBsYXRlcgo+ID4gICAgYWRkaXRpb25zIHJlcXVpcmUg
bmV3IGdyb3VwcyB3aXRoIGRpZmZlcmVudCBuYW1lcy4KClRoaXMgYWxzbyBub3cgbWFrZXMgbWUg
dGhpbmsgd2Ugc2hvdWxkIHByb2JhYmx5IHJlbmFtZSB0aGUKImxlZ2FjeSIgY29uZm9ybWFuY2Ug
Z3JvdXAgdG8gInBhY2tldCIgZm9yIHNpbWlsYXIgcmVhc29ucy4KSXQncyB0aGUgc3RhdHVzIChI
aXN0b3JpY2FsKSBvZiB0aGUgZ3JvdXAgcmF0aGVyIHRoYW4gdGhlIG5hbWUgdGhhdCBhY3R1YWxs
eQptYWtlcyBpdCBsZWdhY3kuCgo+ID4gKiBEZWZpbmluZyBpdCBub3cgd2l0aCB0aGUgbWVhbmlu
ZyBhbHJlYWR5IGltcGxlbWVudGVkIGJ5IGNsYW5nICYgZ2NjCj4gPiAgICBtZWFucyB0aGF0IG5v
IGNoYW5nZXMgYXJlIG5lZWRlZCBsYXRlciBvbmNlIExpbnV4IHN1cHBvcnRzIGl0Lgo+ID4gKiBl
YnBmLWZvci13aW5kb3dzIGlzIGxpa2VseSB0byBzdGFydCBzdXBwb3J0aW5nIGl0IGluIHRoZSB2
ZXJ5IG5lYXIgZnV0dXJlCj4gPiAgICBhcyBhIHJlc3VsdCBvZiB0aGlzIHRocmVhZC4gVGhlcmUg
aXMgYWxyZWFkeSBhIGdpdGh1YiBwdWxsIHJlcXVlc3QgdW5kZXIKPiA+ICAgIHJldmlldyB0byBh
ZGQgc3VwcG9ydCBmb3IgaXQgaW4gdGhlIFBSRVZBSUwgdmVyaWZpZXIuCj4gCj4gQWxsIG1ha2Vz
IHNlbnNlIHRvIG1lLgo+IENvdWxkIHlvdSBzaGFyZSBhIHByZXZhaWwgcHVsbCBsaW5rPwo+IEkn
bSBjdXJpb3VzIHdoYXQgaXQgbWVhbnMgdG8gc3VwcG9ydCBpdCBpbiB0aGF0IHZlcmlmaWVyPwoK
aHR0cHM6Ly9naXRodWIuY29tL3ZicGYvZWJwZi12ZXJpZmllci9wdWxsLzU4NAoKSSBkb24ndCBr
bm93IHlldCB3aGV0aGVyIGl0IHdpbGwgYmUgYWNjZXB0ZWQgaW4gdGhlIGN1cnJlbnQgZm9ybSwK
YnV0IHRoZSBwcm9wb3NlZCBhcHByb2FjaCBpcyBiYXNpY2FsbHk6CgoqIEZhaWwgdmVyaWZpY2F0
aW9uIHVubGVzcyB0aGUgcmVnaXN0ZXIgaXMga25vd24gdG8gYWx3YXlzIGhvbGQgYSBzaW5nbGUK
ICAgaW50ZWdlciB2YWx1ZSBhdCB0aGUgdGltZSBvZiB0aGUgaW5zdHJ1Y3Rpb24uICBUaGlzIGNv
dmVycyB0aGUgY29tbW9uIGNhc2UuCiogVXNpbmcgdGhlIHNpbmdsZSBpbnRlZ2VyLCBkbyB0aGUg
c2FtZSB2ZXJpZmllciBjaGVja3MgYXMgd291bGQgaGF2ZQogICBiZWVuIGRvbmUgd2l0aCB0aGUg
bm9ybWFsIEJQRl9DQUxMIGluc3RydWN0aW9uLgoqIEl0J3Mgb25seSBpbXBsZW1lbnRlZCBmb3Ig
c3JjID0gMHgwIHNvIGZhciBzaW5jZSBQUkVWQUlMIGRvZXNuJ3QgeWV0CiAgIHN1cHBvcnQgc3Jj
ID0gMHgxIG9yIDB4MiAodGhlcmUncyBzZXBhcmF0ZSBnaXRodWIgaXNzdWVzIHRyYWNraW5nIHRo
b3NlKSwKICAgYnV0IHRoZSBtZWNoYW5pc20gZm9yIGNhbGx4IHdvdWxkIGJlIHRoZSBzYW1lIGZv
ciB0aG9zZSBvbmNlIHRoZXkncmUKICAgaW1wbGVtZW50ZWQuCgpEYXZlCgotLSAKQnBmIG1haWxp
bmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYK

