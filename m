Return-Path: <bpf+bounces-2126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622327284B5
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BB281735
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C42174C9;
	Thu,  8 Jun 2023 16:18:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49C3B407
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5DBC433EF;
	Thu,  8 Jun 2023 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686241093;
	bh=wmn/uf1eypGl3f00SXifgpgrsDt/jmo8F0BNQ/mNT7c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iVY36iFhYSnIu6Bw8v7rQLdYnAFN0vOvzCcGFWiM5AyPjDMV6d5wRfsqKsqJZvriI
	 Khe2aP1AEVQ9uYEfPnJ5lnLl3tpagFcDh3KuqUlEZ4JqIRl2k2W+JOAI9ncLX/jCsg
	 hszQqT17Zg7ObT9EM7jevC5REiAM68CQ5+/pF8PWDHGrWD+gorjBJiinL1gTXtK0yo
	 FyDryXFoIkr04rJj8Tm/1zbn9rsGrGGYPc7NfmT7IJvblCYPqY5/hpIC9ICls3/kBL
	 pyubl6WHLSc4c6D17ICQxGOGkNbNXY+zauhsoxGApe+oT5z6+GZy57dti+uvaW0xJ9
	 ra6Krx9UPgBNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D219ECE14DD; Thu,  8 Jun 2023 09:18:12 -0700 (PDT)
Date: Thu, 8 Jun 2023 09:18:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
Message-ID: <d5c9bedb-29ea-456d-b66a-d556f781e656@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <1441a69a-a015-8e3c-4c14-a6af767849e3@huaweicloud.com>
 <1154ba5a-49b2-45c4-8b88-60f1abed6cbf@paulmck-laptop>
 <f4418d9d-857b-eb96-cbec-ab1652291556@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4418d9d-857b-eb96-cbec-ab1652291556@huaweicloud.com>

On Thu, Jun 08, 2023 at 11:43:54AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> On 6/8/2023 10:55 AM, Paul E. McKenney wrote:
> > On Thu, Jun 08, 2023 at 09:51:27AM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/8/2023 4:50 AM, Alexei Starovoitov wrote:
> >>> On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> >>>>> As said in the commit message, the command line for test is
> >>>>> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
> >>>>> using default max_entries and the number of CPUs is greater than 15,
> >>>>> use_percpu_counter will be false.
> >>>> Right. percpu or not depends on number of cpus.
> SNIP
> >>>>  known, because I had just proposed it in the email yesterday.
> >>> Also noticed that the overhead of shared reuse_ready list
> >>> comes both from the contended lock and from cache misses
> >>> when one cpu pushes to the list after RCU GP and another
> >>> cpu removes.
> >>>
> >>> Also low/batch/high watermark are all wrong in patch 3.
> >>> low=32 and high=96 makes no sense when it's not a single list.
> >>> I'm experimenting with 32 for all three heuristics.
> >>>
> >>> Another thing I noticed that per-cpu prepare_reuse and free_by_rcu
> >>> are redundant.
> >>> unit_free() can push into free_by_rcu directly
> >>> then reuse_bulk() can fill it up with free_llist_extra and
> >>> move them into waiting_for_gp.
> >> Yes. Indeed missing that.
> >>> All these _tail optimizations are obscuring the code and make it hard
> >>> to notice these issues.
> >>>
> >>>> For now I still prefer to see v5 with per-bpf-ma and no _tail optimization.
> >>>>
> >>>> Answering your other email:
> >>>>
> >>>>> I see your point. I will continue to debug the memory usage difference
> >>>>> between v3 and v4.
> >>>> imo it's a waste of time to continue analyzing performance based on bench in patch 2.
> >> Don't agree with that. I still think the potential memory usage of v4 is
> >> a problem and the difference memory usage between v3 and v4 reveals that
> >> there is some peculiarity in RCU subsystem, because the difference comes
> >> from the duration of RCU grace period. We need to find out why and fix
> >> or workaround that.
> > A tight loop in the kernel can extend RCU grace periods, especially
> > for kernels built with CONFIG_PREEPTION=n.  Placing things like
> > cond_resched() in such loops can help.  Of course, if you are in an
> > RCU read-side critical section (or holding a spinlock), you will need
> > to exit, cond_resched(), then re-enter.  Taking care to ensure that the
> > state upon re-entry is valid.  After all, having exited either type of
> > critical section, anything might happen.
> 
> As said in the help-wanted email just send out, it was weird that the
> RCU grace period was extended a lot, up to ~150ms or more. But queue a
> dummy kworker periodically which does nothing will help to reduce the
> grace period to ~10ms. I have explained the context of the problem in
> that email. And hope that we could get some help from you and the RCU
> experts in the community.

OK, I will bite...  Why do you think this is weird?

RCU depends on context switches, among other things.  If you have a
long-running in-kernel task, that will naturally extend the grace period.
Scheduling the empty worker provided the context switch that RCU needed
to make forward progress.

So 150 milliseconds is an OK RCU grace period.  A bit long, but not
excessively so.  In contrast, by default in mainline, RCU starts seriously
complaining if its grace period is extended beyond 21 *seconds*.  This is
when the RCU CPU stall warning will appear.  (Yes, some Android configs
are tuning this down to 20 milliseconds, but that is a special hardware
and software configuration.)

But if you want shorter RCU grace periods, what can you do?

1.	Follow Alexei's good advice on one of your early patches.

2.	As an alternative to scheduling an empty kworker, invoke something
	like rcu_momentary_dyntick_idle() periodically.  Note well that
	it is illegal to invoke this in an RCU read-side critical section,
	with preemption disabled, from idle, ...

3.	In non-preemptible kernels, cond_resched() is a much lighter
	weight alternative to rcu_momentary_dyntick_idle().  (Preemptible
	kernels get the same effect by preempting.  In your case, this
	is also true, but it takes 150 milliseconds.)

That should do for a start.  ;-)

							Thanx, Paul

> Regards,
> Tao
> >
> > 							Thanx, Paul
> >
> >>>>> I don't think so. Let's considering the per-cpu list first. Assume the
> >>>>> normal RCU grace period is about 30ms and we are tracing the IO latency
> >>>>> of a normal SSD. The iops is about 176K per seconds, so before one RCU
> >>>>> GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
> >>>>> For the per-ma list, when the number of CPUs increased, it is easy to
> >>>>> make the list contain thousands of elements.
> >>>> That would be true only if there were no scheduling events in all of 176K ops.
> >>>> Which is not the case.
> >>>> I'm not sure why you're saying that RCU GP is 30ms.
> >> Because these freed elements will be freed after one RCU GP and in v4
> >> there is only one RCU callback per-cpu, so before one RCU GP is expired,
> >> these freed elements will be accumulated on the list.
> >>>> In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
> >>>> Every sched event is sort-of implicit rcu_read_lock/unlock.
> >>>> Network and block IO doesn't process 176K packets without resched.
> >>>> Don't know how block does it, but in networking NAPI will process 64 packets and will yield softirq.
> >>>>
> >>>> For small size buckets low_watermark=32 and high=96.
> >>>> We typically move 32 elements at a time from one list to another.
> >>>> A bunch of elements maybe sitting in free_by_rcu and moving them to waiting_for_gp
> >>>> is not instant, but once __free_rcu_tasks_trace is called we need to take
> >>>> elements from waiting_for_gp one at a time and kfree it one at a time.
> >>>> So optimizing the move from free_by_rcu into waiting_for_gp is not worth the code complexity.
> >>>>
> >>>>> Before I post v5, I want to know the reason why per-bpf-ma list is
> >>>>> introduced. Previously, I though it was used to handle the case in which
> >>>>> allocation and freeing are done on different CPUs.
> >>>> Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_tasks_trace GP.
> >>>>
> >>>>> And as we can see
> >>>>> from the benchmark result above and in v3, the performance and the
> >>>>> memory usage of v4 for add_del_on_diff_cpu is better than v3.
> >>>> bench from patch 2 is invalid. Hence no conclusion can be made.
> >>>>
> >>>> So far the only bench we can trust and analyze is map_perf_test.
> >>>> Please make bench in patch 2 yield the cpu after few updates.
> >>>> Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
> >>>> 64 updates is realistic too. A thousand is not.
> >> Will do that.
> >>
> 

