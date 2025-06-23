Return-Path: <bpf+bounces-61259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FEEAE3453
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 06:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209C7188FE77
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 04:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F11C68A6;
	Mon, 23 Jun 2025 04:32:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFCA95C;
	Mon, 23 Jun 2025 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750653141; cv=none; b=S/qi2eBGexumtRn2L9CSL8+eM61pzt8qhXsiCBoKFPQnB2Az8Aj+K961GJSJV/ISPxKTmdwN05SNMf2+t8tH9O4h643okB9/U+cX4fsexHmFByLcGEvk/V+76t5bjBj+/eolHFG3qIRCAHT7jacwbKVlFnEDq3Y7/3sLxdUwAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750653141; c=relaxed/simple;
	bh=ggo/SI/AISA8J6s0yt0k1qoyYkjyPngK3bM8bZl5ikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKd8avWAJQGBPq2thfFwk/jUdid8fNIV3T7yjmu/vWAbO2cwU+mKnXRNEtW/LHVNfr3LaRsEx/OeezN58Z0yL7yOD6fN/vozC/a/JgfZFLL8SOK7eEYQI1sVZSeChbdwxyenBlIRnSIARpbDe9MIZr9Pq1GSpptcXOvCVcY6B5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e8-6858d8cc5518
Date: Mon, 23 Jun 2025 13:32:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v6 6/9] netmem: remove __netmem_get_pp()
Message-ID: <20250623043207.GA31962@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-7-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620041224.46646-7-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3af3V2Xi+syfVIiWklgmRVlBwqNQrpfKiEISyMveWkjXbql
	qRRprizxDYuyuWoRmWmwmqmzF8211KhIDWOVOtE0MdPUFDezckrktx//8+f8zofDUPIHYj9G
	pT4haNR8nIKWYul3z1tBb+yRyvV3ckLAYLpPQ/lkCtztsojBUFaF4KfzswTGbI003L41QYHh
	nQ7DuMlFQW9DtwTKzbvBUdKH4WlWNQXd+U005OqmKHjmHJLAWUupCJqr8sRw2XWHgur0Lgm8
	f2ygofP+HzH0WXMxvNLfw+DI2w4NRh+YeD2IwGaqFsFEznUaLrUaaejRORC0vujGUJyRh8BU
	axfD1OTMjuKXnZLtq7gXg8MU9+jeRxFXo++QcEZzEldRGshl21spzlx2kebMo4USrv3DU5pr
	KprCXI1lTMTlZg7R3EjvJ8wN17bRnOlRG+beGG2SCK+D0m2xQpwqWdAEh8ZIlaar9TghY1HK
	w3wDTkd1C7ORB0PYTaQz6wb1j0d0zdjNmA0gjZ2FsznNriZ2u3OGGcabDSYfCg9kIylDsZk0
	KWxzzvYXs+HkbWkO7WYZC8T54xtys5zlyYWBc2gu9yKvrn2Z7VPsWlJT2U67d1KsP7n7m5mL
	l5PMyuJZrQcbQvqHmkRuXsKuJM+rGkVzZzYzxGRLneOlpL7UjguQl36eQT/PoP9v0M8zGBEu
	Q3KVOjmeV8VtWqdMVatS1h05Hm9GM39UcvpXlAWNNu+zIpZBCk9ZjGekUi7mk7Wp8VZEGErh
	LbPu2K+Uy2L51DRBc/ywJilO0FqRP4MVvrKNEydj5exR/oRwTBASBM2/qYjx8EtHEaYVLYkD
	tvbENP9+JmjLnj/L66ZFPo/PhLWs8ap1FQU9Cay/MnI+IKvOvtl1ROe6GX3qYGXeHvOA7zJ2
	esjHA0kd4R22Tw0qlSO9qnLL1lZKG7SguIa+MZ1Wbv66K+JQeFHY3jWW8RZeEebZE1rQFfM8
	qi16yc4Flw7HjFeUqRUKrFXyGwIpjZb/C5Lllu9DAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e/8d3Zczk5r1Uk/RDMLokzpwptFSCEdsiII1Ppgjjy15bUt
	TaPIy0IztZpRNlctRF0mrZbXsqx5mWKRKNqypWkqZualdDjt5ozIbz+e9+H3fHkpQpzDd6cU
	0ac4ZbQsUkoKsXD/ttT1r6whcp9P6Z6gM5aQcH8qAYo+VvJBV1yOYMLxXgDf6ywk5N+1E6B7
	o8YwaZwmoL+hVwD3Tfugu3AAQ3VaBQG9lxtJyFLPEPDMMSKAlEoDD2pvNfGhpTybD9emCwio
	SPoogLYnOhK6Sn7zYcCchaFJew9Dd7Y/NOiXgr15GEGdsYIH9sxbJOS06kn4pO5G0FrbiyEv
	ORuB8bmVDzNTs468+i6BvxdbOzxKsKX33vHYKu0HAas3xbGPDWvZDGsrwZqKL5Ks6ZtGwNo6
	qkm2MXcGs1WV33lsVuoIyY73d2J29Hk7yeYPjvFYY2k7PiA+LNwezkUq4jnlhh1hQrnxxksc
	m+yW8OiyDiehmgUZyIVi6E3MuLoFOxnTXoylS0M4maTXMFarY5YpSkJvYDo0hzKQkCLoVJLR
	tDvm+ovpAOa1IZN0sogGxjH2BTlZTMuY9KEL6G++iGm62TfXJ+h1TFWZjXQ6CdqDKfpF/Y1X
	MKlleXOzLvQWZnCkkefkJbQn86LcwruC3LTzTNp5Ju1/k3aeSY9wMZIoouOjZIrIzd6qCHli
	tCLB+2hMlAnNvkrhuR9XK9FE224zoikkdRUZAkPkYr4sXpUYZUYMRUglIvPOILlYFC5LPMMp
	Y44o4yI5lRl5UFi6TLQnmAsT08dlp7gIjovllP+uPMrFPQnhga81Kw2HA0sXzsSnTFX7rc7v
	WO7bs7Xn4O2GtJOaveWWoFHHF9uq83GXJk+/dLtTd6Dq7fqzybb3PvWZSe82YunPPl3nCdex
	66e9a+iBuLPBi0KajfbPDyWhBSMF7lf9AnI9UybVuzpj/AnLmWOTgz0FoVfk+gcSQebTIbtt
	eWGYFKvkMt+1hFIl+wM4qcRvJgMAAA==
X-CFilter-Loop: Reflected

On Fri, Jun 20, 2025 at 01:12:21PM +0900, Byungchul Park wrote:
> There are no users of __netmem_get_pp().  Remove it.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  include/net/netmem.h | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index e27ed0b9c82e..d0a84557983d 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -245,22 +245,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>  	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
>  }
>  
> -/**
> - * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
> - * @netmem: netmem reference to get the pointer from
> - *
> - * Unsafe version of netmem_get_pp(). When @netmem is always page-backed,
> - * e.g. when it's a header buffer, performs faster and generates smaller
> - * object code (avoids clearing the LSB). When @netmem points to IOV,
> - * provokes invalid memory access.
> - *
> - * Return: pointer to the &page_pool (garbage if @netmem is not page-backed).
> - */
> -static inline struct page_pool *__netmem_get_pp(netmem_ref netmem)
> -{
> -	return __netmem_to_page(netmem)->pp;
> -}
> -

In the meantime, libeth started to use __netmem_get_pp() again :(

Discard this patch please.  Do I have to resend this series with this
excluded?

	Byungchul

>  static inline struct page_pool *netmem_get_pp(netmem_ref netmem)
>  {
>  	return __netmem_clear_lsb(netmem)->pp;
> -- 
> 2.17.1

