Return-Path: <bpf+bounces-2360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723C72B626
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 05:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA802810BD
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239E1FAA;
	Mon, 12 Jun 2023 03:40:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7017CE
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 03:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C3AC433D2;
	Mon, 12 Jun 2023 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686541239;
	bh=x+iFfXONNiKqN/nLOpTWHe1KReGVZ47KW9yk4DmAf4E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XFqStrZxLQcMzo/KWfYiGnLdIWPZTAtGThX+zuV72XITZi+HzgNLZAnDHvk3P4dCc
	 3NbRyTEaLu8krMIwJjTGOxpew5jw4YKSkCtG3TzrrjCj6EU5Oiy25YI01gX5ziYBA4
	 9oBzONmOgpB3ef3BIEdsnKUPBOJrTVH+9Ed4IxGFjjnUS5a+CMDP1U+fE+samH2P0P
	 nGdejoTFAxnOS7amQHYa05mall1ef2LHC25mJzVEEzrn7O1i03NE72+r/sYA5IUom0
	 BD6ZugRwlTFWQnjyDUEPatHXltyKbVl6nFii00s+4OPCJAabMrQIiSJpWo5ZQeuB4X
	 3DouRlNxYjCXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54A62CE3A1E; Sun, 11 Jun 2023 20:40:39 -0700 (PDT)
Date: Sun, 11 Jun 2023 20:40:39 -0700
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
Message-ID: <c9cdac7c-81e8-4f19-8a6a-e0f79221533d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <1441a69a-a015-8e3c-4c14-a6af767849e3@huaweicloud.com>
 <1154ba5a-49b2-45c4-8b88-60f1abed6cbf@paulmck-laptop>
 <f4418d9d-857b-eb96-cbec-ab1652291556@huaweicloud.com>
 <d5c9bedb-29ea-456d-b66a-d556f781e656@paulmck-laptop>
 <58572036-cb29-340e-fe62-d9091304bf0c@huaweicloud.com>
 <5bcd9ed9-0811-4f14-b86c-2f84ec8c7066@paulmck-laptop>
 <1adc2744-2c8b-7e24-f360-f02f3cd07e9e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1adc2744-2c8b-7e24-f360-f02f3cd07e9e@huaweicloud.com>

On Mon, Jun 12, 2023 at 10:03:15AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> On 6/9/2023 10:30 PM, Paul E. McKenney wrote:
> > On Fri, Jun 09, 2023 at 11:02:59AM +0800, Hou Tao wrote:
> >> Hi Paul,
> >>
> >> On 6/9/2023 12:18 AM, Paul E. McKenney wrote:
> >>> On Thu, Jun 08, 2023 at 11:43:54AM +0800, Hou Tao wrote:
> >>>> Hi Paul,
> >>>>
> >>>> On 6/8/2023 10:55 AM, Paul E. McKenney wrote:
> >>>>> On Thu, Jun 08, 2023 at 09:51:27AM +0800, Hou Tao wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On 6/8/2023 4:50 AM, Alexei Starovoitov wrote:
> >>>>>>> On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
> >>>>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>>> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> >>>>>>>>> As said in the commit message, the command line for test is
> >>>>>>>>> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
> >>>>>>>>> using default max_entries and the number of CPUs is greater than 15,
> >>>>>>>>> use_percpu_counter will be false.
> >>>>>>>> Right. percpu or not depends on number of cpus.
> >>>> SNIP
> >>>>>>>>  known, because I had just proposed it in the email yesterday.
> >>>>>>> Also noticed that the overhead of shared reuse_ready list
> >>>>>>> comes both from the contended lock and from cache misses
> >>>>>>> when one cpu pushes to the list after RCU GP and another
> >>>>>>> cpu removes.
> >>>>>>>
> >>>>>>> Also low/batch/high watermark are all wrong in patch 3.
> >>>>>>> low=32 and high=96 makes no sense when it's not a single list.
> >>>>>>> I'm experimenting with 32 for all three heuristics.
> >>>>>>>
> >>>>>>> Another thing I noticed that per-cpu prepare_reuse and free_by_rcu
> >>>>>>> are redundant.
> >>>>>>> unit_free() can push into free_by_rcu directly
> >>>>>>> then reuse_bulk() can fill it up with free_llist_extra and
> >>>>>>> move them into waiting_for_gp.
> >>>>>> Yes. Indeed missing that.
> >>>>>>> All these _tail optimizations are obscuring the code and make it hard
> >>>>>>> to notice these issues.
> >>>>>>>
> >>>>>>>> For now I still prefer to see v5 with per-bpf-ma and no _tail optimization.
> >>>>>>>>
> >>>>>>>> Answering your other email:
> >>>>>>>>
> >>>>>>>>> I see your point. I will continue to debug the memory usage difference
> >>>>>>>>> between v3 and v4.
> >>>>>>>> imo it's a waste of time to continue analyzing performance based on bench in patch 2.
> >>>>>> Don't agree with that. I still think the potential memory usage of v4 is
> >>>>>> a problem and the difference memory usage between v3 and v4 reveals that
> >>>>>> there is some peculiarity in RCU subsystem, because the difference comes
> >>>>>> from the duration of RCU grace period. We need to find out why and fix
> >>>>>> or workaround that.
> >>>>> A tight loop in the kernel can extend RCU grace periods, especially
> >>>>> for kernels built with CONFIG_PREEPTION=n.  Placing things like
> >>>>> cond_resched() in such loops can help.  Of course, if you are in an
> >>>>> RCU read-side critical section (or holding a spinlock), you will need
> >>>>> to exit, cond_resched(), then re-enter.  Taking care to ensure that the
> >>>>> state upon re-entry is valid.  After all, having exited either type of
> >>>>> critical section, anything might happen.
> >>>> As said in the help-wanted email just send out, it was weird that the
> >>>> RCU grace period was extended a lot, up to ~150ms or more. But queue a
> >>>> dummy kworker periodically which does nothing will help to reduce the
> >>>> grace period to ~10ms. I have explained the context of the problem in
> >>>> that email. And hope that we could get some help from you and the RCU
> >>>> experts in the community.
> >>> OK, I will bite...  Why do you think this is weird?
> >>>
> >>> RCU depends on context switches, among other things.  If you have a
> >>> long-running in-kernel task, that will naturally extend the grace period.
> >>> Scheduling the empty worker provided the context switch that RCU needed
> >>> to make forward progress.
> >> Because the empty kwork trick also works for CONFIG_PREEMPT_VOLUNTARY=y.
> >> And there is neither implicit or explicit calling of schedule() in the
> >> kernel space of producer thread when CONFIG_PREEMPT_VOLUNTARY=y.
> >> And also I don't know how to define a long-running in-kernel task,
> >> because I have checked the latency of getpgid() syscall in producer
> >> thread when CONFIG_PREEMPT_VOLUNTARY=y . As shown in the text below,
> >> there are indeed some outliers, but the most latency is less than 1ms,
> >> so the producer thread will do contex_switch in at most 1ms. But before
> >> the empty kwork trick, the latency of RCU callback is about 100ms or
> >> more, and after the empty kwork trick, the latenct for RCU callback is
> >> reduced to ~8ms.
> >>
> >> @hist_us:
> >> [128, 256)            60
> >> |                                                    |
> >> [256, 512)        101364
> >> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >> [512, 1K)          17580
> >> |@@@@@@@@@                                           |
> >> [1K, 2K)              16
> >> |                                                    |
> >>
> >> @stat_us: count 119020, average 436, total 51957277
> > Ah!
> >
> > The trick is that if you have a non-nohz_full CPU spending most of its
> > time in kernel space (in your case, due to repeated system calls), with
> > high probability this CPU will appear to RCU as if it were spending all
> > of its time in kernel space.  This probability will increase with the
> > fraction of the time this CPU spends in kernel space.
> >
> > If I am reading your histogram correctly, the overhead of your system
> > call is usually etween 256 and 512 microseconds.  If you are invoking
> > that system call in a tight loop, that CPU might could easily be spending
> > way more than 99% of its time in the kernel.  Unless you have similar
> > statistics for the average lenght of your CPU's times in userspace,
> > let's assume exactly 99%.
> >
> > On a non-nohz_full CPU, RCU's only hint that a CPU is executing in
> > userspace occurs when the once-per-jiffy scheduling-clock interrupt
> > is taken from userspace.  If the CPU is spending 99% of its time in
> > the kernel, we can expect only one in 100 interrupts being taken from
> > userspace.  On a HZ=1000 system, that will give you 100 milliseconds
> > right there.
> 
> Thanks for the detailed explanation. It seemed my previous understanding
> of RCU was wrong. My original though was that when one syscall returns
> from the kernel space, the process which does the syscall will be
> considered as being in quiescent state and an RCU grace period will be
> expired soon.

On a nohz_full CPU, that does in fact happen, courtesy of the
context-tracking code's ct_user_enter() and ct_user_exit() functions.

So your understanding was not entirely wrong.

But context tracking adds overhead, so it is not enabled on kernels
not requiring it.  Such kernels run certain types of HPC and/or
real-time workloads.  On other kernels, there is no context tracking
for user/kernel transitions, which (as discussed above) forces RCU to
rely on the scheduling clock interrupt, with the resulting grace-period
delays.

							Thanx, Paul

> > But it gets worse.  The variance is quite large.  For example, for a
> > given grace period, there is about a 5% chance that the delay will be
> > 300 milliseconds instead of the expected 100 milliseconds.  (You can
> > easily check this by taking 0.99 to the 300th power.  Or whatever other
> > power you desire.)
> >
> > So the problem is that simple statistics is biting pretty hard here.
> >
> > As you may have noticed, life is like that sometimes.  ;-)
> >
> > 							Thanx, Paul
> >
> >>> So 150 milliseconds is an OK RCU grace period.  A bit long, but not
> >>> excessively so.  In contrast, by default in mainline, RCU starts seriously
> >>> complaining if its grace period is extended beyond 21 *seconds*.  This is
> >>> when the RCU CPU stall warning will appear.  (Yes, some Android configs
> >>> are tuning this down to 20 milliseconds, but that is a special hardware
> >>> and software configuration.)
> >>>
> >>> But if you want shorter RCU grace periods, what can you do?
> >>>
> >>> 1.	Follow Alexei's good advice on one of your early patches.
> >>>
> >>> 2.	As an alternative to scheduling an empty kworker, invoke something
> >>> 	like rcu_momentary_dyntick_idle() periodically.  Note well that
> >>> 	it is illegal to invoke this in an RCU read-side critical section,
> >>> 	with preemption disabled, from idle, ...
> >>>
> >>> 3.	In non-preemptible kernels, cond_resched() is a much lighter
> >>> 	weight alternative to rcu_momentary_dyntick_idle().  (Preemptible
> >>> 	kernels get the same effect by preempting.  In your case, this
> >>> 	is also true, but it takes 150 milliseconds.)
> >>>
> >>> That should do for a start.  ;-)
> >>>
> >>> 							Thanx, Paul
> >>>
> >>>> Regards,
> >>>> Tao
> >>>>> 							Thanx, Paul
> >>>>>
> >>>>>>>>> I don't think so. Let's considering the per-cpu list first. Assume the
> >>>>>>>>> normal RCU grace period is about 30ms and we are tracing the IO latency
> >>>>>>>>> of a normal SSD. The iops is about 176K per seconds, so before one RCU
> >>>>>>>>> GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
> >>>>>>>>> For the per-ma list, when the number of CPUs increased, it is easy to
> >>>>>>>>> make the list contain thousands of elements.
> >>>>>>>> That would be true only if there were no scheduling events in all of 176K ops.
> >>>>>>>> Which is not the case.
> >>>>>>>> I'm not sure why you're saying that RCU GP is 30ms.
> >>>>>> Because these freed elements will be freed after one RCU GP and in v4
> >>>>>> there is only one RCU callback per-cpu, so before one RCU GP is expired,
> >>>>>> these freed elements will be accumulated on the list.
> >>>>>>>> In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
> >>>>>>>> Every sched event is sort-of implicit rcu_read_lock/unlock.
> >>>>>>>> Network and block IO doesn't process 176K packets without resched.
> >>>>>>>> Don't know how block does it, but in networking NAPI will process 64 packets and will yield softirq.
> >>>>>>>>
> >>>>>>>> For small size buckets low_watermark=32 and high=96.
> >>>>>>>> We typically move 32 elements at a time from one list to another.
> >>>>>>>> A bunch of elements maybe sitting in free_by_rcu and moving them to waiting_for_gp
> >>>>>>>> is not instant, but once __free_rcu_tasks_trace is called we need to take
> >>>>>>>> elements from waiting_for_gp one at a time and kfree it one at a time.
> >>>>>>>> So optimizing the move from free_by_rcu into waiting_for_gp is not worth the code complexity.
> >>>>>>>>
> >>>>>>>>> Before I post v5, I want to know the reason why per-bpf-ma list is
> >>>>>>>>> introduced. Previously, I though it was used to handle the case in which
> >>>>>>>>> allocation and freeing are done on different CPUs.
> >>>>>>>> Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_tasks_trace GP.
> >>>>>>>>
> >>>>>>>>> And as we can see
> >>>>>>>>> from the benchmark result above and in v3, the performance and the
> >>>>>>>>> memory usage of v4 for add_del_on_diff_cpu is better than v3.
> >>>>>>>> bench from patch 2 is invalid. Hence no conclusion can be made.
> >>>>>>>>
> >>>>>>>> So far the only bench we can trust and analyze is map_perf_test.
> >>>>>>>> Please make bench in patch 2 yield the cpu after few updates.
> >>>>>>>> Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
> >>>>>>>> 64 updates is realistic too. A thousand is not.
> >>>>>> Will do that.
> >>>>>>
> >>> .
> 

