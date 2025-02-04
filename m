Return-Path: <bpf+bounces-50348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D877A26938
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D103416596F
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3A78F26;
	Tue,  4 Feb 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYGdoEFj"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7925A65F
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631004; cv=none; b=k4SsjgjM6KtYT9VhDFqnShDcsjJ1xS8wc0nMQrTJoHVxKtylm8xPQvWABr+90wUMi1D4jtg4qah9IG5M7HTajkvmuz7ln3vxq9EJ/C1UEpOA6n5wJwYdSLGS/+62M41Dbvd8FhE6TqOXvs/++vJXJBsZXksnxPPELbmYfKbZ03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631004; c=relaxed/simple;
	bh=7yQUjQoVexRjYJWwKdqKHHiilZU11W/7FR+QI2I/iW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjtgzgWSkOBFqga1465noROdc3MBIbPutxZC+CkuXZwvyJAk1miD4UN1PPklQsg1pPT1TOYd5RsnOcLOzKDWGC9p5vLhoFFWaOJK2YgCFc0NKEDGn6fwOdoFRWYbgzzR9xW/ivVjlVYJMocLPcft+HQrH3iEuTdGOn50/2+aLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYGdoEFj; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7364435-caaa-481a-9fee-83e5c915ed07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738630995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp8vbghPNmcoOuG7PepNlble5c24Dv005MiJmyYuFKo=;
	b=CYGdoEFjkdCT4YkstkNCW6SPHcJbQsQWgxycUgrJ4g8u/WqpehaYH+0n3YKeIUX9MqoHfe
	uDc466rYONypVZilNcFxiqLtPZ1cnA7R+q5WddqcKiCjtt1Q+X9pL7+GMC/qokuXP2C5d6
	bmNIQg9w/5X/SiORFKNquZI/Qxho7v8=
Date: Mon, 3 Feb 2025 17:03:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 10/13] net-timestamp: make TCP tx timestamp
 bpf extension work
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-11-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-11-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> Make partial of the feature work finally. After this, user can

If it is "partial"-ly done, what is still missing?

My understanding is after this patch, the BPF program can fully support the TX 
timestamping in TCP.

> fully use the bpf prog to trace the tx path for TCP type.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/ipv4/tcp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..0a41006b10d1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -492,6 +492,15 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>   		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
>   			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>   	}
> +
> +	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> +		struct skb_shared_info *shinfo = skb_shinfo(skb);
> +		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
> +
> +		tcb->txstamp_ack_bpf = 1;
> +		shinfo->tx_flags |= SKBTX_BPF;
> +		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> +	}
>   }
>   
>   static bool tcp_stream_is_readable(struct sock *sk, int target)


