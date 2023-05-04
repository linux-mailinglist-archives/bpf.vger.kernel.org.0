Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924686F62C5
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEDCA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 22:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDCA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 22:00:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58EFB;
        Wed,  3 May 2023 19:00:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso6303a91.0;
        Wed, 03 May 2023 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683165655; x=1685757655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRBOHh/tCmyWw1Poq3WxviOnrdJ0PJsvOsbXWNJkFdw=;
        b=d40CmsXXOsoIkmc1dUsd6O4ZbixTS/RL+LYZKUKi3iVMAuCkLB0UcJQbx46TRKGAw4
         J4eH00yQ1q4KVRYUJYv6KEIfjRl2cIWXILR0hJgkdaMal/ZGcwiQ6Jfa2i3lJ6QXSl8p
         KywF7zhpQMIa2eQdP7v3Kti25ctAN6DymkQl4lrSfg6dcbAExmE+G777GNHJhhtOGqx+
         /KJUW/cvnK+eJPRgezRDt5rzC/2j7UmZL/0uLHKpIrE+XxDA9cPXUxUrI/ryx2uF5Z1S
         72AvhmiZWSEN4pKzYCQJq/h8PtGL+w2EsVLOinSQqoQQ4k5I7g6QJVqS14V/KCAjbq1x
         2Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683165655; x=1685757655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRBOHh/tCmyWw1Poq3WxviOnrdJ0PJsvOsbXWNJkFdw=;
        b=DdFbu9YkiHMZXQ+1VTa7DAMh2JWQzJHhsfIil7HgRgSNEBjF5Ep9jFo5RyY8WzUlIE
         7WYURaM9gfoP2PbvEToYtaxQqLTX4MHCee4nia5XFDMrfCRVJhXwz1yY+kc1uffPFA8R
         85otrbdnQl/WyJxQDb171Qc2f4oQaWUlLOw09RSZtWfiksxDiwZEw3ToTg0BoyjWuF5L
         DqsTC7WtnSIimL1eHmefSYbJ18+wQASL106lc9PUCEeRfwVJN1UarWLK75qTHqgMxx93
         RqZEShf5mm/kI8naOF2u5/NAzDESLEFVuFQ+Zu1M6CbChjlK3CjgnpdQYlZk6PVZ/JyF
         yf/g==
X-Gm-Message-State: AC+VfDzOPJm/Rbtl3hblYJ2jkkcgbwCoLCEfnUNLJAphAMJsUgcFt13E
        cTAczVoDZ1CadxpKFG7b+DY=
X-Google-Smtp-Source: ACHHUZ6I9a4D3bqASHnIw8Cy16pin+0jckQZIukmADgBbI8NkWUzhXn+SSYfB6sGSAWgiO0S3tBtWA==
X-Received: by 2002:a17:90a:9412:b0:24d:f966:2503 with SMTP id r18-20020a17090a941200b0024df9662503mr574103pjo.38.1683165654721;
        Wed, 03 May 2023 19:00:54 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id ie14-20020a17090b400e00b0024e1172c1d3sm5237138pjb.32.2023.05.03.19.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:00:53 -0700 (PDT)
Date:   Wed, 3 May 2023 19:00:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Message-ID: <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
 <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 04, 2023 at 09:35:17AM +0800, Hou Tao wrote:
> Hi,
> 
> On 5/4/2023 2:48 AM, Alexei Starovoitov wrote:
> > On Sat, Apr 29, 2023 at 06:12:12PM +0800, Hou Tao wrote:
> >> +
> >> +static void notrace wait_gp_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	local_irq_save(flags);
> >> +	/* In case a NMI-context bpf program is also freeing object. */
> >> +	if (local_inc_return(&c->active) == 1) {
> >> +		bool try_queue_work = false;
> >> +
> >> +		/* kworker may remove elements from prepare_reuse_head */
> >> +		raw_spin_lock(&c->reuse_lock);
> >> +		if (llist_empty(&c->prepare_reuse_head))
> >> +			c->prepare_reuse_tail = llnode;
> >> +		__llist_add(llnode, &c->prepare_reuse_head);
> >> +		if (++c->prepare_reuse_cnt > c->high_watermark) {
> >> +			/* Zero out prepare_reuse_cnt early to prevent
> >> +			 * unnecessary queue_work().
> >> +			 */
> >> +			c->prepare_reuse_cnt = 0;
> >> +			try_queue_work = true;
> >> +		}
> >> +		raw_spin_unlock(&c->reuse_lock);
> >> +
> >> +		if (try_queue_work && !work_pending(&c->reuse_work)) {
> >> +			/* Use reuse_cb_in_progress to indicate there is
> >> +			 * inflight reuse kworker or reuse RCU callback.
> >> +			 */
> >> +			atomic_inc(&c->reuse_cb_in_progress);
> >> +			/* Already queued */
> >> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))
> > As Martin pointed out queue_work() is not safe here.
> > The raw_spin_lock(&c->reuse_lock); earlier is not safe either.
> I see. Didn't recognize these problems.
> > For the next version please drop workers and spin_lock from unit_free/alloc paths.
> > If lock has to be taken it should be done from irq_work.
> > Under no circumstances we can use alloc_workqueue(). No new kthreads.
> Is there any reason to prohibit the use of new kthread in irq_work ?

Because:
1. there is a workable solution without kthreads.
2. if there was no solution we would have to come up with one.
kthread is not an answer. It's hard to reason about a setup when kthreads
are in critical path due to scheduler. Assume the system is 100% cpu loaded.
kthreads delays and behavior is unpredictable. We cannot subject memory alloc/free to it.

> >
> > We can avoid adding new flag to bpf_mem_alloc to reduce the complexity
> > and do roughly equivalent of REUSE_AFTER_RCU_GP unconditionally in the following way:
> >
> > - alloc_bulk() won't be trying to steal from c->free_by_rcu.
> >
> > - do_call_rcu() does call_rcu(&c->rcu, __free_rcu) instead of task-trace version.
> No sure whether or not one inflight RCU callback is enough. Will check.
> If one is not enough, I may use kmalloc(__GFP_NOWAIT) in irq work to
> allocate multiple RCU callbacks.

Pls dont. Just assume it will work, implement the proposal (if you agree),
come back with the numbers and then we will discuss again.
We cannot keep arguing about merits of complicated patch set that was done on partial data.
Just like the whole thing with kthreads.
I requested early on: "pls no kthreads" and weeks later we're still arguing.

> > - rcu_trace_implies_rcu_gp() is never used.
> >
> > - after RCU_GP __free_rcu() moves all waiting_for_gp elements into 
> >   a size specific link list per bpf_mem_alloc (not per bpf_mem_cache which is per-cpu)
> >   and does call_rcu_tasks_trace
> >
> > - Let's call this list ma->free_by_rcu_tasks_trace
> >   (only one list for bpf_mem_alloc with known size or NUM_CACHES such lists when size == 0 at init)
> >
> > - any cpu alloc_bulk() can steal from size specific ma->free_by_rcu_tasks_trace list that
> >   is protected by ma->spin_lock (1 or NUM_CACHES such locks)
> To reduce the lock contention, alloc_bulk() can steal from the global
> list in batch. 

Pls no special batches. The simplest implementation possible.
alloc_bulk() has 'int cnt' argument. It will try to steal 'cnt' from ma->free_by_rcu_tasks_trace.

> Had tried the global list before but I didn't do the
> concurrent freeing, I think it could reduce the risk of OOM for
> add_del_on_diff_cpu.

Maybe you've tried, but we didn't see the patches and we cannot take for granted
anyone saying: "I've tried *foo*. It didn't work. That's why I'm doing *bar* here".
Everything mm is tricky. Little details matter a lot.
It's also questionable whether we should make any design decisions based on this benchmark
and in particular based on add_del_on_diff_cpu part of it.
I'm not saying we shouldn't consider it, but all numbers have a "decision weight"
associated with them.
For example: there is existing samples/bpf/map_perf_test benchmark.
So far we haven't seen the numbers from it.
Is it more important than your new bench? Yes and no. All numbers matter.

> >
> > - ma->waiting_for_gp_tasks_trace will be freeing elements into slab
> >
> > What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
> > Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
> > (while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)
> >
> > After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
> > Probably usage of bpf_mem_alloc in local storage can be simplified as well.
> > Martin wdyt?
> >
> > I think this approach adds minimal complexity to bpf_mem_alloc while solving all existing pain points
> > including needs of qp-trie.
> Thanks for these great suggestions. Will try to do it in v4.

Thanks.
Also for benchmark, pls don't hack htab and benchmark as 'non-landable patches' (as in this series).
Construct the patch series as:
- prep patches
- benchmark
- unconditional convert of bpf_ma to REUSE_AFTER_rcu_GP_and_free_after_rcu_tasks_trace
  with numbers from bench(s) before and after this patch.
