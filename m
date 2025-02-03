Return-Path: <bpf+bounces-50330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B77A267BA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D3E3A5C6E
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA0202C46;
	Mon,  3 Feb 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UUL9ZsPt"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952B1C3BEE
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624515; cv=none; b=Ze1Lco5ymPNm4DTolEM1oM6BCOyMs9FtAXPTTY6iSxCWpmE+nq1UIxU3wtXlDBMlP28nvxNNd4K9g6Nc8Bl/giB/sAyk19Vo5taBhQAy+KNXfUzv05VEqFkgiFsJB8W/1bghguNEGeM2TvxFuqMZxu2Q+veBdWqrPD9BQrc/jBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624515; c=relaxed/simple;
	bh=Ps2PoqAxD07pYevA0h9KDZKI7xrmfxmRhIPvcx08oFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM8d4HE7/9dWc9LfnPJWjwKMZsyZb588V4jvElsTN6D62XYQbbd1z9wRr0cjcEDbK/CNKKff7xjjMJRykck3MKaTORnwO936eq3Ktq76YcsASnx1fiASBFjXppAqvewRGgEruUFJF4sPX/08gehIVNIKXLYc35ljpOReMzN73II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UUL9ZsPt; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b3e0cdf-9c2b-4423-b638-0a79b238eb93@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738624497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anNuJrUoZKOIBzp0YXKNGYgRPx+u+ceChV7XBbB+m7c=;
	b=UUL9ZsPtZ6QzoN35VpQJIHAnyDkmQOKfw06XXVU+T2u5IMW+uJKEIfUIR9szQcPOgYfU8a
	un46SK5EF9ejyG48LB/rfR4lrlb2oPfVmFHsCxwokC8G+DVZS4zGCOWAiulEkpftG17IWI
	npwmVM2A9UkVBMeVr/7st63ZfHbrziA=
Date: Mon, 3 Feb 2025 15:14:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 05/13] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-6-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> No functional changes here. I add skb_enable_app_tstamp() to test
> if the orig_skb matches the usage of application SO_TIMESTAMPING
> and skb_sw_tstamp_tx() to distinguish the software and hardware

There is no skb_sw_tstamp_tx() in the code. An outdated commit message?

> timestamp when tsflag is SCM_TSTAMP_SND.
> 
> Also, I deliberately distinguish the the software and hardware
> SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order to
> avoid such a case where hardware may go wrong and pass a NULL
> hwstamps, which is even though unlikely to happen. If it really
> happens, bpf prog will finally consider it as a software timestamp.
> It will be hardly recognized. Let's make the timestamping part
> more robust.
> 
> After this patch, I will soon add checks about bpf SO_TIMESTAMPING.

This needs to be updated also. BPF does not use the SO_TIMESTAMPING socket option.

> In this way, we can support two modes parallelly.

s/parallely/in parallel/

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h | 13 +++++++------
>   net/core/dev.c         |  2 +-
>   net/core/skbuff.c      | 32 ++++++++++++++++++++++++++++++--
>   net/ipv4/tcp_input.c   |  3 ++-
>   4 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..dfc419281cc9 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -39,6 +39,7 @@
>   #include <net/net_debug.h>
>   #include <net/dropreason-core.h>
>   #include <net/netmem.h>
> +#include <uapi/linux/errqueue.h>
>   
>   /**
>    * DOC: skb checksums
> @@ -4533,18 +4534,18 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>   
>   void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
>   		     struct skb_shared_hwtstamps *hwtstamps,
> -		     struct sock *sk, int tstype);
> +		     struct sock *sk, bool sw, int tstype);
>   
>   /**
> - * skb_tstamp_tx - queue clone of skb with send time stamps
> + * skb_tstamp_tx - queue clone of skb with send HARDWARE timestamps
>    * @orig_skb:	the original outgoing packet
>    * @hwtstamps:	hardware time stamps, may be NULL if not available
>    *
>    * If the skb has a socket associated, then this function clones the
>    * skb (thus sharing the actual data and optional structures), stores
> - * the optional hardware time stamping information (if non NULL) or
> - * generates a software time stamp (otherwise), then queues the clone

This line is removed. Does it mean no software timestamp now after this change?

> - * to the error queue of the socket.  Errors are silently ignored.
> + * the optional hardware time stamping information (if non NULL) then
> + * queues the clone to the error queue of the socket.  Errors are
> + * silently ignored.
>    */
>   void skb_tstamp_tx(struct sk_buff *orig_skb,
>   		   struct skb_shared_hwtstamps *hwtstamps);
> @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
>   {
>   	skb_clone_tx_timestamp(skb);
>   	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> -		skb_tstamp_tx(skb, NULL);
> +		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);
>   }



