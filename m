Return-Path: <bpf+bounces-2051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11F7272FF
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FA22815E2
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DB3B410;
	Wed,  7 Jun 2023 23:30:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC2F3B3E0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 23:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECDC433EF;
	Wed,  7 Jun 2023 23:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686180656;
	bh=4omPFz9EzTb31VlfUaDX91IrIYAdj5ogBWSVjstl2i4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lhWxmAn5YtT2ySCl6Lqx6Y7u/W7sk4No4E9Oxrgpptt1O/gtXT4Hn18YSrsc4q4NQ
	 EJ4JkSpgNjcLFmywiIQdi6T5pdZxrXc/wkgcXxB+Xfm9L/MWGcCAcdr/dw4Ff9SDHV
	 z0PV+Ual5TDkNk6+hb+Qq0shOzxuFg2h3hfYomiH8avoYSaGlmO5pygwtjJnTCVA0m
	 XHMTpwQYv2fnO6FcfQpocoRYrwd0vUGwdCpvGk/8NXAwDk4EAMf9DoeCbXKatkNMDx
	 30q7diw7pm7c4DmTYcnOnUuP3ccJ0EssjyCoePEYKkt3BnJBqZrvfIxUO47OcBdBEe
	 tSBjBqDnDt6gA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0D413CE3A6C; Wed,  7 Jun 2023 16:30:56 -0700 (PDT)
Date: Wed, 7 Jun 2023 16:30:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
	"houtao1@huawei.com" <houtao1@huawei.com>
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
Message-ID: <55f5e64d-9d9e-4c65-8d1b-8fd4684ee9a3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
 <20230606210429.qziyhz4byqacmso3@MacBook-Pro-8.local>
 <9d17ed7f-1726-d894-9f74-75ec9702ca7e@huaweicloud.com>
 <20230607175224.oqezpaztsb5hln2s@MacBook-Pro-8.local>
 <CAADnVQJMM2ueRoDMmmBsxb_chPFr_WCH34tyiYQiwphnDhyuGw@mail.gmail.com>
 <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ1njnHb96HfO4k48XDY9L3YXqQW1iUW=ti5iBNKKcE9A@mail.gmail.com>

On Wed, Jun 07, 2023 at 04:23:20PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 7, 2023 at 1:50 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 7, 2023 at 10:52 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 04:42:11PM +0800, Hou Tao wrote:
> > > > As said in the commit message, the command line for test is
> > > > "./map_perf_test 4 8 16384", because the default max_entries is 1000. If
> > > > using default max_entries and the number of CPUs is greater than 15,
> > > > use_percpu_counter will be false.
> > >
> > > Right. percpu or not depends on number of cpus.
> > >
> > > >
> > > > I have double checked my local VM setup (8 CPUs + 16GB) and rerun the
> > > > test.  For both "./map_perf_test 4 8" and "./map_perf_test 4 8 16384"
> > > > there are obvious performance degradation.
> > > ...
> > > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > > 2:hash_map_perf kmalloc 359201 events per sec
> > > ..
> > > > [root@hello bpf]# ./map_perf_test 4 8 16384
> > > > 4:hash_map_perf kmalloc 203983 events per sec
> > >
> > > this is indeed a degration in a VM.
> > >
> > > > I also run map_perf_test on a physical x86-64 host with 72 CPUs. The
> > > > performances for "./map_perf_test 4 8" are similar, but there is obvious
> > > > performance degradation for "./map_perf_test 4 8 16384"
> > >
> > > but... a degradation?
> > >
> > > > Before reuse-after-rcu-gp:
> > > >
> > > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > > 1:hash_map_perf kmalloc 388088 events per sec
> > > ...
> > > > After reuse-after-rcu-gp:
> > > > [houtao@fedora bpf]$ sudo ./map_perf_test 4 8 16384
> > > > 5:hash_map_perf kmalloc 655628 events per sec
> > >
> > > This is a big improvement :) Not a degration.
> > > You always have to double check the numbers with perf report.
> > >
> > > > So could you please double check your setup and rerun map_perf_test ? If
> > > > there is no performance degradation, could you please share your setup
> > > > and your kernel configure file ?
> > >
> > > I'm testing on normal no-debug kernel. No kasan. No lockdep. HZ=1000
> > > Playing with it a bit more I found something interesting:
> > > map_perf_test 4 8 16348
> > > before/after has too much noise to be conclusive.
> > >
> > > So I did
> > > map_perf_test 4 8 16348 1000000
> > >
> > > and now I see significant degration from patch 3.
> > > It drops from 800k to 200k.
> > > And perf report confirms that heavy contention on sc->reuse_lock is the culprit.
> > > The following hack addresses most of the perf degradtion:
> > >
> > > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > > index fea1cb0c78bb..eeadc9359097 100644
> > > --- a/kernel/bpf/memalloc.c
> > > +++ b/kernel/bpf/memalloc.c
> > > @@ -188,7 +188,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
> > >         alloc = 0;
> > >         head = NULL;
> > >         tail = NULL;
> > > -       raw_spin_lock_irqsave(&sc->reuse_lock, flags);
> > > +       if (raw_spin_trylock_irqsave(&sc->reuse_lock, flags)) {
> > >         while (alloc < cnt) {
> > >                 obj = __llist_del_first(&sc->reuse_ready_head);
> > >                 if (obj) {
> > > @@ -206,6 +206,7 @@ static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
> > >                 alloc++;
> > >         }
> > >         raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > > +       }
> > >
> > >         if (alloc) {
> > >                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > @@ -334,9 +335,11 @@ static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c)
> > >                 sc->reuse_ready_tail = NULL;
> > >                 WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
> > >                 __llist_add_batch(head, tail, &sc->wait_for_free);
> > > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > >                 call_rcu_tasks_trace(&sc->rcu, free_rcu);
> > > +       } else {
> > > +               raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > >         }
> > > -       raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
> > >  }
> > >
> > > It now drops from 800k to 450k.
> > > And perf report shows that both reuse is happening and slab is working hard to satisfy kmalloc/kfree.
> > > So we may consider per-cpu waiting_for_rcu_gp and per-bpf-ma waiting_for_rcu_task_trace_gp lists.
> >
> > Sorry. per-cpu waiting_for_rcu_gp is what patch 3 does already.
> > I meant per-cpu reuse_ready and per-bpf-ma waiting_for_rcu_task_trace_gp.
> 
> An update..
> 
> I tweaked patch 3 to do per-cpu reuse_ready and it addressed
> the lock contention, but cache miss on
> __llist_del_first(&c->reuse_ready_head);
> was still very high and performance was still at 450k as
> with a simple hack above.
> 
> Then I removed some of the _tail optimizations and added counters
> to these llists.
> To my surprise
> map_perf_test 4 1 16348 1000000
> was showing ~200k on average in waiting_for_gp when reuse_rcu() is called
> and ~400k sitting in reuse_ready_head.
> 
> Then noticed that we should be doing:
> call_rcu_hurry(&c->rcu, reuse_rcu);
> instead of call_rcu(),
> but my config didn't have RCU_LAZY, so that didn't help.
> Obviously we cannot allow such a huge number of elements to sit
> in these link lists.
> The whole "reuse-after-rcu-gp" idea for bpf_mem_alloc may not work.
> To unblock qp-trie work I suggest to add rcu_head to each inner node
> and do call_rcu() on them before free-ing them to bpf_mem_alloc.
> Explicit call_rcu would disqualify qp-tree from tracing programs though :(

I am sure that you guys have already considered and discarded this one,
but I cannot help but suggest SLAB_TYPESAFE_BY_RCU.

							Thanx, Paul

