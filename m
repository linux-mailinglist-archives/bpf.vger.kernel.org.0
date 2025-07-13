Return-Path: <bpf+bounces-63139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A003B03381
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F21776FC
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E420D4E9;
	Sun, 13 Jul 2025 23:39:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673C20297E;
	Sun, 13 Jul 2025 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449988; cv=none; b=i5iOgbbzSEqUV6cOzsDIrOT14d6ow5T1zO0loJV+HXwbMcK+hjA/EpFA8ht9K3OAYXIpOFXTCElu5wPxyfPXnOdPN98rU679LFKIXMGEk+Erno9ii9DDiQWOEIo9a9l/ZBmfuyGV/7Uc7BIdKRCfHH/2+ssjJtY8qtWC3L0MVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449988; c=relaxed/simple;
	bh=gyYuYe+DpoRdgHiDNrkMOVuB7pT4GV9+kdEyHHfrxGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYPveJvEMnwL2paSADbH2dIKLgHzXJMO1QgbUdpdsQRcg9/1mbhsCG8UZVeqSTTcX61u9QQzmzRYNcEN+ZY5F8uhOUBsCs+9+FyOgINYUfqbRkf1LYMt1Jt8EZvE38tpBkfp3Jsig65uisCzBVTpWQOJWhEnJ39LZHV//EYe0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8f-687443bb3d56
Date: Mon, 14 Jul 2025 08:39:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
Message-ID: <20250713233934.GA26068@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
 <20250713230752.GA7758@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713230752.GA7758@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0hTcRzH+59zds5xbHGcVv/sIVtJoF3Fh18YFd04FVEQ9lAPNfLQRtNi
	M9PA0rKbeQmL1LVkdpnmpMVabmWFrs0LCtnEXBfzloKlzryVrazNkHz78Lt8ft+HH0vKikRh
	rCoxSdAkKtRyWkyJByV3VlZtSVKuKWmMBb25ggbTjxQo7bSLQF9eiWBs8gMDo846Gu6WTJCg
	f51Jwbj5Jwm9td0MmCy7ocPYR8HzSzYSuvPqacjJ9JHwYnKIgXP2MgKaK3NFcOPnfRJs6Z0M
	tDzT0/Cp4o8I+hw5FDToHlDQkbsJag3zYaJxAIHTbCNgIvs2DdfdBhp6MjsQuF91U3ArIxeB
	+aVHBL4ffsct1ydm0zL+1YCX5K0P3hH8U107wxssJ/nHZZF8lsdN8pbyKzRvGcln+I9vn9N8
	faGP4p/aRwk+5/wQzX/rfU/x3petNG+2tlJ8k8HJ7A0+IF4fL6hVyYJm9YbDYmVm+13RieKw
	FHdLDZOO2kKzUBCLuRjcWmGlZ9iqN4kCTHER2FucQwWY5pZjj2eSDHAoF4W/tjmYLCRmSa6Q
	xg+7jNPLIdwhPFxQSQRYygGuepY/zTLOgfDN7Lh/9WDcUPR5Wkpykdgz1e+fYf28CJdOsQEM
	8q8Od3OBiXncUlxdWUcETmHOyuIXV8uJfzkX4poyD3UNcbpZVt0sq+6/1YDIciRTJSYnKFTq
	mFXK1ERVyqojxxMsyP8wxrRfB+1opHmfA3EskkukHqtWKRMpkrWpCf7cLCkPlX5p1yhl0nhF
	6mlBc/yQ5qRa0DrQIpaSL5BGT5yKl3FHFUnCMUE4IWhmugQbFJaOQqrVsfsv+4TiqsGRcCoj
	unbPh4jxt0Yi+pFtzliB7/L9U0u2zh3OKy2JjHpzwSyBus7fQZvrJeMrTKE9rm1TIbtMqj97
	L7VtlPWTOy7GxRQ3Nnh717nCC3GHCwYj2vQShZDdJD4Y0jX5ffviJ0390fdi3Gd37xzLd0bN
	70rbeEZOaZWKtZGkRqv4C3CGuQAsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRSH+7/3jUava9WLfWphpdHFSjrQBSGrt6DoQxGUYaO9a6M5bVOb
	kWA5KIeuvJC1liwk77RYY85LYltpEpRNrGmZujK6OrtJurA2I/Lbwzm/58f5cBhcGiZiGY0u
	S9DrFFo5JSbEezcVrGrdlqVe29YYDzZHIwUNP41QM+whwVbvRvB98gUN3+53UVB1YwIH2xMT
	AT8cUziMdgZpaHDugaHqtwS0nW/CIXjxIQXFpjAOdyfHaDjnqcXAd72bhB63hYTyqZs4NOUP
	09DbYqPgVeNvEt56iwnottYRMGRJhk77Qph49AnBfUcTBhNF1yko89speG0aQuD3BQm4dtaC
	wNEeICH8M9Jx7cErOjmO930K4byrrh/jm62DNG93ZvN3ahN4c8CP8876Qop3fi2l+ZfP2ij+
	4ZUwwTd7vmF8ccEYxX8ZHSD4UHsfxVe9G8d4h6uP2Cc9JN6sFLSaHEG/ZutRsdo0WEVmVsYa
	/b336Hz0XGZGIoZjN3AuWwMZZYKN40KVxUSUKXY5FwhM4lGWsSu5j8+9tBmJGZy9QnG3Rqqp
	6GI+m8aNV7ixKEtY4FpbSmdYynoRd7nowN95DNd99c1MKc4mcIHp95EME+HFXM00E0VRRB0P
	stHEAnYp1+Huwi4hiXWWbJ0lW//LdoTXI5lGl5Ou0GiTVhtOqHN1GuPqYxnpThR5ieq8XyUe
	9L13pxexDJLPlQRcBrWUVOQYctMjBzK4XCb5MKhXSyVKRe5pQZ+Rps/WCgYvWswQ8kWS3QeF
	o1L2uCJLOCEImYL+3xZjRLH5SDBViHpSYMT8GLuqJMMxAU1o8HP8kZU+12jH+pMXahOTtm9c
	z7W8vKG6V35Yl122cZ25yLjfFDOwZocqfupLiiov7ylezrT3y0w6asG+FYUdqT1zXJWJqcqt
	sGVbxpm0/d6xAVew71SpaHpXakqSalnNba8FfqCSgkeSD/OWyAmDWpGYgOsNij9Wp7R+DgMA
	AA==
X-CFilter-Loop: Reflected

On Mon, Jul 14, 2025 at 08:07:52AM +0900, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
> > On 7/10/25 09:28, Byungchul Park wrote:
> > ...> +
> > >   static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> > >   {
> > >       if (netmem_is_net_iov(netmem))
> > > @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> > >       return page_to_netmem(compound_head(netmem_to_page(netmem)));
> > >   }
> > > 
> > > +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
> > > +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> > > +     struct netmem_desc * :          (struct page *)(nmdesc)))
> > 
> > Considering that nmdesc is going to be separated from pages and
> > accessed through indirection, and back reference to the page is
> > not needed (at least for net/), this helper shouldn't even exist.
> > And in fact, you don't really use it ...
> > > +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> > > +{
> > > +     VM_BUG_ON_PAGE(PageTail(page), page);
> > > +     return (struct netmem_desc *)page;
> > > +}
> > > +
> > > +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> > > +{
> > > +     return page_address(nmdesc_to_page(nmdesc));
> > > +}
> > 
> > ... That's the only caller, and nmdesc_address() is not used, so
> > just nuke both of them. This helper doesn't even make sense.
> > 
> > Please avoid introducing functions that you don't use as a general
> > rule.
> 
> I'm sorry about making you confused.  I should've included another patch
> using the helper like the following.

As Mina suggested, I will add this helper along with the patch using it.
	Byungchul

> 	Byungchul
> 
> ---8<---
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index cef9dfb877e8..adccc7c8e68f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3266,7 +3266,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>  			     struct libeth_fqe *buf, u32 data_len)
>  {
>  	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
> -	struct page *hdr_page, *buf_page;
> +	struct netmem_desc *hdr_nmdesc, *buf_nmdesc;
>  	const void *src;
>  	void *dst;
>  
> @@ -3274,10 +3274,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>  	    !libeth_rx_sync_for_cpu(buf, copy))
>  		return 0;
>  
> -	hdr_page = __netmem_to_page(hdr->netmem);
> -	buf_page = __netmem_to_page(buf->netmem);
> -	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
> -	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
> +	hdr_nmdesc = __netmem_to_nmdesc(hdr->netmem);
> +	buf_nmdesc = __netmem_to_nmdesc(buf->netmem);
> +	dst = nmdesc_address(hdr_nmdesc) + hdr->offset + hdr_nmdesc->pp->p.offset;
> +	src = nmdesc_address(buf_nmdesc) + buf->offset + buf_nmdesc->pp->p.offset;
>  
>  	memcpy(dst, src, LARGEST_ALIGN(copy));
>  	buf->offset += copy;
> --
> > > +
> > >   /**
> > >    * __netmem_address - unsafely get pointer to the memory backing @netmem
> > >    * @netmem: netmem reference to get the pointer for
> > 
> > --
> > Pavel Begunkov

