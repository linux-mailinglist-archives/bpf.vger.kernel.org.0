Return-Path: <bpf+bounces-49728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9260FA1BFE3
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5851167C1E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6794C81;
	Sat, 25 Jan 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFZ3wgxl"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966CAD23
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765493; cv=none; b=I2TghBBKQDoc5hW51+ZSXAY/cAd2baQHOqqT0YonLAxbrYELH5zQOk107NFjCs1K+E4nIf+ooE1Xy3lRLa2Sq7S9qKthKdv60HLz3L6Y9nn9QweXrc8ny6bDWfZ+JAJOfffs1UKfvi6rsJEHD3Dip8Pvnzxv0EQFXZJtmQ0QHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765493; c=relaxed/simple;
	bh=fjdjqs0FfX8pK8EcUv8yjgt/ymkYLmTAvdYJMD5ewgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLbVba5zSphJbdJneEITbWmlmk5TGPxx1WgdXsPFTuLuM0m6gyl7i+v937oz3G//35gtTW+/jMD2AbSOY4R9TbYXQjJ7yAq6lt9F3rF1ZHa9vxAsDjTpS/yf+K9YzbzPBx3GCCKR7vB7S4hajfWXHuLYSrHRySM2JkJX4kRs2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFZ3wgxl; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50459085-8517-4de2-bd59-d0ae740d36a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737765489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0un8GoSiSPeRojuvTGPNqlYNplBZgxwH2UeVfJxWqQI=;
	b=ZFZ3wgxlywDG91lvOb2n4+GxuqXzCq3RnJXWNXNZxJOT0lRVbdGhGaTDsedY5gH06LhuOa
	zS9otfqW5/gSlqMn4GJ1Kx3hJjI2NHEDENxJtTYQPNB+b8HMxlZApTkXlvmBhMCKdiXvIG
	io+dNTmtdX8ci8a6Uqo/OjywThfIYWo=
Date: Fri, 24 Jan 2025 16:38:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 06/13] net-timestamp: support
 SCM_TSTAMP_SCHED for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-7-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
> Introducing SKBTX_BPF is used as an indicator telling us whether
> the skb should be traced by the bpf prog.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         |  6 +++++-
>   include/uapi/linux/bpf.h       |  5 +++++
>   net/core/dev.c                 |  3 ++-
>   net/core/skbuff.c              | 23 +++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  5 +++++
>   5 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index dfc419281cc9..35c2e864dd4b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -490,10 +490,14 @@ enum {
>   
>   	/* generate software time stamp when entering packet scheduling */
>   	SKBTX_SCHED_TSTAMP = 1 << 6,
> +
> +	/* used for bpf extension when a bpf program is loaded */
> +	SKBTX_BPF = 1 << 7,
>   };
>   
>   #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> -				 SKBTX_SCHED_TSTAMP)
> +				 SKBTX_SCHED_TSTAMP | \
> +				 SKBTX_BPF)
>   #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
>   				 SKBTX_HW_TSTAMP_USE_CYCLES | \
>   				 SKBTX_ANY_SW_TSTAMP)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e629e09b0b31..72f93c6e45c1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7022,6 +7022,11 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SO_TIMESTAMPING

The "SO_TIMESTAMPING" term is not accurate. I guess you meant 
"SK_BPF_CB_TX_TIMESTAMPING"?

Also, may be "Called before skb entering qdisc"?

> +					 * feature is on. It indicates the
> +					 * recorded timestamp.

There is no timestamp recorded also.



