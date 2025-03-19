Return-Path: <bpf+bounces-54369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E296A68B20
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F343167F1E
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C982571AB;
	Wed, 19 Mar 2025 11:07:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB582254B0A;
	Wed, 19 Mar 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382429; cv=none; b=pgu8xBuSmF2REb/fvne7qlT9EFT/hkfd8gmwPdgLMkZfUC5fnf977zBFRcSQRAgnLEuj1qmXaltSvsT0I0WqJ8oK++IbRgmKQ6xeMw7VMk1ZYBRaX6jz3ziHNPTGmFB2Zb3u0lj3NETJ41sPCYdlhF+b9MQEB38Qs9CqoksJlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382429; c=relaxed/simple;
	bh=uk6sv1Pw3BLBBGqjIqGPQ4yzGT4R7eLdgEn/GG6R3Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oIP6wxcLhQ6V+k0bElC4AvLcfZPEHgdTILU3dM2xJq2R5r+5vzV/PdhPnLPkC/xcLhnBrX/zyp0ecPKRcwFQDHW+9jVsqb5jp772jXrUIe1ZBHPRGJxhv8W3o13J2Q/a2Zpom8LOyGA93KwDzoDoh9vu/kF+qAQwbbCXZqEnUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZHm620lK9zCsGW;
	Wed, 19 Mar 2025 19:03:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AFCC1800CD;
	Wed, 19 Mar 2025 19:06:58 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 19:06:57 +0800
Message-ID: <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
Date: Wed, 19 Mar 2025 19:06:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>, Yonglong
 Liu <liuyonglong@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	IOMMU <iommu@lists.linux.dev>, <segoon@openwall.com>, <solar@openwall.com>,
	<oss-security@lists.openwall.com>, <kernel-hardening@lists.openwall.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87wmcmhxdz.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/19 4:55, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>> On 2025/3/17 23:16, Toke Høiland-Jørgensen wrote:
>>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>>>
>>>> On 3/14/2025 6:10 PM, Toke Høiland-Jørgensen wrote:
>>>>
>>>> ...
>>>>
>>>>>
>>>>> To avoid having to walk the entire xarray on unmap to find the page
>>>>> reference, we stash the ID assigned by xa_alloc() into the page
>>>>> structure itself, using the upper bits of the pp_magic field. This
>>>>> requires a couple of defines to avoid conflicting with the
>>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>>>>> so does not affect run-time performance. The bitmap calculations in this
>>>>> patch gives the following number of bits for different architectures:
>>>>>
>>>>> - 24 bits on 32-bit architectures
>>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>>>>> - 32 bits on other 64-bit architectures
>>>>
>>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>>>> "The page->signature field is aliased to page->lru.next and
>>>> page->compound_head, but it can't be set by mistake because the
>>>> signature value is a bad pointer, and can't trigger a false positive
>>>> in PageTail() because the last bit is 0."
>>>>
>>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2} 
>>>> offset"):
>>>> "Poison pointer values should be small enough to find a room in
>>>> non-mmap'able/hardly-mmap'able space."
>>>>
>>>> So the question seems to be:
>>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>>>>     easier-mmap'able space? If yes, how can we make sure this will not
>>>>     cause any security problem?
>>>> 2. Is the masking the page->pp_magic causing a valid pionter for
>>>>     page->lru.next or page->compound_head to be treated as a vaild
>>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>>>>     allocated via page_pool.
>>>
>>> Right, so my reasoning for why the defines in this patch works for this
>>> is as follows: in both cases we need to make sure that the ID stashed in
>>> that field never looks like a valid kernel pointer. For 64-bit arches
>>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
>>> writing to any bits that overlap with the illegal value (so that the
>>> PP_SIGNATURE written to the field keeps it as an illegal pointer value).
>>> For 32-bit arches, we make sure of this by making sure the top-most bit
>>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
>>> which puts it outside the range used for kernel pointers (AFAICT).
>>
>> Is there any season you think only kernel pointer is relevant here?
> 
> Yes. Any pointer stored in the same space as pp_magic by other users of
> the page will be kernel pointers (as they come from page->lru.next). The
> goal of PP_SIGNATURE is to be able to distinguish pages allocated by
> page_pool, so we don't accidentally recycle a page from somewhere else.
> That's the goal of the check in page_pool_page_is_pp():
> 
> (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE
> 
> To achieve this, we must ensure that the check above never returns true
> for any value another page user could have written into the same field
> (i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA

POISON_POINTER_DELTA is defined according to CONFIG_ILLEGAL_POINTER_VALUE,
if CONFIG_ILLEGAL_POINTER_VALUE is not defined yet, POISON_POINTER_DELTA
is defined to zero.

It seems only the below 64-bit arches define CONFIG_ILLEGAL_POINTER_VALUE
through grepping:
a29815a333c6 core, x86: make LIST_POISON less deadly
5c178472af24 riscv: define ILLEGAL_POINTER_VALUE for 64bit
f6853eb561fb powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
bf0c4e047324 arm64: kconfig: Move LIST_POISON to a safe value

The below 64-bit arches don't seems to define the above config yet:
MIPS64, SPARC64, System z(S390X),loongarch

Does ID stashing cause problem for the above arches?

> serves this purpose. For 32-bit arches, we can leave the top-most bits
> out of PP_MAGIC_MASK, to make sure that any valid pointer value will
> fail the check above.

The above mainly explained how to ensure page_pool_page_is_pp() will
not return false positive result from the page_pool perspective.

From MM/security perspective, most of the commits quoted above seem
to suggest that poison pointer should be in the non-mmap'able or
hardly-mmap'able space, otherwise userspace can arrange for those
pointers to actually be dereferencable, potentially turning an oops
to an expolit, more detailed example in the below paper, which explains
how to exploit a vulnerability which hardened by the 8a5e5e02fc83 commit:
https://www.usenix.org/system/files/conference/woot15/woot15-paper-xu.pdf

ID stashing seems to cause page->lru.next (aliased to page->pp_magic) to
be in the mmap'able space for some arches.


> 
>> It seems it is not really only about kernel pointers as round_hint_to_min()
>> in mm/mmap.c suggests and the commit log in the above commit 8a5e5e02fc83
>> if I understand it correctly:
>> "Given unprivileged users cannot mmap anything below mmap_min_addr, it
>> should be safe to use poison pointers lower than mmap_min_addr."
>>
>> And the above "making sure the top-most bit is always 0" doesn't seems to
>> ensure page->signature to be outside the range used for kernel pointers
>> for 32-bit arches with VMSPLIT_1G defined, see arch/arm/Kconfig, there
>> is a similar config for x86 too:

...

> 
> Ah, interesting, didn't know this was configurable. Okay, so AFAICT, the
> lowest value of PAGE_OFFSET is 0x40000000 (for VMSPLIT_1G), so we need
> to leave two bits off at the top instead of just one. Will update this,
> and try to explain the logic better in the comment.

It seems there was attempt of doing 4G/4G split too, and that is the kind
of limitation or complexity added to the ARCH and MM subsystem by doing the
ID stashing I mentioned earlier.
https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain/

> 
>> IMHO, even if some trick like above is really feasible, it may be
>> adding some limitation or complexity to the ARCH and MM subsystem, for
>> example, stashing the ID in page->signature may cause 0x*40 signature
>> to be unusable for other poison pointer purpose, it makes more sense to
>> make it obvious by doing the above trick in some MM header file like
>> poison.h instead of in the page_pool subsystem.
> 
> AFAIU, PP_SIGNATURE is used for page_pool to be able to distinguish its
> own pages from those allocated elsewhere (cf the description above).
> Which means that these definitions are logically page_pool-internal, and
> thus it makes the most sense to keep them in the page pool headers. The
> only bits the mm subsystem cares about in that field are the bottom two
> (for pfmemalloc pages and compound pages).

All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
still want to proceed with reusing the page->pp_magic as the masking and
the signature to be masked seems reasonable to be in the same file.

> 
>>>>> Since all the tracking is performed on DMA map/unmap, no additional code
>>>>> is needed in the fast path, meaning the performance overhead of this
>>>>> tracking is negligible. A micro-benchmark shows that the total overhead
>>>>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
>>>>> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
>>>>> map and unmap, it seems like an acceptable cost to fix the late unmap
>>>>
>>>> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
>>>> DMA map and unmap operation is almost negligible as said below, so the
>>>> cost is about 200% performance degradation, which doesn't seems like an
>>>> acceptable cost.
>>>
>>> I disagree. This only impacts the slow path, as long as pages are
>>> recycled there is no additional cost. While your patch series has
>>> demonstrated that it is *possible* to reduce the cost even in the slow
>>> path, I don't think the complexity cost of this is worth it.
>>
>> It is still the datapath otherwise there isn't a specific testing
>> for that use case, more than 200% performance degradation is too much
>> IHMO.
> 
> Do you have a real-world use case (i.e., a networking benchmark, not a
> micro-benchmark of the allocation function) where this change has a
> measurable impact on performance? If so, please do share the numbers!

I don't have one yet.

> 
> I very much doubt it will be anything close to that magnitude, but I'm
> always willing to be persuaded by data :)
> 
>> Let aside the above severe performance degradation, reusing space in
>> page->signature seems to be a tradeoff between adding complexity in
>> page_pool subsystem and in VM/ARCH subsystem as mentioned above.
> 
> I think you are overstating the impact on other MM users; this is all
> mostly page_pool-internal logic, cf the explanation above.

To be honest, I am not that familiar with the pointer poison mechanism.
But through some researching and analyzing, it makes sense to overstate
it a little as it seems to be security-related.
Cc'ed some security-related experts and ML to see if there is some
clarifying from them.

> 
>>>
>>> [...]
>>>
>>>>> The extra memory needed to track the pages is neatly encapsulated inside
>>>>> xarray, which uses the 'struct xa_node' structure to track items. This
>>>>> structure is 576 bytes long, with slots for 64 items, meaning that a
>>>>> full node occurs only 9 bytes of overhead per slot it tracks (in
>>>>> practice, it probably won't be this efficient, but in any case it should
>>>>
>>>> Is there any debug infrastructure to know if it is not this efficient?
>>>> as there may be 576 byte overhead for a page for the worst case.
>>>
>>> There's an XA_DEBUG define which enables some dump functions, but I
>>> don't think there's any API to inspect the memory usage. I guess you
>>> could attach a BPF program and walk the structure, or something?
>>>
>>
>> It seems the XA_DEBUG is not defined in production environment.
>> And I am not familiar enough with BPF program to understand if the
>> BPF way is feasiable in production environment.
>> Any example for the above BPF program and how to attach it?
> 
> Hmm, no, not really, sorry :(
> 
> I *think* it should be possible to write a bpftrace script that walks
> the internal xarray tree and counts the nodes along the way, but it's
> not trivial to do, and I haven't tried.
> 
> -Toke
> 
> 

