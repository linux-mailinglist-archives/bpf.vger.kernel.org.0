Return-Path: <bpf+bounces-34819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1E93133E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119391C215AB
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59C189F5E;
	Mon, 15 Jul 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ctwKmMfN"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA172572;
	Mon, 15 Jul 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043675; cv=none; b=kB8Yz06qndFya+8HXADFzGSiYsqZuPySSDg3bH2FqIecIuab58FcS8pu2+YgaJnfVUl35kffYIGdp7vN7JCbuBlIbmYXXmADN1nK6ywjQEcObYXgzddhjXmZEx5IwliSGjN6gc4uXJ6vKuq82MMC/x+0xf/Q0pnZwM+HsNAORi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043675; c=relaxed/simple;
	bh=OXHU1MHxbj793Mtok78Gc21X5UrdTvA60vYMWvz7U+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kge2vGnK1Jf/PZ+KN+6bzX7XJE58cp4zXX08wYLwTztWIOPV3ySQXa+cLc/MjiDBgCUqJwfLubOhnWUQRQPlvGG1WsPwk82sKsTu/mXceHXXmFpso2XY/mGCndNymY+9wAeuEthQdlFlVF8WNayebBJEd0rnmhGs8t3eUtVm8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ctwKmMfN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=y5Q7Vcvg0k0Ths9BKndB5/gtpLO3ynMN1NfxgNm2faI=; b=ctwKmMfNK/BqpHr7ftrEWvIBBR
	bbsbK+lDxtD0xVDj1JytO98GqK+F1TB3L/yDWVAatHptf+NujI8dP8O1r+nXwaB40s2gsvtaqfoZU
	HKs7Xg/ZsEfJ3B7KZBzdBIilKTYQrDaRKTXYholmM82iiaZWUYobEUPZ/LKvcYic//DGwTMsAZ2n6
	w5XIo43thOCEpKGAL3d71s4kcSLdW7SoNJDwOH5Ki9ojbkcmN4k1tfyTRKTCNhGz/AR1VY1PH9ewF
	WnnlHpk7Quk8YOMOPkkh459oVm8h/4fxgyUUgAWJTcEbrdc103EHpuJjt1xfAqMv1e+FiWSXIEqay
	R1/2ki7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTK4q-0000000FkFX-0D7n;
	Mon, 15 Jul 2024 11:41:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AD433003FF; Mon, 15 Jul 2024 13:41:07 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:41:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240715114107.GE14400@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
 <CAEf4BzZCzqOsk55E0b8i9y5zFuf8t=zwrjORnVaLGK0ZVgJTFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZCzqOsk55E0b8i9y5zFuf8t=zwrjORnVaLGK0ZVgJTFg@mail.gmail.com>

On Fri, Jul 12, 2024 at 02:43:52PM -0700, Andrii Nakryiko wrote:
> + bpf
> 
> On Thu, Jul 11, 2024 at 4:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > In order to put a bound on the uretprobe_srcu critical section, add a
> > timer to uprobe_task. Upon every RI added or removed the timer is
> > pushed forward to now + 1s. If the timer were ever to fire, it would
> > convert the SRCU 'reference' to a refcount reference if possible.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/uprobes.h |    8 +++++
> >  kernel/events/uprobes.c |   67 ++++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 69 insertions(+), 6 deletions(-)
> >
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -15,6 +15,7 @@
> >  #include <linux/rbtree.h>
> >  #include <linux/types.h>
> >  #include <linux/wait.h>
> > +#include <linux/timer.h>
> >
> >  struct vm_area_struct;
> >  struct mm_struct;
> > @@ -79,6 +80,10 @@ struct uprobe_task {
> >         struct return_instance          *return_instances;
> >         unsigned int                    depth;
> >         unsigned int                    active_srcu_idx;
> > +
> > +       struct timer_list               ri_timer;
> > +       struct callback_head            ri_task_work;
> > +       struct task_struct              *task;
> >  };
> >
> >  struct return_instance {
> > @@ -86,7 +91,8 @@ struct return_instance {
> >         unsigned long           func;
> >         unsigned long           stack;          /* stack pointer */
> >         unsigned long           orig_ret_vaddr; /* original return address */
> > -       bool                    chained;        /* true, if instance is nested */
> > +       u8                      chained;        /* true, if instance is nested */
> > +       u8                      has_ref;
> 
> Why bool -> u8 switch? You don't touch chained, so why change its
> type? And for has_ref you interchangeably use 0 and true for the same
> field. Let's stick to bool as there is nothing wrong with it?

sizeof(_Bool) is implementation defined. It is 1 for x86_64, but there
are platforms where it ends up begin 4 (some PowerPC ABIs among others.
I didn't want to grow this structure for no reason.

> >         int                     srcu_idx;
> >
> >         struct return_instance  *next;          /* keep as stack */
> 
> [...]
> 
> > @@ -1822,13 +1864,20 @@ static int dup_utask(struct task_struct
> >                         return -ENOMEM;
> >
> >                 *n = *o;
> > -               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
> > +               if (n->uprobe) {
> > +                       if (n->has_ref)
> > +                               get_uprobe(n->uprobe);
> > +                       else
> > +                               __srcu_clone_read_lock(&uretprobes_srcu, n->srcu_idx);
> > +               }
> >                 n->next = NULL;
> >
> >                 *p = n;
> >                 p = &n->next;
> >                 n_utask->depth++;
> >         }
> > +       if (n_utask->return_instances)
> > +               mod_timer(&n_utask->ri_timer, jiffies + HZ);
> 
> let's add #define for HZ, so it's adjusted in just one place (instead
> of 3 as it is right now)

Can do I suppose.

> Also, we can have up to 64 levels of uretprobe nesting, so,
> technically, the user can cause a delay of 64 seconds in total. Maybe
> let's use something smaller than a full second? After all, if the
> user-space function has high latency, then this refcount congestion is
> much less of a problem. I'd set it to something like 50-100 ms for
> starters.

Before you know it we'll have a sysctl :/ But sure, we can do something
shorter.

