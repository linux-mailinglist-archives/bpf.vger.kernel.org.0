Return-Path: <bpf+bounces-27102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5E8A90F7
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 04:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640311F21AAA
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3264084E;
	Thu, 18 Apr 2024 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaQXswJS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074163A1B6
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405930; cv=none; b=q+jrOwyb3gXF5cnjAYh8j+WxlEI7mQTfQRS3Jym11dGCJoKGdJhQEF4525dC3jK1qGI18hERwG2HiWiCBhCYoKIXTHpPoh5cIdnYk80t0skxEnrwMAveOCfJBPp6jo9d0n14jjwL1UUj6fGB6twG1cyQzktzJ8nuTybe84zEOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405930; c=relaxed/simple;
	bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB1GoSJKraM3+uoPbTf0Jml3jqWd3Ae/nXj7g3h/aY6q1RWvvR1DRBxdnO9uEUO/7+/Zquh2PiWo4s2DPR2T30TLr6LZ+bLc0desCRN2X6XoZUBzdKGhvnQlWfGtppj9NqJRjksEyNbzyIjQ5VpfaoBtWX7TotYyWGFF8n0+8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaQXswJS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db13ca0363so6060471fa.3
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713405927; x=1714010727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
        b=iaQXswJSwbd6W25fe4Gm0Pjcaxlny+oZVrwFZ5yeQDqUCqctGQ0oJzeErLjcaqSVjQ
         c5rROx3N5EHWyGn7GYvncjhJ2MW+mzH4mfu0FnHyvfU/krB54BJpgMR7zL7aXg3gHt1h
         Cix3sRYVObXpzTpratyv/GQAbufq/aQo47i5wFdquZDGtwXA1bRzIChHOiU9gnz9YgWO
         pVtgb4K/M67JhK2l5S2DYN/nP1WKudwWA/AFyov3uh9pQgyGoFU2m8gEh9/1UdgACd/e
         /VoLNfpm6mfQJYZ3SJRs1JomoDjYLJ055rtMehVwPTfjEW5/Vs2/KqpkVDlMUOR2Prfc
         BuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405927; x=1714010727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0QnjAhdYrmACiuwAPDxnR5HIy4p9penGkBMygu+5uU=;
        b=gFunJxZ13fLDD8n0Z/4oTac+v3kzQRIMOF7X5o35TVLEaMrC/rdi9YjZCUNebhXhUK
         wucZWEby0y9o3a6QG78xB2fTBjw5o7vBjRv0as7voLAWUpzrHB9fa4kHTdyMtbyKcBnD
         7EFn6MGJ/Vimxc6FO9/cuF09smiAo+oH6X5SzStIbgzevSutc32l5WOs3JO4rOjw15/f
         S5qlANuNuYvIDLo2sPGpLqJXbWmEH9YZ2S7T4Z550UjUerAndm0GCMF8tIIIuX9RPAFT
         8jgDq5lVMQ0f4mY1nr5UJIOHvAK9oC31o1Ci3D/XwQZfG75Vj6dGaCcLqEZiG7Qilsr0
         +cTw==
X-Forwarded-Encrypted: i=1; AJvYcCUB2i/ly4V79FZMQqQhYgW5RsfXA+2OhWOiljXGmNz1JEAzbPA8+RcC6vpAWEwhViycwSsWl+q/RZvkZv9/BafGdu7k
X-Gm-Message-State: AOJu0YyBaftgeYLhikdr6FkzOYMmCWAezQlFbtE5CZoqM9m8HsMVj1k9
	Kmzzd5AktQgIoRn9g6MLP9DXqkWmRMgdDOvdZkprPC7iK2KuxMjk3m6NouRiWCFYdVh/bKGsvmi
	cf7lxeCF0AYvwrkquXWezxfG6ZKEqAlU7Mrc8
X-Google-Smtp-Source: AGHT+IFCm3pN2ShD28Z+g4gvIKer7DIONCtgHex5oajrniOoI2un8C3zrZeQwrRhrc0hLYs0bHNGtT9KLILyXzzacvw=
X-Received: by 2002:a2e:9003:0:b0:2d8:bda5:c5f5 with SMTP id
 h3-20020a2e9003000000b002d8bda5c5f5mr644366ljg.35.1713405927096; Wed, 17 Apr
 2024 19:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org> <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
 <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
 <4fd9106c-40a6-415a-9409-c346d7ab91ce@redhat.com> <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
 <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
 <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org> <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
 <9f6333ec-f28c-4a91-b7b9-07a028d92225@kernel.org> <f6daabzdesdwo7zdouexow5mdub3qnzr7e67lonmhh3itjgk5j@qw3xpvqoyb7j>
In-Reply-To: <f6daabzdesdwo7zdouexow5mdub3qnzr7e67lonmhh3itjgk5j@qw3xpvqoyb7j>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Apr 2024 19:04:50 -0700
Message-ID: <CAJD7tkYnSRwJTpXxSnGgo-i3-OdD7cdT-e3_S_yf7dSknPoRKw@mail.gmail.com>
Subject: Re: Advice on cgroup rstat lock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Waiman Long <longman@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jesper Dangaard Brouer <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeelb@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

[..]

> > > I personally don't like mem_cgroup_flush_stats_ratelimited() very
> > > much, because it is time-based (unlike memcg_vmstats_needs_flush()),
> > > and a lot of changes can happen in a very short amount of time.
> > > However, it seems like for some workloads it's a necessary evil :/
> > >
>
> Other than obj_cgroup_may_zswap(), there is no other place which really
> need very very accurate stats. IMO we should actually make ratelimited
> version the default one for all the places. Stats will always be out of
> sync for some time window even with non-ratelimited flush and I don't
> see any place where 2 second old stat would be any issue.

We disagreed about this before, and I am not trying to get you to
debate this with me again :)

I just prefer that we avoid this if possible. We have seen cases where
the 2 sec window caused issues. Not because 2 sec is a long time, but
because userspace reads the stats after an event occurs (e.g.
proactive reclaim), but gets stats from before the event.

[..]
>
> >
> >
> > With a mutex lock contention will be less obvious, as converting this to
> > a mutex avoids multiple CPUs spinning while waiting for the lock, but
> > it doesn't remove the lock contention.
> >
>
> I don't like global sleepable locks as those are source of priority
> inversion issues on highly utilized multi-tenant systems but I still
> need to see how you are handling that.

For context, this was discussed before as well in [1].

[1]https://lore.kernel.org/lkml/CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com/

