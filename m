Return-Path: <bpf+bounces-20293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCDF83B76A
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F4D1C23B59
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A748C63AE;
	Thu, 25 Jan 2024 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="n5bTqUTQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="n5bTqUTQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCRrMvFJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA475566A
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151364; cv=none; b=sRteDIoHpF6+3U46X7gIua5Mp5eTOoKgEzyEriwtdukk4bHUtNS0/nrfKMLXe8E7vIBymcUuHkH8gWDBw8SFvk4sAvs+rkitfW0UCE1/MjJkEaeCYwOaS4y+C2na1DvvywlZa/pST78MA+ZvAP8Ib+UuXvrh2yOx5HQW52axZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151364; c=relaxed/simple;
	bh=tYCVbaj0N+9IKDa7pWIaEPs8rWRzsSbinnr4d2NgWMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=eD0eikueXkCHJXqnoMXifrg+9KmhjenVghKjv/tZwDIw04kwUL/VfZT0TBWfU1v7NtrVs44gAtiF9bUa6KOpYnUiUDXvpFn7nksYPvVfG8MreKdgKHNay836wIYxTodMq8xJOt1X/2VUutvYlmFhVzw5BXGXgCh9WCs1VPWg7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=n5bTqUTQ; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=n5bTqUTQ; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCRrMvFJ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5B484C151989
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706151362; bh=tYCVbaj0N+9IKDa7pWIaEPs8rWRzsSbinnr4d2NgWMw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=n5bTqUTQaWn3sjFSSYIkiAui5nXPFSpEfmuEDz5kO0FGk/2sk9MUCejwUad5rjVJF
	 abhhLXC0yz0J3UbYQritrhIhprDM4fu8NcKdTiFXmHO38e1u1WmGJCTICmeF6wjbGW
	 F7NGH3ZYbrG04ZskDDyXm1wRwARIwf7s8eBzhkek=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 24 18:56:02 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 29BAEC14F71B;
	Wed, 24 Jan 2024 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706151362; bh=tYCVbaj0N+9IKDa7pWIaEPs8rWRzsSbinnr4d2NgWMw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=n5bTqUTQaWn3sjFSSYIkiAui5nXPFSpEfmuEDz5kO0FGk/2sk9MUCejwUad5rjVJF
	 abhhLXC0yz0J3UbYQritrhIhprDM4fu8NcKdTiFXmHO38e1u1WmGJCTICmeF6wjbGW
	 F7NGH3ZYbrG04ZskDDyXm1wRwARIwf7s8eBzhkek=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id B27EDC14F71B
 for <bpf@ietfa.amsl.com>; Wed, 24 Jan 2024 18:56:00 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kqaMjchOiewD for <bpf@ietfa.amsl.com>;
 Wed, 24 Jan 2024 18:55:58 -0800 (PST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 97731C14F6F3
 for <bpf@ietf.org>; Wed, 24 Jan 2024 18:55:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33931b38b65so3976596f8f.3
 for <bpf@ietf.org>; Wed, 24 Jan 2024 18:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706151357; x=1706756157; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbhGA0gDhCjRLVpsKiToXzQlCxMvHT4hJbqH0aQDeuI=;
 b=kCRrMvFJyTzYtvoTqLh5CH5hCu5pfOUPDcZTmh2PvDPd3Q1PDW2a/H9x5ay7/Iapuq
 9mRYGjp3EKqFkvbcaXtIurBPDLYbZBz7G+hey3RetHmd24q4ch1KgyHKnSEOUfGLtHJd
 t+IMznLJIwU20jwnibat20Ye7yGgQgEWmq2bLqKkPL3V7Q2WUVd4BGIszGAkZyrCC6il
 R39C8teSASFVOr+pKyH1S/fqaYmNsTw5bRlzI2bh+7Le+ogh3Z1eP1IwvMTCu1EvD2er
 WYTOw3Q6+j3tZpAPRXQCQJNfRVNnolbb9IhIdw6jf2zqkEN710mn2QkXOKcqIFvprtA0
 /ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706151357; x=1706756157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbhGA0gDhCjRLVpsKiToXzQlCxMvHT4hJbqH0aQDeuI=;
 b=umjETZdop0lZ0zRrQsaENBS7bycNP9yJaw/miFHkyRV9HwnvEZKyTmHC1GLHpYb7D+
 0B3bkeDo5p9fjoyg+K69yxoKmOpPJbV6HoaJcfdIEVWRoZNc9YBfOmljHBOovd4AiI4u
 YOz/vklH+p/FzJRPGVyU9nRJKFyZ2ea9H/y6tkOxivv8bf5z+wawxeaNFCmIQvwAwQJW
 5CfZRqGtjouqmS2Jv1YnNpXvWvJhINm+k0xNDgbqX88BSAdXKW/gEE3eQ1RFkECvYdUz
 kbCmP4NEvBtIUmBYKk/IsoNiZv/WKI6SORaJ0jO8CFeWILP4xA4Cmygg0/RFpLa0Rmnp
 sOJQ==
X-Gm-Message-State: AOJu0YyS6KonLmxKc/lfQckUlFSIXqxfoNFO0+k6kequro5GlwUNfU+u
 cJLNluRiSLS+5fr5Vo+vHScCtCz7fIb4UX06wht1+LqMJSTmQ1nKNorX3mSdQz7Kt/vUSYKaHe6
 kEaFuHwgw0F4hdu0PlyiIG42Bcunv5QTO
X-Google-Smtp-Source: AGHT+IE47PVU+SyIT0Gq5bH3DbX3L55aEhmnlU1Vd0psSXCvryuQERT+5x72Yf6bfGfxjYf8p7qoYgXao8sw8+iorwA=
X-Received: by 2002:a05:6000:510:b0:337:8db0:597d with SMTP id
 a16-20020a056000051000b003378db0597dmr86065wrf.116.1706151356977; Wed, 24 Jan
 2024 18:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214174437.GA2853@maniforge> <ZXvkS4qmRMZqlWhA@infradead.org>
 <CAADnVQ+ExRC_RavN_sbuOmuwyP6+HKnV9bFjJOseORBaVw0Jcg@mail.gmail.com>
 <09dc01da32a6$99c97e50$cd5c7af0$@gmail.com>
 <CAADnVQ+Kb20aUZdcqSh5eF-_dzpHWcpjAtYpLgg5Fqog=g7hpA@mail.gmail.com>
 <ZYPiq6ijLaMl/QD8@infradead.org> <20240105220711.GA1001999@maniforge>
 <ZZwcC7nZiZ+OV1ST@infradead.org>
 <CAADnVQLMo0M675T89gu9v_wSR+GbQmu4ajWjwgWK9aCNkJPsaQ@mail.gmail.com>
 <874jfm68ok.fsf@oracle.com> <20240123213948.GA221862@maniforge>
 <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
In-Reply-To: <1f8301da4e54$0b0ad690$212083b0$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 18:55:45 -0800
Message-ID: <CAADnVQ+iN=HMdZD3jVhQxPzCWKi07DZo_wxq28nuC4JuXk2ZGw@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: David Vernet <void@manifault.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
 Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Faust <david.faust@oracle.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/A--3VwJB82EMoEf2p4Uin8gNabk>
Subject: Re: [Bpf] BPF ISA conformance groups
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMzoyOeKAr1BNIDxkdGhhbGVyMTk2OEBnb29nbGVtYWls
LmNvbT4gd3JvdGU6Cj4KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBE
YXZpZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbT4KPiA+IFNlbnQ6IFR1ZXNkYXksIEphbnVh
cnkgMjMsIDIwMjQgMTo0MCBQTQo+ID4gVG86IEpvc2UgRS4gTWFyY2hlc2kgPGpvc2UubWFyY2hl
c2lAb3JhY2xlLmNvbT4KPiA+IENjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3Zv
aXRvdkBnbWFpbC5jb20+OyBDaHJpc3RvcGggSGVsbHdpZwo+ID4gPGhjaEBpbmZyYWRlYWQub3Jn
PjsgRGF2ZSBUaGFsZXIgPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tPjsKPiA+IGJwZkBpZXRm
Lm9yZzsgYnBmIDxicGZAdmdlci5rZXJuZWwub3JnPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz47Cj4gPiBkYXZpZC5mYXVzdEBvcmFjbGUuY29tCj4gPiBTdWJqZWN0OiBSZTogW0Jw
Zl0gQlBGIElTQSBjb25mb3JtYW5jZSBncm91cHMKPiA+Cj4gPiBPbiBUdWUsIEphbiAwOSwgMjAy
NCBhdCAxMjozNTozOVBNICswMTAwLCBKb3NlIEUuIE1hcmNoZXNpIHdyb3RlOgo+ID4gPgo+ID4g
PiA+IE9uIE1vbiwgSmFuIDgsIDIwMjQgYXQgODowMOKAr0FNIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4KPiA+IHdyb3RlOgo+ID4gPiA+Pgo+ID4gPiA+PiBPbiBGcmksIEph
biAwNSwgMjAyNCBhdCAwNDowNzoxMVBNIC0wNjAwLCBEYXZpZCBWZXJuZXQgd3JvdGU6Cj4gPiA+
ID4+ID4KPiA+ID4gPj4gPiBTbyBob3cgZG8gd2Ugd2FudCB0byBtb3ZlIGZvcndhcmQgaGVyZT8g
SXQgc291bmRzIGxpa2Ugd2UncmUKPiA+ID4gPj4gPiBsZWFuaW5nIHRvd2FyZCdzIEFsZXhlaSdz
IHByb3Bvc2FsIG9mIGhhdmluZzoKPiA+ID4gPj4gPgo+ID4gPiA+PiA+IC0gQmFzZSBJbnRlZ2Vy
IEluc3RydWN0aW9uIFNldCwgMzItYml0Cj4gPiA+ID4+ID4gLSBCYXNlIEludGVnZXIgSW5zdHJ1
Y3Rpb24gU2V0LCA2NC1iaXQKPiA+ID4gPj4gPiAtIEludGVnZXIgTXVsdGlwbGljYXRpb24gYW5k
IERpdmlzaW9uCj4gPiA+ID4+ID4gLSBBdG9taWMgSW5zdHJ1Y3Rpb25zCj4gPiA+ID4+Cj4gPiA+
ID4+IEFzIGluIHRoZSA2NC1iaXQgaW50ZWdlciBzZXQgd291bGQgYmUgYW4gYWRkLW9uIHRvIHRo
ZSBmaXJzdCBvbmUKPiA+ID4gPj4gd2hpY2ggaXMgdGhlIGNvcmUgc2V0PyAgSW4gdGhhdCBjYXNl
IHRoYXQncyBmaW5lIHdpdGggbWUsIGJ1dCB0aGUKPiA+ID4gPj4gYWJvdmUgd29yZGluZyBpcyBh
IGJpdCBzdWJvcHRpbWFsLgo+ID4gPiA+Cj4gPiA+ID4geWVzLgo+ID4gPiA+IEhlcmUgaXMgaG93
IEkgd2FzIHRoaW5raW5nIGFib3V0IHRoZSBncm91cGluZzoKPiA+ID4gPiAzMi1iaXQgc2V0OiBh
bGwgMzItYml0IGluc3RydWN0aW9ucyB0aG9zZSB3aXRoIEJQRl9BTFUgYW5kIEJQRl9KTVAzMgo+
ID4gPiA+IGFuZCBsb2FkL3N0b3JlLgo+ID4gPiA+Cj4gPiA+ID4gNjQtYml0IHNldDogYWJvdmUg
cGx1cyBCUEZfQUxVNjQgYW5kIEJQRl9KTVAuCj4gPiA+ID4KPiA+ID4gPiBUaGUgaWRlYSBpcyB0
byBhbGxvdyBmb3IgY2xlYW4gMzItYml0IEhXIG9mZmxvYWRzLgo+ID4gPiA+IFdlIGNhbiBpbnRy
b2R1Y2UgYSBjb21waWxlciBmbGFnIHRoYXQgd2lsbCBvbmx5IHVzZSBzdWNoCj4gPiA+ID4gaW5z
dHJ1Y3Rpb25zIGFuZCB3aWxsIGVycm9yIHdoZW4gNjQtYml0IG1hdGggaXMgbmVlZGVkLgo+ID4g
PiA+IERldGFpbHMgbmVlZCB0byBiZSB0aG91Z2h0IHRocm91Z2gsIG9mIGNvdXJzZS4KPiA+ID4g
PiBSaWdodCBub3cgSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCB0byByZWR1Y2Ugc2l6ZW9m
KHZvaWQqKSB0byA0Cj4gPiA+ID4gaW4gc3VjaCBhIGNhc2Ugb3Igbm9ybWFsIDggd2lsbCBzdGls
bCB3b3JrLCBidXQgZnJvbSBJU0EgcGVyc3BlY3RpdmUKPiA+ID4gPiBldmVyeXRoaW5nIGlzIHJl
YWR5LiAzMi1iaXQgc3VicmVnaXN0ZXJzIGZpdCB3ZWxsLgo+ID4gPiA+IFRoZSBjb21waWxlciB3
b3JrIHBsdXMgYWRkaXRpb25hbCB2ZXJpZmllciBzbWFydG5lc3MgaXMgbmVlZGVkLCBidXQKPiA+
ID4gPiB0aGUgZW5kIHJlc3VsdCBzaG91bGQgYmUgdmVyeSBuaWNlLgo+ID4gPiA+IE9mZmxvYWQg
b2YgYnBmIHByb2dyYW1zIGludG8gMzItYml0IGVtYmVkZGVkIGRldmljZXMgd2lsbCBiZSBwb3Nz
aWJsZS4KPiA+ID4KPiA+ID4gVGhpcyBpcyB2ZXJ5IGludGVyZXN0aW5nLgo+ID4gdGhpcyBpcyBu
ZWNlc3NhcmlseSBzb21ldGhpbmcgd2UgbmVlZCB0byBmaWd1cmUgb3V0IG5vdy4gSG9wZWZ1bGx5
IHRoaXMgaXMgYWxsCj4gPiBzdHVmZiB3ZSBjYW4gaXJvbiBvdXQgb25jZSB3ZSBzdGFydCB0byBy
ZWFsbHkgc2luayBvdXIgdGVldGggaW50byB0aGUgQUJJIGRvYy4KPgo+ICJJbnRlZ2VyIE11bHRp
cGxpY2F0aW9uIGFuZCBEaXZpc2lvbiIgaW4gdGhpcyB0aHJlYWQgZG9lc24ndCBzZWVtIHRvIHNl
cGFyYXRlCj4gYmV0d2VlbiAzMi1iaXQgdnMgNjQtYml0LiAgSXMgdGhlIHByb3Bvc2FsIHRoYXQg
bXVsdGlwbGljYXRpb24vZGl2aXNpb24gaXMgb2sKPiB0byByZXF1aXJlIDY0LWJpdCBvcGVyYXRp
b25zPyAgSSBoYWQgZXhwZWN0ZWQgb25lIHJhdGlvbmFsZSBmb3IgdGhlIDMyYml0Cj4gbXVsdGlw
bGljYXRpb24vZGl2aXNpb24gaW5zdHJ1Y3Rpb25zIGlzIHRvIGFjY29tbW9kYXRlIDMyLWJpdC1v
bmx5Cj4gaW1wbGVtZW50YXRpb25zLiAgIFNvIHNob3VsZCB3ZSBoYXZlIHNlcGFyYXRlIGdyb3Vw
cyBmb3IgMzItYml0IHZzCj4gNjQtYml0IGZvciB0aGUgbXVsdGlwbGljYXRpb24vZGl2aXNpb24g
aW5zdHJ1Y3Rpb25zPwo+Cj4gU2ltaWxhciBxdWVzdGlvbiBnb2VzIGZvciB0aGUgYXRvbWljIGlu
c3RydWN0aW9ucywgaS5lLiwgc2hvdWxkIHdlCj4gaGF2ZSBzZXBhcmF0ZSBjb25mb3JtYW5jZSBn
cm91cHMgZm9yIDMyLWJpdCB2cyA2NC1iaXQgYXRvbWljcz8KCnJpc2MtdiBkZWZpbmVzIG9ubHkg
b25lIGdyb3VwICJNIiBmb3IgZGl2L211bCBhbmQgYW5vdGhlciBncm91cCAiQSIKZm9yIGF0b21p
Y3MuCgpXaGF0IGl0IG1lYW5zIHRoYXQgZ3JvdXBzICJiYXNlMzIgKyBNIiBtZWFucyB0aGF0IG9u
bHkgMzItYml0IG11bAppcyBhdmFpbGFibGUgd2hpbGUgImJhc2U2NCArIE0iIG1lYW5zIHRoYXQg
Ym90aCAzMiBhbmQgNjQtYml0IGFsdSBpcyB0aGVyZS4KCi0tIApCcGYgbWFpbGluZyBsaXN0CkJw
ZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZgo=

