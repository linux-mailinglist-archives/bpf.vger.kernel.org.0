Return-Path: <bpf+bounces-62283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA9AF7592
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40085189F7E4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3D42E2EE0;
	Thu,  3 Jul 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCmmqMiS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286FC148;
	Thu,  3 Jul 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549247; cv=none; b=UwD+4dz+hnFQkVz/1qG+dtDy/Li4FiZztbzDLrMAXOtIsb72JoxgIM9evl2VN9g+pLcdZix/8GCwN09EwTvQLhSKiy849sLZB1tn6q0Se2mVdXGlEhUk3ATZxDTK2LN6pI8ECQqerGQ2ZN9Zg41Q8IZrWXXArt+2869vTiF4Rqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549247; c=relaxed/simple;
	bh=02Jt1Cymbs57OvvyqASB9yCoi82LcJgdykJmqeCnv8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMkGZ4bLIybJdAc/rE7cFAOt1+viRYOvjhsZHVerbkf+0kBR4epz2h2HHE1i4xdb7LsWN9PJKBP3jioP9NXyByroOREV8SW1YLPqcI1PTrJjwcGbUEX5czJNGkNplOO1+SXsHc3bYYczv0SZ3GW3jZM3qiCalPD9ZlTFxmal0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCmmqMiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7ECC4CEE3;
	Thu,  3 Jul 2025 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549246;
	bh=02Jt1Cymbs57OvvyqASB9yCoi82LcJgdykJmqeCnv8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCmmqMiSMdW95nEPe1HJViQllZgFpmCY4isMnJBc6miFP3aSlDhfQg5wjWCPHBjUO
	 jHIeWhmx8m/x5oTMYwK0pov1zIDGKIMVDEnEtNxEXKtts1KZ2e+bU816zmaE07OmaY
	 vsGJqNigVBrmny+x/6apIvX4eGvR6RjhALEZ6hvMDFB4gVoeUWGD3HDIDGVEkoDAC0
	 Fg1ZBJkg7bp+v9NK8JyV2aTfdU6REn1Ex58+/5nr3A6gL2RPe1L6saJxdppQTUV8LE
	 qk0RP9lsJzodZ4eLLvskzTzyRiXaqlBfL/8EMYRLQDZ2cgzGfZLwYoSk4cD4S5ia8M
	 dKDsCjqTRS9qQ==
Message-ID: <720df841-8300-490a-af77-8d20f833c042@kernel.org>
Date: Thu, 3 Jul 2025 15:27:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 5/5] page_pool: make page_pool_get_dma_addr()
 just wrap page_pool_get_dma_addr_netmem()
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
 <20250702053256.4594-6-byungchul@sk.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250702053256.4594-6-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/07/2025 07.32, Byungchul Park wrote:
> The page pool members in struct page cannot be removed unless it's not
> allowed to access any of them via struct page.
> 
> Do not access 'page->dma_addr' directly in page_pool_get_dma_addr() but
> just wrap page_pool_get_dma_addr_netmem() safely.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>   include/net/page_pool/helpers.h | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 773fc65780b5..db180626be06 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -444,12 +444,7 @@ static inline dma_addr_t page_pool_get_dma_addr_netmem(netmem_ref netmem)
>    */
>   static inline dma_addr_t page_pool_get_dma_addr(const struct page *page)
>   {
> -	dma_addr_t ret = page->dma_addr;
> -
> -	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
> -		ret <<= PAGE_SHIFT;
> -
> -	return ret;
> +	return page_pool_get_dma_addr_netmem(page_to_netmem(page));

Wow - the amount of type casting shenanigans going on here make the code
hard to follow.

This code changes adds an extra "AND" operation, but we don't have a
micro-benchmark that tests the performance of a DMA enabled page_pool,
so I cannot tell if this add any overhead.  My experience tells me that
this extra AND-operation will not be measurable.

I see a lot of reviewed-by from people I trust, so you also get my 
page_pool maintainer ack.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper

