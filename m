Return-Path: <bpf+bounces-11379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F47B81D6
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 45C17B2097C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5617980;
	Wed,  4 Oct 2023 14:09:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5963FF1;
	Wed,  4 Oct 2023 14:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9973C433C7;
	Wed,  4 Oct 2023 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696428568;
	bh=szFz4YybWVjwyW+r82OEsjOxDV1ouR3ha/lQm56FgEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qD22DDjR7ngDrGhAGeNod1F08/63/1KaaLzrBMxvLqqUtPYebLVcTF2LkAw1elTxr
	 hdTqWYczmA3VGG/ZmneFs3zRR1ejAvpTq9oDJ53J904SrPd0ieBY4Ahf5nUid4NjdM
	 jrONVFVYBs9b7kf2F0MqfkAUKgNXrnMpPWE2J0mgb4IX6zEp+R+zdS46wZ4Ftgwanr
	 JAFkR8b/yYMMKHp7UdAiv4r0Vtcxuc95/q7XiePCGmU3vYGZRtKc50mXXFwc01wFaQ
	 q8uK9JC+/OmYEsWj9JEqS/WgRdKhuEerIHeDTXEPYx6JOffQiY2n3ppvuzznAosqmR
	 1hVS8VyqJIHxg==
Date: Wed, 4 Oct 2023 07:09:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>, Paolo
 Abeni <pabeni@redhat.com>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Message-ID: <20231004070926.5b4ba04c@kernel.org>
In-Reply-To: <20230929165825.RvwBYGP1@linutronix.de>
References: <20230929165825.RvwBYGP1@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 18:58:25 +0200 Sebastian Andrzej Siewior wrote:
> +#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_DEBUG_NET)
> +bool __dev_check_flush(void);
> +bool __cpu_map_check_flush(void);
> +
> +#else
> +static inline bool __dev_check_flush(void)
> +{
> +	return false;
> +}
> +
> +static inline bool __cpu_map_check_flush(void)
> +{
> +	return false;
> +}
> +#endif

I think you're going too hard with the ifdefs.
These functions are only called if DEBUG_NET, add if BPF on the call
site and spare us the static inlines for all the __ helpers.

>  static __always_inline int
>  bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
>  {
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 27406aee2d402..db095d731813e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1025,6 +1025,14 @@ int xdp_do_redirect_frame(struct net_device *dev,
>  			  struct bpf_prog *prog);
>  void xdp_do_flush(void);
>  
> +#ifdef CONFIG_DEBUG_NET
> +void xdp_do_check_flushed(struct napi_struct *napi);
> +
> +#else
> +static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
> +
> +#endif

Can you move this to net/core/dev.h? Or a new header under net/core
if you prefer? This looks internal to the stack.
Also nit: drop the empty lines inside the #ifdef?

