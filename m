Return-Path: <bpf+bounces-59050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2519AC5EEF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409339E47D0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228791BC9F4;
	Wed, 28 May 2025 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3GfrO64"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659558210;
	Wed, 28 May 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748397471; cv=none; b=tRe/IuIijd80aBbBLKNTW6GfPwynVWO9cgcH7e9JoC8jEJ/V828imHGIN3EtslMnETp2f/haBBjfGLXyAyhqhqzPXpYEreBt+TRmhME5WnmSsssy/x9zNcO3zr1TWjt8xwrf91freF73ryX7I+FBem0AiVJZuoRkm/7clU7ap7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748397471; c=relaxed/simple;
	bh=4HjYB4qD80vuvebU1onFwu/O5AJxJ4g8Zbk3uV1XDlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtRd3wMHxH5KWl7yH1As8arV9feymH3gzVvytRbEgKakEKHviJ0CNQUAy3bp5gQ4OZgNOn0OcDE6Ny6THKdnEFGixOsuYj4bt7pWhH/gFbmxvrx5wYpfe8JWsm53fjJh4fxmp8Rqrwyv61d8QD6Cu3ROgNMrn/uPqOYmrRq4E7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3GfrO64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49398C4CEE9;
	Wed, 28 May 2025 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748397471;
	bh=4HjYB4qD80vuvebU1onFwu/O5AJxJ4g8Zbk3uV1XDlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3GfrO64xlVRAGk1LwItoFi7HXQMB18GY+SbIejkh2RD9XBKeGd7IuZxT6E1XD5rG
	 6lIXTAKWpiMWrqzjTJJ1zlk+Rt6R529QXgNsxrrmAr3tWtVsqrMzlD0CjlpAA5oNY2
	 oKfOXtDn59NOai79JZLDpyS7k8noyYXjpVe+L34IoWCExuvYkCP+df9FHg0dng/ssF
	 miJjIUf74OMO5r5q6atOzWW4eMW9pDw7t9opBtFPFs+hMX67CGBscxJcrJASJJl5ZH
	 IiBsqw0zo/97Jz2htyqncuaWXgW+Ljh89LpYgtBIgIiuXqHPZpDN+FuWfhszNyd/zq
	 A7MCC3CvUPKfQ==
Date: Tue, 27 May 2025 18:57:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Alexander Lobakin
 <aleksander.lobakin@intel.com>, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, michal.kubiak@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
 bpf@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
Message-ID: <20250527185749.5053f557@kernel.org>
In-Reply-To: <20250520205920.2134829-2-anthony.l.nguyen@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
	<20250520205920.2134829-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 13:59:02 -0700 Tony Nguyen wrote:
> @@ -3277,16 +3277,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>  			     struct libeth_fqe *buf, u32 data_len)
>  {
>  	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
> +	struct page *hdr_page, *buf_page;
>  	const void *src;
>  	void *dst;
>  
> -	if (!libeth_rx_sync_for_cpu(buf, copy))
> +	if (unlikely(netmem_is_net_iov(buf->netmem)) ||
> +	    !libeth_rx_sync_for_cpu(buf, copy))
>  		return 0;

So what happens to the packet that landed in a netmem buffer in case
when HDS failed? I don't see the handling.

> -	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
> -	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
> -	memcpy(dst, src, LARGEST_ALIGN(copy));
> +	hdr_page = __netmem_to_page(hdr->netmem);
> +	buf_page = __netmem_to_page(buf->netmem);
> +	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
> +	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
>  
> +	memcpy(dst, src, LARGEST_ALIGN(copy));
>  	buf->offset += copy;
>  
>  	return copy;
> @@ -3302,11 +3306,12 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>   */
>  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
>  {
> -	u32 hr = buf->page->pp->p.offset;
> +	struct page *buf_page = __netmem_to_page(buf->netmem);
> +	u32 hr = buf_page->pp->p.offset;
>  	struct sk_buff *skb;
>  	void *va;
>  
> -	va = page_address(buf->page) + buf->offset;
> +	va = page_address(buf_page) + buf->offset;
>  	prefetch(va + hr);

If you don't want to have to validate the low bit during netmem -> page
conversions - you need to clearly maintain the separation between 
the two in the driver. These __netmem_to_page() calls are too much of 
a liability.

