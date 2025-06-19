Return-Path: <bpf+bounces-61087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB704AE09DC
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BDA179583
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970C28C5B1;
	Thu, 19 Jun 2025 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIxPYLQq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9587494;
	Thu, 19 Jun 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345746; cv=none; b=Y5jmhYS/9dimMXwc2iQRZMLukjU1QPeaEIy39V31UXO2DPmWLFcVmvbk7qXGacV3eAo+b5zdP3qU1GOZI5AaX42FVriiR10FF48mDYcBXuCij5stiGwttDwxXP1evGwV6gJFLLpVXeZELiENfi9A7jRj/5TUHaHhkv3LshBGrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345746; c=relaxed/simple;
	bh=0CL1Z+OfZHqKzBgIZXUGehFGRPGbCXxgysN3GeqYBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJEp2xbY8siMwKa+VUqPoQ+b4tHYD8xPKeyamKKFkLNELfTofYDM2ya5KlJG1+hQm5kdKSCkxeusj46Rac1nlppjw9tEzlwH0GmBzXDGcPmiaPc4Y5ny8Spp/b6tTnWNRXN0Q63J6KAuEjOKCDCiY7qL55gS9kyIrAxhgwm5Sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIxPYLQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D59C4CEEA;
	Thu, 19 Jun 2025 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750345746;
	bh=0CL1Z+OfZHqKzBgIZXUGehFGRPGbCXxgysN3GeqYBwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIxPYLQqQRi2LEP1eIp+IV7e49SS5nJonA15ARRP2UVf1x+UHpKBWIA54Siz9jQYi
	 yDFRxQR6dFoAACDbrG0RzDBxRROsA5MQjMDI7LMuu8tID+mkgzltl/ToWODYAu7yq/
	 +CgilN0hh9WygaZS6v3QAXLW3WdpaiU0YI25eoyXFZdAiquCfJefXPKFk0ntUqTwlP
	 KcNGR1tjBKOJYJHvKsBXafe1Fvg9eQ/m0nB20xkqY6EaSkso35dtt3OFI49g2Wwj1w
	 Ll2oPP2gsDjiSpliLRlQfQIHrOwCUMX3DQT/+rIGwAqXyhIlzRZi2gYRnqFkKqiV3y
	 HOKCGTrxYzHQQ==
Date: Thu, 19 Jun 2025 08:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <20250619080904.0a70574c@kernel.org>
In-Reply-To: <20250619090440.65509-1-kerneljasonxing@gmail.com>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
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
> @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  static int __xsk_generic_xmit(struct sock *sk)
>  {
>  	struct xdp_sock *xs = xdp_sk(sk);
> -	u32 max_batch = TX_BATCH_SIZE;
> +	u32 max_budget = READ_ONCE(xs->max_tx_budget);

Hm, maybe a question to Stan / Willem & other XSK experts but are these
two max values / code paths really related? Question 2 -- is generic
XSK a legit optimization target, legit enough to add uAPI?

Jason, I think some additions to Documentation/ and quantification of
the benefits would be needed as well.
-- 
pw-bot: cr

