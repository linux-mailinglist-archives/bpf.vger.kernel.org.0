Return-Path: <bpf+bounces-51324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED2A3333F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75981188AD51
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657A207A02;
	Wed, 12 Feb 2025 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oUyNxkLV"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFF1ACEA7
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402350; cv=none; b=pdB+iMvXTWgSeAjWg8EKzFZRg6ZComQyaUbOC1+X3ZUKPE85kraLZQwwONeYPE8IIwmqt/rCUtG/Qq2BkySDGMGfJ4PK98ldPa6bz6mBezk/2lLF3sSedk+QowRgFJ0OJMrBa72Z5WTsNQ7EcIjJ+qXjQdl9sy61Mr5pNTMQ19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402350; c=relaxed/simple;
	bh=uJ3BchwZTL4I2uIdLOAcThpaVgOW4gsWrSzd1TQVWy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWqeQz+2V5oOmHWNdTzwh7dMjuYygtn6A/B1OJxn3czF/+dTWM08KZCxVdC1iWsqPc2skDMFu2y1bAkK929hipAbb0r1jfNzfjbZLazCoHRTjys2XX+8AumPWhVo12TSiPSqqpPZ6q+cpFyK4olw+ZFj3vC1t/9yGRmdsD4CFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oUyNxkLV; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1b7106d-2c36-4663-bf46-807337f792bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739402345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKgQ7WPp3r+FnLIuOPTHBEEhb2/CXcnlaDY5RN/hocI=;
	b=oUyNxkLVRXo5zuOkysb0qOLRzLZALn5SYEWwxi0ZT8Dtt5Mf72R8VAwdk7QrdxBavRb5nx
	JnPlJT9WXEzMsVahfBiPNTckziRckCemL7FhTCL6SU41uy0aCpJ2VacaqWUglf6QLTZm3b
	iQZGEH2LLtCrkVvxYyi1bQHXEt/46AU=
Date: Wed, 12 Feb 2025 15:18:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 07/12] bpf: add BPF_SOCK_OPS_TS_SW_OPT_CB
 callback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-8-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250212061855.71154-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/11/25 10:18 PM, Jason Xing wrote:
> Support sw SCM_TSTAMP_SND case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_SW_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's software SCM_TSTAMP_SND. The BPF program can use it to
> get the same SCM_TSTAMP_SND timestamp without modifying the
> user-space application.
> 
> Based on this patch, BPF program will get the software
> timestamp when the driver is ready to send the skb. In the
> sebsequent patch, the hardware timestamp will be supported.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         | 2 +-
>   include/uapi/linux/bpf.h       | 4 ++++
>   net/core/skbuff.c              | 9 ++++++++-
>   tools/include/uapi/linux/bpf.h | 4 ++++
>   4 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 52f6e033e704..76582500c5ea 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4568,7 +4568,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>   static inline void skb_tx_timestamp(struct sk_buff *skb)
>   {
>   	skb_clone_tx_timestamp(skb);
> -	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> +	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
>   		skb_tstamp_tx(skb, NULL);
>   }
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 68664ececdc0..b3bd92281084 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7039,6 +7039,10 @@ enum {
>   					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
> +					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7bac5e950e3d..d80d2137692f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5557,6 +5557,7 @@ static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
>   }
>   
>   static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
> +						  struct skb_shared_hwtstamps *hwts,

s/hwts/hwtstamps/
Use the same argument name as all other functions in this file. Its caller is 
using hwtstamps as the argument name also. Easier to follow.

Probably the same for the skb_tstamp_tx_report_so_timestamping().

>   						  struct sock *sk,
>   						  int tstype)
>   {
> @@ -5566,6 +5567,11 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
>   	case SCM_TSTAMP_SCHED:
>   		op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>   		break;
> +	case SCM_TSTAMP_SND:
> +		if (hwts)
> +			return;
> +		op = BPF_SOCK_OPS_TS_SW_OPT_CB;
> +		break;
>   	default:
>   		return;
>   	}
> @@ -5586,7 +5592,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		return;
>   
>   	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> -		skb_tstamp_tx_report_bpf_timestamping(orig_skb, sk, tstype);
> +		skb_tstamp_tx_report_bpf_timestamping(orig_skb, hwtstamps,
> +						      sk, tstype);
>   
>   	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
>   		return;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index eed91b7296b7..9bd1c7c77b17 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7029,6 +7029,10 @@ enum {
>   					 * dev layer when SK_BPF_CB_TX_TIMESTAMPING
>   					 * feature is on.
>   					 */
> +	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
> +					 * to the nic when SK_BPF_CB_TX_TIMESTAMPING
> +					 * feature is on.
> +					 */
>   };
>   
>   /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect


