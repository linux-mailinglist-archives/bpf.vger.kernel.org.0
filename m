Return-Path: <bpf+bounces-13013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B1F7D3A5D
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E391F22085
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F021BDC8;
	Mon, 23 Oct 2023 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eVOXS9cO";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eVOXS9cO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="07JnKKxF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0914AA9
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:06:50 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A529DD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:06:48 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A8253C170600
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698073608; bh=cZpfhiCWzgU00SfS2AWuf6pT+8YdPTLWP0iBtW1TluI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eVOXS9cOOXGq6yRh89U1IJKL7l9Z5/YBdrC6MN2SVqpzkfH5UkzgS64TwdQCU9Zp5
	 L83FjitmxnSO0ksWskehjgR3EUqsDQXk+Co8TAEBZF3h6FYJ/16czjzm2GXGNbK0i4
	 SUMLKwEyseYOI6GPMBfy9ByVadpzhWcJSXYmcH2g=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct 23 08:06:48 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 53407C151080;
	Mon, 23 Oct 2023 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1698073608; bh=cZpfhiCWzgU00SfS2AWuf6pT+8YdPTLWP0iBtW1TluI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=eVOXS9cOOXGq6yRh89U1IJKL7l9Z5/YBdrC6MN2SVqpzkfH5UkzgS64TwdQCU9Zp5
	 L83FjitmxnSO0ksWskehjgR3EUqsDQXk+Co8TAEBZF3h6FYJ/16czjzm2GXGNbK0i4
	 SUMLKwEyseYOI6GPMBfy9ByVadpzhWcJSXYmcH2g=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BF9D2C14CE4A
 for <bpf@ietfa.amsl.com>; Mon, 23 Oct 2023 08:06:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.905
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20230601.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVgWGaLoy1MG for <bpf@ietfa.amsl.com>;
 Mon, 23 Oct 2023 08:06:43 -0700 (PDT)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id F236FC151080
 for <bpf@ietf.org>; Mon, 23 Oct 2023 08:06:42 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-581de3e691dso2036758eaf.3
 for <bpf@ietf.org>; Mon, 23 Oct 2023 08:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1698073602; x=1698678402;
 darn=ietf.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=589kWa60rv9ivRuzxruIRObnx4upUw3uc1WngFwaW/E=;
 b=07JnKKxFPMvkHBj9OIe5rrdyFBBnCA0U4q1LFzjK5KR3jamklvgsatxR0jprZVvZXM
 aqMe15f2/zoPBzGc0BnS3sQ+5m6O+dceBM9dQN/AfzqKGhYKTwnxL3VbLEJJLFG8JiiL
 fj1QkdGCOBf/euMT1ySJKygrvYj2Y9BeKZo2wT1K5KoJXPcJg/5vltfjmSp9owgaB3Fa
 U0RUAu/eSgVs5ph/vCNPQyLnuxYUA2DHWEaYFAOuR2vNJ7MfZIiq8Q23kvIxJlAXKVAu
 vdfEIH/gJTDkRk1Jk+WgHznEUK4W4pYT66mt4dI9bJnHfysLbklfrjPGkb/GyDv8AfqQ
 MKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073602; x=1698678402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=589kWa60rv9ivRuzxruIRObnx4upUw3uc1WngFwaW/E=;
 b=nDPvVBSABWwL3x/gId6XLQgGALP1EigfqRssMCnGbOhnNvEg4NOE8drPx9PWVY77zT
 1ihZljbkibLqn7R9bY+1rhw0xIuSPWIBqpOVNo5Ry7kYcuLZKM/tAjY8OVD3rJF537bT
 N+J64ESMIwqKD8M0qWqjpdUGveu2H96N8P3CEcVivsXxOqnfG8WhO2/L5ZrKIWobJ/NC
 LLn7zo+oRQbm1GkyE8mK4jZT5DLJInLf50Oljk8ik8tTnIDTGd0tHIqaM6R23aS8L6t9
 kt34hB6b5IqW0jg+clZ0qGO//8+WyzMkBBSgEUi7vqV7QdkyKSPDxDXxbO6Z6v8qVcuE
 Q8sg==
X-Gm-Message-State: AOJu0Yxfm/yz/PQtOeVxoh9hTOwEBdJ71FhMyzddnf5O/NQe7kgI5TEC
 +rut4IfINbcWMKQTbDvsdyYaYg702HQGWVIQuId5Pg==
X-Google-Smtp-Source: AGHT+IFNQ1m7HKnCw0yCQBHmA1Fz716XV9sZnDMUA943cr0wW2g8X1fgF2y2e5lLHjl99/hK91pYr2xUGbE6zum5o+0=
X-Received: by 2002:a05:6358:cd04:b0:168:d0a3:202f with SMTP id
 gv4-20020a056358cd0400b00168d0a3202fmr5784477rwb.15.1698073601496; Mon, 23
 Oct 2023 08:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZTDGfppgSnpKjaYz@infradead.org>
In-Reply-To: <ZTDGfppgSnpKjaYz@infradead.org>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 23 Oct 2023 11:06:32 -0400
Message-ID: <CADx9qWgP=h4kQEJ2Cpy-A9hyiKLdkF3hVZVydLrz2Lk+UGBaAQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
 "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/2la-VDz8UhgR8G5QyO-5LVjPyh8>
Subject: Re: [Bpf] ISA RFC compliance question
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

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMjowNOKAr0FNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4KPiBPbiBGcmksIFNlcCAyOSwgMjAyMyBhdCAwODoxNDox
MlBNICswMDAwLCBEYXZlIFRoYWxlciB3cm90ZToKPiA+IE5vdyB0aGF0IHdlIGhhdmUgc29tZSBu
ZXcgInY0IiBpbnN0cnVjdGlvbnMsIGl0IHNlZW1zIGEgZ29vZCB0aW1lIHRvIGFzayBhYm91dAo+
ID4gd2hhdCBpdCBtZWFucyB0byBzdXBwb3J0IChvciBjb21wbHkgd2l0aCkgdGhlIElTQSBSRkMg
b25jZSBwdWJsaXNoZWQuICBEb2VzCj4gPiBpdCBtZWFuIHRoYXQgYSB2ZXJpZmllci9kaXNhc3Nl
bWJsZXIvSklUIGNvbXBpbGVyL2V0Yy4gTVVTVCBzdXBwb3J0ICphbGwqIHRoZQo+ID4gbm9uLWRl
cHJlY2F0ZWQgaW5zdHJ1Y3Rpb25zIGluIHRoZSBkb2N1bWVudD8gICBUaGF0IGlzIGFueSBydW50
aW1lIG9yIHRvb2wgdGhhdAo+ID4gZG9lc24ndCBzdXBwb3J0IHRoZSBuZXcgaW5zdHJ1Y3Rpb25z
IGlzIGNvbnNpZGVyZWQgbm9uLWNvbXBsaWFudCB3aXRoIHRoZSBCUEYgSVNBPwo+Cj4gVW5sZXNz
IHdlIGNsZWFybHkgZGVzaWduYXRlIG9wdGlvbmFsIGV4dGVuc2lvbnMgdGhhdCB0aGF0IGNhbiBj
bGVhcmx5Cj4gYmUgbWFya2VkIHN1cHBvcnRlZCBvciBub3Qgc3VwcG9ydGVkIHRoYXQgaXMgdGhl
IG9ubHkgd2F5IHRvIGdldAo+IGludGVyb3BlcmFiaWxpdHkuCj4KCkNhbiB3ZSBsb29rIHRvIGVp
dGhlciBSSVNDLVYgb3IgQVJNIGZvciBwcmlvciBhcnQgaW4gaG93IHRoZXkgd29ya2VkCmRpZmZl
cmVudCB2ZXJzaW9ucyBhbmQgY29tcGxpYW5jZSBsZXZlbHM/IEkgYW0gaGFwcHkgdG8gYW1hc3Mg
c29tZQpkb2N1bWVudGF0aW9uIGFib3V0IHRoZWlyIHByb2Nlc3Nlcy9wcm9jZWR1cmVzIGlmIHlv
dSB0aGluayB0aGF0IGl0CndvdWxkIGhlbHAhCgpXaWxsCgoKPiAtLQo+IEJwZiBtYWlsaW5nIGxp
c3QKPiBCcGZAaWV0Zi5vcmcKPiBodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2JwZgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYu
b3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

