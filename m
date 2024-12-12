Return-Path: <bpf+bounces-46759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18839F001E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EC516329D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6E1DE8BA;
	Thu, 12 Dec 2024 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xiPiFSnd"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609131DE8BC
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045984; cv=none; b=sWy+urKP25miA463KVjN7/lVEvAdt1PvOtLr36AxHjNyZopf2CK1sz3SrD+OKE0+FkZE+3YeRojmVdtr4+YmtGu6/v+5N3you+RZd9BKJBAHyqbG94Nk2Gt2rwWrbnCYrYmJPYTYjJVwfkELZ6SLPwdc/prXMgMyo4sXoApQzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045984; c=relaxed/simple;
	bh=2QArz9HR0Mn4eH46qUNMNUMzAH9biw3LyfowCZSeyDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN9sUW0icnEWYguNrl4Wb6Bmrj4ClsfBfa8ZL3+BZnMhak/ug7Mq+d7Fx/a9nFjp89HiDTQxK+ThkpuKS85VGBcPznQ61CV0d3Ns2RJr+4ToYwzSDkxQE0VAUAhkPmg/AaFDB+zrr6JACLoJ1qFVJ3vSv0vkIdZzwkHkjU76vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xiPiFSnd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3abb0b6-cd94-46f6-b996-f90da7e790b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734045970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtmzuoydkMml2x/nxzE/7XluiqfmaP/qMJmj3Zm1urw=;
	b=xiPiFSndYUQ2tOUkMMR7XEHrFihDoiPrSbnE2qrSgo4quoCaW03IVXPjhDpkio7jkniub2
	hy5YqTqTsWaa2q8t+9/qIRe3d/gbsoTkH1qayIx6Ra5Cx4s8cvyMJ1/wVuGyOezhdmBCc2
	aHezcfRZyI3wqq1fs70Ipr6qWNApyEs=
Date: Thu, 12 Dec 2024 15:25:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 07/11] net-timestamp: support hwtstamp print
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
 <20241207173803.90744-8-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241207173803.90744-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:37 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Passing the hwtstamp to bpf prog which can print.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/net/sock.h |  6 ++++--
>   net/core/skbuff.c  | 17 +++++++++++++----
>   net/core/sock.c    |  4 +++-
>   3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index f88a00108a2f..9bc883573208 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2921,9 +2921,11 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   
>   void sock_enable_timestamps(struct sock *sk);
>   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> -void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
> +			       u32 nargs, u32 *args);
>   #else
> -static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
> +					     u32 nargs, u32 *args)
>   {
>   }
>   #endif
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48b0c71e9522..182a44815630 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5539,8 +5539,12 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   }
>   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
>   
> -static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype)
> +static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
> +				struct skb_shared_hwtstamps *hwtstamps,
> +				int tstype)
>   {
> +	struct timespec64 tstamp;
> +	u32 args[2] = {0, 0};
>   	int op;
>   
>   	if (!sk)
> @@ -5552,6 +5556,11 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
>   		break;
>   	case SCM_TSTAMP_SND:
>   		op = BPF_SOCK_OPS_TS_SW_OPT_CB;

> +		if (hwtstamps) {
> +			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);

Avoid this conversion which is likely not useful to the bpf prog. Directly pass 
hwtstamps->hwtstamp (in ns?) to the bpf prog. Put lower 32bits in args[0] and 
higher 32bits in args[1].

Also, how about adding a BPF_SOCK_OPS_TS_"HW"_OPT_CB for the "hwtstamps != NULL" 
case instead of reusing the BPF_SOCK_OPS_TS_"SW"_OPT_CB?

A more subtle thing for the hwtstamps case is, afaik the bpf prog will not be 
called. All drivers are still only testing SKBTX_HW_TSTAMP instead of testing
(SKBTX_HW_TSTAMP | SKBTX_BPF).

There are a lot of drivers to change though. A quick thought is to rename the 
existing SKBTX_HW_TSTAMP (e.g. __SKBTX_HW_TSTAMP = 1 << 0) and define 
SKBTX_HW_TSTAMP like:

#define SKBTX_HW_TSTAMP (__SKBTX_HW_TSTAMP | SKBTX_BPF)

Then change some of the existing skb_shinfo(skb)->tx_flags "setting" site to use 
__SKBTX_HW_TSTAMP instead. e.g. in __sock_tx_timestamp(). Not very pretty but 
may be still better than changing many drivers. May be there is a better way...

While talking about where to test the SKBTX_BPF bit, I wonder if the new 
skb_tstamp_is_set() is needed. For the non SKBTX_HW_TSTAMP case, the number of 
tx_flags testing sites should be limited, so should be easy to add the SKBTX_BPF 
bit test. e.g. at the __dev_queue_xmit, test "if 
(unlikely(skb_shinfo(skb)->tx_flags & (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))". Patch 
6 has also tested the bpf specific bit at tcp_ack_tstamp() before calling the 
__skb_tstamp_tx().

At the beginning of __skb_tstamp_tx(), do something like this:

void __skb_tstamp_tx(struct sk_buff *orig_skb,
		     const struct sk_buff *ack_skb,
		     struct skb_shared_hwtstamps *hwtstamps,
		     struct sock *sk, int tstype)
{
	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
	    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_BPF))
		__skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);

	if (unlikely(!(skb_shinfo(skb)->tx_flags & ~SKBTX_BPF)))
		return;

Then the new skb_tstamp_tx_output() shuffle is probably not be needed also.

> +			args[0] = tstamp.tv_sec;
> +			args[1] = tstamp.tv_nsec;
> +		}
>   		break;
>   	case SCM_TSTAMP_ACK:
>   		op = BPF_SOCK_OPS_TS_ACK_OPT_CB;
> @@ -5560,7 +5569,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb, int tstype
>   		return;
>   	}
>   
> -	bpf_skops_tx_timestamping(sk, skb, op);
> +	bpf_skops_tx_timestamping(sk, skb, op, 2, args);
>   }
>   
>   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> @@ -5651,7 +5660,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, false)))
>   		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
>   	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
> -		__skb_tstamp_tx_bpf(sk, orig_skb, tstype);
> +		__skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
>   }
>   EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
>   
> @@ -5662,7 +5671,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>   
>   	skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk, tstype);
>   	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
> -		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, tstype);
> +		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, hwtstamps, tstype);
>   }
>   EXPORT_SYMBOL_GPL(skb_tstamp_tx);
>   
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 79cb5c74c76c..504939bafe0c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -942,7 +942,8 @@ int sock_set_timestamping(struct sock *sk, int optname,
>   }
>   
>   #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> -void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op,
> +			       u32 nargs, u32 *args)

Directly pass hwtstamps->hwtstamp instead of args and nargs. Save a memcpy below.

>   {
>   	struct bpf_sock_ops_kern sock_ops;
>   
> @@ -952,6 +953,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>   	sock_ops.op = op;
>   	sock_ops.is_fullsock = 1;
>   	sock_ops.sk = sk;
> +	memcpy(sock_ops.args, args, nargs * sizeof(*args));
>   	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>   }
>   #endif


