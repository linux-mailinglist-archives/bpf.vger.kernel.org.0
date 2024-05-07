Return-Path: <bpf+bounces-28749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7F28BD8B4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4401F249CB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D2E441D;
	Tue,  7 May 2024 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hbbLEjJK"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013110F2
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715042710; cv=none; b=DzP4FCvrCH+LjB1G85RF1+pEBKI0aUjCXCHu6zkxMJ8TMHGgR6qrJdcGwr665qjW0dezfDcbSSUvYgQpLCqwUWmuJzA+Od/bJXQ1Ol5gmnWS4MaN5d+z3UDGB4UrbxZDluF4uEFZKGrPpWIfJz8QQ1bVMZ0gwRGSTC1HlcODc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715042710; c=relaxed/simple;
	bh=3q8dZA3RYVxRLzlIk4TjtCOswwWtpfJrGsc5PYHxJ5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMfd63FfZg/FI10M77EuDhkmf81kuXdNKtE4JHACM4dI4fMU4bkurefqvF95H3zVW7BhzGeT3ZanMCdMcdUzF+k2zVYngZKrys2vq1Neyofu8trzxUR+SxaYI2ctiyX3XDtWnAj1IeDfTo2QhLIywniZOgoZwxReTuj0mVGBIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hbbLEjJK; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cab0c7ba-90bf-49e2-908d-ecd879160667@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715042704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmC0CJo8VGzdQ+lw2Wkc3ro98vq94DGKwTKxAwIJ2N8=;
	b=hbbLEjJKcnmdol7u+0trYocZ/jOzebxlC08hEzYJsAmRpFEcoDH7g08lwsHZ/kI6Zw+DWe
	rdCXGeJxV2BIODY7ys+Yc9tVi2/EKFdfNbWgXurK/Qm+oMKTp0L1Bogjhftm0qAX8AeNeK
	MQQNU84f+HtzLLwpUr/DBZVPbSv/Oms=
Date: Mon, 6 May 2024 17:44:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support
 clockid_t timestamp type
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240504031331.2737365-3-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/3/24 8:13 PM, Abhishek Chauhan wrote:
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index fe86cadfa85b..c3d852eecb01 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>   
>   	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>   	skb->mark = cork->mark;
> -	skb->tstamp = cork->transmit_time;
> +	if (sk_is_tcp(sk))

This seems not catching all IPPROTO_TCP case. In particular, the percpu 
"ipv4_tcp_sk" is SOCK_RAW. sk_is_tcp() is checking SOCK_STREAM:

void __init tcp_v4_init(void)
{

	/* ... */
	res = inet_ctl_sock_create(&sk, PF_INET, SOCK_RAW,
				   IPPROTO_TCP, &init_net);

	/* ... */
}

"while :; do ./test_progs -t tc_redirect/tc_redirect_dtime || break; done" 
failed pretty often exactly in this case.

> +		skb_set_delivery_type_by_clockid(skb, cork->transmit_time, CLOCK_MONOTONIC);
> +	else
> +		skb_set_delivery_type_by_clockid(skb, cork->transmit_time, sk->sk_clockid);
>   	/*
>   	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
>   	 * on dst refcount

[ ... ]

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 05067bd44775..797a9764e8fe 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1924,7 +1924,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
>   
>   	skb->priority = READ_ONCE(sk->sk_priority);
>   	skb->mark = cork->base.mark;
> -	skb->tstamp = cork->base.transmit_time;
> +	if (sk_is_tcp(sk))
> +		skb_set_delivery_type_by_clockid(skb, cork->base.transmit_time, CLOCK_MONOTONIC);
> +	else
> +		skb_set_delivery_type_by_clockid(skb, cork->base.transmit_time, sk->sk_clockid);
>   
>   	ip6_cork_steal_dst(skb, cork);
>   	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);


