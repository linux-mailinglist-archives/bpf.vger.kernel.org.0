Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689E439346B
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE0Q7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 12:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236701AbhE0Q65 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 May 2021 12:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622134643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DitiMvOfcxEoC9xo/1ZFhGzrLdHIy2GXYfTTFDefRGg=;
        b=Cz33BA0pDN5GvhVT0adSHVooh5lNmrGIpxNvrL3QpxguHvXv5SSn8j9jYYN1fqzcKSssYl
        VkqVBi73gNCi/lkZcMljT16JYtCFnkDXy6HIwgU1xzMuyZFUQrQD+azN0ftuM2Uc+rRkyU
        IQ3hzsd/92MiK0vykldweP7NO756tHc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-SWmbdw20MGqzyPi65xLCyw-1; Thu, 27 May 2021 12:57:21 -0400
X-MC-Unique: SWmbdw20MGqzyPi65xLCyw-1
Received: by mail-ej1-f72.google.com with SMTP id f7-20020a1709067f87b02903e18c4e1e85so254097ejr.20
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 09:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DitiMvOfcxEoC9xo/1ZFhGzrLdHIy2GXYfTTFDefRGg=;
        b=V1hFpSzcR9D88lS0V+mIMsugqRm3/CPqMUFuWq47PQvxX1g400Kyk7OdIxYtxZ+tvO
         LA4LVuewgBUT6ACcXdxFgSUwOM9xdLxMxwI7P+as9Wj231JiurVQW8bknys+TiQlXiZi
         9JhTginTonStDqkvJaf1e/cfe3p6leJwBQPOaKQfymx0f56yarLwYr9e7blSlZjQP4lM
         8Vqbr01vxDs4UulzcPpL9yLn8NIi/XkcA6t1zAZyb/ZFpPiFcpylDwCogs4rWXveegFp
         xfwmZ2gr9X6o8ocabn5OLi0UTVZg1P/q5kuIBEA6MQmdZJuAVsxkvMoATiLtXjwOEVO4
         f6Xw==
X-Gm-Message-State: AOAM531KRBrsMw/GN0Beddl09wytyAaNwqx/FtA4nOE/FxVmoQLGZn7H
        RBWUgl81RgiwMG68JZq+Zo8lYTiYEOUheiysRqmm2FLQndDuQ9vbMHjcLlHdyFbL2CJYo/wzqsB
        xlM/PsnBi3MUY
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr5047537ejj.442.1622134640501;
        Thu, 27 May 2021 09:57:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKp3kCmvV9OZnMXkDrUUSjtAo4khIz3SfQPcxqtQG9CqckVzFFupIXz5ah/iM252fnupRCcw==
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr5047505ejj.442.1622134640116;
        Thu, 27 May 2021 09:57:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hp1sm1207519ejc.96.2021.05.27.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 09:57:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CFB0918071B; Thu, 27 May 2021 18:57:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce bpf_timer
In-Reply-To: <20210527040259.77823-2-alexei.starovoitov@gmail.com>
References: <20210527040259.77823-1-alexei.starovoitov@gmail.com>
 <20210527040259.77823-2-alexei.starovoitov@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 27 May 2021 18:57:17 +0200
Message-ID: <87r1hsgln6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce 'struct bpf_timer { __u64 :64; };' that can be embedded
> in hash/array/lru maps as regular field and helpers to operate on it:
> long bpf_timer_init(struct bpf_timer *timer, void *callback, int flags);
> long bpf_timer_start(struct bpf_timer *timer, u64 nsecs);
> long bpf_timer_cancel(struct bpf_timer *timer);
>
> Here is how BPF program might look like:
> struct map_elem {
>     int counter;
>     struct bpf_timer timer;
> };
>
> struct {
>     __uint(type, BPF_MAP_TYPE_HASH);
>     __uint(max_entries, 1000);
>     __type(key, int);
>     __type(value, struct map_elem);
> } hmap SEC(".maps");
>
> struct bpf_timer global_timer;
>
> static int timer_cb1(void *map, int *key, __u64 *data);
> /* global_timer is in bss which is special bpf array of one element.
>  * data points to beginning of bss.
>  */
>
> static int timer_cb2(void *map, int *key, struct map_elem *val);
> /* val points to particular map element that contains bpf_timer. */
>
> SEC("fentry/bpf_fentry_test1")
> int BPF_PROG(test1, int a)
> {
>     struct map_elem *val;
>     int key = 0;
>     bpf_timer_init(&global_timer, timer_cb1, 0);
>     bpf_timer_start(&global_timer, 0 /* call timer_cb1 asap */);
>
>     val = bpf_map_lookup_elem(&hmap, &key);
>     if (val) {
>         bpf_timer_init(&val->timer, timer_cb2, 0);
>         bpf_timer_start(&val->timer, 1000 /* call timer_cb2 in 1 msec */);

nit: there are 1M nanoseconds in a millisecond :)

>     }
> }
>
> This patch adds helper implementations that rely on hrtimers
> to call bpf functions as timers expire.
> The following patch adds necessary safety checks.
>
> Only programs with CAP_BPF are allowed to use bpf_timer.
>
> The amount of timers used by the program is constrained by
> the memcg recorded at map creation time.
>
> The bpf_timer_init() helper is receiving hidden 'map' and 'prog' arguments
> supplied by the verifier. The prog pointer is needed to do refcnting of bpf
> program to make sure that program doesn't get freed while timer is armed.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Overall this LGTM, and I believe it will be usable for my intended use
case. One question:

With this, it will basically be possible to create a BPF daemon, won't
it? I.e., if a program includes a timer and the callback keeps re-arming
itself this will continue indefinitely even if userspace closes all refs
to maps and programs? Not saying this is a problem, just wanted to check
my understanding (i.e., that there's not some hidden requirement on
userspace keeping a ref open that I'm missing)...

A few other nits below:

> ---
>  include/linux/bpf.h            |   1 +
>  include/uapi/linux/bpf.h       |  26 ++++++
>  kernel/bpf/helpers.c           | 160 +++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 110 +++++++++++++++++++++++
>  kernel/trace/bpf_trace.c       |   2 +-
>  scripts/bpf_doc.py             |   2 +
>  tools/include/uapi/linux/bpf.h |  26 ++++++
>  7 files changed, 326 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1e9a0ff3217b..925b8416ea0a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -314,6 +314,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
>  	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
>  	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
> +	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
>  	__BPF_ARG_TYPE_MAX,
>  };
>  
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 562adeac1d67..3da901d5076b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4774,6 +4774,25 @@ union bpf_attr {
>   * 		Execute close syscall for given FD.
>   * 	Return
>   * 		A syscall result.
> + *
> + * long bpf_timer_init(struct bpf_timer *timer, void *callback_fn, int flags)
> + *	Description
> + *		Initialize the timer to call given static function.
> + *	Return
> + *		zero
> + *
> + * long bpf_timer_start(struct bpf_timer *timer, u64 nsecs)
> + *	Description
> + *		Start the timer and set its expiration N nanoseconds from
> + *		the current time.
> + *	Return
> + *		zero
> + *
> + * long bpf_timer_cancel(struct bpf_timer *timer)
> + *	Description
> + *		Deactivate the timer.
> + *	Return
> + *		zero
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -4945,6 +4964,9 @@ union bpf_attr {
>  	FN(sys_bpf),			\
>  	FN(btf_find_by_name_kind),	\
>  	FN(sys_close),			\
> +	FN(timer_init),			\
> +	FN(timer_start),		\
> +	FN(timer_cancel),		\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -6051,6 +6073,10 @@ struct bpf_spin_lock {
>  	__u32	val;
>  };
>  
> +struct bpf_timer {
> +	__u64 :64;
> +};
> +
>  struct bpf_sysctl {
>  	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
>  				 * Allows 1,2,4-byte read, but no write.
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 544773970dbc..6f9620cbe95d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -985,6 +985,160 @@ const struct bpf_func_proto bpf_snprintf_proto = {
>  	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
>  };
>  
> +struct bpf_hrtimer {
> +	struct hrtimer timer;
> +	spinlock_t lock;
> +	struct bpf_map *map;
> +	struct bpf_prog *prog;
> +	void *callback_fn;
> +	void *key;
> +	void *value;
> +};
> +
> +/* the actual struct hidden inside uapi struct bpf_timer */
> +struct bpf_timer_kern {
> +	struct bpf_hrtimer *timer;
> +};
> +
> +static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
> +
> +static enum hrtimer_restart timer_cb(struct hrtimer *timer)
> +{
> +	struct bpf_hrtimer *t = container_of(timer, struct bpf_hrtimer, timer);
> +	unsigned long flags;
> +	int ret;
> +
> +	/* timer_cb() runs in hrtimer_run_softirq and doesn't migrate.
> +	 * Remember the timer this callback is servicing to prevent
> +	 * deadlock if callback_fn() calls bpf_timer_cancel() on the same timer.
> +	 */
> +	this_cpu_write(hrtimer_running, t);
> +	ret = BPF_CAST_CALL(t->callback_fn)((u64)(long)t->map,
> +					    (u64)(long)t->key,
> +					    (u64)(long)t->value, 0, 0);
> +	WARN_ON(ret != 0); /* todo: define 0 vs 1 or disallow 1 in the verifier */
> +	spin_lock_irqsave(&t->lock, flags);
> +	if (!hrtimer_is_queued(timer))
> +		bpf_prog_put(t->prog);
> +	spin_unlock_irqrestore(&t->lock, flags);
> +	this_cpu_write(hrtimer_running, NULL);
> +	return HRTIMER_NORESTART;
> +}
> +
> +BPF_CALL_5(bpf_timer_init, struct bpf_timer_kern *, timer, void *, cb, int, flags,
> +	   struct bpf_map *, map, struct bpf_prog *, prog)
> +{
> +	struct bpf_hrtimer *t;
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (READ_ONCE(timer->timer))
> +		return -EBUSY;
> +	/* allocate hrtimer via map_kmalloc to use memcg accounting */
> +	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, NUMA_NO_NODE);
> +	if (!t)
> +		return -ENOMEM;
> +	t->callback_fn = cb;
> +	t->value = (void *)timer /* - offset of bpf_timer inside elem */;
> +	t->key = t->value - round_up(map->key_size, 8);

For array-maps won't this just point to somewhere inside the previous value?

> +	t->map = map;
> +	t->prog = prog;
> +	spin_lock_init(&t->lock);
> +	hrtimer_init(&t->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +	t->timer.function = timer_cb;
> +	if (cmpxchg(&timer->timer, NULL, t)) {
> +		/* Parallel bpf_timer_init() calls raced. */
> +		kfree(t);
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_timer_init_proto = {
> +	.func		= bpf_timer_init,
> +	.gpl_only	= false,

hrtimer_init() is EXPORT_SYMBOL_GPL, should this be as well? Same with
the others below.

> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_TIMER,
> +	.arg2_type	= ARG_PTR_TO_FUNC,
> +	.arg3_type	= ARG_ANYTHING,
> +};
> +
> +BPF_CALL_2(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs)
> +{
> +	struct bpf_hrtimer *t;
> +	unsigned long flags;
> +
> +	t = READ_ONCE(timer->timer);
> +	if (!t)
> +		return -EINVAL;
> +	spin_lock_irqsave(&t->lock, flags);
> +	/* Keep the prog alive until callback is invoked */
> +	if (!hrtimer_active(&t->timer))
> +		bpf_prog_inc(t->prog);
> +	hrtimer_start(&t->timer, ns_to_ktime(nsecs), HRTIMER_MODE_REL_SOFT);
> +	spin_unlock_irqrestore(&t->lock, flags);
> +	return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_timer_start_proto = {
> +	.func		= bpf_timer_start,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_TIMER,
> +	.arg2_type	= ARG_ANYTHING,
> +};
> +
> +BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
> +{
> +	struct bpf_hrtimer *t;
> +	unsigned long flags;
> +
> +	t = READ_ONCE(timer->timer);
> +	if (!t)
> +		return -EINVAL;
> +	if (this_cpu_read(hrtimer_running) == t)
> +		/* If bpf callback_fn is trying to bpf_timer_cancel()
> +		 * its own timer the hrtimer_cancel() will deadlock
> +		 * since it waits for callback_fn to finish
> +		 */
> +		return -EBUSY;
> +	spin_lock_irqsave(&t->lock, flags);
> +	/* Cancel the timer and wait for associated callback to finish
> +	 * if it was running.
> +	 */
> +	if (hrtimer_cancel(&t->timer) == 1)
> +		/* If the timer was active then drop the prog refcnt,
> +		 * since callback will not be invoked.
> +		 */
> +		bpf_prog_put(t->prog);
> +	spin_unlock_irqrestore(&t->lock, flags);
> +	return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_timer_cancel_proto = {
> +	.func		= bpf_timer_cancel,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_TIMER,
> +};
> +
> +void bpf_timer_cancel_and_free(void *val)
> +{
> +	struct bpf_timer_kern *timer = val;
> +	struct bpf_hrtimer *t;
> +
> +	t = READ_ONCE(timer->timer);
> +	if (!t)
> +		return;
> +	/* Cancel the timer and wait for callback to complete
> +	 * if it was running
> +	 */
> +	if (hrtimer_cancel(&t->timer) == 1)
> +		bpf_prog_put(t->prog);
> +	kfree(t);
> +	WRITE_ONCE(timer->timer, NULL);
> +}
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
> @@ -1051,6 +1205,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  		return &bpf_per_cpu_ptr_proto;
>  	case BPF_FUNC_this_cpu_ptr:
>  		return &bpf_this_cpu_ptr_proto;
> +	case BPF_FUNC_timer_init:
> +		return &bpf_timer_init_proto;
> +	case BPF_FUNC_timer_start:
> +		return &bpf_timer_start_proto;
> +	case BPF_FUNC_timer_cancel:
> +		return &bpf_timer_cancel_proto;
>  	default:
>  		break;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1de4b8c6ee42..f386f85aee5c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4656,6 +4656,35 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>  	return 0;
>  }
>  
> +static int process_timer_func(struct bpf_verifier_env *env, int regno,
> +			      struct bpf_call_arg_meta *meta)
> +{
> +	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> +	bool is_const = tnum_is_const(reg->var_off);
> +	struct bpf_map *map = reg->map_ptr;
> +	u64 val = reg->var_off.value;
> +
> +	if (!is_const) {
> +		verbose(env,
> +			"R%d doesn't have constant offset. bpf_timer has to be at the constant offset\n",
> +			regno);
> +		return -EINVAL;
> +	}
> +	if (!map->btf) {
> +		verbose(env, "map '%s' has to have BTF in order to use bpf_timer\n",
> +			map->name);
> +		return -EINVAL;
> +	}
> +	if (val) {
> +		/* todo: relax this requirement */
> +		verbose(env, "bpf_timer field can only be first in the map value element\n");
> +		return -EINVAL;
> +	}
> +	WARN_ON(meta->map_ptr);
> +	meta->map_ptr = map;
> +	return 0;
> +}
> +
>  static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
>  {
>  	return type == ARG_PTR_TO_MEM ||
> @@ -4788,6 +4817,7 @@ static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PER
>  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
>  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
>  
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
> @@ -4819,6 +4849,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>  	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
>  	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
>  	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
> +	[ARG_PTR_TO_TIMER]		= &timer_types,
>  };
>  
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -5000,6 +5031,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  			verbose(env, "verifier internal error\n");
>  			return -EFAULT;
>  		}
> +	} else if (arg_type == ARG_PTR_TO_TIMER) {
> +		if (process_timer_func(env, regno, meta))
> +			return -EACCES;
>  	} else if (arg_type == ARG_PTR_TO_FUNC) {
>  		meta->subprogno = reg->subprogno;
>  	} else if (arg_type_is_mem_ptr(arg_type)) {
> @@ -5742,6 +5776,43 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static int set_timer_init_callback_state(struct bpf_verifier_env *env,
> +					 struct bpf_func_state *caller,
> +					 struct bpf_func_state *callee,
> +					 int insn_idx)
> +{
> +	struct bpf_insn_aux_data *insn_aux = &env->insn_aux_data[insn_idx];
> +	struct bpf_map *map_ptr;
> +
> +	if (bpf_map_ptr_poisoned(insn_aux)) {
> +		verbose(env, "bpf_timer_init abusing map_ptr\n");
> +		return -EINVAL;
> +	}
> +
> +	map_ptr = BPF_MAP_PTR(insn_aux->map_ptr_state);
> +
> +	/* bpf_timer_init(struct bpf_timer *timer, void *callback_fn, u64 flags);
> +	 * callback_fn(struct bpf_map *map, void *key, void *value);
> +	 */
> +	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +	callee->regs[BPF_REG_1].map_ptr = map_ptr;
> +
> +	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
> +	callee->regs[BPF_REG_2].map_ptr = map_ptr;
> +
> +	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
> +	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
> +	callee->regs[BPF_REG_3].map_ptr = map_ptr;
> +
> +	/* unused */
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +	callee->in_callback_fn = true;
> +	return 0;
> +}
> +
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>  	struct bpf_verifier_state *state = env->cur_state;
> @@ -5837,6 +5908,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	    func_id != BPF_FUNC_map_pop_elem &&
>  	    func_id != BPF_FUNC_map_peek_elem &&
>  	    func_id != BPF_FUNC_for_each_map_elem &&
> +	    func_id != BPF_FUNC_timer_init &&
>  	    func_id != BPF_FUNC_redirect_map)
>  		return 0;
>  
> @@ -6069,6 +6141,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			return -EINVAL;
>  	}
>  
> +	if (func_id == BPF_FUNC_timer_init) {
> +		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +					set_timer_init_callback_state);
> +		if (err < 0)
> +			return -EINVAL;
> +	}
> +
>  	if (func_id == BPF_FUNC_snprintf) {
>  		err = check_bpf_snprintf_call(env, regs);
>  		if (err < 0)
> @@ -12526,6 +12605,37 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			insn      = new_prog->insnsi + i + delta;
>  			continue;
>  		}
> +		if (insn->imm == BPF_FUNC_timer_init) {
> +
> +			aux = &env->insn_aux_data[i + delta];
> +			if (bpf_map_ptr_poisoned(aux)) {
> +				verbose(env, "bpf_timer_init abusing map_ptr\n");
> +				return -EINVAL;
> +			}
> +			map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
> +			{
> +				struct bpf_insn ld_addrs[4] = {
> +					BPF_LD_IMM64(BPF_REG_4, (long)map_ptr),
> +					BPF_LD_IMM64(BPF_REG_5, (long)prog),
> +				};
> +
> +				insn_buf[0] = ld_addrs[0];
> +				insn_buf[1] = ld_addrs[1];
> +				insn_buf[2] = ld_addrs[2];
> +				insn_buf[3] = ld_addrs[3];
> +			}
> +			insn_buf[4] = *insn;
> +			cnt = 5;
> +
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			goto patch_call_imm;
> +		}
>  
>  		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
>  		 * and other inlining handlers are currently limited to 64 bit
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d2d7cf6cfe83..453a46c2d732 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1065,7 +1065,7 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_snprintf:
>  		return &bpf_snprintf_proto;
>  	default:
> -		return NULL;
> +		return bpf_base_func_proto(func_id);
>  	}
>  }
>  
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index 2d94025b38e9..00ac7b79cddb 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -547,6 +547,7 @@ COMMANDS
>              'struct inode',
>              'struct socket',
>              'struct file',
> +            'struct bpf_timer',
>      ]
>      known_types = {
>              '...',
> @@ -594,6 +595,7 @@ COMMANDS
>              'struct inode',
>              'struct socket',
>              'struct file',
> +            'struct bpf_timer',
>      }
>      mapped_types = {
>              'u8': '__u8',
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 562adeac1d67..3da901d5076b 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4774,6 +4774,25 @@ union bpf_attr {
>   * 		Execute close syscall for given FD.
>   * 	Return
>   * 		A syscall result.
> + *
> + * long bpf_timer_init(struct bpf_timer *timer, void *callback_fn, int flags)
> + *	Description
> + *		Initialize the timer to call given static function.
> + *	Return
> + *		zero
> + *
> + * long bpf_timer_start(struct bpf_timer *timer, u64 nsecs)
> + *	Description
> + *		Start the timer and set its expiration N nanoseconds from
> + *		the current time.
> + *	Return
> + *		zero
> + *
> + * long bpf_timer_cancel(struct bpf_timer *timer)
> + *	Description
> + *		Deactivate the timer.
> + *	Return
> + *		zero
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -4945,6 +4964,9 @@ union bpf_attr {
>  	FN(sys_bpf),			\
>  	FN(btf_find_by_name_kind),	\
>  	FN(sys_close),			\
> +	FN(timer_init),			\
> +	FN(timer_start),		\
> +	FN(timer_cancel),		\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -6051,6 +6073,10 @@ struct bpf_spin_lock {
>  	__u32	val;
>  };
>  
> +struct bpf_timer {
> +	__u64 :64;
> +};
> +
>  struct bpf_sysctl {
>  	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
>  				 * Allows 1,2,4-byte read, but no write.
> -- 
> 2.30.2

