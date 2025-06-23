Return-Path: <bpf+bounces-61274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EBAE3BFE
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D277F3A48B2
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F1239E8A;
	Mon, 23 Jun 2025 10:16:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961243594B;
	Mon, 23 Jun 2025 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673795; cv=none; b=DeBbIz9oa8/ljEwYMGjajIC1P7bZuVN1jOw3WQvTJlGpuwxOTWVPrR9h9WwBbCZxCJraNiJzY/RTUW1vviCuVxMhs828t9JpWm/7oe3W6uMr+9fWqEkGkza2x6EqrW+7Bkw7G2h6JdPau/9udtqjeOi8CYFPgebmhOdr/3BqIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673795; c=relaxed/simple;
	bh=4hlRXYti4Od8c6oYubkTk0N9zQ1yF2SNKRST9MEGxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPD0sy+8qTkjceCZt3DwWuRlL5vc+VffbnneFkthpDI13fjF4mUsWxyiL6bRRorksGebM8qT8hiZ4D0Du2uaVvwFSyOkHR8Zvl3wMiRWPHUp5UduLvyI6KVQqQOnIsAuxJJFnyfAv3BG4jvujV1qHV9n/WZDUh0drozvYISaLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6b-6859297b1aaf
Date: Mon, 23 Jun 2025 19:16:22 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250623101622.GB3199@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe3fOzjkOR8d1e7vXVEwtu0n9P4REEL1BRRREF6RGntpouphl
	UwosJUmahl2dK5Zhs2lMZs7NMnRqWiqFXVhqaqsMyzStpLXItknktx/P8/L83g9/jpJViudw
	qpRjgjZFoZYzElryJbR42cnoPcoVl99yYLSWM1D2UwfmPocYjBY7gu/eLha+NTYzcOvmGAXG
	p9k0/LD+ouDDIw8LZbat0Hu7n4YHOdUUePJbGNBn+yio9Q6xcMZRKoJn9jwxXPpVQkF1Zh8L
	z2uMDPSUj4uh36Wn4bHhDg29eevhkWkmjLUOImi0Votg7Px1Bi52mBh4l92LoKPBQ0PR6TwE
	1oduMfh++jeKmnrY9RGkYXCYIvfuvBYRp+ENS0y246SyNIbkujsoYrOcY4httIAl3a8eMKTl
	mo8mTsc3EdFnDTFk5EMnTYYfvmSI9d5LmrSZGtntYXsl65IEtSpN0C5POCBRFjh72aP3F+jq
	zPVUJirEuSiEw3w8bjb+YP5xVbuZCjDNR+Kyto/BnOGjsNvtDebT+SXYdrbCzxKO4m8w2HSp
	O1hM43XY5+kPspRfiwsG8sWBRzL+CsJtBQ40UYThx4Xv6QBT/FLsrOr2Gzg/z8XmP9xEvBBn
	VRUFd0L4BDx0a4AN8Aw+HNfZm0WBTcy3cNic2S6a+PVsXF/qpi+gMMMkhWGSwvBfYZikMCHa
	gmSqlLRkhUodH6dMT1Hp4g5qkm3If0q3T/3e50Cjz3a6EM8heaj0QOhupUysSEtNT3YhzFHy
	6VLXhl1KmTRJkZ4haDX7tcfVQqoLzeVo+SzpqrETSTL+sOKYcEQQjgraf62IC5mTicrWLcp4
	4cuL+DiuLv+UE9W20ZjlzS/Ub/paEx1acb2rtuLQ4OfY1kQF++nKeeF3cfzI5oTVrXKwkIXz
	ntj6lqyKWfyusi48d3Rek73bW1NrSbTr73o0ziLpmqThquUe0fCmc/fnaxKvxprCI1aUl5Ts
	2DagiYyf2tiZM0U3viWLkdOpSsXKGEqbqvgLvm7RmEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzjmOJqd56U3DYNFFKUsoeqASiaCXbvQlrQhy6KHNO5tT
	l0SmkmXeUhs5XSysvBWL5WWWhW6WSkqlWGbmxNIuhJWaqYtqUyK//fj///yeLw9Hya6I/ThV
	QrKgTlDEyRkJLTm0I2tTeuAx5ZY7bSFQYb7NQN1sGlSNWMVQUduIYHruDQtT7R0MVF6foaDi
	WTYNP8zzFIw9GWWhznIQHLfGaWjJaaJgtLCTgfxsJwUP5yZYyLRWi8Bu7BLD88YCMZTO36Sg
	KWOEhb77FQwM3/4jhnFbPg1dhhoaHAVh8MTkCzNPvyBoNzeJYCbPyEBJr4mBd9kOBL32URrK
	zxUgMD8aEINz1uUofzzMhq0l9i9fKVJf81pEmg1vWWKyaMm96iCSO9BLEUvtRYZYJotZMvSy
	hSGdV500abZOiUh+1gRDvo8N0uTro36GVH78JiLm+n76sOy4ZGe0EKdKEdSbQyMlyuJmB5v0
	ICCttaqNykBlOBd5cJjfiht6qig30/xaXNf9gXEzw6/HAwNzC7k3vwFbzt91sYSj+GsMNpUO
	LRRefBp2jo4vsJTfjos/FYrdIxmvR7i72IoWi+W4q+w97WaK34ibG4ZcFzgX++Oq39xivBpn
	NZQveDz4UDxR+Yl1sw+/Brc2doiKkKdhicmwxGT4bzIsMZkQXYu8VQkp8QpV3LZgTaxSl6BK
	C45KjLcg17PcOvPrshVN9+21IZ5D8mXS6v1HlTKxIkWji7chzFFyb6ltd7hSJo1W6E4L6sST
	am2coLEhf46Wr5DuixAiZfwpRbIQKwhJgvpfK+I8/DJQTqRZE74utatvpZO07LniyJzXrThw
	dqe+Z6+oJVVrPzwYMmjct+rSpO82Y/YJX72/OmVNTaen/GDw/KuYG7TWHlqUfCFQ4lduaTO1
	fg60Gr1P2b06dqXn5Z1W5kfOpvro6xOdfkUquzaqMjwkJqJX/4K36ErenQw4clfCeXz8Kac1
	SkVIEKXWKP4CP4WDFSgDAAA=
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
> On 20.06.25 06:12, Byungchul Park wrote:
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
> >   include/linux/mm.h   | 12 ------------
> >   include/net/netmem.h | 14 ++++++++++++++
> >   mm/page_alloc.c      |  1 +
> >   3 files changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0ef2ba0c667a..0b7f7f998085 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> >    */
> >   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > 
> > -#ifdef CONFIG_PAGE_POOL
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -     return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > -}
> > -#else
> > -static inline bool page_pool_page_is_pp(struct page *page)
> > -{
> > -     return false;
> > -}
> > -#endif
> > -
> >   #endif /* _LINUX_MM_H */
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index d49ed49d250b..3d1b1dfc9ba5 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> >    */
> >   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> > 
> > +#ifdef CONFIG_PAGE_POOL
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +     struct netmem_desc *desc = (struct netmem_desc *)page;
> > +
> > +     return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > +}
> > +#else
> > +static inline bool page_pool_page_is_pp(struct page *page)
> > +{
> > +     return false;
> > +}
> > +#endif
> 
> I wonder how helpful this cleanup is long-term.
> 
> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?

Yes.

> There, we want to make sure that no pagepool page is ever returned to
> the buddy.
> 
> How reasonable is this sanity check to have long-term? Wouldn't we be
> able to check that on some higher-level freeing path?
> 
> The reason I am commenting is that once we decouple "struct page" from
> "struct netmem_desc", we'd have to lookup here the corresponding "struct
> netmem_desc".
> 
> ... but at that point here (when we free the actual pages), the "struct
> netmem_desc" would likely already have been freed separately (remember:
> it will be dynamically allocated).
> 
> With that in mind:
> 
> 1) Is there a higher level "struct netmem_desc" freeing path where we
> could check that instead, so we don't have to cast from pages to
> netmem_desc at all.

I also thought it's too paranoiac.  However, I thought it's other issue
than this work.  That's why I left the API as is for now, it can be gone
once we get convinced the check is unnecessary in deep buddy.  Wrong?

> 2) How valuable are these sanity checks deep in the buddy?

That was also what I felt weird on.

	Byungchul

> --
> Cheers,
> 
> David / dhildenb

