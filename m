Return-Path: <bpf+bounces-50469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0AAA28172
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 02:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A260161DF0
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DED20D50A;
	Wed,  5 Feb 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBGjaaVB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739A2F46;
	Wed,  5 Feb 2025 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738720073; cv=none; b=WfNDXnJrWOCiMulFTxAX09m47k7YIdwLd7FIvvkO6O+X63h1oS2emqwtZ34It6osoYuG9ds743CCqKd8sGSzCaPg9cQv0n04+n382KV4GJ0FEYEH6AEZu2HZcolxu1DNpVoOVBF+DutJVRaWmKZ3UKg6ZphH8wz7XnqHkmSUyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738720073; c=relaxed/simple;
	bh=sQNntZmPlE5eczbwEhfWiX791Y+vEY2Rp/yPUKQAZEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qil0qy0I4goagtuWNUoiZOQlPBSWIXhOAl6UmbyNFPuE3b98wDASCH/sZziIYmq+3KyGhrlH6gQJJVCEZqLpTJjk3qe76HKq6WuYerS2pFYMpbjw67sDZaGFrV7nizUtDLbrjt9I+ztxUz95UAdaMxkQe7thaaXnnAAaGluA6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBGjaaVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE42BC4CEDF;
	Wed,  5 Feb 2025 01:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738720073;
	bh=sQNntZmPlE5eczbwEhfWiX791Y+vEY2Rp/yPUKQAZEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VBGjaaVBlGuIjG2nfxr6AbfuXmkFupzb3vZF6U8zPbC0hau8PaZqbMeAMTR1ptwdg
	 F59rTHD9loCCc1ytUr6b8yTHCKgODFUqUEg7fJ/ok4AAUuYuj8HgFz4emT2B6HQeDe
	 xUqGPb43VGNJDb4xwetP4KVtkUSCl/3iw0K69VY/7SP0uVWt1ihmw30PWhMcz3JmLB
	 d5fOLEh6HJ9sFdUS9poAvEdkfnzdV9OH/suoTHaT0Lq4/3wXAwerFPiWMkAUAtVXck
	 xl9Fvy/K+knW2Yo8MMxeBvXYLJJ5QOo9DQzyZwihOow6zbXpuPPL9dV+X/Cae+FLQU
	 XLfL5Vbm/Y7vg==
Date: Tue, 4 Feb 2025 17:47:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
Message-ID: <20250204174750.677e3520@kernel.org>
In-Reply-To: <20250204183024.87508-6-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
	<20250204183024.87508-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 02:30:17 +0800 Jason Xing wrote:
> @@ -4565,7 +4566,7 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
>  {
>  	skb_clone_tx_timestamp(skb);
>  	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> -		skb_tstamp_tx(skb, NULL);
> +		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAMP_SND);
>  }

Please move skb_tx_timestamp() to net/core/timestamping.c
You can make skb_clone_tx_timestamp() static, this is its only caller.
This way on balance we won't be adding any non-inlined calls,
and we don't have to drag the linux/errqueue.h include into skbuff.h

