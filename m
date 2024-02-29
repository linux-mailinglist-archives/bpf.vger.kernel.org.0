Return-Path: <bpf+bounces-23068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DB86D24B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9289288658
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749B7A15A;
	Thu, 29 Feb 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieoDlsIh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C8160653;
	Thu, 29 Feb 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231374; cv=none; b=MthBduCewZXEsPQFs65T0tOtS+h55Li9V/LjMWeuPPi12zu6tCKDYRkxPtvuNkXWETttZu5F3G6vWOPHO36Kg3Thes78S+ezO60srXgbQIxPpu/FnTS+L5TGJItVjvJgArXXFCW0u8n1b9jWXs7cEZfC5QTM0+Y0AEpgd0GeWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231374; c=relaxed/simple;
	bh=o8/Eyjdv17Z5cxEbu17fyvIpxoYiOsECZ9JmxVF1ZH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJJqZ3jDHvttltZWQ3zncBkJfrHS9BxrWBgV4LykaDTtMbxqt2Ejj2y5VKUPnsAUiZ34lMNFqYXwjQH8ylYA0Nm3lxnNTNwJfy7cMAE6IwqXTDlp9Oz33QqkjiQuZcJ20LYWinKGVA9w4JFVkKRIJaOyOsmJ2rKazOfeOMBPmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieoDlsIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3281AC433C7;
	Thu, 29 Feb 2024 18:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709231373;
	bh=o8/Eyjdv17Z5cxEbu17fyvIpxoYiOsECZ9JmxVF1ZH4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ieoDlsIh3FAUltmSAPDqbZgtVAB5KFy/vexGwf7MjAV0tUeTnYVlmI0lDRS8C/wcr
	 Vh8QhEUIaQZVc7VATakuRGEiQmJYIK8o593BYDZzvEnClq5awjK1ZdgC9APFKnXwyj
	 3zSN9A6VDPVC1M3uPzAZTqbayG6ygJdrYVdgS8HVk7kq68E7cGXuyrs9ipcB8wDmEb
	 wE4ZfTdMWhgQKRIGsxG3EU+LZVdTLDUtvr+0o3eRlh8cUI2CKULwEWi9ZL53TUnlvE
	 2QJuau/UBT6ggHXI1cn4pUdTZ5GSf2Yx66yQs2ahlMtTp847PUB55th43okWrOasVJ
	 1BlvMJyRaCMKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCB5CCE1382; Thu, 29 Feb 2024 10:29:32 -0800 (PST)
Date: Thu, 29 Feb 2024 10:29:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, Yan Zhai <yan@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Network Development <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>

On Thu, Feb 29, 2024 at 12:41:55PM -0500, Joel Fernandes wrote:
> > On Feb 29, 2024, at 11:57 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > ﻿On Thu, Feb 29, 2024 at 09:21:48AM -0500, Joel Fernandes wrote:
> >>> On 2/28/2024 5:58 PM, Paul E. McKenney wrote:
> >>> On Wed, Feb 28, 2024 at 02:48:44PM -0800, Alexei Starovoitov wrote:
> >>>> On Wed, Feb 28, 2024 at 2:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>>> 
> >>>>> On Wed, 28 Feb 2024 14:19:11 -0800
> >>>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>>> 
> >>>>>>>> 
> >>>>>>>> Well, to your initial point, cond_resched() does eventually invoke
> >>>>>>>> preempt_schedule_common(), so you are quite correct that as far as
> >>>>>>>> Tasks RCU is concerned, cond_resched() is not a quiescent state.
> >>>>>>> 
> >>>>>>> Thanks for confirming. :-)
> >>>>>> 
> >>>>>> However, given that the current Tasks RCU use cases wait for trampolines
> >>>>>> to be evacuated, Tasks RCU could make the choice that cond_resched()
> >>>>>> be a quiescent state, for example, by adjusting rcu_all_qs() and
> >>>>>> .rcu_urgent_qs accordingly.
> >>>>>> 
> >>>>>> But this seems less pressing given the chance that cond_resched() might
> >>>>>> go away in favor of lazy preemption.
> >>>>> 
> >>>>> Although cond_resched() is technically a "preemption point" and not truly a
> >>>>> voluntary schedule, I would be happy to state that it's not allowed to be
> >>>>> called from trampolines, or their callbacks. Now the question is, does BPF
> >>>>> programs ever call cond_resched()? I don't think they do.
> >>>>> 
> >>>>> [ Added Alexei ]
> >>>> 
> >>>> I'm a bit lost in this thread :)
> >>>> Just answering the above question.
> >>>> bpf progs never call cond_resched() directly.
> >>>> But there are sleepable (aka faultable) bpf progs that
> >>>> can call some helper or kfunc that may call cond_resched()
> >>>> in some path.
> >>>> sleepable bpf progs are protected by rcu_tasks_trace.
> >>>> That's a very different one vs rcu_tasks.
> >>> 
> >>> Suppose that the various cond_resched() invocations scattered throughout
> >>> the kernel acted as RCU Tasks quiescent states, so that as soon as a
> >>> given task executed a cond_resched(), synchronize_rcu_tasks() might
> >>> return or call_rcu_tasks() might invoke its callback.
> >>> 
> >>> Would that cause BPF any trouble?
> >>> 
> >>> My guess is "no", because it looks like BPF is using RCU Tasks (as you
> >>> say, as opposed to RCU Tasks Trace) only to wait for execution to leave a
> >>> trampoline.  But I trust you much more than I trust myself on this topic!
> >> 
> >> But it uses RCU Tasks Trace as well (for sleepable bpf programs), not just
> >> Tasks? Looks like that's what Alexei said above as well, and I confirmed it in
> >> bpf/trampoline.c
> >> 
> >>        /* The trampoline without fexit and fmod_ret progs doesn't call original
> >>         * function and doesn't use percpu_ref.
> >>         * Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
> >>         * Then use call_rcu_tasks() to wait for the rest of trampoline asm
> >>         * and normal progs.
> >>         */
> >>        call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
> >> 
> >> The code comment says it uses both.
> > 
> > BPF does quite a few interesting things with these.
> > 
> > But would you like to look at the update-side uses of RCU Tasks Rude
> > to see if lazy preemption affects them?  I don't believe that there
> > are any problems here, but we do need to check.
> 
> Sure I will be happy to. I am planning look at it in detail over the 3 day weekend. Too much fun! ;-)

Thank you, and looking forward to seeing what you come up with!

The canonical concern would be that someone somewhere is using either
call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() to wait for
non-preemptible regions of code that does not account for the possibility
of preemption in CONFIG_PREEMPT_NONE or PREEMPT_PREEMPT_VOLUNTARY kernels.

I *think* that these are used only to handle the possibility
of tracepoints on functions on the entry/exit path and on the
RCU-not-watching portions of the idle loop.  If so, then there is no
difference in behavior for lazy preemption.  But who knows?

						Thanx, Paul

