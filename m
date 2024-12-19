Return-Path: <bpf+bounces-47290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C99F7197
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 02:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB23168CB7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4242339A1;
	Thu, 19 Dec 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l7BXrkjo"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B33AD5A
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571000; cv=none; b=g5IqzjnIquD9GhvjAVTU7WHtZdAlQ50SqH9LzwXWS/KxF20UZiE1U0246NFFk8LypWE+cqwfw+DSCcUGqrUhmcc2X7JM9CeEzfn/jhcUd1FZZE5N3ngXdVuS/H9DDBmdwuqYXuQHjSZxXtjmfs65qzRjJx3JKvl54IuKFW33SX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571000; c=relaxed/simple;
	bh=ywjyRX0wFDmT3x6BXZ5aEoPG06dNitHbPnWy2rAW4jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o77WCIETmE5Fi/829b56bVzX8vvhBsUaUwTXRhR8EMnt0vbZHrBDtcd+b0KFpH6m58KuaIcrBjJ5hvzhn8Gy+UIOPcvJ1/8/kru3xpoRgteTuySlGq9iHW/dmiG2htUPdbbNNIFqdM+uzUnyh1UU8JfWB1LcIuU2zTnPGU0bmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l7BXrkjo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f57ee5de-bf8b-40ce-8883-904653c422b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734570994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DC46yMvTlgzEmr0S66jR2jZbGeEUYCTIBmtIkpXV5Ro=;
	b=l7BXrkjozgkPNpas5+kAiX+q2j98MYIoZlW5dBlq+gXOj6hofb+SlBfFPHhtMwlLDY4X+d
	LQcQtoP1FybyUSCN3Q1OG+rrFIYHoVtgbHMOKC+xBNCc8XXmuRaE/8u4qgYVg0jBQKt60d
	IMlmtNaS168kuLe0k+lSeADE4Pt3zz4=
Date: Wed, 18 Dec 2024 17:16:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 07/13] bpf: net_sched: Add a qdisc watchdog
 timer
To: Amery Hung <amery.hung@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 ameryhung@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-8-amery.hung@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241213232958.2388301-8-amery.hung@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/13/24 3:29 PM, Amery Hung wrote:
> Add a watchdog timer to bpf qdisc. The watchdog can be used to schedule
> the execution of qdisc through kfunc, bpf_qdisc_schedule(). It can be
> useful for building traffic shaping scheduling algorithm, where the time
> the next packet will be dequeued is known.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---
>   include/net/sch_generic.h |  4 +++
>   net/sched/bpf_qdisc.c     | 51 ++++++++++++++++++++++++++++++++++++++-
>   net/sched/sch_api.c       | 11 +++++++++
>   net/sched/sch_generic.c   |  8 ++++++
>   4 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 5d74fa7e694c..6a252b1b0680 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -1357,4 +1357,8 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
>   		msleep(1);
>   }
>   
> +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
> +void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
> +void bpf_qdisc_reset_post_op(struct Qdisc *sch);
> +
>   #endif
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 28959424eab0..7c155207fe1e 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -8,6 +8,10 @@
>   
>   static struct bpf_struct_ops bpf_Qdisc_ops;
>   
> +struct bpf_sched_data {
> +	struct qdisc_watchdog watchdog;
> +};
> +
>   struct bpf_sk_buff_ptr {
>   	struct sk_buff *skb;
>   };
> @@ -17,6 +21,32 @@ static int bpf_qdisc_init(struct btf *btf)
>   	return 0;
>   }
>   
> +int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_watchdog_init(&q->watchdog, sch);
> +	return 0;
> +}
> +EXPORT_SYMBOL(bpf_qdisc_init_pre_op);
> +
> +void bpf_qdisc_reset_post_op(struct Qdisc *sch)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_watchdog_cancel(&q->watchdog);
> +}
> +EXPORT_SYMBOL(bpf_qdisc_reset_post_op);
> +
> +void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_watchdog_cancel(&q->watchdog);
> +}
> +EXPORT_SYMBOL(bpf_qdisc_destroy_post_op);

These feel like the candidates for the ".gen_prologue" and ".gen_epilogue". Then 
the changes to sch_api.c is not needed.

> +
>   static const struct bpf_func_proto *
>   bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
>   			 const struct bpf_prog *prog)
> @@ -134,12 +164,25 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
>   	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
>   }
>   
> +/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time using a timer.
> + * @sch: The qdisc to be scheduled.
> + * @expire: The expiry time of the timer.
> + * @delta_ns: The slack range of the timer.
> + */
> +__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns)
> +{
> +	struct bpf_sched_data *q = qdisc_priv(sch);
> +
> +	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   #define BPF_QDISC_KFUNC_xxx \
>   	BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
>   	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
>   	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
> +	BPF_QDISC_KFUNC(bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS) \
>   
>   BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
>   #define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
> @@ -154,9 +197,14 @@ BPF_QDISC_KFUNC_xxx
>   
>   static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
>   {
> -	if (kfunc_id == bpf_qdisc_skb_drop_ids[0])
> +	if (kfunc_id == bpf_qdisc_skb_drop_ids[0]) {
>   		if (strcmp(prog->aux->attach_func_name, "enqueue"))
>   			return -EACCES;
> +	} else if (kfunc_id == bpf_qdisc_watchdog_schedule_ids[0]) {
> +		if (strcmp(prog->aux->attach_func_name, "enqueue") &&
> +		    strcmp(prog->aux->attach_func_name, "dequeue"))
> +			return -EACCES;
> +	}
>   
>   	return 0;
>   }
> @@ -189,6 +237,7 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
>   	case offsetof(struct Qdisc_ops, priv_size):
>   		if (uqdisc_ops->priv_size)
>   			return -EINVAL;
> +		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);

ah. ok. The priv_size case is still needed.



