Return-Path: <bpf+bounces-74057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A0C461CD
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA84E7692
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5773074B1;
	Mon, 10 Nov 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiW2B8mL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A62E63C;
	Mon, 10 Nov 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772777; cv=none; b=hftJx4mZXjcEmMv1vclROtzhVEz5noP7PVSbk+yq5Jh3lnUt5gEyPz6TrfQrno56ZPOLK4/jASPD+15I4kjIy746+gtIRlppd4swDgf3MrkOWemyPZoX0P2dGT+jITqvQl+tue4ZMOEFtxAB0ji5owIq3nTV8nNn9cwlXgjAYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772777; c=relaxed/simple;
	bh=qIObqiroWcgVL4Dt8RU7ppjIuvnj+Y2jxYFSiNagdVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/ZEl3LEjeh/xdQhp2ObOa7biHd4I4x+27f637OPOhlUrYXiL9f+yMYNUoeUhutF3ocAVnh/cUBMsv51yIqZzw0Ht1W+C36+EUCJPX0y7OQfjrqT9W29N8yO7J8hVw3KdYi+27qCxM1qRNaSCToiTC5oaVUAtTLIClSzJ6kMVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiW2B8mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1998C116B1;
	Mon, 10 Nov 2025 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762772775;
	bh=qIObqiroWcgVL4Dt8RU7ppjIuvnj+Y2jxYFSiNagdVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SiW2B8mLy3S8XHCuBpY45fj0nYxsGJyTG/9aTuD1a2SZlHAhUsitzqjyNmv5Y6JKV
	 5dHk55Kdu6crkKN1/RxlEoiPlD/bybWYtegP8WYr1dS4FJSfTKAXi7SQvRsDFlR+vW
	 j/jHxAfg2dAkNwu2MipHANxx5fAARWe6cexWsUZkP/p80NtR3uGspMTltkJnmDtQ2K
	 r61cIiaLO6MgTXP8hjlEkeHjR9eMGTTN2fFutZwdyiA9gH0taIi8ffr1ATOOiCqEwK
	 2DXRAz0+8eTi0RCLQiAzWiqF9RLJJEhj2vV967F/fYnR810sWqPDRvDtcrQphrFY25
	 M2FunhX11Etjg==
Message-ID: <d0fc4c6a-c4d7-4d62-9e6f-6c05c96a51de@kernel.org>
Date: Mon, 10 Nov 2025 12:06:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] xdp: Delegate fast path return decision to page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>,
 David Ahern <dsahern@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>, KP Singh <kpsingh@kernel.org>
References: <20251107102853.1082118-2-dtatulea@nvidia.com>
 <20251107102853.1082118-5-dtatulea@nvidia.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251107102853.1082118-5-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/11/2025 11.28, Dragos Tatulea wrote:
> XDP uses the BPF_RI_F_RF_NO_DIRECT flag to mark contexts where it is not
> allowed to do direct recycling, even though the direct flag was set by
> the caller. This is confusing and can lead to races which are hard to
> detect [1].
> 
> Furthermore, the page_pool already contains an internal
> mechanism which checks if it is safe to switch the direct
> flag from off to on.
> 
> This patch drops the use of the BPF_RI_F_RF_NO_DIRECT flag and always
> calls the page_pool release with the direct flag set to false. The
> page_pool will decide if it is safe to do direct recycling. This
> is not free but it is worth it to make the XDP code safer. The
> next paragrapsh are discussing the performance impact.
> 
> Performance wise, there are 3 cases to consider. Looking from
> __xdp_return() for MEM_TYPE_PAGE_POOL case:
> 
> 1) napi_direct == false:
>    - Before: 1 comparison in __xdp_return() + call of
>      page_pool_napi_local() from page_pool_put_unrefed_netmem().
>    - After: Only one call to page_pool_napi_local().
> 
> 2) napi_direct == true && BPF_RI_F_RF_NO_DIRECT
>    - Before: 2 comparisons in __xdp_return() + call of
>      page_pool_napi_local() from page_pool_put_unrefed_netmem().
>    - After: Only one call to page_pool_napi_local().
> 
> 3) napi_direct == true && !BPF_RI_F_RF_NO_DIRECT
>    - Before: 2 comparisons in __xdp_return().
>    - After: One call to page_pool_napi_local()
> 
> Case 1 & 2 are the slower paths and they only have to gain.
> But they are slow anyway so the gain is small.
> 
> Case 3 is the fast path and is the one that has to be considered more
> closely. The 2 comparisons from __xdp_return() are swapped for the more
> expensive page_pool_napi_local() call.
> 
> Using the page_pool benchmark between the fast-path and the
> newly-added NAPI aware mode to measure [2] how expensive
> page_pool_napi_local() is:
> 
>    bench_page_pool: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
>    bench_page_pool: Type:tasklet_page_pool01_fast_path Per elem: 15 cycles(tsc) 7.537 ns (step:0)
> 
>    bench_page_pool: time_bench_page_pool04_napi_aware(): in_serving_softirq fast-path
>    bench_page_pool: Type:tasklet_page_pool04_napi_aware Per elem: 20 cycles(tsc) 10.490 ns (step:0)
> 

IMHO fast-path slowdown is significant.  This fast-path is used for the
XDP_DROP use-case in drivers.  The fast-path is competing with the speed
of updating an (per-cpu) array and a function-call overhead. The
performance target for XDP_DROP is NIC *wirespeed* which at 100Gbit/s is
148Mpps (or 6.72ns between packets).

I still want to seriously entertain this idea, because (1) because the
bug[1] was hard to find, and (2) this is mostly an XDP API optimization
that isn't used by drivers (they call page_pool APIs directly for
XDP_DROP case).
Drivers can do this because they have access to the page_pool instance.

Thus, this isn't a XDP_DROP use-case.
  - This is either XDP_REDIRECT or XDP_TX use-case.

The primary change in this patch is, changing the XDP API call 
xdp_return_frame_rx_napi() effectively to xdp_return_frame().

Looking at code users of this call:
  (A) Seeing a number of drivers using this to speed up XDP_TX when 
*completing* packets from TX-ring.
  (B) drivers/net/xen-netfront.c use looks incorrect.
  (C) drivers/net/virtio_net.c use can easily be removed.
  (D) cpumap.c and drivers/net/tun.c should not be using this call.
  (E) devmap.c is the main user (with multiple calls)

The (A) user will see a performance drop for XDP_TX, but these driver
should be able to instead call the page_pool APIs directly as they
should have access to the page_pool instance.

Users (B)+(C)+(D) simply needs cleanup.

User (E): devmap is the most important+problematic user (IIRC this was
the cause of bug[1]).  XDP redirecting into devmap and running a new
XDP-prog (per target device) was a prime user of this call
xdp_return_frame_rx_napi() as it gave us excellent (e.g. XDP_DROP)
performance.

Perhaps we should simply measure the impact on devmap + 2nd XDP-prog
doing XDP_DROP.  Then, we can see if overhead is acceptable... ?

> ... and the slow path for reference:
> 
>    bench_page_pool: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
>    bench_page_pool: Type:tasklet_page_pool02_ptr_ring Per elem: 30 cycles(tsc) 15.395 ns (step:0)

The devmap user will basically fallback to using this code path.

> So the impact is small in the fast-path, but not negligible. One thing
> to consider is the fact that the comparisons from napi_direct are
> dropped. That means that the impact will be smaller than the
> measurements from the benchmark.
> 
> [1] Commit 2b986b9e917b ("bpf, cpumap: Disable page_pool direct xdp_return need larger scope")
> [2] Intel Xeon Platinum 8580
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>   drivers/net/veth.c     |  2 --
>   include/linux/filter.h | 22 ----------------------
>   include/net/xdp.h      |  2 +-
>   kernel/bpf/cpumap.c    |  2 --
>   net/bpf/test_run.c     |  2 --
>   net/core/filter.c      |  2 +-
>   net/core/xdp.c         | 24 ++++++++++++------------
>   7 files changed, 14 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142cb8e..6d5c1e0b05a7 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -975,7 +975,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   
>   	bq.count = 0;
>   
> -	xdp_set_return_frame_no_direct();
>   	done = veth_xdp_rcv(rq, budget, &bq, &stats);
>   
>   	if (stats.xdp_redirect > 0)
> @@ -994,7 +993,6 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   
>   	if (stats.xdp_tx > 0)
>   		veth_xdp_flush(rq, &bq);
> -	xdp_clear_return_frame_no_direct();
>   
>   	return done;
>   }
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5c859b8131a..877e40d81a4c 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -764,7 +764,6 @@ struct bpf_nh_params {
>   };
>   
>   /* flags for bpf_redirect_info kern_flags */
> -#define BPF_RI_F_RF_NO_DIRECT	BIT(0)	/* no napi_direct on return_frame */
>   #define BPF_RI_F_RI_INIT	BIT(1)
>   #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
>   #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
> @@ -1163,27 +1162,6 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>   				       const struct bpf_insn *patch, u32 len);
>   int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt);
>   
> -static inline bool xdp_return_frame_no_direct(void)
> -{
> -	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
> -
> -	return ri->kern_flags & BPF_RI_F_RF_NO_DIRECT;
> -}
> -
> -static inline void xdp_set_return_frame_no_direct(void)
> -{
> -	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
> -
> -	ri->kern_flags |= BPF_RI_F_RF_NO_DIRECT;
> -}
> -
> -static inline void xdp_clear_return_frame_no_direct(void)
> -{
> -	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
> -
> -	ri->kern_flags &= ~BPF_RI_F_RF_NO_DIRECT;
> -}
> -
>   static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
>   				 unsigned int pktlen)
>   {
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c35..2a44d84a7611 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -446,7 +446,7 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
>   }
>   
>   void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
> -		  bool napi_direct, struct xdp_buff *xdp);
> +		  struct xdp_buff *xdp);
>   void xdp_return_frame(struct xdp_frame *xdpf);
>   void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
>   void xdp_return_buff(struct xdp_buff *xdp);
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 703e5df1f4ef..3ece03dc36bd 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -253,7 +253,6 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>   
>   	rcu_read_lock();
>   	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> -	xdp_set_return_frame_no_direct();
>   
>   	ret->xdp_n = cpu_map_bpf_prog_run_xdp(rcpu, frames, ret->xdp_n, stats);
>   	if (unlikely(ret->skb_n))
> @@ -263,7 +262,6 @@ static void cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>   	if (stats->redirect)
>   		xdp_do_flush();
>   
> -	xdp_clear_return_frame_no_direct();
>   	bpf_net_ctx_clear(bpf_net_ctx);
>   	rcu_read_unlock();
>   
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 8b7d0b90fea7..a0fe03e9e527 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -289,7 +289,6 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
>   	local_bh_disable();
>   	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
>   	ri = bpf_net_ctx_get_ri();
> -	xdp_set_return_frame_no_direct();
>   
>   	for (i = 0; i < batch_sz; i++) {
>   		page = page_pool_dev_alloc_pages(xdp->pp);
> @@ -352,7 +351,6 @@ static int xdp_test_run_batch(struct xdp_test_data *xdp, struct bpf_prog *prog,
>   			err = ret;
>   	}
>   
> -	xdp_clear_return_frame_no_direct();
>   	bpf_net_ctx_clear(bpf_net_ctx);
>   	local_bh_enable();
>   	return err;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16105f52927d..5622ec5ac19c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4187,7 +4187,7 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>   	}
>   
>   	if (release) {
> -		__xdp_return(netmem, mem_type, false, zc_frag);
> +		__xdp_return(netmem, mem_type, zc_frag);
>   	} else {
>   		if (!tail)
>   			skb_frag_off_add(frag, shrink);
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9100e160113a..cf8eab699d9a 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -431,18 +431,18 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
>    * of xdp_frames/pages in those cases.
>    */
>   void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
> -		  bool napi_direct, struct xdp_buff *xdp)
> +		  struct xdp_buff *xdp)
>   {
>   	switch (mem_type) {
>   	case MEM_TYPE_PAGE_POOL:
>   		netmem = netmem_compound_head(netmem);
> -		if (napi_direct && xdp_return_frame_no_direct())
> -			napi_direct = false;
> +
>   		/* No need to check netmem_is_pp() as mem->type knows this a
>   		 * page_pool page
> +		 *
> +		 * page_pool can detect direct recycle.
>   		 */
> -		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
> -					  napi_direct);
> +		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
>   		break;
>   	case MEM_TYPE_PAGE_SHARED:
>   		page_frag_free(__netmem_address(netmem));
> @@ -471,10 +471,10 @@ void xdp_return_frame(struct xdp_frame *xdpf)
>   	sinfo = xdp_get_shared_info_from_frame(xdpf);
>   	for (u32 i = 0; i < sinfo->nr_frags; i++)
>   		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
> -			     false, NULL);
> +			     NULL);
>   
>   out:
> -	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, false, NULL);
> +	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, NULL);
>   }
>   EXPORT_SYMBOL_GPL(xdp_return_frame);
>   
> @@ -488,10 +488,10 @@ void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
>   	sinfo = xdp_get_shared_info_from_frame(xdpf);
>   	for (u32 i = 0; i < sinfo->nr_frags; i++)
>   		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
> -			     true, NULL);
> +			     NULL);
>   
>   out:
> -	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, true, NULL);
> +	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, NULL);
>   }
>   EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);

The changed to xdp_return_frame_rx_napi() makes it equvilent to 
xdp_return_frame().

>   
> @@ -542,7 +542,7 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
>    */
>   void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
>   {
> -	__xdp_return(netmem, xdp->rxq->mem.type, true, NULL);
> +	__xdp_return(netmem, xdp->rxq->mem.type, NULL);
>   }
>   EXPORT_SYMBOL_GPL(xdp_return_frag);
>   
> @@ -556,10 +556,10 @@ void xdp_return_buff(struct xdp_buff *xdp)
>   	sinfo = xdp_get_shared_info_from_buff(xdp);
>   	for (u32 i = 0; i < sinfo->nr_frags; i++)
>   		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
> -			     xdp->rxq->mem.type, true, xdp);
> +			     xdp->rxq->mem.type, xdp);
>   
>   out:
> -	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
> +	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, xdp);
>   }
>   EXPORT_SYMBOL_GPL(xdp_return_buff);
>   


