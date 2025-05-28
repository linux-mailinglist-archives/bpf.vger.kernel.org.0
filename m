Return-Path: <bpf+bounces-59139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC470AC642C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172094E2051
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B72686B9;
	Wed, 28 May 2025 08:14:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA00247291;
	Wed, 28 May 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420057; cv=none; b=Kw84M6iSAVLALdQ8KF+Bii5z45670oNKIiHBBO64yWwKKPSP1u1lkljHdc+1aJ4Ov6JFLxZdBrTt28KOgjApipBnBSKMBxAMNGMr2ndM94cLpZ1/SEkBE1KL4524+IxwiOHQfTQeFjIjvclOlydQqPVtX0IPPLm6ItNmlRnaDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420057; c=relaxed/simple;
	bh=vyBcgVOPSrR43OVYlusrL3kuuPXusxiiPudzkAi4juI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsrDdk/OizkNJdz8d0UgVwCPSnEpuissuJSYmRheyJHWl0yDJVK71zqPWGQAOlIF0ouUka2z0pDeyWHc6dWM9mJxMwd9XJVSMLQlmgmTALdubsh7eLro1VheEXTLQwSpJa7ULBQpmUsx7sPF1dolrkQb80kMvEhSF+WLM/fmCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e5-6836c5d07935
Date: Wed, 28 May 2025 17:14:03 +0900
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
Message-ID: <20250528081403.GA28116@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3+7t3daHFbr58JRgsTjJ70ONDDHkQ/iCgQIkqwkZe2mmZb
	2gyKStOyNDWhmqumkjotZsvHNAub5oqCbKUteyjqtEiLtHykWZsS+d+H8z3n+z0cDs8o89k5
	vDbmqKiPUetUnBzLe6fkLXr5eJVm6bdBOZhttzkoGTJCYZuDBXNxBYIfw++k0F/v4iA/d4AB
	84skDD9tvxjwNrRLobWgC0NNSiUD7ZeecJCWNMLAGUeRBBor0lnI/nWLgcpTbVJ4VW3m4OPt
	Pyx0OdMwPDVZMbSmb4AGyywYeNaDoN5WKYGBi9c5uOy2cNCR1IrAXdeOIed0OgLbQw8LI0Nm
	bsM8WmZ9K6FVpg9SarHH0XtFoTTV42aovfg8R+19WVL6vrmGo0+ujmBa5eiX0LTErxz97m3B
	9NvDJo7aypowfW6pl9J+e9BOYY98bZSo08aL+iXr98k15jtZXOxvpTF7bM4p1Dk1Fcl4Iqwg
	r11W7h97U4tZP2MhmNgaSiR+5oQQ4vEMM36eISwkX944palIzjNCD0tsKRXYL0wXDpKLLd3j
	RgoBSG9dE+tvUgoXJCRzzMtMCNPI02ud4wOMz3X0httX530cSArH+InyXJJYnjPeLhPWkVfn
	c8Y9ZwrzSW2FS+L3JEIZT1pdRezE1gHkUZEHZ6BppkkRpkkRpv8RpkkRFoSLkVIbEx+t1upW
	LNYkxGiNi/cfjrYj3+sUnBjd60B9jeFOJPBINUVBS1dqlKw63pAQ7USEZ1QzFGfCVmmUiih1
	wnFRfzhSH6cTDU4UyGPVbMXygWNRSuGA+qh4SBRjRf0/VcLLfLe/8icgXBoacqR2Z3bEl8ZS
	w+7u5PLMNyGbMyKCRwcH31dveRsHWD3cHIu2pZS37Uo7uaXAKrt7f8fWrH13Vt5sXqQ3kuvz
	NiW72j653Xl5HY7pHo8xzBJ/NnHNd+0Dy+eNJ4IWdPetla2LvKzz9lo/5jbVTD0XGnThQctX
	7/YenLtahQ0a9bJQRm9Q/wVeXz2pNgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRSHea97N9x6XVovSheWUlmpQZMDlvUh6V8fKiGQgsihb226zdhM
	NAlNRXE1Sytwc9VCvE1lYV5miNS0qRkkXsrKMqx1wcpK8562GZHfHs7vd54Ph8MQ0jwqgFFp
	U3idVqGW0SJSdDgyZ0fvowhl+PyYHCz2WhpqZtKg8q2DAoutCYPJ2VcCmOjopKHszhQBlqe5
	JPyyzxHgdo0KYKTiAwmt+c0EjF7posGYO09AtqMKh/ab3RT0NhVScH2unIDmrLcC6L9voeFN
	7RIFH5xGErrN1SSMFO4Dl3UNTPV8waDD3ozD1OWbNFzrs9LwLncEg772URJKLxZiYG8bomB+
	xkLvk6GG6hc4ajG/FiBr/Tl0ryoEGYb6CFRvK6BR/c9iARp+1kqjrpJ5ErU4JnBkzPlGox/u
	lyQabxukUdmn7ziyNwyS6Im1Q3DU94RodwKvVqXyurCoOJHSUldMn/0tTbu+GJCFvZcYMCHD
	sbs4t8FGeZlkgzm7qwb3Ms1u5oaGZgkv+7HbuLHnToEBEzEE+4Xi7PlNpDdYzSZyl19+pL0s
	ZoH72j5IeUtS9hLOFS26ib+BL9dter+8QHisC7f6PHPGw4Fc5SLzd7yBy2ksXa4L2T1cf0Hp
	stOf3cQ9aOrEr2IS8wqTeYXJ/N9kXmGyYqQN81NpUzUKlVoeqk9SpmtVaaHxyZp6zPMdFRcW
	ihzYZP8BJ8YymMxHjO7KlVJKkapP1zgxjiFkfuLsvRFKqThBkX6e1yWf0p1T83onFsiQsrXi
	Q7F8nJQ9o0jhk3j+LK/7l+KM0HPY+FXTMRM12QuZxjrH4MH2XvXjwIyen22G4ToCYuCOfOs4
	YW67HRUWtGvcf3tkdFUQycaUw5L1+bobzz6bFuX7xa4uV2WGkU1M0Rxr3BA1sOXIFbfE9A3N
	TRdvjLPqT5cEx0aUCAvHBtb7TJysPE7mJWRGn38osdUdCtdqhCYZqVcqdoYQOr3iDykcY+4Z
	AwAA
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
> On 5/26/25 03:23, Byungchul Park wrote:
> > On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> > > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > 
> > > > To simplify struct page, the effort to seperate its own descriptor from
> > > > struct page is required and the work for page pool is on going.
> > > > 
> > > > To achieve that, all the code should avoid accessing page pool members
> > > > of struct page directly, but use safe APIs for the purpose.
> > > > 
> > > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > > > page_pool_page_is_pp().
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >   include/linux/mm.h   | 5 +----
> > > >   net/core/page_pool.c | 5 +++++
> > > >   2 files changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 8dc012e84033..3f7c80fb73ce 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > >   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > 
> > > >   #ifdef CONFIG_PAGE_POOL
> > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > -{
> > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > -}
> > > 
> > > I vote for keeping this function as-is (do not convert it to netmem),
> > > and instead modify it to access page->netmem_desc->pp_magic.
> > 
> > Once the page pool fields are removed from struct page, struct page will
> > have neither struct netmem_desc nor the fields..
> > 
> > So it's unevitable to cast it to netmem_desc in order to refer to
> > pp_magic.  Again, pp_magic is no longer associated to struct page.
> > 
> > Thoughts?
> 
> Once the indirection / page shrinking is realized, the page is
> supposed to have a type field, isn't it? And all pp_magic trickery
> will be replaced with something like
> 
> page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }

Agree, but we need a temporary solution until then.  I will use the
following way for now:

   https://lore.kernel.org/all/20250528051452.GB59539@system.software.com/

	Byungchul
> 
> 
> -- 
> Pavel Begunkov

