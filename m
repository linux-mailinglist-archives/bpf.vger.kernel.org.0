Return-Path: <bpf+bounces-17419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1080D316
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1DA1C2142E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791C4CE15;
	Mon, 11 Dec 2023 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cysm9a7O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D53B785;
	Mon, 11 Dec 2023 17:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B0C433CA;
	Mon, 11 Dec 2023 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702314054;
	bh=Op3LbJY6uVtV2cruzQREIzqD6tOJ53Bfr8SRwtGAB04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cysm9a7O7bbkfr/ta/yL1pxWw9ibP8wg1wUwrWk+aQJF7cgO2e/htXFCWogkCuhim
	 lGItMcmzRHsGctJwgSHy8ckjUMbZco6azuTVIuVPs3seqOsVODKznbL4OdZJqe5wzW
	 2vaxcDuFz5iJHWLC+NGQboEgHsOops9aNDi0HZ1eT/W5zZ4etmicsSFUqMy2WGDKbV
	 Gz9xQIdBT+eTU90gOXQKZNe2ZZz6t1si8kE4EB2vRKOHgEl/OvA+0Lau0n2tDYrewa
	 7ksT8aEfocC0IrOeKlz2nLZRP7Fs8BkWJresYqYvWjjpFp23BEdC4oMhrCGid47nzR
	 8dBzqj72HnZGA==
Date: Mon, 11 Dec 2023 09:00:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20231211090053.21cb357d@kernel.org>
In-Reply-To: <ZXS-naeBjoVrGTY9@lore-desk>
References: <cover.1701437961.git.lorenzo@kernel.org>
	<c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
	<20231201194829.428a96da@kernel.org>
	<ZW3zvEbI6o4ydM_N@lore-desk>
	<20231204120153.0d51729a@kernel.org>
	<ZW-tX9EAnbw9a2lF@lore-desk>
	<20231205155849.49af176c@kernel.org>
	<4b9804e2-42f0-4aed-b191-2abe24390e37@kernel.org>
	<20231206080333.0aa23754@kernel.org>
	<ZXS-naeBjoVrGTY9@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Dec 2023 20:23:09 +0100 Lorenzo Bianconi wrote:
> Are we going to use these page_pools just for virtual devices (e.g. veth) or
> even for hw NICs? If we do not bound the page_pool to a netdevice I think we
> can't rely on it to DMA map/unmap the buffer, right?

Right, I don't think it's particularly useful for HW NICs.
Maybe for allocating skb heads? We could possibly kill
struct page_frag_1k and use PP page / frag instead.
But not sure how Eric would react :)

> Moreover, are we going to rework page_pool stats first? It seems a bit weird to
> have a percpu struct with a percpu pointer in it, right?

The per-CPU stuff is for recycling, IIRC. Even if PP is for a single
CPU we can still end up freeing packets which used its pages anywhere
in the system.

I don't disagree that we may end up with a lot of stats on a large
system, but seems tangential to per-cpu page pools.

