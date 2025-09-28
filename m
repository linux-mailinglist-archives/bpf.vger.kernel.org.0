Return-Path: <bpf+bounces-69912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCAABA663F
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8659917A7C3
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD324729D;
	Sun, 28 Sep 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJMrghd+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47E1B423B
	for <bpf@vger.kernel.org>; Sun, 28 Sep 2025 02:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025649; cv=none; b=uJnc/4N0uwyic9cFTV6a60S/pErc69wj17GPKMoU3lJ5jLUjNY5cYI40I/wIVpZ5dwQVFb7aSpG3cfCP1I9gFSJDky2PSK3C2I058Kc3c0FwSMV0UOZxfKCu8fRVjxSeeCkTxNNk2YN4JGpD8NWahOAV/vytOtmICIFWY80xrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025649; c=relaxed/simple;
	bh=IH83jEiyJrKrhlVsP4em5vaOm3ovsNKL/2Uh1Adnpk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwIiBpKGaDHIAn5tabDysl9aHuieR8Sv9Wq3VRPTmYobooyx8ft8UhL/MvOQ/Wge+71+sWiTghODRD73GcnIpX4EruC5vMpV8A9UKlKs7VpMtlsaiePZ6Tc5Qf3rmJj6j904ju7sDjprwAYO4Ts2DqX30Ff9m6NLcdu1pnLI4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJMrghd+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78e4056623fso27209626d6.2
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759025646; x=1759630446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgfyK+ERvcGdu6t0lNJixg5TdROYvSdbOndCTyoB1XA=;
        b=NJMrghd+NzTNy+rZLfNHIxKTh0zezSix1IpIyyWbtU14v+nX1F4T+5ltr4QrSIEnb9
         qhO7GkvsLzOwiUfAlkeJ9HXT1OnK4Heo68iLKsMQ7Pe+4D8j9NH3C7CY6UmVmt4v5ZSv
         otE3feIkUYBE1n/wM5woBGpyB+aLZYEzzpgJNVI61j1kznRwa91FTE6ihX1RhR/Lv1s0
         uc0B5tLWw2l2DRDfJoO6mgBBjaP3ViZUsg+CBcx6SvUcfBYc4ONwINJIX8ahmGe84hpT
         3iKnIRNxASYAEgNKX9lBN4eRHR3IC+BGoxOdzqfBPsoM6J17m2t0OInrX7lSVnRvVJEE
         67EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759025646; x=1759630446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgfyK+ERvcGdu6t0lNJixg5TdROYvSdbOndCTyoB1XA=;
        b=jjxtefZsX3oekj/T4s7Ay13QMF+DWtNYm+b4if/j5LJ21uf4gmBCgV8LvTlvSoiGQQ
         xMXfdNnUJLgiTDeFCE21gJ/HsKw4GMxt250ZVO4QU8QnL61eg0euQ9cDTs5YSfrrP1JR
         2lFEvMG65ZGrExmGPLcD3qRtd7+TY9YqoCDEIOFikNBN3KvdP+r2BWICgu/oGLrjJIBL
         BnJ/Ld1Q9L2oCA/Qgz481lFUN2+jYLv+MZU9p/2N+330KK/45uh8byR9A5MyDTfNUilS
         JDPd5OEelojc2f9DWNJFv4RtwFE0zLoTixsRgt8mCQm5YoDvEtG6P3oTp7x0pdZDVfVx
         Pl+w==
X-Forwarded-Encrypted: i=1; AJvYcCUSB7FUgYeTWzDerF2pJv9oKMyVf8nyNy9EQkHv2nov0fHW5og2FdqSKxWpn8GnE31q4Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDk6nkUJrLNjlELCytnAIuxA9ylVZxj3G/mpzwdwtgsF/uvW6
	imeZsiO70HPbYHMjs2dJhxGSEejf6wF0b3HpQF/QJZitK2jA4kWB+1Pd+2ugfBgLIByk9uQ0M57
	taL7RWCcZ2KWQ/SRCnW0QO/hnhKpxHjw=
X-Gm-Gg: ASbGncuUbA0f1BGBz0s/uXE2/av0oH/CQjEAFW8iT677SlHKyohMG110wYNJVgV5MEl
	Mj00lnRQAMRYY9EiQ+iDbY4gq3ayS1eg8fIXBiOubnVM6JGi/maZYmo+9UrxyQsFKHrDoihEWt4
	nSKvqtJqn8+Puu7yh8Z4oF84xkrMBdyfIrxIwf6hsOfHQPMPVpgkqCucLiOg2Mt+L1BDe0HUFjk
	wHU5738p8elTXXyesTjL+8HN9ZY677eiFt62YKNZzGUvqP+FFo=
X-Google-Smtp-Source: AGHT+IFBzSCWT9hh0pEexdSgkq3kl3qXsAZzuIThj+zxZ39IC7nb4rfO/kyEpmVN3tJ4CnGQisxqrYSyLve72cAkf2M=
X-Received: by 2002:a05:6214:21a3:b0:7ef:5587:5427 with SMTP id
 6a1803df08f44-7fc3ca0be80mr189169576d6.32.1759025645980; Sat, 27 Sep 2025
 19:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926093343.1000-1-laoar.shao@gmail.com> <20250926093343.1000-5-laoar.shao@gmail.com>
 <073d5246-6da7-4abb-93d6-38d814daedcc@gmail.com>
In-Reply-To: <073d5246-6da7-4abb-93d6-38d814daedcc@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 28 Sep 2025 10:13:29 +0800
X-Gm-Features: AS18NWAeAit0xGzG8ueU72wy7682FqeEqNkhZer2yoKGcZbdy1zHQ6f7MpL24z0
Message-ID: <CALOAHbCS1ndOUtMizCGxFRU8Xd9oJkK2GG1OmZVN1dEZ=iZmUw@mail.gmail.com>
Subject: Re: [PATCH v8 mm-new 04/12] mm: thp: add support for BPF based THP
 order selection
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:13=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 26/09/2025 10:33, Yafang Shao wrote:
> > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynam=
ic
> > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > programs to influence THP order selection based on factors such as:
> > - Workload identity
> >   For example, workloads running in specific containers or cgroups.
> > - Allocation context
> >   Whether the allocation occurs during a page fault, khugepaged, swap o=
r
> >   other paths.
> > - VMA's memory advice settings
> >   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > - Memory pressure
> >   PSI system data or associated cgroup PSI metrics
> >
> > The kernel API of this new BPF hook is as follows,
> >
> > /**
> >  * thp_order_fn_t: Get the suggested THP order from a BPF program for a=
llocation
> >  * @vma: vm_area_struct associated with the THP allocation
> >  * @type: TVA type for current @vma
> >  * @orders: Bitmask of available THP orders for this allocation
> >  *
> >  * Return: The suggested THP order for allocation from the BPF program.=
 Must be
> >  *         a valid, available order.
> >  */
> > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> >                          enum tva_type type,
> >                          unsigned long orders);
> >
> > Only a single BPF program can be attached at any given time, though it =
can
> > be dynamically updated to adjust the policy. The implementation support=
s
> > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > file-backed THP.
> >
> > This functionality is only active when system-wide THP is configured to
> > madvise or always mode. It remains disabled in never mode. Additionally=
,
> > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > functionality will also be unavailable for that task.
> >
> > This BPF hook enables the implementation of flexible THP allocation
> > policies at the system, per-cgroup, or per-task level.
> >
> > This feature requires CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL to be
> > enabled. Note that this capability is currently unstable and may underg=
o
> > significant changes=E2=80=94including potential removal=E2=80=94in futu=
re kernel versions.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  MAINTAINERS             |   1 +
> >  include/linux/huge_mm.h |  23 +++++
> >  mm/Kconfig              |  12 +++
> >  mm/Makefile             |   1 +
> >  mm/huge_memory_bpf.c    | 204 ++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 241 insertions(+)
> >  create mode 100644 mm/huge_memory_bpf.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ca8e3d18eedd..7be34b2a64fd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16257,6 +16257,7 @@ F:    include/linux/huge_mm.h
> >  F:   include/linux/khugepaged.h
> >  F:   include/trace/events/huge_memory.h
> >  F:   mm/huge_memory.c
> > +F:   mm/huge_memory_bpf.c
> >  F:   mm/khugepaged.c
> >  F:   mm/mm_slot.h
> >  F:   tools/testing/selftests/mm/khugepaged.c
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index a635dcbb2b99..fea94c059bed 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
> >       TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> > +     TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
> >  };
> >
> >  struct kobject;
> > @@ -269,6 +270,23 @@ unsigned long __thp_vma_allowable_orders(struct vm=
_area_struct *vma,
> >                                        enum tva_type type,
> >                                        unsigned long orders);
> >
> > +#ifdef CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL
> > +
> > +unsigned long
> > +bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type=
,
> > +                     unsigned long orders);
> > +
> > +#else
> > +
> > +static inline unsigned long
> > +bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type=
,
> > +                     unsigned long orders)
> > +{
> > +     return orders;
> > +}
> > +
> > +#endif
> > +
> >  /**
> >   * thp_vma_allowable_orders - determine hugepage orders that are allow=
ed for vma
> >   * @vma:  the vm area to check
> > @@ -290,6 +308,11 @@ unsigned long thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
> >  {
> >       vm_flags_t vm_flags =3D vma->vm_flags;
> >
> > +     /* The BPF-specified order overrides which order is selected. */
> > +     orders &=3D bpf_hook_thp_get_orders(vma, type, orders);
> > +     if (!orders)
> > +             return 0;
> > +
> >       /*
> >        * Optimization to check if required orders are enabled early. On=
ly
> >        * forced collapse ignores sysfs configs.
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index bde9f842a4a8..fd7459eecb2d 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -895,6 +895,18 @@ config NO_PAGE_MAPCOUNT
> >
> >         EXPERIMENTAL because the impact of some changes is still unclea=
r.
> >
> > +config BPF_THP_GET_ORDER_EXPERIMENTAL
> > +     bool "BPF-based THP order selection (EXPERIMENTAL)"
> > +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> > +
> > +     help
> > +       Enable dynamic THP order selection using BPF programs. This
> > +       experimental feature allows custom BPF logic to determine optim=
al
> > +       transparent hugepage allocation sizes at runtime.
> > +
> > +       WARNING: This feature is unstable and may change in future kern=
el
> > +       versions.
> > +
>
> I am assuming this series opens up the possibility of additional hooks be=
ing added in
> the future. Instead of naming this BPF_THP_GET_ORDER_EXPERIMENTAL, should=
 we
> name it BPF_THP? Otherwise we will end up with 1 Kconfig option per hook,=
 which
> is quite bad.

makes sense.

>
> Also It would be really nice if we dont put "EXPERIMENTAL" in the name of=
 the defconfig.
> If its decided that its not experimental anymore without any change to th=
e code needed,
> renaming the defconfig will break it for everyone.

makes sense to me.
Lorenzo, what do you think ?

>
>
> >  endif # TRANSPARENT_HUGEPAGE
> >
> >  # simple helper to make the code a bit easier to read
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 21abb3353550..62ebfa23635a 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
> >  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
> >  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> > +obj-$(CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL) +=3D huge_memory_bpf.o
> >  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
> >  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
> >  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > new file mode 100644
> > index 000000000000..b59a65d70a93
> > --- /dev/null
> > +++ b/mm/huge_memory_bpf.c
> > @@ -0,0 +1,204 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BPF-based THP policy management
> > + *
> > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +/**
> > + * @thp_order_fn_t: Get the suggested THP order from a BPF program for=
 allocation
> > + * @vma: vm_area_struct associated with the THP allocation
> > + * @type: TVA type for current @vma
> > + * @orders: Bitmask of available THP orders for this allocation
> > + *
> > + * Return: The suggested THP order for allocation from the BPF program=
. Must be
> > + *         a valid, available order.
> > + */
> > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > +                        enum tva_type type,
> > +                        unsigned long orders);
> > +
> > +struct bpf_thp_ops {
> > +     thp_order_fn_t __rcu *thp_get_order;
> > +};
> > +
> > +static struct bpf_thp_ops bpf_thp;
> > +static DEFINE_SPINLOCK(thp_ops_lock);
> > +
> > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > +                                   enum tva_type type,
> > +                                   unsigned long orders)
> > +{
> > +     thp_order_fn_t *bpf_hook_thp_get_order;
> > +     int bpf_order;
> > +
> > +     /* No BPF program is attached */
> > +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                   &transparent_hugepage_flags))
> > +             return orders;
> > +
> > +     rcu_read_lock();
> > +     bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_order)=
;
> > +     if (!bpf_hook_thp_get_order)
>
> Should we warn over here if we are going to out? TRANSPARENT_HUGEPAGE_BPF=
_ATTACHED
> being set + !bpf_hook_thp_get_order shouldnt be possible, right?

will add a warning in the next version.

--=20
Regards
Yafang

