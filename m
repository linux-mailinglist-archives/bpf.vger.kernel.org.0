Return-Path: <bpf+bounces-35691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626A93CC4B
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4111C21473
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 01:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4488EDC;
	Fri, 26 Jul 2024 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r/cdEkWY"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4D368
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721956550; cv=none; b=ApsXNGBuRaWnoHoIE4hwid08tw4MJzRngDrfDGJN4HtyQJCilsdtqu3NjMbKLFGnHu/Svv4aZ2PF9QFueHvcactdJp/A7jjxNVcQnPrvDINc73qSeXBOt7AkbTlWsj6lmohBorwJYfij6gWIfsf8ieqDTN9nWNs2caAfcAsq6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721956550; c=relaxed/simple;
	bh=ABAeF0td+V7Qmx/XI7YPqrOcTMb09W0mytpLgntAAR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7OEBswLGUWutKHs+Qm/7XD4vlSQvmJnDtB+NpT59JaNTys00lo7Cma0V7/BoFOBvT4Q41/segQqJgTXbEglvnnRDSvSNd8ZQFxSKjEHUrYiApoXVOX33hnRjn9bbSRs9A3cD3UEKhtVkQmznV9witfwWYR5MCIYUg6lBY/y49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r/cdEkWY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3bfe9a5-40e8-4a1c-a5e5-0f7f24b9e395@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721956545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDUIjNwdKuDXe19nnD/XMgqnauA4XCg7yVYXDqBO1KU=;
	b=r/cdEkWY/S3w1h7OOWNO/5wabQX+dNGUTj8UFs1d6bODc+emoWntnmMOh2Z30+HUHx7x6Z
	/+UCLsk1vkeD+ymrewOE7hn2pacsSK44aJKZHv2npS448WnhG5aUxKRPu3aUSyk2oBu/WE
	U83Q7PhCT3MUVLVsjmXo06XUdk3Oj9I=
Date: Thu, 25 Jul 2024 18:15:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional
 operators in Qdisc_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn,
 daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-8-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240714175130.4051012-8-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/24 10:51 AM, Amery Hung wrote:
> So far, init, reset, and destroy are implemented by bpf qdisc infra as
> fixed operators that manipulate the watchdog according to the occasion.
> This patch allows users to implement these three operators to perform
> desired work alongside the predefined ones.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   include/net/sch_generic.h |  6 ++++++
>   net/sched/bpf_qdisc.c     | 20 ++++----------------
>   net/sched/sch_api.c       | 11 +++++++++++
>   net/sched/sch_generic.c   |  8 ++++++++
>   4 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 214ed2e34faa..3041782b7527 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1359,4 +1359,10 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
>   		msleep(1);
>   }
>   
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
> +void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
> +void bpf_qdisc_reset_post_op(struct Qdisc *sch);
> +#endif
> +
>   #endif
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index eff7559aa346..903b4eb54510 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -9,9 +9,6 @@
>   static struct bpf_struct_ops bpf_Qdisc_ops;
>   
>   static u32 unsupported_ops[] = {
> -	offsetof(struct Qdisc_ops, init),
> -	offsetof(struct Qdisc_ops, reset),
> -	offsetof(struct Qdisc_ops, destroy),
>   	offsetof(struct Qdisc_ops, change),
>   	offsetof(struct Qdisc_ops, attach),
>   	offsetof(struct Qdisc_ops, change_real_num_tx),
> @@ -36,8 +33,8 @@ static int bpf_qdisc_init(struct btf *btf)
>   	return 0;
>   }
>   
> -static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
> -			     struct netlink_ext_ack *extack)
> +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
>   {
>   	struct bpf_sched_data *q = qdisc_priv(sch);
>   
> @@ -45,14 +42,14 @@ static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
>   	return 0;
>   }
>   
> -static void bpf_qdisc_reset_op(struct Qdisc *sch)
> +void bpf_qdisc_reset_post_op(struct Qdisc *sch)
>   {
>   	struct bpf_sched_data *q = qdisc_priv(sch);
>   
>   	qdisc_watchdog_cancel(&q->watchdog);
>   }
>   
> -static void bpf_qdisc_destroy_op(struct Qdisc *sch)
> +void bpf_qdisc_destroy_post_op(struct Qdisc *sch)

The reset_post_ops and destroy_post_op are identical. They only do 
qdisc_watchdog_cancel().

>   {
>   	struct bpf_sched_data *q = qdisc_priv(sch);
>   
> @@ -235,15 +232,6 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
>   			return -EINVAL;
>   		qdisc_ops->static_flags = TCQ_F_BPF;
>   		return 1;
> -	case offsetof(struct Qdisc_ops, init):
> -		qdisc_ops->init = bpf_qdisc_init_op;
> -		return 1;
> -	case offsetof(struct Qdisc_ops, reset):
> -		qdisc_ops->reset = bpf_qdisc_reset_op;
> -		return 1;
> -	case offsetof(struct Qdisc_ops, destroy):
> -		qdisc_ops->destroy = bpf_qdisc_destroy_op;
> -		return 1;
>   	case offsetof(struct Qdisc_ops, peek):
>   		if (!uqdisc_ops->peek)
>   			qdisc_ops->peek = qdisc_peek_dequeued;
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 5064b6d2d1ec..9fb9375e2793 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1352,6 +1352,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>   		rcu_assign_pointer(sch->stab, stab);
>   	}
>   
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> +	if (sch->flags & TCQ_F_BPF) {

I can see the reason why this patch is needed. It is a few line changes and they 
are not in the fast path... still weakly not excited about them but I know it 
could be a personal preference.

I think at the very least, instead of adding a new TCQ_F_BPF, let see if the 
"owner == BPF_MODULE_OWNER" test can be reused like how it is done in the 
bpf_try_module_get().


A rough direction I am spinning...

The pre/post is mainly to initialize and cleanup the "struct bpf_sched_data" 
before/after calling the bpf prog.

For the pre (init), there is a ".gen_prologue(...., const struct bpf_prog 
*prog)" in the "bpf_verifier_ops". Take a look at the tc_cls_act_prologue().
It calls a BPF_FUNC_skb_pull_data helper. It potentially can call a kfunc 
bpf_qdisc_watchdog_cancel. However, the gen_prologue is invoked too late in the 
verifier for kfunc calling now. This will need some thoughts and works.

For the post (destroy,reset), there is no "gen_epilogue" now. If 
bpf_qdisc_watchdog_schedule() is not allowed to be called in the ".reset" and 
".destroy" bpf prog. I think it can be changed to pre also? There is a ".filter" 
function in the "struct btf_kfunc_id_set" during the kfunc register.

> +		err = bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], extack);
> +		if (err != 0)
> +			goto err_out4;
> +	}
> +#endif
>   	if (ops->init) {
>   		err = ops->init(sch, tca[TCA_OPTIONS], extack);
>   		if (err != 0)
> @@ -1388,6 +1395,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>   	 */
>   	if (ops->destroy)
>   		ops->destroy(sch);
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> +	if (sch->flags & TCQ_F_BPF)
> +		bpf_qdisc_destroy_post_op(sch);
> +#endif
>   	qdisc_put_stab(rtnl_dereference(sch->stab));
>   err_out3:
>   	lockdep_unregister_key(&sch->root_lock_key);
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 76e4a6efd17c..0ac05665c69f 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1033,6 +1033,10 @@ void qdisc_reset(struct Qdisc *qdisc)
>   
>   	if (ops->reset)
>   		ops->reset(qdisc);
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> +	if (qdisc->flags & TCQ_F_BPF)
> +		bpf_qdisc_reset_post_op(qdisc);
> +#endif
>   
>   	__skb_queue_purge(&qdisc->gso_skb);
>   	__skb_queue_purge(&qdisc->skb_bad_txq);
> @@ -1076,6 +1080,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>   
>   	if (ops->destroy)
>   		ops->destroy(qdisc);
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
> +	if (qdisc->flags & TCQ_F_BPF)
> +		bpf_qdisc_destroy_post_op(qdisc);
> +#endif
>   
>   	lockdep_unregister_key(&qdisc->root_lock_key);
>   	bpf_module_put(ops, ops->owner);


