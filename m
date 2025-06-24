Return-Path: <bpf+bounces-61462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B446AE7342
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1A7170C4E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0F726E71F;
	Tue, 24 Jun 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWDqrtPJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8E26B2AE;
	Tue, 24 Jun 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807876; cv=none; b=Vk8pkIVxP4tDNcOT7gyj8kK3+pPCYXMjN9HDTWqU/wCz/J5CwTSbPYo6eAK2qKmoyw7AUqJ/j9gDzIw8LQczJ96C6bOFTuEvMRe42OcnX3Ot8ERAxfckmXaqthWSwjTFfvgmHijzyHNZnUVb3/0MHHlUDcHRsWbzXy1IwAUOr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807876; c=relaxed/simple;
	bh=VlBs7o7mBF7VcdvN1sBvor007d7BqlY6Pz6in6IqgJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ//qzWWXz59ElMAzfsnLEZIMdW9KVjWWrtgES5/xon7IED3hIAAHXRb24P6M/MITS6EqxdmrDk4mpkd3VrHa1CD1Ae+3Wy+d17GGh8AxfSLTrTNhOJvjSjmFXs0ehJv8DAWWsq0yRt/1UVP8gLoBXcQXEJHhi4slHwMfSIdeOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWDqrtPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33706C4CEE3;
	Tue, 24 Jun 2025 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750807876;
	bh=VlBs7o7mBF7VcdvN1sBvor007d7BqlY6Pz6in6IqgJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NWDqrtPJn0fgSFxbSHTURM8GuH2RixHQydw6tnz9DE5zJIpk+qzoGzWdzl7zKf4En
	 N0VIO02dYWHHh89/ekgv3PQiwiS1+ALgSeVg+sgSOpieFJBugrOQU2BDZTSLBafQsy
	 LUu8+vRGLS5qAOXDqet5/RBYswb8EM1sKZX2eClEwFZdYvF0Uw1GCDhVfhlyIimnRV
	 pGkQAXfQxPMuMgzWECcwMNCg62JHb0MFZFwKn+eId6C+7+LqLnzWQGH4fQSdjeoV1J
	 3WFB4bQ7ucdZItdoeIrjCzM41vwYQ1Bg4PvP90PXBXbwYRy8TheHb57kmX85XPy6WJ
	 /YUH4eU/gAFKw==
Date: Tue, 24 Jun 2025 16:31:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4] net: xsk: introduce XDP_MAX_TX_BUDGET
 setsockopt
Message-ID: <20250624163114.712a9c43@kernel.org>
In-Reply-To: <20250623021345.69211-1-kerneljasonxing@gmail.com>
References: <20250623021345.69211-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 10:13:45 +0800 Jason Xing wrote:
> @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
>  	rcu_read_lock();
>  again:
>  	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> -		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> +		int max_budget = READ_ONCE(xs->max_tx_budget);
> +
> +		if (xs->tx_budget_spent >= max_budget) {
>  			budget_exhausted = true;
>  			continue;
>  		}

I still think you're mixing two very different things. In the generic
xmit path the value you're changing is a budget. But xsk_tx_peek_desc()
*does not* exit after the "per socket budget" gets spent. The per
socket budget only controls how many frames we pick from a single sock
before we move to the next. But if we run out of budget on all sockets
we give every socket a full budget again and start from the first one
again.

For the ZC case the true budget is set by the driver's NAPI loop.
-- 
pw-bot: cr

