Return-Path: <bpf+bounces-54475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEFA6A8C5
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E9F88353C
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4F1E282D;
	Thu, 20 Mar 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US7Rfm3i"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E851DE2DF
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481458; cv=none; b=ssg0OFmiS4dvkQjdPoUWQs31B4FIIbq7epHkzJXC/KsOsVbvSCyP5oGfOufdRfz8xJp16C4ovbnURAVKQ2uFwypI4g1tpxVY5HG8j1HMCjQCIxz7mVRkSHJg30c/pu3fFSYGm2pApB5rBP3O/o6kufhPpF2CL5/An6NINsXdwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481458; c=relaxed/simple;
	bh=rNaYxAA0W9isVeCZz2qUgEKgWLEAtwWHcEfKMd2UaxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EgPWz9kjO2GPzJityCdQD/FM3V166b2LMgCvuUIEZF20gCjjlXp80ot0tOImbsmvqyDClPTcIR+T4tA5erQHqcJR6LYnTLf8bsORpViKIrC7h/y25LxL6UlMv77tAgjEjrKf1p7xt9ZkFwaCgrbw8aQpECdb6OPASwLsUJQ5tIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US7Rfm3i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLx6gnmmSWWfdNgPfLYTsxSrV+Ix7KpS1F+U6ftX2nU=;
	b=US7Rfm3iYdTQwjX8IFT6fILv5g8ugxBXU4FN+9sb3OfsF33BVcanJ3cUTzXv0K1MlK5uH5
	0WFtrRR9CAscepssq3KrrvvbycxZrXAtr1ZnFpyA0ASf/P/jUACLa0sb5njHFywgGNeK1B
	/sVd3X0GRc9/ntgfDn3vDVlzGfiIVgY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-oYlRoPhbM1-ZURZ1dj5_fg-1; Thu, 20 Mar 2025 10:37:33 -0400
X-MC-Unique: oYlRoPhbM1-ZURZ1dj5_fg-1
X-Mimecast-MFC-AGG-ID: oYlRoPhbM1-ZURZ1dj5_fg_1742481452
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf67adf33so9887391fa.0
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 07:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481452; x=1743086252;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLx6gnmmSWWfdNgPfLYTsxSrV+Ix7KpS1F+U6ftX2nU=;
        b=qyLRr46FCfJCapp5VzrgYUydJ2jEeh2/HgUX9gkorOwGbiBLlPbV0aTAMpkKMnp03G
         LXuwwmVvt1TDXh5Z0jO++fzN51x29DGavl51rMn54UhkDQwvMZ7AVdbo6r3W2jzpiouw
         trZY69m8FJ1e5PtEFz33QpW62WIVumw4BXpojFDOUg+l2hezDZ8IbB5qkSp/OySJOJVU
         YM73k0Jfap3Qt+8zyAvmCGCS4hglo1rd4xXI7eTPNaRcSXTiIR6IjJTh3/2UPBrgHoVC
         uEBZ3/FZi/3AWSGCEe9pHxmUfyPXHllYFmQrBIFELOB/cqLj7Wab/MGqWG0m1rptLQnh
         Dksw==
X-Forwarded-Encrypted: i=1; AJvYcCUmNWGcwwg7mFL+xwHa31DB23Q1DuS2aoD28oy9uDOY4EB0FPZY14LLr8H9oU++PN23Th4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbFWUAo6VFLsRI/Yp7JPS3iSGqqwpxAAVx2BDK9IXsOHEeVR5
	sSBIDDKTNYQLtyMPfUHsCeGFxRoE2u9iavbLQZXXmjY9eOTM9BIo0e5EdsKMsr1c7yRcAqDFE/w
	X2DjDXiF42wLNP9/lOwZdXF7RDMwQpquXiQ/KP/q7rmDXy0/ZfA==
X-Gm-Gg: ASbGncuS9ikPPn4otOVWcheo713KCahdP3OKf4WAwbRz2OcUO3ojk6xIToCQwXRzuUt
	0+3KQKnhp/WXj3jMgRx76n9UiMu646yirvJ1FvEbeti42NQ7dd/Fk7b6nfzTBN0FDFHgpp1VvB4
	n/Q+UHczrNaT3eO8U6FFz0sBwaJnDHj7GnGQdK232vIsP3iu8qY6VLaGB9V84MNvFKqt/VoM9OM
	+mMJKTFIgP/AJwEy9uw7o4XsV1WQ+BcPNPCeZ2rUnDcvtWSXbyOmm813yoK1EC5SLbycm95yMx6
	GSXIDOduZmt/
X-Received: by 2002:a05:6512:3f18:b0:549:929c:e896 with SMTP id 2adb3069b0e04-54acfaa1b0emr1518844e87.11.1742481451810;
        Thu, 20 Mar 2025 07:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5VpCfZOFBC54LR922wO7u7GK5UhK0NC/mhGGmpD3DQ8vCNlbhBNi5GGvL7dfWltRcMPHQyg==
X-Received: by 2002:a05:6512:3f18:b0:549:929c:e896 with SMTP id 2adb3069b0e04-54acfaa1b0emr1518818e87.11.1742481451151;
        Thu, 20 Mar 2025 07:37:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c1203sm2219442e87.90.2025.03.20.07.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:37:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9D74918FC2E8; Thu, 20 Mar 2025 15:37:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Solar Designer <solar@openwall.com>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>, Robin
 Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>,
 segoon@openwall.com, kernel-hardening@lists.openwall.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>, sultan@kerneltoast.com
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <20250320023202.GA25514@openwall.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com>
 <20250320023202.GA25514@openwall.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 20 Mar 2025 15:37:29 +0100
Message-ID: <87ldszix92.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Solar Designer <solar@openwall.com> writes:

> On Wed, Mar 19, 2025 at 07:06:57PM +0800, Yunsheng Lin wrote:
>> On 2025/3/19 4:55, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Yunsheng Lin <linyunsheng@huawei.com> writes:
>> >> On 2025/3/17 23:16, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>> >>>> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >>>>
>> >>>> ...
>> >>>>
>> >>>>> To avoid having to walk the entire xarray on unmap to find the page
>> >>>>> reference, we stash the ID assigned by xa_alloc() into the page
>> >>>>> structure itself, using the upper bits of the pp_magic field. This
>> >>>>> requires a couple of defines to avoid conflicting with the
>> >>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-=
time,
>> >>>>> so does not affect run-time performance. The bitmap calculations i=
n this
>> >>>>> patch gives the following number of bits for different architectur=
es:
>> >>>>>
>> >>>>> - 24 bits on 32-bit architectures
>> >>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_V=
ALUE)
>> >>>>> - 32 bits on other 64-bit architectures
>> >>>>
>> >>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>> >>>> "The page->signature field is aliased to page->lru.next and
>> >>>> page->compound_head, but it can't be set by mistake because the
>> >>>> signature value is a bad pointer, and can't trigger a false positive
>> >>>> in PageTail() because the last bit is 0."
>> >>>>
>> >>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1=
,2}=20
>> >>>> offset"):
>> >>>> "Poison pointer values should be small enough to find a room in
>> >>>> non-mmap'able/hardly-mmap'able space."
>> >>>>
>> >>>> So the question seems to be:
>> >>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>> >>>>     easier-mmap'able space? If yes, how can we make sure this will =
not
>> >>>>     cause any security problem?
>> >>>> 2. Is the masking the page->pp_magic causing a valid pionter for
>> >>>>     page->lru.next or page->compound_head to be treated as a vaild
>> >>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>> >>>>     allocated via page_pool.
>> >>>
>> >>> Right, so my reasoning for why the defines in this patch works for t=
his
>> >>> is as follows: in both cases we need to make sure that the ID stashe=
d in
>> >>> that field never looks like a valid kernel pointer. For 64-bit arches
>> >>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
>> >>> writing to any bits that overlap with the illegal value (so that the
>> >>> PP_SIGNATURE written to the field keeps it as an illegal pointer val=
ue).
>> >>> For 32-bit arches, we make sure of this by making sure the top-most =
bit
>> >>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the pat=
ch,
>> >>> which puts it outside the range used for kernel pointers (AFAICT).
>> >>
>> >> Is there any season you think only kernel pointer is relevant here?
>> >=20
>> > Yes. Any pointer stored in the same space as pp_magic by other users of
>> > the page will be kernel pointers (as they come from page->lru.next). T=
he
>> > goal of PP_SIGNATURE is to be able to distinguish pages allocated by
>> > page_pool, so we don't accidentally recycle a page from somewhere else.
>> > That's the goal of the check in page_pool_page_is_pp():
>> >=20
>> > (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE
>> >=20
>> > To achieve this, we must ensure that the check above never returns true
>> > for any value another page user could have written into the same field
>> > (i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA
>>=20
>> POISON_POINTER_DELTA is defined according to CONFIG_ILLEGAL_POINTER_VALU=
E,
>> if CONFIG_ILLEGAL_POINTER_VALUE is not defined yet, POISON_POINTER_DELTA
>> is defined to zero.
>>=20
>> It seems only the below 64-bit arches define CONFIG_ILLEGAL_POINTER_VALUE
>> through grepping:
>> a29815a333c6 core, x86: make LIST_POISON less deadly
>> 5c178472af24 riscv: define ILLEGAL_POINTER_VALUE for 64bit
>> f6853eb561fb powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
>> bf0c4e047324 arm64: kconfig: Move LIST_POISON to a safe value
>>=20
>> The below 64-bit arches don't seems to define the above config yet:
>> MIPS64, SPARC64, System z(S390X),loongarch
>>=20
>> Does ID stashing cause problem for the above arches?
>>=20
>> > serves this purpose. For 32-bit arches, we can leave the top-most bits
>> > out of PP_MAGIC_MASK, to make sure that any valid pointer value will
>> > fail the check above.
>>=20
>> The above mainly explained how to ensure page_pool_page_is_pp() will
>> not return false positive result from the page_pool perspective.
>>=20
>> From MM/security perspective, most of the commits quoted above seem
>> to suggest that poison pointer should be in the non-mmap'able or
>> hardly-mmap'able space, otherwise userspace can arrange for those
>> pointers to actually be dereferencable, potentially turning an oops
>> to an expolit, more detailed example in the below paper, which explains
>> how to exploit a vulnerability which hardened by the 8a5e5e02fc83 commit:
>> https://www.usenix.org/system/files/conference/woot15/woot15-paper-xu.pdf
>>=20
>> ID stashing seems to cause page->lru.next (aliased to page->pp_magic) to
>> be in the mmap'able space for some arches.
>
> ...
>
>> To be honest, I am not that familiar with the pointer poison mechanism.
>> But through some researching and analyzing, it makes sense to overstate
>> it a little as it seems to be security-related.
>> Cc'ed some security-related experts and ML to see if there is some
>> clarifying from them.
>
> You're correct that the pointer poison values should be in areas not
> mmap'able by userspace (at least with reasonable mmap_min_addr values).
>
> Looking at the union inside "struct page", I see pp_magic is aliased
> against multiple pointers in the union'ed anonymous structs.
>
> I'm not familiar with the uses of page->pp_magic and how likely or not
> we are to have a bug where its aliasing with pointers would be exposed
> as an attack vector, but this does look like a serious security concern.
> It looks like we would be seriously weakening the poisoning, except on
> archs where the new values with ID stashing are still not mmap'able.
>
> I just discussed the matter with my colleague at CIQ, Sultan Alsawaf,
> and he thinks the added risk is not that bad.  He wrote:
>
>> Toke's response here is fair:
>>=20
>> > Right, okay, I see what you mean. So the risk is basically the
>> > following:
>> >=20
>> > If some other part of the kernel ends up dereferencing the
>> > page->lru.next pointer of a page that is owned by page_pool, and which
>> > has an ID stashed into page->pp_magic, that dereference can end up bei=
ng
>> > to a valid userspace mapping, which can lead to Bad Things(tm), cf the
>> > paper above.
>> >=20
>> > This is mitigated by the fact that it can only happen on architectures
>> > that don't set ILLEGAL_POINTER_VALUE (which includes 32-bit arches, and
>> > the ones you listed above). In addition, this has to happen while the
>> > page is owned by page_pool, and while it is DMA-mapped - we already
>> > clear the pp_magic field when releasing the page from page_pool.
>> >=20
>> > I am not sure to what extent the above is a risk we should take pains =
to
>> > avoid, TBH. It seems to me that for this to become a real problem, lots
>> > of other things will already have gone wrong. But happy to defer to the
>> > mm/security folks here.
>>=20
>> For this to be a problem, there already needs to be a use-after-free on
>> a page, which arguably creates many other vectors for attack.
>>=20
>> The lru field of struct page is already used as a generic list pointer
>> in several places in the kernel once ownership of the page is obtained.
>> Any risk of dereferencing lru.next in a use-after-free scenario would
>> technically apply to a bunch of other places in the kernel (grep for
>> page->lru).
>
> We also tried searching for existing exploitation techniques for "struct
> page" use-after-free.  We couldn't find any.  The closest (non-)match I
> found is this fine research (the same project presented differently):
>
> https://i.blackhat.com/BH-US-24/Presentations/US24-Qian-PageJack-A-Powerf=
ul-Exploit-Technique-With-Page-Level-UAF-Thursday.pdf page 33+
> https://arxiv.org/html/2401.17618v2#S4
> https://phrack.org/issues/71/13
>
> The arxiv paper includes this sentence: "To create a page-level UAF, the
> key is to cause a UAF of the struct page objects."  However, we do not
> see them actually do that, and this statement is not found in the slides
> nor in the Phrack article.  Confused.

Thank you for weighing in! I will post an updated version of this patch
with a reference to this discussion and try to summarise the above.

> Thank you for CC'ing me and the kernel-hardening list.  However, please
> do not CC the oss-security list like that, where it's against content
> guidelines.  Only properly focused new postings/threads are acceptable
> there (not CC'ing from/to other lists where only part of the content is
> on-topic, and follow-ups might not be on-topic at all).  See:
>
> https://oss-security.openwall.org/wiki/mailing-lists/oss-security#list-co=
ntent-guidelines
>
> As a moderator for oss-security, I'm going to remove these messages from
> the queue now.  Please drop Cc: oss-security from any further replies.
>
> If desired, we may bring these topics to oss-security separately, with a
> proper Subject line and clear description of what we're talking about.

Noted, thanks!

-Toke


