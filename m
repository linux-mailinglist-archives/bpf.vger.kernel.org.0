Return-Path: <bpf+bounces-53852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D81A5CD24
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9616E75A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2626388C;
	Tue, 11 Mar 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eguhmMJN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C953263885
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716301; cv=none; b=mHaBuP1guiwH6dZoQ4C3v3XrXDmGS3/zY0lcOZIVH04AY5SQSPSdxMSSILdhzLpBmwThnOHdvrDi+oEAxg5Z2scb9Yh0bP7iQgfvURzuImtSfSSLpTV3WQWfUctQVtnBnHn35wK25ZKIep//n2x2yWi9dvEqYz8cdOOJ8QXHcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716301; c=relaxed/simple;
	bh=ZUj1NmhZQKiOgWvMR6fT8s+8x5jsWPr/CWt+aXhG4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cItrWqyPbr9qGJQ7d06tGOwDW1XvyDKgyBRq4Fyn8LJL1qbIPGInBAyCw2+iR2BvaBWyfsYCFLLTOXMpgI/9hVjE/rH/dl45MgwLxWQdlHoo3dfBI8EXeO6206utOgXa9GhxeNms3AQeIkaP+twD1xFc3U7wedq2AISAhM4G/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eguhmMJN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54957f0c657so93820e87.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716298; x=1742321098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMsGH3YV+7Jez0K1iVv4LQwNOT9vQI0481jYwFLNLGk=;
        b=eguhmMJN6IaqtEbbEJY7EIy6dZsrb266X+vODBtoXbJkXbVEXZQ3q0Q3kHxdLXUZRu
         bot0isgcV6muu776BUisEnuvUPpxZjlrx6kbO4ngpDWSTvOX9w/KLhr43ZuQHw0yZbOy
         fB3qV2AU/v9879nTVm+0QbpkZpYGwwi2BWRzHc8qDyBW8hZ87oeL8mIVxTLaqKc+L4rk
         GFnmrZfXXU6Wy3Co3NFu1PAl/wG2GdTNa6gjA/d0cQjtGWBkWQ7ciorQNjYKzbTem7oY
         YPUN3aoosBf+RuIXdeOfFCENKSPFncVAe+zLolpQC+L4O+aALqdJAor7uJfccnBWqRFB
         AWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716298; x=1742321098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMsGH3YV+7Jez0K1iVv4LQwNOT9vQI0481jYwFLNLGk=;
        b=sBpMea/TeyyJBw//esMrYITAbq4JKH1Oe6eFfIS4jbB0Sn4WHR+KCHwZCLFMJheP6c
         6dCKveYt4fRvNmFZWmSkCi4tXextUhXxW4DBWmSYX6O4Ip4sH5MJdQtIInWoNLeUVuD/
         fl048QX215RUIu6aCJjd4aWyg0+GtQvQ4aNTf3XTVkePuQKCylF47Dto4NOMIiF/XDoH
         6V29XT+/spx6JOYFZXWVO35JzaHE4rFAUV6NHFiEoNxUIClnv8k+heriCpUsvpmUlZ0K
         2A690z4hGzLe37i/KX36EuTPlxOFVhoO3l3z/N00cQsG9sXNOSVd04XRd/hACLT4tA1B
         rrVA==
X-Forwarded-Encrypted: i=1; AJvYcCU0G6UTi2yj9wOQzF4IGDtcTyrRQYryR4ruw9pwY5Lrn/IA5VCVX//K+1NGAcwFkwb3NlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzsB91yN15uf1/fe6rKlvTkNZbvkEn9Y/cx6bvca9SefM8NY9
	RGFeaoSik/IfJvSWeRRjMXKsBOlZsbERgLEKRJrhhUnuJC9cbwH0
X-Gm-Gg: ASbGnctiMuUZbm+lHq1Qz9Yk9IZOaaC6N5fbSuRsVEUpAub5z0GmLe2VwaQny4qq+/T
	Tirxu5ekMGD+VaCMFWe6IXvtbwaDGXdfeY0lRbQPcLU1XvU499/mGAStUXTrF7+kzMMiMeeRO9V
	y3yPYyR3GvNgetLQkz5gl/928+frrlfLq3UViO1tLqsWQdFdbGgyZgp5lyBtL0bnNF4/8eb++vc
	9ITfsRmBA5VaMj+OjDUWcg/CHuHPLFM3gtuKoUBJr7YTnuZCws6JJEDBOLfF+2W2DjA3lWAI0rB
	Iemdz4QVrh0ugsRk5EjP4bQX4Py4qAGzT4hogwj0pbwt/kVHP+xz+ejtCNEJ
X-Google-Smtp-Source: AGHT+IFUK/N2ttWr3IIs5Uri+DRbvApiqKz4hmjmPEHs9K+Woe2sSswWWoqioF5cNEHR7FaTTf9Nag==
X-Received: by 2002:a05:6512:2313:b0:549:8ccd:4538 with SMTP id 2adb3069b0e04-549abd58949mr1576975e87.26.1741716297204;
        Tue, 11 Mar 2025 11:04:57 -0700 (PDT)
Received: from f (cst-prg-86-144.cust.vodafone.cz. [46.135.86.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae59171sm1880818e87.94.2025.03.11.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:04:56 -0700 (PDT)
Date: Tue, 11 Mar 2025 19:04:47 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <rbfpuj6kmbwbzyd25tjhlrf4aytmhmegn5ez54rpb2mue3cxyk@ok46lkhvvfjt>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>

On Tue, Mar 11, 2025 at 02:32:24PM +0100, Alexei Starovoitov wrote:
> On Tue, Mar 11, 2025 at 3:04 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > Tracing BPF programs execute from tracepoints and kprobes where
> > > running context is unknown, but they need to request additional
> > > memory. The prior workarounds were using pre-allocated memory and
> > > BPF specific freelists to satisfy such allocation requests.
> >
> > The "prior workarounds" sound entirely appropriate.  Because the
> > performance and maintainability of Linux's page allocator is about
> > 1,000,040 times more important than relieving BPF of having to carry a
> > "workaround".
> 
> Please explain where performance and maintainability is affected?
> 

I have some related questions below. Note I'm a bystander, not claiming
to have any (N)ACK power.

A small bit before that:
       if (!spin_trylock_irqsave(&zone->lock, flags)) {
	       if (unlikely(alloc_flags & ALLOC_TRYLOCK))
		       return NULL;
	       spin_lock_irqsave(&zone->lock, flags);
       }

This is going to perform worse when contested due to an extra access to
the lock. I presume it was done this way to avoid suffering another
branch, with the assumption the trylock is normally going to succeed.

So happens I'm looking at parallel exec on the side and while currently
there is bigger fish to fry, contention on zone->lock is very much a
factor. Majority of it comes from RCU freeing (in free_pcppages_bulk()),
but I also see several rmqueue calls below. As they trylock, they are
going to make it more expensive for free_pcppages_bulk() to even get the
lock.

So this *is* contested, but at the moment is largely overshadowed by
bigger problems (which someone(tm) hopefully will sort out sooner than
later).

So should this land, I expect someone is going to hoist the trylock at
some point in the future. If it was my patch I would just do it now, but
I understand this may result in new people showing up and complaining.

> As far as motivation, if I recall correctly, you were present in
> the room when Vlastimil presented the next steps for SLUB at
> LSFMM back in May of last year.
> A link to memory refresher is in the commit log:
> https://lwn.net/Articles/974138/
> 
> Back then he talked about a bunch of reasons including better
> maintainability of the kernel overall, but what stood out to me
> as the main reason to use SLUB for bpf, objpool, mempool,
> and networking needs is prevention of memory waste.
> All these wrappers of slub pin memory that should be shared.
> bpf, objpool, mempools should be good citizens of the kernel
> instead of stealing the memory. That's the core job of the
> kernel. To share resources. Memory is one such resource.
> 

I suspect the worry is that the added behavior may complicate things
down the road (or even prevent some optimizations) -- there is another
context to worry about.

I think it would help to outline why these are doing any memory
allocation from something like NMI to begin with. Perhaps you could have
carved out a very small piece of memory as a reserve just for that? It
would be refilled as needed from process context.

A general remark is that support for an arbitrary running context in
core primitives artificially limits what can be done to optimize them
for their most common users. imo the sheaves patchset is a little bit of
an admission (also see below). It may be the get pages routine will get
there.

If non-task memory allocs got beaten to the curb, or at least got heavily
limited, then a small allocator just for that purpose would do the
trick and the two variants would likely be simpler than one thing which
supports everyone. This patchset is a step in the opposite direction,
but it may be there is a good reason.

To my understanding ebpf can be used to run "real" code to do something
or "merely" collect data. I presume the former case is already running
from a context where it can allocate memory no problem.

For the latter I presume ebpf has conflicting goals: 1. not disrupt the
workload under observation (cpu and ram) -- to that end small memory
usage limits are in place. otherwise a carelessly written aggregation
can OOM the box (e.g., say someone wants to know which files get opened
the most and aggregates on names, while a malicious user opens and
unlinks autogenerated names, endlessly growing the list if you let it)
2. actually log stuff even if resources are scarce. to that end I
would expect that a small area is pre-allocated and periodically drained

Which for me further puts a question mark on general alloc from the NMI
context.

All that said, the cover letter:
> The main motivation is to make alloc page and slab reentrant and
> remove bpf_mem_alloc.

does not justify why ebpf performs allocations in a manner which warrant
any of this, which I suspect is what Andrew asked about.

I never put any effort into ebpf -- it may be all the above makes
excellent sense. But then you need to make a case to the people
maintaining the code.

