Return-Path: <bpf+bounces-54748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02594A716FA
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E03189A3A3
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57571E51EC;
	Wed, 26 Mar 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THU3o0rI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE861B3950;
	Wed, 26 Mar 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993727; cv=none; b=HTinBjZPjyAWpgzplcV8XlhLopbjLjMG/i7Dc5ClYlKglxuqUKXp45TReUXmVjtfb5tCn7TAzg9XcS0q/htV3UNylS4WNbC20MCWOpN61vaUDY9rqb/sbiAXQHvEgQaGeriyc2ykXaIoQTzbUl/VLgwBt+XqYItE98D5aOstBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993727; c=relaxed/simple;
	bh=A0tYgISPZr3nBdVXsqT8eCy/AZW3HgsAo/r/eYIdF7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNgerwSkLrHqeEL/eQH5sz7Rn4qb6SPO1MtPKUC7JP66efacFfWpm/cycs8DQTCFaefFIDkyYgb9hod+vZ0YX0UefDuDe1UMWGQHlY+FV8XRu+LAjlYhxk7l33GsEjuCmIaZq979AGleDJ9Bi5uGVUiITt/SOtLW/t/MZyTla2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THU3o0rI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A1C4CEE2;
	Wed, 26 Mar 2025 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742993726;
	bh=A0tYgISPZr3nBdVXsqT8eCy/AZW3HgsAo/r/eYIdF7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THU3o0rIbjwHT9PJTSFjAw+msHz6bBCCCWbSbkZbzCpyNHz3DNnBQD3RJaYmZy4At
	 diYGAQbunY5Z6PzvcefCNBo/l6d+Ji0PT5bdZLTGQLPCfjLHCOQoLCsnXJjwuuVho6
	 gJEfgcLRetMnMGFe7ylOaz7C//gvUljt2JlrwxJg0W+VXESsrm8bGvVEV3O93lNZws
	 XMDmwzOrXpuwM/uc0QRQ6RshQzXOIcxhWzXpRE0ynrjWXkysxrPtZQWeGFtR77RDfO
	 SQjWlEUg4s+/XITtoFn8JgwxAPNsNdTFxgpQMvqkULaySHr5d/TLSyTKe75/lY4ry8
	 WDvFHwE177O0w==
Message-ID: <c91a9571-7893-4f9c-923b-f9d85fa4796f@kernel.org>
Date: Wed, 26 Mar 2025 13:55:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] page_pool: Move pp_magic check into
 helper functions
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326-page-pool-track-dma-v3-1-8e464016e0ac@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250326-page-pool-track-dma-v3-1-8e464016e0ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/03/2025 09.18, Toke Høiland-Jørgensen wrote:
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
> 
> Reviewed-by: Mina Almasry<almasrymina@google.com>
> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>   include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>   mm/page_alloc.c                                  |  9 +++------
>   net/core/netmem_priv.h                           |  5 +++++
>   net/core/skbuff.c                                | 16 ++--------------
>   net/core/xdp.c                                   |  4 ++--
>   6 files changed, 32 insertions(+), 24 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

