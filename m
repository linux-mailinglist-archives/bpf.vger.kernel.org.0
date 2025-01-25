Return-Path: <bpf+bounces-49729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F9A1BFEB
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C522C16833E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB879EA;
	Sat, 25 Jan 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fijuxr4w"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDAAD23
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765677; cv=none; b=eHSrsv3Y7QLA9X9vdISTYRS9ct5LFLKPq4L1vxRkdzKsUTXUCwkzI85mxDPEuPk+74h3lZQPpoqNJGZPWJNDaK7nZ+xc8eqCL8lqqh6RntOCNRa+q5cxDNGPlxs5TlP3urxB2oUvzAI88f/n4F5jWJCLUrzgKduBX4eXFcqPEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765677; c=relaxed/simple;
	bh=nFfdx73JP01H3KGCBqC6K8fG2x5lWMWYyZttPzvGtkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwRVpdWKLJb9tcuvqDYQRp2Ex72+vwgzDEd8a9SyQfXdTT3hfvs2ZYo6PrtkuY8VM0xpyK/l7WxYe4Gn9VDh/CATmecgrPyW+kfqtv4Ksfh52xToN7/m7I6SNt+7W2KgwtXZ71M1xZVHnbzXZ2TMjXfSC9zXpM41f69Xqgbf5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fijuxr4w; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46469401-173b-435f-b9d8-fc4cdb1099dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737765662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ll4pPVrErgc9NqvDMKGRXLdljEiap3qabnLbDf+VWLc=;
	b=Fijuxr4w9+UH+kd+sb4DoZhfBXwKP2m7lTJuR/RPZ4oSyI1GTj732OELzs3dWueN2aLJN0
	X/+5AWjS5Wg3ySt25MhaMDtQZjMET72mEVbspkMrnz9BLZs02BiRre3ISKkGDRVkgawlDO
	w63DANzQL/Sxw7B6bE9EAVoPgE9IOTo=
Date: Fri, 24 Jan 2025 16:40:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 07/13] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-8-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-8-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
> Support SCM_TSTAMP_SND case. Then we will get the software
> timestamp when the driver is about to send the skb. Later, I
> will support the hardware timestamp.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   include/linux/skbuff.h         |  2 +-
>   include/uapi/linux/bpf.h       |  5 +++++
>   net/core/skbuff.c              | 10 ++++++++--
>   tools/include/uapi/linux/bpf.h |  5 +++++
>   4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 35c2e864dd4b..de8d3bd311f5 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4569,7 +4569,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>   static inline void skb_tx_timestamp(struct sk_buff *skb)
>   {
>   	skb_clone_tx_timestamp(skb);
> -	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> +	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
>   		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);
>   }
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 72f93c6e45c1..a6d761f07f67 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7027,6 +7027,11 @@ enum {
>   					 * feature is on. It indicates the
>   					 * recorded timestamp.
>   					 */
> +	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
> +					 * to the nic when SO_TIMESTAMPING

Same comment on the "SO_TIMESTAMPING".


