Return-Path: <bpf+bounces-27458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180AD8AD464
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F21C21124
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43A155394;
	Mon, 22 Apr 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Crkt+/Rb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Crkt+/Rb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNv7L2t/"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347A1474D3
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811798; cv=none; b=cF1KxxW4fZDd2EE0wtHAx/mdZmyVflkG83nisBZ0JTwRk3MXQpl7myazttMkXygPq6t6jdbDTC4smMSTP6ChWDrWIPtulO3EaqbCvTJHQyN98naULop3tmJJ+6uBFXIdleul/WTs6xaPIKK9yJvCK5a9vVZRqgFfh5Q3AuUBV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811798; c=relaxed/simple;
	bh=5EjOG+u18oMfWWJUJoQZnPlNoANH4UVMMtE4tbWUhhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=jzCsUPdjd65JmKKOxqt9xaQxZnRtiC5FOYaz5Z1tXncEzNN4CdnIrG8930peAPJ6pRXfxcX5XL/M+zgy7bvPzXvGyq0TW2rEphmhBUiEtAfvRaZSdiEg4Dv9voLHvoPcxmWMmwk/0SyrKZ2SP2hM3N4Cscsmol8rHmhHm9eYj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Crkt+/Rb; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Crkt+/Rb; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNv7L2t/ reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7B2D7C1930B0
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713811796; bh=5EjOG+u18oMfWWJUJoQZnPlNoANH4UVMMtE4tbWUhhs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Crkt+/Rb5vOYQyXL+S3HSxJuo37Vcb/C5nm+H1FQTXarymB7MTDz8MNpZQ855HNLT
	 olQSXCQPPOIHBPXjLqkfO8EBE9b6SqCfVTf/xCFM3NvRi0kE7TnqXglGbIDhv5/4TM
	 g/P4l2mUpTeicnrTB7p3KX7AmUbENEKgEQnv2ueo=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Apr 22 11:49:56 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4CE8DC18DB8E;
	Mon, 22 Apr 2024 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713811796; bh=5EjOG+u18oMfWWJUJoQZnPlNoANH4UVMMtE4tbWUhhs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=Crkt+/Rb5vOYQyXL+S3HSxJuo37Vcb/C5nm+H1FQTXarymB7MTDz8MNpZQ855HNLT
	 olQSXCQPPOIHBPXjLqkfO8EBE9b6SqCfVTf/xCFM3NvRi0kE7TnqXglGbIDhv5/4TM
	 g/P4l2mUpTeicnrTB7p3KX7AmUbENEKgEQnv2ueo=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 3FAF9C18DB8F
 for <bpf@ietfa.amsl.com>; Mon, 22 Apr 2024 11:49:55 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.095
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTrTBSoPT5r1 for <bpf@ietfa.amsl.com>;
 Mon, 22 Apr 2024 11:49:51 -0700 (PDT)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 717A6C18DB8E
 for <bpf@ietf.org>; Mon, 22 Apr 2024 11:49:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34b64b7728cso105494f8f.0
 for <bpf@ietf.org>; Mon, 22 Apr 2024 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713811789; x=1714416589; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiRNn7upgUuaQsU1pt0QfK+J1fpewc+eaCfhpu3qwxQ=;
 b=LNv7L2t/3UWk0gME98oqYjzdq2LNo0gpI3HtY1WqyQZDzseIbrxCT4TrrFxCf2hq8m
 AhWYTFarpnUU4ejH/KxMt1Y2zmdvi8mKPoUojxZcGCjBc9eTR+iXoGI04UXZDmTMgS/3
 qiI0hlKVu7Y80UEAixhZc8fiUKQMF+4v79HFtRiENcb0UtuTod8Kr1Cx+hWnFm3wCOwH
 UArPgnoSmDm4ps8NWxClQV1WRBz27tHenU6qTfZi8Edu1DUbkCD4AsN4Ntk6sd4/smP6
 GGIdncHHzxF3mtY3sjgnrzL+RcYTXP+8qhFyaMraKakELS3ZSK0y7RktAKTqlWtl8zw2
 pEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713811789; x=1714416589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiRNn7upgUuaQsU1pt0QfK+J1fpewc+eaCfhpu3qwxQ=;
 b=uqfRSKApPFkuy98X5dHsNLyg3ytDlWIyPYg2TimcSo+pZkKaltlzGLIintpg+kLg0k
 6mNfBIPPWXoaEg9CsUf8Yb28hlMnVeDnI60YifmvcqurmxQOuneJupwB7V8Na3XdLY6J
 rZoWu7eX4mk3AKxg61d+rkFdSR/BhJuY/UOtuSZ1PaufVcU3ZrF/0QIeKta8QoivzBdj
 DRZyLEpV+awjqrBY+7OfFUclyesu4XL2PsfrgOngWxeHri/EPhnqmuGFH2Fnm/6UgYjg
 N6vfafmJLuJ73bCQVApZdgwoZO4vjju+kekEkxzXssJU1Zxj6h9zqQWpb8WYVC/EFnjR
 8GGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9afhC05frb3Chs98P+ZOS6sgKT2tATdLjXkbldCgFWV6LK3401Ynn1PcFms+W36IPo4TNDsSGFBNzJOM=
X-Gm-Message-State: AOJu0YyVgf7ZSY5/vLmcmrXvLJCEy4sjx4a++kzVAQbp7mvO66BTloKi
 DlFXGGIka29CSv3RMstyARpQ7HukFj5lpp3wZjc8rmDZQf6UidIuzEncAHxE02ybd7KDS5p5AIN
 jLIfIMs1aT4wb/1KwEdrYTySvnr0=
X-Google-Smtp-Source: AGHT+IGTvAfNLSVHGpQ5tStl2kARL1suXWhd5DzQJ3IOVDwg2mmVui3cBUl0Kba3l+dw6zo4NFMCiuvFW0Il0am9ER0=
X-Received: by 2002:adf:e743:0:b0:346:afab:9702 with SMTP id
 c3-20020adfe743000000b00346afab9702mr7158667wrn.13.1713811789113; Mon, 22 Apr
 2024 11:49:49 -0700 (PDT)
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
In-Reply-To: <149401da94e4$2da0acd0$88e20670$@gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Mon, 22 Apr 2024 11:49:37 -0700
Message-ID: <CACsn0c=H7e_G_X=L4i5mnNpZJPB4U4wZCYkg9N0qrypQUzKmPw@mail.gmail.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: dthaler1968@googlemail.com, David Vernet <void@manifault.com>, bpf@ietf.org,
 bpf@vger.kernel.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/IRQZWGm21aX69134nyhsqltsN5I>
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

T24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgMTE6MzjigK9BTQo8ZHRoYWxlcjE5Njg9NDBnb29nbGVt
YWlsLmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6Cj4KPiBEYXZpZCBWZXJuZXQgPHZvaWRAbWFu
aWZhdWx0LmNvbT4gd3JvdGU6Cj4gPiA+IFRoYW5rcyBmb3Igd3JpdGluZyB0aGlzIHVwLiBPdmVy
YWxsIGl0IGxvb2tzIGdyZWF0LCBqdXN0IGhhZCBvbmUKPiA+ID4gY29tbWVudAo+ID4gYmVsb3cu
Cj4gPiA+Cj4gPiA+ID4gPiBTZWN1cml0eSBDb25zaWRlcmF0aW9ucwo+ID4gPiA+ID4KPiA+ID4g
PiA+IEJQRiBwcm9ncmFtcyBjb3VsZCB1c2UgQlBGIGluc3RydWN0aW9ucyB0byBkbyBtYWxpY2lv
dXMgdGhpbmdzCj4gPiA+ID4gPiB3aXRoIG1lbW9yeSwgQ1BVLCBuZXR3b3JraW5nLCBvciBvdGhl
ciBzeXN0ZW0gcmVzb3VyY2VzLiBUaGlzIGlzCj4gPiA+ID4gPiBub3QgZnVuZGFtZW50YWxseSBk
aWZmZXJlbnQgIGZyb20gYW55IG90aGVyIHR5cGUgb2Ygc29mdHdhcmUgdGhhdAo+ID4gPiA+ID4g
bWF5IHJ1biBvbiBhIGRldmljZS4gRXhlY3V0aW9uIGVudmlyb25tZW50cyBzaG91bGQgYmUgY2Fy
ZWZ1bGx5Cj4gPiA+ID4gPiBkZXNpZ25lZCB0byBvbmx5IHJ1biBCUEYgcHJvZ3JhbXMgdGhhdCBh
cmUgdHJ1c3RlZCBvciB2ZXJpZmllZCwKPiA+ID4gPiA+IGFuZCBzYW5kYm94aW5nIGFuZCBwcml2
aWxlZ2UgbGV2ZWwgc2VwYXJhdGlvbiBhcmUga2V5IHN0cmF0ZWdpZXMKPiA+ID4gPiA+IGZvciBs
aW1pdGluZyBzZWN1cml0eSBhbmQgYWJ1c2UgaW1wYWN0LiBGb3IgZXhhbXBsZSwgQlBGIHZlcmlm
aWVycwo+ID4gPiA+ID4gYXJlIHdlbGwta25vd24gYW5kIHdpZGVseSBkZXBsb3llZCBhbmQgYXJl
IHJlc3BvbnNpYmxlIGZvcgo+ID4gPiA+ID4gZW5zdXJpbmcgdGhhdCBCUEYgcHJvZ3JhbXMgd2ls
bCB0ZXJtaW5hdGUgd2l0aGluIGEgcmVhc29uYWJsZQo+ID4gPiA+ID4gdGltZSwgb25seSBpbnRl
cmFjdCB3aXRoIG1lbW9yeSBpbiBzYWZlIHdheXMsIGFuZCBhZGhlcmUgdG8KPiA+ID4gPiA+IHBs
YXRmb3JtLXNwZWNpZmllZCBBUEkgY29udHJhY3RzLiBUaGUgZGV0YWlscyBhcmUgb3V0IG9mIHNj
b3BlIG9mCj4gPiA+ID4gPiB0aGlzIGRvY3VtZW50IChidXQgc2VlIFtMSU5VWF0gYW5kIFtQUkVW
QUlMXSksIGJ1dCB0aGlzIGxldmVsIG9mCj4gPiA+ID4gPiB2ZXJpZmljYXRpb24gY2FuIG9mdGVu
IHByb3ZpZGUgYSBzdHJvbmdlciBsZXZlbCBvZiBzZWN1cml0eQo+ID4gPiA+ID4gYXNzdXJhbmNl
IHRoYW4gZm9yIG90aGVyIHNvZnR3YXJlIGFuZCBvcGVyYXRpbmcgc3lzdGVtIGNvZGUuCj4gPiA+
ID4gPgo+ID4gPiA+ID4gRXhlY3V0aW5nIHByb2dyYW1zIHVzaW5nIHRoZSBCUEYgaW5zdHJ1Y3Rp
b24gc2V0IGFsc28gcmVxdWlyZXMKPiA+ID4gPiA+IGVpdGhlciBhbiBpbnRlcnByZXRlciBvciBh
IEpJVCBjb21waWxlciB0byB0cmFuc2xhdGUgdGhlbSB0bwo+ID4gPiA+ID4gaGFyZHdhcmUgcHJv
Y2Vzc29yIG5hdGl2ZSBpbnN0cnVjdGlvbnMuIEluIGdlbmVyYWwsIGludGVycHJldGVycwo+ID4g
PiA+ID4gYXJlIGNvbnNpZGVyZWQgYSBzb3VyY2Ugb2YgaW5zZWN1cml0eSAoZS5nLiwgZ2FkZ2V0
cyBzdXNjZXB0aWJsZQo+ID4gPiA+ID4gdG8gc2lkZS1jaGFubmVsIGF0dGFja3MgZHVlIHRvIHNw
ZWN1bGF0aXZlIGV4ZWN1dGlvbikgYW5kIGFyZSBub3QKPiA+ID4gPiA+IHJlY29tbWVuZGVkLgo+
ID4gPgo+ID4gPiBEbyB3ZSBuZWVkIHRvIHNheSB0aGF0IGl0J3Mgbm90IHJlY29tbWVuZGVkIHRv
IHVzZSBKSVQgZW5naW5lcz8gR2l2ZW4KPiA+ID4gdGhhdAo+ID4gdGhpcyBpcwo+ID4gPiBleHBs
YWluaW5nIGhvdyBCUEYgcHJvZ3JhbXMgYXJlIGV4ZWN1dGVkLCB0byBtZSBpdCByZWFkcyBhIGJp
dCBhcwo+ID4gPiBzYXlpbmcsCj4gPiAiSXQncyBub3QKPiA+ID4gcmVjb21tZW5kZWQgdG8gdXNl
IEJQRi4iIElzIGl0IG5vdCBzdWZmaWNpZW50IHRvIGp1c3QgZXhwbGFpbiB0aGUgcmlza3M/Cj4g
Pgo+ID4gSXQgc2F5cyBpdCdzIG5vdCByZWNvbW1lbmRlZCB0byB1c2UgaW50ZXJwcmV0ZXJzLgo+
ID4gSSBjb3VsZG4ndCB0ZWxsIGlmIHlvdXIgY29tbWVudCB3YXMgYSB0eXBvLCBkaWQgeW91IG1l
YW4gaW50ZXJwcmV0ZXJzIG9yCj4gSklUCj4gPiBlbmdpbmVzPwo+ID4gSXQgc2hvdWxkIHJlYWQg
YXMgc2F5aW5nIGl0J3MgcmVjb21tZW5kZWQgdG8gdXNlIGEgSklUIGVuZ2luZSByYXRoZXIgdGhh
bgo+IGFuCj4gPiBpbnRlcnByZXRlci4KPiA+Cj4gPiBEbyB5b3UgaGF2ZSBhIHN1Z2dlc3RlZCBh
bHRlcm5hdGUgd29yZGluZz8KPgo+IEhvdyBhYm91dDoKPgo+IE9MRDogSW4gZ2VuZXJhbCwgaW50
ZXJwcmV0ZXJzIGFyZSBjb25zaWRlcmVkIGEKPiBPTEQ6IHNvdXJjZSBvZiBpbnNlY3VyaXR5IChl
LmcuLCBnYWRnZXRzIHN1c2NlcHRpYmxlIHRvIHNpZGUtY2hhbm5lbCBhdHRhY2tzCj4gZHVlIHRv
IHNwZWN1bGF0aXZlIGV4ZWN1dGlvbikKPiBPTEQ6IGFuZCBhcmUgbm90IHJlY29tbWVuZGVkLgo+
Cj4gTkVXOiBJbiBnZW5lcmFsLCBpbnRlcnByZXRlcnMgYXJlIGNvbnNpZGVyZWQgYQo+IE5FVzog
c291cmNlIG9mIGluc2VjdXJpdHkgKGUuZy4sIGdhZGdldHMgc3VzY2VwdGlibGUgdG8gc2lkZS1j
aGFubmVsIGF0dGFja3MKPiBkdWUgdG8gc3BlY3VsYXRpdmUgZXhlY3V0aW9uKQo+IE5FVzogc28g
dXNlIG9mIGEgSklUIGNvbXBpbGVyIGlzIHJlY29tbWVuZGVkIGluc3RlYWQuCgpJIGFtIHZlcnkg
Y29uZnVzZWQgYWJvdXQgdGhlIHN1YnN0YW5jZSBvZiB0aGlzIHJlY29tbWVuZGF0aW9uLiBJJ3Zl
CmFsc28gZ290IG90aGVyIGNvbW1lbnRzLCBidXQgd2lsbCBwdXQgdGhvc2UgaW4gc2VwYXJhdGUg
cmVwbHkuCgpTaW1wbHkgcHV0IEpJVHMgYXJlbid0IG1hZ2ljLiBXaGV0aGVyIGEgYm91bmRzIGNo
ZWNrIGlzIHB1dCBpbiBieSBhCmNvbXBpbGVyIG9yIGFuIGludGVycHJldGVyIGV4ZWN1dGVzIGl0
IGRpcmVjdGx5LCBpdCBjYW4gc3RpbGwgYmUKc3BlY3VsYXRpdmVseSBieXBhc3NlZC4gSWYgYW55
dGhpbmcgSklUcyBtYXkgc2ltcGxpZnkgdGhlIG1hdHRlcgpjb21wYXJlZCB0byBpbnRlcnByZXRl
cnMgYXMgdGhlIGV4ZWN1dGlvbiBwYXRoIG1hcHMgbW9yZSBjbG9zZWx5IHRvCnRoZSBCUEYgZXhl
Y3V0ZWQsIGFuZCB0aGUgQlBGIHdpbGwgaGF2ZSB0aWdodGVyIGNvbnRyb2wgb2YgcGF0aHMgYW5k
CmxheW91dCBpZiBlLmcuIGl0IGlzIGluamVjdGluZyBicmFuY2hlcyB0byBmb29sIHRoZSBDUFUg
bGF0ZXIuIFRoZXJlJ3MKYSB3aWRlIHJhbmdlIG9mIGV4ZWN1dGlvbiB0ZWNobm9sb2dpZXMgdGhh
dCBnbyB1bmRlciB0aGUgbmFtZSBKSVQgYW5kCmludGVycHJldGVyLCBmcm9tIHRocmVhZGVkIGNv
ZGUgdG8gY29tcGxldGUgY29tcGlsYXRpb24gdG8gdHJhY2UgYmFzZWQKY29tcGlsYXRpb24gd2l0
aCBiYWlsb3V0cyB0byBldmVuIG1vcmUgY29tcGxleCBzY2hlbWVzLiBBbGwgb2YgdGhlbQpoYXZl
IFNwZWN0ZXIgaXNzdWVzLgoKU2luY2VyZWx5LApXYXRzb24gTGFkZAoKPgo+IERhdmUKPgo+IC0t
Cj4gQnBmIG1haWxpbmcgbGlzdAo+IEJwZkBpZXRmLm9yZwo+IGh0dHBzOi8vd3d3LmlldGYub3Jn
L21haWxtYW4vbGlzdGluZm8vYnBmCgoKCi0tIApBc3RyYSBtb3J0ZW1xdWUgcHJhZXN0YXJlIGdy
YWRhdGltCgotLSAKQnBmIG1haWxpbmcgbGlzdApCcGZAaWV0Zi5vcmcKaHR0cHM6Ly93d3cuaWV0
Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9icGYK

