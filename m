Return-Path: <bpf+bounces-66778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C26B39370
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 07:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24453ACDEF
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499E2773C8;
	Thu, 28 Aug 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpEl+XI8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30F4A02;
	Thu, 28 Aug 2025 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360519; cv=none; b=um/u9zX/q6nPTaBTbhJhXtqc1s65BHYV9o9LUZdzgQCQsH3ORHqvsPqpllQr9kGRb5kIYTPVpXGCwPp+bgNahPyQvrqZqcdfauFzcGJvpmIwrcvTczVn/FsLvhsscjmBTqCX79xjan8SAfg0a2+8PoYIxAM5l3PyA8lan5I+46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360519; c=relaxed/simple;
	bh=30KRfQG9QFf/W1C4k/imbGXu1HP4RkFmgUZHb0PVVzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJt++L0vvzTKJ2hYNKJPiWyZRWZfR8rfqGKrC7plH9TKTURDZ4YAuyVgFKHPAsaSll/QuJXw/gttqtTE78M0t2uS3+YrjIRDSBLRGH8K1n1p6sjta88jjCG1dZfcS1yhcbjKhD50I09yA4Bgih7MIus8vSFUQwUac+uvbgVxNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpEl+XI8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70dd5de762cso5524946d6.1;
        Wed, 27 Aug 2025 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360516; x=1756965316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dldp0U5bxa6Uwhl9/gyB62dNAojKNlQ5L021DWTSr1Y=;
        b=XpEl+XI8Z8hREfTDwmpDn8lQ9S5w6Q40nu3YvvvUqzrqd/Qmn+hph+6woGd3dq4Mtn
         ScrVqP62Tce/KfLWrWgv2kDh37vtWWTHq+daE7Dvc7rkBeadjo2LP48e5q3HL/bRzE50
         GnQcdEfctn4vVrOtJTRokJYQgo/D705iQBTR0O0/RgBWSUW/5LYAUdcH1wWu/qkongph
         Z/YE0LE55qMF/lLsc0uUV5GB4OlAppxHnsILLiozSC0cIE/OgEhON/xofuCTLcB2eNuj
         ake/mttMFqx6MGNIAkGmjUmVQf37qmvYcUFLbAlNVwT4upYAsIieVPPeQ49LbBQDwqc1
         TvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360516; x=1756965316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dldp0U5bxa6Uwhl9/gyB62dNAojKNlQ5L021DWTSr1Y=;
        b=hMuJCi+Ya88ejMHceJGaV8wsbh6mIhy0f/iLdRWw1tPPCOkSwQgg3N5WWg5wRwvweQ
         ViBpZ7Ozvl93ci6xklzRjTWpb9q8lPBIyqoNGUExoV4N1Gpe7dEgTXPUOaAOXGjt/9Ej
         cuDyiLmeJjNgyT8yrMQ2Wp0uILH05JhBmUi8sa+M1+GXbHqsIFAv1QbvgckiepET+4h2
         uNT6cN1gKzPL9AvrReYFWyvU/IoLU9BYDR8pmChfG3N2zOpzJpyZU4CMPbyL3FoEunuy
         kgtVZr+jc42Z7VUCW2om9IeVBz3Lcm0IUWgqYguUA/GKVLoycTOQHs9yV7wqYI2l/RnM
         I0JA==
X-Forwarded-Encrypted: i=1; AJvYcCWhjrzsExclEIlIxwJXN161InJatVbDlkixPBPAdv8hWas849CpyeB2JzFxXBp37VpnLDzpqDsRHcAJ@vger.kernel.org, AJvYcCXMMztnVo44ysi5UxlqslSDFmbGfiibiSubUpj0NpCj8ZbtjdSyxD/jG2fDDqEkLtKCCPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h/RzI5zCvOz6VbTi3KRgKlxOczuQ8fclsunc1/tD7n/vCwn4
	9Qrz6fB9/IrXXCfaXvzLq3mAvsonX+R7s346T+SEDAmWzGyNn7NM6I0x3D6G6oq4sD4dK15MbCP
	yCC9g1ebY3N1DaKntrfQp2Ebt5G2CtlA=
X-Gm-Gg: ASbGncv/J6+AE74s8lbaPGXRecaFRzwGLeyQ2hRxAS0JBYhRTu1mv2ZJi8Doe0x7zOR
	5NMobW0bEAS/rvOKDExn2YUvqoOJGH5lJ1HzlTDhJAtBHO3RFmwJKaaCRKiK9pWQPyA1BMlwL0U
	VMdy14H1j4Rf6d/tX5dGW2/+Ugy4UYu5a40i4alkmnpmGuT7f2SWX5/+5z3onhYrS9+GoIx+XYN
	R/BFrsOGOy4gpd7IUwUIw/45b66mwhZORj7p14=
X-Google-Smtp-Source: AGHT+IE7gK3LzfStpyqOrkju1++EeRY1wMSLYIyUJveEm39q4Sk8OdpNJFsj8TYjzNuNKhrD5f1PE1GloVsdpMljuWM=
X-Received: by 2002:a05:6214:1c4b:b0:709:b90c:66f1 with SMTP id
 6a1803df08f44-70d971f28b7mr259851996d6.34.1756360515855; Wed, 27 Aug 2025
 22:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
In-Reply-To: <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 13:54:39 +0800
X-Gm-Features: Ac12FXz5N0Xylog4coLtFNfktMJwwPDc8YwnuJZ4IKJRIj_PvpqBdDfpsLowBss
Message-ID: <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:03=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:39PM +0800, Yafang Shao wrote:
> > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynam=
ic
> > THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
> > programs to influence THP order selection based on factors such as:
> > - Workload identity
> >   For example, workloads running in specific containers or cgroups.
> > - Allocation context
> >   Whether the allocation occurs during a page fault, khugepaged, or oth=
er
> >   paths.
> > - System memory pressure
> >   (May require new BPF helpers to accurately assess memory pressure.)
> >
> > Key Details:
> > - Only one BPF program can be attached at a time, but it can be updated
> >   dynamically to adjust the policy.
> > - Supports automatic mTHP order selection and per-workload THP policies=
.
> > - Only functional when THP is set to madise or always.
> >
> > It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> > This feature is unstable and may evolve in future kernel versions.
> >
> > Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redha=
t.com/ [0]
> > Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucif=
er.local/ [1]
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/huge_mm.h    |  15 +++
> >  include/linux/khugepaged.h |  12 ++-
> >  mm/Kconfig                 |  12 +++
> >  mm/Makefile                |   1 +
> >  mm/bpf_thp.c               | 186 +++++++++++++++++++++++++++++++++++++
>
> Please add new files to MAINTAINERS as you add them.

will do it.

>
> >  mm/huge_memory.c           |  10 ++
> >  mm/khugepaged.c            |  26 +++++-
> >  mm/memory.c                |  18 +++-
> >  8 files changed, 273 insertions(+), 7 deletions(-)
> >  create mode 100644 mm/bpf_thp.c
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 1ac0d06fb3c1..f0c91d7bd267 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -6,6 +6,8 @@
> >
> >  #include <linux/fs.h> /* only for vma_is_dax() */
> >  #include <linux/kobject.h>
> > +#include <linux/pgtable.h>
> > +#include <linux/mm.h>
>
> Hm this is a bit weird as mm.h includes huge_mm... I guess it will be han=
dled by
> header defines but still.

Some refactoring is needed for these two header files, but we can
handle it separately later.

>
> >
> >  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> >  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
> >  };
> >
> >  struct kobject;
> > @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void)
> >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> >  }
> >
> > +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *v=
ma__nullable,
> > +                     u64 vma_flags, enum tva_type tva_flags, int order=
s);
>
> Not a massive fan of this naming to be honest. I think it should explicit=
ly
> reference bpf, e.g. bpf_hook_thp_get_order() or something.

will change it to bpf_hook_thp_get_orders().

>
> Right now this is super unclear as to what it's for.
>
> Also wrt vma_flags - this type is wrong :) it's vm_flags_t and going to c=
hange
> to a bitmap of unlimiiteeed size soon. So probs best not to pass around a=
s value
> type either.

As replied in another thread. I will change it.

>
> But unclear us to purpose as mentioned elsewhere.
>
> And also get_suggested_order() should be get_suggested_orderS() no? As yo=
u
> seem later in the code to be referencing a bitfield?

Right, it should be bpf_hook_thp_get_orderS().

>
> Also will mm ever !=3D vma->vm_mm?

No it can't. It can be guaranteed by the caller.

>
> Are we hacking this for the sake of overloading what this does?

The @vma is actually unneeded. I will remove it.

>
> Also if we're returning a bitmask of orders which you seem to be (not sur=
e I
> like that tbh - I feel like we shoudl simply provide one order but open f=
or
> disucssion) - shouldn't it return an unsigned long?

We are indifferent to whether a single order or a bitmask is returned,
as we only use order-0 and order-9. We have no use cases for
middle-order pages, though this feature might be useful for other
architectures or for some special use cases.

>
> > +#else
> > +static inline int
> > +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__=
nullable,
> > +                 u64 vma_flags, enum tva_type tva_flags, int orders)
> > +{
> > +     return orders;
> > +}
> > +#endif
> > +
> >  static inline int highest_order(unsigned long orders)
> >  {
> >       return fls_long(orders) - 1;
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index eb1946a70cff..d81c1228a21f 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -4,6 +4,8 @@
> >
> >  #include <linux/mm.h>
> >
> > +#include <linux/huge_mm.h>
> > +
>
> Hm this is iffy too, There's probably a reason we didn't include this bef=
ore,
> the headers can be so so fragile. Let's be cautious...

I will check.

>
> >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  extern struct attribute_group khugepaged_attr_group;
> > @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
> >
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_str=
uct *oldmm)
> >  {
> > -     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > +     /*
> > +      * THP allocation policy can be dynamically modified via BPF. Eve=
n if a
> > +      * task was allowed to allocate THPs, BPF can decide whether its =
forked
> > +      * child can allocate THPs.
> > +      *
> > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> > +      */
> > +     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> > +             get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
>
> Hmmm so there seems to be some kind of additional functionality you're pr=
oviding
> here kinda quietly, which is to allow the exact same interface to determi=
ne
> whether we kick off khugepaged or not.
>
> Don't love that, I think we should be hugely specific about that.
>
> This bpf interface should literally be 'ok we're deciding what order we
> want'. It feels like a bit of a gross overloading?

This makes sense. I have no objection to reverting to returning a single or=
der.

>
> >               __khugepaged_enter(mm);
> >  }
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 4108bcd96784..d10089e3f181 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
> >
> >         EXPERIMENTAL because the impact of some changes is still unclea=
r.
> >
> > +config EXPERIMENTAL_BPF_ORDER_SELECTION
> > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > +
> > +     help
> > +       Enable dynamic THP order selection using BPF programs. This
> > +       experimental feature allows custom BPF logic to determine optim=
al
> > +       transparent hugepage allocation sizes at runtime.
> > +
> > +       Warning: This feature is unstable and may change in future kern=
el
> > +       versions.
>
> Thanks! This is important to document. Absolute nitty nit: can you capita=
lise
> 'WARNING'? Thanks!

will do it.

>
> > +
> >  endif # TRANSPARENT_HUGEPAGE
> >
> >  # simple helper to make the code a bit easier to read
> > diff --git a/mm/Makefile b/mm/Makefile
> > index ef54aa615d9d..cb55d1509be1 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
> >  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
> >  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> > +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) +=3D bpf_thp.o
> >  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> >  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
> >  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> > new file mode 100644
> > index 000000000000..fbff3b1bb988
> > --- /dev/null
> > +++ b/mm/bpf_thp.c
>
> As mentioned before, please update MAINTAINERS for new files. I went to g=
reat +
> painful lengths to get everything listed there so let's keep it that way =
please
> :P

will do it.

>
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +struct bpf_thp_ops {
> > +     /**
> > +      * @get_suggested_order: Get the suggested THP orders for allocat=
ion
> > +      * @mm: mm_struct associated with the THP allocation
> > +      * @vma__nullable: vm_area_struct associated with the THP allocat=
ion (may be NULL)
> > +      *                 When NULL, the decision should be based on @mm=
 (i.e., when
> > +      *                 triggered from an mm-scope hook rather than a =
VMA-specific
> > +      *                 context).
> > +      *                 Must belong to @mm (guaranteed by the caller).
> > +      * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if=
 @vma is NULL)
> > +      * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> > +      * @orders: Bitmask of requested THP orders for this allocation
> > +      *          - PMD-mapped allocation if PMD_ORDER is set
> > +      *          - mTHP allocation otherwise
> > +      *
> > +      * Rerurn: Bitmask of suggested THP orders for allocation. The hi=
ghest
> > +      *         suggested order will not exceed the highest requested =
order
> > +      *         in @orders.
> > +      */
> > +     int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_s=
truct *vma__nullable,
> > +                                u64 vma_flags, enum tva_type tva_flags=
, int orders) __rcu;
>
> I feel like we should be declaring this function pointer type somewhere e=
lse as
> we're now duplicating this in two places.

agreed, I have already done it to fix the spare warning.

>
> > +};
> > +
> > +static struct bpf_thp_ops bpf_thp;
> > +static DEFINE_SPINLOCK(thp_ops_lock);
> > +
> > +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *v=
ma__nullable,
> > +                     u64 vma_flags, enum tva_type tva_flags, int order=
s)
>
> surely tva_flag? As this is an enum value?

will change it to tva_type instead.

>
> > +{
> > +     int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_s=
truct *vma__nullable,
> > +                                u64 vma_flags, enum tva_type tva_flags=
, int orders);
>
> This type for vma flags is totally incorrect. vm_flags_t. And that's goin=
g to
> change soon to an opaque type.
>
> Also right now it's actually an unsigned long.
>
> I really really do not like that we're providing extra, unexplained VMA f=
lags
> for some reason. I may be missing something :) so happy to hear why this =
is
> necessary.
>
> However in future we really shouldn't be passing something like this.

will change it as replied in another thread.

>
> Also - now a third duplication of the same function pointer :) can we do =
better
> than this? At least typedef it.
>
> > +     int suggested_orders =3D orders;
> > +
> > +     /* No BPF program is attached */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                   &transparent_hugepage_flags))
> > +             return suggested_orders;
>
> This is atomic ofc, but are we concerned about races, or I guess you expe=
ct only
> the first attached bpf program to work with it I suppose.

It is against the race to unreg or update.

>
> > +
> > +     rcu_read_lock();
>
> Is this sufficient? Anything stopping the mm or VMA going away here?

This RCU lock is not for protecting the mm or VMA structures
themselves, but for protecting the update of the function pointer.
Arbitrary access to pointers within the mm_struct or vm_area_struct is
prohibited, as they are guarded by the BPF verifier.

>
> > +     bpf_suggested_order =3D rcu_dereference(bpf_thp.get_suggested_ord=
er);
> > +     if (!bpf_suggested_order)
> > +             goto out;
> > +
> > +     suggested_orders =3D bpf_suggested_order(mm, vma__nullable, vma_f=
lags, tva_flags, orders);
>
> OK so now it's suggested order_S but we're invoking suggested order :) wh=
aaatt?
> :)

will change it.

>
> > +     if (highest_order(suggested_orders) > highest_order(orders))
> > +             suggested_orders =3D orders;
>
> Hmmm so the semantics are - whichever is the highest order wins?

The maximum requested order is determined by the callsite. For example:
- PMD-mapped THP uses PMD_ORDER
- mTHP uses (PMD_ORDER - 1)

We must respect this upper bound to avoid undefined behavior. So the
highest suggested order can't exceed the highest requested order.

>
> I thought the idea was we'd hand control over to bpf if provided in effec=
t?
>
> Definitely worth going over these semantics in the cover letter (and do f=
orgive
> me if you have and I've missed! :)

It has already in the cover letter:

 * Return: Bitmask of suggested THP orders for allocation. The highest
 *         suggested order will not exceed the highest requested order
 *         in @orders.


>
> > +
> > +out:
> > +     rcu_read_unlock();
> > +     return suggested_orders;
> > +}
> > +
> > +static bool bpf_thp_ops_is_valid_access(int off, int size,
> > +                                     enum bpf_access_type type,
> > +                                     const struct bpf_prog *prog,
> > +                                     struct bpf_insn_access_aux *info)
> > +{
> > +     return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> > +}
> > +
> > +static const struct bpf_func_proto *
> > +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog=
 *prog)
> > +{
> > +     return bpf_base_func_proto(func_id, prog);
> > +}
> > +
> > +static const struct bpf_verifier_ops thp_bpf_verifier_ops =3D {
> > +     .get_func_proto =3D bpf_thp_get_func_proto,
> > +     .is_valid_access =3D bpf_thp_ops_is_valid_access,
> > +};
> > +
> > +static int bpf_thp_init(struct btf *btf)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int bpf_thp_init_member(const struct btf_type *t,
> > +                            const struct btf_member *member,
> > +                            void *kdata, const void *udata)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> > +{
> > +     struct bpf_thp_ops *ops =3D kdata;
> > +
> > +     spin_lock(&thp_ops_lock);
> > +     if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                          &transparent_hugepage_flags)) {
> > +             spin_unlock(&thp_ops_lock);
> > +             return -EBUSY;
> > +     }
> > +     WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order));
> > +     rcu_assign_pointer(bpf_thp.get_suggested_order, ops->get_suggeste=
d_order);
> > +     spin_unlock(&thp_ops_lock);
> > +     return 0;
> > +}
> > +
> > +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> > +{
> > +     spin_lock(&thp_ops_lock);
> > +     clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepag=
e_flags);
> > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> > +     rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is=
_held(&thp_ops_lock));
> > +     spin_unlock(&thp_ops_lock);
> > +
> > +     synchronize_rcu();
> > +}
>
> I am a total beginner with BPF implementations so don't feel like I can s=
ay much
> intelligent about the above. But presumably fairly standard fare BPF-wise=
?

This implementation is necessary to support BPF program updates.

>
> Will perhaps try to dig deeper on another iteration :) as intersting to m=
e.
>
> > +
> > +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_lin=
k *link)
> > +{
> > +     struct bpf_thp_ops *ops =3D kdata;
> > +     struct bpf_thp_ops *old =3D old_kdata;
> > +     int ret =3D 0;
> > +
> > +     if (!ops || !old)
> > +             return -EINVAL;
> > +
> > +     spin_lock(&thp_ops_lock);
> > +     /* The prog has aleady been removed. */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hug=
epage_flags)) {
> > +             ret =3D -ENOENT;
> > +             goto out;
> > +     }
>
> OK so we gate things on this flag and it's global, got it.
>
> I see this is a hook, and I guess RCU-all-the-things is what BPF does whi=
ch
> makes tonnes of sense.
>
> > +     WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> > +     rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_suggest=
ed_order,
> > +                         lockdep_is_held(&thp_ops_lock));
> > +
> > +out:
> > +     spin_unlock(&thp_ops_lock);
> > +     if (!ret)
> > +             synchronize_rcu();
> > +     return ret;
> > +}
> > +
> > +static int bpf_thp_validate(void *kdata)
> > +{
> > +     struct bpf_thp_ops *ops =3D kdata;
> > +
> > +     if (!ops->get_suggested_order) {
> > +             pr_err("bpf_thp: required ops isn't implemented\n");
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int suggested_order(struct mm_struct *mm, struct vm_area_struct=
 *vma__nullable,
> > +                        u64 vma_flags, enum tva_type vm_flags, int ord=
ers)
> > +{
> > +     return orders;
> > +}
> > +
> > +static struct bpf_thp_ops __bpf_thp_ops =3D {
> > +     .get_suggested_order =3D suggested_order,
> > +};
>
> Can you explain to me what this stub stuff is for? This is more 'BPF impl=
 101'
> stuff sorry :)

It is a CFI stub. cfi_stubs in BPF struct_ops are secure intermediary
functions that prevent the kernel from making direct, unsafe jumps to
BPF code. A new attached BPF program will run via this stub.

>
> > +
> > +static struct bpf_struct_ops bpf_bpf_thp_ops =3D {
> > +     .verifier_ops =3D &thp_bpf_verifier_ops,
> > +     .init =3D bpf_thp_init,
> > +     .init_member =3D bpf_thp_init_member,
> > +     .reg =3D bpf_thp_reg,
> > +     .unreg =3D bpf_thp_unreg,
> > +     .update =3D bpf_thp_update,
> > +     .validate =3D bpf_thp_validate,
> > +     .cfi_stubs =3D &__bpf_thp_ops,
> > +     .owner =3D THIS_MODULE,
> > +     .name =3D "bpf_thp_ops",
> > +};
> > +
> > +static int __init bpf_thp_ops_init(void)
> > +{
> > +     int err =3D register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops=
);
> > +
> > +     if (err)
> > +             pr_err("bpf_thp: Failed to register struct_ops (%d)\n", e=
rr);
> > +     return err;
> > +}
> > +late_initcall(bpf_thp_ops_init);
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d89992b65acc..bd8f8f34ab3c 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_=
fault *vmf)
> >               return ret;
> >       khugepaged_enter_vma(vma, vma->vm_flags);
> >
> > +     /*
> > +      * This check must occur after khugepaged_enter_vma() because:
> > +      * 1. We may permit THP allocation via khugepaged
> > +      * 2. While simultaneously disallowing THP allocation
> > +      *    during page fault handling
> > +      */
> > +     if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_PAGEF=
AULT, BIT(PMD_ORDER)) !=3D
> > +                             BIT(PMD_ORDER))
>
> Hmmm so you return a bitmask of orders, but then you only allow this faul=
t if
> the only order provided is PMD order? That seems strange. Can you explain=
?

This is in the do_huge_pmd_anonymous_page() that can only accept a PMD
order, otherwise it might result in unexpected behavior.

>
> > +             return VM_FAULT_FALLBACK;
>
> It'd be good to have a helper function for this like:
>
>         if (!bpf_hook_allow_pmd_order(vma, tva_flag))
>                 return VM_FAULT_FALLBACK;
>
> And implemented like maybe:
>
> static bool bpf_hook_allow_pmd_order(struct vm_area_struct *vma, enum tva=
_type tva_flag)
> {
>         int orders =3D get_suggested_order(vma->vm_mm, vma, vma->vm_flags=
, tva_flag,
>                         BIT(PMD_ORDER));
>
>         return orders & BIT(PMD_ORDER);
> }
>
> It's good the tva flag gives context though.

Thanks for the suggestion.
will change it.

>
> > +
> >       if (!(vmf->flags & FAULT_FLAG_WRITE) &&
> >                       !mm_forbids_zeropage(vma->vm_mm) &&
> >                       transparent_hugepage_use_zero_page()) {
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c

> > index d3d4f116e14b..935583626db6 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -474,7 +474,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vm=
a,
> >  {
> >       if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> >           hugepage_pmd_enabled()) {
> > -             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER))
> > +             if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED=
, PMD_ORDER) &&
> > +                 get_suggested_order(vma->vm_mm, vma, vm_flags, TVA_KH=
UGEPAGED,
> > +                                     BIT(PMD_ORDER)))
>
> I don't know why we aren't working the bpf hook into thp_vma_allowable_or=
der()?

Actually it can be added into thp_vma_allowable_order().  I will change it.

>
> Also a helper would work here.
>
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
> >  }
> > @@ -934,6 +936,8 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >               return SCAN_ADDRESS_RANGE;
> >       if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER)=
)
> >               return SCAN_VMA_CHECK;
> > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, type, BI=
T(PMD_ORDER)))
> > +             return SCAN_VMA_CHECK;
>
>
>
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
> >        * remapped to file after khugepaged reaquired the mmap_lock.
> > @@ -1465,6 +1469,11 @@ static void collect_mm_slot(struct khugepaged_mm=
_slot *mm_slot)
> >               /* khugepaged_mm_lock actually not necessary for the belo=
w */
> >               mm_slot_free(mm_slot_cache, mm_slot);
> >               mmdrop(mm);
> > +     } else if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))=
 {
> > +             hash_del(&slot->hash);
> > +             list_del(&slot->mm_node);
> > +             mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> > +             mm_slot_free(mm_slot_cache, mm_slot);
> >       }
> >  }
> >
> > @@ -1538,6 +1547,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,=
 unsigned long addr,
> >       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
> >               return SCAN_VMA_CHECK;
> >
> > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORC=
ED_COLLAPSE,
> > +                              BIT(PMD_ORDER)))
>
> Again, can we please not duplicate thp_vma_allowable_order() logic?
>
> The THP code is horrible enough, but now we have to remember to also do t=
he bpf
> check?

makes sense.

>
> > +             return SCAN_VMA_CHECK;
> >       /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tabl=
es() */
> >       if (userfaultfd_wp(vma))
> >               return SCAN_PTE_UFFD_WP;
> > @@ -2416,6 +2428,10 @@ static unsigned int khugepaged_scan_mm_slot(unsi=
gned int pages, int *result,
> >        * the next mm on the list.
> >        */
> >       vma =3D NULL;
> > +
> > +     /* If this mm is not suitable for the scan list, we should remove=
 it. */
> > +     if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> > +             goto breakouterloop_mmap_lock;
>
> OK again I'm really not loving this NULL, 0, -1 stuff. What is this suppo=
sed to
> mean? The idea here is we have a hook for 'trying to determine THP order'=
 and
> now it's overloaded it seems in multiple ways?
>
> I may be missing context here.
>
> I'm also a bit perplexed by the comment as to what is intended here.

Using a BPF-based approach for THP adjustment allows us to dynamically
enable or disable THP for running applications without causing any
disruption. This capability is particularly valuable in production
environments. The logic here is designed to achieve exactly that.


>
> >       if (unlikely(!mmap_read_trylock(mm)))
> >               goto breakouterloop_mmap_lock;
> >
> > @@ -2432,7 +2448,9 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                       progress++;
> >                       break;
> >               }
> > -             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUG=
EPAGED, PMD_ORDER)) {
> > +             if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUG=
EPAGED, PMD_ORDER) ||
> > +                 !get_suggested_order(vma->vm_mm, vma, vma->vm_flags, =
TVA_KHUGEPAGED,
> > +                                      BIT(PMD_ORDER))) {
>
> Same various comments from above.

will change it.

>
> >  skip:
> >                       progress++;
> >                       continue;
> > @@ -2769,6 +2787,10 @@ int madvise_collapse(struct vm_area_struct *vma,=
 unsigned long start,
> >       if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLA=
PSE, PMD_ORDER))
> >               return -EINVAL;
> >
> > +     if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORC=
ED_COLLAPSE,
> > +                              BIT(PMD_ORDER)))
> > +             return -EINVAL;
> > +
>
> Same various comments from above.

will change it.

>
> >       cc =3D kmalloc(sizeof(*cc), GFP_KERNEL);
> >       if (!cc)
> >               return -ENOMEM;
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d9de6c056179..0178857aa058 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4486,6 +4486,7 @@ static inline unsigned long thp_swap_suitable_ord=
ers(pgoff_t swp_offset,
> >  static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma =3D vmf->vma;
> > +     int order, suggested_orders;
> >       unsigned long orders;
> >       struct folio *folio;
> >       unsigned long addr;
> > @@ -4493,7 +4494,6 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
> >       spinlock_t *ptl;
> >       pte_t *pte;
> >       gfp_t gfp;
> > -     int order;
> >
> >       /*
> >        * If uffd is active for the vma we need per-page fault fidelity =
to
> > @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >       if (!zswap_never_enabled())
> >               goto fallback;
> >
> > +     suggested_orders =3D get_suggested_order(vma->vm_mm, vma, vma->vm=
_flags,
> > +                                            TVA_PAGEFAULT,
> > +                                            BIT(PMD_ORDER) - 1);
> > +     if (!suggested_orders)
> > +             goto fallback;
>
> Wait, but below we have a bunch of fallbacks, now BPF overrides everythin=
g?

When allocating high-order pages is not feasible, such as during
periods of high memory pressure, the system should immediately fall
back to using 4 KB pages.

>
> I know I'm repaeting myself :P but can we just please put this into
> thp_vma_allowable_orders(), it's massively gross to just duplicate this c=
heck
> _everywhere_ with subtle differences.

will change it.

>
> >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >       /*
> >        * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
> >        * and suitable for swapping THP.
> >        */
> >       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEF=
AULT,
> > -                                       BIT(PMD_ORDER) - 1);
> > +                                       suggested_orders);
> >       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> >       orders =3D thp_swap_suitable_orders(swp_offset(entry),
> >                                         vmf->address, orders);
> > @@ -5044,12 +5049,12 @@ static struct folio *alloc_anon_folio(struct vm=
_fault *vmf)
> >  {
> >       struct vm_area_struct *vma =3D vmf->vma;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +     int order, suggested_orders;
> >       unsigned long orders;
> >       struct folio *folio;
> >       unsigned long addr;
> >       pte_t *pte;
> >       gfp_t gfp;
> > -     int order;
> >
> >       /*
> >        * If uffd is active for the vma we need per-page fault fidelity =
to
> > @@ -5058,13 +5063,18 @@ static struct folio *alloc_anon_folio(struct vm=
_fault *vmf)
> >       if (unlikely(userfaultfd_armed(vma)))
> >               goto fallback;
> >
> > +     suggested_orders =3D get_suggested_order(vma->vm_mm, vma, vma->vm=
_flags,
> > +                                            TVA_PAGEFAULT,
> > +                                            BIT(PMD_ORDER) - 1);
> > +     if (!suggested_orders)
> > +             goto fallback;
>
> Same comment as above.

will change it.


Thanks a lot for your comments.


--
Regards

Yafang

