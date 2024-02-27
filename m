Return-Path: <bpf+bounces-22784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A8869F26
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 19:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0970E28F232
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8C4CB55;
	Tue, 27 Feb 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2a9klJj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438843F9D4;
	Tue, 27 Feb 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058743; cv=none; b=tO+Ot53xBCaSalz+WX0UnpUrq3bwzHJjFzCSKCj3GV6KoPmlHduDk9mEDFy5FP6NKTq+Trl1eCHiE5kbyqEzK20W9m4ooLUOsVQYu1+6zDwa6si7PVp7h4e45TxN6xmic3ayZYagf0szp9y5ASh4HyQpiyADqVa/K3aTTKkHhS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058743; c=relaxed/simple;
	bh=j/7lHjnuycVswY8Vitw2LTYF5LfHLWpvyXDyXoKHN58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap8op6hPrQROF7breBwKv2YTmVUYPp2ez4Jj1qUG0ju2l978SWu4MTW2hFmDLcpa7PQ7kae/fUwtI4kWPouucTlQPmwKw4Q5sRy9vSxQpYwTDN7Kl/aZrrtQ0r9qkECm/OYIeFaaEg8B3fTCi32lToGG0PRWbeA0akap6eabjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2a9klJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF36C433F1;
	Tue, 27 Feb 2024 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058743;
	bh=j/7lHjnuycVswY8Vitw2LTYF5LfHLWpvyXDyXoKHN58=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=s2a9klJj3z3nhiKK0y/N8gc+m+4m4iyE1BtWkSjHjSU7e2IL/LxESGgjBL+OTe+Rq
	 GGaEvDOjNb/bZQgtfeKzedXU7Jis+zS8R/dprDKA2hVy66kvzGv0Gnv961G6lHZCov
	 H3FF5M1ydr0rbtAEbYiXHksatSJMieHyCNXMu5fCW/jLKk5PqCK9dAf8p114mLDeb6
	 70Gmsssm/4ceeSpVuh6T9t3izM8bc2veqz/22RRFf9QCDeYxzU2nKcJZNzgIsV6Z3+
	 C6KtFZD9DoJ6h0mFeHvKl2aygAMe6P9w5Pum+egPHmAsXvd2dUwZa5G/WrRmtDc5zM
	 5334H7P6Uf+1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80AB9CE0D68; Tue, 27 Feb 2024 10:32:22 -0800 (PST)
Date: Tue, 27 Feb 2024 10:32:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>

On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
> On Tue, Feb 27, 2024 at 4:44 PM Yan Zhai <yan@cloudflare.com> wrote:
> >
> > We noticed task RCUs being blocked when threaded NAPIs are very busy in
> > production: detaching any BPF tracing programs, i.e. removing a ftrace
> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> > ranges from hundreds of seconds to even an hour, severely harming any
> > observability tools that rely on BPF tracing programs. It can be
> > easily reproduced locally with following setup:
> >
> > ip netns add test1
> > ip netns add test2
> >
> > ip -n test1 link add veth1 type veth peer name veth2 netns test2
> >
> > ip -n test1 link set veth1 up
> > ip -n test1 link set lo up
> > ip -n test2 link set veth2 up
> > ip -n test2 link set lo up
> >
> > ip -n test1 addr add 192.168.1.2/31 dev veth1
> > ip -n test1 addr add 1.1.1.1/32 dev lo
> > ip -n test2 addr add 192.168.1.3/31 dev veth2
> > ip -n test2 addr add 2.2.2.2/31 dev lo
> >
> > ip -n test1 route add default via 192.168.1.3
> > ip -n test2 route add default via 192.168.1.2
> >
> > for i in `seq 10 210`; do
> >  for j in `seq 10 210`; do
> >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
> >  done
> > done
> >
> > ip netns exec test2 ethtool -K veth2 gro on
> > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> > ip netns exec test1 ethtool -K veth1 tso off
> >
> > Then run an iperf3 client/server and a bpftrace script can trigger it:
> >
> > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
> > bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'
> >
> > Above reproduce for net-next kernel with following RCU and preempt
> > configuraitons:
> >
> > # RCU Subsystem
> > CONFIG_TREE_RCU=y
> > CONFIG_PREEMPT_RCU=y
> > # CONFIG_RCU_EXPERT is not set
> > CONFIG_SRCU=y
> > CONFIG_TREE_SRCU=y
> > CONFIG_TASKS_RCU_GENERIC=y
> > CONFIG_TASKS_RCU=y
> > CONFIG_TASKS_RUDE_RCU=y
> > CONFIG_TASKS_TRACE_RCU=y
> > CONFIG_RCU_STALL_COMMON=y
> > CONFIG_RCU_NEED_SEGCBLIST=y
> > # end of RCU Subsystem
> > # RCU Debugging
> > # CONFIG_RCU_SCALE_TEST is not set
> > # CONFIG_RCU_TORTURE_TEST is not set
> > # CONFIG_RCU_REF_SCALE_TEST is not set
> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> > # CONFIG_RCU_TRACE is not set
> > # CONFIG_RCU_EQS_DEBUG is not set
> > # end of RCU Debugging
> >
> > CONFIG_PREEMPT_BUILD=y
> > # CONFIG_PREEMPT_NONE is not set
> > CONFIG_PREEMPT_VOLUNTARY=y
> > # CONFIG_PREEMPT is not set
> > CONFIG_PREEMPT_COUNT=y
> > CONFIG_PREEMPTION=y
> > CONFIG_PREEMPT_DYNAMIC=y
> > CONFIG_PREEMPT_RCU=y
> > CONFIG_HAVE_PREEMPT_DYNAMIC=y
> > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> > CONFIG_PREEMPT_NOTIFIERS=y
> > # CONFIG_DEBUG_PREEMPT is not set
> > # CONFIG_PREEMPT_TRACER is not set
> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> >
> > An interesting observation is that, while tasks RCUs are blocked,
> > related NAPI thread is still being scheduled (even across cores)
> > regularly. Looking at the gp conditions, I am inclining to cond_resched
> > after each __napi_poll being the problem: cond_resched enters the
> > scheduler with PREEMPT bit, which does not account as a gp for tasks
> > RCUs. Meanwhile, since the thread has been frequently resched, the
> > normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> > seems to have very little chance to kick in. Given the nature of "busy
> > polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
> > updated (other gp conditions), the result is that such NAPI thread is
> > put on RCU holdouts list for indefinitely long time.
> >
> > This is simply fixed by mirroring the ksoftirqd behavior: after
> > NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
> > more blocking afterwards for the same setup.
> >
> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/core/dev.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 275fd5259a4a..6e41263ff5d3 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
> >                                 net_rps_action_and_irq_enable(sd);
> >                         }
> >                         skb_defer_free_flush(sd);

Please put a comment here stating that RCU readers cannot cross
this point.

I need to add lockdep to rcu_softirq_qs() to catch placing this in an
RCU read-side critical section.  And a header comment noting that from
an RCU perspective, it acts as a momentary enabling of preemption.

> > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > +                               rcu_softirq_qs();
> > +
> >                         local_bh_enable();
> >
> >                         if (!repoll)
> > --
> > 2.30.2
> >
> 
> Hmm....
> Why napi_busy_loop() does not have a similar problem ?
> 
> It is unclear why rcu_all_qs() in __cond_resched() is guarded by
> 
> #ifndef CONFIG_PREEMPT_RCU
>      rcu_all_qs();
> #endif

The theory is that PREEMPT_RCU kernels have preemption, and get their
quiescent states that way.

The more recent practice involves things like PREEMPT_DYNAMIC and maybe
soon PREEMPT_AUTO, which might require adjustments, so thank you for
pointing this out!

Back on the patch, my main other concern is that someone somewhere might
be using something like synchronize_rcu() to wait for all in-progress
softirq handlers to complete.  But I don't know of such a thing, and if
there is, there are workarounds, including synchronize_rcu_tasks().

So something to be aware of, not (as far as I know) something to block
this commit.

With the added comment:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

