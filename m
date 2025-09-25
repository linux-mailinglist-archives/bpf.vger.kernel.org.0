Return-Path: <bpf+bounces-69771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F299BA11AD
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC346C1CB2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B831B10B;
	Thu, 25 Sep 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHOXC3Yf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AC2F25FE;
	Thu, 25 Sep 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826702; cv=none; b=m61c+O9Ecl4iyaDe6AWVy1QUcJwQMku3jOWu4kqjSXIbYOjCGqbGdwa/+DMrYOkIPdOhliVf9aYb95d/rb9+OKDurCUCjWa62zgGtgdmbD1Ee6OJfk7fOL0OzgtzxYTPuh1KcNk6xvS3v3p+M6/GtJMM5AFa4Hh6oLvdgWtG1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826702; c=relaxed/simple;
	bh=4XwZqpYqbX+3v35Bk1RuPIRomzQUZdJDuZfAGxzI5nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMnG2aZT/vqRtolv6ciiJYGcRz4DWb+mvwtIYiQ0a6vVig99MqzW/0gGc2GkFI9WqBKpR1w8pEs+iyfJOXdXLdsJ2dfSh/W2VfmAUgQWtN5JtB2zXNVksH3r9R8P7zrnOeIjkmz7jPWMKr91DBqcCt0AiFzMT/vaRbJvKaFU4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHOXC3Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5536EC4CEF0;
	Thu, 25 Sep 2025 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758826700;
	bh=4XwZqpYqbX+3v35Bk1RuPIRomzQUZdJDuZfAGxzI5nw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EHOXC3Yfbh03OE+Lp2Dyx5LhXMRL1A485SnEwgO6e1/iR1Mii8DPDeiJtik6TPfOA
	 TfJwHZ5xIyoweItNEEV5I4yMntfRaXEF6kyuDmynT09WMliWDY6vcAVtfA1EorNQNo
	 Pf1eGCSAz45bYoY41iTywC5A/Udu9HFMSxmSltsoO9XFmm46JLKDJl8Gp9/Ik6Nhoz
	 CcmrvW0lrR4+yDKKtojvF5LiayeabWekIaX3f56I6ojyNvVgGn5NUOgOC+Pdn2ihUO
	 HA6u132AIeJ0B5gc2XdLyNeqYeSAguiOveMnNQefNVfZNNKRKVc06q/ayFGrXgeaoA
	 DfrFWR/wVyyjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7E53CE1591; Thu, 25 Sep 2025 11:58:17 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:58:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 01/34] rcu: Re-implement RCU Tasks Trace in terms of
 SRCU-fast
Message-ID: <36f40819-d2ac-4185-9f1c-1d01940b1d8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-1-paulmck@kernel.org>
 <CAEf4Bzan+yAzKcBG8VWFWOwR6PigRAjmQB8KrcRwheZnRaTEyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzan+yAzKcBG8VWFWOwR6PigRAjmQB8KrcRwheZnRaTEyQ@mail.gmail.com>

On Thu, Sep 25, 2025 at 11:39:18AM -0700, Andrii Nakryiko wrote:
> On Tue, Sep 23, 2025 at 7:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > This commit saves more than 500 lines of RCU code by re-implementing
> > RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
> > more code that does not cause problems by its presence, but that is no
> > longer required.
> >
> > This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
> > be removed on common-case architectures in a later commit.
> >
> > [ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/rcupdate_trace.h | 107 ++++--
> >  include/linux/sched.h          |   1 +
> >  kernel/rcu/srcutiny.c          |  13 +-
> >  kernel/rcu/tasks.h             | 617 +--------------------------------
> >  4 files changed, 104 insertions(+), 634 deletions(-)
> >
> 
> makes sense to me overall, but I had a few questions below
> 
> > diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> > index e6c44eb428ab63..3f46cbe6700038 100644
> > --- a/include/linux/rcupdate_trace.h
> > +++ b/include/linux/rcupdate_trace.h
> > @@ -12,28 +12,28 @@
> >  #include <linux/rcupdate.h>
> >  #include <linux/cleanup.h>
> >
> > -extern struct lockdep_map rcu_trace_lock_map;
> > +#ifdef CONFIG_TASKS_TRACE_RCU
> > +extern struct srcu_struct rcu_tasks_trace_srcu_struct;
> > +#endif // #ifdef CONFIG_TASKS_TRACE_RCU
> >
> > -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +#if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
> >
> >  static inline int rcu_read_lock_trace_held(void)
> >  {
> > -       return lock_is_held(&rcu_trace_lock_map);
> > +       return srcu_read_lock_held(&rcu_tasks_trace_srcu_struct);
> >  }
> >
> > -#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > +#else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
> >
> >  static inline int rcu_read_lock_trace_held(void)
> >  {
> >         return 1;
> >  }
> >
> > -#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > +#endif // #else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
> 
> nit: // #else // #if... looks very unconventional

Perhaps so, but it is much easier to deal with.

> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >
> > -void rcu_read_unlock_trace_special(struct task_struct *t);
> > -
> >  /**
> >   * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
> >   *
> > @@ -50,12 +50,14 @@ static inline void rcu_read_lock_trace(void)
> >  {
> >         struct task_struct *t = current;
> >
> > -       WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
> > -       barrier();
> > -       if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
> > -           t->trc_reader_special.b.need_mb)
> > -               smp_mb(); // Pairs with update-side barriers
> > -       rcu_lock_acquire(&rcu_trace_lock_map);
> > +       if (t->trc_reader_nesting++) {
> > +               // In case we interrupted a Tasks Trace RCU reader.
> > +               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> 
> why is this a "try_lock" variant instead of a no-try "lock_acquire"
> one? Some lockdep special treatment for nested locking?

Because rcu_read_lock_trace() cannot participate in anywhere near the
variety of deadlocks that (say) read_lock() can.  So we tell lockdep
that this is a try-lock variant so that it won't spew false-positive
deadlock diagnostics.

> > +               return;
> > +       }
> > +       barrier();  // nesting before scp to protect against interrupt handler.
> > +       t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > +       smp_mb(); // Placeholder for more selective ordering
> >  }
> >
> >  /**
> 
> [...]
> 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 2b272382673d62..89d3646155525f 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -939,6 +939,7 @@ struct task_struct {
> >
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >         int                             trc_reader_nesting;
> > +       struct srcu_ctr __percpu        *trc_reader_scp;
> >         int                             trc_ipi_to_cpu;
> >         union rcu_special               trc_reader_special;
> >         struct list_head                trc_holdout_list;
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index e3b64a5e0ec7e1..3450c3751ef7ad 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -106,15 +106,15 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >         newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> >         WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> >         preempt_enable();
> > -       if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> > +       if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
> 
> this seems like something that probably should be done in a separate
> patch with an explanation on why?
> 
> >                 swake_up_one(&ssp->srcu_wq);
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> >
> >  /*
> >   * Workqueue handler to drive one grace period and invoke any callbacks
> > - * that become ready as a result.  Single-CPU and !PREEMPTION operation
> > - * means that we get away with murder on synchronization.  ;-)
> > + * that become ready as a result.  Single-CPU operation and preemption
> > + * disabling mean that we get away with murder on synchronization.  ;-)
> >   */
> >  void srcu_drive_gp(struct work_struct *wp)
> >  {
> > @@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
> >         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> >         WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
> >         preempt_enable();
> > -       swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
> > +       do {
> > +               // Deadlock issues prevent __srcu_read_unlock() from
> > +               // doing an unconditional wakeup, so polling is required.
> > +               swait_event_timeout_exclusive(ssp->srcu_wq,
> > +                                             !READ_ONCE(ssp->srcu_lock_nesting[idx]), HZ / 10);
> > +       } while (READ_ONCE(ssp->srcu_lock_nesting[idx]));
> 
> ditto, generic srcu change, driven by RCU Tasks Trace transformation,
> but probably worth calling it out separately?

Good point for both, will extract them to their own commits.

							Thanx, Paul

> >         preempt_disable();  // Needed for PREEMPT_LAZY
> >         WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
> >         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> 
> [...]

