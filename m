Return-Path: <bpf+bounces-54749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C103A716FD
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289F0189D26B
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA31E5215;
	Wed, 26 Mar 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6fWq3FU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7B1A83E6;
	Wed, 26 Mar 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993780; cv=none; b=tofPtWGO1LIKGPtqGSH2hqI/nLad1dIEHTzz2L33ZRuMQIjeivS62t8j/cDH0DTqYZkVlcONIHTk8b0NdvgcwuBTdLZK3vpYj7idUwg7CwkLTvLsWTdl3ekrPE/H2yj7xA1ZxRD85RTCjTULyBzV5jA8f0BIUfs/QlwvnXQWJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993780; c=relaxed/simple;
	bh=cO4nZNQoNa/bUZ2mza5TdYc3j78iCgeN30xv21F2Nso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJGA+rjlADYYcQ5kxoSi9zBtkBd7ehPoicauSFabkoN7JPYcHjxXkwEBClL6WABpuf+dU7Z2vCnryGHzsEgJwMYJ2ybg3nevNp+HDysHw+qIxVqnIm86Nw+5/wJFqc9F89xvZoY/pzzO8GFqTpEkqYe3D+dQyqJh1UacibFBGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6fWq3FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D06C4CEE2;
	Wed, 26 Mar 2025 12:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742993779;
	bh=cO4nZNQoNa/bUZ2mza5TdYc3j78iCgeN30xv21F2Nso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6fWq3FUgKyjvdwSr3GbZa+6/cZKlW8P4BD4O+MWeT/vCWMNA2k28M0rQ2QSzyVQA
	 ofYUH0P3RI6pv6InL7NDx5sd0z2Ox/IGtlQMa5BW2L5xE23uKthYtxBBLC0GQag9Ce
	 YhgvJybn2t8ctkzJV0ZvwSTZeNQU41W7f1EP8N/Hg/FG15M2OIDgl3seZigVQhnQSU
	 y+qGD48pUhT7nRZYcTJqjXM6HnNlZXZo0NZufKaWkcY/5ODBIEjbycIZYrB7F30C00
	 lOpPzN8/zrlp1FJuhdzVHPOchL16TrsbLLo3KnLDadVYM7N9yTGblQ9an2QLePRYt6
	 ULPePySGJydeA==
Message-ID: <072fc1a0-096a-4448-bf09-e3dc0f804b17@kernel.org>
Date: Wed, 26 Mar 2025 13:56:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] page_pool: Turn dma_sync into a
 full-width bool field
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
 <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250326-page-pool-track-dma-v3-2-8e464016e0ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/03/2025 09.18, Toke Høiland-Jørgensen wrote:
> Change the single-bit boolean for dma_sync into a full-width bool, so we
> can read it as volatile with READ_ONCE(). A subsequent patch will add
> writing with WRITE_ONCE() on teardown.
> 
> Reviewed-by: Mina Almasry<almasrymina@google.com>
> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
> ---
>   include/net/page_pool/types.h | 6 +++---
>   net/core/page_pool.c          | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

