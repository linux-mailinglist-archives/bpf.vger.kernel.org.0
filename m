Return-Path: <bpf+bounces-42492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AEA9A4A68
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 02:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF745B21CDB
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113B646;
	Sat, 19 Oct 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYOCy4IZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C5173;
	Sat, 19 Oct 2024 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296548; cv=none; b=VgMTenedrRdbeznA5o4YzMuXFXBaa1M1uimdD/MZIVbFK1fovgkE07/C1EY2Nl37DHFmxbYKGRtPD1fi+ZwVfd2H/O84o/Q/wZdcebOIZ3jPZNongaSlHZmKGHhlPFyuFol+HhEQFYy8z+Ch2jyHZZ+99euc4nQZ8lr4V3saZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296548; c=relaxed/simple;
	bh=jzUKTbSkd04sRQh3xPurQDxdL63C7Ml+w1QQqgW6N1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4zKhYMKjiNYzpSvMYWqVUudXCGfCujhWPeEls2L8U5a4h0WEgb5Ki3Hy3eMd6N4jSCKEWNKOWODw9/AHNlwDumd4gkiC/G3Mgi/xNgk95xfqN7BJc0ktny9KDY6prsIzQJaJUO59CNABllWxQ6XpwiknvLJEbcUBXPkHMhYROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYOCy4IZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A2C4CEC3;
	Sat, 19 Oct 2024 00:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729296547;
	bh=jzUKTbSkd04sRQh3xPurQDxdL63C7Ml+w1QQqgW6N1A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oYOCy4IZxG3PVJzueGEjbsvi7U+2fwBd/z4MFq29Kyd7PBDvPzHnImWZUA1p48H/w
	 7YWtxD8Y/uyEorZQXUE+LdVUpAcjG53TSidiHGFV1WtV6wJmpPYKOq1g8C60a1G4ar
	 mov7Wo6g/8zIEMSTc0NG/P2Xy1NRWrmaH253+9d0K89XBm1uW+1LJrGpWBzlgce7m6
	 /g8Yy4uASYe0WxFxqRl4G7INq1Sp8crj+qyN4H03spbkhFNiTq2fKGnfnCDQDIe0F0
	 HWEtl9pQcQc7BS/xq4o8Gf8//APYIzvIjn1ZSgFwvZjaMDTImDsNVfcnVt+nLp7TeI
	 +xqvcVQKit0Kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1E2EDCE0995; Fri, 18 Oct 2024 17:09:07 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:09:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, oleg@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mingo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <c728b2bf-f188-4602-9b1c-b05e3bdea324@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241008002556.2332835-1-andrii@kernel.org>
 <20241008002556.2332835-3-andrii@kernel.org>
 <20241018101647.GA36494@noisy.programming.kicks-ass.net>
 <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZaZGE7Kb+AZkN0eTH+0ny-_0WUxKT7ydDzAfEwP8cKVg@mail.gmail.com>

On Fri, Oct 18, 2024 at 11:22:09AM -0700, Andrii Nakryiko wrote:
> On Fri, Oct 18, 2024 at 3:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 07, 2024 at 05:25:56PM -0700, Andrii Nakryiko wrote:
> >
> 
> [...]
> 
> > > +
> > > +             /* We lost the race, undo refcount bump (if it ever happened) */
> > > +             if (uprobe)
> > > +                     put_uprobe(uprobe);
> > > +             /*
> > > +              * Even if hprobe_consume() or another hprobe_expire() wins
> > > +              * the state update race and unlocks SRCU from under us, we
> > > +              * still have a guarantee that underyling uprobe won't be
> > > +              * freed due to ongoing caller's SRCU lock region, so we can
> > > +              * return it regardless. The caller then can attempt its own
> > > +              * try_get_uprobe() to preserve the instance, if necessary.
> > > +              * This is used in dup_utask().
> > > +              */
> > > +             return uprobe;
> > > +     }
> > > +     default:
> > > +             WARN(1, "unknown hprobe state %d", hstate);
> > > +             return NULL;
> > > +     }
> > > +}
> >
> > So... after a few readings I think I'm mostly okay with this. But I got
> > annoyed by the whole HPROBE_STABLE with uprobe=NULL weirdness. Also,
> > that data_race() usage is weird, what is that about?
> 
> People keep saying that evil KCSAN will come after me if I don't add
> data_race() for values that can change under me, so I add it to make
> it explicit that it's fine. But I can of course just drop data_race(),
> as it has no bearing on correctness.

Use data_race() if you know that the compiler cannot mess you up or when
its messing you up is acceptable.  An example of the latter is code that
gathers statistics or debug information, at least in some cases.

Something like READ_ONCE() or atomic_read() is better when the compiler
can mess you up.

For more information:  https://lwn.net/Articles/793253/
https://lwn.net/Articles/799218/

							Thanx, Paul

> > And then there's the case where we end up doing:
> >
> >   try_get_uprobe()
> >   put_uprobe()
> >   try_get_uprobe()
> >
> > in the dup path. Yes, it's unlikely, but gah.
> >
> >
> > So how about something like this?
> 
> Yep, it makes sense to start with HPROBE_GONE if it's already NULL, no
> problem. I'll roll those changes in.
> 
> I'm fine with the `bool get` flag as well. Will incorporate all that
> into the next revision, thanks!
> 
> The only problem I can see is in the assumption that `srcu_idx < 0` is
> never going to be returned by srcu_read_lock(). Paul says that it can
> only be 0 or 1, but it's not codified as part of a contract. So until
> we change that, probably safer to pass an extra bool specifying
> whether srcu_idx is valid or not, is that OK?
> 
> (and I assume you want me to drop verbose comments for various states, right?)
> 
> 
> 
> >
> > ---
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 06ec41c75c45..efb4f5ee6212 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -657,20 +657,19 @@ static void put_uprobe(struct uprobe *uprobe)
> >         call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
> >  }
> >
> > -/* Initialize hprobe as SRCU-protected "leased" uprobe */
> > -static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
> > +static void hprobe_init(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
> >  {
> > -       hprobe->state = HPROBE_LEASED;
> > -       hprobe->uprobe = uprobe;
> > -       hprobe->srcu_idx = srcu_idx;
> > -}
> > +       enum hprobe_state state = HPROBE_GONE;
> >
> > -/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
> > -static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
> > -{
> > -       hprobe->state = HPROBE_STABLE;
> > +       if (uprobe) {
> > +               state = HPROBE_LEASED;
> > +               if (srcu_idx < 0)
> > +                       state = HPROBE_STABLE;
> > +       }
> > +
> > +       hprobe->state = state;
> >         hprobe->uprobe = uprobe;
> > -       hprobe->srcu_idx = -1;
> > +       hprobe->srcu_idx = srcu_idx;
> >  }
> >
> >  /*
> > @@ -713,8 +712,7 @@ static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
> >                 __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> >                 break;
> >         case HPROBE_STABLE:
> > -               if (hprobe->uprobe)
> > -                       put_uprobe(hprobe->uprobe);
> > +               put_uprobe(hprobe->uprobe);
> >                 break;
> >         case HPROBE_GONE:
> >         case HPROBE_CONSUMED:
> > @@ -739,8 +737,9 @@ static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
> >   * refcount, so caller has to attempt try_get_uprobe(), if it needs to
> >   * preserve uprobe beyond current SRCU lock region. See dup_utask().
> >   */
> > -static struct uprobe* hprobe_expire(struct hprobe *hprobe)
> > +static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
> >  {
> > +       struct uprobe *uprobe = NULL;
> >         enum hprobe_state hstate;
> >
> >         /*
> > @@ -749,25 +748,18 @@ static struct uprobe* hprobe_expire(struct hprobe *hprobe)
> >          */
> >         lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> >
> > -       hstate = data_race(READ_ONCE(hprobe->state));
> > +       hstate = READ_ONCE(hprobe->state);
> >         switch (hstate) {
> >         case HPROBE_STABLE:
> > -               /* uprobe is properly refcounted, return it */
> > -               return hprobe->uprobe;
> > +               uprobe = hprobe->uprobe;
> > +               break;
> > +
> >         case HPROBE_GONE:
> > -               /*
> > -                * SRCU was unlocked earlier and we didn't manage to take
> > -                * uprobe refcnt, so it's effectively NULL
> > -                */
> > -               return NULL;
> >         case HPROBE_CONSUMED:
> > -               /*
> > -                * uprobe was consumed, so it's effectively NULL as far as
> > -                * uretprobe processing logic is concerned
> > -                */
> > -               return NULL;
> > -       case HPROBE_LEASED: {
> > -               struct uprobe *uprobe = try_get_uprobe(hprobe->uprobe);
> > +               break;
> > +
> > +       case HPROBE_LEASED:
> > +               uprobe = try_get_uprobe(hprobe->uprobe);
> >                 /*
> >                  * Try to switch hprobe state, guarding against
> >                  * hprobe_consume() or another hprobe_expire() racing with us.
> > @@ -778,27 +770,26 @@ static struct uprobe* hprobe_expire(struct hprobe *hprobe)
> >                 if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
> >                         /* We won the race, we are the ones to unlock SRCU */
> >                         __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> > -                       return uprobe;
> > +                       break;
> >                 }
> >
> >                 /* We lost the race, undo refcount bump (if it ever happened) */
> > -               if (uprobe)
> > +               if (uprobe && !get) {
> >                         put_uprobe(uprobe);
> > -               /*
> > -                * Even if hprobe_consume() or another hprobe_expire() wins
> > -                * the state update race and unlocks SRCU from under us, we
> > -                * still have a guarantee that underyling uprobe won't be
> > -                * freed due to ongoing caller's SRCU lock region, so we can
> > -                * return it regardless. The caller then can attempt its own
> > -                * try_get_uprobe() to preserve the instance, if necessary.
> > -                * This is used in dup_utask().
> > -                */
> > +                       uprobe = NULL;
> > +               }
> > +
> >                 return uprobe;
> > -       }
> > +
> >         default:
> >                 WARN(1, "unknown hprobe state %d", hstate);
> >                 return NULL;
> >         }
> > +
> > +       if (uprobe && get)
> > +               return try_get_uprobe(uprobe);
> > +
> > +       return uprobe;
> >  }
> >
> >  static __always_inline
> > @@ -1920,9 +1911,8 @@ static void ri_timer(struct timer_list *timer)
> >         /* RCU protects return_instance from freeing. */
> >         guard(rcu)();
> >
> > -       for_each_ret_instance_rcu(ri, utask->return_instances) {
> > -               hprobe_expire(&ri->hprobe);
> > -       }
> > +       for_each_ret_instance_rcu(ri, utask->return_instances)
> > +               hprobe_expire(&ri->hprobe, false);
> >  }
> >
> >  static struct uprobe_task *alloc_utask(void)
> > @@ -1975,10 +1965,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >
> >                 *n = *o;
> >
> > -               /* see hprobe_expire() comments */
> > -               uprobe = hprobe_expire(&o->hprobe);
> > -               if (uprobe) /* refcount bump for new utask */
> > -                       uprobe = try_get_uprobe(uprobe);
> > +               uprobe = hprobe_expire(&o->hprobe, true);
> >
> >                 /*
> >                  * New utask will have stable properly refcounted uprobe or
> > @@ -1986,7 +1973,7 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >                  * need to preserve full set of return_instances for proper
> >                  * uretprobe handling and nesting in forked task.
> >                  */
> > -               hprobe_init_stable(&n->hprobe, uprobe);
> > +               hprobe_init(&n->hprobe, uprobe, -1);
> >
> >                 n->next = NULL;
> >                 rcu_assign_pointer(*p, n);
> > @@ -2131,7 +2118,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> >
> >         utask->depth++;
> >
> > -       hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
> > +       hprobe_init(&ri->hprobe, uprobe, srcu_idx);
> >         ri->next = utask->return_instances;
> >         rcu_assign_pointer(utask->return_instances, ri);
> >

