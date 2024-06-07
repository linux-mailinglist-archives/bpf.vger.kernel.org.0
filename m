Return-Path: <bpf+bounces-31579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B944A9002A3
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A533E1C23172
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7218FDAF;
	Fri,  7 Jun 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+sMPRiR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D5187358;
	Fri,  7 Jun 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761094; cv=none; b=OfJxCnE+OvY8pgcZc1LYeFhU4K46fbSKg/Aznub2Osl1Mr/5tgLWFxrNMR3eW3/NAV7B1+ryG0QlgTV3cALK7LruAk5fL11TgfN3bWJAhW35s1TM6x7YezEchzd+FpO2H78Av4q9w+ZP3eM9MJUmPFNFfEKeJNAJGjQqkFgRf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761094; c=relaxed/simple;
	bh=dKbuqX1WzQnhzGio5Hp05zIP0ds5xQhsfvuXhuegNCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcTry/nyryARmmOw6o3VJjxFrZMVaAYg/2IXD3EhK7OTiweMgbENv+T/4Hn534HtZcUgODvswpIahqPbVE7v771S6m2HPzY2UK+lXVDrMJGDTmxNFdAtOrMW2ZrQ/Iz+bAP4LU62BoqQmJZov1tp47GOwETAX6SrtT9X7pM1v9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+sMPRiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED1C32782;
	Fri,  7 Jun 2024 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717761092;
	bh=dKbuqX1WzQnhzGio5Hp05zIP0ds5xQhsfvuXhuegNCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+sMPRiRZIqYQXZJhrmRX4QFozqIHizzeEglrctFy8B38cUSrJcozsue+UADh08eb
	 yNl7yrQmdE4+TbFqVq3x9+HoFJIyN93/H8YvCEygecIbCXWTWSkDL9C6YU8HTDcqsz
	 ow4WDID293NpLzZ8njFiObMS91MXgmQpeVvOfMDRe0Ti/ApGZA2Qd0hjp1QqH0UAdW
	 nF3WaTEx8HJ1J7fXTKx/JOikRWtLmunw9neizQcCbepXILWrf/nTtTe3XsR6IQWjFd
	 /JXSv5+2ON2Q5LRXqODtn116q5rl9wjNg/KXe/7Y6uYolkBQfE8Muz3cFTOvj8apSF
	 6eSvGktwCAgmA==
Message-ID: <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>
Date: Fri, 7 Jun 2024 13:51:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
References: <20240607070427.1379327-1-bigeasy@linutronix.de>
 <20240607070427.1379327-15-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240607070427.1379327-15-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/06/2024 08.53, Sebastian Andrzej Siewior wrote:
[...]
> 
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it, bpf_net_ctx_clear() removes it again.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
> 
> The pointer to bpf_net_context is saved task's task_struct. Using
> always the bpf_net_context approach has the advantage that there is
> almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.
> 
[...]
> ---
>   include/linux/filter.h | 43 ++++++++++++++++++++++++++++++++++-------
>   include/linux/sched.h  |  3 +++
>   kernel/bpf/cpumap.c    |  3 +++
>   kernel/bpf/devmap.c    |  9 ++++++++-
>   kernel/fork.c          |  1 +
>   net/bpf/test_run.c     | 11 ++++++++++-
>   net/core/dev.c         | 26 ++++++++++++++++++++++++-
>   net/core/filter.c      | 44 ++++++++++++------------------------------
>   net/core/lwt_bpf.c     |  3 +++
>   9 files changed, 101 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b02aea291b7e8..2ff1c394dcf0c 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -744,7 +744,38 @@ struct bpf_redirect_info {
>   	struct bpf_nh_params nh;
>   };
>   
> -DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
> +struct bpf_net_context {
> +	struct bpf_redirect_info ri;
> +};
> +
> +static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> +{
> +	struct task_struct *tsk = current;
> +
> +	if (tsk->bpf_net_context != NULL)
> +		return NULL;
> +	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));

It annoys me that we have to clear this memory every time.
(This is added in net_rx_action() that *all* RX packets traverse).

The feature and memory is only/primarily used for XDP and TC redirects,
but we take the overhead of clearing even when these features are not used.

Netstack does bulking in most of the cases this is used, so in our/your
benchmarks this overhead doesn't show.  But we need to be aware that
this is a "paper-cut" for single network packet processing.

Idea: We could postpone clearing until code calls bpf_net_ctx_get() ?
See below.

> +	tsk->bpf_net_context = bpf_net_ctx;
> +	return bpf_net_ctx;
> +}
> +
> +static inline void bpf_net_ctx_clear(struct bpf_net_context *bpf_net_ctx)
> +{
> +	if (bpf_net_ctx)
> +		current->bpf_net_context = NULL;
> +}
> +
> +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> +{

> +	return current->bpf_net_context;
> +}
> +
> +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +

if (bpf_net_ctx->ri->kern_flags & BPF_RI_F_NEEDS_INIT) {
   memset + init_list (intro in patch 15)
}

Maybe even postpone the init_list calls to the "get" helpers introduced 
in patch 15.


> +	return &bpf_net_ctx->ri;
> +}
>   
[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2c3f86c8cd176..73965dff1b30f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[...]
> @@ -6881,10 +6902,12 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)

The function net_rx_action() is core to the network stack.

>   	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
>   	unsigned long time_limit = jiffies +
>   		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
> +	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>   	int budget = READ_ONCE(net_hotdata.netdev_budget);
>   	LIST_HEAD(list);
>   	LIST_HEAD(repoll);
>   
> +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>   start:
>   	sd->in_net_rx_action = true;
>   	local_irq_disable();
> @@ -6937,7 +6960,8 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
>   		sd->in_net_rx_action = false;
>   
>   	net_rps_action_and_irq_enable(sd);
> -end:;
> +end:
> +	bpf_net_ctx_clear(bpf_net_ctx);
>   }


The memset can be further optimized as it currently clears 64 bytes, but
it only need to clear 40 bytes, see pahole below.

Replace memset with something like:
  memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));

This is an optimization, because with 64 bytes this result in a rep-stos
(repeated string store operation) that on Intel touch CPU-flags (to be
IRQ safe) which is slow, while clearing 40 bytes doesn't cause compiler
to use this instruction, which is faster.  Memset benchmarked with [1]

[1] 
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/time_bench_memset.c

--Jesper

$ pahole -C bpf_redirect_info vmlinux
struct bpf_redirect_info {
	u64                        tgt_index;            /*     0     8 */
	void *                     tgt_value;            /*     8     8 */
	struct bpf_map *           map;                  /*    16     8 */
	u32                        flags;                /*    24     4 */
	u32                        kern_flags;           /*    28     4 */
	u32                        map_id;               /*    32     4 */
	enum bpf_map_type          map_type;             /*    36     4 */
	struct bpf_nh_params       nh;                   /*    40    20 */

	/* size: 64, cachelines: 1, members: 8 */
	/* padding: 4 */
};



The full struct:

$ pahole -C bpf_net_context vmlinux
struct bpf_net_context {
	struct bpf_redirect_info   ri;                   /*     0    64 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 1 boundary (64 bytes) --- */
	struct list_head           cpu_map_flush_list;   /*    64    16 */
	struct list_head           dev_map_flush_list;   /*    80    16 */
	struct list_head           xskmap_map_flush_list; /*    96    16 */

	/* size: 112, cachelines: 2, members: 4 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 48 bytes */
};



