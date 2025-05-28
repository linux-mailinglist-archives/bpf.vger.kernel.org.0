Return-Path: <bpf+bounces-59119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD6AC614E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A278E4A1A81
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C11207E1D;
	Wed, 28 May 2025 05:41:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42641C84B2;
	Wed, 28 May 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748410875; cv=none; b=MO3bqGj47vqCOsWZTidK0LZ1dJWWtwOQ60vwzU7wVYYgKaZ+oKsXJtoD09OChj80c9CnuOUqtcexcirFk8H7GZlHjw9nnRFQK5SZlnQkq6k9Eeb2+92vRI8GEBEJV/dMvSri+jUmJuVQhxPO9xOSRADZgpKnsAUDSXsu7luBp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748410875; c=relaxed/simple;
	bh=wN8sYZl/mz8uDPrAXCUTTNFLSJM4kxH7HqZEgJtHnQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izi5OEGQyKabOK+o4fKc5eTAWIFrNlaDfbL3hq8BYganxCmLVWOaFYSEjRx7rG9+B3MWjPyNwpzS+fvT8VrTZQMDXTSTvuw9YGPXd3sDtUbXXyd9/0fpdy2mksOBwSQT/BzEScG9n1f3HUBL/mHNo8ddoUU8lNqJzJ9EEo/Mfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-bb-6836a1f3d4ed
Date: Wed, 28 May 2025 14:41:00 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
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
	vishal.moola@gmail.com
Subject: Re: [PATCH v2 02/16] netmem: introduce netmem alloc APIs to wrap
 page alloc APIs
Message-ID: <20250528054100.GB9346@system.software.com>
References: <20250528022911.73453-1-byungchul@sk.com>
 <20250528022911.73453-3-byungchul@sk.com>
 <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOkr96_i1B8o_AWQGgfWSWZVVjHhOShReLZozsxZB6WdQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fec3YcDo4r603JaBVSlFZYPkWU9CFfuoBd6EPSZbRDW+mS
	maZ2YakhWpp2o9a0aTfTbLZsrpJRZl4qTDRjXa2VGmSlLsUblXNEfvvx3H7/Dw/PKIrYAF6r
	2y/qdaoYJSfDsu++hfPdhUs0Cwa7/cFkuclB6UASXP9oZ8FUYkPwa/CtFNw1dRxcLuxnwPQi
	HUOfZYiB9lqXFNqudWCoyqhkwHWynoPs9GEGUu3FEmiy5bBwZugqA5WGj1JouW/i4MPNPyx0
	VGdjaDDewNCWEwG15snQ/6wLQY2lUgL9J/I5ON1s5uBzehuC5scuDBeP5iCwOJwsDA+YuIgZ
	tOLGawm9Z3wvpWZrAr1TPJdmOZsZai3J5Ki195SUvntVxdH688OY3rO7JTQ77QdHe9rfYPrT
	0cpRS0Urps/NNVLqtgZFCVtly9VijDZR1Ieu2CnTVHSZUNw5vyTHuc0GlC/PQj48EcKIu9HO
	/OOMTofEw1iYTV4OH8ce5oRg4nQOjs1MEuaQK4481sOM0MaSRtMeD08Uosmxb6Vj83IhnNzN
	7eaykIxXCMWIOA0vJd6GH2m48AV7l4PJSEHz6FF+lAPJ9d+8tzydpN29OObyETYQwwNvNn9h
	Jnloq5N4bhLBzpMLmSVSb+ip5FGxE+ciP+M4hXGcwvhfYRynMCNcghRaXWKsShsTFqJJ1mmT
	Qnbti7Wi0c+5dngk2o56mzZVI4FHSl85LV+sUbCqxPjk2GpEeEY5SZ66colGIVerklNE/b4d
	+oQYMb4aBfJYOUW+qP+AWiHsVu0X94pinKj/15XwPgEGlLA7v9FGLlXeGjh0RNM+ryM0xbl5
	4cEo2ZazloJZm1KiPq17Hvy7aPvnh4bwrV0tE62rtBPa16qjy5+Erk1IU8f+CFo6OVwmKrSB
	6G3u+U5/TVMq9t3WFVlU0JO3pjYzz16vjrzfs7iMnaY73JpRGmaLWL2+deTr02Vxqze2uMpu
	9ylxvEa1cC6jj1f9BdCSIPI1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe97Ls9fR4nVZvWURLUoSNKO0I0VJH+oh6AaVlB9q6VubTq2t
	hnahlYZkza6IrSkbVpoKS1s6S0ZMMS1JmxrrOrNSu1CWF9TZxSmR336c///8zpfD0fIz7BxO
	nXJY1KYoNQosZaSbV2WE9VmjVBH2HgxmWxmG0qE0KOpwsGAuqUTQP/xKAn11jzAUWgdpMDdn
	MjBgG6HhY32nBLy3uhioyaqiofNCAwZjpo+G045iCmrzG1loqcxh4erITRqqDB0SaL1vxvC2
	7A8LXS4jA42m2wx4c2Kg3jITBp98RVBnq6Jg8Hw+hituC4b3mV4E7tpOBq6fykFgc3pY8A2Z
	cYyC2G+/oEi16Y2EWCqOkLvFoSTb46ZJRclZTCp+XpaQ189rMGnI8zGk2tFHEWPGN0x+fHzJ
	kO/OdkwKe3opYrO3M6TJUifZGrhbujpB1Kj1onbpmr1Slf2rGR3MDUxz5m43oHxZNgrgBH6F
	kNXtpPzM8IuENt85xs+YDxE8nmHaz0H8EuGG8xLrZ5r3ssJTc6Kfp/NxwpkvpeN9Gb9SuHex
	F2cjKSfni5HgMbRRE0Gg0HjtAzOxHCKMFrjHpNwYBwtFv7mJ8Xwh49718VsB/DbB8MAxzjP4
	hcLDykfURTTNNMlkmmQy/TeZJpksiClBQeoUfbJSrYkM1yWp0lPUaeHxqckVaOw5bp0YveRA
	/a0bXIjnkGKqjNyJVMlZpV6XnuxCAkcrgmSn10ap5LIEZfpRUZu6R3tEI+pcKJhjFLNkG2PF
	vXL+gPKwmCSKB0Xtv5TiAuYYEN6pbY7O+60Peay24uAtzXnPD/xq8U2Pal9YfihhwTrrwLv3
	DUM5YTfvZG0ILvgT/fjYSOywcf/SUztSazYldu8wjS5IzTRGSDSfenZN2Rwv2bczd1vTwPdw
	e2HY8bKB5vIt63lpnPtkYn3pPN+12YuD5hU/C9VY53421EbLXK7lMfsUjE6lXBZKa3XKvxHZ
	eCsYAwAA
X-CFilter-Loop: Reflected

On Tue, May 27, 2025 at 08:11:58PM -0700, Mina Almasry wrote:
> On Tue, May 27, 2025 at 7:29 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To eliminate the use of struct page in page pool, the page pool code
> > should use netmem descriptor and APIs instead.
> >
> > As part of the work, introduce netmem alloc APIs allowing the code to
> > use them rather than the existing APIs for struct page.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/netmem.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index a721f9e060a2..37d0e0e002c2 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -177,6 +177,19 @@ static inline netmem_ref page_to_netmem(struct page *page)
> >         return (__force netmem_ref)page;
> >  }
> >
> > +static inline netmem_ref alloc_netmems_node(int nid, gfp_t gfp_mask,
> > +               unsigned int order)
> > +{
> > +       return page_to_netmem(alloc_pages_node(nid, gfp_mask, order));
> > +}
> > +
> > +static inline unsigned long alloc_netmems_bulk_node(gfp_t gfp, int nid,
> > +               unsigned long nr_netmems, netmem_ref *netmem_array)
> > +{
> > +       return alloc_pages_bulk_node(gfp, nid, nr_netmems,
> > +                       (struct page **)netmem_array);
> > +}
> > +
> >  /**
> >   * virt_to_netmem - convert virtual memory pointer to a netmem reference
> >   * @data: host memory pointer to convert
> 
> Code looks fine to me, but I'm not sure we want to export these
> helpers in include/net where they're available to the entire kernel
> and net stack. Can we put these helpers in net/core/page_pool.c or at
> least net/core/netmem_priv.h?
> 
> Also maybe the helpers aren't needed anyway. AFAICT there is only 1
> call site in page_pool.c for each, so maybe we can implement this
> inline.

Ah.  I recalled the reason why I added these APIs this way, that is, to
make the allocation method easier to be altered in the future.  I will
move it to net/core/netmem_priv.h but keep it in the header anyway.

	Byungchul
> 
> -- 
> Thanks,
> Mina

