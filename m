Return-Path: <bpf+bounces-56040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA37FA9047A
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228E43B3BFB
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725651B4223;
	Wed, 16 Apr 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYbIniVf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1EB1B042F;
	Wed, 16 Apr 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810695; cv=none; b=h+T6ePbkPiJZe+bJJ6BCBuwGtrsIWMlKUMKr5hmZsCEpkuOFD4wuxFoLqDqJ82HB1SjaFnfSKCGDZhw4bgk2EC0ZScP38WrX8M3dr/GQKP28DfxyoikyZ7yY44F91ZmLEsL/ZkcZiuI5jFt/JZVnxV0m2BkYB9UQWBpjZHGIqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810695; c=relaxed/simple;
	bh=sdNLl1W288uG9ZDxKVKiy23P3vv4qT3wAIUV4yV8D9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3591700hzFcR7ngWob6ZiQp8eMHdbNB3nwJ2QD5ZSIfpQhmVSmKkXgnmhQGXny8Vy6Q6aGWBuX96sUY10Ul7RLDtQJ2CMcX7DBHVJ0PDAnw1t5MMlI5VFEl/+Yr6HvmwNvDO620yH005UceYML3zM/9uUkntkSxHvQM+rnK5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYbIniVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C543C4CEE2;
	Wed, 16 Apr 2025 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744810694;
	bh=sdNLl1W288uG9ZDxKVKiy23P3vv4qT3wAIUV4yV8D9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TYbIniVfq32iDZScm88zQcbKRZ86XQ2Ol37pjImGDFMBZdm6xPxj7IUCknV5BNyz9
	 Ohz/V4EhD9WKM49WTQO4uYu1cSXEp8SDe7+mG/pPLwkpSxakZJ2hz3BR+L3J6qXJ8l
	 pqBjaEIWx9OKMgPMLurd+oDcwzYc7hF++S8tZwMj3qGJyC2+uM+VZws0nJ4w5KhJA9
	 h3qTVreui67i9P/ADSZ9xJ5AerpRDvlcGB5WjDMiT0Z4cJJ3+AF33+836kDl/MAjpv
	 v7NhY/yThNhc1d/VOZi+BnLx+GBx32OiU9EzegiiWeatP4TuTGSGSeWVn/RFDzXi3i
	 6Yvor/ydo3BjA==
Date: Wed, 16 Apr 2025 06:38:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?= <toke@toke.dk>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Message-ID: <20250416063813.75fb83dc@kernel.org>
In-Reply-To: <174472470529.274639.17026526070544068280.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
	<174472470529.274639.17026526070544068280.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 15:45:05 +0200 Jesper Dangaard Brouer wrote:
> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.

It splats:

[ 5319.025772][ C1] dump_stack_lvl (lib/dump_stack.c:123) 
[ 5319.025786][ C1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6866) 
[ 5319.025797][ C1] veth_xdp_rcv (drivers/net/veth.c:907 (discriminator 9)) 
[ 5319.025850][ C1] veth_poll (drivers/net/veth.c:977) 
-- 
pw-bot: cr

