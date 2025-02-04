Return-Path: <bpf+bounces-50347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B5A26929
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047037A12CD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9B78F3E;
	Tue,  4 Feb 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBxPsOg7"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893D46434
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630623; cv=none; b=IML43VqEmuqVO4NllNWucOmyiD0UMjOwigQETscarnuQ6tSMd2174kAWsSemloyriCyDt/lWrOXByCFYe1WrIAkTp9Fs2DmqsXYQ2XAhmPe29t91LKNn6UZ+Uhgu4pmnp5GJDVQ9AQWRj4Nez1jSLFUb7dGyNYbbaruEry1eJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630623; c=relaxed/simple;
	bh=nKlRIpXDKlxE+D08XLD3Fh+fMkkbxb5zx4dccgVVjJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a98NWDwnSQ6gO1aW9DumkILsMBPwYHUMdRSE4B1hXxVh2P/vz+RQ309oJUqc2YyOrdMr4dG9n1AHu+rMOPABYL37ok2MFXA1SDvoIh694Fbrk7jITiLya7ErOuNEkOVGunoCsHHHxJ2EjeptwwMBfK2z/7HBB7tJSpzdvS3R4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBxPsOg7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5be0c7cd-cf89-4ab9-a7c4-381ca2e2903f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738630616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu/JhCBG8yb/twVA3WYb3haWQ2Ff2DGWUDja2ugh5ec=;
	b=LBxPsOg7H3lHxLdCHJmZ1HhoSOUhUen65wibu9aJVKX7rgt6ZtBWLwUPfo2gA7dojzGT+G
	fWcAgNM2jZCzBOdj60qLLnRiPcIPZQgpLA2NkvfEE0hMl7RHra7xYrNtWvMe5KfHT1yTpc
	XkiUkylVXNGeBISp2/cX6go2+0hvZi8=
Date: Mon, 3 Feb 2025 16:56:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-9-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> In this patch, we finish the hardware part. Then bpf program can
> fetch the hwstamp from skb directly.
> 
> To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
> use this simple modification like this patch does to support printing
> hardware timestamp.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         |  4 +++-
>   include/uapi/linux/bpf.h       |  7 +++++++
>   net/core/skbuff.c              | 11 ++++++-----
>   net/dsa/user.c                 |  2 +-
>   net/socket.c                   |  2 +-
>   tools/include/uapi/linux/bpf.h |  7 +++++++
>   6 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index de8d3bd311f5..df2d790ae36b 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
>   /* Definitions for tx_flags in struct skb_shared_info */
>   enum {
>   	/* generate hardware time stamp */
> -	SKBTX_HW_TSTAMP = 1 << 0,
> +	__SKBTX_HW_TSTAMP = 1 << 0,
>   
>   	/* generate software time stamp when queueing packet to NIC */
>   	SKBTX_SW_TSTAMP = 1 << 1,
> @@ -495,6 +495,8 @@ enum {
>   	SKBTX_BPF = 1 << 7,
>   };
>   
> +#define SKBTX_HW_TSTAMP		(__SKBTX_HW_TSTAMP | SKBTX_BPF)
> +
>   #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
>   				 SKBTX_SCHED_TSTAMP | \
>   				 SKBTX_BPF)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6a1083bcf779..4c3566f623c2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7040,6 +7040,13 @@ enum {
>   					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SK_BPF_CB_TX_TIMESTAMPING feature
> +					 * is on. At the same time, hwtstamps
> +					 * of skb is initialized as the
> +					 * timestamp that hardware just
> +					 * generates.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 288eb9869827..c769feae5162 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5548,7 +5548,7 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>   		flag = SKBTX_SCHED_TSTAMP;
>   		break;
>   	case SCM_TSTAMP_SND:
> -		flag = sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
> +		flag = sw ? SKBTX_SW_TSTAMP : __SKBTX_HW_TSTAMP;
>   		break;
>   	case SCM_TSTAMP_ACK:
>   		if (TCP_SKB_CB(skb)->txstamp_ack)
> @@ -5565,7 +5565,8 @@ static bool skb_enable_app_tstamp(struct sk_buff *skb, int tstype, bool sw)
>   }
>   
>   static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
> -			      int tstype, bool sw)
> +			      int tstype, bool sw,
> +			      struct skb_shared_hwtstamps *hwtstamps)
>   {
>   	int op;
>   
> @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>   		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>   		break;
>   	case SCM_TSTAMP_SND:
> +		op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
>   		if (!sw)

Patch 5 mentioned hwtstamps could be NULL, so this should be "if (hwtstamps)" here.

> -			return;
> -		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +			*skb_hwtstamps(skb) = *hwtstamps;

Otherwise, this will crash.

pw-bot: cr


>   		break;
>   	default:
>   		return;

