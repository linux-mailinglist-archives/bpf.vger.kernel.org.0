Return-Path: <bpf+bounces-69688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C3B9E8ED
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165171B2278F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8632EA177;
	Thu, 25 Sep 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ncX4rO1v"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5B2868AC
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794788; cv=none; b=uZcUcrewmzTXO1A8+bE+dRTkvXTf/UwtHklxnaLmpzP6SCOgLL3UXewhDvNn7BUmMn6oLv8pS1tMZo0Qxlahm+pStTfgYdL0hWBsNsl3MYVfttAzwAzNN8XpoXaGiFWBn2AZ9cEfRLuPecF7S/i1tcfpHiKDsvNF1Y+qpK5hpJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794788; c=relaxed/simple;
	bh=Iw6WY4yLqnE4HyMvv9SiDOYBOunBzZP/vMpSrN3zyPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+I+ls+BgFy96cW6h6mc09ZvL5nnNJGwsFVnIxwo4dlE/ksz2rZ9VKyrkw6IpKZ0Tw32CmXG+1D5RF8kVdaxe4zc4OeDVRxIrswPyWLCo8mOFNcqPc87VgfrijwVDtjYb7wbm9ONSXZMnLCdziYYHzccIRz0rszZSFcd47EGk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ncX4rO1v; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW1aJ65+/2bKF5OdzejvVLHnT0U7cyZ0hPgGReGCs4d2kv82uSQKZvLGT2IB3Y1frYz0+o=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758794783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TtwmpZPCjNOwjMItaLVn8GYJUr1kz1Bfb1+TI3PcNUE=;
	b=ncX4rO1vCwfgct748/j/WsTXTPy8FPKYITbUBuH2LwP1riv/HhxMUSLmUlxjNDEsFperzv
	g2wIwqmbeANw8gky47ROBTk8k2JHHom1iCp1+LH+sHN4v4FQBwg9192b/UlO7INLGqKJw8
	3zxB2aEgCGPNdWiwlKJgFzzSkOWz3JQ=
X-Gm-Message-State: AOJu0YxQN9U0DGQJHIuyUSnAlaB+I1QHKxrrpsiwaRCbGinF5OYCsYCs
	jVA6OAVkeRKiYAW9AJTHd7F6i+uwLf0I/vALoqwHl8Ce/qw+kZe1T+0Q00BhoNWKRSooO6WeDPw
	qm0nrhBZ7bgZZgIp+plycK9IVQHe68j4=
X-Google-Smtp-Source: AGHT+IF71+HS7nj4AXMSTXwCRsiI/oIr44gPCeQOdfiXJRiyJBTrygGIFffFbShN0CYuQklLT8TN/1t/9FCPuUGyTcs=
X-Received: by 2002:a05:6214:4f05:b0:804:9bb6:fe77 with SMTP id
 6a1803df08f44-8049bb7022bmr13404236d6.49.1758794774193; Thu, 25 Sep 2025
 03:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
In-Reply-To: <20250910024447.64788-3-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 25 Sep 2025 18:05:36 +0800
X-Gmail-Original-Message-ID: <CABzRoyaFv4ciJwcdU=1qQNvSWE_PPQonn7ehE7Zz_PHNHfN4gA@mail.gmail.com>
X-Gm-Features: AS18NWA9LEHOEgT6nKT_-lHmoS0ZA6SZH1mIenV7DALkzBHtOcVtCyJGULS1h_k
Message-ID: <CABzRoyaFv4ciJwcdU=1qQNvSWE_PPQonn7ehE7Zz_PHNHfN4gA@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 10:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> programs to influence THP order selection based on factors such as:
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, swap or
>   other paths.
> - VMA's memory advice settings
>   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> - Memory pressure
>   PSI system data or associated cgroup PSI metrics
>
> The kernel API of this new BPF hook is as follows,
>
> /**
>  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for a=
llocation
>  * @vma: vm_area_struct associated with the THP allocation
>  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is=
 set
>  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_V=
M_NONE if
>  *            neither is set.
>  * @tva_type: TVA type for current @vma
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Return: The suggested THP order from the BPF program for allocation. I=
t will
>  *         not exceed the highest requested order in @orders. Return -1 t=
o
>  *         indicate that the original requested @orders should remain unc=
hanged.
>  */
> typedef int thp_order_fn_t(struct vm_area_struct *vma,
>                            enum bpf_thp_vma_type vma_type,
>                            enum tva_type tva_type,
>                            unsigned long orders);
>
> Only a single BPF program can be attached at any given time, though it ca=
n
> be dynamically updated to adjust the policy. The implementation supports
> anonymous THP, shmem THP, and mTHP, with future extensions planned for
> file-backed THP.
>
> This functionality is only active when system-wide THP is configured to
> madvise or always mode. It remains disabled in never mode. Additionally,
> if THP is explicitly disabled for a specific task via prctl(), this BPF
> functionality will also be unavailable for that task.
>
> This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to b=
e
> enabled. Note that this capability is currently unstable and may undergo
> significant changes=E2=80=94including potential removal=E2=80=94in future=
 kernel versions.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I've tested this patch on my machine, and it works as expected. Using BPF
hooks to control THP is a great step forward!

Tested-by: Lance Yang <lance.yang@linux.dev>

This work also inspires some ideas for another useful hook for THP that I
might propose in the future, once this series is settled and merged ;)

Cheers,
Lance

> ---
>  MAINTAINERS             |   1 +
>  include/linux/huge_mm.h |  26 ++++-
>  mm/Kconfig              |  12 ++
>  mm/Makefile             |   1 +
>  mm/huge_memory_bpf.c    | 243 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 280 insertions(+), 3 deletions(-)
>  create mode 100644 mm/huge_memory_bpf.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fef05bc2224..d055a3c95300 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16252,6 +16252,7 @@ F:      include/linux/huge_mm.h
>  F:     include/linux/khugepaged.h
>  F:     include/trace/events/huge_memory.h
>  F:     mm/huge_memory.c
> +F:     mm/huge_memory_bpf.c
>  F:     mm/khugepaged.c
>  F:     mm/mm_slot.h
>  F:     tools/testing/selftests/mm/khugepaged.c
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 23f124493c47..f72a5fd04e4f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
>         TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>         TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +       TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached *=
/
>  };
>
>  struct kobject;
> @@ -270,6 +271,19 @@ unsigned long __thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
>                                          enum tva_type type,
>                                          unsigned long orders);
>
> +#ifdef CONFIG_BPF_GET_THP_ORDER
> +unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags=
,
> +                       enum tva_type type, unsigned long orders);
> +#else
> +static inline unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags=
,
> +                       enum tva_type tva_flags, unsigned long orders)
> +{
> +       return orders;
> +}
> +#endif
> +
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed=
 for vma
>   * @vma:  the vm area to check
> @@ -291,6 +305,12 @@ unsigned long thp_vma_allowable_orders(struct vm_are=
a_struct *vma,
>                                        enum tva_type type,
>                                        unsigned long orders)
>  {
> +       unsigned long bpf_orders;
> +
> +       bpf_orders =3D bpf_hook_thp_get_orders(vma, vm_flags, type, order=
s);
> +       if (!bpf_orders)
> +               return 0;
> +
>         /*
>          * Optimization to check if required orders are enabled early. On=
ly
>          * forced collapse ignores sysfs configs.
> @@ -304,12 +324,12 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
>                     ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled(=
)))
>                         mask |=3D READ_ONCE(huge_anon_orders_inherit);
>
> -               orders &=3D mask;
> -               if (!orders)
> +               bpf_orders &=3D mask;
> +               if (!bpf_orders)
>                         return 0;
>         }
>
> -       return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
> +       return __thp_vma_allowable_orders(vma, vm_flags, type, bpf_orders=
);
>  }
>
>  struct thpsize {
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d1ed839ca710..4d89d2158f10 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -896,6 +896,18 @@ config NO_PAGE_MAPCOUNT
>
>           EXPERIMENTAL because the impact of some changes is still unclea=
r.
>
> +config BPF_GET_THP_ORDER
> +       bool "BPF-based THP order selection (EXPERIMENTAL)"
> +       depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> +
> +       help
> +         Enable dynamic THP order selection using BPF programs. This
> +         experimental feature allows custom BPF logic to determine optim=
al
> +         transparent hugepage allocation sizes at runtime.
> +
> +         WARNING: This feature is unstable and may change in future kern=
el
> +         versions.
> +
>  endif # TRANSPARENT_HUGEPAGE
>
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index 21abb3353550..f180332f2ad0 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) +=3D migrate.o
>  obj-$(CONFIG_NUMA) +=3D memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) +=3D migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) +=3D huge_memory.o khugepaged.o
> +obj-$(CONFIG_BPF_GET_THP_ORDER) +=3D huge_memory_bpf.o
>  obj-$(CONFIG_PAGE_COUNTER) +=3D page_counter.o
>  obj-$(CONFIG_MEMCG_V1) +=3D memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) +=3D memcontrol.o vmpressure.o
> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> new file mode 100644
> index 000000000000..525ee22ab598
> --- /dev/null
> +++ b/mm/huge_memory_bpf.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BPF-based THP policy management
> + *
> + * Author: Yafang Shao <laoar.shao@gmail.com>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +enum bpf_thp_vma_type {
> +       BPF_THP_VM_NONE =3D 0,
> +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> +};
> +
> +/**
> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for =
allocation
> + * @vma: vm_area_struct associated with the THP allocation
> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE i=
s set
> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_=
VM_NONE if
> + *            neither is set.
> + * @tva_type: TVA type for current @vma
> + * @orders: Bitmask of requested THP orders for this allocation
> + *          - PMD-mapped allocation if PMD_ORDER is set
> + *          - mTHP allocation otherwise
> + *
> + * Return: The suggested THP order from the BPF program for allocation. =
It will
> + *         not exceed the highest requested order in @orders. Return -1 =
to
> + *         indicate that the original requested @orders should remain un=
changed.
> + */
> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> +                          enum bpf_thp_vma_type vma_type,
> +                          enum tva_type tva_type,
> +                          unsigned long orders);
> +
> +struct bpf_thp_ops {
> +       thp_order_fn_t __rcu *thp_get_order;
> +};
> +
> +static struct bpf_thp_ops bpf_thp;
> +static DEFINE_SPINLOCK(thp_ops_lock);
> +
> +/*
> + * Returns the original @orders if no BPF program is attached or if the
> + * suggested order is invalid.
> + */
> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +                                     vm_flags_t vma_flags,
> +                                     enum tva_type tva_type,
> +                                     unsigned long orders)
> +{
> +       thp_order_fn_t *bpf_hook_thp_get_order;
> +       unsigned long thp_orders =3D orders;
> +       enum bpf_thp_vma_type vma_type;
> +       int thp_order;
> +
> +       /* No BPF program is attached */
> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +                     &transparent_hugepage_flags))
> +               return orders;
> +
> +       if (vma_flags & VM_HUGEPAGE)
> +               vma_type =3D BPF_THP_VM_HUGEPAGE;
> +       else if (vma_flags & VM_NOHUGEPAGE)
> +               vma_type =3D BPF_THP_VM_NOHUGEPAGE;
> +       else
> +               vma_type =3D BPF_THP_VM_NONE;
> +
> +       rcu_read_lock();
> +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_order)=
;
> +       if (!bpf_hook_thp_get_order)
> +               goto out;
> +
> +       thp_order =3D bpf_hook_thp_get_order(vma, vma_type, tva_type, ord=
ers);
> +       if (thp_order < 0)
> +               goto out;
> +       /*
> +        * The maximum requested order is determined by the callsite. E.g=
.:
> +        * - PMD-mapped THP uses PMD_ORDER
> +        * - mTHP uses (PMD_ORDER - 1)
> +        *
> +        * We must respect this upper bound to avoid undefined behavior. =
So the
> +        * highest suggested order can't exceed the highest requested ord=
er.
> +        */
> +       if (thp_order <=3D highest_order(orders))
> +               thp_orders =3D BIT(thp_order);
> +
> +out:
> +       rcu_read_unlock();
> +       return thp_orders;
> +}
> +
> +static bool bpf_thp_ops_is_valid_access(int off, int size,
> +                                       enum bpf_access_type type,
> +                                       const struct bpf_prog *prog,
> +                                       struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_func_proto *
> +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
> +{
> +       return bpf_base_func_proto(func_id, prog);
> +}
> +
> +static const struct bpf_verifier_ops thp_bpf_verifier_ops =3D {
> +       .get_func_proto =3D bpf_thp_get_func_proto,
> +       .is_valid_access =3D bpf_thp_ops_is_valid_access,
> +};
> +
> +static int bpf_thp_init(struct btf *btf)
> +{
> +       return 0;
> +}
> +
> +static int bpf_thp_check_member(const struct btf_type *t,
> +                               const struct btf_member *member,
> +                               const struct bpf_prog *prog)
> +{
> +       /* The call site operates under RCU protection. */
> +       if (prog->sleepable)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static int bpf_thp_init_member(const struct btf_type *t,
> +                              const struct btf_member *member,
> +                              void *kdata, const void *udata)
> +{
> +       return 0;
> +}
> +
> +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct bpf_thp_ops *ops =3D kdata;
> +
> +       spin_lock(&thp_ops_lock);
> +       if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +                            &transparent_hugepage_flags)) {
> +               spin_unlock(&thp_ops_lock);
> +               return -EBUSY;
> +       }
> +       WARN_ON_ONCE(rcu_access_pointer(bpf_thp.thp_get_order));
> +       rcu_assign_pointer(bpf_thp.thp_get_order, ops->thp_get_order);
> +       spin_unlock(&thp_ops_lock);
> +       return 0;
> +}
> +
> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> +{
> +       thp_order_fn_t *old_fn;
> +
> +       spin_lock(&thp_ops_lock);
> +       clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepag=
e_flags);
> +       old_fn =3D rcu_replace_pointer(bpf_thp.thp_get_order, NULL,
> +                                    lockdep_is_held(&thp_ops_lock));
> +       WARN_ON_ONCE(!old_fn);
> +       spin_unlock(&thp_ops_lock);
> +
> +       synchronize_rcu();
> +}
> +
> +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link =
*link)
> +{
> +       thp_order_fn_t *old_fn, *new_fn;
> +       struct bpf_thp_ops *old =3D old_kdata;
> +       struct bpf_thp_ops *ops =3D kdata;
> +       int ret =3D 0;
> +
> +       if (!ops || !old)
> +               return -EINVAL;
> +
> +       spin_lock(&thp_ops_lock);
> +       /* The prog has aleady been removed. */
> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +                     &transparent_hugepage_flags)) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +
> +       new_fn =3D rcu_dereference(ops->thp_get_order);
> +       old_fn =3D rcu_replace_pointer(bpf_thp.thp_get_order, new_fn,
> +                                    lockdep_is_held(&thp_ops_lock));
> +       WARN_ON_ONCE(!old_fn || !new_fn);
> +
> +out:
> +       spin_unlock(&thp_ops_lock);
> +       if (!ret)
> +               synchronize_rcu();
> +       return ret;
> +}
> +
> +static int bpf_thp_validate(void *kdata)
> +{
> +       struct bpf_thp_ops *ops =3D kdata;
> +
> +       if (!ops->thp_get_order) {
> +               pr_err("bpf_thp: required ops isn't implemented\n");
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static int bpf_thp_get_order(struct vm_area_struct *vma,
> +                            enum bpf_thp_vma_type vma_type,
> +                            enum tva_type tva_type,
> +                            unsigned long orders)
> +{
> +       return -1;
> +}
> +
> +static struct bpf_thp_ops __bpf_thp_ops =3D {
> +       .thp_get_order =3D (thp_order_fn_t __rcu *)bpf_thp_get_order,
> +};
> +
> +static struct bpf_struct_ops bpf_bpf_thp_ops =3D {
> +       .verifier_ops =3D &thp_bpf_verifier_ops,
> +       .init =3D bpf_thp_init,
> +       .check_member =3D bpf_thp_check_member,
> +       .init_member =3D bpf_thp_init_member,
> +       .reg =3D bpf_thp_reg,
> +       .unreg =3D bpf_thp_unreg,
> +       .update =3D bpf_thp_update,
> +       .validate =3D bpf_thp_validate,
> +       .cfi_stubs =3D &__bpf_thp_ops,
> +       .owner =3D THIS_MODULE,
> +       .name =3D "bpf_thp_ops",
> +};
> +
> +static int __init bpf_thp_ops_init(void)
> +{
> +       int err;
> +
> +       err =3D register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +       if (err)
> +               pr_err("bpf_thp: Failed to register struct_ops (%d)\n", e=
rr);
> +       return err;
> +}
> +late_initcall(bpf_thp_ops_init);
> --
> 2.47.3
>
>

