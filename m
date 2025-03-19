Return-Path: <bpf+bounces-54370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E901A68C9E
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15315423CCD
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1D255E54;
	Wed, 19 Mar 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZfohkow"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D28255E26
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386733; cv=none; b=rmtPyUIwmd7YTOcYt+rggkYIV+FeNKF1/ucAsBCCGCSsz5Z60WngaJn7vErIg0ss7URmUU5LLA0jd8828jQgodbqNlF1+6IMUKB3YlbTeHwg5Hws90tfzFyCt9qHwuzGEDT2YtDoLzw90cnFNsGXs90ONLnt3i2DaauU6xhR6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386733; c=relaxed/simple;
	bh=KYPJ5Nm5CiOpKZSaHN1aE1WNqtcEvX3sSRLdvIfud/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lfzz/G6t4TmwJExs52GFcVRua4xM4sllp3qS2n1QjA7ltV4MQRZECEMbdmW1EIuIBWeKK/IzPtBN0WuUZJ7gh9y++2zy7CVBsGRDzcETOCRW4MyfS3ouyzwM7wZpfvEuUf5+ONsbPIwd1kqmC2K14SsDGeKNY1JebRjoYElRisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZfohkow; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742386730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHAuof8mNqwebJdSvdzZnag+45htJDLXlVltgIFNUY8=;
	b=WZfohkowvLY9AbyAcmVgGnga3uX4abb0vCPx3ZHcxmjE/lhasckEIW/TpjeluLRYOOgj2I
	LVXqngaWtgYGTvXSQmRjC6KPdiyaZMcip28+AwVOqdZ3r2eTDjyj65Xv3mo19f0Ggopt8s
	8d4mktzdAY07KNTRpZ+GePSWhzqaHvQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-tnqwPx4wM4SyKOJK9wOj9Q-1; Wed, 19 Mar 2025 08:18:45 -0400
X-MC-Unique: tnqwPx4wM4SyKOJK9wOj9Q-1
X-Mimecast-MFC-AGG-ID: tnqwPx4wM4SyKOJK9wOj9Q_1742386724
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-54991197341so3337202e87.2
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 05:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386724; x=1742991524;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHAuof8mNqwebJdSvdzZnag+45htJDLXlVltgIFNUY8=;
        b=Eds1oQMdG6kcXQPb3i4q4Enb/aTfncD261FJx9Qw699RxNGcxbU2csu1IKH/hR1uB7
         wvDWAsibnsXtth3IJE6m9RIz+lU7WUqQLzlHSXKIhv5ZqsQblM4eGK4nlwwY4TWgB8ax
         qWQQzyalJhZDxbeXQMaYqIUlj4qZ9zvfeQ65KifoCWRcHLhAEvC0wTBnPcrsR1ioJyMd
         7PgbzcVqjGM8qfkIlX3bhEZFpTZuD2rRLaa2z7SHplNfjyjLtbF3Qj8W9V5+0T4y/X83
         1PqMPw5Mj17T+2RXiTX+2MIdulYT0ry5J1ASP6FCeNq122drinC7sh3+WUzGtEeT71/t
         GoYA==
X-Forwarded-Encrypted: i=1; AJvYcCVbS63BWEXGuR1+tCC4eIu0QFH8VWV76YvAMtm92/AUQvBtT1vmE6uxXnmH3yJlNxJFNs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8cGl8Cfau6ZPgZbs/rx5eImcR4vybEpBFIQzkc2Zo7sYWrSQM
	s+f6AvoYGD/g7nEIWfxxhsNo4vYcNqSGsDcv7sGJJKXLUOU1WZFzp7t9dQdkEfIqbF1if5yX+dY
	x6TjQhwPH6HR3Go26qUFzMiHcasMwPeumfaRNF9Md4N9fuQjfsw==
X-Gm-Gg: ASbGncszXpid35ji+/BFfeMI/lf0upzKhTUbImsaMQITK70YqxYsSufB6lLiGCcGsfg
	e2cBY0t0HUyfW1PuxC+ci2rhV2ocuplOZ3z5F7CI08ADLOeGwVgQxNZKgmmxmOznquJ7auTBii1
	zSjETyX7ZNhCvlHoFNG7VLAtpFRYor90TcGa7eNW+S9MFtL4lFkQyon4nV5hfj8SxFuo+Ld0Lxi
	UMYeuTTbh8bxsd4maiDfoUWcjGVAwk2PXLrx86MqE/iCOkG92vc7wZ9MYjbGQPECmpmrjB1rwUl
	pOdUdtz6MoWS2Rsl2My5HcFqgzXX7xDSQHUGHOVQ
X-Received: by 2002:a05:6512:10cb:b0:545:d54:2ebe with SMTP id 2adb3069b0e04-54acb22365dmr1045586e87.43.1742386723730;
        Wed, 19 Mar 2025 05:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyGYm0L4Zrm63gwHHSEdeVhZIEKSSrhZNtgIfcLFC9WB6N+6dtsumfvF4gPJciZl+hjDy7ZQ==
X-Received: by 2002:a05:6512:10cb:b0:545:d54:2ebe with SMTP id 2adb3069b0e04-54acb22365dmr1045551e87.43.1742386723083;
        Wed, 19 Mar 2025 05:18:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88536csm1927357e87.177.2025.03.19.05.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:18:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1634218FC0C2; Wed, 19 Mar 2025 13:18:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com,
 oss-security@lists.openwall.com, kernel-hardening@lists.openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 19 Mar 2025 13:18:34 +0100
Message-ID: <87r02ti57p.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/19 4:55, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>> On 2025/3/17 23:16, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>>>>
>>>>> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>
>>>>>> To avoid having to walk the entire xarray on unmap to find the page
>>>>>> reference, we stash the ID assigned by xa_alloc() into the page
>>>>>> structure itself, using the upper bits of the pp_magic field. This
>>>>>> requires a couple of defines to avoid conflicting with the
>>>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-ti=
me,
>>>>>> so does not affect run-time performance. The bitmap calculations in =
this
>>>>>> patch gives the following number of bits for different architectures:
>>>>>>
>>>>>> - 24 bits on 32-bit architectures
>>>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VAL=
UE)
>>>>>> - 32 bits on other 64-bit architectures
>>>>>
>>>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>>>>> "The page->signature field is aliased to page->lru.next and
>>>>> page->compound_head, but it can't be set by mistake because the
>>>>> signature value is a bad pointer, and can't trigger a false positive
>>>>> in PageTail() because the last bit is 0."
>>>>>
>>>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2=
}=20
>>>>> offset"):
>>>>> "Poison pointer values should be small enough to find a room in
>>>>> non-mmap'able/hardly-mmap'able space."
>>>>>
>>>>> So the question seems to be:
>>>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>>>>>     easier-mmap'able space? If yes, how can we make sure this will not
>>>>>     cause any security problem?
>>>>> 2. Is the masking the page->pp_magic causing a valid pionter for
>>>>>     page->lru.next or page->compound_head to be treated as a vaild
>>>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>>>>>     allocated via page_pool.
>>>>
>>>> Right, so my reasoning for why the defines in this patch works for this
>>>> is as follows: in both cases we need to make sure that the ID stashed =
in
>>>> that field never looks like a valid kernel pointer. For 64-bit arches
>>>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
>>>> writing to any bits that overlap with the illegal value (so that the
>>>> PP_SIGNATURE written to the field keeps it as an illegal pointer value=
).
>>>> For 32-bit arches, we make sure of this by making sure the top-most bit
>>>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
>>>> which puts it outside the range used for kernel pointers (AFAICT).
>>>
>>> Is there any season you think only kernel pointer is relevant here?
>>=20
>> Yes. Any pointer stored in the same space as pp_magic by other users of
>> the page will be kernel pointers (as they come from page->lru.next). The
>> goal of PP_SIGNATURE is to be able to distinguish pages allocated by
>> page_pool, so we don't accidentally recycle a page from somewhere else.
>> That's the goal of the check in page_pool_page_is_pp():
>>=20
>> (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE
>>=20
>> To achieve this, we must ensure that the check above never returns true
>> for any value another page user could have written into the same field
>> (i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA
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

Well, not from a "number of bits available" perspective. In that case we
have plenty of bits, but we limit the size of the ID we stash to 32 bits
in all cases, so we will just end up with the 21 leading bits being
all-zero. So for those arches we basically end up in the same situation
as on 32-bit (see below).

>> serves this purpose. For 32-bit arches, we can leave the top-most bits
>> out of PP_MAGIC_MASK, to make sure that any valid pointer value will
>> fail the check above.
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

Right, okay, I see what you mean. So the risk is basically the
following:

If some other part of the kernel ends up dereferencing the
page->lru.next pointer of a page that is owned by page_pool, and which
has an ID stashed into page->pp_magic, that dereference can end up being
to a valid userspace mapping, which can lead to Bad Things(tm), cf the
paper above.

This is mitigated by the fact that it can only happen on architectures
that don't set ILLEGAL_POINTER_VALUE (which includes 32-bit arches, and
the ones you listed above). In addition, this has to happen while the
page is owned by page_pool, and while it is DMA-mapped - we already
clear the pp_magic field when releasing the page from page_pool.

I am not sure to what extent the above is a risk we should take pains to
avoid, TBH. It seems to me that for this to become a real problem, lots
of other things will already have gone wrong. But happy to defer to the
mm/security folks here.

>>> It seems it is not really only about kernel pointers as round_hint_to_m=
in()
>>> in mm/mmap.c suggests and the commit log in the above commit 8a5e5e02fc=
83
>>> if I understand it correctly:
>>> "Given unprivileged users cannot mmap anything below mmap_min_addr, it
>>> should be safe to use poison pointers lower than mmap_min_addr."
>>>
>>> And the above "making sure the top-most bit is always 0" doesn't seems =
to
>>> ensure page->signature to be outside the range used for kernel pointers
>>> for 32-bit arches with VMSPLIT_1G defined, see arch/arm/Kconfig, there
>>> is a similar config for x86 too:
>
> ...
>
>>=20
>> Ah, interesting, didn't know this was configurable. Okay, so AFAICT, the
>> lowest value of PAGE_OFFSET is 0x40000000 (for VMSPLIT_1G), so we need
>> to leave two bits off at the top instead of just one. Will update this,
>> and try to explain the logic better in the comment.
>
> It seems there was attempt of doing 4G/4G split too, and that is the kind
> of limitation or complexity added to the ARCH and MM subsystem by doing t=
he
> ID stashing I mentioned earlier.
> https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@loc=
alhost.localdomain/

Given that this is all temporary until the folio rework Matthew alluded
to is completed, I think that particular concern is somewhat theoretical :)

>>> IMHO, even if some trick like above is really feasible, it may be
>>> adding some limitation or complexity to the ARCH and MM subsystem, for
>>> example, stashing the ID in page->signature may cause 0x*40 signature
>>> to be unusable for other poison pointer purpose, it makes more sense to
>>> make it obvious by doing the above trick in some MM header file like
>>> poison.h instead of in the page_pool subsystem.
>>=20
>> AFAIU, PP_SIGNATURE is used for page_pool to be able to distinguish its
>> own pages from those allocated elsewhere (cf the description above).
>> Which means that these definitions are logically page_pool-internal, and
>> thus it makes the most sense to keep them in the page pool headers. The
>> only bits the mm subsystem cares about in that field are the bottom two
>> (for pfmemalloc pages and compound pages).
>
> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
> still want to proceed with reusing the page->pp_magic as the masking and
> the signature to be masked seems reasonable to be in the same file.

Hmm, my thinking was that this would be a lot of irrelevant stuff to put
into poison.h, but I suppose we could do so if the mm folks don't object :)

-Toke


