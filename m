Return-Path: <bpf+bounces-63137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89509B03363
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E111D7A4EC0
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6620126A;
	Sun, 13 Jul 2025 23:08:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C469211F;
	Sun, 13 Jul 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752448091; cv=none; b=RpIsFl+PBP2fuZYs+Ag+y++2Zsd1gSA0+TsJWVHa8QH25Er4NyE7fIWKC1znh7cglamwxcCdPRzujm7rMehcG/clGlAuIVy/nEGPdyFjie/ApXQGpVMEF4R9n31fD/hezw+wwN9RGremX0Kym6FxgzU7PGeeMNsmdglCoJRXzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752448091; c=relaxed/simple;
	bh=habpyJiwj0GUAmkpmOaf0SO6WNS9JrlFk47h0mc5Dik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHVZ26gJeR7ifftiMy3gRWTkXmdlII+BEmOd2jBMvmru4J8Hz88/TLeovq7gr0OkHeKNIgVTrrA+XgFmL0vmbYPSgfWx8bWytzzh+tzuOAbDaHqKPaj9H+0AuXC47vpBNgHsWLBAK8VYULzqN+TmgyJv/tvF7bGeoxJYrG7DKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1d-68743c4ddf33
Date: Mon, 14 Jul 2025 08:07:52 +0900
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
Message-ID: <20250713230752.GA7758@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3e3XsdTq7L9JdCf6wkMsxSqRNpGPXHjRKioD966cpLG/li
	803FSiWyNLMiWyuW4lucLZkzTHQuHygllnZLy0dllo9V1khnD6dE/vfhe875nPPHYQiZTuzL
	qOKTeHW8IlZOSUjJlHtRYGRYknLTeO4W0BurKaj6mQZlwxYx6CvNCL7PDtAwY2unoPi+gwD9
	sywSfhjnCPjQNkpDlSkShkrHSGi8WE/A6NUOCnKznAQ8np2m4YKlXAQ95jwx3JgrIaBeO0zD
	80d6Ct5W/xHDmDWXhE5dBQlDeRHQZvAGR9ckApuxXgSOK3cpuN5roOBd1hCC3tZREu6cz0Ng
	bBLE4Py54Ljz5C0dsZZrnbQTXF3FKxHXoHtDcwZTMvewPIDLEXoJzlR5ieJM3wpobrC/keI6
	Cp0k12CZEXG5mdMU9/XDa5KzN/VRnLGuj+S6DTZ6v+dhSVgMH6tK4dVBO6IlyqcNPUTilE/a
	BUezSIsKVuQgNwazobitvx/9Y1u1nXAxyfpjY8d7kYspdh0WhNnF3IvdgCdeWukcJGEItpDC
	NSOllKuwgo3CX26ZFwek7FZcMjVCu1jG3kBY2wlLuSfuvP2edDHBBmDh96eFfmaB/XDZb8YV
	u7HheL44e1Gzkl2Dm83tItcuzDYy+Jf2HrV06CrcUi6Q+YjVLdPqlml1/7UGRFQimSo+JU6h
	ig3dqEyPV6VtPJkQZ0ILH1N6dv6IBX3rOWhFLIPk7lKhTqOUiRUpmvQ4K8IMIfeSfn6jVsqk
	MYr0DF6dEKVOjuU1VuTHkHIfabAjNUbGnlIk8ad5PpFX/6uKGDdfLdq+q3xzxvGivWmw8+aY
	suVs5vwL/0HsHE+d0AV/rIn0CEreO0z5jW7z5EekpQeCC8+EhNzs9hho/VQmWC6nDub/eHAu
	5JjfL7uX2+r5qKL17XNl3pf0iWaxJT9mzHSw66jNeu3J7ujAQPmhPcXTvfdOBN0Nz/afcNbu
	M3k3rRFq7XJSo1RsDiDUGsVfDUSl9S0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+59zds5xNDzNlX80CibdDEst64UsDIIOghFBSBewkac2UrPN
	RLuAqRFaWpmgzRmGtHKTRmvsUma2zdrooizUWalpdte0MslLljMiv/14nvf3fHpZUjpJhbGq
	jCxBnaFIk9NiSrxtQ0FUUnyWMvqTJwJ0pnoajD9z4Ppruwh0BiuCkbGXDHx3P6Kh9uooCbqW
	Qgp+mMZJePuwjwGjOQl69O8oaDhjI6HvvIeGksIJEu6NfWEg336DAFe1VwSt1lIRlI9fI8GW
	95qB53d0NHTX/xbBO2cJBV5tHQU9pQnwsGYBjD4eQOA22QgYPVdNwyVfDQ1vCnsQ+Fx9FFSd
	KkVgavSLYOLn9EZVczeTsIR3DQyRvKWuk+Ad2i6GrzEf5W/fiOSL/T6SNxuKaN78rYzhX7U3
	0LyncoLiHfbvBF9S8IXmv759QfFDjW00X/thmOBNljZqu3S3OD5VSFNlC+rVm/aJlc8crWTm
	YGhO/mgTkYfKQopREIu5tdhdP0QGmOKWYJOnnwgwzS3Dfv/YTC7jVuLPHU6mGIlZkquk8c1e
	PR0oQrgUPFxhnREk3Hp8bbCXCbCUK0c4zwt/83nYe7mfCjDJRWL/1Mfpe3aaw/H1KTYQB3Eb
	8WTt6ZmZ+VwEbrI+Ii4giXaWrZ1la//bNYg0IJkqIztdoUqLW6U5pMzNUOWs2n843Yymf0J/
	cvKiHY083+pEHIvkcyV+i0YpFSmyNbnpToRZUi6TfOpSK6WSVEXuMUF9OEV9NE3QOFE4S8lD
	JYnJwj4pd1CRJRwShExB/a8l2KCwPNTSNmdn9Nj7B2uIE09rK91hRTsslvC16a+OOKnmKMfc
	RcdlS41PhP7x2L3B8l9ou0v3+eO6RHHFlZTkFWdX9O1p7+6KOqbXDCfELh80RE90HrgfCo/j
	dp0gR+76XOychTh+p3GzjMOZQYotMR1nKVtnMN1bvbDKHzpguOUTLY6TUxqlIiaSVGsUfwAk
	/SylDwMAAA==
X-CFilter-Loop: Reflected

On Sat, Jul 12, 2025 at 12:59:34PM +0100, Pavel Begunkov wrote:
> On 7/10/25 09:28, Byungchul Park wrote:
> ...> +
> >   static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
> >   {
> >       if (netmem_is_net_iov(netmem))
> > @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
> >       return page_to_netmem(compound_head(netmem_to_page(netmem)));
> >   }
> > 
> > +#define nmdesc_to_page(nmdesc)               (_Generic((nmdesc),             \
> > +     const struct netmem_desc * :    (const struct page *)(nmdesc),  \
> > +     struct netmem_desc * :          (struct page *)(nmdesc)))
> 
> Considering that nmdesc is going to be separated from pages and
> accessed through indirection, and back reference to the page is
> not needed (at least for net/), this helper shouldn't even exist.
> And in fact, you don't really use it ...
> > +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> > +{
> > +     VM_BUG_ON_PAGE(PageTail(page), page);
> > +     return (struct netmem_desc *)page;
> > +}
> > +
> > +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> > +{
> > +     return page_address(nmdesc_to_page(nmdesc));
> > +}
> 
> ... That's the only caller, and nmdesc_address() is not used, so
> just nuke both of them. This helper doesn't even make sense.
> 
> Please avoid introducing functions that you don't use as a general
> rule.

I'm sorry about making you confused.  I should've included another patch
using the helper like the following.

	Byungchul

---8<---
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index cef9dfb877e8..adccc7c8e68f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3266,7 +3266,7 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 			     struct libeth_fqe *buf, u32 data_len)
 {
 	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
-	struct page *hdr_page, *buf_page;
+	struct netmem_desc *hdr_nmdesc, *buf_nmdesc;
 	const void *src;
 	void *dst;
 
@@ -3274,10 +3274,10 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
 	    !libeth_rx_sync_for_cpu(buf, copy))
 		return 0;
 
-	hdr_page = __netmem_to_page(hdr->netmem);
-	buf_page = __netmem_to_page(buf->netmem);
-	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
-	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
+	hdr_nmdesc = __netmem_to_nmdesc(hdr->netmem);
+	buf_nmdesc = __netmem_to_nmdesc(buf->netmem);
+	dst = nmdesc_address(hdr_nmdesc) + hdr->offset + hdr_nmdesc->pp->p.offset;
+	src = nmdesc_address(buf_nmdesc) + buf->offset + buf_nmdesc->pp->p.offset;
 
 	memcpy(dst, src, LARGEST_ALIGN(copy));
 	buf->offset += copy;
--
> > +
> >   /**
> >    * __netmem_address - unsafely get pointer to the memory backing @netmem
> >    * @netmem: netmem reference to get the pointer for
> 
> --
> Pavel Begunkov

