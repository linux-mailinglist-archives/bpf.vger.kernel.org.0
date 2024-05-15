Return-Path: <bpf+bounces-29752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D708C641E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944EB1C21A23
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4295A4D5;
	Wed, 15 May 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MQJRNZmo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B375A0E0
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766495; cv=none; b=qs46I6tC7KQsOUhH7JtFyx9revEuNPo/yTKfbb9ZmHJgCA9gbsO8W8Y6IodIXpK+nz12abDqnO4ryAvsbmTJc4wH80s4870eplAcO00D9BttkC1+xCY+zEqRWl+hEX/NyGYnmKYDeeXV3nbBB6QVfSyTAp5BgoLMPGschom7xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766495; c=relaxed/simple;
	bh=H9I5y314uT6KJjlHzr5ZCjJZM5vCbb5k41Bcy2g85JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YkbAh2CFIoliwyqwXZSIAMqIrLkekvfDoL66Nu+mClgrNuP6zFvsEI1eBkbYlu0F3i77EerS4rCxFFxWjp9HBCi7F3ptIeec7GpZ+vRssWTJdCkmJOPchApq/LGHHGR8/G7RFZlks42o5l07ZCE+LUz3qTw9WqBpn+7+7q/DLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MQJRNZmo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso1360831a12.3
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715766491; x=1716371291; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvdvxKzsIXlbkkCS/c8FlBp7an8yZdRF5H/FBmVMbF0=;
        b=MQJRNZmo4nT0duU8DCTFLPZ/3u3ZjshzYZ5EWUWK2vmHxJTCBLtRxUgaWY5E/A9qLK
         3vZLnWozA5PLUX/2ZmZ+r5h+hHjIQx46NMm/eVhFuo/42/9uo4py+QLz2vS3cMBy7Csl
         Zx/6JHTsoSzR9hFRNyKhsKsHp9zzd52GzTXedgmgnwZll+psNyb8tvw8Pv4wgHde5LIM
         lPWwtJ4SdsTfVgL7nZgd87Y5FKCuuT99uad3zKWDZiZiBPmL8eZlJT8tsRIGZxpPejBG
         vmNQH7ojWz+vOstWWcUn/S/IPtaA0YGWeqHHLCGN0WE19yTcLa5g8YxV5vQxIKCsU557
         jqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766491; x=1716371291;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvdvxKzsIXlbkkCS/c8FlBp7an8yZdRF5H/FBmVMbF0=;
        b=wDH5iFctGLvvXNby2WUjLhaafPZ+rv5azWOkIFEQM/0q3Hu+m4tE3uNX6C3I7NO8om
         WN1gXyk0xUxnbrkTTVh9+6li6L97ZxR+ynus7MJZao7OxFz7yKFNJIUBYZTlMJaGLRQY
         9S7uIU7wOfHP+x9gYJtpmqdFwVkHJvKo9XVOqHwQoWN5+iRgBeb8l3YNEaqtxm/GANhE
         30gthjv8IRe6TUbyxaHI19Wl2Jw8dTOv66PA4EMJNV1yz58wufmFP2F1ygl2BfKQyA0I
         1lJHSEMmiQMK0+SuGcfvA1HZ9nY11KhQE4mKx+r6Lp1C2mVb6joR1BXZnmhU2rBNWLul
         +uog==
X-Forwarded-Encrypted: i=1; AJvYcCUlnfNCmwz/vV2yvRj6RwqpW5ZYoQNNUxBnKCbxvOUnKJjpdy6bbxj2QqLbNXB5H+fivZEJG78xN1JxcZO6l74QN/KA
X-Gm-Message-State: AOJu0Yyig/77+Ji2C2kJq6P0o+odl5/3qbiiaJDbcKagYovJFS1rgy9p
	ZUvaJaTe7ua6/v+HNzoATPXfceUY5R7H1GziznXi+KSldQ0Ht9yFYvnAUAI4QXk=
X-Google-Smtp-Source: AGHT+IHyuK8hf39Mrn4kHBbuQOKmVcIaKCNYD4xN1HPPn/SRu5yzRFnMwhRQ8pYbw4tPVT3jc9hndQ==
X-Received: by 2002:a17:906:f296:b0:a58:f13d:d378 with SMTP id a640c23a62f3a-a5a2d54c5d6mr1072040666b.13.1715766491126;
        Wed, 15 May 2024 02:48:11 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a88a2ba62sm170355966b.91.2024.05.15.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:48:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@google.com,  haoluo@google.com,
  jolsa@kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  laoar.shao@gmail.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  yangzhenze@bytedance.com,
  wangdongdong.6@bytedance.com
Subject: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
In-Reply-To: <20240515081901.91058-1-zhoufeng.zf@bytedance.com> (Feng zhou's
	message of "Wed, 15 May 2024 16:19:01 +0800")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 15 May 2024 11:48:09 +0200
Message-ID: <87seyjwgme.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 15, 2024 at 04:19 PM +08, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> Set the full package write tcp option, the test found that the loss
> will be 20%. If a package wants to write tcp option, it will trigger
> bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
> call "tcp_established_options" to reserve tcp opt len, call
> "bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
> TSO. Through bpftrace tracking, it was found that during the pressure
> test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
> len does not change often, consider caching opt len for optimization.

You could also make your BPF sock_ops program cache the value and return
the cached value when called for BPF_SOCK_OPS_HDR_OPT_LEN_CB.

If that is in your opinion prohibitevely expensive then it would be good
to see a sample program and CPU cycle measurements (bpftool prog profile).

>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>  include/linux/tcp.h            |  3 +++
>  include/uapi/linux/bpf.h       |  8 +++++++-
>  net/ipv4/tcp_output.c          | 12 +++++++++++-
>  tools/include/uapi/linux/bpf.h |  8 +++++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..74437fcf94a2 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -455,6 +455,9 @@ struct tcp_sock {
>  					  * to recur itself by calling
>  					  * bpf_setsockopt(TCP_CONGESTION, "itself").
>  					  */
> +	u8	bpf_opt_len;		/* save tcp opt len implementation
> +					 * BPF_SOCK_OPS_HDR_OPT_LEN_CB fast path
> +					 */
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
>  #else
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 90706a47f6ff..f2092de1f432 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6892,8 +6892,14 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Fast path to reserve space in a skb under
> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
> +	 */
> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };
>  
>  /* List of known BPF sock_ops operators.
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index ea7ad7d99245..0e7480a58012 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -488,12 +488,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct bpf_sock_ops_kern sock_ops;
>  	int err;
> +	struct tcp_sock *th = (struct tcp_sock *)sk;
>  
> -	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> +	if (likely(!BPF_SOCK_OPS_TEST_FLAG(th,
>  					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
>  	    !*remaining)
>  		return;
>  
> +	if (likely(BPF_SOCK_OPS_TEST_FLAG(th,
> +					  BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG)) &&
> +	    th->bpf_opt_len) {
> +		*remaining -= th->bpf_opt_len;

What if *remaining value shrinks from one call to the next?

BPF sock_ops program can't react to change. Feels like there should be a
safety check to prevent an underflow.

> +		opts->bpf_opt_len = th->bpf_opt_len;
> +		return;
> +	}
> +
>  	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
>  
>  	/* init sock_ops */
> @@ -538,6 +547,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
>  	/* round up to 4 bytes */
>  	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
> +	th->bpf_opt_len = opts->bpf_opt_len;
>  
>  	*remaining -= opts->bpf_opt_len;
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 90706a47f6ff..f2092de1f432 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6892,8 +6892,14 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Fast path to reserve space in a skb under
> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
> +	 */
> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),

Have you considered a bpf_reserve_hdr_opt() flag instead?

An example or test coverage would to show this API extension in action
would help.

>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };
>  
>  /* List of known BPF sock_ops operators.

