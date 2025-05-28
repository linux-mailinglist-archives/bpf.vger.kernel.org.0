Return-Path: <bpf+bounces-59146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A25AC6572
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948AB1888156
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA22750FB;
	Wed, 28 May 2025 09:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9E20CCD0;
	Wed, 28 May 2025 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423670; cv=none; b=ie3tIrygHEdL/4yoV4D+omHGARXVjmuXL/6yRpebnrRcdQROM75tTXO0Usp3wyuVxGK6fcE03aiSHYK7itKwAP2dautu0G6vYsksFuQSpiVxbRF3snACbiYyWPwb48EyigeMHxQpOs/96L1bmyUmJJ7mK0lImOYJjMMqZxyDZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423670; c=relaxed/simple;
	bh=zyvjLg/hY8UCWc5yJms8u/bhLNJ5o5BQnWkTrB0wzlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfy6GTm65cNrZZeTu4M1qXWJdMMy2K6D5YM0qsNwjh+fks60ZvWUMXStzCLqAFfQF/4szck/47M4VRu/KOV7DHTIuf+Z3xqyow3T8QF+RnXSo9Eknwytvb81ROPkrldRQhmqVO2oLgoxuWBLt82+Jcv5E8joHn2E0N4ukKanuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-71-6836d3edca26
Date: Wed, 28 May 2025 18:14:16 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 12/18] page_pool: use netmem APIs to access
 page->pp_magic in page_pool_page_is_pp()
Message-ID: <20250528091416.GA54984@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
 <20250528081403.GA28116@system.software.com>
 <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRDH83W3u0ulca2oH1RRildQ8YiSeUAl8vL5YGJijMG7ymqrXCmH
	YELkDGAACWqCpZgSBLGS1NTaghKPioDxIkWloAIBQVGQyBWQyxYk8vbLzH/mNw/DUbISsRen
	jogRNBHKMAUjoSV97sWb+hoDVFs+3gLQGSsYuDsaD7fbK8WgM1gQDI19YmGwpo6BkuIRCnTv
	0mgYNv6hoKu2g4W2sm4aqjOsFHRcqWcgJ22cgpTKchE0WHLFcO1PKQXWpHYWGh/qGGitmBZD
	ty2HhpfaOzS05QZBrX4pjLzqRVBjtIpgJLuIgat2PQOdaW0I7M87aChMzkVgfOwQw/iojgny
	IeY7zSJSpf3CEr0pltwv9yOXHXaKmAxZDDEN5LPk88dqhtQXjNOkqnJQRHJSfzHkd1cLTfof
	f2CI0fyBJq/1NSwZNHnv5w9LAkOFMHWcoNm866RE1V9fx0Zdlce35b9BSajL4zJy4zC/HTus
	r9EcT02WsS6m+TW4WWuiXczw67DDMUa52IPfgH822ZwZCUfxvWJszLDMhBbz53B2yzfGxVIe
	cG3Ze5ErJOP7RDi5MP1fYxF+eePrzADl3Dpx0+7cyjlZjm9PcbPllTj1QeGMzI3fiXsmhsQu
	XsL74qeWOtHsoWYOP8qSzrInflbuoPPQIu08g3aeQfvfoJ1n0CPagGTqiLhwpTpsu78qIUId
	7386MtyEnK9TljhxpBINNBywIZ5DCncpubdDJRMr46ITwm0Ic5TCQ5qyO0Alk4YqEy4KmsgT
	mtgwIdqG5BytWCbdNnIhVMafVcYI5wUhStDMdUWcm1cS8gq3q/L2fF9Vs7xn78F99xuHCzJ9
	ltYXxtrk6zMNrwKC7a2TZ594nnlr3Hg0sujQ2KnjDWyidONaWr7aN8ZwqaR3gWOt58KowA2n
	OGv1ihCPQPNJ9z2Z09dDzN13j8ssqQHHvD+r6krzzcExVRfzmnL6O9t3mV74/AhJHz6vLnW0
	EgUdrVJu9aM00cq/tzO2DTYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH9/09dzp+ncNv9Ye5mKdVGrWPkfzFdzbGHx7mYRz91l0q3FXK
	ZjsVrfREbPw6HObSYWdX6lhrdj0Pk8vDKTpKySqFaj3nLkz/vfZ5vz+vzz8fjlRk0P6cNj5B
	1MWrY1WMjJJtW5cW1NsUrlklFS8Go/U+A/eGk6Hok50Go6UMwcBICwu/qusYuH1ziATjy3QK
	Bq2jJHTUtrHgNndSUJFRTkJbXj0DOeljJKTa7xJQda2BhsayXBoujd4hodzwiYWmJ0YGWu9P
	0dDpyKGgQSqmwJ27EWpN82HoWQ+Cams5AUPZ1xgocJoYaE93I3BWtVFQeCYXgbXSRcPYsJHZ
	qMKlxe8J/Fj6yGKTLRGX3F2Bs1xOEtssmQy2/bzI4g9vKxhcf2WMwo/tvwick/adwT86minc
	V/mGwbe7+glsLX1D4eemana7317Z+igxVpsk6kI2HJJp+urr2OMFAcnuiy+QAXUos5APJ/Br
	hMkJM+tlil8ivJdslJcZfqngco2QXlbyK4Xudw5PR8aRfA8tWDPKpktz+Rghu/kr42U5D0Kt
	+TXhLSn4XkI4U3j2b+AnNFz9Mr1Aeqzj150eK+fhAKFokvszXiikPSqcPubDRwjfxgdoL8/j
	A4WnZXVEPpotzTBJM0zSf5M0w2RClAUptfFJcWptbFiw/qgmJV6bHHzkWJwNed7DfHr8gh0N
	NG12IJ5DKl85fhimUdDqJH1KnAMJHKlSylMjwzUKeZQ65ZSoO3ZQlxgr6h0ogKNUC+RbdouH
	FHy0OkE8KorHRd2/lOB8/A1oB+UMeR2haL+Vv2sixrC6u29rjzGwJszv3DCdGbo8z1wkxa13
	mZJ1kZpNs1r6oxNPcMsCEwxRa+salR8O+I4sku+2X36VtWOOJa+LbGqdyK55UfJgi292UcHJ
	qiN5lj07gyr6DdC1H7mnzreG3NjXMBxwPZwV/QcPxwRRkZ8vm1SUXqMOXUHq9Orf/1LMbxoD
	AAA=
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
> On 5/28/25 09:14, Byungchul Park wrote:
> > On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
> > > On 5/26/25 03:23, Byungchul Park wrote:
> > > > On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> > > > > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > > > 
> > > > > > To simplify struct page, the effort to seperate its own descriptor from
> > > > > > struct page is required and the work for page pool is on going.
> > > > > > 
> > > > > > To achieve that, all the code should avoid accessing page pool members
> > > > > > of struct page directly, but use safe APIs for the purpose.
> > > > > > 
> > > > > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > > > > > page_pool_page_is_pp().
> > > > > > 
> > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > ---
> > > > > >    include/linux/mm.h   | 5 +----
> > > > > >    net/core/page_pool.c | 5 +++++
> > > > > >    2 files changed, 6 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > index 8dc012e84033..3f7c80fb73ce 100644
> > > > > > --- a/include/linux/mm.h
> > > > > > +++ b/include/linux/mm.h
> > > > > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > > >    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > > > 
> > > > > >    #ifdef CONFIG_PAGE_POOL
> > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > -{
> > > > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > -}
> > > > > 
> > > > > I vote for keeping this function as-is (do not convert it to netmem),
> > > > > and instead modify it to access page->netmem_desc->pp_magic.
> > > > 
> > > > Once the page pool fields are removed from struct page, struct page will
> > > > have neither struct netmem_desc nor the fields..
> > > > 
> > > > So it's unevitable to cast it to netmem_desc in order to refer to
> > > > pp_magic.  Again, pp_magic is no longer associated to struct page.
> > > > 
> > > > Thoughts?
> > > 
> > > Once the indirection / page shrinking is realized, the page is
> > > supposed to have a type field, isn't it? And all pp_magic trickery
> > > will be replaced with something like
> > > 
> > > page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
> > 
> > Agree, but we need a temporary solution until then.  I will use the
> > following way for now:
> 
> The question is what is the problem that you need another temporary
> solution? If, for example, we go the placeholder way, page_pool_page_is_pp()

I prefer using the place-holder, but Matthew does not.  I explained it:

   https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/

Now, I'm going with the same way as the other approaches e.g. ptdesc.

	Byungchul

> can continue using page->netmem_desc->pp_magic as before, and mm folks
> will fix it up to page->type when it's time for that. And the compiler
> will help by failing compilation if forgotten. You should be able to do
> the same with the overlay option.
> 
> And, AFAIU, they want to remove/move the lru field in the same way?
> In which case we'll get the same problem and need to re-alias it to
> something else.
> 
> -- 
> Pavel Begunkov

