Return-Path: <bpf+bounces-54430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3CBA69E67
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 03:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2EF7AD651
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD11EBFED;
	Thu, 20 Mar 2025 02:41:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 54BFB1EB1AB
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742438475; cv=none; b=qJfs7t97nR1CaKOCH7j4pB8ommNNf48HeqDCsINKg0mAvUvTbP3kaEt51NIBqDj6OYQZ5VzM6TUv9OS5ZiAi1f430svyNQvd2EgF9wxIx5DpdjUmiBIcKERS+JHrdyz4tJ4PHNk5zhrB1rWYhRBe9Ei0sadqZQXWurZ0Q3ajOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742438475; c=relaxed/simple;
	bh=Ov12BHgQtJeYkVfTeLe4KkA/+7bFWMw8jGFJAJXzl3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjaYD/dTOu4BkMTrk2qXlzBE8yHB6A/4pvQ+xvcXkapYCMJVaFodb/NeN/IrfTz+fOUfZwphOspqBGhFu86VcFsajKSJs4vQxb+123g8Vgn8Krmw9BeYZ1L8pZ45jM9QUM29ei8dpRSXmKp53gKkFyyw0+D9kzkKq8rTz8g5SnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openwall.com; spf=pass smtp.mailfrom=openwall.com; arc=none smtp.client-ip=193.110.157.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openwall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openwall.com
Received: (qmail 5897 invoked from network); 20 Mar 2025 02:34:28 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 20 Mar 2025 02:34:28 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
	id E98CBA064E; Thu, 20 Mar 2025 03:32:02 +0100 (CET)
Date: Thu, 20 Mar 2025 03:32:02 +0100
From: Solar Designer <solar@openwall.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Yunsheng Lin <yunshenglin0825@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mina Almasry <almasrymina@google.com>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>,
	segoon@openwall.com, oss-security@lists.openwall.com,
	kernel-hardening@lists.openwall.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>,
	sultan@kerneltoast.com
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap them when destroying the pool
Message-ID: <20250320023202.GA25514@openwall.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com> <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com> <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk> <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk> <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Mar 19, 2025 at 07:06:57PM +0800, Yunsheng Lin wrote:
> On 2025/3/19 4:55, Toke Høiland-Jørgensen wrote:
> > Yunsheng Lin <linyunsheng@huawei.com> writes:
> >> On 2025/3/17 23:16, Toke Høiland-Jørgensen wrote:
> >>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
> >>>> On 3/14/2025 6:10 PM, Toke Høiland-Jørgensen wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>> To avoid having to walk the entire xarray on unmap to find the page
> >>>>> reference, we stash the ID assigned by xa_alloc() into the page
> >>>>> structure itself, using the upper bits of the pp_magic field. This
> >>>>> requires a couple of defines to avoid conflicting with the
> >>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
> >>>>> so does not affect run-time performance. The bitmap calculations in this
> >>>>> patch gives the following number of bits for different architectures:
> >>>>>
> >>>>> - 24 bits on 32-bit architectures
> >>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
> >>>>> - 32 bits on other 64-bit architectures
> >>>>
> >>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
> >>>> "The page->signature field is aliased to page->lru.next and
> >>>> page->compound_head, but it can't be set by mistake because the
> >>>> signature value is a bad pointer, and can't trigger a false positive
> >>>> in PageTail() because the last bit is 0."
> >>>>
> >>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2} 
> >>>> offset"):
> >>>> "Poison pointer values should be small enough to find a room in
> >>>> non-mmap'able/hardly-mmap'able space."
> >>>>
> >>>> So the question seems to be:
> >>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
> >>>>     easier-mmap'able space? If yes, how can we make sure this will not
> >>>>     cause any security problem?
> >>>> 2. Is the masking the page->pp_magic causing a valid pionter for
> >>>>     page->lru.next or page->compound_head to be treated as a vaild
> >>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
> >>>>     allocated via page_pool.
> >>>
> >>> Right, so my reasoning for why the defines in this patch works for this
> >>> is as follows: in both cases we need to make sure that the ID stashed in
> >>> that field never looks like a valid kernel pointer. For 64-bit arches
> >>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
> >>> writing to any bits that overlap with the illegal value (so that the
> >>> PP_SIGNATURE written to the field keeps it as an illegal pointer value).
> >>> For 32-bit arches, we make sure of this by making sure the top-most bit
> >>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
> >>> which puts it outside the range used for kernel pointers (AFAICT).
> >>
> >> Is there any season you think only kernel pointer is relevant here?
> > 
> > Yes. Any pointer stored in the same space as pp_magic by other users of
> > the page will be kernel pointers (as they come from page->lru.next). The
> > goal of PP_SIGNATURE is to be able to distinguish pages allocated by
> > page_pool, so we don't accidentally recycle a page from somewhere else.
> > That's the goal of the check in page_pool_page_is_pp():
> > 
> > (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE
> > 
> > To achieve this, we must ensure that the check above never returns true
> > for any value another page user could have written into the same field
> > (i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA
> 
> POISON_POINTER_DELTA is defined according to CONFIG_ILLEGAL_POINTER_VALUE,
> if CONFIG_ILLEGAL_POINTER_VALUE is not defined yet, POISON_POINTER_DELTA
> is defined to zero.
> 
> It seems only the below 64-bit arches define CONFIG_ILLEGAL_POINTER_VALUE
> through grepping:
> a29815a333c6 core, x86: make LIST_POISON less deadly
> 5c178472af24 riscv: define ILLEGAL_POINTER_VALUE for 64bit
> f6853eb561fb powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
> bf0c4e047324 arm64: kconfig: Move LIST_POISON to a safe value
> 
> The below 64-bit arches don't seems to define the above config yet:
> MIPS64, SPARC64, System z(S390X),loongarch
> 
> Does ID stashing cause problem for the above arches?
> 
> > serves this purpose. For 32-bit arches, we can leave the top-most bits
> > out of PP_MAGIC_MASK, to make sure that any valid pointer value will
> > fail the check above.
> 
> The above mainly explained how to ensure page_pool_page_is_pp() will
> not return false positive result from the page_pool perspective.
> 
> From MM/security perspective, most of the commits quoted above seem
> to suggest that poison pointer should be in the non-mmap'able or
> hardly-mmap'able space, otherwise userspace can arrange for those
> pointers to actually be dereferencable, potentially turning an oops
> to an expolit, more detailed example in the below paper, which explains
> how to exploit a vulnerability which hardened by the 8a5e5e02fc83 commit:
> https://www.usenix.org/system/files/conference/woot15/woot15-paper-xu.pdf
> 
> ID stashing seems to cause page->lru.next (aliased to page->pp_magic) to
> be in the mmap'able space for some arches.

...

> To be honest, I am not that familiar with the pointer poison mechanism.
> But through some researching and analyzing, it makes sense to overstate
> it a little as it seems to be security-related.
> Cc'ed some security-related experts and ML to see if there is some
> clarifying from them.

You're correct that the pointer poison values should be in areas not
mmap'able by userspace (at least with reasonable mmap_min_addr values).

Looking at the union inside "struct page", I see pp_magic is aliased
against multiple pointers in the union'ed anonymous structs.

I'm not familiar with the uses of page->pp_magic and how likely or not
we are to have a bug where its aliasing with pointers would be exposed
as an attack vector, but this does look like a serious security concern.
It looks like we would be seriously weakening the poisoning, except on
archs where the new values with ID stashing are still not mmap'able.

I just discussed the matter with my colleague at CIQ, Sultan Alsawaf,
and he thinks the added risk is not that bad.  He wrote:

> Toke's response here is fair:
> 
> > Right, okay, I see what you mean. So the risk is basically the
> > following:
> > 
> > If some other part of the kernel ends up dereferencing the
> > page->lru.next pointer of a page that is owned by page_pool, and which
> > has an ID stashed into page->pp_magic, that dereference can end up being
> > to a valid userspace mapping, which can lead to Bad Things(tm), cf the
> > paper above.
> > 
> > This is mitigated by the fact that it can only happen on architectures
> > that don't set ILLEGAL_POINTER_VALUE (which includes 32-bit arches, and
> > the ones you listed above). In addition, this has to happen while the
> > page is owned by page_pool, and while it is DMA-mapped - we already
> > clear the pp_magic field when releasing the page from page_pool.
> > 
> > I am not sure to what extent the above is a risk we should take pains to
> > avoid, TBH. It seems to me that for this to become a real problem, lots
> > of other things will already have gone wrong. But happy to defer to the
> > mm/security folks here.
> 
> For this to be a problem, there already needs to be a use-after-free on
> a page, which arguably creates many other vectors for attack.
> 
> The lru field of struct page is already used as a generic list pointer
> in several places in the kernel once ownership of the page is obtained.
> Any risk of dereferencing lru.next in a use-after-free scenario would
> technically apply to a bunch of other places in the kernel (grep for
> page->lru).

We also tried searching for existing exploitation techniques for "struct
page" use-after-free.  We couldn't find any.  The closest (non-)match I
found is this fine research (the same project presented differently):

https://i.blackhat.com/BH-US-24/Presentations/US24-Qian-PageJack-A-Powerful-Exploit-Technique-With-Page-Level-UAF-Thursday.pdf page 33+
https://arxiv.org/html/2401.17618v2#S4
https://phrack.org/issues/71/13

The arxiv paper includes this sentence: "To create a page-level UAF, the
key is to cause a UAF of the struct page objects."  However, we do not
see them actually do that, and this statement is not found in the slides
nor in the Phrack article.  Confused.

Thank you for CC'ing me and the kernel-hardening list.  However, please
do not CC the oss-security list like that, where it's against content
guidelines.  Only properly focused new postings/threads are acceptable
there (not CC'ing from/to other lists where only part of the content is
on-topic, and follow-ups might not be on-topic at all).  See:

https://oss-security.openwall.org/wiki/mailing-lists/oss-security#list-content-guidelines

As a moderator for oss-security, I'm going to remove these messages from
the queue now.  Please drop Cc: oss-security from any further replies.

If desired, we may bring these topics to oss-security separately, with a
proper Subject line and clear description of what we're talking about.

Alexander

