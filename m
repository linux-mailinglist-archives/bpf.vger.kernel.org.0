Return-Path: <bpf+bounces-59193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70983AC7233
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 22:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322804A274D
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 20:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EBF221725;
	Wed, 28 May 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hb1th95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BB220694
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748464168; cv=none; b=UlS/2/Ip2JkFcV5+46MkjhX1Vw8p2SqXZzQZWQIBB5vypS1nn7xJRXwoWmCvIudf/PrzyIvJ8eXS9cn27xbUXRr9b3voRyVn/cxJb8pejZX+hp3tiDZVrfbDK/Wo38YIlUd6+lJgLVA9R+uMsP1jeKei/sSNeEAyxnMfBqRmTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748464168; c=relaxed/simple;
	bh=WL3JbFFeB8hz9dp4apUh9xBal5aOrNBvFds8l+hj0cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQaBxZZwnFSKh6VjjMS34YRR4bVlQDjlvshYjd48Z/rzubNyAPlihHA2AlWTObCEgty4zT47n/JbbCFLb9bbzyrQPDRcrXrg1hdvJmFlGPXRTfdhKd+ctq5YxIkuQbVfr0zAxZ7pgLY03rtqAclInIp17wQ/x8HxBXmkgOo9KsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hb1th95; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2348a45fc73so48325ad.0
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748464165; x=1749068965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtuCwhZW/OpdzghCypJVgYdX1gC23Z08ZYJNUJxLNwY=;
        b=3hb1th95TTdKuGI1fBAtfJwujPFLw6hQtPYB98Nt73eFhsA1SekT4piFCJ53TSG9pA
         hMwV2hbX2VdCB3DLvthVTckwR39otOzZgfivCnyF+RZVWiC/d1B+bj3TT1KOoftqfiDM
         mPLn69ruhiZHKX5h+Mw+UJEe0UgapRCBqwlUQPitsAxRrjbGjisw/9V9UydAHXtivuaz
         B2uAPz66vLxtmLkH9gjwQutRCUeGUy5HvrDxT+zkYoqMTyst4xy9vvRd0NWLCfCllcrk
         fLjtU/hmpzoDPeH9/IZ1rThnzqAhoJ53Y1r9ugyncZGFA52C4GJCl739m+p4CzVQcuTl
         RRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748464165; x=1749068965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtuCwhZW/OpdzghCypJVgYdX1gC23Z08ZYJNUJxLNwY=;
        b=VYEiOjCkIDLkbT4sHOHZHxHrMaS3epiqwthlgkHcYZLoWWcqXL1b0rKiOed+O64WxJ
         ULp/ulLPuihgnD+PLrbiuMYs/Vqf7+ZPaznfZ6KgeogkMzqbWT1VPjVBPgPPlMic4i2S
         RtbpCg3b0e0dKaY027+Oha0iJ6+APNn1nZ20ImRlqV2vJlxIXsgFZ1ZIw0nGmMJrBy9A
         kaO/JC19SYCXXPnHmUh0p0xopTKNfXR7IXchd+prlZ7bYAninAQTiSSdC3pdNPAq4Fyg
         WgJRVglQNhNjfObsRXHsNsAv0h6eQmEBg5mhINNtjiEU5ak22If2JOFRWb+ON3n1s3Rr
         PK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVMrsHqZmGbGWlDuj/BdqJS65ihY7DSjGjgK4Q4ss2SwBy7MTLsEmgc3Ez30278zUoS3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIK0yhlKmW7v5p69f1tVyB87aGICxWe/Se3JiEWqhaqWNbfTFT
	lYf3suYpR52vMagQn3itSjyh8XG6wWeuJEazrFOiqePttVmd6dXYS3ArjZC6EeF4xaEn/DL2C7q
	xxjQig8/unGrZymHh1zvjCYMpd3R2fmMo3DAwyIrE
X-Gm-Gg: ASbGncvxZW/77Z9B9YAZyf6zTOBwTKhTTpnlt+y50hmeAY2KeUNwp0TcnI28TE7797a
	eosXFPkejYTWCCKUuCprq1Z41l0hbIhbLMlPuMarX5d/tKkUme14TLqsqOoELtrTSqt3PX5EZgc
	Wp4hqw/YhZc4onHD+Qls+XbGAx/gJlSVJFsi/Usn6vTYbKxevVD3ArR1RNJaAgPLbYe2tFQKXQa
	A==
X-Google-Smtp-Source: AGHT+IF3olouht4/h+Yom7odAZXWAlWP3Jr74zvGxmzUXYZiqm+ZrYb9dZ0Z6AtwKCQgKYoDWgVpborgGQhXum1PIXo=
X-Received: by 2002:a17:902:f68a:b0:234:bca7:2934 with SMTP id
 d9443c01a7336-234ffe67a1dmr777355ad.6.1748464164902; Wed, 28 May 2025
 13:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528022911.73453-1-byungchul@sk.com> <20250528022911.73453-9-byungchul@sk.com>
 <CAHS8izMmsHa4taaujEbTK5PM+APYsRJzv1LqGESJf2x6BRnxag@mail.gmail.com> <20250528055625.GC9346@system.software.com>
In-Reply-To: <20250528055625.GC9346@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 13:29:12 -0700
X-Gm-Features: AX0GCFtLmYzec5bNXT46FH3Zh7xYXq7-lgq8DUSSH3cP76DeHTPqGOw_dzekarY
Message-ID: <CAHS8izORW+42nFBFas6t9RcOrRVG3KvQ9+3We4u4f1kXFzz=7Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:56=E2=80=AFPM Byungchul Park <byungchul@sk.com> =
wrote:
>
> On Tue, May 27, 2025 at 08:21:32PM -0700, Mina Almasry wrote:
> > On Tue, May 27, 2025 at 7:29=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > Now that __page_pool_release_page_dma() is for releasing netmem, not
> > > struct page, rename it to __page_pool_release_netmem_dma() to reflect
> > > what it does.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  net/core/page_pool.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > > index fb487013ef00..af889671df23 100644
> > > --- a/net/core/page_pool.c
> > > +++ b/net/core/page_pool.c
> > > @@ -674,8 +674,8 @@ void page_pool_clear_pp_info(netmem_ref netmem)
> > >         netmem_set_pp(netmem, NULL);
> > >  }
> > >
> > > -static __always_inline void __page_pool_release_page_dma(struct page=
_pool *pool,
> > > -                                                        netmem_ref n=
etmem)
> > > +static __always_inline void __page_pool_release_netmem_dma(struct pa=
ge_pool *pool,
> > > +                                                          netmem_ref=
 netmem)
> > >  {
> > >         struct page *old, *page =3D netmem_to_page(netmem);
> > >         unsigned long id;
> > > @@ -722,7 +722,7 @@ static void page_pool_return_netmem(struct page_p=
ool *pool, netmem_ref netmem)
> > >         if (static_branch_unlikely(&page_pool_mem_providers) && pool-=
>mp_ops)
> > >                 put =3D pool->mp_ops->release_netmem(pool, netmem);
> > >         else
> > > -               __page_pool_release_page_dma(pool, netmem);
> > > +               __page_pool_release_netmem_dma(pool, netmem);
> > >
> > >         /* This may be the last page returned, releasing the pool, so
> > >          * it is not safe to reference pool afterwards.
> > > @@ -1140,7 +1140,7 @@ static void page_pool_scrub(struct page_pool *p=
ool)
> > >                 }
> > >
> > >                 xa_for_each(&pool->dma_mapped, id, ptr)
> > > -                       __page_pool_release_page_dma(pool, page_to_ne=
tmem(ptr));
> > > +                       __page_pool_release_netmem_dma(pool, page_to_=
netmem((struct page *)ptr));
> >
> > I think this needs to remain page_to_netmem(). This static cast should
>
> Do you mean to ask to revert the casting patch of page_to_netmem()?
>
> Or leave page_to_netmem(ptr) unchanged?
>
> I added the casting '(struct page *)ptr' above to avoid compliler
> warning..  Do you see another warning on it?
>

Ah, sorry, I misread this on the first try. I thought you're
replaceing page_to_netmem with a static cast but you're not. You're
just casting a void * to page*. That should be fine and should indeed
remove warning.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

