Return-Path: <bpf+bounces-2084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BE72754F
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 04:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5313C1C20F8B
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 02:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB71116;
	Thu,  8 Jun 2023 02:55:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C1A29
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 02:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB12DC433D2;
	Thu,  8 Jun 2023 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686192900;
	bh=kYKpg/dIghj3Epm3BB7q4NH0f0w8UUC6Oqc7xkEq4nM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AzUYBeUL3xBz++ZvshdqvZk6Hf37XtMyPBCHr0SLn7M6Qqw/iUauZrIciCG05AyJv
	 WyrUx7pqZ2HpedQJUGeTaBGc5PP3NfCaUvkVQm3M/9wd0qJNPI3hGWlqk41LdcWP44
	 fcIvSOittM2qajSGRwhjaVucaEGHS6o//keXOO5gGP59Bw3Qvs2dHL/8j2m5rljY8E
	 QZXSeV3vabUqQKbipvod3UoPWn+k1cuw9dv29Nrejqtjrfnl+wbAsMrL06u+EAYfuf
	 1UBhJ/r1lZxvjI2C7XxuDwWGlFvYjwIkMl8HAB03dMimtWtZeh7Y+L+w0nJbSwxizz
	 FnxyTvL7aFXQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4EF4BCE3A6C; Wed,  7 Jun 2023 19:55:00 -0700 (PDT)
Date: Wed, 7 Jun 2023 19:55:00 -0700
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
Message-ID: <1154ba5a-49b2-45c4-8b88-60f1abed6cbf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <1441a69a-a015-8e3c-4c14-a6af767849e3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1441a69a-a015-8e3c-4c14-a6af767849e3@huaweicloud.com>

On Thu, Jun 08, 2023 at 09:51:27AM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/8/2023 4:50 AM, Alexei Starovoitov wrote:
> > On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> >>> As said in the commit message, the command line for test is
> >>> "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
> >>> using default max_entries and the number of CPUs is greater than 15,
> >>> use_percpu_counter will be false.
> >> Right. percpu or not depends on number of cpus.
> >>
> >>> I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
> >>> test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
> >>> there are obvious performance degradation.
> >> ...
> >>> [root@hello bpf]# ./map_perf_test 4 8 16384
> >>> 2:hash_map_perf kmalloc 359201 events per sec
> >> ..
> >>> [root@hello bpf]# ./map_perf_test 4 8 16384
> >>> 4:hash_map_perf kmalloc 203983 events per sec
> >> this is indeed a degration in a VM.
> >>
> >>> I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
> >>> performances for "./map_perf_test 4 8" are similar, but there is obvious
> >>> performance degradation for "./map_perf_test 4 8 16384"
> >> but... a degradation?
> Er, My bad. I miss-labeled "Before" and "After". v4 indeed introduces
> big performance degradation in physical host.
> >>
> >>> Before reuse-after-rcu-gp:
> >>>
> >>> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> >>> 1:hash_map_perf kmalloc 388088 events per sec
> >> ...
> >>> After reuse-after-rcu-gp:
> >>> [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> >>> 5:hash_map_perf kmalloc 655628 events per sec
> >> This is a big improvement :) Not a degration.
> >> You always have to double check the numbers with perf report.
> >>
> >>> So could you please double check your setup and rerun map_perf_test ? If
> >>> there is no performance degradation, could you please share your setup
> >>> and your kernel configure file ?
> >> I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=1000
> >> Playing with it a bit more I found something interesting:
> >> map_perf_test 4 8 16348
> >> before/after has too much noise to be conclusive.
> >>
> >> So I did
> >> map_perf_test 4 8 16348 1000000
> >>
> >> and now I see significant degration from patch 3.
> >> It drops from 800k to 200k.
> >> And perf report confirms that heavy contention on sc->reuse_lock is the culprit.
> >> The following hack addresses most of the perf degradtion:
> >>
> >> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >> index fea1cb0c78bb..eeadc9359097 100644
> >> --- a/kernel/bpf/memalloc.c
> >> +++ b/kernel/bpf/memalloc.c
> >> @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
> >>         alloc = 0;
> >>         head = NULL;
> >>         tail = NULL;
> >> -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
> >> +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
> >>         while (alloc < cnt) {
> >>                 obj = __llist_del_first(&sc->reuse_ready_head);
> >>                 if (obj) {
> >> @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
> >>                 alloc++;
> >>         }
> >>         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >> +       }
> >>
> >>         if (alloc) {
> >>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >> @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c)
> >>                 sc->reuse_ready_tail = NULL;
> >>                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
> >>                 __llist_add_batch(head, tail, &sc->wait_for_free);
> >> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >>                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
> >> +       } else {
> >> +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >>         }
> >> -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> >>  }
> >>
> >> It now drops from 800k to 450k.
> >> And perf report shows that both reuse is happening and slab is working hard to satisfy kmalloc/kfree.
> >> So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_for_rcu_task_trace_gp lists.
> > Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
> > I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace_gp.
> Yes, I known, because I had just proposed it in the email yesterday.
> >
> > Also noticed that the overhead of shared reuse_ready list
> > comes both from the contended lock and from cache misses
> > when one cpu pushes to the list after RCU GP and another
> > cpu removes.
> >
> > Also low/batch/high watermark are all wrong in patch 3.
> > low=32 and high=96 makes no sense when it's not a single list.
> > I'm experimenting with 32 for all three heuristics.
> >
> > Another thing I noticed that per-cpu prepare_reuse and free_by_rcu
> > are redundant.
> > unit_free() can push into free_by_rcu directly
> > then reuse_bulk() can fill it up with free_llist_extra and
> > move them into waiting_for_gp.
> Yes. Indeed missing that.
> >
> > All these _tail optimizations are obscuring the code and make it hard
> > to notice these issues.
> >
> >> For now I still prefer to see v5 with per-bpf-ma and no _tail optimization.
> >>
> >> Answering your other email:
> >>
> >>> I see your point. I will continue to debug the memory usage difference
> >>> between v3 and v4.
> >> imo it's a waste of time to continue analyzing performance based on bench in patch 2.
> Don't agree with that. I still think the potential memory usage of v4 is
> a problem and the difference memory usage between v3 and v4 reveals that
> there is some peculiarity in RCU subsystem, because the difference comes
> from the duration of RCU grace period. We need to find out why and fix
> or workaround that.

A tight loop in the kernel can extend RCU grace periods, especially
for kernels built with CONFIG_PREEPTION=n.  Placing things like
cond_resched() in such loops can help.  Of course, if you are in an
RCU read-side critical section (or holding a spinlock), you will need
to exit, cond_resched(), then re-enter.  Taking care to ensure that the
state upon re-entry is valid.  After all, having exited either type of
critical section, anything might happen.

							Thanx, Paul

> >>> I don't think so. Let's considering the per-cpu list first. Assume the
> >>> normal RCU grace period is about 30ms and we are tracing the IO latency
> >>> of a normal SSD. The iops is about 176K per seconds, so before one RCU
> >>> GP is passed, we will need to allocate about 176 * 30 = 5.2K elements.
> >>> For the per-ma list, when the number of CPUs increased, it is easy to
> >>> make the list contain thousands of elements.
> >> That would be true only if there were no scheduling events in all of 176K ops.
> >> Which is not the case.
> >> I'm not sure why you're saying that RCU GP is 30ms.
> Because these freed elements will be freed after one RCU GP and in v4
> there is only one RCU callback per-cpu, so before one RCU GP is expired,
> these freed elements will be accumulated on the list.
> >> In CONFIG_PREEMPT_NONE rcu_read_lock/unlock are true nops.
> >> Every sched event is sort-of implicit rcu_read_lock/unlock.
> >> Network and block IO doesn't process 176K packets without resched.
> >> Don't know how block does it, but in networking NAPI will process 64 packets and will yield softirq.
> >>
> >> For small size buckets low_watermark=32 and high=96.
> >> We typically move 32 elements at a time from one list to another.
> >> A bunch of elements maybe sitting in free_by_rcu and moving them to waiting_for_gp
> >> is not instant, but once __free_rcu_tasks_trace is called we need to take
> >> elements from waiting_for_gp one at a time and kfree it one at a time.
> >> So optimizing the move from free_by_rcu into waiting_for_gp is not worth the code complexity.
> >>
> >>> Before I post v5, I want to know the reason why per-bpf-ma list is
> >>> introduced. Previously, I though it was used to handle the case in which
> >>> allocation and freeing are done on different CPUs.
> >> Correct. per-bpf-ma list is necessary to avoid OOM-ing due to slow rcu_tasks_trace GP.
> >>
> >>> And as we can see
> >>> from the benchmark result above and in v3, the performance and the
> >>> memory usage of v4 for add_del_on_diff_cpu is better than v3.
> >> bench from patch 2 is invalid. Hence no conclusion can be made.
> >>
> >> So far the only bench we can trust and analyze is map_perf_test.
> >> Please make bench in patch 2 yield the cpu after few updates.
> >> Earlier I suggested to stick to 10, but since NAPI can do 64 at a time.
> >> 64 updates is realistic too. A thousand is not.
> Will do that.
> 

