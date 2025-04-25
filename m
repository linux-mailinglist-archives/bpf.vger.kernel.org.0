Return-Path: <bpf+bounces-56680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D8A9C05F
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1094A66E9
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B8233704;
	Fri, 25 Apr 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Unv1MIkJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BF233140
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568425; cv=none; b=D5SbtitIxffXByZanD+TzZ1cwRvpEI/h3Pwm1F3Dd9/RUbmO+6cETXqOSORnnoBL3ng4PwrE5ZrYPX1sT3n4j93KPb3tp1iii6wkniQJZrl0xTeJs2Dk7F7tIYSv1mbz7Um3o41pZjCAT5VL/EAND0Im8Uc8CNUxyLJvSXcFZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568425; c=relaxed/simple;
	bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5m+4QDjJg6tdb1U7o3Z0ZcVrbDzzdohB9UgNaNVlzqICHNsk+0NwOe/emBMykWHjKiWBQRqjeP6qVKx1OyVnrlLc+gMxfAGb7PNPQxzxcO0PxvzpSrBKEuTNqPb46s5rYObFDCl8eTn3QqKa7dJ1+icqU1tIa1mVW1dLoVzWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Unv1MIkJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745568421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
	b=Unv1MIkJVr/xCJyAASTeughOIxXgBopEK0gaebTy21lyvAVaDuDuTgEq0GnKOtPXW6YsSr
	j9vfN1EQxxSNkB33WtmAzsp26VAtqrNjcawhFeazc/hVusbC2XlW89QhVd58G278Ogd8k7
	Es1JRu6ilvvH0KEELfgVITwnfBLifk0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-YwwiiDwnN9uQhPPp3GZLww-1; Fri, 25 Apr 2025 04:06:57 -0400
X-MC-Unique: YwwiiDwnN9uQhPPp3GZLww-1
X-Mimecast-MFC-AGG-ID: YwwiiDwnN9uQhPPp3GZLww_1745568416
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5f620c5f8e4so1914758a12.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 01:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568416; x=1746173216;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0vEA9hITINUFq21qN7+MPFAG54LSqVcGMT6tYWPCMc=;
        b=RIrQYG/vDTLIWlsOGNUTRSa33VGIMITlrBe7zrcyCTFJ323LfoHUDdQz5Og7Nfsrw4
         0dDNjK/EXEJGeghBrI57i2azH8JHkzLWD3ul9qFJKQ0bYDAuikjVBjJdTe0pRymQWg23
         z4CUyGuGWIskzsihf4QSu3D2YUp6g90oCIIcYnRF7DSczcEx3thB7Eex5id1tx2/616f
         xWoYnJt4GjTYxBqnfxlarPHUvBYwzynn5b7rMSK04KZQYSlL404arhd75Btyh+DoTalx
         VMnIWrtzzjzOtIUpaI+hK/tD/5KQ5pO0HD7C8SEMO9hGrHqK/WTyJkrgKtfTPkPQ2BNL
         I1bw==
X-Forwarded-Encrypted: i=1; AJvYcCXh5cujDA6gaOIywnQuoQuMiH/Qbzov7UDZ7u8q/AGYkvV9/E1qTOcw5kh5xVcAQtoGoog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJ4JzpkL67i87G8b0yC9b4NxTNnOno1FLRVsDCpbkN1J1z5QU
	6Xr35KF3l7LPPCwCO1zbSby3e0f/LlwFimqZd2q3xo0/PKcVH/aahYUaABbZrh4kKM6YGX2uLKS
	HKv0CF82wP99zYCh4IR3h23P303pqk+psPofbiHDDMtOyRy/pgQ==
X-Gm-Gg: ASbGncviopQdtZCqStypInWrReCw+u2FRRnkJZ0496mn4PlCziBDJeYjImlrGWc9Oai
	DGXSLrt+XlDBVrggNG0DluIVJM4cGqlM/CkxF5yjeWDW6MWAcjM7UJLz5sB9Ku2zZdrMBUL+vs8
	/wxrHKiEh/pMXAD8L4ufoZ6HOKROO8+RtPlA/Ms7g1+CEsc/H9ll1U/3vqr9vQe3TXNsSOVFm8K
	sWJhvPu02C3ZvCuNqWIfkvG1B00nbds2EN7YoW8I5TiNfeGhCNIeAXpjSTo4ghmGkfcEEamOdpx
	Abc5r2pKqjzo53cwQTfwP4YBYpOLyeyoQiCm
X-Received: by 2002:a05:6402:34c2:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f723a14ffdmr958910a12.31.1745568415833;
        Fri, 25 Apr 2025 01:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHICv/JNk8k7fYInMalFni/XTF4Yka/+A4hIJuXaq1ow5LsmSgtSTJXUqpu3AXRwYa4aMT2jA==
X-Received: by 2002:a05:6402:34c2:b0:5ec:cd52:27c9 with SMTP id 4fb4d7f45d1cf-5f723a14ffdmr958886a12.31.1745568415400;
        Fri, 25 Apr 2025 01:06:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7038340f5sm879917a12.78.2025.04.25.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:06:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AD6661A037D9; Fri, 25 Apr 2025 10:06:52 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Stanislav Fomichev
 <stfomichev@gmail.com>
Cc: Arthur Fabre <arthur@arthurfabre.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, hawk@kernel.org, yan@cloudflare.com,
 jbrandeburg@cloudflare.com, lbiancon@redhat.com, ast@kernel.org,
 kuba@kernel.org, edumazet@google.com, kernel-team@cloudflare.com
Subject: Re: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
In-Reply-To: <87msc5e68a.fsf@cloudflare.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
 <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
 <aAkW--LAm5L2oNNn@mini-arch> <D9EBFOPVB4WH.1MCWD4B4VGXGO@arthurfabre.com>
 <aAl7lz88_8QohyxK@mini-arch> <87tt6d7utp.fsf@toke.dk>
 <aApbI4utFB3riv4i@mini-arch> <87msc5e68a.fsf@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 25 Apr 2025 10:06:52 +0200
Message-ID: <87cyd07jhf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki <jakub@cloudflare.com> writes:

> On Thu, Apr 24, 2025 at 08:39 AM -07, Stanislav Fomichev wrote:
>> On 04/24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> [...]
>
>>> Being able to change the placement (and format) of the data store is the
>>> reason why we should absolutely *not* expose the internal trait storage
>>> to AF_XDP. Once we do that, we effectively make the whole thing UAPI.
>>> The trait get/set API very deliberately does not expose any details
>>> about the underlying storage for exactly this reason :)
>>
>> I was under the impression that we want to eventually expose trait
>> blobs to the userspace via getsockopt (or some other similar means),
>> is it not the case? How is userspace supposed to consume it?
>
> Yes, we definitely want to consume and produce traits from userspace.
>
> Before last Netdev [1], our plan was for the socket glue layer to
> convert between the in-kernel format and a TLV-based stable format for
> uAPI.
>
> But then Alexei suggested something that did not occur to us. The traits
> format can be something that BPF and userspace agree on. The kernel just
> passes it back and forth without needing to understand the content. This
> naturally simplifies changes in the socket glue layer.
>
> As Eric pointed out, this is similar to exposing raw TCP SYN headers via
> getsockopt(TCP_SAVED_SYN). BPF can set a custom TCP option, and
> userspace can consume it.
>
> The trade-off is that then the traits can only be used in parts of the
> network stack where a BPF hook exist.

It also means that we can't change the format later because it becomes
an API consumed by userspace. Regardless of whether we deem it "UAPI"
and not, it is bound to ossify. TCP headers are actually an excellent
example of this; they are ostensibly modifiable, but it's all but
impossible to do so in practice, because implementations make
assumptions on the expected format and break if it changes.

Also, making the format "agreed upon between BPF and userspace", means
that the kernel won't be able to use the data stored in traits itself
(since it does not know the format). We do want fields stored in traits
to be consumable by the kernel as well, so for this reason it is not a
good idea to leave it up to BPF to define the format either.

> Is that an acceptable limitation? That's what we're hoping to hear your
> thoughts on.

I absolutely don't think this is acceptable, see above.

> One concern that comes to mind, since the network stack is unaware of
> traits contents, we will be limited to simple merge strategies (like
> "drop all" or "keep first") in the GRO layer.

Yeah, this is another limitation of the kernel not understanding the
format, but not the only one.

-Toke


