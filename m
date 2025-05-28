Return-Path: <bpf+bounces-59140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34AAC6436
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441A33B72B6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C93253F39;
	Wed, 28 May 2025 08:15:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492B213253;
	Wed, 28 May 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420150; cv=none; b=qESdBs2dAyvpWkEYS2vll8ovQhXifYDTIs+41pAn4RTNYPYPhy64wytfZj6wjfYXgGHuNQrnsyoXNcTR+sEDpRsnGzZ9xIMfZmman7TZ11wiyLtSEVCyK4YQJOuA03XIeSgBxJNK8fnH2TIg1dQjWEyw4kDspG/hQgEi4tGsKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420150; c=relaxed/simple;
	bh=I92/m063vrwtrEq8+KAWK3SpIzJrOw6l+0LO4duztWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izst7nBg7a4BP/VpdC9hqZ6XcYtdYAdovw8/q3eF2n+vDsaVGzZtfrJN7EFEaMZuwu29wyYuDD7IMX3RwVX2aaAp9Exy5PU5KSxIwh2y0pO6RtmS9+4xqqydmsFzD+wcR1k0odF1OEZvB+7n9yQiPvH6F1pLZkqLqiaioU0qTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4c-6836c63082fb
Date: Wed, 28 May 2025 17:15:39 +0900
From: Byungchul Park <byungchul@sk.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, tariqt@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250528081539.GB28116@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
 <87o6vfahoh.fsf@toke.dk>
 <20250526094305.GA29080@system.software.com>
 <87ldqjae92.fsf@toke.dk>
 <20250528051452.GB59539@system.software.com>
 <87sekpmbmg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sekpmbmg.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe3fenR2Xg+PSelXSWmUkpBYVfylSP0hvH4KoICihhju0lU7Z
	1FSozKRoNQuNqDljFqUuZbFMV6nlJS8UKJa2zJxpWkFZXpmXLk6J/Pbw+z88z/PhzzHyInEA
	p9GmCDqtMkHBSrH0u3fRxoimbeqI8w0KMNvKWLjvTofiPocYzNZKBONT7yUw1tjMwp2iSQbM
	bTkYJmzTDAw29UvAdW8IQ/WFKgb6r7SwYMyZYSDbUSKC9spcMVybvstAVVafBF4/MbPQW/ZH
	DEP1RgytplIMrtxoaLIsh8mX3xA02qpEMHm5kIX8DgsLAzkuBB0N/RgKzuYisNU6xTDjNrPR
	q2lF6TsRfWz6IKEWeyp9WBJKDc4OhtqtF1lqH82T0J6uapa23JjB9LFjTESN54ZZOjLYjemP
	2k6W2io6MX1laZTQMXvQXv6QdIdKSNCkCbrwnUel6ilnjzj5fUh6Rek4k4UGVhqQF0f4LaSv
	9CYyIG5el4yc9GDMryPG4l8ij2b59cTpnGI8Fl8+hrx0HzMgKcfwY2JiHTUyHs8y/ji53P2Z
	9WgZD6TuTZXEY5LzlQzJv/EVLxx8SOvNT/OamQudvdUxH8rwgaT4N7eAg8m5RwXz2GtuQ9uP
	DA/249eQ55XNIk8k4R0ccT/Lxgvz/UldiRNfRT6mRQ2mRQ2m/w2mRQ0WhK1IrtGmJSo1CVvC
	1BlaTXpYfFKiHc09zr1Ts4cdaLR9fz3iOaTwltEHW9VysTJNn5FYjwjHKHxl2VHb1HKZSpmR
	KeiSjuhSEwR9PQrksGKFbPPkSZWcP6ZMEU4IQrKg+3cVcV4BWUiGbq8M/hj7wvb2tP+wpqam
	+Lq50NVVO3CwfHvcEiEmM/JXX+edwQjNl0B9yMNgHBYVP+TKIpegu/fKrqU7NrSU0/3b97x6
	1nzGFZMTGKkNUu3DbYNbVS2dQVGrgj9/SNlt9ePPP/3pjos40zgdMB2bGbt2ycSB8F3Dhryg
	a3bbWgXWq5WbQhmdXvkXND3YEjQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5/bjqvVcVkdtKhOZCSkBhlvWmqf+hMV0oeEQnLlwS2nxaam
	QWUqaMNpZoTNFSuvM2Fl5maYmC4vmRlbxlLTsOwiUXnFWxdnRH57eJ4fP94PL0vKM2lvVpWQ
	KGoSFGqBkVLSQyEZ2wJbdioDnT9WgNFSxcDdqRQof2ejwVhZi2B8ulcCY/ZWBopvT5Jg7Mqk
	YMIyQ8JQy6AEBso+UlCfZSVhMK+NAX3mLAnptgoCmm+20/CyNpeGazOlJFjT3knA+cjIQH/V
	bxo+NukpaDeYKRjIDYcW02qY7PiKwG6xEjCZc5OBAoeJgfeZAwgczYMUFF3KRWBpcNEwO2Vk
	wgVcY35D4DrDWwk2VSfhBxV+WOdykLi68jKDq0evSnDf63oGtxXOUrjONkZgfcY3Bo8M9VD4
	e0M3g4s//yCwpaabws9NdkmE51Hp7hhRrUoWNQGh0VLltKuPPtPrm1JjHifT0Pt1OsSyPLeD
	rxg5q0MeLMVt5vXlPwl3ZrgtvMs1TboRL24v3zEVq0NSluTGaL5yVE+6mZXcKT6n5xPjzjIO
	+CevrBI3JOdqSb6g8Av1d/Dk2298WMjkvHTulmNBSnI+fPkv9m+9ns94WLRQe8zf0PU91V2v
	4jbxjbWtxBW03LBIZFgkMvwXGRaJTIiqRF6qhOR4hUod5K+NU6YmqFL8T56Or0bzv1F2fi7f
	hsad+5oQxyJhmQzfC1LKaUWyNjW+CfEsKXjJ0sN2KuWyGEXqOVFz+rgmSS1qm5APSwlrZPsj
	xWg5F6tIFONE8Yyo+bcSrId3GmLOBVv4D/ZuX+HA2pJvF9bpnhZdu1GycTidSiwYOWJ2bkhe
	n5gSnHGnM9vWmWVPUp8QYlcfK+xPi7N4DU+ZYettZ1ZkXViHrzX3S1ThzJ6LSxz3x69nNx7O
	Whs8E7A3Kjr2UESIXqoS7EsPDpfOvSBsfXmyidDH4r38Qfxsl0wvUFqlYrsfqdEq/gAGYQaT
	FwMAAA==
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 09:35:03AM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, May 26, 2025 at 11:54:33AM +0200, Toke Høiland-Jørgensen wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Mon, May 26, 2025 at 10:40:30AM +0200, Toke Høiland-Jørgensen wrote:
> >> >> Byungchul Park <byungchul@sk.com> writes:
> >> >> 
> >> >> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
> >> >> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> >> >> >> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >> >> >> > >
> >> >> >> > > To simplify struct page, the effort to seperate its own descriptor from
> >> >> >> > > struct page is required and the work for page pool is on going.
> >> >> >> > >
> >> >> >> > > To achieve that, all the code should avoid accessing page pool members
> >> >> >> > > of struct page directly, but use safe APIs for the purpose.
> >> >> >> > >
> >> >> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> >> >> >> > > page_pool_page_is_pp().
> >> >> >> > >
> >> >> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> >> > > ---
> >> >> >> > >  include/linux/mm.h   | 5 +----
> >> >> >> > >  net/core/page_pool.c | 5 +++++
> >> >> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> >> >> >> > >
> >> >> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> >> >> > > index 8dc012e84033..3f7c80fb73ce 100644
> >> >> >> > > --- a/include/linux/mm.h
> >> >> >> > > +++ b/include/linux/mm.h
> >> >> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >> >> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >> >> >> > >
> >> >> >> > >  #ifdef CONFIG_PAGE_POOL
> >> >> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
> >> >> >> > > -{
> >> >> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >> >> >> > > -}
> >> >> >> > 
> >> >> >> > I vote for keeping this function as-is (do not convert it to netmem),
> >> >> >> > and instead modify it to access page->netmem_desc->pp_magic.
> >> >> >> 
> >> >> >> Once the page pool fields are removed from struct page, struct page will
> >> >> >> have neither struct netmem_desc nor the fields..
> >> >> >> 
> >> >> >> So it's unevitable to cast it to netmem_desc in order to refer to
> >> >> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
> >> >> >
> >> >> > Options that come across my mind are:
> >> >> >
> >> >> >    1. use lru field of struct page instead, with appropriate comment but
> >> >> >       looks so ugly.
> >> >> >    2. instead of a full word for the magic, use a bit of flags or use
> >> >> >       the private field for that purpose.
> >> >> >    3. do not check magic number for page pool.
> >> >> >    4. more?
> >> >> 
> >> >> I'm not sure I understand Mina's concern about CPU cycles from casting.
> >> >> The casting is a compile-time thing, which shouldn't affect run-time
> >> >
> >> > I didn't mention it but yes.
> >> >
> >> >> performance as long as the check is kept as an inline function. So it's
> >> >> "just" a matter of exposing struct netmem_desc to mm.h so it can use it
> >> >
> >> > Then.. we should expose net_iov as well, but I'm afraid it looks weird.
> >> > Do you think it's okay?
> >> 
> >> Well, it'll be ugly, I grant you that :)
> >> 
> >> Hmm, so another idea could be to add the pp_magic field to the inner
> >> union that the lru field is in, and keep the page_pool_page_is_pp()
> >> as-is. Then add an assert for offsetof(struct page, pp_magic) ==
> >> offsetof(netmem_desc, pp_magic) on the netmem side, which can be removed
> >> once the two structs no longer shadow each other?
> >> 
> >> That way you can still get rid of the embedded page_pool struct in
> >> struct page, and the pp_magic field will just be a transition thing
> >> until things are completely separated...
> >
> > Or what about to do that as mm folks did in page_is_pfmemalloc()?
> >
> > static inline bool page_pool_page_is_pp(struct page *page)
> > {
> > 	/*
> > 	 * XXX: The space of page->lru.next is used as pp_magic in
> > 	 * struct netmem_desc overlaying on struct page temporarily.
> > 	 * This API will be unneeded shortly.  Let's use the ugly but
> > 	 * temporal way to access pp_magic until struct netmem_desc has
> > 	 * its own instance.
> > 	 */
> >         return (((unsigned long)page->lru.next) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > }
> 
> Sure, that can work as a temporary solution (maybe with a static assert
> somewhere that pp_magic and lru have the same offsetof())?

Sure.  I will do that as I posted in the cover letter:

   https://lore.kernel.org/all/20250528022911.73453-1-byungchul@sk.com/

	Byungchul
> 
> -Toke

