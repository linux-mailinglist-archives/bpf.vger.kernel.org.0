Return-Path: <bpf+bounces-48996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950FA12EFB
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BDE3A2656
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7C1DC993;
	Wed, 15 Jan 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OWZ/nNNG"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C1DB14C
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982314; cv=none; b=SMEilpq+MTuzbffc+pWF6ZhMZAQ1K5iMz+ZaC9+r4eWRikIDG1eM4+iKlqbRpmWv1uO3kgwUWsk8Az5/8AWjwgznN3VLNmAQtvcra+zo0bD7fsA+lSXsQebZX4BHwJt7RwPAEY1R/kUgKGi4cVSoe3sEwyFafyg4hBsojqbiLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982314; c=relaxed/simple;
	bh=HUdO7vlvd899MLYXzdaT6gUFALBVN6c00vFvFFw78qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLdosFbQCH8f+QW9TP9ePM07fAayTIZwH6N8MsX9yfDjJC9YBhZHUJWn0J9F+h7AlbFp8qzKZ7vF5u07H4n14qhqHgqO5mFstnlyMWouXYA7UddO3fD2RG/M4zuKAzsgy5PtBTDto3XWyLkxDUU1v+uSlMuhFZbR4nJjlwPKk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OWZ/nNNG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b9b9206-86ce-4d03-86b4-82f378fd0dc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736982310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5dx+EpNp6mUzqgimPYNjpBDGqen8m2WFmZqRdq6DIE=;
	b=OWZ/nNNGpf28CLnhZVCRxsw0nF0okbyqCSJR4xKrX3RTWVlKKd73xc0Jx0g+eB7GKN/P16
	abjt7TR3RMzv1qQNw+u7ae5bS55BvRMeSHx+M4sf7HI+hYk2GFoYkSQQolcNCQJTRddntF
	ovW887E9I7wu8tSuIvqj9nAVwIDZ8nM=
Date: Wed, 15 Jan 2025 15:05:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 11/15] net-timestamp: support export skb to
 the userspace
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-12-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> People can follow these three steps as below to fetch the shared info
> from the exported skb in the bpf prog:
> 1. skops_kern = bpf_cast_to_kern_ctx(skops);
> 2. skb = skops_kern->skb;
> 3. shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
> 
> It's worth to highlight we will be able to fetch the hwstamp, tskey
> and more key information extracted from the skb.
> 
> More details can be seen in the last selftest patch of the series.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/sock.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index dbb9326ae9d1..2f54e60a50d4 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
>   	if (sk_is_tcp(sk) && sk_fullsock(sk))
>   		sock_ops.is_fullsock = 1;
>   	sock_ops.sk = sk;
> +	bpf_skops_init_skb(&sock_ops, skb, 0);

nit. This change can fold into patch 1.

>   	sock_ops.timestamp_used = 1;
>   	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>   }


