Return-Path: <bpf+bounces-31783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4A903490
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E9DB27E21
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423FC17333D;
	Tue, 11 Jun 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuymS0Mq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8E172798;
	Tue, 11 Jun 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092518; cv=none; b=bvTf+3nm/FiwcvYe8ckKPqO0dME9bhjawH2K25/lQ9i6HQP72cq3gxdGadPKWhQQNPF+AM0T5LeNGVdlYT9lrEQX5S/zPJjmj3zvpeuDyWSHLmSe1XnNJ9zPYgNjIe52VOkGV3awGVh8MAjQaVeVKxjbb7EjwviZvRnNTIaPWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092518; c=relaxed/simple;
	bh=Zi4uy1TUma6iabLgVVre8jD58HzqwP0vUE0xLv/7Wpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr40RCX/GDLeiRjfCqsbt4ev1eA6nGzq3IQQCld42+HvBAbkVywLGZRhQT53EQ9heMB8H6x1OWYo5TCZDOezElBcxAutu8L4sKqtsPrA7SFG6BvklyuZK0hBV+NKXuhDTpconYgNMvcNiyPTB59hIT/WOsxpZgjnTI3j2ELSn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuymS0Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D390C2BD10;
	Tue, 11 Jun 2024 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718092518;
	bh=Zi4uy1TUma6iabLgVVre8jD58HzqwP0vUE0xLv/7Wpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuymS0MqIHbqDgregRyzyDcz69F6eXl/Fo5BfNplmTGp86AAVEAMPAvf7h+mb+qO4
	 fGS4OCL0zJNXL1MHqWQdqleAjMdklkBJf/MSuBpn4QXVv4SCf8OG0u75lvbMX1QLu+
	 Pu61V5acO8Qfq0w+e4cvXfz+QjjlT8W+ycnaxMLUweE/0v0Tep5ys5AyYJBTxxba24
	 qfqSPL4tCXY+e4ATgtBbX2jsAdjYCh7AfdxikFHQhVW7xe1C/wwjTVwFTkR4rPnMz1
	 7q6pHPV68t/d3DVZh53YBKuTwpHe5nsMbmkSTw7JZq5NbjWh8C8JVK6AtHS6bX2IdS
	 +2sCiwMbk0WYQ==
Message-ID: <18328cc2-c135-4b69-8c5f-cd45998e970f@kernel.org>
Date: Tue, 11 Jun 2024 09:55:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
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
 <045e3716-3c3a-4238-b38a-3616c8974e2c@kernel.org>
 <20240610165014.uWp_yZuW@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240610165014.uWp_yZuW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/06/2024 18.50, Sebastian Andrzej Siewior wrote:
> On 2024-06-07 13:51:25 [+0200], Jesper Dangaard Brouer wrote:
>> The memset can be further optimized as it currently clears 64 bytes, but
>> it only need to clear 40 bytes, see pahole below.
>>
>> Replace memset with something like:
>>   memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
>>
>> This is an optimization, because with 64 bytes this result in a rep-stos
>> (repeated string store operation) that on Intel touch CPU-flags (to be
>> IRQ safe) which is slow, while clearing 40 bytes doesn't cause compiler
>> to use this instruction, which is faster.  Memset benchmarked with [1]
> 
> I've been playing along with this and have to say that "rep stosq" is
> roughly 3x slower vs "movq" for 64 bytes on all x86 I've been looking
> at.

Thanks for confirming "rep stos" is 3x slower for small sizes.


> For gcc the stosq vs movq depends on the CPU settings. The generic uses
> movq up to 40 bytes, skylake uses movq even for 64bytes. clang…
> This could be tuned via -mmemset-strategy=libcall:64:align,rep_8byte:-1:align
> 

Cool I didn't know of this tuning.  Is this a compiler option?
Where do I change this setting, as I would like to experiment with this
for our prod kernels.

My other finding is, this primarily a kernel compile problem, because
for userspace compiler chooses to use MMX instructions (e.g. movaps
xmmword ptr[rsp], xmm0).  The kernel compiler options (-mno-sse -mno-mmx
-mno-sse2 -mno-3dnow -mno-avx) disables this, which aparently changes
the tipping point.


> I folded this into the last two patches:
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index d2b4260d9d0be..1588d208f1348 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -744,27 +744,40 @@ struct bpf_redirect_info {
>   	struct bpf_nh_params nh;
>   };
>   
> +enum bpf_ctx_init_type {
> +	bpf_ctx_ri_init,
> +	bpf_ctx_cpu_map_init,
> +	bpf_ctx_dev_map_init,
> +	bpf_ctx_xsk_map_init,
> +};
> +
>   struct bpf_net_context {
>   	struct bpf_redirect_info ri;
>   	struct list_head cpu_map_flush_list;
>   	struct list_head dev_map_flush_list;
>   	struct list_head xskmap_map_flush_list;
> +	unsigned int flags;

Why have yet another flags variable, when we already have two flags in 
bpf_redirect_info ?

>   };
>   
> +static inline bool bpf_net_ctx_need_init(struct bpf_net_context *bpf_net_ctx,
> +					 enum bpf_ctx_init_type flag)
> +{
> +	return !(bpf_net_ctx->flags & (1 << flag));
> +}
> +
> +static inline bool bpf_net_ctx_set_flag(struct bpf_net_context *bpf_net_ctx,
> +					enum bpf_ctx_init_type flag)
> +{
> +	return bpf_net_ctx->flags |= 1 << flag;
> +}
> +
>   static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
>   {
>   	struct task_struct *tsk = current;
>   
>   	if (tsk->bpf_net_context != NULL)
>   		return NULL;
> -	memset(&bpf_net_ctx->ri, 0, sizeof(bpf_net_ctx->ri));
> -
> -	if (IS_ENABLED(CONFIG_BPF_SYSCALL)) {
> -		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
> -		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
> -	}
> -	if (IS_ENABLED(CONFIG_XDP_SOCKETS))
> -		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
> +	bpf_net_ctx->flags = 0;
>   
>   	tsk->bpf_net_context = bpf_net_ctx;
>   	return bpf_net_ctx;
> @@ -785,6 +798,11 @@ static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
>   {
>   	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>   
> +	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_ri_init)) {
> +		memset(&bpf_net_ctx->ri, 0, offsetof(struct bpf_net_context, ri.nh));
> +		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_ri_init);
> +	}
> +
>   	return &bpf_net_ctx->ri;
>   }
>   
> @@ -792,6 +810,11 @@ static inline struct list_head *bpf_net_ctx_get_cpu_map_flush_list(void)
>   {
>   	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>   
> +	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_cpu_map_init)) {
> +		INIT_LIST_HEAD(&bpf_net_ctx->cpu_map_flush_list);
> +		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_cpu_map_init);
> +	}
> +
>   	return &bpf_net_ctx->cpu_map_flush_list;
>   }
>   
> @@ -799,6 +822,11 @@ static inline struct list_head *bpf_net_ctx_get_dev_flush_list(void)
>   {
>   	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>   
> +	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_dev_map_init)) {
> +		INIT_LIST_HEAD(&bpf_net_ctx->dev_map_flush_list);
> +		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_dev_map_init);
> +	}
> +
>   	return &bpf_net_ctx->dev_map_flush_list;
>   }
>   
> @@ -806,6 +834,11 @@ static inline struct list_head *bpf_net_ctx_get_xskmap_flush_list(void)
>   {
>   	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
>   
> +	if (bpf_net_ctx_need_init(bpf_net_ctx, bpf_ctx_xsk_map_init)) {
> +		INIT_LIST_HEAD(&bpf_net_ctx->xskmap_map_flush_list);
> +		bpf_net_ctx_set_flag(bpf_net_ctx, bpf_ctx_xsk_map_init);
> +	}
> +
>   	return &bpf_net_ctx->xskmap_map_flush_list;
>   }
>   
> 
> Sebastian

