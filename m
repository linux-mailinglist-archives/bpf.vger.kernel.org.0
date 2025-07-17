Return-Path: <bpf+bounces-63651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AFCB093CF
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B623B5482
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8762FBFEC;
	Thu, 17 Jul 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l21fgq0v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62481925BC
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776506; cv=none; b=f+PbvjyT6a0FqORlqTrxc3WojSZc+2s3vjtADYEIwt3CGqAp0PwWZj1JDcUSvzH3ohAWv5pxzjWdBA4zXtx2OWXVFOEe4fCI6hKsUpPw0Pub/3K4XtkRgcOjl36+5Wc1H46NEerwn0yUWH0e6lG4d01/P0pAexXgDB4r0XgcvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776506; c=relaxed/simple;
	bh=jTsY7NAle48lMK6xaxMhqh49tR2pwLkcb9f+1HdOfLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdmJPMb82BokTb6J56kTWFLwkCxQEqTOdt7ldYm9j1uvVEA35np1EITS13K0ETd+fFu3hKiTOuvYISBTr6AY+q33Y/9+nvU2try5L0d3xl64roSCiKUTxhVcmUqxBpU+u8n15MxdZRfWLP/dunNEPmXEacC1SPMlj477zAIOIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l21fgq0v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so1388669b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752776504; x=1753381304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Owo8/pepQaG8tCLdms7r8I0XLUvKhXbhFJD1zAzOisI=;
        b=l21fgq0vcXCzrpwfEFhJs4PArZahD1pPS2gQlJmfjgP//43BCT1gKPBzbLKn+IBpyN
         1Dg486ErF/pFmU8XAT3ST0ZW/TTLkcs125M+O3FUOuKPfw6PdZyrRspkjb0TUxbYEEfl
         6ezHiqF6ocQtLig7ppLdTblHwcyczaHDCxOEYkEf+PzNBpXPVhVW68+4iIIwBTN+bard
         k7+tlEY/OtWoC5RvqsYJ00mUYtavQHJndabrkVCu+zuwCWr1M3glaCitJmBr8DTqjlpW
         fmbqJbQ37j+hDWkEZSyYRR/y1haVlezDFSV1IEbdwlXGTYw2hdtpUZtbTf0IZy2npmAP
         zh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776504; x=1753381304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owo8/pepQaG8tCLdms7r8I0XLUvKhXbhFJD1zAzOisI=;
        b=rp6ZpX0QVIX0ktitIA3+WT6XkzwI00HyXptzQhvYnlnqXQPGkdWuQbcJr9yx1l5uYW
         wrSVOcrRZvCrTa+5Fwt2EK50C4gfrlCCgOlgmeMx7w2++ZVKj/GFpt9V6I4vEmdRh0gf
         wFB3VLERiIVOSLIbLmZ6qetUfjSDP52CRx+8lh7MJbZF84rTi2AJg0NPtlp5JXWDSzqP
         V/SELozrgCrAijjdhwgTM8c1B93uG1XlFmLlV7OF7oTaGEWmTbvTyGDiih3v2XCnXEAe
         VTFxlwIf354SEgOxfJUfnncODrNGBgbemwdZQCUT8RO2ao+vpceCOPvH57dpDlUzMYzK
         wZKA==
X-Gm-Message-State: AOJu0Yx3K3NPTdOUnSqVepphf/MRQcuT1d5I2l9bEngSVitlXm/gxB60
	Rg/9qL27/mHlxNXfVuM+fqL7O9KQ6Iv0vIqjXUCyPUuyHQlgt3UpssBI
X-Gm-Gg: ASbGncuiOzfr3ZTHMkcQQfRV8g6atEfjd0Yxnc6H4NGikpRrIQ9cEcLmc7InIbvSKKA
	Rdr+viQ3UbnE0GkYuBvFADTSVJXzVoqLpnzkhmN5LQlOX1K58A65heL/RCP8rE2fFod4r4MpxSp
	X8+HDfnhvbKo+YTbv+6bGxIAlaUi+uSianyeLFTXz4s1KG3XPOy3UmCNYTUpNk6qdGTmR3yh0Ul
	snM+xTc10a1zPweGmJGYW3vJrv3ClwqXnqTiCTwKATTYX4A9/P4k7HGBUih72+3zBTw+Slt1Kcv
	Oj9bUO4ddEmBEtuap1fti9k/kRhtGNysxbytHOos8xdTm3xrhWKj4FQAawTe5YswMjjk8BeMR6n
	BgXWweGM/xIhdRWCVGeMKXvue4WBwyoZiQaV0qNCi9d1KkfFNHfhl2wIJRpwHvkdoL6croCmXEI
	q1
X-Google-Smtp-Source: AGHT+IGIDQ8ZOjuWdcX5onexleEqNk5wiDXmBBzs6kP/LngPXZMeA3Vsi09NDta52vhcFJRoLXFutQ==
X-Received: by 2002:a05:6a21:62c1:b0:216:1476:f5c with SMTP id adf61e73a8af0-23812b50d6cmr12577497637.25.1752776503749;
        Thu, 17 Jul 2025 11:21:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:49c:e9dc:5730:d2af? ([2620:10d:c090:500::4:ec62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ab5sm16627521b3a.30.2025.07.17.11.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:21:43 -0700 (PDT)
Message-ID: <a19a28e6-6a67-464f-9597-2da1d2d906db@gmail.com>
Date: Thu, 17 Jul 2025 11:21:38 -0700
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
 usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <20250608073516.22415-5-laoar.shao@gmail.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20250608073516.22415-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/8/25 12:35 AM, Yafang Shao wrote:
> A new bpf_thp struct ops is introduced to provide finer-grained control
> over THP allocation policy. The struct ops includes two APIs for
> determining the THP allocator and reclaimer behavior:
>
> - THP allocator
>
>    int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
>
>    The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
>    indicating whether THP allocation should be performed synchronously
>    (current task) or asynchronously (khugepaged).
>
>    The decision is based on the current task context, VMA flags, and TVA
>    flags.
>
> - THP reclaimer
>
>    int (*reclaimer)(bool vma_madvised);
>
>    The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
>    determining whether memory reclamation is handled by the current task or
>    kswapd.
>
>    The decision depends on the current task and VMA flags.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   include/linux/huge_mm.h |  13 +--
>   mm/Makefile             |   3 +
>   mm/bpf_thp.c            | 184 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 190 insertions(+), 10 deletions(-)
>   create mode 100644 mm/bpf_thp.c
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 6a40ebf25f5c..0d02c9b56a85 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -54,6 +54,7 @@ enum transparent_hugepage_flag {
>   	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>   	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>   	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,	/* BPF prog is attached */
>   };
>   
>   struct kobject;
> @@ -192,16 +193,8 @@ static inline bool hugepage_global_always(void)
>   
>   #define THP_ALLOC_KHUGEPAGED (1 << 1)
>   #define THP_ALLOC_CURRENT (1 << 2)
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
> +int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags);
> +gfp_t bpf_thp_gfp_mask(bool vma_madvised);
>   
>   static inline int highest_order(unsigned long orders)
>   {
> diff --git a/mm/Makefile b/mm/Makefile
> index 1a7a11d4933d..e5f41cf3fd61 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>   obj-$(CONFIG_NUMA) += memory-tiers.o
>   obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>   obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> +ifdef CONFIG_BPF_SYSCALL
> +obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += bpf_thp.o
> +endif
>   obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>   obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>   obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
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
> +
> +	allocator = bpf_thp.allocator(vm_flags, tva_flags);
> +	if (!allocator)
> +		return 0;

The check seems redundant. Is it?

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

I think returning -EBUSY if the struct_ops is already attached is a 
better choice

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

[...]

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

nit. check_member doesn't need to be defined if it does not do anything.

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


