Return-Path: <bpf+bounces-49733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61A5A1C009
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A1188FEC5
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE366199920;
	Sat, 25 Jan 2025 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WHbDFiSv"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AF1991DB
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767393; cv=none; b=QC5KGp0BppaqrOg95F9Fr2r/OcXTd3OQa4cBPasiMQWgVJB/Eucxll7wBMshrSDF7fvhepkQ4oX8UQ5NrRPyzj7at9oX+5s9CcOQeLwkQ6NrgI1wS7WrtXkRnlYclmNnyXZf+4SxXecNd7kiP/JMbPSBSxivgZdwG6P7jBjJNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767393; c=relaxed/simple;
	bh=UmSAfM9RV8whxp65NUZ6e1UKVCRS0brhWpbzK1gCSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICC++NJcRqLljmdU+LrXcOd1oZwIyGq6Vl6asZZG6DKYnTGJ5r0JsFYwf2GwFM/1U2Jzb4Q4IpBJ3/4Z+2oLzzeymje5HrQrq8D8iPRSlja/HRSYZBNvW6R7jRGQhEbGj9owt2FkjhtdS+4E0Gmzo5cjU9EakaTFE0hV96lte/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WHbDFiSv; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0697db8c-9909-4abb-932d-51413850cdd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737767389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VlmsTZhWis28WVHX+6DJKvsE9ZhzkonmhfKddu+5WeY=;
	b=WHbDFiSv4NSBC1KDzq5VjRA082nhqvIOjzKAyS5jtRishgn2pSCT+lYIQv7xxrzr6SaOvh
	eLkCLV02VHjVNXLdGHvwJInFgJwKIYzUUsnZrnr5osUhgi1GbvZZr+EFBZRPCMHfi1nY9X
	dOBePuCxIxzIfhllwWKf3tE8LWg1TcY=
Date: Fri, 24 Jan 2025 17:09:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 12/13] net-timestamp: introduce cgroup
 lock to avoid affecting non-bpf cases
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-13-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:29 PM, Jason Xing wrote:
> Introducing the lock to avoid affecting the applications which
> are not using timestamping bpf feature.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/skbuff.c     | 6 ++++--
>   net/ipv4/tcp.c        | 3 ++-
>   net/ipv4/tcp_input.c  | 3 ++-
>   net/ipv4/tcp_output.c | 3 ++-
>   4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 33340e0b094f..db5b4b653351 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5605,11 +5605,13 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>   		return;
>   
>   	/* bpf extension feature entry */
> -	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&

I wonder if it is really needed. The caller has just tested the tx_flags.

> +	    skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
>   		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
>   
>   	/* application feature entry */
> -	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&

Same here and this one looks wrong also. The userspace may get something 
unexpected in the err queue. The bpf prog may have already detached here after 
setting the SKBTX_BPF earlier.

> +	    !skb_enable_app_tstamp(orig_skb, tstype, sw))
>   		return;
>   
>   	tsflags = READ_ONCE(sk->sk_tsflags);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 49e489c346ea..d88160af00c4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>   	}
>   
> -	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&

This looks ok considering SK_BPF_CB_FLAG_TEST may get to another cacheline.

> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
>   		struct skb_shared_info *shinfo = skb_shinfo(skb);
>   		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>   
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index c8945f5be31b..e30607ba41e5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3324,7 +3324,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
>   
>   	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
>   	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> -		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))
> +		   !(cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&

Same here. txtstamp_ack has just been tested.... txstamp_ack_bpf is the next bit.

> +		     TCP_SKB_CB(skb)->txstamp_ack_bpf)))
>   		return;
>   
>   	shinfo = skb_shinfo(skb);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index fc84ca669b76..483f19c2083e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1556,7 +1556,8 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
>   static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
>   {
>   	return TCP_SKB_CB(skb)->txstamp_ack ||
> -	       TCP_SKB_CB(skb)->txstamp_ack_bpf ||
> +	       (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&

Same here.

> +		TCP_SKB_CB(skb)->txstamp_ack_bpf) ||
>   		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
>   }
>   


