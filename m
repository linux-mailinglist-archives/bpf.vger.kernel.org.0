Return-Path: <bpf+bounces-58934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ADEAC3D8E
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C722B3A4C03
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE811F4C94;
	Mon, 26 May 2025 10:01:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4A14AD2B;
	Mon, 26 May 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253685; cv=none; b=MEYnsWf5iotrbarISJROUsB0JJfwSxUc2AlApjCIqkjAJ1URWJPPMlSEV5eGkeZ53Vigh0P6t8lpX00U8epO0k7dDX64dS5Ag/1lUuUv8ByLDa88vsDoc8R2WfBheEDe6nxoQtEUUvueUPUYG1b16zgQPj0PHBkpETx1SzUX8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253685; c=relaxed/simple;
	bh=7xnBbO9oZrXF/pz7tZt0xLcfgxXrxwyrfMm82fzzaRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCbjRs/DT3HvQYD7PH72TnQJXvHt5pK/6s1l7gVo61dZ96rNg0tokKCVVFXU3rdGxmX5cPcIBnOfQCrvbIKvUxpYrvzbVUL23htHE7fdAdZcopZOJLS/1YTEw7hm1DPRdw/XtTUbcoOaVUzySOdjEx1XIGVa1Fqjc4CcJQAymqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-43-68343beced90
Date: Mon, 26 May 2025 19:01:11 +0900
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
Message-ID: <20250526100111.GA39311@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <20250526023624.GB27145@system.software.com>
 <87o6vfahoh.fsf@toke.dk>
 <20250526094305.GA29080@system.software.com>
 <87ldqjae92.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldqjae92.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zdnYcDo5T868rw3UxhMpK7KVCCjL+9CG6fIiMqJWnNi8z
	NjMXRFajUJxZCdZcOYu8rGC1vEzx1hItLTJDWbPSzAvB7KJl5ro5RfLbj+d9eJ7nw8vRslui
	ME6tSRe0GmWKgpUwklH/Wys9G2NU0Ya6DWC23WPh7mQmlPU7RGC2ViP49rNXDOMtbSzcLpmg
	wfzCwMB32xQNQ60DYugrHWag/mINDQOXnrBgNHhpOOcop6CzOk8EBVN3aKjJ6hfDqzozC+/u
	/RXBsNPIwFNTBQN9eZuh1bIAJjo8CFpsNRRM5N5g4WqXhYUPhj4EXY8HGCg6m4fA1ugSgXfS
	zG6OIJUVrylSa3orJhb7CfKwPIrkuLpoYrdms8Q+dkVM3vTUs+TJNS9Dah3jFDGe/8SSr0Nu
	hnxu7GaJrbKbIc8sLWIybg/fySdINiUKKeoMQbs67pBE9aChGB2/EZ75vv25KAtZQ3KQH4f5
	GDx2P5+a4+JsG+1jhl+GCw1FM8zykdjl+jnNHBfEb8Edk8dykISj+XERto4ZZzyBfBLOdY+w
	PpbygEt62hmfScZ7KNzhaRXPHgLw0+uDjI/p6dBfN7tmQmlejsv+cLPyYny+qmhG9pve8LJ5
	l08O5pfg5uo2yheJeQeHLxT+Fc9uDsWPyl1MPgowzWswzWsw/W8wzWuwIMaKZGpNRqpSnRKz
	SqXXqDNXHUlLtaPpzyk9/Wu/A4117nEinkMKf+khxTqVTKTM0OlTnQhztCJIutAcrZJJE5X6
	U4I27aD2RIqgcyI5xyhCpGsnTibK+GPKdCFZEI4L2rkrxfmFZaGC9cm793rccZ2Ud2jHSoLl
	1uDMhKratojqwsjIGu375VqqKXCF+fWoO/WT29/47ELIvoVefYarLMkzOjIlf6z/feYB/kKP
	lupaDg4u9d/fmSC/3CRfPbjox2TMx7KAm7H347ceiA/fHtTfcCd099HyM9mWXmP3Ng3tjD38
	xTkcp2B0KuWaKFqrU/4DmdcGhTUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z/bzkar4zI7aRid6GKQFRq8oYVR0MEwukEQRK46tKlbuqm4
	oFg6i9TZRaOaMyfm1GWMzHRFxTBTp0W6Lqx10SwrQiuvTNfNKZHffjzPw4/3w0vjslwylFaq
	0wWNWp7CURJCsj0mZ1V/TLRiTbZrBZjttRRc92VBVY+DBLOtAcHI+GsRDDe3UlBRPoaD+amB
	gFH7BA59Lb0i6LZ+IuDe6UYces+2UWA0+HHIdlRj8LDURUJnQyEJxROVODTqe0Tw7K6Zgne1
	f0j41GQkwGWqIaC7MA5aLCEw1tGPoNneiMFYQSkFRW4LBR8M3QjcD3sJKDlZiMD+wEOC32em
	4ji+vuYVxt8xvRXxlroM/lb1Sj7P48b5OtsZiq8buiDi37y8R/Ftl/0Ef8cxjPHGnG8UP9jn
	JfjvD15QfMWXHxhvr39B8I8tzaIdQfsksYeFFGWmoFm9MVGiuHm/DKWWhme9b39C6pFtfh4S
	0ywTzZadseMBJpil7CVDyRRTzHLW4xmfZJoOZjaxHb4jeUhC48wwydqGjFObuUwSW+D9TAVY
	ygBb/rKdCIxkTD/GdvS3iKaLINZ15SMRYHxS+vOqe0qKM2Fs1W96Ol7E5twumYrFkzd0OXcG
	4nnMEtbZ0IqdQ7NNM0SmGSLTf5FphsiCCBsKVqozVXJlyrpIbbJCp1ZmRR46qqpDk89hPf7z
	vAONPNvahBgacbOkiVyUQkbKM7U6VRNiaZwLli40r1HIpIflumOC5ugBTUaKoG1CYTTBzZfG
	7xUSZcwRebqQLAipguZfi9HiUD0qfr4s1+NwstFnrWWWfeF3VRJbxOjEQH1bF7Uhl938I//G
	7ljlrs8FA2hO1LYF68OqRkHUc78zBAZ3mKwR4V7uVHvaV6duoy9h9bVU//lWX3KItWjuvF+4
	8pHYnx9h7FsfG6/fr0sbrN2SkbSh0ntx8UDC0297Kl1xZTHXD9ac4AitQr52Ja7Ryv8C3w2N
	oBgDAAA=
X-CFilter-Loop: Reflected

On Mon, May 26, 2025 at 11:54:33AM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, May 26, 2025 at 10:40:30AM +0200, Toke Høiland-Jørgensen wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Mon, May 26, 2025 at 11:23:07AM +0900, Byungchul Park wrote:
> >> >> On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> >> >> > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> >> >> > >
> >> >> > > To simplify struct page, the effort to seperate its own descriptor from
> >> >> > > struct page is required and the work for page pool is on going.
> >> >> > >
> >> >> > > To achieve that, all the code should avoid accessing page pool members
> >> >> > > of struct page directly, but use safe APIs for the purpose.
> >> >> > >
> >> >> > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> >> >> > > page_pool_page_is_pp().
> >> >> > >
> >> >> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> > > ---
> >> >> > >  include/linux/mm.h   | 5 +----
> >> >> > >  net/core/page_pool.c | 5 +++++
> >> >> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> >> >> > >
> >> >> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> >> > > index 8dc012e84033..3f7c80fb73ce 100644
> >> >> > > --- a/include/linux/mm.h
> >> >> > > +++ b/include/linux/mm.h
> >> >> > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >> >> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >> >> > >
> >> >> > >  #ifdef CONFIG_PAGE_POOL
> >> >> > > -static inline bool page_pool_page_is_pp(struct page *page)
> >> >> > > -{
> >> >> > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> >> >> > > -}
> >> >> > 
> >> >> > I vote for keeping this function as-is (do not convert it to netmem),
> >> >> > and instead modify it to access page->netmem_desc->pp_magic.
> >> >> 
> >> >> Once the page pool fields are removed from struct page, struct page will
> >> >> have neither struct netmem_desc nor the fields..
> >> >> 
> >> >> So it's unevitable to cast it to netmem_desc in order to refer to
> >> >> pp_magic.  Again, pp_magic is no longer associated to struct page.
> >> >
> >> > Options that come across my mind are:
> >> >
> >> >    1. use lru field of struct page instead, with appropriate comment but
> >> >       looks so ugly.
> >> >    2. instead of a full word for the magic, use a bit of flags or use
> >> >       the private field for that purpose.
> >> >    3. do not check magic number for page pool.
> >> >    4. more?
> >> 
> >> I'm not sure I understand Mina's concern about CPU cycles from casting.
> >> The casting is a compile-time thing, which shouldn't affect run-time
> >
> > I didn't mention it but yes.
> >
> >> performance as long as the check is kept as an inline function. So it's
> >> "just" a matter of exposing struct netmem_desc to mm.h so it can use it
> >
> > Then.. we should expose net_iov as well, but I'm afraid it looks weird.
> > Do you think it's okay?
> 
> Well, it'll be ugly, I grant you that :)
> 
> Hmm, so another idea could be to add the pp_magic field to the inner
> union that the lru field is in, and keep the page_pool_page_is_pp()
> as-is. Then add an assert for offsetof(struct page, pp_magic) ==
> offsetof(netmem_desc, pp_magic) on the netmem side, which can be removed
> once the two structs no longer shadow each other?

It would work, but still that's what I wanted to avoid.

To Matthew and mm folks,

Does it look okay?

	Byungchul
> 
> That way you can still get rid of the embedded page_pool struct in
> struct page, and the pp_magic field will just be a transition thing
> until things are completely separated...
> 
> -Toke

