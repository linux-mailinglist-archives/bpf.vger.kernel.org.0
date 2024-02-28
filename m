Return-Path: <bpf+bounces-22880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6D86B2C9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072B31C258CA
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D7612FC;
	Wed, 28 Feb 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edbW8c2/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F515B11F;
	Wed, 28 Feb 2024 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133022; cv=none; b=dqtaZtyK0xEoCsb+4bD4n+jrWWnNe5VZb6NMYUbcD7832b9B3K47cQzyOClR34/zDdFRRiG2qiQoS+bPdwiEW9jAhU4t9cVv2LCMAOQW1snHPXTbwaBgcAorHDSgAtXYqaaIW2+TPZUuGk87k19VfxkGyMvf37s2tVl5I5SAdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133022; c=relaxed/simple;
	bh=yHXpHOkP8gdcH0+vIBwlbMHemDD2qgwTO9TVUeA0dOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVA3C9xwAsfTRK4p4ms9GmyhTdKNwRGWh5yIby2z7VbuYnQ3Rksn848wkMJiRgJ/tmhKhbKYv1bykqdmJuBFJ6CJRmuILgiDGZhaZ2obPluf8Hwt5dhGIzVz/lDJx0wDL1sXAxIx4RO+jXhP8uIuktOCIo055kEQff9F53amb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edbW8c2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8AFC433C7;
	Wed, 28 Feb 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133021;
	bh=yHXpHOkP8gdcH0+vIBwlbMHemDD2qgwTO9TVUeA0dOE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=edbW8c2/Uo8SM/jstFNdf1DstEWigu8gsJ9b58KetD44ECFpiAnZVHsnHctZpMw/E
	 irxaovvFgoqpe7F7Zvh/FZYDT0ac47weDeduGVPvXSxBFLEtbMNoa7arrt3ZxeXp6N
	 f2gJgQMqY3S3OffO8wkKBj6oLyKjf2C9h+R2go0kzoqWMHtr1xBxtv45km4IaFvo2R
	 /II7+TbrD4JwxM4KStccBKViNNG+O6JolBhXmB6e8kJN8yDMl9hFS4wNzWmdXjTbTF
	 3sMfIBjZB48m3R1PPJdnDxnLysBCYiNxx9sf56Il2gx1tkv6yLmRA50u46oBp/zx/G
	 UTXNPfs/SvtRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3DD33CE074C; Wed, 28 Feb 2024 07:10:21 -0800 (PST)
Date: Wed, 28 Feb 2024 07:10:21 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Yan Zhai <yan@cloudflare.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <6b6ce007-4527-494f-8d03-079f7bf139f9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <87edcwerj6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edcwerj6.fsf@toke.dk>

On Wed, Feb 28, 2024 at 12:50:53PM +0100, Toke Høiland-Jørgensen wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
> >> On Tue, Feb 27, 2024 at 4:44 PM Yan Zhai <yan@cloudflare.com> wrote:
> >> >
> >> > We noticed task RCUs being blocked when threaded NAPIs are very busy in
> >> > production: detaching any BPF tracing programs, i.e. removing a ftrace
> >> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> >> > ranges from hundreds of seconds to even an hour, severely harming any
> >> > observability tools that rely on BPF tracing programs. It can be
> >> > easily reproduced locally with following setup:
> >> >
> >> > ip netns add test1
> >> > ip netns add test2
> >> >
> >> > ip -n test1 link add veth1 type veth peer name veth2 netns test2
> >> >
> >> > ip -n test1 link set veth1 up
> >> > ip -n test1 link set lo up
> >> > ip -n test2 link set veth2 up
> >> > ip -n test2 link set lo up
> >> >
> >> > ip -n test1 addr add 192.168.1.2/31 dev veth1
> >> > ip -n test1 addr add 1.1.1.1/32 dev lo
> >> > ip -n test2 addr add 192.168.1.3/31 dev veth2
> >> > ip -n test2 addr add 2.2.2.2/31 dev lo
> >> >
> >> > ip -n test1 route add default via 192.168.1.3
> >> > ip -n test2 route add default via 192.168.1.2
> >> >
> >> > for i in `seq 10 210`; do
> >> >  for j in `seq 10 210`; do
> >> >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
> >> >  done
> >> > done
> >> >
> >> > ip netns exec test2 ethtool -K veth2 gro on
> >> > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> >> > ip netns exec test1 ethtool -K veth1 tso off
> >> >
> >> > Then run an iperf3 client/server and a bpftrace script can trigger it:
> >> >
> >> > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> >> > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
> >> > bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'
> >> >
> >> > Above reproduce for net-next kernel with following RCU and preempt
> >> > configuraitons:
> >> >
> >> > # RCU Subsystem
> >> > CONFIG_TREE_RCU=y
> >> > CONFIG_PREEMPT_RCU=y
> >> > # CONFIG_RCU_EXPERT is not set
> >> > CONFIG_SRCU=y
> >> > CONFIG_TREE_SRCU=y
> >> > CONFIG_TASKS_RCU_GENERIC=y
> >> > CONFIG_TASKS_RCU=y
> >> > CONFIG_TASKS_RUDE_RCU=y
> >> > CONFIG_TASKS_TRACE_RCU=y
> >> > CONFIG_RCU_STALL_COMMON=y
> >> > CONFIG_RCU_NEED_SEGCBLIST=y
> >> > # end of RCU Subsystem
> >> > # RCU Debugging
> >> > # CONFIG_RCU_SCALE_TEST is not set
> >> > # CONFIG_RCU_TORTURE_TEST is not set
> >> > # CONFIG_RCU_REF_SCALE_TEST is not set
> >> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> >> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> >> > # CONFIG_RCU_TRACE is not set
> >> > # CONFIG_RCU_EQS_DEBUG is not set
> >> > # end of RCU Debugging
> >> >
> >> > CONFIG_PREEMPT_BUILD=y
> >> > # CONFIG_PREEMPT_NONE is not set
> >> > CONFIG_PREEMPT_VOLUNTARY=y
> >> > # CONFIG_PREEMPT is not set
> >> > CONFIG_PREEMPT_COUNT=y
> >> > CONFIG_PREEMPTION=y
> >> > CONFIG_PREEMPT_DYNAMIC=y
> >> > CONFIG_PREEMPT_RCU=y
> >> > CONFIG_HAVE_PREEMPT_DYNAMIC=y
> >> > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> >> > CONFIG_PREEMPT_NOTIFIERS=y
> >> > # CONFIG_DEBUG_PREEMPT is not set
> >> > # CONFIG_PREEMPT_TRACER is not set
> >> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> >> >
> >> > An interesting observation is that, while tasks RCUs are blocked,
> >> > related NAPI thread is still being scheduled (even across cores)
> >> > regularly. Looking at the gp conditions, I am inclining to cond_resched
> >> > after each __napi_poll being the problem: cond_resched enters the
> >> > scheduler with PREEMPT bit, which does not account as a gp for tasks
> >> > RCUs. Meanwhile, since the thread has been frequently resched, the
> >> > normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> >> > seems to have very little chance to kick in. Given the nature of "busy
> >> > polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
> >> > updated (other gp conditions), the result is that such NAPI thread is
> >> > put on RCU holdouts list for indefinitely long time.
> >> >
> >> > This is simply fixed by mirroring the ksoftirqd behavior: after
> >> > NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
> >> > more blocking afterwards for the same setup.
> >> >
> >> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
> >> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >> > ---
> >> >  net/core/dev.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/net/core/dev.c b/net/core/dev.c
> >> > index 275fd5259a4a..6e41263ff5d3 100644
> >> > --- a/net/core/dev.c
> >> > +++ b/net/core/dev.c
> >> > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
> >> >                                 net_rps_action_and_irq_enable(sd);
> >> >                         }
> >> >                         skb_defer_free_flush(sd);
> >
> > Please put a comment here stating that RCU readers cannot cross
> > this point.
> >
> > I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> > RCU read-side critical section.  And a header comment noting that from
> > an RCU perspective, it acts as a momentary enabling of preemption.
> 
> OK, so one question here: for XDP, we're basically treating
> local_bh_disable/enable() as the RCU critical section, cf the discussion
> we had a few years ago that led to this being documented[0]. So why is
> it OK to have the rcu_softirq_qs() inside the bh disable/enable pair,
> but not inside an rcu_read_lock() section?

In general, it is not OK.  And it is not OK in this case if this happens
to be one of the local_bh_disable() regions that XDP is waiting on.
Except that that region ends right after the rcu_softirq_qs(), so that
should not be a problem.

But you are quite right, that is an accident waiting to happen, so it
would be better if the patch did something like this:

	local_bh_enable();
	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
		preempt_disable();
		rcu_softirq_qs();
		preempt_enable();
	}

Though maybe something like this would be better:

	local_bh_enable();
	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
		rcu_softirq_qs_enable(local_bh_enable());
	else
		local_bh_enable();

A bit ugly, but it does allow exact checking of the rules and also
avoids extra overhead.

I could imagine pulling the CONFIG_PREEMPT_RT check into the body of
rcu_softirq_qs_enable().

But is there a better way?

> Also, looking at the patch in question:
> 
> >> > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >> > +                               rcu_softirq_qs();
> >> > +
> >> >                         local_bh_enable();
> 
> Why does that local_bh_enable() not accomplish the same thing as the qs?

In this case, because it does not create the appearance of a voluntary
context switch needed by RCU Tasks.  So the wait for trampoline evacuation
could still take a very long time.

							Thanx, Paul

> -Toke
> 
> [0] https://lore.kernel.org/bpf/20210624160609.292325-6-toke@redhat.com/
> 

