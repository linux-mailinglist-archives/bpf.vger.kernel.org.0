Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B1520BAB
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 05:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiEJDGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 23:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiEJDGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 23:06:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87951525FF
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 20:02:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w17-20020a17090a529100b001db302efed6so980231pjh.4
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XXMy1AFMHXjeXWi9uTm8hKBGN3KBkNh8i2ELJQl4O8s=;
        b=DO4ysz439fDC4iOiuaXyin4otVTuzFtIEvyl9+jP+q9Xk8X4q9ouLN+dZDpfOFheVb
         d+Chwk+xdxMTJ4SfNMEay66Gonj2IqEo7sGtE99kb8f/R80OsdSD642pje38WfLXQQr1
         dFqtLkAocdt0uQ1YkvTAyw1qfU3+c4plrfv/Wz/OpeJSfwR4pTzVpXshYaBJfKTAaqXa
         AeGGpWJ5tNXcFJ6fSmEQJ+nsMb9g/xq5n2OZGozYYmbQU56jzcqlqpNRwCXstJPHCL+n
         MOA2QPp47NopLi3xpHBbbib8Xvtsu0n8lGykmSkr6afk3OnFL3ciE6HeHT5uXv2b1J9e
         kOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXMy1AFMHXjeXWi9uTm8hKBGN3KBkNh8i2ELJQl4O8s=;
        b=z7tvhi5pd3zvzNmLJycpqLpG55AZaXikMRG1ODhgwi12k8BMxk5XYhrjEerR/Z0fj1
         DmK5ZnVPOFZrBB4Ewv50yyZAgbU2EUbav8c1nO0rYxjWUPGSWFBnK8qlMkL7fPCL92TF
         M3b1JRStwkJ6X+hmQnfa7ZW8auWBE3+zkKDwMHy4GV9Q/+5uWzjgLipnb5qtx0x8chPT
         SZvi0y6rW6TJKHLch9x9E2EqWks18KcjMJ+U8117Oy3TeXcuurCcFWI/YLu3X80IbXRk
         BPT/qdCQrWhpfvejse1RRKZi/gg/nfA6Dm6k+tWNESNTwyYtzKy03KPllkKi6cwHUIKB
         OliQ==
X-Gm-Message-State: AOAM533xDAAcF98ZLobX4iUktfvDHqAM40Rnobbn3DTag3JMJ7/eoRBo
        L1jfvymedriLp9eNJ2PTjCM=
X-Google-Smtp-Source: ABdhPJwnMzASYAZRo+PsNJHyRcv0/mL1kVUpwT3utq/sCXiswF8K7aQdjSFtexdBCpoUBU2uEpRQsQ==
X-Received: by 2002:a17:903:2344:b0:15e:bc62:bda7 with SMTP id c4-20020a170903234400b0015ebc62bda7mr18975573plh.120.1652151759143;
        Mon, 09 May 2022 20:02:39 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8e5])
        by smtp.gmail.com with ESMTPSA id b132-20020a621b8a000000b0050dc76281d2sm9666783pfb.172.2022.05.09.20.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:02:38 -0700 (PDT)
Date:   Mon, 9 May 2022 20:02:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: implement sleepable uprobes by
 chaining tasks_trace and normal rcu
Message-ID: <20220510030236.c3ubxkihtt757hnu@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <cover.1651532419.git.delyank@fb.com>
 <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588dd77e9e7424e0abc0e0e624524ef8a2c7b847.1651532419.git.delyank@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 02, 2022 at 11:09:37PM +0000, Delyan Kratunov wrote:
> uprobes work by raising a trap, setting a task flag from within the
> interrupt handler, and processing the actual work for the uprobe on the
> way back to userspace. As a result, uprobe handlers already execute in a
> user context. The primary obstacle to sleepable bpf uprobe programs is
> therefore on the bpf side.
> 
> Namely, the bpf_prog_array attached to the uprobe is protected by normal
> rcu and runs with disabled preemption.

disabled preemption was an artifact of the past.
It became unnecessary when migrate_disable was introduced.
Looks like we forgot to update this spot.

> In order for uprobe bpf programs
> to become actually sleepable, we need it to be protected by the tasks_trace
> rcu flavor instead (and kfree() called after a corresponding grace period).
> 
> Based on Alexei's proposal, we change the free path for bpf_prog_array to
> chain a tasks_trace and normal grace periods one after the other.
> 
> Users who iterate under tasks_trace read section would
> be safe, as would users who iterate under normal read sections (from
> non-sleepable locations). The downside is that we take the tasks_trace latency
> for all perf_event-attached bpf programs (and not just uprobe ones)
> but this is deemed safe given the possible attach rates for
> kprobe/uprobe/tp programs.
> 
> Separately, non-sleepable programs need access to dynamically sized
> rcu-protected maps, so we conditionally disable preemption and take an rcu
> read section around them, in addition to the overarching tasks_trace section.
> 
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  include/linux/bpf.h          | 57 ++++++++++++++++++++++++++++++++++++
>  include/linux/trace_events.h |  1 +
>  kernel/bpf/core.c            | 15 ++++++++++
>  kernel/trace/bpf_trace.c     | 27 +++++++++++++++--
>  kernel/trace/trace_uprobe.c  |  4 +--
>  5 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 57ec619cf729..592886115011 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -26,6 +26,7 @@
>  #include <linux/stddef.h>
>  #include <linux/bpfptr.h>
>  #include <linux/btf.h>
> +#include <linux/rcupdate_trace.h>
> 
>  struct bpf_verifier_env;
>  struct bpf_verifier_log;
> @@ -1343,6 +1344,8 @@ extern struct bpf_empty_prog_array bpf_empty_prog_array;
> 
>  struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
>  void bpf_prog_array_free(struct bpf_prog_array *progs);
> +/* Use when traversal over the bpf_prog_array uses tasks_trace rcu */
> +void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs);
>  int bpf_prog_array_length(struct bpf_prog_array *progs);
>  bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
>  int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
> @@ -1428,6 +1431,60 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>  	return ret;
>  }
> 
> +/**
> + * Notes on RCU design for bpf_prog_arrays containing sleepable programs:
> + *
> + * We use the tasks_trace rcu flavor read section to protect the bpf_prog_array
> + * overall. As a result, we must use the bpf_prog_array_free_sleepable
> + * in order to use the tasks_trace rcu grace period.
> + *
> + * When a non-sleepable program is inside the array, we take the rcu read
> + * section and disable preemption for that program alone, so it can access
> + * rcu-protected dynamically sized maps.
> + */
> +static __always_inline u32
> +bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
> +			     const void *ctx, bpf_prog_run_fn run_prog)
> +{
> +	const struct bpf_prog_array_item *item;
> +	const struct bpf_prog *prog;
> +	const struct bpf_prog_array *array;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
> +	u32 ret = 1;
> +
> +	might_fault();
> +
> +	migrate_disable();
> +	rcu_read_lock_trace();

pls swap this order to make it the same as bpf trampoline.

> +
> +	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
> +	if (unlikely(!array))
> +		goto out;
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +	item = &array->items[0];
> +	while ((prog = READ_ONCE(item->prog))) {
> +		if (!prog->aux->sleepable) {
> +			preempt_disable();

just remove this line.

> +			rcu_read_lock();

In config-s where rcu_read_lock/unlock is a nop
this whole 'if' and one below will be optimized out by the compiler.
Which is nice.

> +		}
> +
> +		run_ctx.bpf_cookie = item->bpf_cookie;
> +		ret &= run_prog(prog, ctx);
> +		item++;
> +
> +		if (!prog->aux->sleepable) {
> +			rcu_read_unlock();
> +			preempt_enable();
> +		}
> +	}
> +	bpf_reset_run_ctx(old_run_ctx);
> +out:
> +	rcu_read_unlock_trace();
> +	migrate_enable();
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  DECLARE_PER_CPU(int, bpf_prog_active);
>  extern struct mutex bpf_stats_enabled_mutex;
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index e6e95a9f07a5..d45889f1210d 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -736,6 +736,7 @@ trace_trigger_soft_disabled(struct trace_event_file *file)
> 
>  #ifdef CONFIG_BPF_EVENTS
>  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx);
> +unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx);
>  int perf_event_attach_bpf_prog(struct perf_event *event, struct bpf_prog *prog, u64 bpf_cookie);
>  void perf_event_detach_bpf_prog(struct perf_event *event);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 13e9dbeeedf3..9271b708807a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2268,6 +2268,21 @@ void bpf_prog_array_free(struct bpf_prog_array *progs)
>  	kfree_rcu(progs, rcu);
>  }
> 
> +static void __bpf_prog_array_free_sleepable_cb(struct rcu_head *rcu)
> +{
> +	struct bpf_prog_array *progs;
> +
> +	progs = container_of(rcu, struct bpf_prog_array, rcu);
> +	kfree_rcu(progs, rcu);
> +}
> +
> +void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
> +{
> +	if (!progs || progs == &bpf_empty_prog_array.hdr)
> +		return;
> +	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
> +}
> +
>  int bpf_prog_array_length(struct bpf_prog_array *array)
>  {
>  	struct bpf_prog_array_item *item;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f15b826f9899..582a6171e096 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -140,6 +140,29 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  	return ret;
>  }
> 
> +unsigned int uprobe_call_bpf(struct trace_event_call *call, void *ctx)
> +{
> +	unsigned int ret;
> +
> +	/*
> +	 * Instead of moving rcu_read_lock/rcu_dereference/rcu_read_unlock
> +	 * to all call sites, we did a bpf_prog_array_valid() there to check
> +	 * whether call->prog_array is empty or not, which is
> +	 * a heuristic to speed up execution.
> +	 *
> +	 * If bpf_prog_array_valid() fetched prog_array was
> +	 * non-NULL, we go into uprobe_call_bpf() and do the actual
> +	 * proper rcu_dereference() under RCU trace lock.
> +	 * If it turns out that prog_array is NULL then, we bail out.
> +	 * For the opposite, if the bpf_prog_array_valid() fetched pointer
> +	 * was NULL, you'll skip the prog_array with the risk of missing
> +	 * out of events when it was updated in between this and the
> +	 * rcu_dereference() which is accepted risk.
> +	 */
> +	ret = bpf_prog_run_array_sleepable(call->prog_array, ctx, bpf_prog_run);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>  BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
>  {
> @@ -1915,7 +1938,7 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
>  	event->prog = prog;
>  	event->bpf_cookie = bpf_cookie;
>  	rcu_assign_pointer(event->tp_event->prog_array, new_array);
> -	bpf_prog_array_free(old_array);
> +	bpf_prog_array_free_sleepable(old_array);
> 
>  unlock:
>  	mutex_unlock(&bpf_event_mutex);
> @@ -1941,7 +1964,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  		bpf_prog_array_delete_safe(old_array, event->prog);
>  	} else {
>  		rcu_assign_pointer(event->tp_event->prog_array, new_array);
> -		bpf_prog_array_free(old_array);
> +		bpf_prog_array_free_sleepable(old_array);
>  	}
> 
>  	bpf_prog_put(event->prog);
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 9711589273cd..3eb48897d15b 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1346,9 +1346,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>  	if (bpf_prog_array_valid(call)) {
>  		u32 ret;
> 
> -		preempt_disable();

It should have been replaced with migrate_disable long ago.

> -		ret = trace_call_bpf(call, regs);
> -		preempt_enable();
> +		ret = uprobe_call_bpf(call, regs);
>  		if (!ret)
>  			return;
>  	}
> --
> 2.35.1
