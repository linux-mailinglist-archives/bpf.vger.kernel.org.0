Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AD6F5E7C
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjECStG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjECStA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 14:49:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0A6A75;
        Wed,  3 May 2023 11:48:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaff9c93a5so25882955ad.2;
        Wed, 03 May 2023 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139725; x=1685731725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHGrLK6Ja7GJoRBWTFAfctBGCxtJTjuvz3zG1yvxji8=;
        b=qsCSq2eb6r9Ux5c3TJ9Tzn/SvJv6cyiMXqW4o+hZDWP2QsiGOvf9Gn0CYAKs2Zq95A
         Kawo4z+t3xw8qMkyMjJrI1ewUHE1LHI9TxKL+1OkIHc2Arr9lER2POdmSs2RcNH50wAQ
         t6Aw4i3Bmwme+POeAH0/VUs8+6cktrCrsXPwPZk9AAdMn4V/Jh5NnsHTnmPukxxhchiq
         foTY321oZnnBxbTuLEvXaesI6vUyl6P/4/WliefHDYy4UKmx+MwLfZvl/8xehNn1ibQc
         t/F2kGAO43gbR0Enm6N7QsSpbyQTkRjhC6YIf8nGh+UFNbJJrbOs5v1OF74wkzyvOpgQ
         Og+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139725; x=1685731725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHGrLK6Ja7GJoRBWTFAfctBGCxtJTjuvz3zG1yvxji8=;
        b=O+YDZu9iUUN1xVBQjFKC7FT+FgUQPuQVP2fvdFA4PN3jQOq5kMJq+DOu3HXYxZUK17
         ZyPo/tKFzj+uE59lkwoMjEqXRSdXTRKHktPZ3Mnx5LNtWQvjA1biylUaoB+Aaiju8cdc
         0Ytl9hTpOPJb2UKVF23te/tkBueK4Hn1DUw8skLFxiobehUupgHEYJei5cI+f0THmYNp
         +ttiaDhNo5Zaf6dxgXwZxlgSpXDZKz/1YIDsU3VUDIeY9Je35lBtOy6fihqTZcy+doV9
         3yyy2rMCjJsjJclX2TJdR1tutMGcTk6Aov4LSi8M38f7eqHHjzqYGRCJ2uurN273sWNh
         Nqkg==
X-Gm-Message-State: AC+VfDww3Hp2T5L3nfJqBzZT/r9Q6X+J1HyS4K9LDQ7+WTAUzzpq6kZ/
        gfvY3p8VRia9bjsxrCyW+i4=
X-Google-Smtp-Source: ACHHUZ7gkpK5QkAqbpxb1s6Xu7FcjLy4k2Y3b6K6injGlNKCp8lAxDNBikmYO2ajzPQiZM1jA3NODA==
X-Received: by 2002:a17:903:22c6:b0:1aa:e650:bac3 with SMTP id y6-20020a17090322c600b001aae650bac3mr1299566plg.0.1683139725068;
        Wed, 03 May 2023 11:48:45 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:f64b])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001aaecc0b6ffsm6780097plc.160.2023.05.03.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:48:44 -0700 (PDT)
Date:   Wed, 3 May 2023 11:48:41 -0700
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
Message-ID: <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429101215.111262-4-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 29, 2023 at 06:12:12PM +0800, Hou Tao wrote:
> +
> +static void notrace wait_gp_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	/* In case a NMI-context bpf program is also freeing object. */
> +	if (local_inc_return(&c->active) == 1) {
> +		bool try_queue_work = false;
> +
> +		/* kworker may remove elements from prepare_reuse_head */
> +		raw_spin_lock(&c->reuse_lock);
> +		if (llist_empty(&c->prepare_reuse_head))
> +			c->prepare_reuse_tail = llnode;
> +		__llist_add(llnode, &c->prepare_reuse_head);
> +		if (++c->prepare_reuse_cnt > c->high_watermark) {
> +			/* Zero out prepare_reuse_cnt early to prevent
> +			 * unnecessary queue_work().
> +			 */
> +			c->prepare_reuse_cnt = 0;
> +			try_queue_work = true;
> +		}
> +		raw_spin_unlock(&c->reuse_lock);
> +
> +		if (try_queue_work && !work_pending(&c->reuse_work)) {
> +			/* Use reuse_cb_in_progress to indicate there is
> +			 * inflight reuse kworker or reuse RCU callback.
> +			 */
> +			atomic_inc(&c->reuse_cb_in_progress);
> +			/* Already queued */
> +			if (!queue_work(bpf_ma_wq, &c->reuse_work))

As Martin pointed out queue_work() is not safe here.
The raw_spin_lock(&c->reuse_lock); earlier is not safe either.
For the next version please drop workers and spin_lock from unit_free/alloc paths.
If lock has to be taken it should be done from irq_work.
Under no circumstances we can use alloc_workqueue(). No new kthreads.

We can avoid adding new flag to bpf_mem_alloc to reduce the complexity
and do roughly equivalent of REUSE_AFTER_RCU_GP unconditionally in the following way:

- alloc_bulk() won't be trying to steal from c->free_by_rcu.

- do_call_rcu() does call_rcu(&c->rcu, __free_rcu) instead of task-trace version.

- rcu_trace_implies_rcu_gp() is never used.

- after RCU_GP __free_rcu() moves all waiting_for_gp elements into 
  a size specific link list per bpf_mem_alloc (not per bpf_mem_cache which is per-cpu)
  and does call_rcu_tasks_trace

- Let's call this list ma->free_by_rcu_tasks_trace
  (only one list for bpf_mem_alloc with known size or NUM_CACHES such lists when size == 0 at init)

- any cpu alloc_bulk() can steal from size specific ma->free_by_rcu_tasks_trace list that
  is protected by ma->spin_lock (1 or NUM_CACHES such locks)

- ma->waiting_for_gp_tasks_trace will be freeing elements into slab

What it means that sleepable progs using hashmap will be able to avoid uaf with bpf_rcu_read_lock().
Without explicit bpf_rcu_read_lock() it's still safe and equivalent to existing behavior of bpf_mem_alloc.
(while your proposed BPF_MA_FREE_AFTER_RCU_GP flavor is not safe to use in hashtab with sleepable progs)

After that we can unconditionally remove rcu_head/call_rcu from bpf_cpumask and improve usability of bpf_obj_drop.
Probably usage of bpf_mem_alloc in local storage can be simplified as well.
Martin wdyt?

I think this approach adds minimal complexity to bpf_mem_alloc while solving all existing pain points
including needs of qp-trie.
