Return-Path: <bpf+bounces-15739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F67F59C1
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 09:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E3B1C20D29
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4B518C3C;
	Thu, 23 Nov 2023 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="t/3d9rWF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68CD1B3
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 00:08:00 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A9F6402D4
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1700726879;
	bh=gokYZGe1QoII7+uDO65Qm/DNquvUNmNK6+pvHFO6JCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=t/3d9rWFRKPhmtpdqVYuiuW8wv/RB+OpdO/NIRdJ96zsu+P3S5VKjyWGAPdYSf/KS
	 6YzZAJ4lX5qT01WxTHjY/Hnbi64USpOZsdhmL6+5o4C+DsL/jEYZ2k9kdCgaP9kKg5
	 41qrAS3wNgemwk4csBfp1btbaR2TtQDNhpUNwNbBEgsCnVMxNc7q22mTIMKCxxBGpg
	 AbSdYRf2cTzSIPv+mUTiGIN2TvB6nju9MHEW2oLvOdt/Xf8N1dR2s/PgmA/flN+p9u
	 yoltUriQrSHZymRPLj+6cw/COR047JDsfLAkQY0XJd6To5MOl/wkaNprBjoJW2Ozjn
	 tcKxiCOUgf4fg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a02ccc2fb53so32421566b.1
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 00:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726879; x=1701331679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gokYZGe1QoII7+uDO65Qm/DNquvUNmNK6+pvHFO6JCo=;
        b=cve2XvFAninid1f039a4wOh5j/xVZqCpGJu6P4U+9jHAVyvAC3YIyxw2dbWcfvTPRx
         owdQi7BkIEntfJIRxLu2CsXCkUjPJCzxizn7bbu6eIQ09tPhA0hrtlerdOzMmU3BxNXm
         biJyBoOqglLvFv0xbmZX5ZJmbtCyEvOedBFi5x4sYtjwwpn6PoQMOnvo9v4vACUQO3Jp
         YLPGCzACe/SLFsgVgjnIF7Z4yZJzxZydW2ppG4QTTSfRRFSSFu9l73r7MooqV6jutFgU
         ux2lqG58FDZ0Ywyey6dDaR8X87B4ir0k+FacWHFijNMhjlalVpTaCNMNivBU7TSU0K0M
         xqFw==
X-Gm-Message-State: AOJu0Yy27f1RjyBFNraHfUQsR0sSr3+7YxDS+1dV3ldJnQzAxQ18eFPo
	y5scZwLsoHcr/lRwoexoy+CaqdkklJOCMeDn/cTievlf/oJwFfqeguR3cZohAtXBpjodZdBIXNe
	gvuW1VtU1ivVjzqizQqTguXbAzlCE0Q==
X-Received: by 2002:a17:906:15d:b0:9e6:da40:50bf with SMTP id 29-20020a170906015d00b009e6da4050bfmr1973089ejh.8.1700726858103;
        Thu, 23 Nov 2023 00:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg/dObVwBZdSrJhf5IxM4YDyhYgXFAwmhaTpB0amzOk6reK8n+myZIcqRG5jKyomqeLXSjcA==
X-Received: by 2002:a17:906:15d:b0:9e6:da40:50bf with SMTP id 29-20020a170906015d00b009e6da4050bfmr1973019ejh.8.1700726857211;
        Thu, 23 Nov 2023 00:07:37 -0800 (PST)
Received: from localhost (host-79-54-179-199.retail.telecomitalia.it. [79.54.179.199])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906361600b00a0290da4a50sm450828ejb.186.2023.11.23.00.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:07:36 -0800 (PST)
Date: Thu, 23 Nov 2023 09:07:35 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZV8IR/w4IaxJ2vPA@gpd>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111024835.2164816-13-tj@kernel.org>

On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
...
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3961,6 +3961,15 @@ bool cpus_share_resources(int this_cpu, int that_cpu)
>  
>  static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  {
> +	/*
> +	 * The BPF scheduler may depend on select_task_rq() being invoked during
> +	 * wakeups. In addition, @p may end up executing on a different CPU
> +	 * regardless of what happens in the wakeup path making the ttwu_queue
> +	 * optimization less meaningful. Skip if on SCX.
> +	 */
> +	if (task_on_scx(p))
> +		return false;
> +
>  	/*
>  	 * Do not complicate things with the async wake_list while the CPU is
>  	 * in hotplug state.
> @@ -4531,6 +4540,18 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->rt.on_rq		= 0;
>  	p->rt.on_list		= 0;
>  
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	p->scx.dsq		= NULL;
> +	INIT_LIST_HEAD(&p->scx.dsq_node);
> +	p->scx.flags		= 0;
> +	p->scx.weight		= 0;
> +	p->scx.sticky_cpu	= -1;
> +	p->scx.holding_cpu	= -1;
> +	p->scx.kf_mask		= 0;
> +	atomic64_set(&p->scx.ops_state, 0);

We probably need atomic_long_set() here or in 32-bit arches (such as
armhf) we get this:

kernel/sched/core.c:4564:22: error: passing argument 1 of ‘atomic64_set’ from incompatible pointer type [-Werror=incompatible-pointer-types]
 4564 |         atomic64_set(&p->scx.ops_state, 0);
      |                      ^~~~~~~~~~~~~~~~~
      |                      |
      |                      atomic_long_t * {aka atomic_t *}

> +	p->scx.slice		= SCX_SLICE_DFL;
> +#endif
> +
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
>  	INIT_HLIST_HEAD(&p->preempt_notifiers);
>  #endif
> @@ -4779,6 +4800,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  		goto out_cancel;
>  	} else if (rt_prio(p->prio)) {
>  		p->sched_class = &rt_sched_class;
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	} else if (task_should_scx(p)) {
> +		p->sched_class = &ext_sched_class;
> +#endif
>  	} else {
>  		p->sched_class = &fair_sched_class;
>  	}
> @@ -7059,6 +7084,10 @@ void __setscheduler_prio(struct task_struct *p, int prio)
>  		p->sched_class = &dl_sched_class;
>  	else if (rt_prio(prio))
>  		p->sched_class = &rt_sched_class;
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	else if (task_should_scx(p))
> +		p->sched_class = &ext_sched_class;
> +#endif
>  	else
>  		p->sched_class = &fair_sched_class;
>  
> @@ -9055,6 +9084,7 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
>  	case SCHED_NORMAL:
>  	case SCHED_BATCH:
>  	case SCHED_IDLE:
> +	case SCHED_EXT:
>  		ret = 0;
>  		break;
>  	}
> @@ -9082,6 +9112,7 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
>  	case SCHED_NORMAL:
>  	case SCHED_BATCH:
>  	case SCHED_IDLE:
> +	case SCHED_EXT:
>  		ret = 0;
>  	}
>  	return ret;
> @@ -9918,6 +9949,10 @@ void __init sched_init(void)
>  	BUG_ON(!sched_class_above(&dl_sched_class, &rt_sched_class));
>  	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
>  	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
> +	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
> +#endif
>  
>  	wait_bit_init();
>  
> @@ -12047,3 +12082,38 @@ void sched_mm_cid_fork(struct task_struct *t)
>  	t->mm_cid_active = 1;
>  }
>  #endif
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> +			    struct sched_enq_and_set_ctx *ctx)
> +{
> +	struct rq *rq = task_rq(p);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	*ctx = (struct sched_enq_and_set_ctx){
> +		.p = p,
> +		.queue_flags = queue_flags,
> +		.queued = task_on_rq_queued(p),
> +		.running = task_current(rq, p),
> +	};
> +
> +	update_rq_clock(rq);
> +	if (ctx->queued)
> +		dequeue_task(rq, p, queue_flags | DEQUEUE_NOCLOCK);
> +	if (ctx->running)
> +		put_prev_task(rq, p);
> +}
> +
> +void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
> +{
> +	struct rq *rq = task_rq(ctx->p);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (ctx->queued)
> +		enqueue_task(rq, ctx->p, ctx->queue_flags | ENQUEUE_NOCLOCK);
> +	if (ctx->running)
> +		set_next_task(rq, ctx->p);
> +}
> +#endif	/* CONFIG_SCHED_CLASS_EXT */
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 4580a450700e..6587a45ffe96 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -374,6 +374,9 @@ static __init int sched_init_debug(void)
>  
>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
>  
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	debugfs_create_file("ext", 0444, debugfs_sched, NULL, &sched_ext_fops);
> +#endif
>  	return 0;
>  }
>  late_initcall(sched_init_debug);
> @@ -1085,6 +1088,9 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		P(dl.runtime);
>  		P(dl.deadline);
>  	}
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	__PS("ext.enabled", task_on_scx(p));
> +#endif
>  #undef PN_SCHEDSTAT
>  #undef P_SCHEDSTAT
>  
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> new file mode 100644
> index 000000000000..7b78f77d2293
> --- /dev/null
> +++ b/kernel/sched/ext.c
> @@ -0,0 +1,3158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
> + * Copyright (c) 2022 David Vernet <dvernet@meta.com>
> + */
> +#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> +
> +enum scx_internal_consts {
> +	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
> +	SCX_DSP_DFL_MAX_BATCH	= 32,
> +};
> +
> +enum scx_ops_enable_state {
> +	SCX_OPS_PREPPING,
> +	SCX_OPS_ENABLING,
> +	SCX_OPS_ENABLED,
> +	SCX_OPS_DISABLING,
> +	SCX_OPS_DISABLED,
> +};
> +
> +/*
> + * sched_ext_entity->ops_state
> + *
> + * Used to track the task ownership between the SCX core and the BPF scheduler.
> + * State transitions look as follows:
> + *
> + * NONE -> QUEUEING -> QUEUED -> DISPATCHING
> + *   ^              |                 |
> + *   |              v                 v
> + *   \-------------------------------/
> + *
> + * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
> + * sites for explanations on the conditions being waited upon and why they are
> + * safe. Transitions out of them into NONE or QUEUED must store_release and the
> + * waiters should load_acquire.
> + *
> + * Tracking scx_ops_state enables sched_ext core to reliably determine whether
> + * any given task can be dispatched by the BPF scheduler at all times and thus
> + * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
> + * to try to dispatch any task anytime regardless of its state as the SCX core
> + * can safely reject invalid dispatches.
> + */
> +enum scx_ops_state {
> +	SCX_OPSS_NONE,		/* owned by the SCX core */
> +	SCX_OPSS_QUEUEING,	/* in transit to the BPF scheduler */
> +	SCX_OPSS_QUEUED,	/* owned by the BPF scheduler */
> +	SCX_OPSS_DISPATCHING,	/* in transit back to the SCX core */
> +
> +	/*
> +	 * QSEQ brands each QUEUED instance so that, when dispatch races
> +	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
> +	 * on the task being dispatched.
> +	 *
> +	 * As some 32bit archs can't do 64bit store_release/load_acquire,
> +	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
> +	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
> +	 * and runs with IRQ disabled. 30 bits should be sufficient.
> +	 */
> +	SCX_OPSS_QSEQ_SHIFT	= 2,
> +};
> +
> +/* Use macros to ensure that the type is unsigned long for the masks */
> +#define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
> +#define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
> +
> +/*
> + * During exit, a task may schedule after losing its PIDs. When disabling the
> + * BPF scheduler, we need to be able to iterate tasks in every state to
> + * guarantee system safety. Maintain a dedicated task list which contains every
> + * task between its fork and eventual free.
> + */
> +static DEFINE_SPINLOCK(scx_tasks_lock);
> +static LIST_HEAD(scx_tasks);
> +
> +/* ops enable/disable */
> +static struct kthread_worker *scx_ops_helper;
> +static DEFINE_MUTEX(scx_ops_enable_mutex);
> +DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
> +DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
> +static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
> +static struct sched_ext_ops scx_ops;
> +static bool scx_warned_zero_slice;
> +
> +static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
> +static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
> +static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> +
> +struct static_key_false scx_has_op[SCX_NR_ONLINE_OPS] =
> +	{ [0 ... SCX_NR_ONLINE_OPS-1] = STATIC_KEY_FALSE_INIT };
> +
> +static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
> +static struct scx_exit_info scx_exit_info;
> +
> +/* idle tracking */
> +#ifdef CONFIG_SMP
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +#define CL_ALIGNED_IF_ONSTACK
> +#else
> +#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
> +#endif
> +
> +static struct {
> +	cpumask_var_t cpu;
> +	cpumask_var_t smt;
> +} idle_masks CL_ALIGNED_IF_ONSTACK;
> +
> +#endif	/* CONFIG_SMP */
> +
> +/*
> + * Direct dispatch marker.
> + *
> + * Non-NULL values are used for direct dispatch from enqueue path. A valid
> + * pointer points to the task currently being enqueued. An ERR_PTR value is used
> + * to indicate that direct dispatch has already happened.
> + */
> +static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
> +
> +/* dispatch queues */
> +static struct scx_dispatch_q __cacheline_aligned_in_smp scx_dsq_global;
> +
> +static const struct rhashtable_params dsq_hash_params = {
> +	.key_len		= 8,
> +	.key_offset		= offsetof(struct scx_dispatch_q, id),
> +	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
> +};
> +
> +static struct rhashtable dsq_hash;
> +static LLIST_HEAD(dsqs_to_free);
> +
> +/* dispatch buf */
> +struct scx_dsp_buf_ent {
> +	struct task_struct	*task;
> +	unsigned long		qseq;
> +	u64			dsq_id;
> +	u64			enq_flags;
> +};
> +
> +static u32 scx_dsp_max_batch;
> +static struct scx_dsp_buf_ent __percpu *scx_dsp_buf;
> +
> +struct scx_dsp_ctx {
> +	struct rq		*rq;
> +	struct rq_flags		*rf;
> +	u32			buf_cursor;
> +	u32			nr_tasks;
> +};
> +
> +static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
> +
> +void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
> +		      u64 enq_flags);
> +__printf(2, 3) static void scx_ops_error_kind(enum scx_exit_kind kind,
> +					      const char *fmt, ...);
> +#define scx_ops_error(fmt, args...)						\
> +	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
> +
> +struct scx_task_iter {
> +	struct sched_ext_entity		cursor;
> +	struct task_struct		*locked;
> +	struct rq			*rq;
> +	struct rq_flags			rf;
> +};
> +
> +#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
> +
> +/* if the highest set bit is N, return a mask with bits [N+1, 31] set */
> +static u32 higher_bits(u32 flags)
> +{
> +	return ~((1 << fls(flags)) - 1);
> +}
> +
> +/* return the mask with only the highest bit set */
> +static u32 highest_bit(u32 flags)
> +{
> +	int bit = fls(flags);
> +	return bit ? 1 << (bit - 1) : 0;
> +}
> +
> +/*
> + * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
> + * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
> + * the allowed kfuncs and those kfuncs should use scx_kf_allowed() to check
> + * whether it's running from an allowed context.
> + *
> + * @mask is constant, always inline to cull the mask calculations.
> + */
> +static __always_inline void scx_kf_allow(u32 mask)
> +{
> +	/* nesting is allowed only in increasing scx_kf_mask order */
> +	WARN_ONCE((mask | higher_bits(mask)) & current->scx.kf_mask,
> +		  "invalid nesting current->scx.kf_mask=0x%x mask=0x%x\n",
> +		  current->scx.kf_mask, mask);
> +	current->scx.kf_mask |= mask;
> +}
> +
> +static void scx_kf_disallow(u32 mask)
> +{
> +	current->scx.kf_mask &= ~mask;
> +}
> +
> +#define SCX_CALL_OP(mask, op, args...)						\
> +do {										\
> +	if (mask) {								\
> +		scx_kf_allow(mask);						\
> +		scx_ops.op(args);						\
> +		scx_kf_disallow(mask);						\
> +	} else {								\
> +		scx_ops.op(args);						\
> +	}									\
> +} while (0)
> +
> +#define SCX_CALL_OP_RET(mask, op, args...)					\
> +({										\
> +	__typeof__(scx_ops.op(args)) __ret;					\
> +	if (mask) {								\
> +		scx_kf_allow(mask);						\
> +		__ret = scx_ops.op(args);					\
> +		scx_kf_disallow(mask);						\
> +	} else {								\
> +		__ret = scx_ops.op(args);					\
> +	}									\
> +	__ret;									\
> +})
> +
> +/* @mask is constant, always inline to cull unnecessary branches */
> +static __always_inline bool scx_kf_allowed(u32 mask)
> +{
> +	if (unlikely(!(current->scx.kf_mask & mask))) {
> +		scx_ops_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
> +			      mask, current->scx.kf_mask);
> +		return false;
> +	}
> +
> +	if (unlikely((mask & (SCX_KF_INIT | SCX_KF_SLEEPABLE)) &&
> +		     in_interrupt())) {
> +		scx_ops_error("sleepable kfunc called from non-sleepable context");
> +		return false;
> +	}
> +
> +	/*
> +	 * Enforce nesting boundaries. e.g. A kfunc which can be called from
> +	 * DISPATCH must not be called if we're running DEQUEUE which is nested
> +	 * inside ops.dispatch(). We don't need to check the SCX_KF_SLEEPABLE
> +	 * boundary thanks to the above in_interrupt() check.
> +	 */
> +	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
> +		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
> +		scx_ops_error("dispatch kfunc called from a nested operation");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/**
> + * scx_task_iter_init - Initialize a task iterator
> + * @iter: iterator to init
> + *
> + * Initialize @iter. Must be called with scx_tasks_lock held. Once initialized,
> + * @iter must eventually be exited with scx_task_iter_exit().
> + *
> + * scx_tasks_lock may be released between this and the first next() call or
> + * between any two next() calls. If scx_tasks_lock is released between two
> + * next() calls, the caller is responsible for ensuring that the task being
> + * iterated remains accessible either through RCU read lock or obtaining a
> + * reference count.
> + *
> + * All tasks which existed when the iteration started are guaranteed to be
> + * visited as long as they still exist.
> + */
> +static void scx_task_iter_init(struct scx_task_iter *iter)
> +{
> +	lockdep_assert_held(&scx_tasks_lock);
> +
> +	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
> +	list_add(&iter->cursor.tasks_node, &scx_tasks);
> +	iter->locked = NULL;
> +}
> +
> +/**
> + * scx_task_iter_exit - Exit a task iterator
> + * @iter: iterator to exit
> + *
> + * Exit a previously initialized @iter. Must be called with scx_tasks_lock held.
> + * If the iterator holds a task's rq lock, that rq lock is released. See
> + * scx_task_iter_init() for details.
> + */
> +static void scx_task_iter_exit(struct scx_task_iter *iter)
> +{
> +	struct list_head *cursor = &iter->cursor.tasks_node;
> +
> +	lockdep_assert_held(&scx_tasks_lock);
> +
> +	if (iter->locked) {
> +		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
> +		iter->locked = NULL;
> +	}
> +
> +	if (list_empty(cursor))
> +		return;
> +
> +	list_del_init(cursor);
> +}
> +
> +/**
> + * scx_task_iter_next - Next task
> + * @iter: iterator to walk
> + *
> + * Visit the next task. See scx_task_iter_init() for details.
> + */
> +static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
> +{
> +	struct list_head *cursor = &iter->cursor.tasks_node;
> +	struct sched_ext_entity *pos;
> +
> +	lockdep_assert_held(&scx_tasks_lock);
> +
> +	list_for_each_entry(pos, cursor, tasks_node) {
> +		if (&pos->tasks_node == &scx_tasks)
> +			return NULL;
> +		if (!(pos->flags & SCX_TASK_CURSOR)) {
> +			list_move(cursor, &pos->tasks_node);
> +			return container_of(pos, struct task_struct, scx);
> +		}
> +	}
> +
> +	/* can't happen, should always terminate at scx_tasks above */
> +	BUG();
> +}
> +
> +/**
> + * scx_task_iter_next_filtered - Next non-idle task
> + * @iter: iterator to walk
> + *
> + * Visit the next non-idle task. See scx_task_iter_init() for details.
> + */
> +static struct task_struct *
> +scx_task_iter_next_filtered(struct scx_task_iter *iter)
> +{
> +	struct task_struct *p;
> +
> +	while ((p = scx_task_iter_next(iter))) {
> +		/*
> +		 * is_idle_task() tests %PF_IDLE which may not be set for CPUs
> +		 * which haven't yet been onlined. Test sched_class directly.
> +		 */
> +		if (p->sched_class != &idle_sched_class)
> +			return p;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * scx_task_iter_next_filtered_locked - Next non-idle task with its rq locked
> + * @iter: iterator to walk
> + *
> + * Visit the next non-idle task with its rq lock held. See scx_task_iter_init()
> + * for details.
> + */
> +static struct task_struct *
> +scx_task_iter_next_filtered_locked(struct scx_task_iter *iter)
> +{
> +	struct task_struct *p;
> +
> +	if (iter->locked) {
> +		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
> +		iter->locked = NULL;
> +	}
> +
> +	p = scx_task_iter_next_filtered(iter);
> +	if (!p)
> +		return NULL;
> +
> +	iter->rq = task_rq_lock(p, &iter->rf);
> +	iter->locked = p;
> +	return p;
> +}
> +
> +static enum scx_ops_enable_state scx_ops_enable_state(void)
> +{
> +	return atomic_read(&scx_ops_enable_state_var);
> +}
> +
> +static enum scx_ops_enable_state
> +scx_ops_set_enable_state(enum scx_ops_enable_state to)
> +{
> +	return atomic_xchg(&scx_ops_enable_state_var, to);
> +}
> +
> +static bool scx_ops_tryset_enable_state(enum scx_ops_enable_state to,
> +					enum scx_ops_enable_state from)
> +{
> +	int from_v = from;
> +
> +	return atomic_try_cmpxchg(&scx_ops_enable_state_var, &from_v, to);
> +}
> +
> +static bool scx_ops_disabling(void)
> +{
> +	return unlikely(scx_ops_enable_state() == SCX_OPS_DISABLING);
> +}
> +
> +/**
> + * wait_ops_state - Busy-wait the specified ops state to end
> + * @p: target task
> + * @opss: state to wait the end of
> + *
> + * Busy-wait for @p to transition out of @opss. This can only be used when the
> + * state part of @opss is %SCX_QUEUEING or %SCX_DISPATCHING. This function also
> + * has load_acquire semantics to ensure that the caller can see the updates made
> + * in the enqueueing and dispatching paths.
> + */
> +static void wait_ops_state(struct task_struct *p, unsigned long opss)
> +{
> +	do {
> +		cpu_relax();
> +	} while (atomic_long_read_acquire(&p->scx.ops_state) == opss);
> +}
> +
> +/**
> + * ops_cpu_valid - Verify a cpu number
> + * @cpu: cpu number which came from a BPF ops
> + *
> + * @cpu is a cpu number which came from the BPF scheduler and can be any value.
> + * Verify that it is in range and one of the possible cpus.
> + */
> +static bool ops_cpu_valid(s32 cpu)
> +{
> +	return likely(cpu >= 0 && cpu < nr_cpu_ids && cpu_possible(cpu));
> +}
> +
> +/**
> + * ops_sanitize_err - Sanitize a -errno value
> + * @ops_name: operation to blame on failure
> + * @err: -errno value to sanitize
> + *
> + * Verify @err is a valid -errno. If not, trigger scx_ops_error() and return
> + * -%EPROTO. This is necessary because returning a rogue -errno up the chain can
> + * cause misbehaviors. For an example, a large negative return from
> + * ops.prep_enable() triggers an oops when passed up the call chain because the
> + * value fails IS_ERR() test after being encoded with ERR_PTR() and then is
> + * handled as a pointer.
> + */
> +static int ops_sanitize_err(const char *ops_name, s32 err)
> +{
> +	if (err < 0 && err >= -MAX_ERRNO)
> +		return err;
> +
> +	scx_ops_error("ops.%s() returned an invalid errno %d", ops_name, err);
> +	return -EPROTO;
> +}
> +
> +static void update_curr_scx(struct rq *rq)
> +{
> +	struct task_struct *curr = rq->curr;
> +	u64 now = rq_clock_task(rq);
> +	u64 delta_exec;
> +
> +	if (time_before_eq64(now, curr->se.exec_start))
> +		return;
> +
> +	delta_exec = now - curr->se.exec_start;
> +	curr->se.exec_start = now;
> +	curr->se.sum_exec_runtime += delta_exec;
> +	account_group_exec_runtime(curr, delta_exec);
> +	cgroup_account_cputime(curr, delta_exec);
> +
> +	curr->scx.slice -= min(curr->scx.slice, delta_exec);
> +}
> +
> +static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
> +			     u64 enq_flags)
> +{
> +	bool is_local = dsq->id == SCX_DSQ_LOCAL;
> +
> +	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
> +
> +	if (!is_local) {
> +		raw_spin_lock(&dsq->lock);
> +		if (unlikely(dsq->id == SCX_DSQ_INVALID)) {
> +			scx_ops_error("attempting to dispatch to a destroyed dsq");
> +			/* fall back to the global dsq */
> +			raw_spin_unlock(&dsq->lock);
> +			dsq = &scx_dsq_global;
> +			raw_spin_lock(&dsq->lock);
> +		}
> +	}
> +
> +	if (enq_flags & SCX_ENQ_HEAD)
> +		list_add(&p->scx.dsq_node, &dsq->fifo);
> +	else
> +		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
> +	dsq->nr++;
> +	p->scx.dsq = dsq;
> +
> +	/*
> +	 * We're transitioning out of QUEUEING or DISPATCHING. store_release to
> +	 * match waiters' load_acquire.
> +	 */
> +	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
> +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> +
> +	if (is_local) {
> +		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
> +
> +		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
> +			resched_curr(rq);
> +	} else {
> +		raw_spin_unlock(&dsq->lock);
> +	}
> +}
> +
> +static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
> +{
> +	struct scx_dispatch_q *dsq = p->scx.dsq;
> +	bool is_local = dsq == &scx_rq->local_dsq;
> +
> +	if (!dsq) {
> +		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
> +		/*
> +		 * When dispatching directly from the BPF scheduler to a local
> +		 * DSQ, the task isn't associated with any DSQ but
> +		 * @p->scx.holding_cpu may be set under the protection of
> +		 * %SCX_OPSS_DISPATCHING.
> +		 */
> +		if (p->scx.holding_cpu >= 0)
> +			p->scx.holding_cpu = -1;
> +		return;
> +	}
> +
> +	if (!is_local)
> +		raw_spin_lock(&dsq->lock);
> +
> +	/*
> +	 * Now that we hold @dsq->lock, @p->holding_cpu and @p->scx.dsq_node
> +	 * can't change underneath us.
> +	*/
> +	if (p->scx.holding_cpu < 0) {
> +		/* @p must still be on @dsq, dequeue */
> +		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
> +		list_del_init(&p->scx.dsq_node);
> +		dsq->nr--;
> +	} else {
> +		/*
> +		 * We're racing against dispatch_to_local_dsq() which already
> +		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
> +		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
> +		 * the race.
> +		 */
> +		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
> +		p->scx.holding_cpu = -1;
> +	}
> +	p->scx.dsq = NULL;
> +
> +	if (!is_local)
> +		raw_spin_unlock(&dsq->lock);
> +}
> +
> +static struct scx_dispatch_q *find_non_local_dsq(u64 dsq_id)
> +{
> +	lockdep_assert(rcu_read_lock_any_held());
> +
> +	if (dsq_id == SCX_DSQ_GLOBAL)
> +		return &scx_dsq_global;
> +	else
> +		return rhashtable_lookup_fast(&dsq_hash, &dsq_id,
> +					      dsq_hash_params);
> +}
> +
> +static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
> +						    struct task_struct *p)
> +{
> +	struct scx_dispatch_q *dsq;
> +
> +	if (dsq_id == SCX_DSQ_LOCAL)
> +		return &rq->scx.local_dsq;
> +
> +	dsq = find_non_local_dsq(dsq_id);
> +	if (unlikely(!dsq)) {
> +		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
> +			      dsq_id, p->comm, p->pid);
> +		return &scx_dsq_global;
> +	}
> +
> +	return dsq;
> +}
> +
> +static void direct_dispatch(struct task_struct *ddsp_task, struct task_struct *p,
> +			    u64 dsq_id, u64 enq_flags)
> +{
> +	struct scx_dispatch_q *dsq;
> +
> +	/* @p must match the task which is being enqueued */
> +	if (unlikely(p != ddsp_task)) {
> +		if (IS_ERR(ddsp_task))
> +			scx_ops_error("%s[%d] already direct-dispatched",
> +				      p->comm, p->pid);
> +		else
> +			scx_ops_error("enqueueing %s[%d] but trying to direct-dispatch %s[%d]",
> +				      ddsp_task->comm, ddsp_task->pid,
> +				      p->comm, p->pid);
> +		return;
> +	}
> +
> +	/*
> +	 * %SCX_DSQ_LOCAL_ON is not supported during direct dispatch because
> +	 * dispatching to the local DSQ of a different CPU requires unlocking
> +	 * the current rq which isn't allowed in the enqueue path. Use
> +	 * ops.select_cpu() to be on the target CPU and then %SCX_DSQ_LOCAL.
> +	 */
> +	if (unlikely((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON)) {
> +		scx_ops_error("SCX_DSQ_LOCAL_ON can't be used for direct-dispatch");
> +		return;
> +	}
> +
> +	dsq = find_dsq_for_dispatch(task_rq(p), dsq_id, p);
> +	dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> +
> +	/*
> +	 * Mark that dispatch already happened by spoiling direct_dispatch_task
> +	 * with a non-NULL value which can never match a valid task pointer.
> +	 */
> +	__this_cpu_write(direct_dispatch_task, ERR_PTR(-ESRCH));
> +}
> +
> +static bool test_rq_online(struct rq *rq)
> +{
> +#ifdef CONFIG_SMP
> +	return rq->online;
> +#else
> +	return true;
> +#endif
> +}
> +
> +static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
> +			    int sticky_cpu)
> +{
> +	struct task_struct **ddsp_taskp;
> +	unsigned long qseq;
> +
> +	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
> +
> +	if (p->scx.flags & SCX_TASK_ENQ_LOCAL) {
> +		enq_flags |= SCX_ENQ_LOCAL;
> +		p->scx.flags &= ~SCX_TASK_ENQ_LOCAL;
> +	}
> +
> +	/* rq migration */
> +	if (sticky_cpu == cpu_of(rq))
> +		goto local_norefill;
> +
> +	/*
> +	 * If !rq->online, we already told the BPF scheduler that the CPU is
> +	 * offline. We're just trying to on/offline the CPU. Don't bother the
> +	 * BPF scheduler.
> +	 */
> +	if (unlikely(!test_rq_online(rq)))
> +		goto local;
> +
> +	/* see %SCX_OPS_ENQ_EXITING */
> +	if (!static_branch_unlikely(&scx_ops_enq_exiting) &&
> +	    unlikely(p->flags & PF_EXITING))
> +		goto local;
> +
> +	/* see %SCX_OPS_ENQ_LAST */
> +	if (!static_branch_unlikely(&scx_ops_enq_last) &&
> +	    (enq_flags & SCX_ENQ_LAST))
> +		goto local;
> +
> +	if (!SCX_HAS_OP(enqueue)) {
> +		if (enq_flags & SCX_ENQ_LOCAL)
> +			goto local;
> +		else
> +			goto global;
> +	}
> +
> +	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
> +	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
> +
> +	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> +	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
> +
> +	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
> +	WARN_ON_ONCE(*ddsp_taskp);
> +	*ddsp_taskp = p;
> +
> +	SCX_CALL_OP(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
> +
> +	/*
> +	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
> +	 * dequeue may be waiting. The store_release matches their load_acquire.
> +	 */
> +	if (*ddsp_taskp == p)
> +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUED | qseq);
> +	*ddsp_taskp = NULL;
> +	return;
> +
> +local:
> +	p->scx.slice = SCX_SLICE_DFL;
> +local_norefill:
> +	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
> +	return;
> +
> +global:
> +	p->scx.slice = SCX_SLICE_DFL;
> +	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
> +}
> +
> +static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
> +{
> +	int sticky_cpu = p->scx.sticky_cpu;
> +
> +	enq_flags |= rq->scx.extra_enq_flags;
> +
> +	if (sticky_cpu >= 0)
> +		p->scx.sticky_cpu = -1;
> +
> +	/*
> +	 * Restoring a running task will be immediately followed by
> +	 * set_next_task_scx() which expects the task to not be on the BPF
> +	 * scheduler as tasks can only start running through local DSQs. Force
> +	 * direct-dispatch into the local DSQ by setting the sticky_cpu.
> +	 */
> +	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
> +		sticky_cpu = cpu_of(rq);
> +
> +	if (p->scx.flags & SCX_TASK_QUEUED)
> +		return;
> +
> +	p->scx.flags |= SCX_TASK_QUEUED;
> +	rq->scx.nr_running++;
> +	add_nr_running(rq, 1);
> +
> +	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
> +}
> +
> +static void ops_dequeue(struct task_struct *p, u64 deq_flags)
> +{
> +	unsigned long opss;
> +
> +	/* acquire ensures that we see the preceding updates on QUEUED */
> +	opss = atomic_long_read_acquire(&p->scx.ops_state);
> +
> +	switch (opss & SCX_OPSS_STATE_MASK) {
> +	case SCX_OPSS_NONE:
> +		break;
> +	case SCX_OPSS_QUEUEING:
> +		/*
> +		 * QUEUEING is started and finished while holding @p's rq lock.
> +		 * As we're holding the rq lock now, we shouldn't see QUEUEING.
> +		 */
> +		BUG();
> +	case SCX_OPSS_QUEUED:
> +		if (SCX_HAS_OP(dequeue))
> +			SCX_CALL_OP(SCX_KF_REST, dequeue, p, deq_flags);
> +
> +		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
> +					    SCX_OPSS_NONE))
> +			break;
> +		fallthrough;
> +	case SCX_OPSS_DISPATCHING:
> +		/*
> +		 * If @p is being dispatched from the BPF scheduler to a DSQ,
> +		 * wait for the transfer to complete so that @p doesn't get
> +		 * added to its DSQ after dequeueing is complete.
> +		 *
> +		 * As we're waiting on DISPATCHING with the rq locked, the
> +		 * dispatching side shouldn't try to lock the rq while
> +		 * DISPATCHING is set. See dispatch_to_local_dsq().
> +		 *
> +		 * DISPATCHING shouldn't have qseq set and control can reach
> +		 * here with NONE @opss from the above QUEUED case block.
> +		 * Explicitly wait on %SCX_OPSS_DISPATCHING instead of @opss.
> +		 */
> +		wait_ops_state(p, SCX_OPSS_DISPATCHING);
> +		BUG_ON(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> +		break;
> +	}
> +}
> +
> +static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
> +{
> +	struct scx_rq *scx_rq = &rq->scx;
> +
> +	if (!(p->scx.flags & SCX_TASK_QUEUED))
> +		return;
> +
> +	ops_dequeue(p, deq_flags);
> +
> +	if (deq_flags & SCX_DEQ_SLEEP)
> +		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
> +	else
> +		p->scx.flags &= ~SCX_TASK_DEQD_FOR_SLEEP;
> +
> +	p->scx.flags &= ~SCX_TASK_QUEUED;
> +	scx_rq->nr_running--;
> +	sub_nr_running(rq, 1);
> +
> +	dispatch_dequeue(scx_rq, p);
> +}
> +
> +static void yield_task_scx(struct rq *rq)
> +{
> +	struct task_struct *p = rq->curr;
> +
> +	if (SCX_HAS_OP(yield))
> +		SCX_CALL_OP_RET(SCX_KF_REST, yield, p, NULL);
> +	else
> +		p->scx.slice = 0;
> +}
> +
> +static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
> +{
> +	struct task_struct *from = rq->curr;
> +
> +	if (SCX_HAS_OP(yield))
> +		return SCX_CALL_OP_RET(SCX_KF_REST, yield, from, to);
> +	else
> +		return false;
> +}
> +
> +#ifdef CONFIG_SMP
> +/**
> + * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
> + * @rq: rq to move the task into, currently locked
> + * @p: task to move
> + * @enq_flags: %SCX_ENQ_*
> + *
> + * Move @p which is currently on a different rq to @rq's local DSQ. The caller
> + * must:
> + *
> + * 1. Start with exclusive access to @p either through its DSQ lock or
> + *    %SCX_OPSS_DISPATCHING flag.
> + *
> + * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
> + *
> + * 3. Remember task_rq(@p). Release the exclusive access so that we don't
> + *    deadlock with dequeue.
> + *
> + * 4. Lock @rq and the task_rq from #3.
> + *
> + * 5. Call this function.
> + *
> + * Returns %true if @p was successfully moved. %false after racing dequeue and
> + * losing.
> + */
> +static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
> +				   u64 enq_flags)
> +{
> +	struct rq *task_rq;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * If dequeue got to @p while we were trying to lock both rq's, it'd
> +	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
> +	 * updated it to different values afterwards, as this operation can't be
> +	 * preempted or recurse, @p->scx.holding_cpu can never become
> +	 * raw_smp_processor_id() again before we're done. Thus, we can tell
> +	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
> +	 * still raw_smp_processor_id().
> +	 *
> +	 * See dispatch_dequeue() for the counterpart.
> +	 */
> +	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()))
> +		return false;
> +
> +	/* @p->rq couldn't have changed if we're still the holding cpu */
> +	task_rq = task_rq(p);
> +	lockdep_assert_rq_held(task_rq);
> +
> +	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
> +	deactivate_task(task_rq, p, 0);
> +	set_task_cpu(p, cpu_of(rq));
> +	p->scx.sticky_cpu = cpu_of(rq);
> +
> +	/*
> +	 * We want to pass scx-specific enq_flags but activate_task() will
> +	 * truncate the upper 32 bit. As we own @rq, we can pass them through
> +	 * @rq->scx.extra_enq_flags instead.
> +	 */
> +	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> +	rq->scx.extra_enq_flags = enq_flags;
> +	activate_task(rq, p, 0);
> +	rq->scx.extra_enq_flags = 0;
> +
> +	return true;
> +}
> +
> +/**
> + * dispatch_to_local_dsq_lock - Ensure source and desitnation rq's are locked
> + * @rq: current rq which is locked
> + * @rf: rq_flags to use when unlocking @rq
> + * @src_rq: rq to move task from
> + * @dst_rq: rq to move task to
> + *
> + * We're holding @rq lock and trying to dispatch a task from @src_rq to
> + * @dst_rq's local DSQ and thus need to lock both @src_rq and @dst_rq. Whether
> + * @rq stays locked isn't important as long as the state is restored after
> + * dispatch_to_local_dsq_unlock().
> + */
> +static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
> +				       struct rq *src_rq, struct rq *dst_rq)
> +{
> +	rq_unpin_lock(rq, rf);
> +
> +	if (src_rq == dst_rq) {
> +		raw_spin_rq_unlock(rq);
> +		raw_spin_rq_lock(dst_rq);
> +	} else if (rq == src_rq) {
> +		double_lock_balance(rq, dst_rq);
> +		rq_repin_lock(rq, rf);
> +	} else if (rq == dst_rq) {
> +		double_lock_balance(rq, src_rq);
> +		rq_repin_lock(rq, rf);
> +	} else {
> +		raw_spin_rq_unlock(rq);
> +		double_rq_lock(src_rq, dst_rq);
> +	}
> +}
> +
> +/**
> + * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
> + * @rq: current rq which is locked
> + * @rf: rq_flags to use when unlocking @rq
> + * @src_rq: rq to move task from
> + * @dst_rq: rq to move task to
> + *
> + * Unlock @src_rq and @dst_rq and ensure that @rq is locked on return.
> + */
> +static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
> +					 struct rq *src_rq, struct rq *dst_rq)
> +{
> +	if (src_rq == dst_rq) {
> +		raw_spin_rq_unlock(dst_rq);
> +		raw_spin_rq_lock(rq);
> +		rq_repin_lock(rq, rf);
> +	} else if (rq == src_rq) {
> +		double_unlock_balance(rq, dst_rq);
> +	} else if (rq == dst_rq) {
> +		double_unlock_balance(rq, src_rq);
> +	} else {
> +		double_rq_unlock(src_rq, dst_rq);
> +		raw_spin_rq_lock(rq);
> +		rq_repin_lock(rq, rf);
> +	}
> +}
> +#endif	/* CONFIG_SMP */
> +
> +
> +static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
> +			       struct scx_dispatch_q *dsq)
> +{
> +	struct scx_rq *scx_rq = &rq->scx;
> +	struct task_struct *p;
> +	struct rq *task_rq;
> +	bool moved = false;
> +retry:
> +	if (list_empty(&dsq->fifo))
> +		return false;
> +
> +	raw_spin_lock(&dsq->lock);
> +	list_for_each_entry(p, &dsq->fifo, scx.dsq_node) {
> +		task_rq = task_rq(p);
> +		if (rq == task_rq)
> +			goto this_rq;
> +		if (likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
> +		    cpumask_test_cpu(cpu_of(rq), p->cpus_ptr))
> +			goto remote_rq;
> +	}
> +	raw_spin_unlock(&dsq->lock);
> +	return false;
> +
> +this_rq:
> +	/* @dsq is locked and @p is on this rq */
> +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> +	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.fifo);
> +	dsq->nr--;
> +	scx_rq->local_dsq.nr++;
> +	p->scx.dsq = &scx_rq->local_dsq;
> +	raw_spin_unlock(&dsq->lock);
> +	return true;
> +
> +remote_rq:
> +#ifdef CONFIG_SMP
> +	/*
> +	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> +	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> +	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> +	 * rq lock or fail, do a little dancing from our side. See
> +	 * move_task_to_local_dsq().
> +	 */
> +	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
> +	list_del_init(&p->scx.dsq_node);
> +	dsq->nr--;
> +	p->scx.holding_cpu = raw_smp_processor_id();
> +	raw_spin_unlock(&dsq->lock);
> +
> +	rq_unpin_lock(rq, rf);
> +	double_lock_balance(rq, task_rq);
> +	rq_repin_lock(rq, rf);
> +
> +	moved = move_task_to_local_dsq(rq, p, 0);
> +
> +	double_unlock_balance(rq, task_rq);
> +#endif /* CONFIG_SMP */
> +	if (likely(moved))
> +		return true;
> +	goto retry;
> +}
> +
> +enum dispatch_to_local_dsq_ret {
> +	DTL_DISPATCHED,		/* successfully dispatched */
> +	DTL_LOST,		/* lost race to dequeue */
> +	DTL_NOT_LOCAL,		/* destination is not a local DSQ */
> +	DTL_INVALID,		/* invalid local dsq_id */
> +};
> +
> +/**
> + * dispatch_to_local_dsq - Dispatch a task to a local dsq
> + * @rq: current rq which is locked
> + * @rf: rq_flags to use when unlocking @rq
> + * @dsq_id: destination dsq ID
> + * @p: task to dispatch
> + * @enq_flags: %SCX_ENQ_*
> + *
> + * We're holding @rq lock and want to dispatch @p to the local DSQ identified by
> + * @dsq_id. This function performs all the synchronization dancing needed
> + * because local DSQs are protected with rq locks.
> + *
> + * The caller must have exclusive ownership of @p (e.g. through
> + * %SCX_OPSS_DISPATCHING).
> + */
> +static enum dispatch_to_local_dsq_ret
> +dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
> +		      struct task_struct *p, u64 enq_flags)
> +{
> +	struct rq *src_rq = task_rq(p);
> +	struct rq *dst_rq;
> +
> +	/*
> +	 * We're synchronized against dequeue through DISPATCHING. As @p can't
> +	 * be dequeued, its task_rq and cpus_allowed are stable too.
> +	 */
> +	if (dsq_id == SCX_DSQ_LOCAL) {
> +		dst_rq = rq;
> +	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
> +		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> +
> +		if (!ops_cpu_valid(cpu)) {
> +			scx_ops_error("invalid cpu %d in SCX_DSQ_LOCAL_ON verdict for %s[%d]",
> +				      cpu, p->comm, p->pid);
> +			return DTL_INVALID;
> +		}
> +		dst_rq = cpu_rq(cpu);
> +	} else {
> +		return DTL_NOT_LOCAL;
> +	}
> +
> +	/* if dispatching to @rq that @p is already on, no lock dancing needed */
> +	if (rq == src_rq && rq == dst_rq) {
> +		dispatch_enqueue(&dst_rq->scx.local_dsq, p,
> +				 enq_flags | SCX_ENQ_CLEAR_OPSS);
> +		return DTL_DISPATCHED;
> +	}
> +
> +#ifdef CONFIG_SMP
> +	if (cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr)) {
> +		struct rq *locked_dst_rq = dst_rq;
> +		bool dsp;
> +
> +		/*
> +		 * @p is on a possibly remote @src_rq which we need to lock to
> +		 * move the task. If dequeue is in progress, it'd be locking
> +		 * @src_rq and waiting on DISPATCHING, so we can't grab @src_rq
> +		 * lock while holding DISPATCHING.
> +		 *
> +		 * As DISPATCHING guarantees that @p is wholly ours, we can
> +		 * pretend that we're moving from a DSQ and use the same
> +		 * mechanism - mark the task under transfer with holding_cpu,
> +		 * release DISPATCHING and then follow the same protocol.
> +		 */
> +		p->scx.holding_cpu = raw_smp_processor_id();
> +
> +		/* store_release ensures that dequeue sees the above */
> +		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> +
> +		dispatch_to_local_dsq_lock(rq, rf, src_rq, locked_dst_rq);
> +
> +		/*
> +		 * We don't require the BPF scheduler to avoid dispatching to
> +		 * offline CPUs mostly for convenience but also because CPUs can
> +		 * go offline between scx_bpf_dispatch() calls and here. If @p
> +		 * is destined to an offline CPU, queue it on its current CPU
> +		 * instead, which should always be safe. As this is an allowed
> +		 * behavior, don't trigger an ops error.
> +		 */
> +		if (unlikely(!test_rq_online(dst_rq)))
> +			dst_rq = src_rq;
> +
> +		if (src_rq == dst_rq) {
> +			/*
> +			 * As @p is staying on the same rq, there's no need to
> +			 * go through the full deactivate/activate cycle.
> +			 * Optimize by abbreviating the operations in
> +			 * move_task_to_local_dsq().
> +			 */
> +			dsp = p->scx.holding_cpu == raw_smp_processor_id();
> +			if (likely(dsp)) {
> +				p->scx.holding_cpu = -1;
> +				dispatch_enqueue(&dst_rq->scx.local_dsq, p,
> +						 enq_flags);
> +			}
> +		} else {
> +			dsp = move_task_to_local_dsq(dst_rq, p, enq_flags);
> +		}
> +
> +		/* if the destination CPU is idle, wake it up */
> +		if (dsp && p->sched_class > dst_rq->curr->sched_class)
> +			resched_curr(dst_rq);
> +
> +		dispatch_to_local_dsq_unlock(rq, rf, src_rq, locked_dst_rq);
> +
> +		return dsp ? DTL_DISPATCHED : DTL_LOST;
> +	}
> +#endif /* CONFIG_SMP */
> +
> +	scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
> +		      cpu_of(dst_rq), p->comm, p->pid);
> +	return DTL_INVALID;
> +}
> +
> +/**
> + * finish_dispatch - Asynchronously finish dispatching a task
> + * @rq: current rq which is locked
> + * @rf: rq_flags to use when unlocking @rq
> + * @p: task to finish dispatching
> + * @qseq_at_dispatch: qseq when @p started getting dispatched
> + * @dsq_id: destination DSQ ID
> + * @enq_flags: %SCX_ENQ_*
> + *
> + * Dispatching to local DSQs may need to wait for queueing to complete or
> + * require rq lock dancing. As we don't wanna do either while inside
> + * ops.dispatch() to avoid locking order inversion, we split dispatching into
> + * two parts. scx_bpf_dispatch() which is called by ops.dispatch() records the
> + * task and its qseq. Once ops.dispatch() returns, this function is called to
> + * finish up.
> + *
> + * There is no guarantee that @p is still valid for dispatching or even that it
> + * was valid in the first place. Make sure that the task is still owned by the
> + * BPF scheduler and claim the ownership before dispatching.
> + */
> +static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
> +			    struct task_struct *p,
> +			    unsigned long qseq_at_dispatch,
> +			    u64 dsq_id, u64 enq_flags)
> +{
> +	struct scx_dispatch_q *dsq;
> +	unsigned long opss;
> +
> +retry:
> +	/*
> +	 * No need for _acquire here. @p is accessed only after a successful
> +	 * try_cmpxchg to DISPATCHING.
> +	 */
> +	opss = atomic_long_read(&p->scx.ops_state);
> +
> +	switch (opss & SCX_OPSS_STATE_MASK) {
> +	case SCX_OPSS_DISPATCHING:
> +	case SCX_OPSS_NONE:
> +		/* someone else already got to it */
> +		return;
> +	case SCX_OPSS_QUEUED:
> +		/*
> +		 * If qseq doesn't match, @p has gone through at least one
> +		 * dispatch/dequeue and re-enqueue cycle between
> +		 * scx_bpf_dispatch() and here and we have no claim on it.
> +		 */
> +		if ((opss & SCX_OPSS_QSEQ_MASK) != qseq_at_dispatch)
> +			return;
> +
> +		/*
> +		 * While we know @p is accessible, we don't yet have a claim on
> +		 * it - the BPF scheduler is allowed to dispatch tasks
> +		 * spuriously and there can be a racing dequeue attempt. Let's
> +		 * claim @p by atomically transitioning it from QUEUED to
> +		 * DISPATCHING.
> +		 */
> +		if (likely(atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
> +						   SCX_OPSS_DISPATCHING)))
> +			break;
> +		goto retry;
> +	case SCX_OPSS_QUEUEING:
> +		/*
> +		 * do_enqueue_task() is in the process of transferring the task
> +		 * to the BPF scheduler while holding @p's rq lock. As we aren't
> +		 * holding any kernel or BPF resource that the enqueue path may
> +		 * depend upon, it's safe to wait.
> +		 */
> +		wait_ops_state(p, opss);
> +		goto retry;
> +	}
> +
> +	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
> +
> +	switch (dispatch_to_local_dsq(rq, rf, dsq_id, p, enq_flags)) {
> +	case DTL_DISPATCHED:
> +		break;
> +	case DTL_LOST:
> +		break;
> +	case DTL_INVALID:
> +		dsq_id = SCX_DSQ_GLOBAL;
> +		fallthrough;
> +	case DTL_NOT_LOCAL:
> +		dsq = find_dsq_for_dispatch(cpu_rq(raw_smp_processor_id()),
> +					    dsq_id, p);
> +		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> +		break;
> +	}
> +}
> +
> +static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
> +{
> +	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
> +	u32 u;
> +
> +	for (u = 0; u < dspc->buf_cursor; u++) {
> +		struct scx_dsp_buf_ent *ent = &this_cpu_ptr(scx_dsp_buf)[u];
> +
> +		finish_dispatch(rq, rf, ent->task, ent->qseq, ent->dsq_id,
> +				ent->enq_flags);
> +	}
> +
> +	dspc->nr_tasks += dspc->buf_cursor;
> +	dspc->buf_cursor = 0;
> +}
> +
> +static int balance_scx(struct rq *rq, struct task_struct *prev,
> +		       struct rq_flags *rf)
> +{
> +	struct scx_rq *scx_rq = &rq->scx;
> +	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
> +	bool prev_on_scx = prev->sched_class == &ext_sched_class;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	if (prev_on_scx) {
> +		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
> +		update_curr_scx(rq);
> +
> +		/*
> +		 * If @prev is runnable & has slice left, it has priority and
> +		 * fetching more just increases latency for the fetched tasks.
> +		 * Tell put_prev_task_scx() to put @prev on local_dsq.
> +		 *
> +		 * See scx_ops_disable_workfn() for the explanation on the
> +		 * disabling() test.
> +		 */
> +		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
> +		    prev->scx.slice && !scx_ops_disabling()) {
> +			prev->scx.flags |= SCX_TASK_BAL_KEEP;
> +			return 1;
> +		}
> +	}
> +
> +	/* if there already are tasks to run, nothing to do */
> +	if (scx_rq->local_dsq.nr)
> +		return 1;
> +
> +	if (consume_dispatch_q(rq, rf, &scx_dsq_global))
> +		return 1;
> +
> +	if (!SCX_HAS_OP(dispatch))
> +		return 0;
> +
> +	dspc->rq = rq;
> +	dspc->rf = rf;
> +
> +	/*
> +	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
> +	 * the local DSQ might still end up empty after a successful
> +	 * ops.dispatch(). If the local DSQ is empty even after ops.dispatch()
> +	 * produced some tasks, retry. The BPF scheduler may depend on this
> +	 * looping behavior to simplify its implementation.
> +	 */
> +	do {
> +		dspc->nr_tasks = 0;
> +
> +		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
> +			    prev_on_scx ? prev : NULL);
> +
> +		flush_dispatch_buf(rq, rf);
> +
> +		if (scx_rq->local_dsq.nr)
> +			return 1;
> +		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
> +			return 1;
> +	} while (dspc->nr_tasks);
> +
> +	return 0;
> +}
> +
> +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> +{
> +	if (p->scx.flags & SCX_TASK_QUEUED) {
> +		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);

Ditto. Even if this line is replaced later by
"[PATCH 31/36] sched_ext: Implement core-sched support"

> +		dispatch_dequeue(&rq->scx, p);
> +	}
> +
> +	p->se.exec_start = rq_clock_task(rq);
> +}

Thanks,
-Andrea

