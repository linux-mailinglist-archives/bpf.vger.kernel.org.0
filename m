Return-Path: <bpf+bounces-46567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB79EBD8B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 23:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F43188CC87
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED1240363;
	Tue, 10 Dec 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAboepKK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD41EE7A1
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868407; cv=none; b=OthZxA4j2+1HUtgbxF1AcwDhXIkEhogBxHUhJI1koy9IFO+CcK5bR6bJQCcE58053Zy9oJ3yhzrc8AxrLfl/y4bryO2dTgIevNNy9HyrvdnaTvR2c0i1dlpNJnxeQCwm7UrcGYVj/vW7U3H5OK5KQ2DyW6PjuKe9aYqUZZ4JPLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868407; c=relaxed/simple;
	bh=kTXkMeyaSbg7ZJvce8GgCpBi8Y5Nmyiexlx6P1LNAgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC25dmXXXEHqIG5gAy+i9zX0/nMCBw4bAA5Cod0KtzKWbB+rnGfI8UyKYXLqF8mfxPRlCm136URXVNwQjtBdQ2h7qtAn0AzfG+aED1x+Qj7/+BmBhCJeddmPMARXAcFkimHgZ3f4HHUU+H5fdlVWryeo4O9Q2/4PO/wKwpMEo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAboepKK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e3621518so3955243f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733868404; x=1734473204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7r/ujUSA8WI6llNNMSkcXsP+FVbV3O9MXAN4gtJ0t4=;
        b=gAboepKKolsgWxkterZa4h5ONtzflsnLiYLKB3SunyY6yRrJk8PHQ5ErDPqxYEZDoW
         sv1Gp6dV4fiVN+PjFmWra0izUeezzWjjsfe5boV+14DvESf/vAATrvvP0EwxcKg0a6wW
         abRo7hdZo9VduQBH/yPky9yAaho2WEFDOhg4oSiLJ0QIf23iq9U5SiKOmqSgrEjITQMB
         xFz1cU5XCj3ynJtYNFAx7Gdpxq371oFeqd3C/KjS0agPIFk+/xgxzZY9344Xm8sW3JXE
         ESnMf1pw+ak85eqXaDilzJkHupHz7crXI+A3JstB+eNFueFIsojSFPhC1TtAIYkXvSy4
         qywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868404; x=1734473204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7r/ujUSA8WI6llNNMSkcXsP+FVbV3O9MXAN4gtJ0t4=;
        b=aeqzwKIdmu44Hn9SA9FxzNkBlHiBQImCTWLFmfEFKVa3fhAvBradsZNWWxxjL2/Gxk
         cMieV4IE+oSJvv4zAAPKX73GwmtLR2RoQ/IMTO9F1lE1WqzB2EaXMzCOEAbAtMC17MJX
         JjRnmZhbEkGW1WkPAU+22jjQ7/zedEEuWBNxNOGxjkmB1DyFlj0gup1V+AxtZcXxAQ6H
         ry3ulcArhlgPtmwtuwXO0yyrFPL63mwzN0b/X1D9x8Afs3lCya6Hj6csyTfDTL4Jp4uH
         FzxU2f9OlKQCO6zb8l9ZowdCVCGn9Iows01tZKQeIhYbLETFsZiD28tWvZoBKYzeHk5v
         j4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXGy/Vg7QKLQi+PapJCdBS4YLfRcboSAA0cslXEf3DENQpb8MzvJWmjHefy99XDdFxbUxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN97TM3xB7KveBUWrG+BjnUwHoJmioJKq5wzbVTEFhh7UlO5Kr
	M3EvIH8dwoyWcIoS95ZKBS4J5yssURws005PxCtO5PniZafUav+fPMLv9AVbMXGo4dWrx0+8U/x
	LP8nbfbrE2z8rjwWm4uP83Y8zCeY=
X-Gm-Gg: ASbGncvxmODet6hnHizr0rXVW3L7Bmzj5j184XHTVjl3fMbypXJAdvKXGhNOrgJlKtm
	fWFQvR7ZVojMxU2IfhA17CyWTFerPQRZz23Nblxq4fMAKJZ4uUD0=
X-Google-Smtp-Source: AGHT+IGDmmtb22UuyrBBvK3V9jG5ErcHX3MG2LurkjPVBWfp7ZCC778kP32UIzbrh9Bl9mOTwwrvDvEwrjFZRM3ZrBU=
X-Received: by 2002:a5d:5849:0:b0:385:f6c7:90c6 with SMTP id
 ffacd0b85a97d-3864ce55a98mr519902f8f.20.1733868404233; Tue, 10 Dec 2024
 14:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
In-Reply-To: <Z1gEUmHkF1ikgbor@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 14:06:32 -0800
Message-ID: <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:05=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 10-12-24 05:31:30, Matthew Wilcox wrote:
> > On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > > +   if (preemptible() && !rcu_preempt_depth())
> > > +           return alloc_pages_node_noprof(nid,
> > > +                                          GFP_NOWAIT | __GFP_ZERO,
> > > +                                          order);
> > > +   return alloc_pages_node_noprof(nid,
> > > +                                  __GFP_TRYLOCK | __GFP_NOWARN | __G=
FP_ZERO,
> > > +                                  order);
> >
> > [...]
> >
> > > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int=
 order)
> > >      * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> > >      */
> > >     alloc_flags |=3D (__force int)
> > > -           (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > > +           (gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TR=
YLOCK));
> >
> > It's not quite clear to me that we need __GFP_TRYLOCK to implement this=
.
> > I was originally wondering if this wasn't a memalloc_nolock_save() /
> > memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore=
),
> > but I wonder if we can simply do:
> >
> >       if (!preemptible() || rcu_preempt_depth())
> >               alloc_flags |=3D ALLOC_TRYLOCK;
>
> preemptible is unusable without CONFIG_PREEMPT_COUNT but I do agree that
> __GFP_TRYLOCK is not really a preferred way to go forward. For 3
> reasons.
>
> First I do not really like the name as it tells what it does rather than
> how it should be used. This is a general pattern of many gfp flags
> unfotrunatelly and historically it has turned out error prone. If a gfp
> flag is really needed then something like __GFP_ANY_CONTEXT should be
> used.  If the current implementation requires to use try_lock for
> zone->lock or other changes is not an implementation detail but the user
> should have a clear understanding that allocation is allowed from any
> context (NMI, IRQ or otherwise atomic contexts).

__GFP_ANY_CONTEXT would make sense if we wanted to make it available
for all kernel users. In this case I agree with Sebastian.
This is bpf specific feature, since it doesn't know the context.
All other kernel users should pick GFP_KERNEL or ATOMIC or NOWAIT.
Exposing GFP_ANY_CONTEXT to all may lead to sloppy code in drivers
and elsewhere.

> Is there any reason why GFP_ATOMIC cannot be extended to support new
> contexts? This allocation mode is already documented to be usable from
> atomic contexts except from NMI and raw_spinlocks. But is it feasible to
> extend the current implementation to use only trylock on zone->lock if
> called from in_nmi() to reduce unexpected failures on contention for
> existing users?

No. in_nmi() doesn't help. It's the lack of reentrance of slab and page
allocator that is an issue.
The page alloctor might grab zone lock. In !RT it will disable irqs.
In RT will stay sleepable. Both paths will be calling other
kernel code including tracepoints, potential kprobes, etc
and bpf prog may be attached somewhere.
If it calls alloc_page() it may deadlock on zone->lock.
pcpu lock is thankfully trylock already.
So !irqs_disabled() part of preemptible() guarantees that
zone->lock won't deadlock in !RT.
And rcu_preempt_depth() case just steers bpf into try lock only path in RT.
Since there is no way to tell whether it's safe to call
sleepable spin_lock(&zone->lock).

>
> Third, do we even want such a strong guarantee in the generic page
> allocator path and make it even more complex and harder to maintain?

I'm happy to add myself as R: or M: for trylock bits,
since that will be a fundamental building block for bpf.

> We
> already have a precence in form of __alloc_pages_bulk which is a special
> case allocator mode living outside of the page allocator path. It seems
> that it covers most of your requirements except the fallback to the
> regular allocation path AFAICS. Is this something you could piggy back
> on?

__alloc_pages_bulk() has all the same issues. It takes locks.
Also it doesn't support GFP_ACCOUNT which is a show stopper.
All bpf allocations are going through memcg.

