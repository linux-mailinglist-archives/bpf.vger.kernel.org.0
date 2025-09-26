Return-Path: <bpf+bounces-69843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FAABA40E3
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 16:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23ED41C0144A
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50228155C97;
	Fri, 26 Sep 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvCxvQPl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004172F3605
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895907; cv=none; b=JYpQIaSu9Ml/R3dpRyaipZSAmPzZkW0B5rhhlXNcttoAQSer6erNq3VplQcNDRpJcW9dAetLWOzcbUIKcDjPgYtqExuEG0cr+zguSs5nKVIOzXk0a2HkyPYljWbI3NpaaBZHe/FuokLmyj+N+NN/oxHMiM0KTxTv5xf2HO4bAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895907; c=relaxed/simple;
	bh=Cda4WGQXonbSWQhrD5cw1RbmvTmA5UggAyb6jdw1c9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=of53p+VL0q1AD8fZAmCeWlx493mZgjwmmw2BnecRL4Q0sbwckpx059hyX/EJ5hb/9YLONdrioC2v/TACa5aCH+Z8BkEkoer92ivO4o/kp87mnnoM7Ae6EhjFB2N+QMix9xqcqxwsmu2eCVCqLA3r5c461yI6Pq1keDJ8W+iPyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvCxvQPl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso10617395e9.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758895904; x=1759500704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny7pIQ2SCuYpPr5sAoZMtmx+LX6//dYVYgLJ9SYLcgQ=;
        b=XvCxvQPlDYqNLlioV8HtmIGG/oa15gRdbBsw13aV1VoxGSuLVyElGE18ESBpqaJW/y
         Hr5D8NBbmNVUNPDg4pbPVQkJ+Wve9bSaXBT6JEVjlny0003+0LviusNT16buzcIyc4i9
         EkFYqvFCK9bC/hOmmKMEE+gl4brhFJ6/72w8fT3Pelpl22w7mBJ6gbA07g7UpcBmRCkl
         f8+tFvJuUu16ihZ/3R/tL+WZG8ujAf9vIqHDjEu6/6al2L0MPoiP/DUVPHdl1iO5fV8D
         TPAasuut4XXXoguArQvRoAlg8EydSyAo3B44fEQHMdWJfBFxlkeB/zmQX76UM+AUr1Cz
         S4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758895904; x=1759500704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny7pIQ2SCuYpPr5sAoZMtmx+LX6//dYVYgLJ9SYLcgQ=;
        b=UHXwarGdFPagb/trhHfrFF3bW0P93qJlhmaHlyvbpHDB4XuoKmEP8IOnTzTc2wMKLO
         T/T+3tuyAhY45mkDadvcinixGboicRlXNxYjp4bDBTXbLqv0c+6eb8NMqvl7yA1tiUS7
         Xs4bOC2OFmejBWWys/JwSF+XOk8Adl7fG7YDDoTozKFATUff7jVLITASQ6zrVqTqOi3Q
         0FliYv1m1kHQmrW//mV0fa81iqNslp4zpTAqjhsEqNZXtobGcw3rnV8HsUZH3LyH/Sgm
         /DnT+6rkQpt3/J8logb71eUEEgcaPhDA08vX370yKW7I1OjwS4G+p2bUHqerRZhkhrUE
         XZ4w==
X-Gm-Message-State: AOJu0YxeypIeJp8TIV8m2WcuVE9DoQS1szA4Lr7wNQqLsTzWttCfWvj+
	pQIx+jDDuInN6Rk8vFEoM3ulVLsLntiv+CNEZX6yAvsTQW5JxE3DNB+I
X-Gm-Gg: ASbGncuCQzlGAylZ6YBQbkYDzm0dGIqk4xhL46ihYONpGTntVTjMdpfVZeAckusP29T
	civunX3LdodxlM8kPFLmmYZQ5xHtSagTH9hm57nGa0HByf5Tk+hUAJanCMQVBo5kVQKRxkBca8V
	TTCwAudFlXpLBpJ+Rg99E++V87g7vTX54MNDDXF21iouPs3VhzqkAqHATSgeVZ1xSKlZ1rQopr+
	2lB7NZi57FyGPSqRjkO3tzohzXBvBJ+GAZmXCG3Ymju4vdhfOPfypNdswiP92VXu3PuX3Jt+3Ju
	78L24kvEUm+mgJta8dNE+yeJrJL7MMo8mDYm6OghbDwOas3MImfVXWe+NRw5yqV4/FJeOGhvSiU
	JCCQ1bwlaXYkOVioQpOGkiiFN7J3NNzXbD0JCFmmPwf/1rXWBfJdVbEdrgG0dprYlXz743t/HAy
	AxY8IEp56GPQcOmqrNuwEHreWzr0slIXE3yQ==
X-Google-Smtp-Source: AGHT+IGIsygixbycwSxGEYYSjqdX4hw6Wrb2gEHvzCCx3um4Q8sxCxU/06IukXa1VlsWWUmFmo66KA==
X-Received: by 2002:a05:600c:4fca:b0:46d:45e:350a with SMTP id 5b1f17b1804b1-46e329fb93bmr92609295e9.17.1758895903786;
        Fri, 26 Sep 2025 07:11:43 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32bd6360sm39873825e9.1.2025.09.26.07.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:11:43 -0700 (PDT)
Message-ID: <34a9440f-b0c4-4f76-a2ac-f88b54c2242e@gmail.com>
Date: Fri, 26 Sep 2025 15:11:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 01/12] mm: thp: remove disabled task from
 khugepaged_mm_slot
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
 <20250926093343.1000-2-laoar.shao@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250926093343.1000-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/09/2025 10:33, Yafang Shao wrote:
> Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
> the khugepaged_mm_slot to stop khugepaged from processing it.
> 
> After this change, the following semantic relationship always holds:
> 
>   MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
>   MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> ---
>  include/linux/khugepaged.h |  4 ++++
>  kernel/sys.c               |  7 ++++--
>  mm/khugepaged.c            | 49 ++++++++++++++++++++------------------
>  3 files changed, 35 insertions(+), 25 deletions(-)
> 


Hi Yafang,

Thanks for the patch! Sorry wasnt able to review the previous revisions.

I think it would be good to separate this patch out of the series?
It would make the review of this series shorter and this patch can be merged independently.

In the commit message, we also need to write explicitly that when prctl
PR_SET_THP_DISABLE is cleared, the mm is added back for khugepaged to consider.

Could you also mention in the commit message why the BUG was turned into WARN?

Thanks!

> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index eb1946a70cff..f14680cd9854 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -15,6 +15,7 @@ extern void __khugepaged_enter(struct mm_struct *mm);
>  extern void __khugepaged_exit(struct mm_struct *mm);
>  extern void khugepaged_enter_vma(struct vm_area_struct *vma,
>  				 vm_flags_t vm_flags);
> +extern void khugepaged_enter_mm(struct mm_struct *mm);
>  extern void khugepaged_min_free_kbytes_update(void);
>  extern bool current_is_khugepaged(void);
>  extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> @@ -42,6 +43,9 @@ static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
>  					vm_flags_t vm_flags)
>  {
>  }
> +static inline void khugepaged_enter_mm(struct mm_struct *mm)
> +{
> +}
>  static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
>  					  unsigned long addr, bool install_pmd)
>  {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a46d9b75880b..2c445bf44ce3 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/khugepaged.h>
>  #include <linux/utsname.h>
>  #include <linux/mman.h>
>  #include <linux/reboot.h>
> @@ -2479,7 +2480,7 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
>  	/* Flags are only allowed when disabling. */
>  	if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>  		return -EINVAL;
> -	if (mmap_write_lock_killable(current->mm))
> +	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  	if (thp_disable) {
>  		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
> @@ -2493,7 +2494,9 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
>  		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
>  		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>  	}
> -	mmap_write_unlock(current->mm);
> +
> +	khugepaged_enter_mm(mm);
> +	mmap_write_unlock(mm);
>  	return 0;
>  }
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7ab2d1a42df3..f47ac8c19447 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -396,15 +396,10 @@ void __init khugepaged_destroy(void)
>  	kmem_cache_destroy(mm_slot_cache);
>  }
>  
> -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> -{
> -	return atomic_read(&mm->mm_users) == 0;
> -}
> -
>  static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
> -	return hpage_collapse_test_exit(mm) ||
> -		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
> +	return !atomic_read(&mm->mm_users) ||			/* exit */
> +		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);  /* disable */
>  }
>  
>  static bool hugepage_pmd_enabled(void)
> @@ -437,7 +432,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  	int wakeup;
>  
>  	/* __khugepaged_exit() must not run from under us */
> -	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	VM_WARN_ON_ONCE(hpage_collapse_test_exit_or_disable(mm));
>  	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
>  		return;
>  
> @@ -460,14 +455,25 @@ void __khugepaged_enter(struct mm_struct *mm)
>  		wake_up_interruptible(&khugepaged_wait);
>  }
>  
> +void khugepaged_enter_mm(struct mm_struct *mm)
> +{
> +	if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm))
> +		return;
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
> +		return;
> +	if (!hugepage_pmd_enabled())
> +		return;
> +
> +	__khugepaged_enter(mm);
> +}
> +
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> -	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> -	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> -			__khugepaged_enter(vma->vm_mm);
> -	}
> +	if (!thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> +		return;
> +
> +	khugepaged_enter_mm(vma->vm_mm);
>  }
>  
>  void __khugepaged_exit(struct mm_struct *mm)
> @@ -491,7 +497,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	} else if (slot) {
>  		/*
>  		 * This is required to serialize against
> -		 * hpage_collapse_test_exit() (which is guaranteed to run
> +		 * hpage_collapse_test_exit_or_disable() (which is guaranteed to run
>  		 * under mmap sem read mode). Stop here (after we return all
>  		 * pagetables will be destroyed) until khugepaged has finished
>  		 * working on the pagetables under the mmap_lock.
> @@ -1429,16 +1435,13 @@ static void collect_mm_slot(struct mm_slot *slot)
>  
>  	lockdep_assert_held(&khugepaged_mm_lock);
>  
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (hpage_collapse_test_exit_or_disable(mm)) {
>  		/* free mm_slot */
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
>  
> -		/*
> -		 * Not strictly needed because the mm exited already.
> -		 *
> -		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> -		 */
> +		/* If the mm is disabled, this flag must be cleared. */
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>  
>  		/* khugepaged_mm_lock actually not necessary for the below */
>  		mm_slot_free(mm_slot_cache, slot);
> @@ -1749,7 +1752,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
>  			continue;
>  
> -		if (hpage_collapse_test_exit(mm))
> +		if (hpage_collapse_test_exit_or_disable(mm))
>  			continue;
>  		/*
>  		 * When a vma is registered with uffd-wp, we cannot recycle
> @@ -2500,9 +2503,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  	VM_BUG_ON(khugepaged_scan.mm_slot != slot);
>  	/*
>  	 * Release the current mm_slot if this mm is about to die, or
> -	 * if we scanned all vmas of this mm.
> +	 * if we scanned all vmas of this mm, or if this mm is disabled.
>  	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
>  		/*
>  		 * Make sure that if mm_users is reaching zero while
>  		 * khugepaged runs here, khugepaged_exit will find


