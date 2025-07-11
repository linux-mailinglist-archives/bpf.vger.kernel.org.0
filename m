Return-Path: <bpf+bounces-62990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF1DB010A4
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 03:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE801AA84EC
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 01:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443C78F5E;
	Fri, 11 Jul 2025 01:14:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3D70808;
	Fri, 11 Jul 2025 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196489; cv=none; b=QUGIV9aJHOrrSMBcSL68Njdlr1pb6xBVpYgIh9EzPuTM+hdIAFZnh8L1tVUXgFEIh9JWPbnQaoojEDiLLZh2irv6E6i6HNvMssFR10kwehFllC+qnYq88EZhpkrvyZ69QjdEx0ppUSs9z3PFmfj7DSDzYA0MjIuQRO96KrS9vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196489; c=relaxed/simple;
	bh=xhz4r0kUHVh86SkdUy07aHBytclY8GvduSjuV3fjBDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O72u0fB2UPcw60wJDhRbBZHhIZu+ChjscU1eOK8KoegAsA2Q9uohqPmVzdavGuIHxF1aOIdcgSgRLYgktuGw1ReYu60RkCJc4ezV7+PQXo1u9xIJkNdsaUo/pSWi112YcJjdqGkhhnBXM+1v4wdhEJJJn95TOVG5a3PNiPxUGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-67-6870658031e2
Date: Fri, 11 Jul 2025 10:14:35 +0900
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
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250711011435.GC40145@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzjkOV8ep9ZpBtO5GluWHB4rwQ+UxMJL60gVs6KGN5oXN
	TMtAy5QkbWaZzVkry8uMhjN1mlpNzXWjWljrYprlhTIjy6XOMk8i+e3H//nz/J4PD0PIzOL5
	jCo2gdfEKtRySkJKvnpeXZ3GxyvXPs+XgsF8g4KKkSQo7bKKwWCqQfBz9C0NP1raKCi+4iLA
	8DSdhGHzGAE997tpqLCEQ2dJLwkNmbUEdJ+xU5Cd7iagcXSQhuPWMhE8q8kRw7mx6wTUpnbR
	8KLeQMH7GxNi6LVlk/BAX05CZ04I3DfOBdejAQQt5loRuE4XUZDnMFLwMb0TgaO5m4TCtBwE
	5ianGNwjkzsKW9/TIUu45oFvBHer/LWIq9N30JzRcoirKgvgspwOgrOYTlGcZegszb172UBx
	9gI3ydVZf4i47BODFPe95w3JfWtqpzjzrXaSe2xsoXd47ZFsjObVqkRes2bTfonSUW4Sx5cv
	SDrZ6EapyDY3C3kwmA3GvUY7mub+ot9igUl2Ke5rb/uXU+xy7HSOEgL7sCvxtabcyY6EIVg9
	hdvru8ksxDDebBI2PaIElLKAWy/sE+oytgzh2yOhAktZL/zg4idSYGJy5fglByHUCdYfl/5h
	puKF+ER14b/Yg43AXQVbhNiXXYzv1rSJBClm7QxudeuoqYv98L0yJ6lDXvoZBv0Mg/6/QT/D
	YESkCclUsYkxCpU6OFCZHKtKCoyKi7GgyTcqOTa+14qGnu20IZZBck9pSEWcUiZWJGqTY2wI
	M4TcR3ozPF4pk0Yrko/wmrhIzSE1r7Uhf4aUz5Oucx2OlrEHFAn8QZ6P5zXTUxHjMT8VLajs
	q1dHHPFV+ZUc/tCvruqYWLHc4PrlF6QrrcyvMlWaet5GzNnaYIjkQ/q0C8MG8y7u2vyEePXZ
	5+jJOee9q1NmR31JUUUOh666c339hv1HpQWZ/TX0RHXDtozi7UF2daVHxhgdfM7dGpizbNbl
	T2EaXW7UeN0inXVIm3K7Yzd+KCe1SkVQAKHRKv4C3wLim0IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRiH+3bO+XYcTY7L6mBSsDIp6CZdXroKUX4URf0VVFArD255ZTOZ
	QbWa3SQ1tciO0yaZlyktlukstZrlEolqYa7MXCtLQ7Sr6LSLp4j87+H3Pjx/vSylymXCWF1S
	qqBP0iSosYJWbF1lXmASUrSL+/uiwGKvxlA1bIRyn5MBi60WwbeRTjl8ve/GcKVkiALL4wwa
	vtsDFPS0+OVQ5dgC3WXvaWg4VUeBP+chhqyMUQoaRwbkcNxZIYPmolYGntRmM3A+cJWCOpNP
	Ds9uWTC8rv7FwHtXFg2tYiUN3dnR0GKdBkNt/Qju2+tkMHS2CEO+x4rhbUY3Ak+zn4bCY9kI
	7E1eBkaHxxuFD17LoyNIc/8gRWoqX8hIvdglJ1bHQXKjYj7J9Hoo4rCdwcTxJU9OXj1vwORh
	wShN6p1fZSTLPIDJ556XNBlsasfkSu8nGbHXtNPbVDsVq2OFBF2aoF+0dq9C66m0MSmV4cYT
	jaPIhFzTMlEQy3NL+d6iH4zENBfBf2h3I4kxF8l7vSOUxKHcPL60KXfcUbAUJ2K+/ZafzkQs
	O4Uz8rY2LKGSA/7Bxd2SruIqEH97OEZiJRfCt156R0tMjSfHij2UpFPcDL78J/t3nsWbbxb+
	mYO47byvYIM0T+Vm83dr3bJzKFicEBInhMT/IXFCyIpoGwrVJaUlanQJyxYa4rXpSTrjwv3J
	iQ40/ihlh8dynejbsxgX4liknqyMrkrWqhhNmiE90YV4llKHKq9tSdGqlLGa9EOCPnmP/mCC
	YHChGSytnq7ctEPYq+LiNKlCvCCkCPp/VxkbFGZC2v7jp5cLouHYpK43LVH2mRfGTgd/7Ihc
	V+Zzx37Andebu1bcbcybs3KrUbyeeI3uOLLrpMt9smfV5c2+QGmvv7xmo2VFiDmnp5gECp2B
	e7eHTpnC+0zF60ODF+0q2RS3Y40Xh8x9dCS5I7f+jts7uO/otjDu5idzvjfeip82HXirpg1a
	zZL5lN6g+Q3HXtvPJAMAAA==
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 11:19:53AM -0700, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 1:28 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > To simplify struct page, the effort to separate its own descriptor from
> > struct page is required and the work for page pool is on going.
> >
> > To achieve that, all the code should avoid directly accessing page pool
> > members of struct page.
> >
> > Access ->pp_magic through struct netmem_desc instead of directly
> > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > without header dependency issue.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/mm.h   | 12 ------------
> >  include/net/netmem.h | 17 +++++++++++++++++
> >  mm/page_alloc.c      |  1 +
> >  3 files changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0ef2ba0c667a..0b7f7f998085 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >   */
> >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >
> > -#ifdef CONFIG_PAGE_POOL
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > -}
> > -#else
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -       return false;
> > -}
> > -#endif
> > -
> >  #endif /* _LINUX_MM_H */
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index ad9444be229a..11e9de45efcb 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -355,6 +355,23 @@ static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> >         return page_address(nmdesc_to_page(nmdesc));
> >  }
> >
> > +#ifdef CONFIG_PAGE_POOL
> > +/* XXX: This would better be moved to mm, once mm gets its way to
> > + * identify the type of page for page pool.
> > + */
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +       struct netmem_desc *desc = page_to_nmdesc(page);
> > +
> > +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +}
> 
> pages can be pp pages (where they have pp fields inside of them) or
> non-pp pages (where they don't have pp fields inside them, because
> they were never allocated from the page_pool).
> 
> Casting a page to a netmem_desc, and then checking if the page was a
> pp page doesn't makes sense to me on a fundamental level. The
> netmem_desc is only valid if the page was a pp page in the first
> place. Maybe page_to_nmdesc should reject the cast if the page is not
> a pp page or something.

Right, as you already know, the current mainline code already has the
same problem but we've been using the werid way so far, in other words,
mm code is checking if it's a pp page or not by using ->pp_magic, but
it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.

Both the mainline code and this patch can make sense *only if* it's
actually a pp page.  It's unevitable until mm provides a way to identify
the type of page for page pool.  Thoughts?

	Byungchul

> --
> Thanks,
> Mina

