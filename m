Return-Path: <bpf+bounces-59368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29A4AC9539
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74679A805F2
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA2827703E;
	Fri, 30 May 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saRCg2bT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2974276022
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627438; cv=none; b=qfZoqUv/vpf5JFAJlfBmhTddhCbVf9wp/9wON6rMX/jSOlLG/xoy/khvEh0LGy7nMMdHq+JQOZog/BCQR6N+7EHFMqsKWN6iT0MN1a0PcO6/R/D/QE6xaJCvO44wI/03rIi2psNWhPlKklmqxEw5SFB/9IQ+gpVI7hx359yZ5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627438; c=relaxed/simple;
	bh=ZpyN4/g0fIVhnbT8d1gKlwHIPtIdzBgiCO0etih4F9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOyCRqK4Uj8aVkdlANg83sPagTGdjANNY2E614SFZE3qeBVhxMsjPmxpnkbfveD8VVNb4phLq6xPAcsuBHsgOR3MyRROUsov7WnIHNLNLGMMA5goCNNXA0NaAn5SzSasS80/jcxs/vtlijlalmxsHnm8fK/Tum9s1n/jBSq/DQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saRCg2bT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2349068ebc7so19785ad.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748627436; x=1749232236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZxelI4d4NvZ/TF/J+tAC98NjF7+jArlYHEM3kySd7Y=;
        b=saRCg2bTJPbra+aNMFsPyKAbAZlqc8IdH/0Ku2IoHdPOUzLWf7PwI6kcvT0KvGBcQv
         YCwmBj2b8KBBgL3Etw97zdUUnbAm+yUdQfngtlQTvR9evGmleuYl7911bIjZi1e2QbfR
         mRWu90UgdcDAN8CD64cXCVWcyoThVdqgcLPlnU8E0m4k7a9US9/3mBAfkaohQwIwWk2s
         urCtb/k1cZtfmNwNnXloR7U0oaxIaH3NBSY7n1C0CkCwzhZY65wZb2i29kNWMKij6B9Q
         KhHkHebGOgUWsJ/9zUmbfOIG9jdwSjyqaesv6HOhiHT2w/v9K5s/H8pN+14Yu3O7Wly1
         D+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627436; x=1749232236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZxelI4d4NvZ/TF/J+tAC98NjF7+jArlYHEM3kySd7Y=;
        b=QKgkCZpNfvrvpbFcmfXJIsUM8uw0Ja+giNtXJmEm1gIasgVkvapTBFBr2Akws4xFno
         Eis0nzc2kZ7NM5edgVAteruvpQxK3OEVyHXCS/Y6RkGtnFlousueBQd3iz8IcKLBeDR+
         2zYPZEh1izx6EKidAHUwaC8iiz3CfyjLYZ/7x1yyAC8+Bcx71YZYdg7unySj1ekYpOQh
         JnyYyh+JmPGWyFxQ0ZJE8keuMLlULhOxBcXeP037Zm0a3830sKNy1bax4BEC+kqzd+af
         TMWI+hlkEFw/n3TbYtfaWunQBjv4PX05mUt6Vb8Nfwf9BqTXnaLibTuXsKgWpB4GG7oa
         pEzw==
X-Forwarded-Encrypted: i=1; AJvYcCWI7sa3lt3i4vTfgJ0dUk6Dnw4vw/Cp5vEaYc4MKgRSrPa/Xjxydqp7iN9JkWqn4NA/yUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzolT8vaGslutTab+WOT7MDSG0UfQF/NnVBOOgzk8TJ4TOA4yt+
	3qHOF7iWg6qInwrrb1V9cRd2ICHwmg9JSzv1h6V5KAgBnhfAtiO/i/IFcUP038/PcZWBEJk/o1x
	ak3oCjjXN0ixXVlYNaFWowbs+fRop9DJL9fehlKWp
X-Gm-Gg: ASbGncswdbhyfoWYLh7sfiEpbZM4QDuNjYBZi2mMVG4yCLfth0c0DYBJcBryGxoq9yh
	5L1DyW0VFmD5kmTQi4k9D4Q9Xi+zoKJo0buEUVUop7BymVb+x6vPWls0o9cNYTqpJ2WE/ZGyXaX
	JM9RPOB3TV4k/xw6YiWZpK0orL8nL/EwX/CW3uJa+TX0gb04j/VnCSHAbf90cGadWaoRiVWB0SC
	w==
X-Google-Smtp-Source: AGHT+IF/dpJ3V6p0xr1UkmFfbIzfoRNakFfjWEsSzdnU9K0wExcotWGzZLbWs+c4kGKxup4uLNw2Dwpv5BnHj6UuyNs=
X-Received: by 2002:a17:902:ecd2:b0:231:eedd:de3a with SMTP id
 d9443c01a7336-2353220f83emr3003775ad.25.1748627435241; Fri, 30 May 2025
 10:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529031047.7587-1-byungchul@sk.com> <20250529031047.7587-2-byungchul@sk.com>
 <CAHS8izNBjkMLbQsP++0r+fbkW2q7gGOdrbmE7gH-=jQUMCgJ1g@mail.gmail.com> <20250530011002.GA3093@system.software.com>
In-Reply-To: <20250530011002.GA3093@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 30 May 2025 10:50:22 -0700
X-Gm-Features: AX0GCFvslPZ_UC7JzYeAi_Zy_ofVmEwzK1hvI1l778wh4YYuE9pFk1RpuJvt08A
Message-ID: <CAHS8izNPSHR7B24Y3RZiBeZHkPyzKAKdZbQgXwqwgs01HzxDTw@mail.gmail.com>
Subject: Re: [RFC v3 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
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

On Thu, May 29, 2025 at 6:10=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Thu, May 29, 2025 at 09:31:40AM -0700, Mina Almasry wrote:
> > On Wed, May 28, 2025 at 8:11=E2=80=AFPM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >  struct net_iov {
> > > -       enum net_iov_type type;
> > > -       unsigned long pp_magic;
> > > -       struct page_pool *pp;
> > > -       struct net_iov_area *owner;
> > > -       unsigned long dma_addr;
> > > -       atomic_long_t pp_ref_count;
> > > +       union {
> > > +               struct netmem_desc desc;
> > > +
> > > +               /* XXX: The following part should be removed once all
> > > +                * the references to them are converted so as to be
> > > +                * accessed via netmem_desc e.g. niov->desc.pp instea=
d
> > > +                * of niov->pp.
> > > +                *
> > > +                * Plus, once struct netmem_desc has it own instance
> > > +                * from slab, network's fields of the following can b=
e
> > > +                * moved out of struct netmem_desc like:
> > > +                *
> > > +                *    struct net_iov {
> > > +                *       struct netmem_desc desc;
> > > +                *       struct net_iov_area *owner;
> > > +                *       ...
> > > +                *    };
> > > +                */
> >
> > We do not need to wait until netmem_desc has its own instance from
> > slab to move the net_iov-specific fields out of netmem_desc. We can do
> > that now, because there are no size restrictions on net_iov.
>
> Got it.  Thanks for explanation.
>
> > So, I recommend change this to:
> >
> > struct net_iov {
> >   /* Union for anonymous aliasing: */
> >   union {
> >     struct netmem_desc desc;
> >     struct {
> >        unsigned long _flags;
> >        unsigned long pp_magic;
> >        struct page_pool *pp;
> >        unsigned long _pp_mapping_pad;
> >        unsigned long dma_addr;
> >        atomic_long_t pp_ref_count;
> >     };
> >     struct net_iov_area *owner;
> >     enum net_iov_type type;
> > };
>
> Do you mean?
>
>   struct net_iov {
>     /* Union for anonymous aliasing: */
>     union {
>       struct netmem_desc desc;
>       struct {
>          unsigned long _flags;
>          unsigned long pp_magic;
>          struct page_pool *pp;
>          unsigned long _pp_mapping_pad;
>          unsigned long dma_addr;
>          atomic_long_t pp_ref_count;
>       };
>     };
>     struct net_iov_area *owner;
>     enum net_iov_type type;
>   };
>
> Right?  If so, I will.
>

Yes, sounds good.

Also, maybe having a union with the same fields for anonymous aliasing
can be error prone if someone updates netmem_desc and forgets to
update the mirror in struct net_iov. If you can think of a way to deal
with that, great, if not lets maybe put a comment on top of struct
netmem_desc:

/* Do not update the fields in netmem_desc without also updating the
anonymous aliasing union in struct net_iov */.

Or something like that.

--=20
Thanks,
Mina

