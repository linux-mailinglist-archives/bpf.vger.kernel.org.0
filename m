Return-Path: <bpf+bounces-58918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBBAC380A
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A391722CC
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82417B425;
	Mon, 26 May 2025 02:36:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2C35979;
	Mon, 26 May 2025 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226997; cv=none; b=qxDSpv4O0brolEVwejmCdzjbzHrtQEJ8Lc/Na1Jy3O2sFJ2YURZDOloLaY8rgH8cvQCy3Lfx4C6Uz7GAt/cmNbbZlAHGa0apbf37iLlNsE3W6XWw5eSZKnuwJm6oeP0NAonT0J/tJSieznKoB2nBRs5h2n4jbPU7g+yINIG7m+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226997; c=relaxed/simple;
	bh=rB8e59f9DCmVM7INNnSN9zJLulQqCsUj1n2FnpHMHzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+fL+8dr6zzcsXUGo/8Z0CxP9o0WXhQw3FT7Ghi30Ffh+OeEX9BkwY5gPJKYkk49cMKpyAy8qcU+THR0PHpPFjrV9Gpp3eP88yAfwN6P1c2Of3TnS0GnVfgYzqxSkqGDMEw6Gwuxf4tNx+u1kL3444bnFKxYackrAoDynlGol+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-fe-6833d3ade381
Date: Mon, 26 May 2025 11:36:24 +0900
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
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250526023624.GB27145@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526022307.GA27145@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa2yLURjHnb6np+9qjeM1nLpGRYS4bC7JI5HxQTgScQkhcV2tb7SsJd3M
	Ji6dzW3ZhhGXrqyY3YxG1VYsC7ObEKZCOkaXYhLX2GaZbRm6RezbL8+T5//7f3hEQbqkHCGa
	LAmy1aKP0xE1Vn8Nvzj1+vOZxsjU1wQcrhICVzuSoKDJqwRHcSmCtl+vVdBaVUvg8sV2ARxP
	0zD8dHUK8KEmqIJAfjOG8sNlAgSP1RHITOsS4IC3UAH1pVlKONV5RYAyW5MKnt9xEHhb8lsJ
	zZWZGB7aizAEsuZDjXMYtD/6gqDKVaaA9ozzBE76nATepQUQ+B4EMeSkZCFwVfiV0NXhIPPH
	cU9Rg4Lftr9Rcad7J79ZOJmn+30CdxcfJdzdkq3ijS/LCa8724X5bW+rgmemfiP8x4dXmH+v
	eEG4y/MC88fOKhVvdY9ZTteq5xrkOFOibJ0eHaM2lraV4B0NEUmdp08SG0qh6UgUGZ3Fau/G
	pKOwXizJ7lGFGNMJzOsLoBATOpH5/b+EEEfQSSyv4oQyxAINKNkTx9YQD6FbWcarjyTEGgqs
	uqDqb45alKgfsY68VNy3GMwennuP+44nsu4LPiHUQaAjWUGP2Dcey1Jv5fS6wugcduRMT2+H
	oXQ8u1daqwhlMuoVWW5mHukrrWX3C/34OBps76ew91PY/yvs/RROhIuRZLIkmvWmuFnTjMkW
	U9K02O1mN/r7Ofl7u9d5UUv9ykpERaQL18ToZholpT4xPtlciZgo6CI0oxyRRklj0Cfvlq3b
	N1l3xsnxlWikiHXDNTPadxkkukWfIG+T5R2y9d9WIYaNsCHpZVBb8/kQt8VGf8p7pl4wPPrr
	zyujqwcm1O/3KKZEeRbrb7UVZQfN42szGj0F5rSpKcuaNuxeuyR3k1YbvmRj47Vvawz5C6Wm
	jUMsqw6u2BWJpYWfuw3BMTmxsxcsutHSsL56z0Bt84AjS+vKk2wevP736qjEjBP76OllmwfN
	24sUOhxv1EdNFqzx+j/0dYZGNQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+e9cdhwujmvmQYtiIZKkJZa8oZgJ0aHA6kNlftGlh7acU7Yp
	WmQzLS+oXZSsOWuipZkyMJ3TRMK7GCqTclk5m7c+WGpe8IbllMhvD++P3/O+H14KE90n3Cm5
	UsOplFKFhBTggrDAdJ+aQX/ZUfsLH9Abq0l4s5wMFaNmAvRVJgQLK1/4MN/eRUJZ6RIG+v4M
	HBaNqxhMdNr5YHs1iUNzZgMG9gfdJORlrGFw11zJg7aSHgIGTPkEFK6+xKBBO8qHwSY9CSPV
	fwiYbM3DoUf3Ggdbfgh0GvbAUu80gnZjAw+WcktIKLAYSBjLsCGwtNlxKE7LR2BssRKwtqwn
	QyRs3evPPLZR943PGmoT2beV3myO1YKxtVXZJFv7+zGf/fqpmWS7n67hbKN5nsfmpf8i2bmJ
	YZydaflIsmU/Znmsse4jzn4wtPMvuEQIgmI4hTyJUx0JjhLITAvVeMJncfLqkwJSi9LoHORE
	MfQxpvrxBt/BOO3JmC025GCS9mKs1hXMwWL6EFPe8ohwMEbbCKZPf8PBu+kbTO7wFOlgIQ1M
	R0X7pkdAiWgrYpbL0/HtwIXpeTaOb5e9mPXnlk0ptckeTMUGtT3ez6TXF2/tcqJPMFlFG1s3
	uNIHmfemLt5DtEu3w6TbYdL9N+l2mAwIr0JiuTIpTipXHPdVx8pSlPJk3+j4uFq0+R2vbq8/
	MqOFwTOtiKaQxFkYJfGXiQhpkjolrhUxFCYRC/fqj8pEwhhpyk1OFR+pSlRw6lbkQeESN+HZ
	K1yUiL4u1XCxHJfAqf6lPMrJXYtG6sOuHQgKdx87Nz57KiA69WJ2d7Lfikt5iaLGdWjx8FXn
	Kf6doTpP7ck56rRmGolHPX2EkTNDwUpS+L3DnFDUH0+7FWtiTE0BWRvh/iE/u0MH7iWdD/UM
	jMg9GOQyD077Mit7YwLlhZThnSZ+1n7ZOLvUN3kr69LcQmxqqLxUgqtlUj9vTKWW/gUiqudE
	GQMAAA==
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > >
> > > To simplify struct page, the effort to seperate its own descriptor from
> > > struct page is required and the work for page pool is on going.
> > >
> > > To achieve that, all the code should avoid accessing page pool members
> > > of struct page directly, but use safe APIs for the purpose.
> > >
> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > > page_pool_page_is_pp().
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  include/linux/mm.h   | 5 +----
> > >  net/core/page_pool.c | 5 +++++
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 8dc012e84033..3f7c80fb73ce 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > >
> > >  #ifdef CONFIG_PAGE_POOL
> > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > -{
> > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > -}
> > 
> > I vote for keeping this function as-is (do not convert it to netmem),
> > and instead modify it to access page->netmem_desc->pp_magic.
> 
> Once the page pool fields are removed from struct page, struct page will
> have neither struct netmem_desc nor the fields..
> 
> So it's unevitable to cast it to netmem_desc in order to refer to
> pp_magic.  Again, pp_magic is no longer associated to struct page.

Options that come across my mind are:

   1. use lru field of struct page instead, with appropriate comment but
      looks so ugly.
   2. instead of a full word for the magic, use a bit of flags or use
      the private field for that purpose.
   3. do not check magic number for page pool.
   4. more?

	Byungchul
> 
> Thoughts?
> 
> 	Byungchul
> 
> > The reason is that page_pool_is_pp() is today only called from code
> > paths we have a page and not a netmem. Casting the page to a netmem
> > which will cast it back to a page pretty much is a waste of cpu
> > cycles. The page_pool is a place where we count cycles and we have
> > benchmarks to verify performance (I pointed you to
> > page_pool_bench_simple on the RFC).
> > 
> > So lets avoid the cpu cycles if possible.
> > 
> > -- 
> > Thanks,
> > Mina

