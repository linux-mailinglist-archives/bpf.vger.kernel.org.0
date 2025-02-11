Return-Path: <bpf+bounces-51111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC755A30437
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67AD3A488F
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E91EA7D7;
	Tue, 11 Feb 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSLJyMVg"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C126BDB6
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257959; cv=none; b=pXLeJbv1OEsgRcR37DDXkCovJsl6JBB0dru2Ruo88xp5ihrguCie2U4BK3ZOKGJYqeQnzHO3qfrLRSIJvkrWow5v+rWPTIz1ClxgzoQw+TqBvCqI9uaZ0kxPL0HJyiKTxaLCiyaTz646lMdHjqcp3R1yHZdVfL3PvOwh96tTOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257959; c=relaxed/simple;
	bh=Vt7v5URqxF8orVeDqpKNv9nVBi5rowXTGbUZ9gle0NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKU064CD6z/AV6dCEvwZmawYX9lLzdT4qDyc7MZuySDv8/kXOo5pmbmbjcT/gj9Tmn6/UWMzxJyJpHMtWf3UPj0ZHG2UnHZMIM0VHEHpIjRdQrBo4oqX6TAqowaTdEeNTq96sQGD6Pb8h02xT7hSiUkyNuOMOemAVp2p4kHVF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSLJyMVg; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d9da8b0-5246-4760-abf8-dc70d7a5e3ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739257945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrGz1a6HN3IJF7A0YIdxK2o+nLMgzSKJDA/ph+Nkhvw=;
	b=mSLJyMVgDede1YuwptrYFhrtNFxS1fGuFHHrENaPbLWorWnTiV+mpZ+ByO86PZnLOslluq
	QyR+V0Bl7M5i354S/KwuueTiCITtdkmnj1tBdm3lRHPD5crMC8Imam0htW9Wx044fShSku
	xwG0UwtsUTn8ymxj9zPLJxOBahyYeuY=
Date: Mon, 10 Feb 2025 23:12:18 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 06/12] bpf: support SCM_TSTAMP_SCHED of
 SO_TIMESTAMPING
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-7-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250208103220.72294-7-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> Support SCM_TSTAMP_SCHED case. Introduce SKBTX_BPF used as
> an indicator telling us whether the skb should be traced
> by the bpf prog.

The BPF side does not exactly support SCM_TSTAMP_SCHED as a report value.

What this patch does is:

Add a new sock_ops callback, BPF_SOCK_OPS_TS_SCHED_OPT_CB. This callback will 
occur at the same timestamping point as the user space's SCM_TSTAMP_SCHED. The
BPF program can use it to get the same SCM_TSTAMP_SCHED timestamp without 
modifying the user-space application.

A new SKBTX_BPF flag is added to mark skb_shinfo(skb)->tx_flags, ensuring that 
the new BPF timestamping and the current user space's SO_TIMESTAMPING do not 
interfere with each other.

I would remove most of the SO_TIMESTAMPING comments from the commit messages. 
The timestamping points are the same but there is not much overlapping on the 
API side.

Subject could be:
bpf: Add BPF_SOCK_OPS_TS_SCHED_OPT_CB callback

[ The same probably for patch 7-9. ]

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         |  6 +++++-
>   include/uapi/linux/bpf.h       |  4 ++++
>   net/core/dev.c                 |  3 ++-
>   net/core/skbuff.c              | 20 ++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  4 ++++
>   5 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..52f6e033e704 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -489,10 +489,14 @@ enum {
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
> index 6116eb3d1515..30d2c078966b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7032,6 +7032,10 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/dev.c b/net/core/dev.c
> index afa2282f2604..d57946c96511 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>   	skb_reset_mac_header(skb);
>   	skb_assert_len(skb);
>   
> -	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> +	if (unlikely(skb_shinfo(skb)->tx_flags &
> +		     (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
>   		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SCHED);
>   
>   	/* Disable soft irqs for various locks below. Also
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 46530d516909..6f55eb90a632 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5555,6 +5555,23 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
>   	return false;
>   }
>   
> +static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
> +						  struct sock *sk,
> +						  int tstype)
> +{
> +	int op;
> +
> +	switch (tstype) {
> +	case SCM_TSTAMP_SCHED:
> +		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	bpf_skops_tx_timestamping(sk, skb, op);
> +}
> +
>   void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		     const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> @@ -5567,6 +5584,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   	if (!sk)
>   		return;
>   
> +	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
> +
>   	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tstype, sw))
>   		return;
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70366f74ef4e..eed91b7296b7 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7025,6 +7025,10 @@ enum {
>   					 * by the kernel or the
>   					 * earlier bpf-progs.
>   					 */
> +	BPF_SOCK_OPS_TS_SCHED_OPT_CB,	/* Called when skb is passing through
> +					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


