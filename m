Return-Path: <bpf+bounces-61648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D87AE965B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9D11C24F99
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD012238141;
	Thu, 26 Jun 2025 06:35:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AE13A3F7;
	Thu, 26 Jun 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919747; cv=none; b=FiksQX2KM3/eq46ruNqmoLvGYdzC6mDUndn166Ts7pKGks9nkYtxaCpAbX4ErXL2G1gPXyt0niHUvmBOseB098NWOupMU6nFwymwHiDwLzbbt6h+HlL6CZkh0zLLLTFC+t8hnJTIF00EqjVDtDvlyzSJwJoP/YnMSaBEAZw9GWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919747; c=relaxed/simple;
	bh=bIsQmeRpiiKYNJTGcMkzw7UBTwvfOSVX5juQTe+krIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwP//mBPs+PrCPYMxh4YOPojB2WJNbB4a3ayZw/jQY67/zqL/X3xpLR+qUbI6VfBC2xfty+rnHSCnrz8YY3sameJHFwnwc9PT5ucoGmHkW6RIvF7FK6CHVTxSmmulscyr6KYLUxW1yqvHaOBx+5pRxh16JOZEfrYwsvNVDK829g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-24-685cea3447ce
Date: Thu, 26 Jun 2025 15:35:27 +0900
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
Message-ID: <20250626063527.GA28653@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com>
 <87o6udfbdz.fsf@toke.dk>
 <77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com>
 <20250625012432.GA74285@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625012432.GA74285@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fec3E6OJ1M3zQoFlJ0s8LyCbpLcCKCrkRa6MhDW6nFpjYD
	wVK6mJpdqW3GLFLTaLZyTrEoNbULXSxjlTdW2V3T5mitWk6J/Pbj//D8f8+Hh6MEGx3GaVJS
	JW2KKknJyLH8a9CFWfM/bVXPybuPwWS5wkDFDz2UdttpMJXbELg8r1n43tjMwMViNwWmxzkY
	Bi0/KXjX5GShwroGukp6MNQdqqbAeayFgfwcLwU3Pb0sFPmKMBywl8ngia2AhlM/L1FQndXN
	wrNaEwOdV3w09NTnY7hnuIyhq2AZNJlDwP3gC4JGS7UM3HlFDJxsNTPwJqcLQWuDE4NxfwEC
	yy0HDd4fQx3Gu53ssgix31jIiA1f+ijxxuWXMrHG0MGKZmuaeL1supjraKVEa/kRRrQOnGDF
	9hd1jNhy1ovFGvt3mZif3cuI/e9eYbHvVhsjWm604bVCrHxRopSkSZe0kUsS5OoBb+ge23L9
	0UvvURbqjsxFARzho0j21fP4H3e4amk/Yz6C5J21UH5m+KnE4fAMczA/jVgPVg4zxR9mibkx
	2M/jeD3xOnuGcwUPpPd0F5uL5JzAd1KkofA4GhmMJffOvcUjyzNJTVU7k4u4IQ4npX+4kXgS
	ya4yDvcE8AuJc/A34+fx/BRy29Ys83cS/iFHnh7OY0eOnkDulDlwIRprGKUwjFIY/isMoxRm
	hMuRoElJT1ZpkqJmqzNSNPrZ23cnW9HQN5Vk/oqzo4EnG+oRzyFlkKLyRZxaoFXpuozkekQ4
	ShmsOBMdqxYUiaqMfZJ2d7w2LUnS1aNwDitDFfPcexMFfocqVdolSXsk7b+pjAsIy0JKfcVC
	V3WbbHHpXuNg72DDFoWr6FtCbFZMRPPkVZ2mGYvdrqMrBTI5JtD6cN3UzA9ptZNaisOXeny+
	1RPtZMYCer3vwTb62rawkI0fA/PbHsU//3x8RUfMhVNb940Jev9It6mjKW3nwK85OdqlgXpy
	IsGzf3PFyaqrryKF1hJDQWa0EuvUqrnTKa1O9ReYZb38SQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTcRTA8X67d/deR4vrMr1lIkzKsocFRSeKWBR0CXqAf1hq1FUvbTin
	bPmKHpbSY06z99qDVlqmCYtVOs0ipmkSmI8aVupklYXIypxDW7V0Evnfh3M4378OhUn0wkWU
	QnWEV6s4pZQQ4aLdm4pWrRtOka9p1a0Ak7WWgPsT+VA1aBeCqaYOgXfyAwljLW0EVNzyYWB6
	XYzDuPUnBp9b3STct+0C190hHJrO1mPgvvCSgNJiPwZPJz0kmANmHE7b7wmg2dwuhM66MiFc
	+XkHg/rCQRJ6Gk0EDNQGhDDkKMWh3VCNg6tMBq2WcPC9GkHQYq0XgE9nJuByt4WAj8UuBN3N
	bhyMp8oQWJ/1CsE/MdUwvhggZUvZUWM5wTaPfMPYR9XvBGyDoZ9kLbYc9uG9OFbb242xtprz
	BGv7cYlk+5xNBPtS78fZBvuYgC0t8hDs6Of3OPvt2VuCrfj6XbB3fpJoczqvVOTy6vgth0Ty
	H/6I7Lqt+SV3vqBCNBivRSEUQ69j+r2Nwmnj9BJGp7di0yboWKa3dzLoMHoZYzvzIGiMPkcy
	lpawac+n8xm/eyg4F9PAeK66SC0SURJ6AGOayy+imUUo037jEz5zvJJpeNxHaBE15Uim6g81
	M45mih4bg50QeiPjHv9NTHsBHcM8r2sTlKN5hlklw6yS4X/JMKtkQXgNClOocjM5hXL9ak2G
	vEClyF+dlpVpQ1P/cvf4r4t25O3Z4UA0haRzxQ+cyXKJkMvVFGQ6EENh0jDxtQ1Jcok4nSs4
	yquzDqpzlLzGgSIpXBoh3pnIH5LQh7kjfAbPZ/Pqf1sBFbKoEIVnuKu65tzkFsSZXd7AQlkX
	zu0/OREVEyCGO2OiFidfz0nNtQ9ttAE37EzgU/eVJFwbXYLifLfSQl0H8gSPfCUKa+htffj1
	aDOVGBUbva3tzTGPNq+Qs8raUvjNlS1PaiPTM1ZKliduH+H2lOk6TJUnarNsizu8vhdJSz1O
	Ka6Rc2vjMLWG+wvyjXrZKwMAAA==
X-CFilter-Loop: Reflected

On Wed, Jun 25, 2025 at 10:24:32AM +0900, Byungchul Park wrote:
> On Tue, Jun 24, 2025 at 04:56:32PM +0200, David Hildenbrand wrote:
> > 
> > On 24.06.25 16:43, Toke Høiland-Jørgensen wrote:
> > > Zi Yan <ziy@nvidia.com> writes:
> > > 
> > > > On 23 Jun 2025, at 10:58, David Hildenbrand wrote:
> > > > 
> > > > > On 23.06.25 13:13, Zi Yan wrote:
> > > > > > On 23 Jun 2025, at 6:16, Byungchul Park wrote:
> > > > > > 
> > > > > > > On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
> > > > > > > > On 20.06.25 06:12, Byungchul Park wrote:
> > > > > > > > > To simplify struct page, the effort to separate its own descriptor from
> > > > > > > > > struct page is required and the work for page pool is on going.
> > > > > > > > > 
> > > > > > > > > To achieve that, all the code should avoid directly accessing page pool
> > > > > > > > > members of struct page.
> > > > > > > > > 
> > > > > > > > > Access ->pp_magic through struct netmem_desc instead of directly
> > > > > > > > > accessing it through struct page in page_pool_page_is_pp().  Plus, move
> > > > > > > > > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> > > > > > > > > without header dependency issue.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > > > > Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > > > > > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > > > > > > > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> > > > > > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > > > > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > > > > > > > > ---
> > > > > > > > >     include/linux/mm.h   | 12 ------------
> > > > > > > > >     include/net/netmem.h | 14 ++++++++++++++
> > > > > > > > >     mm/page_alloc.c      |  1 +
> > > > > > > > >     3 files changed, 15 insertions(+), 12 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > > index 0ef2ba0c667a..0b7f7f998085 100644
> > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > > @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > > > > > >      */
> > > > > > > > >     #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > > > > > > 
> > > > > > > > > -#ifdef CONFIG_PAGE_POOL
> > > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > > -{
> > > > > > > > > -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > > -}
> > > > > > > > > -#else
> > > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > > -{
> > > > > > > > > -     return false;
> > > > > > > > > -}
> > > > > > > > > -#endif
> > > > > > > > > -
> > > > > > > > >     #endif /* _LINUX_MM_H */
> > > > > > > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > > > > > > index d49ed49d250b..3d1b1dfc9ba5 100644
> > > > > > > > > --- a/include/net/netmem.h
> > > > > > > > > +++ b/include/net/netmem.h
> > > > > > > > > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > > > > > > > >      */
> > > > > > > > >     static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > > > > > > > > 
> > > > > > > > > +#ifdef CONFIG_PAGE_POOL
> > > > > > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > > +{
> > > > > > > > > +     struct netmem_desc *desc = (struct netmem_desc *)page;
> > > > > > > > > +
> > > > > > > > > +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > > +}
> > > > > > > > > +#else
> > > > > > > > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > > +{
> > > > > > > > > +     return false;
> > > > > > > > > +}
> > > > > > > > > +#endif
> > > > > > > > 
> > > > > > > > I wonder how helpful this cleanup is long-term.
> > > > > > > > 
> > > > > > > > page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
> > > > > > > 
> > > > > > > Yes.
> > > > > > > 
> > > > > > > > There, we want to make sure that no pagepool page is ever returned to
> > > > > > > > the buddy.
> > > > > > > > 
> > > > > > > > How reasonable is this sanity check to have long-term? Wouldn't we be
> > > > > > > > able to check that on some higher-level freeing path?
> > > > > > > > 
> > > > > > > > The reason I am commenting is that once we decouple "struct page" from
> > > > > > > > "struct netmem_desc", we'd have to lookup here the corresponding "struct
> > > > > > > > netmem_desc".
> > > > > > > > 
> > > > > > > > ... but at that point here (when we free the actual pages), the "struct
> > > > > > > > netmem_desc" would likely already have been freed separately (remember:
> > > > > > > > it will be dynamically allocated).
> > > > > > > > 
> > > > > > > > With that in mind:
> > > > > > > > 
> > > > > > > > 1) Is there a higher level "struct netmem_desc" freeing path where we
> > > > > > > > could check that instead, so we don't have to cast from pages to
> > > > > > > > netmem_desc at all.
> > > > > > > 
> > > > > > > I also thought it's too paranoiac.  However, I thought it's other issue
> > > > > > > than this work.  That's why I left the API as is for now, it can be gone
> > > > > > > once we get convinced the check is unnecessary in deep buddy.  Wrong?
> > > > > > > 
> > > > > > > > 2) How valuable are these sanity checks deep in the buddy?
> > > > > > > 
> > > > > > > That was also what I felt weird on.
> > > > > > 
> > > > > > It seems very useful when I asked last time[1]:
> > > > > > 
> > > > > > |> We have actually used this at Cloudflare to catch some page_pool bugs.
> > > > > 
> > > > > My question is rather, whether there is some higher-level freeing path for netmem_desc where we could check that instead (IOW, earlier).
> > > > > 
> > > > > Or is it really arbitrary put_page() (IOW, we assume that many possible references can be held)?
> > > > 
> > > > +Toke, who I talked about this last time.
> > > > 
> > > > Maybe he can shed some light on it.
> > > 
> > > As others have pointed out, basically, AFAIU: Yes, pages are *supposed*
> > > to go through a common freeing path where this check could reside, but
> > > we've had bugs where they ended up leaking anyway, which is why this
> > > check in MM was added in the first place.
> > 
> > Okay, thanks. If we could be using a page type instead to catch such
> > leaks to the page allocator, we could implement it without any such
> > pp-specific checks.
> > 
> > page types are stored in page->page_type and overlay page->_mapcount
> > right now.
> > 
> > Looking at "struct netmem_desc", page->_mapcount should not be overlayed
> > (good!).
> > 
> > 
> > So, you could be setting the type when creating a "struct netmem_desc"
> > page, and clearing the type when about to free the page. In the buddy,
> > you can then check without any casts from page to whatever else if the
> > type is still unexpectedly set. If still set, you know that there is
> > unexpected freeing.
> 
> Yeah, this is what we all were looking forward to.  However, I decided
> to use the pp field for the checking since it's not ready for now.
> 
> So.. Is the current approach okay *for now*, even though the approach
> should be updated once the type can be checked inside mm later?
> 
> Or do you want me to wait for it to be ready before this netmem work to
> remove the pp fields from struct page?

Just in case you may get it wrong, I'm still waiting for your answer,
even though I've sent v7 with this patch excluded.

To Willy and David,

Is the work to add pp type(or bump) going to be done shortly?  If yes,
I should wait for it.  If no, it'd better use the pp magic field *for
now*.

	Byungchul

> 	Byungchul
> > 
> > I'll note that page types will be a building blocks of memdescs, to
> > descibe "what we are pointing at". See
> > 
> > https://kernelnewbies.org/MatthewWilcox/Memdescs
> > 
> > Willy already planned for a "Bump" type; I assume this would now be
> > "NMDesc" or sth like that IIUC.
> > 
> > --
> > Cheers,
> > 
> > David / dhildenb

