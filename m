Return-Path: <bpf+bounces-49730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CA5A1BFF9
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B507A57A9
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE432C148;
	Sat, 25 Jan 2025 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xd9Rt7NB"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539E17C2
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737766025; cv=none; b=Ikq4iqGdORcEyovFPSLskowWKaYZqISgUKTUVOf9rlrgzxvyYqzPgh3P0RlU3SZeMihkSJ/tpg3/egCKeeMQSA8u/sdgt9PIshs8kPDF6aMpiawUgnAIDx878pf6dSf0e0IeOAOJUbEFMeG/yuf3r+Z6aClSq17ihorPAVbkelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737766025; c=relaxed/simple;
	bh=xJrC+KY0vsZJiLqpl/1KEoJwx5yTUqfSeJNA9ggj+uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXenrxjw3oYrtG+GMqU8oslfyg8MNuGbwbmYdqLNKfp38TUe8Ri9sR5YHjDxenAPzMREvr9I0HcFFGcLt1IDgAROqXwytownQMQe+UUcbgLK4ZvzB5VEEP2yILOYZbJ/SjkGiUP3fYbyDSXd66Cs5tAOn7NqZK/GZrC7SLre33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xd9Rt7NB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737766015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHvPRD6b0J9toPaf5Br5kczsEw4qDsF5K3EHLrZkIJk=;
	b=Xd9Rt7NB2BwAcikCz2daWXb9aUNsnt5x1xteTgUMYaKdzrVW7eDnCmMWX7t7QQWIHHnIwo
	0NCUytZEu+RzOkpZxvp7pe2CrSRH7ngm+4hbF+RoDwSS8rO+EcUATOskPEFGIAvYPjtY9W
	zwPbeoah9AUq61OzaxXSA4JbSRjCEFg=
Date: Fri, 24 Jan 2025 16:46:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-9-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
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
>   include/uapi/linux/bpf.h       |  5 +++++
>   net/core/skbuff.c              | 11 ++++++-----
>   net/dsa/user.c                 |  2 +-
>   net/socket.c                   |  2 +-
>   tools/include/uapi/linux/bpf.h |  5 +++++
>   6 files changed, 21 insertions(+), 8 deletions(-)
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
> index a6d761f07f67..8936e1061e71 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7032,6 +7032,11 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_HW_OPT_CB,	/* Called in hardware phase when
> +					 * SO_TIMESTAMPING feature is on.

Same comment on the "SO_TIMESTAMPING".

It will be useful to elaborate more on "hardware phase", like exactly when it 
will be called,

> +					 * It indicates the recorded
> +					 * timestamp.

and the hwtstamps will be in the skb.

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
> -			return;
> -		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +			*skb_hwtstamps(skb) = *hwtstamps;

hwtstamps may still be NULL, no?


