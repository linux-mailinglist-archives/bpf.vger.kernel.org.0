Return-Path: <bpf+bounces-64686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004ADB15796
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DF718A0AA1
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209551A08AF;
	Wed, 30 Jul 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpkLxIC1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F9288A2
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843044; cv=none; b=lJp+odfkiGnW4lTbxrzYxfJpqNDAt4PLLlyhVM7TcPgCNvBInvPN3o6ki4HHhRHrHhWHBe81GydyVpleeg0bq1a0AL+UtyyMSlYaoQsLO9gkHs1gFEpc3JDYaFwVoRT9/HhmbfN0ovX+biqTXeyMnn8Zj8gFEX+QwuA0k0vxkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843044; c=relaxed/simple;
	bh=U2hnbKxmsPE5Pn675/jBJgjgGX1ce5w0rIB8HcgpD74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9uAf3Tz2vCh+OPo17m3MVZvCglORfHkzy06dPT1J/XPx+kGSSus+qchi9s/ActSeYw8Uxag84ylVVGsNjtxEm9JpbkTfI0PdylSUmecrAE0QOY86agpTXNnMJjXSm0lxzm7GM3crJbAA9+kc4zIeJQD+1WlE1ECSlZPg+ELyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpkLxIC1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70749eac23dso21623976d6.2
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 19:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753843041; x=1754447841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azm4H21bCSR8pRZXWBmM1Jjia6/6iWdiaPD1AcoRFgw=;
        b=TpkLxIC1VsfaE4EJ1DPb4FLyXJjkAZ4DHZKQLWl77bdIOJuOptTMJ2NVLg1KRWzoFc
         ZnFgcz2i7QzPAJFzaQUf9bb4As9dpyQtfR3ivhau7MMvPax30eC/jjU69608FwNaEcH7
         3AvcnodeVdn1KnCNjVGYxwk8OBV7tTsUafWngrT3JSC6glmYMGF82hy5aSR5ofZwjIbm
         6MSma8T1dkXl3uEMfLssuR3H1tq8kmVdDvEKN8i2MQqO3crCZN/2j3WQqz9w6Fp74LCM
         uUcVTB9woCITU341zk5SFr+1CX9jgQozMces6NQwhyjCVe0YSgHdD2aKE2o88xpCDNAA
         B4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753843041; x=1754447841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azm4H21bCSR8pRZXWBmM1Jjia6/6iWdiaPD1AcoRFgw=;
        b=UGWU44y0Glviut+GvWZ774wb0r0qx3B17xCWvFY4NlTORKlUv2WIS0jpuSYo8l8tGh
         SpAmC4Z2X1OiRBm/P+/yvp9npRx+S4VC47Bk45a52K0jGAxTHarpp2PQ+PoEZuzg3f2j
         n8N3/63pf65kdsBYJbx17UTaC2w5RVy6zAxl9tMbKi3Znja2p5AG718v6uEZmm0n1NWD
         fSTbGTChl/t05PXFlo4gFiLuZMSXDR7sq8jGbfDkHHMYVFzLKMPLRi4vwSd6I5x9rzFB
         Ln+BItcQ9Bon4GxK7ttT/qS7k5UsRSjw7WnbjhboCCo9GN7CSaLMPdK7QGRDFukroQJd
         IdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpDYreEqDPus2snAz6A4RtD06yvw1zb4Fv7Ry96EFbJ1xDZr1PZAsYMfdQM3upjMuKbWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOXYVPPCVkDlGJqczLYjMTPeylSGI4+hFhVnKTZH3ZfiWaYA/
	RX3Ul+GZ9OTD4sPqy+GJNnj5ZOfroS3vVnCA86BqgaEMbBg610zzMFn4ySYV9BcC0WLefLE3V2X
	16heeGTi0rHK16W0i6WUprJzb2z7TbS4=
X-Gm-Gg: ASbGncuWs46GuMaY1ofJciPKgoeZtpztC6arTlo4gLpa4GpmiSX2MvQPx56oKxPDahn
	TnyQMAYeIwEKINpjEnX8OY7/h/zSbScXdmlS9RVZgBnPRbeQGQCnqRZhvOjdni/TyJm+Rlt8Azh
	qSNjam16jHYqNBweNk3d7EN+PJuQXNHldZAu8QT3+gopHvIpny3Vcokdf8sGcKmpL9Ev7VLGfOY
	OIHkGbDh/BpHR3URA==
X-Google-Smtp-Source: AGHT+IHYPgqpkm23VSfrGkQqGIOsDFxmns71dpolrXxPBJhJSkFCDvaXOwvBV4ORQ7D6tW/54w+2GNPIVEP/NjbGTG8=
X-Received: by 2002:ad4:5764:0:b0:707:5067:4fbe with SMTP id
 6a1803df08f44-7076713a684mr27657556d6.13.1753843041393; Tue, 29 Jul 2025
 19:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729091807.84310-1-laoar.shao@gmail.com> <20250729091807.84310-2-laoar.shao@gmail.com>
 <F204238B-5B11-41DC-AF9B-4D2AC11ADF5E@nvidia.com>
In-Reply-To: <F204238B-5B11-41DC-AF9B-4D2AC11ADF5E@nvidia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 30 Jul 2025 10:36:43 +0800
X-Gm-Features: Ac12FXwSZakNsNX1BWXdDUCZftrIpRp5UhqiepESjeMjAuDTr8_Dyj6y8V2y-K0
Message-ID: <CALOAHbDKHqnyz0w0fKtdCgA3ScQ2qXG7QwZUDRGQjjTb1UNTRw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/4] mm: thp: add support for BPF based THP order selection
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:32=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 29 Jul 2025, at 5:18, Yafang Shao wrote:
>
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
> > Experimental Status:
> > - Requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> > - This feature is unstable and may evolve in future kernel versions.
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
> >  include/linux/huge_mm.h    |  13 +++
> >  include/linux/khugepaged.h |  12 ++-
> >  mm/Kconfig                 |  12 +++
> >  mm/Makefile                |   1 +
> >  mm/bpf_thp.c               | 172 +++++++++++++++++++++++++++++++++++++
> >  mm/huge_memory.c           |   9 ++
> >  mm/khugepaged.c            |  18 +++-
> >  mm/memory.c                |  14 ++-
> >  8 files changed, 244 insertions(+), 7 deletions(-)
> >  create mode 100644 mm/bpf_thp.c
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2f190c90192d..5a1527b3b6f0 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -6,6 +6,8 @@
> >
> >  #include <linux/fs.h> /* only for vma_is_dax() */
> >  #include <linux/kobject.h>
> > +#include <linux/pgtable.h>
> > +#include <linux/mm.h>
> >
> >  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> >  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > @@ -54,6 +56,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
> >  };
> >
> >  struct kobject;
> > @@ -190,6 +193,16 @@ static inline bool hugepage_global_always(void)
> >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> >  }
> >
> > +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> > +int get_suggested_order(struct mm_struct *mm, unsigned long tva_flags,=
 int order);
> > +#else
> > +static inline int
> > +get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, int=
 order)
> > +{
> > +     return order;
> > +}
> > +#endif
> > +
> >  static inline int highest_order(unsigned long orders)
> >  {
> >       return fls_long(orders) - 1;
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index b8d69cfbb58b..e0242968a020 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -2,6 +2,8 @@
> >  #ifndef _LINUX_KHUGEPAGED_H
> >  #define _LINUX_KHUGEPAGED_H
> >
> > +#include <linux/huge_mm.h>
> > +
> >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  extern struct attribute_group khugepaged_attr_group;
> > @@ -20,7 +22,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct =
*mm, unsigned long addr,
> >
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_str=
uct *oldmm)
> >  {
> > -     if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
> > +     /*
> > +      * THP allocation policy can be dynamically modified via BPF. If =
a
> > +      * long-lived task was previously allowed to allocate THP but is =
no
> > +      * longer permitted under the new policy, we must ensure its fork=
ed
> > +      * child processes also inherit this restriction.
>
> The comment is probably better to be:
>
> THP allocation policy can be dynamically modified via BPF. Even if a task
> was allowed to allocate THPs, BPF can decide whether its forked child
> can allocate THPs.
>
> The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
>
> Because the code here just wants to change a forked child=E2=80=99s mm fl=
ag. It has
> nothing to do with its parent THP policy.

Thanks for the improvement. I will change it.

>
> > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> > +      */
> > +     if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags) &&
> > +         get_suggested_order(mm, 0, PMD_ORDER) =3D=3D PMD_ORDER)
>
> Will it work for mTHPs? Nico is adding mTHP support for khugepaged[1].
> What if a BPF program wants khugepaged to work on some mTHP orders.
>
> Maybe get_suggested_order() should accept a bitmask of all allowed
> orders and return a bitmask as well. Only if the returned bitmask
> is 0, khugepaged is not entered.
>
> [1] https://lore.kernel.org/linux-mm/20250714003207.113275-1-npache@redha=
t.com/

Thanks for the information.
It seems extending this to use a bitmask would better accommodate
future changes.
I=E2=80=99ll give it some thought.

>
> >               __khugepaged_enter(mm);
> >  }
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 781be3240e21..5d05a537ecde 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -908,6 +908,18 @@ config NO_PAGE_MAPCOUNT
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
> > +
> >  endif # TRANSPARENT_HUGEPAGE
> >
> >  # simple helper to make the code a bit easier to read
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 1a7a11d4933d..562525e6a28a 100644
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
> > index 000000000000..10b486dd8bc4
> > --- /dev/null
> > +++ b/mm/bpf_thp.c
> > @@ -0,0 +1,172 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +struct bpf_thp_ops {
> > +     /**
> > +      * @get_suggested_order: Get the suggested highest THP order for =
allocation
> > +      * @mm: mm_struct associated with the THP allocation
> > +      * @tva_flags: TVA flags for current context
> > +      *             %TVA_IN_PF: Set when in page fault context
> > +      *             Other flags: Reserved for future use
> > +      * @order: The highest order being considered for this THP alloca=
tion.
> > +      *         %PUD_ORDER for PUD-mapped allocations
>
> Like I mentioned in the cover letter, PMD_ORDER is the highest order
> mm currently supports. I wonder if it is better to be a bitmask of orders
> to better support mTHP.

I=E2=80=99ll look into it.

Regards
Yafang

