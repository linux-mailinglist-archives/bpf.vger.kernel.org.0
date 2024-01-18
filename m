Return-Path: <bpf+bounces-19772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B7831103
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DC21C21E72
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC020FB;
	Thu, 18 Jan 2024 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddGWVc+V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2A468B;
	Thu, 18 Jan 2024 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542445; cv=none; b=Iimxnv2R9fF+lWoRXpMw5DH/csUUfew1Ciy3Zja/9m64ZQRErVjcJWAVACPPdJxR/ZKfWcgJPmXeX5kdDqkideIfVpmO0b+0339bfOzXpFUCwv31oKDEOUwQFdeh4GmQo8PXv+HyTaQjQvoOYIZliMNTbZXuv19hu7DQSKDZX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542445; c=relaxed/simple;
	bh=33T7F3OWpG7lRO/zf2SE9qBBPrsEK0Gr/BxHrVzjXh8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=qRjDZQhkv9Cr7WRx3tb41kv3cKvbeRxDI+5HIW3B/bTUaaSMXrqQt5pnItxvfHxg+hDS6UNfzyV8fbgTHBey2rVoUZ0tNZ+Xgzc+1WWIKbrnuwxRTWKCVtodb8iiZo6ylUV+f6Go7R+mwKxeHAh3iNQdHEYzOyPAYGX5oW0Zl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddGWVc+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011EAC433F1;
	Thu, 18 Jan 2024 01:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705542444;
	bh=33T7F3OWpG7lRO/zf2SE9qBBPrsEK0Gr/BxHrVzjXh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ddGWVc+VRN9tOk7sMobkajDtFnFY6mLk9CXL2ytMVFmCJkIqK7KwedG0A+0TtQTs+
	 R46IulHeVC6xXJnNICLSg8je/QUv4zGSYpDpYdas637epx5Abdgy6nMvwobJ20ypQi
	 JSrCJ3Ci28HmzWhtemAgz7S9Yq3A4Ld+d+amB/6sGgTYCGph/80z9jd6sALDC5dLM1
	 2yDTQWjQbVvn7ioU/V5RbnefT+e+lLOTWVKrGEIWqJPxtf0vtCrX4yhSkiTbMTfg3l
	 2SqVC681yzBQQU2FU3zf062senr4Hhjay2o7f8vEuGfo75guJfvSX16UQpM4UmpE/5
	 kPZc6CqqR+iGQ==
Date: Wed, 17 Jan 2024 17:47:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 willemdebruijn.kernel@gmail.com, toke@redhat.com, davem@davemloft.net,
 edumazet@google.com, bpf@vger.kernel.org, lorenzo.bianconi@redhat.com,
 sdf@google.com, jasowang@redhat.com
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <20240117174722.521c9fdf@kernel.org>
In-Reply-To: <ZagQGZ5CM3vEH2RP@lore-desk>
References: <cover.1702563810.git.lorenzo@kernel.org>
	<b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
	<c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
	<33bbb170-afdd-477f-9296-a9cede9bc2f2@kernel.org>
	<ZagQGZ5CM3vEH2RP@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 18:36:25 +0100 Lorenzo Bianconi wrote:
> I would resume this activity and it seems to me there is no a clear direction
> about where we should add the page_pool (in a per_cpu pointer or in
> netdev_rx_queue struct) or if we can rely on page_frag_cache instead.
> 
> @Jakub: what do you think? Should we add a page_pool in a per_cpu pointer?

Let's try to summarize. We want skb reallocation without linearization
for XDP generic. We need some fast-ish way to get pages for the payload.

First, options for placing the allocator:
 - struct netdev_rx_queue
 - per-CPU

IMO per-CPU has better scaling properties - you're less likely to
increase the CPU count to infinity than spawn extra netdev queues.

The second question is:
 - page_frag_cache
 - page_pool

I like the page pool because we have an increasing amount of infra for
it, and page pool is already used in veth, which we can hopefully also
de-duplicate if we have a per-CPU one, one day. But I do agree that
it's not a perfect fit.

To answer Jesper's questions:
 ad1. cache size - we can lower the cache to match page_frag_cache, 
      so I think 8 entries? page frag cache can give us bigger frags 
      and therefore lower frag count, so that's a minus for using 
      page pool
 ad2. nl API - we can extend netlink to dump unbound page pools fairly
      easily, I didn't want to do it without a clear use case, but I
      don't think there are any blockers
 ad3. locking - a bit independent of allocator but fair point, we assume
      XDP generic or Rx path for now, so sirq context / bh locked out
 ad4. right, well, right, IDK what real workloads need, and whether 
      XDP generic should be optimized at all.. I personally lean
      towards "no"
 
Sorry if I haven't helped much to clarify the direction :)
I have no strong preference on question #2, I would prefer to not add
per-queue state for something that's in no way tied to the device
(question #1 -> per-CPU). 

You did good perf analysis of the options, could you share it here
again?

