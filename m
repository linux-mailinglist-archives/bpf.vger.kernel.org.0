Return-Path: <bpf+bounces-20963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EDC845B11
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FFE1C26E6F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CF6216A;
	Thu,  1 Feb 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5mxj1b6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AD5F496;
	Thu,  1 Feb 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800514; cv=none; b=kC2/CpPbd59ghW4nE7riJsp3yZYw9UMN9wVCdVCNQIUUgIVm1DQnWMK5FV5qlN34tz8ganvb69xixDX9k/+dgKG7ILeEm+1671yLLT7zzwaySdtFc8ydtuiU9+9dFrQDRHqlXKg/bqGh94obdDIlNAZQ50xVgJJ62xfl33BkCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800514; c=relaxed/simple;
	bh=nprQoRxwLS9/ts8LNYwqRfIIySWoejWUlrRBLIkTD2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chTgWw3ka6WTqABAF1xvHauSDL7yuo1/GlzqXsYv3pC0ER4UZsU+V8Moxytuy0HimJVHuZZYgkjuVpFqgOYaZAY+Ww6vI2f2FRh+dtEsQDbO021VA6ixgczFLirJGLgajorKUBZlcSkx1JCiX+kiRXCfluMpa5ITeZhU1qVBlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5mxj1b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDE8C433F1;
	Thu,  1 Feb 2024 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706800514;
	bh=nprQoRxwLS9/ts8LNYwqRfIIySWoejWUlrRBLIkTD2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i5mxj1b6YAw2aI1sdJjGpyKVjOsbNjEnz01/5FBWRv7yCt1c0N1JwRvXh/uLiVNA+
	 jl5yXpDTBjmnFvaHFU8VabmqSIMtbyD2cZT3vljPF7E1VD4liuDkdcb+iUCiLUvCpI
	 GSpEYh4vbmm2nZY7ixoUyvsT3xg86wi8MFGI5uq08PmPY5MpwcfJK8Uo9qm0Ed3yvX
	 fXbxm1D+OMFlPA9jfH7e7sZL/RDWH5W652IKd+3aekjJUAt69g+EwygGhPbGcMeXuj
	 JqYOAe9akBQgZ12loKNgEdlj/43dXZa6qxPDtOljsKOZJ3rPSwFB72yWWcqZvHgmPX
	 Ywo5OZ1uf3TOQ==
Date: Thu, 1 Feb 2024 07:15:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 3/5] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20240201071512.0fb7c5ee@kernel.org>
In-Reply-To: <ZbuBwvCa4diMHNhk@lore-desk>
References: <cover.1706451150.git.lorenzo@kernel.org>
	<c93dce1f78bd383c117311e4d53e2766264f6759.1706451150.git.lorenzo@kernel.org>
	<20240131154740.615966a9@kernel.org>
	<ZbuBwvCa4diMHNhk@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 12:34:26 +0100 Lorenzo Bianconi wrote:
> > nit: doesn't look all that related to a netif, I'd put it in skbuff.c  
> 
> ack, fine. skb_segment_for_xdp() in this case?

I think the closest thing we have now is skb_cow_data(),
so how about skb_cow_data_pp() or skb_cow_fragged() or
skb_cow_something? :)

I'm on the fence whether we should split the XDP-ness out.
I mean the only two xdp-related things are the headroom and
check for xdp_has_frags, so we could also:

skb_cow_data_pp(struct page_pool *pool, struct sk_buff **pskb,
		unsigned int headroom)
{
	...
}

skb_cow_data_xdp(struct page_pool *pool, struct sk_buff **pskb,
		 struct bpf_prog *prog)
{
	if (!prog->aux->xdp_has_frags)
		return -EINVAL;

	return skb_cow_data_pp(pool, pskb, XDP_PACKET_HEADROOM);
}


I think it'd increase the chances of reuse. But that's speculative 
so I'll let you decide if you prefer that or to keep it simple.

