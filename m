Return-Path: <bpf+bounces-63631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD537B091AD
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4937A36E8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357BA2FC3D9;
	Thu, 17 Jul 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUCToMag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7D52F66
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769548; cv=none; b=f2ZPHgAdc6U+L31Nph3I1L2XsDTIG4VidqZa7LqwvVwnaPgP/EqCW1W03Ci/KWXZhetbdjy3mmmLO/BGSBmcpEQoD6LCE6Q+TnjkF08l+IIJV+FM0bvvNKc5IavniLlTKgTQ5Boj/0DJ7ruQWZvn7+qqWAHX37xt/jx8mXndQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769548; c=relaxed/simple;
	bh=XpwsVdVL6Do5Vg/ItUv84Hm+MGjMt+UNqrl3aRu/r5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrWh7fB8vCe18mYh0P5SXqHsMTuIkpBLN6vEfe5T2cBj1lGvLqEHkLiVuySSxDF38MgvmhTEK9fTQ8WNsa3L51RTxMIahwQT+Uc2t/Zf6QO+6sXGJdMbZXJwlPJ5WfSxNuX1mryz4zbhFnDa0C+7dx2tNfEQS3JUopUQrakKP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUCToMag; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adfb562266cso198094066b.0
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752769545; x=1753374345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EPkM4MV2NqCPptDvx5vWcMgE78ZZptHn3oX5iA9oSM=;
        b=KUCToMag6iCurqZdwOnVzHjWcm433zlas5uWg6bomr3wwyoTvZC3stC2r8O/aqvfkY
         FeyqVVQ0NaGErN4X6qJkMYLIBjPQa55nUguBvWXnz83m+S8BGbnzGPpYBR89sLcTwrlM
         BNd0qGe6bKm2mBBpnL9e5NdXaQvuOBz0TwP50bEEUsYHBaD0Cz9GVZN6sqfJ9bWPwQkN
         l9jf6dzj3Qon2WZ8sMRLnXAQJLFSWbGIj7Hu9YEqaak8FsODdALWPae7vse0kXCZUQ+Y
         sVLoftgwDWSJv+CiJdJVs6dAl3JgQ4pQhGjWeRzZCRy9El3Xa/igqZEKjS9SIaSUMD5K
         9INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769545; x=1753374345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EPkM4MV2NqCPptDvx5vWcMgE78ZZptHn3oX5iA9oSM=;
        b=w1EoMy8p1k72iuXzEfHQAQCAfaERZFH+6NtyHr39dlbUS4lCiRPequhgwezTsCiqnL
         tdc3qOOE2OzBr70Ro8rT8em9UTAjAlpflag2UXtrMwjHBcjTWYAgCCNtxsNL8HFlE3xQ
         NLaPLe7/bhdb7mk4qlBnhfbxc+fUOECJRSRcVCHNkmTeaClzPDm3EcW+8lOlb0Dpbdsq
         +cizT5ITVs6Vt8BeZLs0AYfhZO5MlBQ7nrEFS3Oda5xb0x3XkhFTKRxU1pIgZaG6fwQC
         pKpprVwWH9Kjk0Grd2fwVbv/fRGitduNIt/6pC0jhamVfX9DB4J0VgWz26r8kgGj9MKU
         /G3A==
X-Gm-Message-State: AOJu0YwFFfd44N1tPLaa00+lX4v7gPtlzYqLPcesXXgsQP8MZdKGMTR1
	sqUS5uD95Caz/+ES9OjACRCm/PF0Fg+Z4yYIWGf1CPyAOM3tMb5BJlhl
X-Gm-Gg: ASbGncvRA4BCjsrccYBOwPHiqvi//Jz7snOivX7IOR50IjnGTcJoGyqTQUeRka8BDPc
	uhom/5Up/621hWhqC95Cz87uOWAFIeaeBJyjFLCwRmI6tpW4nmcYYeOrkpFu2ZSx2dZM24uMTnW
	d3SolMGWdYY3iLKETWg6Fsrqq6ak84rviImjqEE14v2AgxiRaolMkBOyINyLofU+LwgfyJMC+1U
	m3w0zPIfZpptfSfexCuZHG9TwuFa0FpBPO7Rl4RJrX9tTauz1A75nED5TavtM2/7kh07a6hNUBS
	RYzEvF3cP2GpqGuGPNqiDZ+A+ZYyS9wl91uPXRQX1OJoHhQJZEFg/OqKmEyiaKxCN+Jq9NPnf2W
	LYl1Tu4WF3t9ZRVgyEKe7rhIbAbYRGGRH3xgzgHS0Iotw7atEr6ForE5HCFykWhCAx9EpKdw=
X-Google-Smtp-Source: AGHT+IHeLcr1pBbKBFA1pU6Brp5R8o8KUPnlWlbjIIlH4I6mN0jgJFRhVmH47BFgYKizmcvJjONjqA==
X-Received: by 2002:a17:907:9809:b0:ae0:b22a:29b4 with SMTP id a640c23a62f3a-ae9c9ac18c2mr754671866b.39.1752769544566;
        Thu, 17 Jul 2025 09:25:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8a92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a16sm1378047466b.24.2025.07.17.09.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:25:43 -0700 (PDT)
Message-ID: <c7de5a5b-60ca-4c0c-9adb-c68104c63aa1@gmail.com>
Date: Thu, 17 Jul 2025 17:25:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] mm: thp: add bpf thp struct ops
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <20250608073516.22415-5-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250608073516.22415-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/06/2025 08:35, Yafang Shao wrote:
> A new bpf_thp struct ops is introduced to provide finer-grained control
> over THP allocation policy. The struct ops includes two APIs for
> determining the THP allocator and reclaimer behavior:
> 
> - THP allocator
> 
>   int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
> 
>   The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
>   indicating whether THP allocation should be performed synchronously
>   (current task) or asynchronously (khugepaged).
> 
>   The decision is based on the current task context, VMA flags, and TVA
>   flags.
> 
> - THP reclaimer
> 
>   int (*reclaimer)(bool vma_madvised);
> 
>   The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
>   determining whether memory reclamation is handled by the current task or
>   kswapd.
> 
>   The decision depends on the current task and VMA flags.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h |  13 +--
>  mm/Makefile             |   3 +
>  mm/bpf_thp.c            | 184 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+), 10 deletions(-)
>  create mode 100644 mm/bpf_thp.c
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 6a40ebf25f5c..0d02c9b56a85 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -54,6 +54,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,	/* BPF prog is attached */
>  };
>  
>  struct kobject;
> @@ -192,16 +193,8 @@ static inline bool hugepage_global_always(void)
>  
>  #define THP_ALLOC_KHUGEPAGED (1 << 1)
>  #define THP_ALLOC_CURRENT (1 << 2)
> -static inline int bpf_thp_allocator(unsigned long vm_flags,
> -				     unsigned long tva_flags)
> -{
> -	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> -}
> -
> -static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> -{
> -	return 0;
> -}

It makes it quite confusing for review to add code in earlier patches and remove it here.

I dont think you should have had the first 3 patches? and the code is mostly in
this patch?

> +int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags);
> +gfp_t bpf_thp_gfp_mask(bool vma_madvised);
>  
>  static inline int highest_order(unsigned long orders)
>  {
> diff --git a/mm/Makefile b/mm/Makefile
> index 1a7a11d4933d..e5f41cf3fd61 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += bpf_thp.o
> +endif
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> new file mode 100644
> index 000000000000..894d6cb93107
> --- /dev/null
> +++ b/mm/bpf_thp.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +#define RECLAIMER_CURRENT (1 << 1)
> +#define RECLAIMER_KSWAPD (1 << 2)
> +#define RECLAIMER_BOTH (RECLAIMER_CURRENT | RECLAIMER_KSWAPD)
> +
> +struct bpf_thp_ops {
> +	/**
> +	 * @allocator: Specifies whether the THP allocation is performed
> +	 * by the current task or by khugepaged.
> +	 * @vm_flags: Flags for the VMA in the current allocation context
> +	 * @tva_flags: Flags for the TVA in the current allocation context
> +	 *
> +	 * Rerurn:
> +	 * - THP_ALLOC_CURRENT: THP was allocated synchronously by the calling
> +	 *   task's context.
> +	 * - THP_ALLOC_KHUGEPAGED: THP was allocated asynchronously by the
> +	 *   khugepaged kernel thread.
> +	 * - 0: THP allocation is disallowed in the current context.
> +	 */
> +	int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
> +	/**
> +	 * @reclaimer: Specifies the entity performing page reclaim:
> +	 *             - current task context
> +	 *             - kswapd
> +	 *             - none (no reclaim)
> +	 * @vma_madvised: MADV flags for this VMA (e.g., MADV_HUGEPAGE, MADV_NOHUGEPAGE)
> +	 *
> +	 * Return:
> +	 * - RECLAIMER_CURRENT: Direct reclaim by the current task if THP
> +	 *   allocation fails.
> +	 * - RECLAIMER_KSWAPD: Wake kswapd to reclaim memory if THP allocation fails.
> +	 * - RECLAIMER_ALL: Both current and kswapd will perform the reclaim
> +	 * - 0: No reclaim will be attempted.
> +	 */
> +	int (*reclaimer)(bool vma_madvised);
> +};
> +
> +static struct bpf_thp_ops bpf_thp;
> +
> +int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags)
> +{
> +	int allocator;
> +
> +	/* No BPF program is attached */
> +	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
> +		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> +
> +	if (current_is_khugepaged())
> +		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> +	if (!bpf_thp.allocator)
> +		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;

Probably make it 

if (current_is_khugepaged() || !bpf_thp.allocator)
	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;

> +
> +	allocator = bpf_thp.allocator(vm_flags, tva_flags);
> +	if (!allocator)
> +		return 0;
> +	/* invalid return value */
> +	if (allocator & ~(THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT))
> +		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> +	return allocator;
> +}
> +
> +gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> +{
> +	int reclaimer;
> +
> +	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
> +		return 0;
> +
> +	if (!bpf_thp.reclaimer)
> +		return 0;
> +
> +	reclaimer = bpf_thp.reclaimer(vma_madvised);
> +	switch (reclaimer) {
> +	case RECLAIMER_CURRENT:
> +		return GFP_TRANSHUGE | __GFP_NORETRY;
> +	case RECLAIMER_KSWAPD:
> +		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
> +	case RECLAIMER_BOTH:
> +		return GFP_TRANSHUGE | __GFP_KSWAPD_RECLAIM | __GFP_NORETRY;
> +	default:
> +		return 0;

maybe you let the userspace decide GFP flags instead of having RECLAIMER_xyz?

> +	}
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
> +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +
> +	/* TODO: add support for multiple attaches */
> +	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		&transparent_hugepage_flags))
> +		return -EOPNOTSUPP;
> +	bpf_thp.allocator = ops->allocator;
> +	bpf_thp.reclaimer = ops->reclaimer;
> +	return 0;
> +}
> +
> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> +{
> +	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> +	bpf_thp.allocator = NULL;
> +	bpf_thp.reclaimer = NULL;
> +}
> +
> +static int bpf_thp_check_member(const struct btf_type *t,
> +				const struct btf_member *member,
> +				const struct bpf_prog *prog)
> +{
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
> +static int bpf_thp_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static int allocator(unsigned long vm_flags, unsigned long tva_flags)
> +{
> +	return 0;
> +}
> +
> +static int reclaimer(bool vma_madvised)
> +{
> +	return 0;
> +}
> +
> +static struct bpf_thp_ops __bpf_thp_ops = {
> +	.allocator = allocator,
> +	.reclaimer = reclaimer,
> +};
> +
> +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> +	.verifier_ops = &thp_bpf_verifier_ops,
> +	.init = bpf_thp_init,
> +	.check_member = bpf_thp_check_member,
> +	.init_member = bpf_thp_init_member,
> +	.reg = bpf_thp_reg,
> +	.unreg = bpf_thp_unreg,
> +	.name = "bpf_thp_ops",
> +	.cfi_stubs = &__bpf_thp_ops,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int __init bpf_thp_ops_init(void)
> +{
> +	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +
> +	if (err)
> +		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> +	return err;
> +}
> +late_initcall(bpf_thp_ops_init);


