Return-Path: <bpf+bounces-12580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F917CE14D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF7F1C20DFA
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9383B296;
	Wed, 18 Oct 2023 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX0U2cBo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28127700;
	Wed, 18 Oct 2023 15:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD1C433CB;
	Wed, 18 Oct 2023 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697643318;
	bh=G5i8rgjTCdOtkBia7NJ0E9GJAWq1PZebZiERkTNe52E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dX0U2cBoWRWmcHydY9D9KSYvZpUnGeb2cpV+ocZB3ONcBjC3T4ZKs49Ew9dA+8BoC
	 Y0JPEkDF4yajF2eBhJ2V0Xt0Ymf5AVbFjbu7VEgW+wXLXOuC5GFq583ukUYgH3JqbC
	 cA2L5DP6sa+LLunVH0l3Zpyj01qBLs5QkH2MhH3ArZ0m9ZXiLJh9qrgFwVWTIO3q37
	 jhOkDnSFGhKwCNxgk+tm9i9uYhM+dyQgI63KXCo9F+zea3MBS38B69SG+xmcY2yo42
	 C5seO0cGRTia54M0QNvEF5igJu2sECklqwkMi50rOnnVSffkQlmb2ftQ/g7t3wenX7
	 hSUx4dsqOuHiw==
Date: Wed, 18 Oct 2023 08:35:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related
 API
Message-ID: <20231018083516.60f64c1a@kernel.org>
In-Reply-To: <67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
	<20231016182725.6aa5544f@kernel.org>
	<2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
	<20231017081303.769e4fbe@kernel.org>
	<67f2af29-59b8-a9e2-1c31-c9a625e4c4b3@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 19:47:16 +0800 Yunsheng Lin wrote:
> > mention it in the documentation. Plus the kdoc of the function should
> > say that this is just a thin wrapper around other page pool APIs, and
> > it's safe to mix it with other page pool APIs?  
> 
> I am not sure I understand what do 'safe' and 'mix' mean here.
> 
> For 'safe' part, I suppose you mean if there is a va accociated with
> a 'struct page' without calling some API like kmap()? For that, I suppose
> it is safe when the driver is calling page_pool API without the
> __GFP_HIGHMEM flag. Maybe we should mention that in the kdoc and give a
> warning if page_pool_*alloc_va() is called with the __GFP_HIGHMEM flag?

Sounds good. Warning wrapped in #if CONFIG_DEBUG_NET perhaps?

> For the 'mix', I suppose you mean the below:
> 1. Allocate a page with the page_pool_*alloc_va() API and free a page with
>    page_pool_free() API.
> 2. Allocate a page with the page_pool_*alloc() API and free a page with
>    page_pool_free_va() API.
> 
> For 1, it seems it is ok as some virt_to_head_page() and page_address() call
> between va and 'struct page' does not seem to change anything if we have
> enforce page_pool_*alloc_va() to be called without the __GFP_HIGHMEM flag.
> 
> For 2, If the va is returned from page_address() which the allocation API is
> called without __GFP_HIGHMEM flag. If not, the va is from kmap*()? which means
> we may be calling page_pool_free_va() before kunmap*()? Is that possible?

Right, if someone passes kmap()'ed address they are trying quite hard
to break their own driver. Technically possible but I wouldn't worry.

I just mean that in the common case of non-HIGHMEM page, calling
page_pool_free_va() with the address returned by page_address() 
is perfectly legal.

