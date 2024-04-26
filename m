Return-Path: <bpf+bounces-27999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615558B42E0
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921DF1C2275E
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6753D576;
	Fri, 26 Apr 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lDVxE0l6"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E33BBC5
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175768; cv=none; b=dtbo3IwG5yUd+I98sbxk5MNf6K8dhhlVb28ysluIb3dDQgoQUKSfcMyIvDbs8JDh4ppdfLxMNp1cpJMxPmP4wGuNFiJqlBHFXutN3TbJahE/YQEdVxql1GMZYsKl15AUGCrbvQCygdaJbf0kHFcCwC7YaFWKeyrXO7SRB4YA4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175768; c=relaxed/simple;
	bh=h35Bs0TjvjT5HMdqr6jDsiFes2b5MmRn8YsZIluWb3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoU5OLrFFLIuiMLzAhS5bPJWa3eyE8XesTzjh0xOPXbcGw0R4iwtQuZTrmbIR7rpqpURr6yl/a06urQAClwSv7GgEGNp35Z9bPXKvrCRp4Yjd2sZN2u6EnE/kppmzeAFOVuxDQP4eaOC5PeWAX/iTTtn2Dcaz8fUY+YoLTE5qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lDVxE0l6; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c20eb574-22f4-49f8-a213-5ff57eb6222e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714175763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WB70c0JO1javGJ5ouAAz9GvqmsyBQq5+3gEbrQGxvU=;
	b=lDVxE0l6gvF77tXSsj8hn5zx/V5zIfVbKZonEfyXmEcYVJHUUzs8tEVwYI7ADjFx5zpo8S
	Ypjefc5ycidSx6N/Y13j8YDZ5++SaTTQkH901geqh/GaTgMG19SQAfEcgcQRyFjNC0KuNz
	npYdiOPSY6K7kFECeqZbshwnXlD+Q0s=
Date: Fri, 26 Apr 2024 16:55:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
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
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240424222028.1080134-3-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 3:20 PM, Abhishek Chauhan wrote:
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a9e819115622..63e4cc30d18d 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -955,7 +955,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>   			if (iter.frag)
>   				ip6_fraglist_prepare(skb, &iter);
>   
> -			skb_set_delivery_time(skb, tstamp, tstamp_type);
> +			skb_set_tstamp_type_frm_clkid(skb, tstamp, tstamp_type);
>   			err = output(net, sk, skb);
>   			if (!err)
>   				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
> @@ -1016,7 +1016,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>   		/*
>   		 *	Put this fragment into the sending queue.
>   		 */
> -		skb_set_delivery_time(frag, tstamp, tstamp_type);
> +		skb_set_tstamp_type_frm_clkid(frag, tstamp, tstamp_type);
>   		err = output(net, sk, frag);
>   		if (err)
>   			goto fail;

When replying another thread and looking closer at the ip6 changes, these two 
line changes should not be needed.

