Return-Path: <bpf+bounces-46748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AA9EFF6D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D2C1885A04
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C71DE2DF;
	Thu, 12 Dec 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f44eidoj"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA96189B9C
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042988; cv=none; b=LcHKTmOhuxF1XnB7u/Mn1W8+6uELzdQmBIFf+vuyPUXgjhPGwMQ87M1HMnbL/yNkT1Crk6gC27Qbr6/9b0XyN5kHaXXKwRjwid7GQXzAfDkJMRupjtNLClwk4Aejam62pvP1rkI7YOVLJRb5k6q1zB+rqaScbe9BC7PGXNdYX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042988; c=relaxed/simple;
	bh=4nHzrR1dCAvwLpD/zvgXzjkG6d8i6ABZ3Rp+5dCAvOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZjJTZEQwfU+yIB7ZltWpdmKcRKgg3caHewdyff85BTXBNGnnYpG2uXMuF55sjnI1HHqf71IspV/EDfx/dvuMl7SIyn9tWprAVX2gSI4zYnjoxq0WWS9Ct+t9iE/m+LZRDbe08zlX4CDpSRezEcwEw9AOX7aTJb3o3ZTiCrUoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f44eidoj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6ccdc72c-f21c-4b02-aba3-b70363e58982@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734042982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvg65xsqQEeY9acJ7qVcnHH7lSWf1aowHbIE2O8XBuQ=;
	b=f44eidojWCzkCLPnz5DnqHcJyP86YEjcWokFgXfB4NnJoxa2m4Gcvz/dRHkw7de4oTFMHJ
	yEDUrBsq3Z6zvcYjVSyz2INCkpiD8h2ft6gj03xEnKNeRIjWFN6YePWGwcCo/o7wPTPg7/
	AbCuBlRrYWKdkGielgPhu3diOxg4ffQ=
Date: Thu, 12 Dec 2024 14:36:11 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 06/11] net-timestamp: support SCM_TSTAMP_ACK
 for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-7-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241207173803.90744-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:37 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> can work, but we need to Introduce a new txstamp_ack_bpf to avoid
> cache line misses in tcp_ack_tstamp().
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/tcp.h              | 3 ++-
>   include/uapi/linux/bpf.h       | 5 +++++
>   net/core/skbuff.c              | 9 ++++++---
>   net/ipv4/tcp_input.c           | 3 ++-
>   net/ipv4/tcp_output.c          | 5 +++++
>   tools/include/uapi/linux/bpf.h | 5 +++++
>   6 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index e9b37b76e894..8e5103d3c6b9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -959,9 +959,10 @@ struct tcp_skb_cb {
>   	__u8		sacked;		/* State flags for SACK.	*/
>   	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
>   	__u8		txstamp_ack:1,	/* Record TX timestamp for ack? */
> +			txstamp_ack_bpf:1,	/* ack timestamp for bpf use */

After quickly peeking at patch 8, I realize that the new txstamp_ack_bpf bit is 
not needed. SKBTX_BPF bit (in skb_shinfo(skb)->tx_flags) and the txstamp_ack_bpf 
are always set together. Then only use the SKBTX_BPF bit should be as good.

>   			eor:1,		/* Is skb MSG_EOR marked? */
>   			has_rxtstamp:1,	/* SKB has a RX timestamp	*/
> -			unused:5;
> +			unused:4;
>   	__u32		ack_seq;	/* Sequence number ACK'd	*/
>   	union {
>   		struct {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a6d761f07f67..a0aff1b4eb61 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7032,6 +7032,11 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
> +					 * acknowledged when SO_TIMESTAMPING
> +					 * feature is on. It indicates the
> +					 * recorded timestamp.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 73b15d6277f7..48b0c71e9522 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5553,6 +5553,9 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
>   	case SCM_TSTAMP_SND:
>   		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>   		break;
> +	case SCM_TSTAMP_ACK:
> +		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
> +		break;
>   	default:
>   		return;
>   	}
> @@ -5632,9 +5635,9 @@ static bool skb_tstamp_is_set(const struct sk_buff *skb, int tstype, bool bpf_mo
>   			return true;
>   		return false;
>   	case SCM_TSTAMP_ACK:
> -		if (TCP_SKB_CB(skb)->txstamp_ack)
> -			return true;
> -		return false;
> +		flag = bpf_mode ? TCP_SKB_CB(skb)->txstamp_ack_bpf :
> +				  TCP_SKB_CB(skb)->txstamp_ack;
> +		return !!flag;
>   	}
>   
>   	return false;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bdf13ac26ef..82bb26f5b214 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3321,7 +3321,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>   	const struct skb_shared_info *shinfo;
>   
>   	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
> -	if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
> +	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> +		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))

Change the test here to:
	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
		   !(skb_shinfo(skb)->tx_flags & SKBTX_BPF)))

Does it make sense?


