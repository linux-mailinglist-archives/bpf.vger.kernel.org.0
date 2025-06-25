Return-Path: <bpf+bounces-61480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C86AE7447
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 03:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B4E3A7D25
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4211519B4;
	Wed, 25 Jun 2025 01:24:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44428E0F;
	Wed, 25 Jun 2025 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814694; cv=none; b=I5DqSmSTI1x8kMOoNqRMhtB2S5h2aMtR5Y7abxpLhM0uJBBSmIIEYZVIe4CaSvVfXBDaKr5y8mhTiKS25xDGtw/hsr29lGMdGuR9/ISBB7IV6I2gpoayJgGYYxRmgW9p1y3IH2yJzDN4F472TxpweL/y6uQPm7HVGFZp9paOwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814694; c=relaxed/simple;
	bh=IgWAR6wWQkJfcqL5GjHXx9dFxRjsyXPPVE1r4E4h/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teTaH2Z/wdvd+o+XlFA5ux3KTrGVKv4qA6qT12dx/KgHCKhft22h6FmdWjBFq4vUwYn+XTSVg2vbssXiTiUBmJphPhDuepOXi4oTNwUx6N1G8RU+Fb7GJPGPFT08a/klYS747WZFMbauyL/eoPYmZbpQ/xfEpQwxZ311OC8gOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-98-685b4fd64722
Date: Wed, 25 Jun 2025 10:24:32 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Zi Yan <ziy@nvidia.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, jackmanb@google.com,
	"jesper@cloudflare.com" <jesper@cloudflare.com>
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250625012432.GA74285@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com>
 <87o6udfbdz.fsf@toke.dk>
 <77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURiAObtn915Hg9syOykkLKSSshKj1xUREXWIwqCg0B812q2N/Kj5
	0SwjS/OzmVSE7aMmUpmKi2V+lJWZlRKUGtUynaFmRaaZOZrryzkk/z08L+d93h+HZxQ10mBe
	l5gi6hPV8UpWhmVfZ5UuexMTp11RPLEALPYqFip/GuD6+3opWCpqEfzwvONgrOUpC2WlbgYs
	L7IxjNsnGPjwpI+DSsc26L02iKExt46BvrOtLBizvQzc8wxzYP1rxXCqvlwC7bVFUrgwcZWB
	usz3HLy8Y2HBVfVXCoPNRgxtphsYeovWwxNbELifDSFosddJwH3GysL5ThsL/dm9CDof9WEw
	nyxCYL/vlIL35+QO82MXtz6MjpqLWfpoaIShNTfeSmiDqYejNkcqvVUeTgucnQx1VOSz1PH9
	HEe7XzeytLXEi2lD/ZiEGrOGWTr6oQvTkfuvWGqveYW3K2JlazVivC5N1C9ft1em7cptw4e+
	rDF0dI+zmeji0gIUwBMhigy0WtA0Dzf2cgWI57EQRnI81KdZYRFxOj2MjwOFxcSRc3OKGSGP
	I7aWQB/PEQzE2zc45eUCkM6Rs9jHCsHOEKM3xO9nk7ZLA9j/dilpuN3N+lKMEEKu/+H9OpRk
	3TZPrQkQ1hHrWBXr47nCQtJU+1Tiv7KVJx8dKj/PJw/LnbgYzTbNKJhmFEz/C6YZBRvCFUih
	S0xLUOvioyK06Yk6Q8S+pAQHmvxL147/iqtH39t3NCOBR8pZ8hWnY7UKqTotOT2hGRGeUQbK
	L66eVHKNOv2oqE/ao0+NF5ObUQiPlfPkke4jGoVwQJ0iHhTFQ6J+eirhA4IzUV6TujjnuTV1
	b2i/6p3HKMvcdXXrlYe7q6MudwRt2fxt4eoNqqAHYQmbDxs2RAw7I3/HFGmShNc1rq72lBMD
	GTmF3DFN9KdNrtjqDNfGksL0F6WqHoQGLkePVt9Zddd7rGlny4hqv2FL6Oe3lRm/xCi3ELyj
	rHTJy9yeIbP5iDe/QYmTteqV4Yw+Wf0PSkk8mEcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+/adnXO0Fie1+lKhWmQXrEyS3jBECOkjugj9CBTKoYc2mpfO
	zJzdNE3LUrvRZW60kLzTaqZuZhFq3rprhak1sZIg08oL2SpzSuS/h+flfd4/L489Lsu9eU1c
	oijFqbRK1p1x3x6cvur1jkh1gHlUBkZLOQtlP5KhqMcmB2NpFYLhsS4OhhqaWCi4PorB+CyD
	gRHLTwwfG3s5KLNuA0dhHwO1WdUYevOaWcjJcGK4NzbAgWncxMBxW7EM6k0tcnhelSuHiz9v
	YKhO7eGgvcbIwrvycTn01eUw0GIoYcCRGwqN5nkw+qgfQYOlWgajZ0wsXGgzs/A+w4Ggrb6X
	gfy0XASW+x1ycP6YaOQ/fMeF+tFv+WdZWt8/iOmdkjcyaje85ajZeoBWFK+k2R1tmFpLT7HU
	+v08R7tf17K0+YqToXbbkIzmpA+w9NvHToYO3n/F0oJPX2XhnhHuG2NErSZJlNaERLmrO7Na
	mITPwckvukfYVHTJPxu58URYRwZqHVw24nlGWEoyx6hLs8Iy0tExhl3sJSwn1sxbk4yFkxwx
	N3i52FNIJs7evkmvEIC0DeYxLvYQLJjkOH2m/BzScvUDM7XrT+yV3azrFBZ8SNEffkovJOmV
	+ZMZNyGEmIbKWRfPFZaQB1VNsrNotmFayTCtZPhfMkwrmRFTirw0cUmxKo02aLVun1ofp0le
	HR0fa0UT71J45Nc5Gxpu31yHBB4pZykCTkSoPeSqJJ0+tg4RHiu9FJfWTyhFjEqfIkrxe6QD
	WlFXh3x4RjlfsWWXGOUh7FUlivtEMUGU/k1lvJt3Knqc5QgveBsmNUd26p8WQCe+xgUFfrlp
	ly8mSa2+M7Y/7CpsP90UNry4KrC1Elrbn6f52VP0GtvdtMRtm4x9h3ZWSwtuHw6MHjo4smLh
	/tyEHWGLto6rtE8aP62LORqAX86s8T0fJl2I3DDi1I1vDeqPzcLHQsK/RHUdi7r2u2J3g5LR
	qVVrV2JJp/oLwoX+2SoDAAA=
X-CFilter-Loop: Reflected

On Tue, Jun 24, 2025 at 04:56:32PM +0200, David Hildenbrand wrote:
> 
> On 24.06.25 16:43, Toke Høiland-Jørgensen wrote:
> > Zi Yan <ziy@nvidia.com> writes:
> > 
> > > On 23 Jun 2025, at 10:58, David Hildenbrand wrote:
> > > 
> > > > On 23.06.25 13:13, Zi Yan wrote:
> > > > > On 23 Jun 2025, at 6:16, Byungchul Park wrote:
> > > > > 
> > > > > > On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
> > > > > > > On 20.06.25 06:12, Byungchul Park wrote:
> > > > > > > > To simplify struct page, the effort to separate its own descriptor from
> > > > > > > > struct page is required and the work for page pool is on going.
> > > > > > > > 
> > > > > > > > To achieve that, all the code should avoid directly accessing page pool
> > > > > > > > members of struct page.
> > > > > > > > 
> > > > > > > > Access ->pp_magic through struct netmem_desc instead of directly
> > > > > > > > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > > > > > > > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > > > > > > > without header dependency issue.
> > > > > > > > 
> > > > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > > > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > > > > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > > > > > > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> > > > > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > > > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > > > > ---
> > > > > > > >     include/linux/mm.h   | 12 ------------
> > > > > > > >     include/net/netmem.h | 14 ++++++++++++++
> > > > > > > >     mm/page_alloc.c      |  1 +
> > > > > > > >     3 files changed, 15 insertions(+), 12 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > index 0ef2ba0c667a..0b7f7f998085 100644
> > > > > > > > --- a/include/linux/mm.h
> > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > > > > >      */
> > > > > > > >     #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > > > > > 
> > > > > > > > -#ifdef CONFIG_PAGE_POOL
> > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > -{
> > > > > > > > -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > -}
> > > > > > > > -#else
> > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > -{
> > > > > > > > -     return false;
> > > > > > > > -}
> > > > > > > > -#endif
> > > > > > > > -
> > > > > > > >     #endif /* _LINUX_MM_H */
> > > > > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > > > > index d49ed49d250b..3d1b1dfc9ba5 100644
> > > > > > > > --- a/include/net/netmem.h
> > > > > > > > +++ b/include/net/netmem.h
> > > > > > > > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > > > > > > >      */
> > > > > > > >     static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > > > > > > > 
> > > > > > > > +#ifdef CONFIG_PAGE_POOL
> > > > > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > +{
> > > > > > > > +     struct netmem_desc *desc = (struct netmem_desc *)page;
> > > > > > > > +
> > > > > > > > +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > +}
> > > > > > > > +#else
> > > > > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > +{
> > > > > > > > +     return false;
> > > > > > > > +}
> > > > > > > > +#endif
> > > > > > > 
> > > > > > > I wonder how helpful this cleanup is long-term.
> > > > > > > 
> > > > > > > page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
> > > > > > 
> > > > > > Yes.
> > > > > > 
> > > > > > > There, we want to make sure that no pagepool page is ever returned to
> > > > > > > the buddy.
> > > > > > > 
> > > > > > > How reasonable is this sanity check to have long-term? Wouldn't we be
> > > > > > > able to check that on some higher-level freeing path?
> > > > > > > 
> > > > > > > The reason I am commenting is that once we decouple "struct page" from
> > > > > > > "struct netmem_desc", we'd have to lookup here the corresponding "struct
> > > > > > > netmem_desc".
> > > > > > > 
> > > > > > > ... but at that point here (when we free the actual pages), the "struct
> > > > > > > netmem_desc" would likely already have been freed separately (remember:
> > > > > > > it will be dynamically allocated).
> > > > > > > 
> > > > > > > With that in mind:
> > > > > > > 
> > > > > > > 1) Is there a higher level "struct netmem_desc" freeing path where we
> > > > > > > could check that instead, so we don't have to cast from pages to
> > > > > > > netmem_desc at all.
> > > > > > 
> > > > > > I also thought it's too paranoiac.  However, I thought it's other issue
> > > > > > than this work.  That's why I left the API as is for now, it can be gone
> > > > > > once we get convinced the check is unnecessary in deep buddy.  Wrong?
> > > > > > 
> > > > > > > 2) How valuable are these sanity checks deep in the buddy?
> > > > > > 
> > > > > > That was also what I felt weird on.
> > > > > 
> > > > > It seems very useful when I asked last time[1]:
> > > > > 
> > > > > |> We have actually used this at Cloudflare to catch some page_pool bugs.
> > > > 
> > > > My question is rather, whether there is some higher-level freeing path for netmem_desc where we could check that instead (IOW, earlier).
> > > > 
> > > > Or is it really arbitrary put_page() (IOW, we assume that many possible references can be held)?
> > > 
> > > +Toke, who I talked about this last time.
> > > 
> > > Maybe he can shed some light on it.
> > 
> > As others have pointed out, basically, AFAIU: Yes, pages are *supposed*
> > to go through a common freeing path where this check could reside, but
> > we've had bugs where they ended up leaking anyway, which is why this
> > check in MM was added in the first place.
> 
> Okay, thanks. If we could be using a page type instead to catch such
> leaks to the page allocator, we could implement it without any such
> pp-specific checks.
> 
> page types are stored in page->page_type and overlay page->_mapcount
> right now.
> 
> Looking at "struct netmem_desc", page->_mapcount should not be overlayed
> (good!).
> 
> 
> So, you could be setting the type when creating a "struct netmem_desc"
> page, and clearing the type when about to free the page. In the buddy,
> you can then check without any casts from page to whatever else if the
> type is still unexpectedly set. If still set, you know that there is
> unexpected freeing.

Yeah, this is what we all were looking forward to.  However, I decided
to use the pp field for the checking since it's not ready for now.

So.. Is the current approach okay *for now*, even though the approach
should be updated once the type can be checked inside mm later?

Or do you want me to wait for it to be ready before this netmem work to
remove the pp fields from struct page?

	Byungchul
> 
> I'll note that page types will be a building blocks of memdescs, to
> descibe "what we are pointing at". See
> 
> https://kernelnewbies.org/MatthewWilcox/Memdescs
> 
> Willy already planned for a "Bump" type; I assume this would now be
> "NMDesc" or sth like that IIUC.
> 
> --
> Cheers,
> 
> David / dhildenb

