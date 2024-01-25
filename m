Return-Path: <bpf+bounces-20291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B983B760
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FE01F23994
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15796127;
	Thu, 25 Jan 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wo3ZKDsK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wo3ZKDsK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxOhgXCb"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64B566A
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151094; cv=none; b=Mol/psLkp3wGHbtfisMp8A3MYK7hNhF6mWnGBY8KAtuIBHcz6K5MeLp31qm4AvS6nO4iLwA5uR4A++kHkp55HsAvl66f6GCjGvXoOYwy5MKbZcAji14PmF+doYMfJ8xIc56J0fWdl1D5rM/J14goae0aS3wG8dKWUHFA5PiTvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151094; c=relaxed/simple;
	bh=4Stp0nJTEzvexXn6zF/VXscWHdf+39fRPF5CoX/xmDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=IGxFYJBdI0OR8d65rsMVqaLHv016ICb+SP3IePW7ug/kRDOsbQEBtWDinXiRoP/v4H6Q/VdGfD9P+l/PVCw6ClxjlWjX+ANn3YH0FVH6Z6Q5ZeydjyqhkrOZakE+7O2TpfqXiaz6feIdiw7CD8lyHE+i90bqkLAUwY9Vwtf0yx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=wo3ZKDsK; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=wo3ZKDsK; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxOhgXCb reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B8201C1516EB
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706151091; bh=4Stp0nJTEzvexXn6zF/VXscWHdf+39fRPF5CoX/xmDc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=wo3ZKDsK9ZS4/qVH+fIGzglhovyu5wewQ6s0EAC+5X2komnCXQglZI67H4iuHg3sJ
	 n1/IJ6c2J8YRVbms4Hn8rgYXRuIM4jY2gqk7vN8f4vlLeDwi2r/oeMUxuvc2EznQvv
	 z4bqsLY7zDD1dO5F/9mRN0dA+keHmOuiapAaTc7w=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Jan 24 18:51:31 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 89B84C14F71B;
	Wed, 24 Jan 2024 18:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706151091; bh=4Stp0nJTEzvexXn6zF/VXscWHdf+39fRPF5CoX/xmDc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=wo3ZKDsK9ZS4/qVH+fIGzglhovyu5wewQ6s0EAC+5X2komnCXQglZI67H4iuHg3sJ
	 n1/IJ6c2J8YRVbms4Hn8rgYXRuIM4jY2gqk7vN8f4vlLeDwi2r/oeMUxuvc2EznQvv
	 z4bqsLY7zDD1dO5F/9mRN0dA+keHmOuiapAaTc7w=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 8BC2BC14F710
 for <bpf@ietfa.amsl.com>; Wed, 24 Jan 2024 18:51:30 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e98ovb7eMZOG for <bpf@ietfa.amsl.com>;
 Wed, 24 Jan 2024 18:51:29 -0800 (PST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EC240C14F6F3
 for <bpf@ietf.org>; Wed, 24 Jan 2024 18:51:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so1238746f8f.2
 for <bpf@ietf.org>; Wed, 24 Jan 2024 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706151088; x=1706755888; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brWuhPv08m5IHqo2Fx2aVHV5rCfwWbI9NZG9MaN0KwU=;
 b=YxOhgXCbvASBtV0ObvMVJPKDkE0K85oa/mxCg0iSN9eVav9UT+A10eAHq/uoo7uK0p
 01Z1PQMzjLrskgyoTB8EHZXEJ1j1iIC5sIM9LO0HrL08Ap6aZMXahzQEW0J7xcX1TF4U
 hcs82M+n096mimlr3M5G4x340yYHQiUpwU+0xhTW99WUToR2TirVSwb/ej+5ICe2hcuZ
 2mfvQ9k3rW6mv8Jb5xM19bP1UmJO6y3Hj7udLHvzM5jBI/i5W+UYCRYbmA//OaMnBWtM
 pGgId/10Ga0b8skH3pssccfOu7a8IPHbO4tG2Wx6SfCUgEkGsBmx+RKhTjTHbjjbPDFs
 ULdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706151088; x=1706755888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brWuhPv08m5IHqo2Fx2aVHV5rCfwWbI9NZG9MaN0KwU=;
 b=namYuZtJsF6CSOcjDhViubUDjVQ2srTs3Axho6Tgv6FSqlEYuiYyjEbuFEnmMExyRK
 lXwmQKBzQh/cEjf40jawX7a7DqahzxZ5rO6u5EHrbA9ibsfVGcE0I5l1vlYKWEpBmXMp
 s/gF7xJl7i9ueqHtwOS0zVnLgKhulr/58K41tw5ogjahb23/kLW2MSZG0sIMbwqgg9Dn
 xdM5Blga9LY1IJqej+Q5Y+3ZYAfxY+qQgfFhMGzgY4+yvx6TLgXnAhGHYnsgU3Q4fKoT
 QwWQZqL+RKI8SmtvbiX1BuhRSyNAONoYENjPzqAKC3sO9R+GS+9qmKGjCFuSCY3yR72b
 WejA==
X-Gm-Message-State: AOJu0Yz0i/ak0N1Di1mmx+vnZ5y6NKgOapJ85WvfsiW2F1jFJCILleF0
 V5ZDTA0O7aYMIdcL/jBpwvcroFVGDd2wyUqoYkO16zLrV7J/HYcHR+zO0IwjXwe66c2zEGU9HEq
 sJ3jJtHgF8FPGlFLHVHeU/8sCQPQ=
X-Google-Smtp-Source: AGHT+IF4VAHiiFinwZ6qaHTmt83F1jaKQA1bfTfDoTM/+zm9H1I/M2FBjrQ5st+f4+BQZl7+SsJ0C8QCgzuOh8UaIPQ=
X-Received: by 2002:adf:f549:0:b0:337:2994:15b1 with SMTP id
 j9-20020adff549000000b00337299415b1mr106934wrp.135.1706151087602; Wed, 24 Jan
 2024 18:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
 <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com>
 <20240123215214.GC221862@maniforge>
In-Reply-To: <20240123215214.GC221862@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 18:51:16 -0800
Message-ID: <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org,
 bpf <bpf@vger.kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/xADKxwwkAL2354spnAqY7muCdI8>
Subject: Re: [Bpf] Standardizing BPF assembly language?
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMTo1MuKAr1BNIERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPiB3cm90ZToKPiA+ID4gPiBBIHNlY29uZCBxdWVzdGlvbiB3b3VsZCBiZSwgd2hp
Y2ggZGlhbGVjdChzKSB0byBzdGFuZGFyZGl6ZS4gIEpvc2Uncwo+ID4gPiA+IGxpbmsgYWJvdmUg
YXJndWVzIHRoYXQgdGhlIHNlY29uZCBkaWFsZWN0IHNob3VsZCBiZSB0aGUgb25lCj4gPiA+ID4g
c3RhbmRhcmRpemVkICh0b29scyBhcmUgZnJlZSB0byBzdXBwb3J0IG11bHRpcGxlIGRpYWxlY3Rz
IGZvcgo+ID4gPiA+IGJhY2t3YXJkcyBjb21wYXQgaWYgdGhleSB3YW50KS4gIFNlZSB0aGUgbGlu
ayBmb3IgcmF0aW9uYWxlLgo+ID4gPgo+ID4gPiBNeSByZWNvbGxlY3Rpb24gd2FzIHRoYXQgdGhl
IG91dGNvbWUgb2YgdGhhdCBkaXNjdXNzaW9uIGlzIHRoYXQgd2Ugd2VyZQo+ID4gZ29pbmcKPiA+
ID4gdG8gY29udGludWUgdG8gc3VwcG9ydCBib3RoLiBJZiB3ZSB3YW50ZWQgdG8gc3RhbmRhcmRp
emUsIEkgaGF2ZSBhIGhhcmQKPiA+IHRpbWUKPiA+ID4gc2VlaW5nIGFueSBvdGhlciB3YXkgb3Ro
ZXIgdGhhbiB0byBzdGFuZGFyZGl6ZSBib3RoIGRpYWxlY3RzIHVubGVzcwo+ID4gdGhlcmUncwo+
ID4gPiBiZWVuIGEgc2lnbmlmaWNhbnQgY2hhbmdlIGluIHNlbnRpbWVudCBzaW5jZSBMU0ZNTS4K
PiA+Cj4gPiBJZiAic3RhbmRhcmRpemUgYm90aCIsIGRvZXMgdGhhdCBtZWFuIG5laXRoZXIgaXMg
bWFuZGF0b3J5IGFuZCBlYWNoIHRvb2wKPiA+IGlzIGZyZWUgdG8gcGljayBvbmUgb3IgdGhlIG90
aGVyPyAgQW5kIHdvdWxkIHRoZSBJQU5BIHJlZ2lzdHJ5IHJlcXVpcmUgYQo+ID4gZG9jdW1lbnQK
PiA+IGFkZGluZyBhbnkgbmV3IGluc3RydWN0aW9ucyB0byBzcGVjaWZ5IHRoZSBhc3NlbWJseSBp
biBib3RoIGRpYWxlY3RzPwo+Cj4gV2VsbCwgaWYgd2UncmUgc3RhbmRhcmRpemluZyBvbiBib3Ro
LCB0aGVuIHllcyBJIHRoaW5rIGl0IHdvdWxkIGJlCj4gbWFuZGF0b3J5IGZvciBhIHRvb2wgdG8g
c3VwcG9ydCBib3RoLCBhbmQgSSB0aGluayBpbnN0cnVjdGlvbnMgd291bGQKPiByZXF1aXJlIGFz
c2VtYmx5IGZvciBib3RoIGRpYWxlY3RzLgoKSSB0aGluayBpdCdzIG9idmlvdXMgdGhhdCB0aGVy
ZSBpcyBubyB3YXkgd2Ugd2lsbCBhZGQgZ2NjJ3MgZmxhdm9yCm9mIGFzbSB0byBrZXJuZWwgYW5k
IGxsdm0uCgo+IFByYWN0aWNhbGx5IHNwZWFraW5nIHRoYXQncyBhbHJlYWR5Cj4gd2hhdCdzIGhh
cHBlbmluZywgbm8/IEJvdGggZGlhbGVjdHMgYXJlIGFscmVhZHkgcGVydmFzaXZlLAoKVGhleSBh
cmUgbm90LiBUaGVyZSBhcmUgdGhvdXNhbmRzIG9mIGxpbmVzIG9mIGFzbSB3cml0dGVuIGluIHBz
ZXVkby1jCnVzZWQgaW4gcHJvZHVjdGlvbiBhcHBsaWNhdGlvbnMgYW5kIHByb2JhYmx5IG9ubHkg
dWJwZi90ZXN0cyBhbmQgZ2NjL3Rlc3RzCmluIHRoYXQgb3RoZXIgYXNtLCBzaW5jZSBnY2MgYnBm
IHN1cHBvcnQgaXMgbm90IHlldCBpbiB0aGUgcmVsZWFzZWQgZ2NjIHZlcnNpb24uCgpUaGVyZSBp
cyBhbHNvIHRoaXMgYXNtIGZsYXZvcjoKaHR0cHM6Ly9naXRodWIuY29tL1hpbGlueC1DTlMvZWJw
Zl9hc20KCldoaWNoIGlzIGRpZmZlcmVudCBmcm9tIHBzZXVkby1jIGFuZCB1YnBmIGFzbS4KCkkg
ZG9uJ3QgdGhpbmsgYXNtIHN5bnRheCBzaG91bGQgYmUgYW4gSUVURiBkcmFmdC4KCi0tIApCcGYg
bWFpbGluZyBsaXN0CkJwZkBpZXRmLm9yZwpodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2JwZgo=

