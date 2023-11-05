Return-Path: <bpf+bounces-14218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3B7E12DF
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87FC1C20A36
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20AF9474;
	Sun,  5 Nov 2023 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZTiMLedh";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZTiMLedh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUulQx5c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAA8F5F
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 09:51:35 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47FCF
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 01:51:33 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 4E747C06F22F
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699177893; bh=X2DOCFDW5eEt98DMSu++AEDbV22pNR/cqv0UjHVnFLs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZTiMLedh4sSv9MqLGOG4lYWIiT//rkcX4FzR/v26Mc25Hz3c6vDc8cPhEAgQzWIpL
	 2Dg5zRmma3Dyp2X/LrtBrQJzBEFe9tGwyAtxBL7kVH7qbRPWojOCI6cdevIZSSpFCm
	 DZqBgQBL0Kl0k5NyIWIyxCG+vFyjXrKmTrZRaFSM=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Nov  5 01:51:33 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2333BC1D46EC;
	Sun,  5 Nov 2023 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1699177893; bh=X2DOCFDW5eEt98DMSu++AEDbV22pNR/cqv0UjHVnFLs=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZTiMLedh4sSv9MqLGOG4lYWIiT//rkcX4FzR/v26Mc25Hz3c6vDc8cPhEAgQzWIpL
	 2Dg5zRmma3Dyp2X/LrtBrQJzBEFe9tGwyAtxBL7kVH7qbRPWojOCI6cdevIZSSpFCm
	 DZqBgQBL0Kl0k5NyIWIyxCG+vFyjXrKmTrZRaFSM=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id AAA4BC15C2A5
 for <bpf@ietfa.amsl.com>; Sun,  5 Nov 2023 01:51:32 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kdjBezIT6C2B for <bpf@ietfa.amsl.com>;
 Sun,  5 Nov 2023 01:51:32 -0800 (PST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 46C7EC1D46EC
 for <bpf@ietf.org>; Sun,  5 Nov 2023 01:51:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-507975d34e8so5003394e87.1
 for <bpf@ietf.org>; Sun, 05 Nov 2023 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699177890; x=1699782690; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjcPMO12JeMo6oFMzCF57vbfHf1P824sz09Cbt1FOto=;
 b=LUulQx5cuqfGOlvqd5gkFWAO5wmgYtchJ9q6BJVzfiikvfneLWLndSjcwNBWjcP2Pp
 cI9Ep/hsmy6MuCWPTH2yQIjMxjwNtyf62o2YYu/Bj80dp80lwtrm4aI8b7KDJDjrKeS+
 wiDF6pSrsJPvAhPzw0odtwoLcaPd2VUF77Dxy4gX/I2IzGFEShoOAsRlxsjQ7KDQ+F0L
 iOBbK9qcTmRb5Ujp8xNt38mG81TQnqarsjivzRIoW6D8Cx4gg1E4fV6EB7NU1GX5AvCH
 3AGPo4o8GrXGKsK8cSnxH+W2MBQVZ/hdLbOt8/pAUUY5gAosNPg7JANsL7mloXRw2mVH
 FTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699177890; x=1699782690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PjcPMO12JeMo6oFMzCF57vbfHf1P824sz09Cbt1FOto=;
 b=dk4SUSUA3+JwpzsHt87OlvLXvekb9HCnfGJL5TmgvqEN9RWi2B2kiTnS61pdJ1pzky
 0GpQp/1g1UcMRLhcP/S1L5ILX3EEoq37X72AUXDKgzAWvlbC38mCwZuX0tZOZYOm+ruY
 /3PgQEFGzi7omQ16vlGxIIhAz6YBl30J3Pb7tLNVlQlmwQH9eh6nLGNUukTXfHQcxtEs
 LL+nKx6kxDbaXFS0VM0yRGNj5nEkLfv9ueBfGVZCBxvyZ2Fq/NGSHl/e/xNE8hYDX4yw
 AWRuo2G/Bw+Oq1b5L8S3fX4ARd6Jfp7+gaziVxc6SZ8a78zi+FK//GmUzNktedsLS5mR
 6wAg==
X-Gm-Message-State: AOJu0YzLsouN8Xi2CwTNN3+sm6RQLfUEl/fKeWjKvJ4PXOq5DleWdxOu
 zRWYYSPTZLQ2y3gIM+f05O4EDqRa+E1ssK0QUGeaBOrv+H8=
X-Google-Smtp-Source: AGHT+IGpl1CwABFAzqyNjqyZnM6BzUHoQVwaK8IkqP5Hg0cnl5XNneYWJdUw8iTRil1i+U8Iu1SD7aGZIeI8tzqqRW4=
X-Received: by 2002:ac2:5442:0:b0:500:af69:5556 with SMTP id
 d2-20020ac25442000000b00500af695556mr18170733lfn.29.1699177890207; Sun, 05
 Nov 2023 01:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr>
In-Reply-To: <20231103212024.327833-1-hawkinsw@obs.cr>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Nov 2023 01:51:19 -0800
Message-ID: <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/NzXm2Pzdo8NbVRBgvZC3CSrGbEA>
Subject: Re: [Bpf] [PATCH v3] bpf,
 docs: Add additional ABI working draft base text
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

T24gRnJpLCBOb3YgMywgMjAyMyBhdCAyOjIw4oCvUE0gV2lsbCBIYXdraW5zIDxoYXdraW5zd0Bv
YnMuY3I+IHdyb3RlOgo+ICsKPiArVGhlIEFCSSBpcyBzcGVjaWZpZWQgaW4gdHdvIHBhcnRzOiBh
IGdlbmVyaWMgcGFydCBhbmQgYSBwcm9jZXNzb3Itc3BlY2lmaWMgcGFydC4KPiArQSBwYWlyaW5n
IG9mIGdlbmVyaWMgQUJJIHdpdGggdGhlIHByb2Nlc3Nvci1zcGVjaWZpYyBBQkkgZm9yIGEgY2Vy
dGFpbgo+ICtpbnN0YW50aWF0aW9uIG9mIGEgQlBGIG1hY2hpbmUgcmVwcmVzZW50cyBhIGNvbXBs
ZXRlIGJpbmFyeSBpbnRlcmZhY2UgZm9yIEJQRgo+ICtwcm9ncmFtcyBleGVjdXRpbmcgb24gdGhh
dCBtYWNoaW5lLgo+ICsKPiArVGhpcyBkb2N1bWVudCBpcyB0aGUgZ2VuZXJpYyBBQkkgYW5kIHNw
ZWNpZmllcyB0aGUgcGFyYW1ldGVycyBhbmQgYmVoYXZpb3IKPiArY29tbW9uIHRvIGFsbCBpbnN0
YW50aWF0aW9ucyBvZiBCUEYgbWFjaGluZXMuIEluIGFkZGl0aW9uLCBpdCBkZWZpbmVzIHRoZQo+
ICtkZXRhaWxzIHRoYXQgbXVzdCBiZSBzcGVjaWZpZWQgYnkgZWFjaCBwcm9jZXNzb3Itc3BlY2lm
aWMgQUJJLgo+ICsKPiArVGhlc2UgcHNBQklzIGFyZSB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIEFC
SS4gRWFjaCBpbnN0YW50aWF0aW9uIG9mIGEgQlBGCj4gK21hY2hpbmUgbXVzdCBkZXNjcmliZSB0
aGUgbWVjaGFuaXNtIHRocm91Z2ggd2hpY2ggYmluYXJ5IGludGVyZmFjZQo+ICtjb21wYXRpYmls
aXR5IGlzIG1haW50YWluZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBpc3N1ZXMgaGlnaGxpZ2h0ZWQg
YnkgdGhpcwo+ICtkb2N1bWVudC4gSG93ZXZlciwgdGhlIGRldGFpbHMgdGhhdCBtdXN0IGJlIGRl
ZmluZWQgYnkgYSBwc0FCSSBhcmUgYSBtaW5pbXVtIC0tCj4gK2EgcHNBQkkgbWF5IHNwZWNpZnkg
YWRkaXRpb25hbCByZXF1aXJlbWVudHMgZm9yIGJpbmFyeSBpbnRlcmZhY2UgY29tcGF0aWJpbGl0
eQo+ICtvbiBhIHBsYXRmb3JtLgoKSSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSB0cnlp
bmcgdG8gc2F5IGluIHRoZSBhYm92ZS4KSW4gbXkgbWluZCB0aGVyZSBpcyBvbmx5IG9uZSBCUEYg
cHNBQkkgYW5kIGl0IGRvZXNuJ3QgaGF2ZQpnZW5lcmljIGFuZCBwcm9jZXNzb3IgcGFydHMuIFRo
ZXJlIGlzIG9ubHkgb25lICJwcm9jZXNzb3IiLgpCUEYgaXMgc3VjaCBhIHByb2Nlc3Nvci4KCi0t
IApCcGYgbWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2JwZgo=

