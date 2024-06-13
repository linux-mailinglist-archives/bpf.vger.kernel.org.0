Return-Path: <bpf+bounces-32049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807C9068C3
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0412C1F2632B
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36513E888;
	Thu, 13 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPBAMWh4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FA381C4;
	Thu, 13 Jun 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271133; cv=none; b=S0w1KgX/ONAVUokQgR2hq8QIgcoiEycCp21Enqk2VQOCU9hdL32JeBsUdnEE//5Vi94/VQD2qTrL2C28+V5b6PzipUMQa6sMS78T0wKhqkF4GEw3bCIK3gimloLl+zSnmtcPtj36Y9OB21kAQRScf9HBsA1wpY2sKz4fWZh8ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271133; c=relaxed/simple;
	bh=PaV1/aUONukaNRB9HswUe/iOgOw9sgxe6pBxT6j1JEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6P2vM7J2ZLiZIt7l9RxAoDGSU1titFVPZbAgEryr/jnkopoRRY46Ec8vyuOmM+E/vc/fogwhQwYKkcbhfXQHFWHB2NE3rVqOeDVXK/x2dWsfHZ1AVMZ8ult2r6qWMMO5DzJYD4Is6vhHqJeGbaepZ7zRKKwlRnyRZ4muo1OmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPBAMWh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8250C2BBFC;
	Thu, 13 Jun 2024 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718271133;
	bh=PaV1/aUONukaNRB9HswUe/iOgOw9sgxe6pBxT6j1JEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPBAMWh4wx4yh2ijw91fOQa1Qa7DO5KZr04gK4yZXcfrsYwhZrDqB5LZ/4LGzK/g2
	 glNJRJ1LGahPnku4c1XwqEuSPsVxQ2gNJ1NHSO3nQ7xXjiEp57Bl5HQW3AXcMz/Yjq
	 OF0Ana6IjFXKWdmF2PotAve4fUJ3VtXVTMOgpk2hl/MedLoslbeyTZxTZybbkHzxGg
	 moNxltM0cNdl5sk2kw13tB1uMo4736riZT3cYaWRmyqlVEZW7wakWMfe1lXg6SkjXj
	 rITQm8sLla1mc2XHgimlAI1ZgHigx4wDJJ1pvHFOwF67iNPSF2CCbvGwemPuoCG5aJ
	 qPLopIEp/KfHw==
Message-ID: <74985816-3a3a-490e-b8f0-49f795ab2f07@kernel.org>
Date: Thu, 13 Jun 2024 11:32:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 14/15] net: Reference bpf_redirect_info via
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
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
 <20240612170303.3896084-15-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240612170303.3896084-15-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2024 18.44, Sebastian Andrzej Siewior wrote:
> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>    packet and makes decisions. While doing that, the per-CPU variable
>    bpf_redirect_info is used.
> 
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>    and it may also access other per-CPU variables like xskmap_flush_list.
> 
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
> 
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
> 
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
> 
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it, bpf_net_ctx_clear() removes it again.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info. The returned data structure is zero initialized to
> ensure nothing is leaked from stack. This is done on first usage of the
> struct. bpf_net_ctx_set() sets bpf_redirect_info::kern_flags  to 0 to
> note that initialisation is required. First invocation of
> bpf_net_ctx_get_ri() will memset() the data structure and update
> bpf_redirect_info::kern_flags.
> bpf_redirect_info::nh  is excluded from memset because it is only used
> once BPF_F_NEIGH is set which also sets the nh member. The kern_flags is
> moved past nh to exclude it from memset.
> 
> The pointer to bpf_net_context is saved task's task_struct. Using
> always the bpf_net_context approach has the advantage that there is
> almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.
> 
> Cc: Alexei Starovoitov<ast@kernel.org>
> Cc: Andrii Nakryiko<andrii@kernel.org>
> Cc: Eduard Zingerman<eddyz87@gmail.com>
> Cc: Hao Luo<haoluo@google.com>
> Cc: Jesper Dangaard Brouer<hawk@kernel.org>
> Cc: Jiri Olsa<jolsa@kernel.org>
> Cc: John Fastabend<john.fastabend@gmail.com>
> Cc: KP Singh<kpsingh@kernel.org>
> Cc: Martin KaFai Lau<martin.lau@linux.dev>
> Cc: Song Liu<song@kernel.org>
> Cc: Stanislav Fomichev<sdf@google.com>
> Cc: Toke Høiland-Jørgensen<toke@redhat.com>
> Cc: Yonghong Song<yonghong.song@linux.dev>
> Cc:bpf@vger.kernel.org
> Acked-by: Alexei Starovoitov<ast@kernel.org>
> Reviewed-by: Toke Høiland-Jørgensen<toke@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> ---
>   include/linux/filter.h | 56 ++++++++++++++++++++++++++++++++++--------
>   include/linux/sched.h  |  3 +++
>   kernel/bpf/cpumap.c    |  3 +++
>   kernel/bpf/devmap.c    |  9 ++++++-
>   kernel/fork.c          |  1 +
>   net/bpf/test_run.c     | 11 ++++++++-
>   net/core/dev.c         | 26 +++++++++++++++++++-
>   net/core/filter.c      | 44 +++++++++------------------------
>   net/core/lwt_bpf.c     |  3 +++
>   9 files changed, 111 insertions(+), 45 deletions(-)
> 

I like it :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b02aea291b7e8..0a7f6e4a00b60 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -733,21 +733,59 @@ struct bpf_nh_params {
>   	};
>   };
>   
> +/* flags for bpf_redirect_info kern_flags */
> +#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
> +#define BPF_RI_F_RI_INIT	BIT(1)
> +
>   struct bpf_redirect_info {
>   	u64 tgt_index;
>   	void *tgt_value;
>   	struct bpf_map *map;
>   	u32 flags;
> -	u32 kern_flags;
>   	u32 map_id;
>   	enum bpf_map_type map_type;
>   	struct bpf_nh_params nh;
> +	u32 kern_flags;
>   };
>   
> -DECLARE_PER_CPU(struct bpf_redirect_info, bpf_redirect_info);
> +struct bpf_net_context {
> +	struct bpf_redirect_info ri;
> +};
>   
> -/* flags for bpf_redirect_info kern_flags */
> -#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
> +static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> +{
> +	struct task_struct *tsk = current;
> +
> +	if (tsk->bpf_net_context != NULL)
> +		return NULL;
> +	bpf_net_ctx->ri.kern_flags = 0;
> +
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
> +	if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
> +		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
> +		bpf_net_ctx->ri.kern_flags |= BPF_RI_F_RI_INIT;
> +	}
> +
> +	return &bpf_net_ctx->ri;
> +}
>   
>   /* Compute the linear packet data range [data, data_end) which
>    * will be accessed by various program types (cls_bpf, act_bpf,
> @@ -1018,25 +1056,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>   				       const struct bpf_insn *patch, u32 len);
>   int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
>   
> -void bpf_clear_redirect_map(struct bpf_map *map);
> -
>   static inline bool xdp_return_frame_no_direct(void)
>   {
> -	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>   
>   	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
>   }
>   
>   static inline void xdp_set_return_frame_no_direct(void)
>   {
> -	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>   
>   	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
>   }
>   
>   static inline void xdp_clear_return_frame_no_direct(void)
>   {
> -	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>   
>   	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
>   }
> @@ -1592,7 +1628,7 @@ static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 inde
>   						   u64 flags, const u64 flag_mask,
>   						   void *lookup_elem(struct bpf_map *map, u32 key))
>   {
> -	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
> +	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>   	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;

