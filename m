Return-Path: <bpf+bounces-64939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A4B1894F
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEEB5A1059
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37023817F;
	Fri,  1 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj4UyGcG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647671E0B91;
	Fri,  1 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754089688; cv=none; b=W26j3VOoXRZNQbyHyeHo8ho2+ybvJPO1xEPc0d+mVUUB8twmTT6c6WJb6SGnuWALM6Ca1cm5C0nfkQ8qvkWB8Uf39vARoxZbzEli7b12XuhwoTeIPV4VrJrJh4nOpB6UBkApDLDBwbj7WO+4k8tQOU1jryg2hmSCHo17Zd6N3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754089688; c=relaxed/simple;
	bh=6pOY9vWaKIl9etre7R8PY0gT1B9BcwDb9n4CCJLLzNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjiqAc4Mh7nA1t9n7kmRCqWvR8PxqeGN5+Y1/5iKJJPiP3o++JP3//i8bTsfEdjw/+YcGZoUIHZPysCBu05uehKyt/rqiZXo3IxTmwmucifIQV/52J80stHCabq3KQiKJSHmxnBDmKH2GCzy3DL9G6xMbwqARWooETYiabCmbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj4UyGcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96870C4CEE7;
	Fri,  1 Aug 2025 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754089687;
	bh=6pOY9vWaKIl9etre7R8PY0gT1B9BcwDb9n4CCJLLzNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dj4UyGcGbuIkBc98+22HPLqigl8NgNkMOdvw1zAqKlBQbRiiBxUzvRfWrVyzOtC6D
	 cjuiqHDMdxYBp16KLznBJPAhgVMiEnno49wryNNiuQ5AIayb0Lzi/MAMXBDmJHtduV
	 atkxVrhkNH6oExT6DhZwgH4YEXVh0epCd6rbjc37Rud5naxpUDu9/SX15b0QuZeA2G
	 Go7Lyxio35OeHyJsgXdE/F2mkL3LAAOw5HayQ4Me9AMRRIbkXeJ9elEBJHllp+5v7C
	 4RpA+plFtMLbsK5xWsInIJVj3hWYYCznrcH0gHUz+H3oxe5ida+og57qZTFXSnj0Nh
	 B4pJak/XeYcjw==
Date: Fri, 1 Aug 2025 16:08:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
Message-ID: <20250801160805.28fa1e05@kernel.org>
In-Reply-To: <20250729110210.48313-1-byungchul@sk.com>
References: <20250729110210.48313-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 20:02:10 +0900 Byungchul Park wrote:
> [PATCH linux-next v3] mm, page_pool: introduce a new page type for page pool in page type

linux-next does not accept patches. This has to go either via networking or MM.

> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {

Maybe add :

		/* networking expects to clear its page type before releasing */

> +		WARN_ON_ONCE(PageNetpp(page));
>  		/* Reset the page_type (which overlays _mapcount) */
>  		page->page_type = UINT_MAX;
> +	}

>  static inline bool netmem_is_pp(netmem_ref netmem)
>  {
> -	return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> +	/* Use ->pp for net_iov to identify if it's pp, 

Please try to use precise language, this code is confusing as is.
net_iov may _belong_ to a page pool.

	* which requires that non-pp net_iov should have ->pp NULL'd.

I don't think this adds any information.

> +	 */
> +	if (netmem_is_net_iov(netmem))
> +		return !!__netmem_clear_lsb(netmem)->pp;
> +
> +	/* For system memory, page type bit in struct page can be used

"page type bit" -> "page type", it's not a bit.

> +	 * to identify if it's pp.

... to identify pages which belong to a page pool.

> +	 */
> +	return PageNetpp(__netmem_to_page(netmem));
>  }
>  
>  static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 05e2e22a8f7c..37eeab76c41c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -654,7 +654,6 @@ s32 page_pool_inflight(const struct page_pool *pool, bool strict)
>  void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  {
>  	netmem_set_pp(netmem, pool);
> -	netmem_or_pp_magic(netmem, PP_SIGNATURE);
>  
>  	/* Ensuring all pages have been split into one fragment initially:
>  	 * page_pool_set_pp_info() is only called once for every page when it
> @@ -665,12 +664,19 @@ void page_pool_set_pp_info(struct page_pool *pool, netmem_ref netmem)
>  	page_pool_fragment_netmem(netmem, 1);
>  	if (pool->has_init_callback)
>  		pool->slow.init_callback(netmem, pool->slow.init_arg);
> +
> +	/* If it's page-backed */

Please don't add obvious comments.

> +	if (!netmem_is_net_iov(netmem))
> +		__SetPageNetpp(__netmem_to_page(netmem));

