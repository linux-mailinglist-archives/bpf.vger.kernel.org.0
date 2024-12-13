Return-Path: <bpf+bounces-46771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B89F00C9
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B3216A4B3
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB31372;
	Fri, 13 Dec 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U34RFqj4"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E321136E
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049743; cv=none; b=cH4bV7BKDxNArXwM9HNhb5OQqGS/pu/UAOUG6jzCgwhk4cYaSjPEA69htcx9SmDjWzWR+WDjZVzIQy51d0AjIIJfVYeVaWAXwj3iTGuyxBDkSbR8Uoy0drpVtnLp1zinT2Gt79nS3+bOpj4ROxbfoNt70hcYXN9oH/2/GlbvDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049743; c=relaxed/simple;
	bh=I2xbHgAcaQiqOdZQSwNGkFq1GJGqkeiVvflcm12j9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSWfQE1/Xmz3S9KlLIuCUaURgqX6l2/Sm6mPEl/Y5fShcD+SACkuJZYzrc6O3slA0vNeFbGX6IhDRVCiJ1tQw1NlBDCcC+7+fVlC9Hj7ebgke+sF6lHBQwqPWkIMoJboNKfvbVrSiNo7RuoWM+20dK2PAo49W0rX5PJyXSztqwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U34RFqj4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f5081bb-ed66-4171-acef-786ae02cf69c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734049738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dp/lcL/R+NB1OTjfvM4LWF5XMRD7YyKKWa5v8JFjmAk=;
	b=U34RFqj4ozNQo8pFiMEbLJVP2AjV104+VWeYZbP49wqSiCKRT1SGGuOzgEgmIBtdDRllOS
	c4NCcNlG/pKqOcdOQ3GakjNZwc2sVwq3K0kDbQsgE//QD/9nd1b3l0ocJpQHRKlGPEYa/O
	CffhrlJeG1nNVsi1NlRO3m2FRUWn4r4=
Date: Thu, 12 Dec 2024 16:28:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 10/11] net-timestamp: export the tskey for TCP
 bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-11-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241207173803.90744-11-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:38 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> For now, there are three phases where we are not able to fetch
> the right seqno from the skops->skb_data, because:
> 1) in __dev_queue_xmit(), the skb->data doesn't point to the start
> offset in tcp header.
> 2) in tcp_ack_tstamp(), the skb doesn't have the tcp header.
> 
> In the long run, we may add other trace points for bpf extension.
> And the shinfo->tskey is always the same value for both bpf and
> non-bpf cases. With that said, let's directly use shinfo->tskey
> for TCP protocol.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   net/core/skbuff.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7c59ef501c74..2e13643f791c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5544,7 +5544,7 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
>   				int tstype)
>   {
>   	struct timespec64 tstamp;
> -	u32 args[2] = {0, 0};
> +	u32 args[3] = {0, 0, 0};
>   	int op;
>   
>   	if (!sk)
> @@ -5569,7 +5569,10 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, struct sk_buff *skb,
>   		return;
>   	}
>   
> -	bpf_skops_tx_timestamping(sk, skb, op, 2, args);
> +	if (sk_is_tcp(sk))
> +		args[2] = skb_shinfo(skb)->tskey;

Instead of only passing one info "skb_shinfo(skb)->tskey" of a skb, pass the 
whole skb ptr to the bpf prog. Take a look at bpf_skops_init_skb. Lets start 
with end_offset = 0 for now so that the bpf prog won't use it to read the 
skb->data. It can be revisited later.

	bpf_skops_init_skb(&sock_ops, skb, 0);

The bpf prog can use bpf_cast_to_kern_ctx() and bpf_core_cast() to get to the 
skb_shinfo(skb). Take a look at the md_skb example in type_cast.c.

Then it needs to add a bpf_sock->op check to the existing 
bpf_sock_ops_{load,store}_hdr_opt() helpers to ensure these helpers can only be 
used by the BPF_SOCK_OPS_PARSE_HDR_OPT_CB, BPF_SOCK_OPS_HDR_OPT_LEN_CB, and 
BPF_SOCK_OPS_WRITE_HDR_OPT_CB callback.

btw, how is the ack_skb used for the SCM_TSTAMP_ACK by the user space now?

