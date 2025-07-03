Return-Path: <bpf+bounces-62284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C156FAF75A3
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1976D1C82183
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21582E11C8;
	Thu,  3 Jul 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqrVxygz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC718DB1A;
	Thu,  3 Jul 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549370; cv=none; b=BUPPfC4vL/LUrnGD4CLsOjtu/ibtTlU9P3ufGf3rhV+g07cPBbiOYvO/HAL7A+gIF0Nht2N1tZlmOWT/eWuk1KLiOjH5P/V0QlTz5aIrjTw9RqAkbn+lB4K8n+CaP4ASSnKZaavLBdK5VhIBAVrMNn0XyI/AWjcSOGDoDDu4lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549370; c=relaxed/simple;
	bh=mE7KxLntyokwKS18EvuW2I0xC9Lqd58vJ5T1ZYoF/Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6pK6MjBJ5OR6hUBglhLaDh8TJx53giCGz3kLP4UcA7dX+D34+UewuPBZFCfPmbyLdJnPVgdrfSoLQCkihoz/QMpXAZ4lvKux5T3oWpilmK3HqdV7cyeEscUQwfLQpkCHZmYg1e2mWj05i06XMfQfp88pCU32SIqYR0FdEPB8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqrVxygz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4601C4CEE3;
	Thu,  3 Jul 2025 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549369;
	bh=mE7KxLntyokwKS18EvuW2I0xC9Lqd58vJ5T1ZYoF/Gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dqrVxygzJn9L13hv02/ZfP+LcmYFGietL2GWQ3HobiiKUzzGrIC6Yp7g8wzbTCLZ7
	 Kt1D9W8NX+EFwtyCARdizDjCQk+CMRqA6xQCudmWzEwraA+IfCEIZdL8NEkPL03QlY
	 VV2QVhqYiwvadcPT7EZPqtFG5CXr2rww2zL00V9hxbq4Ca2GKILgeJ6/mABoJ7o1uC
	 9elBCeiSi0WlBfacIUn4+ztPTQTW4c3BxsFxlr5oHiphUiJBeZug+0hyC22D6mQufZ
	 2qJpGV39IgB189+jkIx9bC3yjuUDkhAidwIxn9SS1QZH2TaEJwYf1ZiuD32/IvM4OB
	 pQV9hv5gd+wgQ==
Message-ID: <27363482-efa5-49bf-94e4-6d93a662ecaa@kernel.org>
Date: Thu, 3 Jul 2025 15:29:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/5] Split netmem from struct page
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250702053256.4594-1-byungchul@sk.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250702053256.4594-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/07/2025 07.32, Byungchul Park wrote:
> Hi all,
> 
> In this version, I'm posting non-controversial patches first since there
> are pending works that should be based on this series so that those can
> be started shortly.  I will post the rest later.
> 
> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.
> 
[...]
> 
> Byungchul Park (5):
>    page_pool: rename page_pool_return_page() to page_pool_return_netmem()
>    page_pool: rename __page_pool_release_page_dma() to
>      __page_pool_release_netmem_dma()
>    page_pool: rename __page_pool_alloc_pages_slow() to
>      __page_pool_alloc_netmems_slow()
>    netmem: use _Generic to cover const casting for page_to_netmem()
>    page_pool: make page_pool_get_dma_addr() just wrap
>      page_pool_get_dma_addr_netmem()
> 
>   include/net/netmem.h            |  7 +++----
>   include/net/page_pool/helpers.h |  7 +------
>   net/core/page_pool.c            | 36 ++++++++++++++++-----------------
>   3 files changed, 22 insertions(+), 28 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

