Return-Path: <bpf+bounces-60876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D48ADDFE9
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC0017CDCD
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EA43214;
	Wed, 18 Jun 2025 00:09:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1431362;
	Wed, 18 Jun 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205341; cv=none; b=QK9KOTgZry1o+0t+QbqHZc4yIKCfKzV0iJugui7EItvuwjaSMpePmT9Sci1VGVVRewh1sZ3PTCTkfliDqVTioE/fxyAqrjzQXaQaCToN46soeObGnxRwoxRznNGkm6OPnWwQcCMikPPidlbrD2GdDjr6gfqoH0xQ9QSQyCDo4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205341; c=relaxed/simple;
	bh=Lk70ooPuIoOcs1tkJF7x2dkbLiotCwY9cR+w6sgUM2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR0s9hoAZE+6BN9ffnxTVdLc2f+SgnkwPuVXt4jEnXAofgZxrPKrCzw516MIsdAgFLsK7NOcMiv5qXgKyMm7px0YMgHjc2bX1y/DcSnFuC5hGq2kW1PkXWF1ZwUy2CXg0Kh7HKXXRRxjF83QyfvBrBhQet7K5XOgltAtGlzf+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-28-6852038d4a0f
Date: Wed, 18 Jun 2025 09:08:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Mina Almasry <almasrymina@google.com>,
	willy@infradead.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	ilias.apalodimas@linaro.org, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: netmem series needs some love and Acks from MM folks
Message-ID: <20250618000840.GA23579@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
 <aFDTikg1W3Bz_s5E@hyeyoo>
 <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129fe808-4285-48fe-95b6-00ea19bd87af@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3af3V2Hg+tKeyp6cRVGkJpInKhEo5dLpVRCRAU18tZWvuSm
	poJktQxFp6WYzrelNV8yV6t0ikjaKktBWyirrImlZWSS1tCUalMkv/04/z/ndz4chpJWCJcy
	yug4XhUtj5TRYiwecS/foKUOKvy1dgqKjbU03JlIhMp+sxCKa+oR/Jx8J4Jxy3MaKm46nI0u
	DYZfxt8UDD4bEIHdMISh+WoDBQPZ7TRkaaYouGSuEkB3vVYIeb9vU9CQ2i+C103FNHyo/SuE
	obYsDC901Rjs2mB4pvcCR8c3BBZjgwAcmSU05Fr1NHzU2BFYnwxgKLqoRWBssQlhaqKYDvbm
	Hla/EXCNuvciTm+K5x5UrecybFaKM9Wk05xp7LqI6+ttprn2ginMNZrHBVzW5e8092PwLeZG
	W3pozviwB3OdeouIGzet2M8eEW+N4COVCbzKL+iEWPEh/5XoXL5PoqVMmop6l2cgN4awgWTE
	cAPPcf77EqGLMbuWOAxNIhfTrA+x2SYpFy9i1xFT2j0nixmKvUaTnj7LTLCQDSF/7j8VuFjC
	AsmrmMCukpS9RZGRlwPUbOBBXhR+mrFRzq3TpVbnnHHyMlL5h5kdrySXHxXN1N3YIDL5yDbD
	nuxq8rj+ucC1k7BmhnyurkWzVy8hrVU2nIM8dPMUunkK3X+Fbp5Cj3ANkiqjE6LkyshAX0VS
	tDLR92RMlAk5X8eQMn3UjMa6w9sQyyCZu+TengMKqVCeoE6KakOEoWSLJBXtYQqpJEKelMyr
	Yo6r4iN5dRtaxmDZYkmA43yElD0tj+PP8vw5XjWXChi3palox7EtRdvO+H97M+F/92RtwL5M
	49D30pQFuw8ZsjXZLaYQTVfeZu86cdpIWVNs3c6c+/5qk2dHLm2v2dXiVziqQteC3bcHFmA6
	WcF6hV0YXHXiq/RpecGV1lOhPpsyHiTtXZP1ZFXncMeXMH34aFd67zCypqZIDufGKrwMQ6FI
	vE6G1Qr5xvWUSi3/B2gXCps2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTcRyG+e+cnXM2Wh3X0oNiwawMKctI/EERSkQHL6TyIrSLHHpoy6/a
	1LQyNKVQmmWF5Jy1skxN3Fzl1MRiTt0ssmbastRaKRV9LW1MLWtTIu8e3vfluXopTHyaH0gp
	MrI4ZYYsTUoIcWHc1qINamyvfNMFz3rQ6hsJuO3JhVtvWvmgbWhBMDX9ioRJSy8BNdfcGGj7
	i3H4qZ/BYLzHScJY7QQOHWdMGDjPWQlQF89icKq1jgdd1TY+PG0p48OlmZsYmArekDDQriVg
	tPEPHybMahxsmnocxsqioUfnD+5HnxFY9CYeuM9WE3DRriPgXfEYAnuXE4eqwjIE+k4HH2Y9
	WiJayt6tf8lj2zQjJKszZrN36sLYUocdY40NJQRr/HGBZF8PdRCs9fIszra1TvJYddFXgnWN
	D+Pst85Bgq358J3H6u8O4uxjnYXc7Zco3JbCpSlyOOXG7UlC+WjFM/JwRWiu5aq4AA0FlyIB
	xdBbmIqRar6PcXoN465tJ31M0KGMwzGN+VhCr2OMpw1eFlIYXU4wg68t88VyOoaZa+7m+VhE
	A3OpxoP7RmL6BsZ86XNiC4UfY6t8j/sY81p/XbF7c8rLQcytOWohXsUU3auanwvo7cz0Pcc8
	r6BDmIctvbzzaKlmkUmzyKT5b9IsMukQ3oAkioycdJkiLTJclSrPy1DkhidnphuR9x21+b/K
	W9HUwC4zoikkXSIyxO6Ri/myHFVeuhkxFCaViGqscXKxKEWWd4xTZh5QZqdxKjMKonBpgCh2
	H5ckpg/KsrhUjjvMKf+1PEoQWIAeDG5WmOMNNsnXvvvdnV9GpR+vuRjp29Kmk1Z3aMzzbk//
	6sK6FyvrTE8Cm483d6rid7q2TdsFO/yPnFCPy0MkYflr3VVtxM3I4Ka+eGQ5Gu2azIvyK81y
	WoZliSXX3eZc229DQnllgiuZLBRGLStuJD7NRKzojzy0v2B4JEAjxVVyWUQYplTJ/gIzik1J
	GQMAAA==
X-CFilter-Loop: Reflected

On Tue, Jun 17, 2025 at 06:09:36PM +0200, David Hildenbrand wrote:
> On 17.06.25 04:31, Harry Yoo wrote:
> > On Fri, Jun 13, 2025 at 07:19:07PM -0700, Mina Almasry wrote:
> > > On Thu, Jun 12, 2025 at 6:13 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > > > > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > > > > What's the intended relation between the types?
> > > > > > 
> > > > > > One thing I'm trying to achieve is to remove pp fields from struct page,
> > > > > > and make network code use struct netmem_desc { pp fields; } instead of
> > > > > > sturc page for that purpose.
> > > > > > 
> > > > > > The reason why I union'ed it with the existing pp fields in struct
> > > > > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > > > > from struct net_iov so as to make the final form like:
> > > > > 
> > > > > I see, I may have mixed up the complaints there. I thought the effort
> > > > > was also about removing the need for the ref count. And Rx is
> > > > > relatively light on use of ref counting.
> > > > > 
> > > > > > > netmem_ref exists to clearly indicate that memory may not be readable.
> > > > > > > Majority of memory we expect to allocate from page pool must be
> > > > > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > > > > memory within the kernel?
> > > > > > > 
> > > > > > > I think you're approaching this problem from the easiest and least
> > > > > > 
> > > > > > No, I've never looked for the easiest way.  My bad if there are a better
> > > > > > way to achieve it.  What would you recommend?
> > > > > 
> > > > > Sorry, I don't mean that the approach you took is the easiest way out.
> > > > > I meant that between Rx and Tx handling Rx is the easier part because
> > > > > we already have the suitable abstraction. It's true that we use more
> > > > > fields in page struct on Rx, but I thought Tx is also more urgent
> > > > > as there are open reports for networking taking references on slab
> > > > > pages.
> > > > > 
> > > > > In any case, please make sure you maintain clear separation between
> > > > > readable and unreadable memory in the code you produce.
> > > > 
> > > > Do you mean the current patches do not?  If yes, please point out one
> > > > as example, which would be helpful to extract action items.
> > > > 
> > > 
> > > I think one thing we could do to improve separation between readable
> > > (pages/netmem_desc) and unreadable (net_iov) is to remove the struct
> > > netmem_desc field inside the net_iov, and instead just duplicate the
> > > pp/pp_ref_count/etc fields. The current code gives off the impression
> > > that net_iov may be a container of netmem_desc which is not really
> > > accurate.
> > > 
> > > But I don't think that's a major blocker. I think maybe the real issue
> > > is that there are no reviews from any mm maintainers?
> > 
> > Let's try changing the subject to draw some attention from MM people :)
> 
> Hi, it worked! :P
> 
> I hope Willy will find his way to this thread as well.
> 
> > 
> > > So I'm not 100%
> > > sure this is in line with their memdesc plans. I think probably
> > > patches 2->8 are generic netmem-ifications that are good to merge
> > > anyway, but I would say patch 1 and 9 need a reviewed by from someone
> > > on the mm side. Just my 2 cents.
> > 
> > As someone who worked on the zpdesc series, I think it is pretty much
> > in line with the memdesc plans.
> > 
> > I mean, it does differ a bit from the initial idea of generalizing it as
> > "bump" allocator, but overall, it's still aligned with the memdesc
> > plans, and looks like a starting point, IMHO.
> 
> Just to summarize (not that there is any misunderstanding), the first
> step of the memdesc plan is simple:
> 
> 1) have a dedicated data-structure we will allocate alter dynamically.
> 
> 2) Make it overlay "struct page" for now in a way that doesn't break things
> 
> 3) Convert all users of "struct page" to the new data-structure
> 
> Later, the memdesc data-structure will then actually come be allocated
> dynamically, so "struct page" content will not apply anymore, and we can
> shrink "struct page".
> 
> 
> What I see in this patch is exactly 1) and 2).
> 
> I am not 100% sure about existing "struct net_iov" and how that
> interacts with "struct page" overlay. I suspects it's just a dynamically
> allocated structure?
> 
> Because this patch changes the layout of "struct net_iov", which is a
> bit confusing at first sight?

The changes of the layout was asked by network folks, that was to split
the struct net_iov fields to two, netmem_desc and net_iov specific ones.

How to organize struct net_iov further is up to the network folks, but
I believe the current layout should be the first step.

	Byungchul

> 
> --
> Cheers,
> 
> David / dhildenb

