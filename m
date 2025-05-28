Return-Path: <bpf+bounces-59167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF871AC679B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36414A21F03
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FC27B505;
	Wed, 28 May 2025 10:44:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A59B27A139;
	Wed, 28 May 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429093; cv=none; b=Wh+dSU0Mr031tl8Hu4b3CL6xOaBhg6FqJbt4ZJgmH1p8JQv//pIMiG29O2sJnbJTVUY7AAaZPScsoby4tzJizpXr5B2nu2M+nkMl6IXzrEMaPAAq2LRDshDuaTT9SqrGtbxSl2X2YySsA8FP23hacIJnz/Y+qrwBJVqxns7F9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429093; c=relaxed/simple;
	bh=dg5mHjTNFjh5HufNfUkk+9xtn8O5Kt5adGbR0I182mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXhDOjo2R/hM9JE4RjDR4oAENvvtb70WFxH9T869N/DLWL0fUhqC1+ClvqW4nVvdNSXzC2vRnD8QU0uuixreWxZLvKlAg6Si0UeCyfsa/o51AkYBOpylNVL7H3uunzYeuotWqOQSo/OsNeSnhpdE5wZuQARZ/wpy7o349Q1Kj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-12-6836e91d5aa2
Date: Wed, 28 May 2025 19:44:40 +0900
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
Message-ID: <20250528104440.GA13050@system.software.com>
References: <20250523032609.16334-13-byungchul@sk.com>
 <CAHS8izN6QAcAr-qkFSYAy0JaTU+hdM56r-ug-AWDGGqLvHkNuQ@mail.gmail.com>
 <20250526022307.GA27145@system.software.com>
 <a4ff25cb-e31f-4ed7-a3b9-867b861b17bd@gmail.com>
 <20250528081403.GA28116@system.software.com>
 <06fca2f8-39f6-4abb-8e0d-bef373d9be0f@gmail.com>
 <20250528091416.GA54984@system.software.com>
 <b7efa56b-e9fd-4ca6-9ecf-0d5f15b8d0c1@gmail.com>
 <20250528093303.GB54984@system.software.com>
 <5494b37d-1af0-488e-904b-2d3cbd0e7dcf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5494b37d-1af0-488e-904b-2d3cbd0e7dcf@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2emd6aVxktduErc6oJLXIPmxD0a441xjQ9GTdAGRlstYIog
	IBoEjBELbiRiLVhRERBSU6UsqUYrIkbjUkUrLhhU1OAKWkUUpSVG3r7858/5zsOReE2BYqBk
	iNkqm2J0Ri1WCaoPQQXjB72bpp/0+dB4sNpLMZz9kQhnXlQqwFriRPC1/YkIbTXXMZw84ePB
	eidDgG/2nzy8rm0SobGwWQDXngoemvbXYcjK6OAhrbKIg7vObAXk/DzNQ0XqCxHuV1sxPC/9
	o4Bmd5YANyzFAjRmz4VaW3/w3XyPoMZewYHPnIfhsMeG4WVGIwLP1SYBju3KRmC/5FVAxw8r
	njuMXSh+zLEqyzOR2Rzx7HzRWJbp9fDMUbIXM0frIZE9fejCrC63Q2BVlW0cy0r/iNmX1w0C
	+3SpHjP7hXqB3bLViKzNMXg5WaOaGSUbDQmyaeLs9Sq9q/wI2nIxLDGn+i1ORfmDMpFSoiSc
	mluOiJlICrA3ba0/FshImtuex/sZkzDq9bYHuC8ZR1seubvqKokn7xXUvscp+Ad9yCZqbniD
	/awmQFtqSzg/a8hugZrNS7vzYHrj6KtAn+9a+ivfw/u9PAmlZzql7ngITS8/FnApySya/r0z
	sKYfGU4vO69zfi8lLon6PB/47vsH0CtFXuEACrb0UFh6KCz/FZYeChsSSpDGEJMQrTMYwyfo
	k2IMiRMiY6MdqOtzCnf8WluJWu+udCMiIW2Qmp2bqtcodAlxSdFuRCVe21edNmeaXqOO0iUl
	y6bYdaZ4oxznRqGSoA1RT/Fti9KQjbqt8mZZ3iKb/k05STkwFa2KvTY4JGle/sIIY8po3/JT
	D3ZGXFXnPMFQSMpIxA7j8VHlM28rmz/FhxbX1oeEF3C5znup23NSNu7nIldvqHNd/mPEQcsW
	Vo1Q9m4YE70g+LdryfTti8OS3QdxMrevkG5u86SElYlpIZrJ1Xm92iObp6yMXdHaOZ+JO4ct
	GjpDqxXi9LrJY3lTnO4vwi9NpjUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec85OzuuFsdl9ZJoMQkh8xKYPNHND4FvSdIHIyrCRh7cSqds
	KRoEXpPEaaZpzWkrzdSEhek2r9g0zS4kM2vdtOxqmWUX71rOiPz24/9/+P2/PBwtyxCt5lTq
	E4JGrYiWsxJGErYlzddjKEgZMNuEwWCqYeH6RCJce2UVgaHajODn5HMx/OjoYqHs8hgNhofp
	DPwyTdHwrnNQDAMV7xlozrTQMJh7hwVd+jQNqdZKCtpLukXQY84RQcHUVRosya/E0NtoYKG/
	5rcI3tt0DHTrqxgYyAmGTuNKGLs3jKDDZKFgLLuEhXy7kYU36QMI7O2DDBSn5CAwtTpEMD1h
	YIPlpK7qKUUa9C/FxFgbT25WridZDjtNaqvPsKT2+zkxefG4mSV3LkwzpMH6gyK6tBGWjL57
	xpCvrX0sKfv4jSKmuj6G3Dd2iPe6HpRsjRSiVQmCxn/7EYmyub4IxbV4JxY0fmSTUalHFuI4
	zAdiR+qhLOTCMfw6fGGyhHYyy3tjh2Nygd14H/z5iU2chSQczQ+LsCnTzDiL5fwxnP3sA+tk
	KQ/4c2c15WQZn8Hg7Oywv7kr7r74duGenpfOlNpp5y7Nu+Nrc9zfeA1Oqy9e2HLht+G08bkF
	zQreC7eZu6izaJl+kUm/yKT/b9IvMhkRU43cVOqEGIUqepOf9rgySa1K9DsaG1OL5p+j4tRM
	nhX97A2xIZ5D8qVScmOTUiZSJGiTYmwIc7TcTZq6I0gpk0Yqkk4KmtgITXy0oLUhd46Rr5Lu
	3i8ckfFRihPCcUGIEzT/WopzWZ2MvDWXfEOu4Kjz4Xz+wZChpliLcbz/cOGQjg3YF38rVLIk
	ojjCc+190jDY4z+3y2fn7ddFSasCDnz6Hu63ufzR6SrfoZ7coC95LftHvfz7H4QWXppta21f
	Yg07nRI8Uj4zfrc4PtBaFZGZYgk077WukKkfbaA8Ayuu7gnvq/zg4b3DLme0SsXG9bRGq/gD
	47EkOBgDAAA=
X-CFilter-Loop: Reflected

On Wed, May 28, 2025 at 10:51:29AM +0100, Pavel Begunkov wrote:
> On 5/28/25 10:33, Byungchul Park wrote:
> > On Wed, May 28, 2025 at 10:20:29AM +0100, Pavel Begunkov wrote:
> > > On 5/28/25 10:14, Byungchul Park wrote:
> > > > On Wed, May 28, 2025 at 10:07:52AM +0100, Pavel Begunkov wrote:
> > > > > On 5/28/25 09:14, Byungchul Park wrote:
> > > > > > On Wed, May 28, 2025 at 08:51:47AM +0100, Pavel Begunkov wrote:
> > > > > > > On 5/26/25 03:23, Byungchul Park wrote:
> > > > > > > > On Fri, May 23, 2025 at 10:21:17AM -0700, Mina Almasry wrote:
> > > > > > > > > On Thu, May 22, 2025 at 8:26 PM Byungchul Park <byungchul@sk.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > To simplify struct page, the effort to seperate its own descriptor from
> > > > > > > > > > struct page is required and the work for page pool is on going.
> > > > > > > > > > 
> > > > > > > > > > To achieve that, all the code should avoid accessing page pool members
> > > > > > > > > > of struct page directly, but use safe APIs for the purpose.
> > > > > > > > > > 
> > > > > > > > > > Use netmem_is_pp() instead of directly accessing page->pp_magic in
> > > > > > > > > > page_pool_page_is_pp().
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > > > > > > > ---
> > > > > > > > > >      include/linux/mm.h   | 5 +----
> > > > > > > > > >      net/core/page_pool.c | 5 +++++
> > > > > > > > > >      2 files changed, 6 insertions(+), 4 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > > > > > index 8dc012e84033..3f7c80fb73ce 100644
> > > > > > > > > > --- a/include/linux/mm.h
> > > > > > > > > > +++ b/include/linux/mm.h
> > > > > > > > > > @@ -4312,10 +4312,7 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> > > > > > > > > >      #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > > > > > > > > > 
> > > > > > > > > >      #ifdef CONFIG_PAGE_POOL
> > > > > > > > > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > > > > > > > > -{
> > > > > > > > > > -       return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > > > > > > > > -}
> > > > > > > > > 
> > > > > > > > > I vote for keeping this function as-is (do not convert it to netmem),
> > > > > > > > > and instead modify it to access page->netmem_desc->pp_magic.
> > > > > > > > 
> > > > > > > > Once the page pool fields are removed from struct page, struct page will
> > > > > > > > have neither struct netmem_desc nor the fields..
> > > > > > > > 
> > > > > > > > So it's unevitable to cast it to netmem_desc in order to refer to
> > > > > > > > pp_magic.  Again, pp_magic is no longer associated to struct page.
> > > > > > > > 
> > > > > > > > Thoughts?
> > > > > > > 
> > > > > > > Once the indirection / page shrinking is realized, the page is
> > > > > > > supposed to have a type field, isn't it? And all pp_magic trickery
> > > > > > > will be replaced with something like
> > > > > > > 
> > > > > > > page_pool_page_is_pp() { return page->type == PAGE_TYPE_PP; }
> > > > > > 
> > > > > > Agree, but we need a temporary solution until then.  I will use the
> > > > > > following way for now:
> > > > > 
> > > > > The question is what is the problem that you need another temporary
> > > > > solution? If, for example, we go the placeholder way, page_pool_page_is_pp()
> > > > 
> > > > I prefer using the place-holder, but Matthew does not.  I explained it:
> > > > 
> > > >      https://lore.kernel.org/all/20250528013145.GB2986@system.software.com/
> > > > 
> > > > Now, I'm going with the same way as the other approaches e.g. ptdesc.
> > > 
> > > Sure, but that doesn't change my point
> > 
> > What's your point?  The other appoaches do not use place-holders.  I
> > don't get your point.
> > 
> > As I told you, I will introduce a new struct, netmem_desc, instead of
> > struct_group_tagged() on struct net_iov, and modify the static assert on
> > the offsets to keep the important fields between struct page and
> > netmem_desc.
> > 
> > Then, is that following your point?  Or could you explain your point in
> > more detail?  Did you say other points than these?
> 
> Then please read the message again first. I was replying to th
> aliasing with "lru", and even at the place you cut the message it
> says "for example", which was followed by "You should be able to
> do the same with the overlay option.".

With struct_group_tagged() on struct net_iov, no idea about how to.
However, it's doable with a new separate struct, struct netmem_desc.

I will.

	Byungchul
> 
> You can still continue to use pp_magic placed in the netmem_desc
> until mm gets rid of it in favour of page->type. I hear that you're
> saying it's temporary, but it's messy and there is nothing more
> persistent than a "temporary solution", who knows where the final
> conversion is going to happen.
> 
> -- 
> Pavel Begunkov
> 

