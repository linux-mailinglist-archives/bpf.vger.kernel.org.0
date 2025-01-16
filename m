Return-Path: <bpf+bounces-49007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834CA12F77
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93243A618A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702023A6;
	Thu, 16 Jan 2025 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+PQTCTg"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421D360;
	Thu, 16 Jan 2025 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736985845; cv=none; b=cKj0xfAfePSzogXLTKwa6GbvJt7ntdgOY6xSK97P81VdyOaPJzp6zekdPjEV/ZG4Vl1NmRzpqV2+JrASjJg+ZjVIFsVhd1/F/QiUsrmYBR+F9dTPyEu0uvKua5ee+MyZHILN8XzPb5TjPrAh9+AxA7cg1IGMNnSkjt5TvTnjO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736985845; c=relaxed/simple;
	bh=IrUYSKH/O7pmDzauwEdwJz9B2ArnSvqiJOKtOu/+Knk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqlt/LlwMGSg9/bilL3Sqb1X0BPGx+QnCkC8RlDpMOawRYOw354C0lGFEm0MUx4cNCCPcjH4DogP/YkxUMQXgU7wSv/J4WjmBrffjDwDOUa/Etc/1FGGbkbAwsbR51xO2egXWy/vNeZRuHYWtPguFbK/SPCXp/oU9ZsFToPcM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+PQTCTg; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d9ba064-3288-4926-b9dc-3119bb3404c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736985841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=grUuNHzbk9eYJZ2uKEHcxdyVTr7XAipNzFw1EzAqcxo=;
	b=A+PQTCTgRbtRY2LzAbAWVwVd/Y0SB7oZ6Q7CjOtijo2HMcffjDggLT66Nfh32rR6bqD0XR
	d+IdypTjjkoyUl5XEbsrq6uEtYhWwLiaY5YeTYB885u2Cddwz9uxfZ9VVUjJC2T/PFTNDz
	h4qaUs4wBo7BXfT/ukKWPLPQTm0lvWI=
Date: Wed, 15 Jan 2025 16:03:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 13/15] net-timestamp: support tcp_sendmsg for
 bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-14-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-14-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> Introduce tskey_bpf to correlate tcp_sendmsg timestamp with other
> three points (SND/SW/ACK). More details can be found in the
> selftest.
> 
> For TCP, tskey_bpf is used to store the initial write_seq value
> the moment tcp_sendmsg is called, so that the last skb of this
> call will have the same tskey_bpf with tcp_sendmsg bpf callback.
> 
> UDP works similarly because tskey_bpf can increase by one everytime
> udp_sendmsg gets called. It will be implemented soon.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         |  2 ++
>   include/uapi/linux/bpf.h       |  3 +++
>   net/core/sock.c                |  3 ++-
>   net/ipv4/tcp.c                 | 10 ++++++++--
>   tools/include/uapi/linux/bpf.h |  3 +++
>   5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index d3ef8db94a94..3b7b470d5d89 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -609,6 +609,8 @@ struct skb_shared_info {
>   	};
>   	unsigned int	gso_type;
>   	u32		tskey;
> +	/* For TCP, it records the initial write_seq when sendmsg is called */
> +	u32		tskey_bpf;

I would suggest to remove this tskey_bpf addition to skb_shared_info. My 
understanding is the intention is to get the delay spent in the 
tcp_sendmsg_locked(). I think this can be done in bpf_sk_storage. More below.

>   
>   	/*
>   	 * Warning : all fields before dataref are cleared in __alloc_skb()
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a0aff1b4eb61..87420c0f2235 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7037,6 +7037,9 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
> +					 * syscall is triggered
> +					 */

UDP will need this also?

>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2f54e60a50d4..e74ab0e2979d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -958,7 +958,8 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>   	if (sk_is_tcp(sk) && sk_fullsock(sk))
>   		sock_ops.is_fullsock = 1;
>   	sock_ops.sk = sk;
> -	bpf_skops_init_skb(&sock_ops, skb, 0);
> +	if (skb)
> +		bpf_skops_init_skb(&sock_ops, skb, 0);
>   	sock_ops.timestamp_used = 1;
>   	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>   }
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0a41006b10d1..b6e0db5e4ead 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -477,7 +477,7 @@ void tcp_init_sock(struct sock *sk)
>   }
>   EXPORT_SYMBOL(tcp_init_sock);
>   
> -static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc, u32 first_write_seq)
>   {
>   	struct sk_buff *skb = tcp_write_queue_tail(sk);
>   	u32 tsflags = sockc->tsflags;
> @@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   		tcb->txstamp_ack_bpf = 1;
>   		shinfo->tx_flags |= SKBTX_BPF;
>   		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;

Add the bpf prog callout here instead:

		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_TCP_SND_CB);

If the bpf prog wants to figure out the delay from the very beginning of the 
tcp_sendmsg_locked(), a bpf prog (either by tracing the tcp_sendmsg_locked or by 
adding a new callout at the beginning of tcp_sendmsg_locked like this patch) can 
store a bpf_ktime_get_ns() in the bpf_sk_storage. The bpf prog running here (at 
tcp_tx_timestamp) can get that timestamp from the bpf_sk_storage since it has a 
hold on the same sk pointer. There is no need to add a new shinfo->tskey_bpf to 
measure this part of the delay.

> +		shinfo->tskey_bpf = first_write_seq;
>   	}
>   }
>   
> @@ -1067,10 +1068,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   	int flags, err, copied = 0;
>   	int mss_now = 0, size_goal, copied_syn = 0;
>   	int process_backlog = 0;
> +	u32 first_write_seq = 0;
>   	int zc = 0;
>   	long timeo;
>   
>   	flags = msg->msg_flags;
> +	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
> +		first_write_seq = tp->write_seq;
> +		bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP_SND_CB);

My preference is to skip this bpf callout for now and depends on a bpf trace 
program if it is really needed.

> +	}
>   
>   	if ((flags & MSG_ZEROCOPY) && size) {
>   		if (msg->msg_ubuf) {
> @@ -1331,7 +1337,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   
>   out:
>   	if (copied) {
> -		tcp_tx_timestamp(sk, &sockc);
> +		tcp_tx_timestamp(sk, &sockc, first_write_seq);
>   		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
>   	}
>   out_nopush:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 0fe7d663a244..3769e38e052d 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7030,6 +7030,9 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
> +					 * syscall is triggered
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


