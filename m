Return-Path: <bpf+bounces-69848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50501BA45EA
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332114A1261
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049541FBEA2;
	Fri, 26 Sep 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8pBYjL/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA01A9FBE
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899616; cv=none; b=ATVnjANmWvRhugErw3FjNJcGjF2HiFE2ZmP/JO8o3TLpqILOeZmSCySaOleTI6E3tLFlNMXaVg55rNGcYH171Q+HvzRM8EnSCR+e8R4+Pj7OjZjDWWY2qGKEMTh38TiH0yHVlfBJ+vLRvVShsloFJQEiBh2P8JPMBhpzWGxdk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899616; c=relaxed/simple;
	bh=s7F6GJT+22FiRgE4YXkqDcHFhcXereC+8vtnRu3vXZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhCDPV54LoIwHB3IRixwXA75x57FozmGinI2CDSDAucUwr48AJeDMiVTpOVOb0no8a0ZOy5rVnj+1tLKo4nhgxjxbwsY8LvvmuW0Kxbsiqs6k47PrIEo3kYoCnJa1fvV3vZBuIkoUBY4pM5BywcQVhsDggfTwY2jbv99nRFVQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8pBYjL/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1640027f8f.3
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758899612; x=1759504412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhtyBota5SG0ZAohFmugv1mltFcEigM7VyFxAyvdoGU=;
        b=Z8pBYjL/xLT38zMrjaBMW2oZmEK8e2K4VB7yPqOomB/9GqYxhq/rBrTbEFR4af5u6K
         a6VlvL3r5x0o2s5GZZWdRfq6Mw//D0taoqBLM414j/dY+W8JJp93PDQUsdlHcFcwtkIF
         sQv0wFVoEmNlhGBp074sXkM4YoR7OdoX4WvfcpuALH2ks/KeaX7wABMzLi9NdkO5tsoI
         TIsuNJ4OWwIZJ1Pad5hkWbV6CDPJhxc827vNMfJT/L7Yjd6Rft92Xc+rfZZtioxBgzpp
         avxVPvpjtuedQjOM2lLOYO1JhrOhwpFt8stxSDngy8mKZKbRJf2Yz8k0wDBYE5q7hE5l
         9MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899612; x=1759504412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhtyBota5SG0ZAohFmugv1mltFcEigM7VyFxAyvdoGU=;
        b=Cyva9f2GmwNtq2gUikK6Wd6dPDJSt/qgeU6mX9q5m6TtrCBZsFrE/fQ/X3DBDVUua/
         0XfHOt2guCyjgs+FaKSHX+iDJnKDyNBthv6yisk6wwkRmt6KHEGrUmiQEtW5i3SKSWfD
         rN1lsf8l8fo0au5iNbxSemC/RC/mwkswIb1QD3EZcI0sHKsBYm6COB8f53KxzHtaYGZQ
         vS52OdiyuaDJbeR4ZFWNHVxbrJmjFy1tD0fxB1QL+WHYl77xbpsQEExM9W91wMbEW0zB
         ZeQZbgi9TLBreJTRnjeGoE9PjlMCBmDpSbmLCQ85SZ4YfjmvJ8suYmxIWgbROKvJFDyV
         AkRw==
X-Gm-Message-State: AOJu0Ywzn4TluVVHbHqkjAg1XWnhxvQ0HVT6la3BCzWCdJ8PQ3BoyvDG
	IqobWHfg6Q3AL6Yk1YQ6jm1yBPAvg8wXJ1nqrs5X5Jwg52RiMmHI3alN
X-Gm-Gg: ASbGncusjvagltaPTNHBQyo1am4eeNf+Zi4bkFTlJtQhGvtNqZHg2sKTyr52S8gxmNH
	ky6eckAd93XfTtINj6W/csIv7oupiDW6BZwF53p4ixKGjKylSFJejEnIB55a5HINx0sHeE0YOs4
	/eVVSNV2Bg32QzpSJ60Kq6Kv77PzxWRANqNHgd1bIBc51o5VMNTk/tPT++B2oGsdgm7tgGSw1SF
	h19a6Kk7/a18leOweHDdLXNc9icCRDvzrq2R9t6nAIs8YV0IejdibEVtAEVaHF614y3v6OdQKip
	CGaBqmNW3bLAKJXU20tAtUqIna2YcTTSC2g0q56zBJgKDeY1oFpkvce0ZovvW63OIuztjvJv8um
	2ih7avOUdOp6qWLRBt3hEo3valAg168nQcQOtvau6QOLsxzyUobdAPPTJcAHA8J8mcSgbrWA7bU
	AGko69WUOIFgkxLwR/kqvGDOkcY2wm
X-Google-Smtp-Source: AGHT+IH3ajbe7vhTC6lcuJXDcjluXUUBAEeXkjep5KMm/cFj2+525ch3y8uHWArtYHiTW4yanFzxaA==
X-Received: by 2002:a05:6000:1447:b0:3ee:2ae2:3f34 with SMTP id ffacd0b85a97d-40e497c3458mr8048374f8f.13.1758899611592;
        Fri, 26 Sep 2025 08:13:31 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871c811sm7457233f8f.15.2025.09.26.08.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 08:13:30 -0700 (PDT)
Message-ID: <073d5246-6da7-4abb-93d6-38d814daedcc@gmail.com>
Date: Fri, 26 Sep 2025 16:13:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 04/12] mm: thp: add support for BPF based THP
 order selection
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com,
 shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926093343.1000-1-laoar.shao@gmail.com>
 <20250926093343.1000-5-laoar.shao@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250926093343.1000-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/09/2025 10:33, Yafang Shao wrote:
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
>  * thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
>  * @vma: vm_area_struct associated with the THP allocation
>  * @type: TVA type for current @vma
>  * @orders: Bitmask of available THP orders for this allocation
>  *
>  * Return: The suggested THP order for allocation from the BPF program. Must be
>  *         a valid, available order.
>  */
> typedef int thp_order_fn_t(struct vm_area_struct *vma,
> 			   enum tva_type type,
> 			   unsigned long orders);
> 
> Only a single BPF program can be attached at any given time, though it can
> be dynamically updated to adjust the policy. The implementation supports
> anonymous THP, shmem THP, and mTHP, with future extensions planned for
> file-backed THP.
> 
> This functionality is only active when system-wide THP is configured to
> madvise or always mode. It remains disabled in never mode. Additionally,
> if THP is explicitly disabled for a specific task via prctl(), this BPF
> functionality will also be unavailable for that task.
> 
> This BPF hook enables the implementation of flexible THP allocation
> policies at the system, per-cgroup, or per-task level.
> 
> This feature requires CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL to be
> enabled. Note that this capability is currently unstable and may undergo
> significant changes—including potential removal—in future kernel versions.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  MAINTAINERS             |   1 +
>  include/linux/huge_mm.h |  23 +++++
>  mm/Kconfig              |  12 +++
>  mm/Makefile             |   1 +
>  mm/huge_memory_bpf.c    | 204 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 241 insertions(+)
>  create mode 100644 mm/huge_memory_bpf.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca8e3d18eedd..7be34b2a64fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16257,6 +16257,7 @@ F:	include/linux/huge_mm.h
>  F:	include/linux/khugepaged.h
>  F:	include/trace/events/huge_memory.h
>  F:	mm/huge_memory.c
> +F:	mm/huge_memory_bpf.c
>  F:	mm/khugepaged.c
>  F:	mm/mm_slot.h
>  F:	tools/testing/selftests/mm/khugepaged.c
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index a635dcbb2b99..fea94c059bed 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
>  };
>  
>  struct kobject;
> @@ -269,6 +270,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 enum tva_type type,
>  					 unsigned long orders);
>  
> +#ifdef CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL
> +
> +unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
> +			unsigned long orders);
> +
> +#else
> +
> +static inline unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
> +			unsigned long orders)
> +{
> +	return orders;
> +}
> +
> +#endif
> +
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>   * @vma:  the vm area to check
> @@ -290,6 +308,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  {
>  	vm_flags_t vm_flags = vma->vm_flags;
>  
> +	/* The BPF-specified order overrides which order is selected. */
> +	orders &= bpf_hook_thp_get_orders(vma, type, orders);
> +	if (!orders)
> +		return 0;
> +
>  	/*
>  	 * Optimization to check if required orders are enabled early. Only
>  	 * forced collapse ignores sysfs configs.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index bde9f842a4a8..fd7459eecb2d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -895,6 +895,18 @@ config NO_PAGE_MAPCOUNT
>  
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>  
> +config BPF_THP_GET_ORDER_EXPERIMENTAL
> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> +
> +	help
> +	  Enable dynamic THP order selection using BPF programs. This
> +	  experimental feature allows custom BPF logic to determine optimal
> +	  transparent hugepage allocation sizes at runtime.
> +
> +	  WARNING: This feature is unstable and may change in future kernel
> +	  versions.
> +

I am assuming this series opens up the possibility of additional hooks being added in
the future. Instead of naming this BPF_THP_GET_ORDER_EXPERIMENTAL, should we
name it BPF_THP? Otherwise we will end up with 1 Kconfig option per hook, which
is quite bad.

Also It would be really nice if we dont put "EXPERIMENTAL" in the name of the defconfig.
If its decided that its not experimental anymore without any change to the code needed,
renaming the defconfig will break it for everyone.


>  endif # TRANSPARENT_HUGEPAGE
>  
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index 21abb3353550..62ebfa23635a 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> +obj-$(CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL) += huge_memory_bpf.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> new file mode 100644
> index 000000000000..b59a65d70a93
> --- /dev/null
> +++ b/mm/huge_memory_bpf.c
> @@ -0,0 +1,204 @@
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
> +/**
> + * @thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
> + * @vma: vm_area_struct associated with the THP allocation
> + * @type: TVA type for current @vma
> + * @orders: Bitmask of available THP orders for this allocation
> + *
> + * Return: The suggested THP order for allocation from the BPF program. Must be
> + *         a valid, available order.
> + */
> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> +			   enum tva_type type,
> +			   unsigned long orders);
> +
> +struct bpf_thp_ops {
> +	thp_order_fn_t __rcu *thp_get_order;
> +};
> +
> +static struct bpf_thp_ops bpf_thp;
> +static DEFINE_SPINLOCK(thp_ops_lock);
> +
> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +				      enum tva_type type,
> +				      unsigned long orders)
> +{
> +	thp_order_fn_t *bpf_hook_thp_get_order;
> +	int bpf_order;
> +
> +	/* No BPF program is attached */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags))
> +		return orders;
> +
> +	rcu_read_lock();
> +	bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
> +	if (!bpf_hook_thp_get_order)

Should we warn over here if we are going to out? TRANSPARENT_HUGEPAGE_BPF_ATTACHED
being set + !bpf_hook_thp_get_order shouldnt be possible, right?

> +		goto out;
> +
> +	bpf_order = bpf_hook_thp_get_order(vma, type, orders);
> +	orders &= BIT(bpf_order);
> +
> +out:
> +	rcu_read_unlock();
> +	return orders;
> +}
> +
> +static bool bpf_thp_ops_is_valid_access(int off, int size,
> +					enum bpf_access_type type,
> +					const struct bpf_prog *prog,
> +					struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_func_proto *
> +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return bpf_base_func_proto(func_id, prog);
> +}
> +
> +static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
> +	.get_func_proto = bpf_thp_get_func_proto,
> +	.is_valid_access = bpf_thp_ops_is_valid_access,
> +};
> +
> +static int bpf_thp_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static int bpf_thp_check_member(const struct btf_type *t,
> +				const struct btf_member *member,
> +				const struct bpf_prog *prog)
> +{
> +	/* The call site operates under RCU protection. */
> +	if (prog->sleepable)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bpf_thp_init_member(const struct btf_type *t,
> +			       const struct btf_member *member,
> +			       void *kdata, const void *udata)
> +{
> +	return 0;
> +}
> +
> +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +
> +	spin_lock(&thp_ops_lock);
> +	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +			     &transparent_hugepage_flags)) {
> +		spin_unlock(&thp_ops_lock);
> +		return -EBUSY;
> +	}
> +	WARN_ON_ONCE(rcu_access_pointer(bpf_thp.thp_get_order));
> +	rcu_assign_pointer(bpf_thp.thp_get_order, ops->thp_get_order);
> +	spin_unlock(&thp_ops_lock);
> +	return 0;
> +}
> +
> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> +{
> +	thp_order_fn_t *old_fn;
> +
> +	spin_lock(&thp_ops_lock);
> +	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> +	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, NULL,
> +				     lockdep_is_held(&thp_ops_lock));
> +	WARN_ON_ONCE(!old_fn);
> +	spin_unlock(&thp_ops_lock);
> +
> +	synchronize_rcu();
> +}
> +
> +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
> +{
> +	thp_order_fn_t *old_fn, *new_fn;
> +	struct bpf_thp_ops *old = old_kdata;
> +	struct bpf_thp_ops *ops = kdata;
> +	int ret = 0;
> +
> +	if (!ops || !old)
> +		return -EINVAL;
> +
> +	spin_lock(&thp_ops_lock);
> +	/* The prog has aleady been removed. */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	new_fn = rcu_dereference(ops->thp_get_order);
> +	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, new_fn,
> +				     lockdep_is_held(&thp_ops_lock));
> +	WARN_ON_ONCE(!old_fn || !new_fn);
> +
> +out:
> +	spin_unlock(&thp_ops_lock);
> +	if (!ret)
> +		synchronize_rcu();
> +	return ret;
> +}
> +
> +static int bpf_thp_validate(void *kdata)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +
> +	if (!ops->thp_get_order) {
> +		pr_err("bpf_thp: required ops isn't implemented\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int bpf_thp_get_order(struct vm_area_struct *vma,
> +			     enum tva_type type,
> +			     unsigned long orders)
> +{
> +	return -1;
> +}
> +
> +static struct bpf_thp_ops __bpf_thp_ops = {
> +	.thp_get_order = (thp_order_fn_t __rcu *)bpf_thp_get_order,
> +};
> +
> +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> +	.verifier_ops = &thp_bpf_verifier_ops,
> +	.init = bpf_thp_init,
> +	.check_member = bpf_thp_check_member,
> +	.init_member = bpf_thp_init_member,
> +	.reg = bpf_thp_reg,
> +	.unreg = bpf_thp_unreg,
> +	.update = bpf_thp_update,
> +	.validate = bpf_thp_validate,
> +	.cfi_stubs = &__bpf_thp_ops,
> +	.owner = THIS_MODULE,
> +	.name = "bpf_thp_ops",
> +};
> +
> +static int __init bpf_thp_ops_init(void)
> +{
> +	int err;
> +
> +	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +	if (err)
> +		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> +	return err;
> +}
> +late_initcall(bpf_thp_ops_init);


