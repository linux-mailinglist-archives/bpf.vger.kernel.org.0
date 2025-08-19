Return-Path: <bpf+bounces-65996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A2B2BFEE
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FC51BC060A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35E326D68;
	Tue, 19 Aug 2025 11:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAB322DCE
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601870; cv=none; b=nLvUOvJmjHri+Huj66OxIjABAu0N1SaUjg96FqXge9WVk7tto+ExC6F3q3dAJWfnHInsmgqoHeAz8IOwUM3oh50zAnGp0+ufDrojldl35h1lgbUYhlcCXoAk8BaQcUVsdRO+HaYOAH+YDERteNBQMjv5Vw/8EI4WwWS1TYweeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601870; c=relaxed/simple;
	bh=XMW75Y2aDAwkSQNyADF1eySa1c0pn28LuGWPeNZW2gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NSuSk482TWOK0enAmD9OnpwYchQAOFXJXIOCywK0lNj3T8MM0oZ73Ozh8x3ruYvjuzD1xyQB8B0UHmDSMD0VrBQMvzvzooLFtvCfEGyl1IbEsAne6YnWGMc0gcHPHv7jZiphimddDxlSw8S5cUnnlVe8A909wR6D0aafjM8e9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5myq4b1Fz6H88F;
	Tue, 19 Aug 2025 19:08:03 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 706B014037D;
	Tue, 19 Aug 2025 19:11:03 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 14:11:02 +0300
Message-ID: <7d458b5a-6920-472a-a83c-764c0f00c156@huawei-partners.com>
Date: Tue, 19 Aug 2025 14:10:36 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 mm-new 1/5] mm: thp: add support for BPF based THP
 order selection
To: Usama Arif <usamaarif642@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <hannes@cmpxchg.org>, <willy@infradead.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<ameryhung@gmail.com>, <rientjes@google.com>
CC: <bpf@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250818055510.968-1-laoar.shao@gmail.com>
 <20250818055510.968-2-laoar.shao@gmail.com>
 <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi,

On 8/18/2025 4:17 PM, Usama Arif wrote:
> 
> 
> On 18/08/2025 06:55, Yafang Shao wrote:
>> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
>> THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
>> programs to influence THP order selection based on factors such as:
>> - Workload identity
>>   For example, workloads running in specific containers or cgroups.
>> - Allocation context
>>   Whether the allocation occurs during a page fault, khugepaged, or other
>>   paths.
>> - System memory pressure
>>   (May require new BPF helpers to accurately assess memory pressure.)
>>
>> Key Details:
>> - Only one BPF program can be attached at a time, but it can be updated
>>   dynamically to adjust the policy.
>> - Supports automatic mTHP order selection and per-workload THP policies.
>> - Only functional when THP is set to madise or always.
>>
>> It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
>> This feature is unstable and may evolve in future kernel versions.
>>
>> Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0]
>> Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local/ [1]
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> ---
>>  include/linux/huge_mm.h    |  15 +++
>>  include/linux/khugepaged.h |  12 ++-
>>  mm/Kconfig                 |  12 +++
>>  mm/Makefile                |   1 +
>>  mm/bpf_thp.c               | 186 +++++++++++++++++++++++++++++++++++++
>>  mm/huge_memory.c           |  10 ++
>>  mm/khugepaged.c            |  26 +++++-
>>  mm/memory.c                |  18 +++-
>>  8 files changed, 273 insertions(+), 7 deletions(-)
>>  create mode 100644 mm/bpf_thp.c
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 1ac0d06fb3c1..f0c91d7bd267 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -6,6 +6,8 @@
>>  
>>  #include <linux/fs.h> /* only for vma_is_dax() */
>>  #include <linux/kobject.h>
>> +#include <linux/pgtable.h>
>> +#include <linux/mm.h>
>>  
>>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>> @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
>>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
>> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
>>  };
>>  
>>  struct kobject;
>> @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void)
>>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
>>  }
>>  
>> +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
>> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +			u64 vma_flags, enum tva_type tva_flags, int orders);
>> +#else
>> +static inline int
>> +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +		    u64 vma_flags, enum tva_type tva_flags, int orders)
>> +{
>> +	return orders;
>> +}
>> +#endif
>> +
>>  static inline int highest_order(unsigned long orders)
>>  {
>>  	return fls_long(orders) - 1;
>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
>> index eb1946a70cff..d81c1228a21f 100644
>> --- a/include/linux/khugepaged.h
>> +++ b/include/linux/khugepaged.h
>> @@ -4,6 +4,8 @@
>>  
>>  #include <linux/mm.h>
>>  
>> +#include <linux/huge_mm.h>
>> +
>>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  extern struct attribute_group khugepaged_attr_group;
>> @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>  
>>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>>  {
>> -	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
>> +	/*
>> +	 * THP allocation policy can be dynamically modified via BPF. Even if a
>> +	 * task was allowed to allocate THPs, BPF can decide whether its forked
>> +	 * child can allocate THPs.
>> +	 *
>> +	 * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
>> +	 */
>> +	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
>> +		get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> 
> Hi Yafang,
> 
> From the coverletter, one of the potential usecases you are trying to solve for is if global policy
> is "never", but the workload want THPs (either always or on madvise basis). But over here,
> MMF_VM_HUGEPAGE will never be set so in that case mm_flags_test(MMF_VM_HUGEPAGE, oldmm) will
> always evaluate to false and the get_sugested_order call doesnt matter?
> 
> 
> 
>>  		__khugepaged_enter(mm);
>>  }
>>  
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 4108bcd96784..d10089e3f181 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
>>  
>>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>>  
>> +config EXPERIMENTAL_BPF_ORDER_SELECTION
>> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
>> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
>> +
>> +	help
>> +	  Enable dynamic THP order selection using BPF programs. This
>> +	  experimental feature allows custom BPF logic to determine optimal
>> +	  transparent hugepage allocation sizes at runtime.
>> +
>> +	  Warning: This feature is unstable and may change in future kernel
>> +	  versions.
>> +
> 
> 
> I know there was a discussion on this earlier, but my opinion is that putting all of this
> as experiment with warnings is not great. No one will be able to deploy this in production
> if its going to be removed, and I believe thats where the real usage is.
> 
If the goal is to deploy it in Kubernetes, I believe eBPF is the wrong way to do it. Right 
now eBPF is used mainly for networking (CNI).

Kubernetes currently has something called Dynamic Resource Allocation (DRA), which is already 
in alpha version. It's main use is to share GPU and TPU among many pods. Still, we should 
take into account how likely the user space is going to use eBPF for controlling resources and 
how it integrates with the mechanisms currently available for resource control by the user 
space.

There is another scenario, when you you have a number of pods and a limit of huge pages you 
want to use among them. Something similar to HugeTLBfs. Could this be achieved with your 
ebpf implementation?

>>  endif # TRANSPARENT_HUGEPAGE
>>  
>>  # simple helper to make the code a bit easier to read
>> diff --git a/mm/Makefile b/mm/Makefile
>> index ef54aa615d9d..cb55d1509be1 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>>  obj-$(CONFIG_NUMA) += memory-tiers.o
>>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>> +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
>>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
>> new file mode 100644
>> index 000000000000..2b03539452d1
>> --- /dev/null
>> +++ b/mm/bpf_thp.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bpf.h>
>> +#include <linux/btf.h>
>> +#include <linux/huge_mm.h>
>> +#include <linux/khugepaged.h>
>> +
>> +struct bpf_thp_ops {
>> +	/**
>> +	 * @get_suggested_order: Get the suggested THP orders for allocation
>> +	 * @mm: mm_struct associated with the THP allocation
>> +	 * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
>> +	 *                 When NULL, the decision should be based on @mm (i.e., when
>> +	 *                 triggered from an mm-scope hook rather than a VMA-specific
>> +	 *                 context).
>> +	 *                 Must belong to @mm (guaranteed by the caller).
>> +	 * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
>> +	 * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
>> +	 * @orders: Bitmask of requested THP orders for this allocation
>> +	 *          - PMD-mapped allocation if PMD_ORDER is set
>> +	 *          - mTHP allocation otherwise
>> +	 *
>> +	 * Rerurn: Bitmask of suggested THP orders for allocation. The highest
>> +	 *         suggested order will not exceed the highest requested order
>> +	 *         in @orders.
> 
> If we want to make this generic enough so that it doesnt change, should we allow suggested order to
> exceed highest requested order?
> 
>> +	 */
>> +	int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +				   u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;
>> +};
>> +
>> +static struct bpf_thp_ops bpf_thp;
>> +static DEFINE_SPINLOCK(thp_ops_lock);
>> +
>> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +			u64 vma_flags, enum tva_type tva_flags, int orders)
>> +{
>> +	int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +				   u64 vma_flags, enum tva_type tva_flags, int orders);
>> +	int suggested_orders = orders;
>> +
>> +	/* No BPF program is attached */
>> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>> +		      &transparent_hugepage_flags))
>> +		return suggested_orders;
>> +
>> +	rcu_read_lock();
>> +	bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
>> +	if (!bpf_suggested_order)
>> +		goto out;
> 
> 
> My rcu API knowledge is not the best, but maybe we could do:
> 
> if (!rcu_access_pointer(bpf_thp.get_suggested_order))
> 	return suggested_orders;
> 
> rcu_read_lock();
> bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
> 
> I believe this might be better as you dont acquire the rcu_read_lock and avoid
> the lockdep checks when you do rcu_access_pointer, but I might be wrong
> and hope you or someone on the mailing list corrects me if thats the case :)
> 
>> +
>> +	suggested_orders = bpf_suggested_order(mm, vma__nullable, vma_flags, tva_flags, orders);
>> +	if (highest_order(suggested_orders) > highest_order(orders))
>> +		suggested_orders = orders;
>> +
> 
> Maybe we should allow suggested_order to be greater than order if we want this to be truly generic?
> Not a suggestion to change, just to have a discussion.
> 
>> +out:
>> +	rcu_read_unlock();
>> +	return suggested_orders;
>> +}
>> +
>> +static bool bpf_thp_ops_is_valid_access(int off, int size,
>> +					enum bpf_access_type type,
>> +					const struct bpf_prog *prog,
>> +					struct bpf_insn_access_aux *info)
>> +{
>> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
>> +}
>> +
>> +static const struct bpf_func_proto *
>> +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>> +{
>> +	return bpf_base_func_proto(func_id, prog);
>> +}
>> +
>> +static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
>> +	.get_func_proto = bpf_thp_get_func_proto,
>> +	.is_valid_access = bpf_thp_ops_is_valid_access,
>> +};
>> +
>> +static int bpf_thp_init(struct btf *btf)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int bpf_thp_init_member(const struct btf_type *t,
>> +			       const struct btf_member *member,
>> +			       void *kdata, const void *udata)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
>> +{
>> +	struct bpf_thp_ops *ops = kdata;
>> +
>> +	spin_lock(&thp_ops_lock);
>> +	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>> +		&transparent_hugepage_flags)) {
>> +		spin_unlock(&thp_ops_lock);
>> +		return -EBUSY;
>> +	}
>> +	WARN_ON_ONCE(bpf_thp.get_suggested_order);
> 
> Should it be WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order)) ?
> 
>> +	WRITE_ONCE(bpf_thp.get_suggested_order, ops->get_suggested_order);
> 
> Should it be rcu_assign_pointer instead of WRITE_ONCE?
> 
>> +	spin_unlock(&thp_ops_lock);
>> +	return 0;
>> +}
>> +
>> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
>> +{
>> +	spin_lock(&thp_ops_lock);
>> +	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
>> +	WARN_ON_ONCE(!bpf_thp.get_suggested_order);
> 
> Maybe need to use use rcu_access_pointer here in the warning?
> 
>> +	rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is_held(&thp_ops_lock));
>> +	spin_unlock(&thp_ops_lock);
>> +
>> +	synchronize_rcu();
>> +}
>> +
>> +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
>> +{
>> +	struct bpf_thp_ops *ops = kdata;
>> +	struct bpf_thp_ops *old = old_kdata;
>> +	int ret = 0;
>> +
>> +	if (!ops || !old)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&thp_ops_lock);
>> +	/* The prog has aleady been removed. */
>> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags)) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>> +	WARN_ON_ONCE(!bpf_thp.get_suggested_order);
> 
> As above about using rcu_access_pointer.
> 
>> +	rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order,
>> +			    lockdep_is_held(&thp_ops_lock));
>> +
>> +out:
>> +	spin_unlock(&thp_ops_lock);
>> +	if (!ret)
>> +		synchronize_rcu();
>> +	return ret;
>> +}
>> +
>> +static int bpf_thp_validate(void *kdata)
>> +{
>> +	struct bpf_thp_ops *ops = kdata;
>> +
>> +	if (!ops->get_suggested_order) {
>> +		pr_err("bpf_thp: required ops isn't implemented\n");
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>> +			   u64 vma_flags, enum tva_type vm_flags, int orders)
>> +{
>> +	return orders;
>> +}
>> +
>> +static struct bpf_thp_ops __bpf_thp_ops = {
>> +	.get_suggested_order = suggested_order,
>> +};
>> +
>> +static struct bpf_struct_ops bpf_bpf_thp_ops = {
>> +	.verifier_ops = &thp_bpf_verifier_ops,
>> +	.init = bpf_thp_init,
>> +	.init_member = bpf_thp_init_member,
>> +	.reg = bpf_thp_reg,
>> +	.unreg = bpf_thp_unreg,
>> +	.update = bpf_thp_update,
>> +	.validate = bpf_thp_validate,
>> +	.cfi_stubs = &__bpf_thp_ops,
>> +	.owner = THIS_MODULE,
>> +	.name = "bpf_thp_ops",
>> +};
>> +
>> +static int __init bpf_thp_ops_init(void)
>> +{
>> +	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
>> +
>> +	if (err)
>> +		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
>> +	return err;
>> +}
>> +late_initcall(bpf_thp_ops_init);
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d89992b65acc..bd8f8f34ab3c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>  		return ret;
>>  	khugepaged_enter_vma(vma, vma->vm_flags);
>>  
>> +	/*
>> +	 * This check must occur after khugepaged_enter_vma() because:
>> +	 * 1. We may permit THP allocation via khugepaged
>> +	 * 2. While simultaneously disallowing THP allocation
>> +	 *    during page fault handling
>> +	 */
>> +	if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_PAGEFAULT, BIT(PMD_ORDER)) !=
>> +				BIT(PMD_ORDER))
>> +		return VM_FAULT_FALLBACK;
>> +
>>  	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
>>  			!mm_forbids_zeropage(vma->vm_mm) &&
>>  			transparent_hugepage_use_zero_page()) {
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d3d4f116e14b..935583626db6 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -474,7 +474,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>>  {
>>  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>>  	    hugepage_pmd_enabled()) {
>> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER) &&
>> +		    get_suggested_order(vma->vm_mm, vma, vm_flags, TVA_KHUGEPAGED,
>> +					BIT(PMD_ORDER)))
>>  			__khugepaged_enter(vma->vm_mm);
>>  	}
>>  }
>> @@ -934,6 +936,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>  		return SCAN_ADDRESS_RANGE;
>>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
>>  		return SCAN_VMA_CHECK;
>> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, type, BIT(PMD_ORDER)))
>> +		return SCAN_VMA_CHECK;
>>  	/*
>>  	 * Anon VMA expected, the address may be unmapped then
>>  	 * remapped to file after khugepaged reaquired the mmap_lock.
>> @@ -1465,6 +1469,11 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>>  		/* khugepaged_mm_lock actually not necessary for the below */
>>  		mm_slot_free(mm_slot_cache, mm_slot);
>>  		mmdrop(mm);
>> +	} else if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER))) {
>> +		hash_del(&slot->hash);
>> +		list_del(&slot->mm_node);
>> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>> +		mm_slot_free(mm_slot_cache, mm_slot);
>>  	}
>>  }
>>  
>> @@ -1538,6 +1547,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>>  		return SCAN_VMA_CHECK;
>>  
>> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
>> +				 BIT(PMD_ORDER)))
>> +		return SCAN_VMA_CHECK;
>>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
>>  	if (userfaultfd_wp(vma))
>>  		return SCAN_PTE_UFFD_WP;
>> @@ -2416,6 +2428,10 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>  	 * the next mm on the list.
>>  	 */
>>  	vma = NULL;
>> +
>> +	/* If this mm is not suitable for the scan list, we should remove it. */
>> +	if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
>> +		goto breakouterloop_mmap_lock;
>>  	if (unlikely(!mmap_read_trylock(mm)))
>>  		goto breakouterloop_mmap_lock;
>>  
>> @@ -2432,7 +2448,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>  			progress++;
>>  			break;
>>  		}
>> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>> +		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER) ||
>> +		    !get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_KHUGEPAGED,
>> +					 BIT(PMD_ORDER))) {
>>  skip:
>>  			progress++;
>>  			continue;
>> @@ -2769,6 +2787,10 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>>  		return -EINVAL;
>>  
>> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
>> +				 BIT(PMD_ORDER)))
>> +		return -EINVAL;
>> +
>>  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
>>  	if (!cc)
>>  		return -ENOMEM;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d9de6c056179..0178857aa058 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4486,6 +4486,7 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
>>  static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>  {
>>  	struct vm_area_struct *vma = vmf->vma;
>> +	int order, suggested_orders;
>>  	unsigned long orders;
>>  	struct folio *folio;
>>  	unsigned long addr;
>> @@ -4493,7 +4494,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>  	spinlock_t *ptl;
>>  	pte_t *pte;
>>  	gfp_t gfp;
>> -	int order;
>>  
>>  	/*
>>  	 * If uffd is active for the vma we need per-page fault fidelity to
>> @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>  	if (!zswap_never_enabled())
>>  		goto fallback;
>>  
>> +	suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
>> +					       TVA_PAGEFAULT,
>> +					       BIT(PMD_ORDER) - 1);
>> +	if (!suggested_orders)
>> +		goto fallback;
>>  	entry = pte_to_swp_entry(vmf->orig_pte);
>>  	/*
>>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>  	 * and suitable for swapping THP.
>>  	 */
>>  	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
>> -					  BIT(PMD_ORDER) - 1);
>> +					  suggested_orders);
>>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>  	orders = thp_swap_suitable_orders(swp_offset(entry),
>>  					  vmf->address, orders);
>> @@ -5044,12 +5049,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>  {
>>  	struct vm_area_struct *vma = vmf->vma;
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	int order, suggested_orders;
>>  	unsigned long orders;
>>  	struct folio *folio;
>>  	unsigned long addr;
>>  	pte_t *pte;
>>  	gfp_t gfp;
>> -	int order;
>>  
>>  	/*
>>  	 * If uffd is active for the vma we need per-page fault fidelity to
>> @@ -5058,13 +5063,18 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>  	if (unlikely(userfaultfd_armed(vma)))
>>  		goto fallback;
>>  
>> +	suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
>> +					       TVA_PAGEFAULT,
>> +					       BIT(PMD_ORDER) - 1);
>> +	if (!suggested_orders)
>> +		goto fallback;
>>  	/*
>>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>  	 * for this vma. Then filter out the orders that can't be allocated over
>>  	 * the faulting address and still be fully contained in the vma.
>>  	 */
>>  	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
>> -					  BIT(PMD_ORDER) - 1);
>> +					  suggested_orders);
>>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>  
>>  	if (!orders)
> 
> 

-- 
Asier Gutierrez
Huawei


