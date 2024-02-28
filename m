Return-Path: <bpf+bounces-22898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863E86B65B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B791F24CF3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2915DBC3;
	Wed, 28 Feb 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1KhMvtx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000C6EF02;
	Wed, 28 Feb 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142469; cv=none; b=CvbMd92Vc7kcldX+VWGATon9/FxCmshAetdvTOg4xhiwcyWDjKRdympdTm8CXEFQ+QM0I/fdL2w8dFCpxujMSm0yqoV/KH7t+AZHsKuPLgisdM4DJRuEnaezC4sef1zth2ZbY4E1OSUqo9pOe2EBeC+k3GJ18ISQrrXDXLOgYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142469; c=relaxed/simple;
	bh=C1UU1WA26ToOkkgIYK5WS3L7oXs4voCYLwz9isVT8+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/QYK9jTMoZOcMCpHgSH3nJkFFn4HFPABxtvh+bl6Nx7Y+yxHC2A30z26hDCOcdg263pSgSLY7iYzLU28TdMxp4yizQVPgHu7SHfN+FXoKEPc4e76q2oo7b3Ar28bPbjase+jrOXFq53ZMe+EW6BR9ViMUjGkyIZItSxB5IMa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1KhMvtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E49C433F1;
	Wed, 28 Feb 2024 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709142468;
	bh=C1UU1WA26ToOkkgIYK5WS3L7oXs4voCYLwz9isVT8+k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=R1KhMvtxM5TlHUYIwZOn+O6bgARaol0xJeSoEJFVnwSxhpbar1jquGj5XVuPFoaPW
	 HKMHlekSlIk02JZumDoY6MJUZbXs7byFDqEE/u80HJTYB5YJqGCVAi8jy01RykgFxy
	 XUy/LqS3EdJWBYaq4tvIfUWKBrI+F0NPKZTB0iuYkPTlQL+/CdG0/9SuzLhzMoR3Ug
	 TnT6zoIZPl1WWejxVB/YlR58dXt0Gh8TRoa5KRWyttsNXKoo4IQFAH+R7EIglfzjbU
	 eKAhiZbmGFdEz/mOgTkJ4JSqSkDRqSJNDGcshvqmHdOfmrBNkBAzDBNPi3BqLXpef7
	 xdy4OAMIHg3Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F228CE0350; Wed, 28 Feb 2024 09:47:48 -0800 (PST)
Date: Wed, 28 Feb 2024 09:47:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
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
Message-ID: <e3140bd7-af1b-42b0-bef4-cf2ca39c08d3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Zd4DXTyCf17lcTfq@debian.debian>
 <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop>
 <87edcwerj6.fsf@toke.dk>
 <6b6ce007-4527-494f-8d03-079f7bf139f9@paulmck-laptop>
 <CAO3-PbpPN0ASFbkgb1J=uBnY=hd6s4CPACRuQtWng_3Apsy_NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PbpPN0ASFbkgb1J=uBnY=hd6s4CPACRuQtWng_3Apsy_NQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 09:48:42AM -0600, Yan Zhai wrote:
> On Wed, Feb 28, 2024 at 9:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 28, 2024 at 12:50:53PM +0100, Toke Høiland-Jørgensen wrote:
> > > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > >
> > > > On Tue, Feb 27, 2024 at 05:44:17PM +0100, Eric Dumazet wrote:
> > > >> On Tue, Feb 27, 2024 at 4:44 PM Yan Zhai <yan@cloudflare.com> wrote:
> > > >> >
> > > >> > We noticed task RCUs being blocked when threaded NAPIs are very busy in
> > > >> > production: detaching any BPF tracing programs, i.e. removing a ftrace
> > > >> > trampoline, will simply block for very long in rcu_tasks_wait_gp. This
> > > >> > ranges from hundreds of seconds to even an hour, severely harming any
> > > >> > observability tools that rely on BPF tracing programs. It can be
> > > >> > easily reproduced locally with following setup:
> > > >> >
> > > >> > ip netns add test1
> > > >> > ip netns add test2
> > > >> >
> > > >> > ip -n test1 link add veth1 type veth peer name veth2 netns test2
> > > >> >
> > > >> > ip -n test1 link set veth1 up
> > > >> > ip -n test1 link set lo up
> > > >> > ip -n test2 link set veth2 up
> > > >> > ip -n test2 link set lo up
> > > >> >
> > > >> > ip -n test1 addr add 192.168.1.2/31 dev veth1
> > > >> > ip -n test1 addr add 1.1.1.1/32 dev lo
> > > >> > ip -n test2 addr add 192.168.1.3/31 dev veth2
> > > >> > ip -n test2 addr add 2.2.2.2/31 dev lo
> > > >> >
> > > >> > ip -n test1 route add default via 192.168.1.3
> > > >> > ip -n test2 route add default via 192.168.1.2
> > > >> >
> > > >> > for i in `seq 10 210`; do
> > > >> >  for j in `seq 10 210`; do
> > > >> >     ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
> > > >> >  done
> > > >> > done
> > > >> >
> > > >> > ip netns exec test2 ethtool -K veth2 gro on
> > > >> > ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
> > > >> > ip netns exec test1 ethtool -K veth1 tso off
> > > >> >
> > > >> > Then run an iperf3 client/server and a bpftrace script can trigger it:
> > > >> >
> > > >> > ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
> > > >> > ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
> > > >> > bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'
> > > >> >
> > > >> > Above reproduce for net-next kernel with following RCU and preempt
> > > >> > configuraitons:
> > > >> >
> > > >> > # RCU Subsystem
> > > >> > CONFIG_TREE_RCU=y
> > > >> > CONFIG_PREEMPT_RCU=y
> > > >> > # CONFIG_RCU_EXPERT is not set
> > > >> > CONFIG_SRCU=y
> > > >> > CONFIG_TREE_SRCU=y
> > > >> > CONFIG_TASKS_RCU_GENERIC=y
> > > >> > CONFIG_TASKS_RCU=y
> > > >> > CONFIG_TASKS_RUDE_RCU=y
> > > >> > CONFIG_TASKS_TRACE_RCU=y
> > > >> > CONFIG_RCU_STALL_COMMON=y
> > > >> > CONFIG_RCU_NEED_SEGCBLIST=y
> > > >> > # end of RCU Subsystem
> > > >> > # RCU Debugging
> > > >> > # CONFIG_RCU_SCALE_TEST is not set
> > > >> > # CONFIG_RCU_TORTURE_TEST is not set
> > > >> > # CONFIG_RCU_REF_SCALE_TEST is not set
> > > >> > CONFIG_RCU_CPU_STALL_TIMEOUT=21
> > > >> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
> > > >> > # CONFIG_RCU_TRACE is not set
> > > >> > # CONFIG_RCU_EQS_DEBUG is not set
> > > >> > # end of RCU Debugging
> > > >> >
> > > >> > CONFIG_PREEMPT_BUILD=y
> > > >> > # CONFIG_PREEMPT_NONE is not set
> > > >> > CONFIG_PREEMPT_VOLUNTARY=y
> > > >> > # CONFIG_PREEMPT is not set
> > > >> > CONFIG_PREEMPT_COUNT=y
> > > >> > CONFIG_PREEMPTION=y
> > > >> > CONFIG_PREEMPT_DYNAMIC=y
> > > >> > CONFIG_PREEMPT_RCU=y
> > > >> > CONFIG_HAVE_PREEMPT_DYNAMIC=y
> > > >> > CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> > > >> > CONFIG_PREEMPT_NOTIFIERS=y
> > > >> > # CONFIG_DEBUG_PREEMPT is not set
> > > >> > # CONFIG_PREEMPT_TRACER is not set
> > > >> > # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> > > >> >
> > > >> > An interesting observation is that, while tasks RCUs are blocked,
> > > >> > related NAPI thread is still being scheduled (even across cores)
> > > >> > regularly. Looking at the gp conditions, I am inclining to cond_resched
> > > >> > after each __napi_poll being the problem: cond_resched enters the
> > > >> > scheduler with PREEMPT bit, which does not account as a gp for tasks
> > > >> > RCUs. Meanwhile, since the thread has been frequently resched, the
> > > >> > normal scheduling point (no PREEMPT bit, accounted as a task RCU gp)
> > > >> > seems to have very little chance to kick in. Given the nature of "busy
> > > >> > polling" program, such NAPI thread won't have task->nvcsw or task->on_rq
> > > >> > updated (other gp conditions), the result is that such NAPI thread is
> > > >> > put on RCU holdouts list for indefinitely long time.
> > > >> >
> > > >> > This is simply fixed by mirroring the ksoftirqd behavior: after
> > > >> > NAPI/softirq work, raise a RCU QS to help expedite the RCU period. No
> > > >> > more blocking afterwards for the same setup.
> > > >> >
> > > >> > Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
> > > >> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > > >> > ---
> > > >> >  net/core/dev.c | 4 ++++
> > > >> >  1 file changed, 4 insertions(+)
> > > >> >
> > > >> > diff --git a/net/core/dev.c b/net/core/dev.c
> > > >> > index 275fd5259a4a..6e41263ff5d3 100644
> > > >> > --- a/net/core/dev.c
> > > >> > +++ b/net/core/dev.c
> > > >> > @@ -6773,6 +6773,10 @@ static int napi_threaded_poll(void *data)
> > > >> >                                 net_rps_action_and_irq_enable(sd);
> > > >> >                         }
> > > >> >                         skb_defer_free_flush(sd);
> > > >
> > > > Please put a comment here stating that RCU readers cannot cross
> > > > this point.
> > > >
> > > > I need to add lockdep to rcu_softirq_qs() to catch placing this in an
> > > > RCU read-side critical section.  And a header comment noting that from
> > > > an RCU perspective, it acts as a momentary enabling of preemption.
> > >
> > > OK, so one question here: for XDP, we're basically treating
> > > local_bh_disable/enable() as the RCU critical section, cf the discussion
> > > we had a few years ago that led to this being documented[0]. So why is
> > > it OK to have the rcu_softirq_qs() inside the bh disable/enable pair,
> > > but not inside an rcu_read_lock() section?
> >
> > In general, it is not OK.  And it is not OK in this case if this happens
> > to be one of the local_bh_disable() regions that XDP is waiting on.
> > Except that that region ends right after the rcu_softirq_qs(), so that
> > should not be a problem.
> >
> > But you are quite right, that is an accident waiting to happen, so it
> > would be better if the patch did something like this:
> >
> >         local_bh_enable();
> >         if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >                 preempt_disable();
> >                 rcu_softirq_qs();
> >                 preempt_enable();
> >         }
> >
> Yeah we need preempt for this call. When I first attempt it after
> local_bh_enable, I got the bug call:
> [ 1166.384279] BUG: using __this_cpu_read() in preemptible [00000000]
> code: napi/veth2-66/8439
> [ 1166.385337] caller is rcu_softirq_qs+0x16/0x130
> [ 1166.385900] CPU: 3 PID: 8439 Comm: napi/veth2-66 Not tainted
> 6.7.0-rc8-g3fbf61207c66-dirty #75
> [ 1166.386950] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 1166.388110] Call Trace:
> [ 1166.388417]  <TASK>
> [ 1166.388684]  dump_stack_lvl+0x36/0x50
> [ 1166.389147]  check_preemption_disabled+0xd1/0xe0
> [ 1166.389725]  rcu_softirq_qs+0x16/0x130
> [ 1166.390190]  napi_threaded_poll+0x21e/0x260
> [ 1166.390702]  ? __pfx_napi_threaded_poll+0x10/0x10
> [ 1166.391277]  kthread+0xf7/0x130
> [ 1166.391643]  ? __pfx_kthread+0x10/0x10
> [ 1166.392130]  ret_from_fork+0x34/0x50
> [ 1166.392574]  ? __pfx_kthread+0x10/0x10
> [ 1166.393048]  ret_from_fork_asm+0x1b/0x30
> [ 1166.393530]  </TASK>
> 
> Since this patch is trying to mirror what __do_softirq has, should the
> similar notes/changes apply to that side as well?

Up to now, the rcu_softirq_qs() was a special function strictly for
use by __do_softirq(), hence the lack of documentation.  I will let
the __do_softirq() maintainers decide what they would like to do there,
if anything.

							Thanx, Paul

> > Though maybe something like this would be better:
> >
> >         local_bh_enable();
> >         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 rcu_softirq_qs_enable(local_bh_enable());
> >         else
> >                 local_bh_enable();
> >
> > A bit ugly, but it does allow exact checking of the rules and also
> > avoids extra overhead.
> >
> > I could imagine pulling the CONFIG_PREEMPT_RT check into the body of
> > rcu_softirq_qs_enable().
> >
> > But is there a better way?
> >
> > > Also, looking at the patch in question:
> > >
> > > >> > +                       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > >> > +                               rcu_softirq_qs();
> > > >> > +
> > > >> >                         local_bh_enable();
> > >
> > > Why does that local_bh_enable() not accomplish the same thing as the qs?
> >
> > In this case, because it does not create the appearance of a voluntary
> > context switch needed by RCU Tasks.  So the wait for trampoline evacuation
> > could still take a very long time.
> >
> >                                                         Thanx, Paul
> >
> > > -Toke
> > >
> > > [0] https://lore.kernel.org/bpf/20210624160609.292325-6-toke@redhat.com/
> > >

