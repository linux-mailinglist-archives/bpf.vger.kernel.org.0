Return-Path: <bpf+bounces-67990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEDCB50D05
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 07:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69E4172D46
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 05:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636828935A;
	Wed, 10 Sep 2025 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQVOVsTp"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC225785E
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481105; cv=none; b=tSRcZmwYbErh3+GVji44dwEo5esvempjDQY9HqGrsfaGqL9RPC/T6EW06bSZlTAW3dzKpm4VMvREkVISO38oPFATbINrNw7mrKKeYqKFZsKoiuu+DWLVcBBERgqt8aHbXESpVTppDET+6cM+DvH8XCOu2V7Guyu9oW+yHH/r89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481105; c=relaxed/simple;
	bh=N3k/bk/c2rGHPGMdwsunCWHfvD+ngAp6ptJyb5mhkqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJOivl/HLfRYfm8Nyky5QT9g7NP8Zfi0m+gfK6I8ha+84yQjhiLG7GAlDBSrgBmKz2HCAyktwkgDvLIE7d8sjy0qfoGUn7M+Uksi5FQVGKeMWH0seTMiyBFmN2d2I4+rXJBspOjJgYZEpLmDD6plxCN6+YYhC0vOG0p/RFK0THo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vQVOVsTp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c890b42-610f-42ec-acf2-b5b9f95209b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757481099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYMkB0r9HSctXWgIuLRdmWEAYpy9xNa7COuGYriZzdI=;
	b=vQVOVsTpRUiot61+tU/kEjJNwPcwL94BOyb1LO9rBYYKootbsf3ErKWHagw7o5YWMCv3GG
	gxSMzJ4L3x6j5MUJpTEmb4xQ6iR1EnT8axrkykWZ5AvA98wiCwjev9tl44lTmp9FnR6/aY
	itPGUFah10wATaekIMtobALd5RC7sqM=
Date: Wed, 10 Sep 2025 13:11:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from
 khugepaged_mm_slot
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Lance Yang <ioworker0@gmail.com>, david@redhat.com,
 akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
 hannes@cmpxchg.org, corbet@lwn.net, ameryhung@gmail.com, 21cnbao@gmail.com,
 shakeel.butt@linux.dev, rientjes@google.com, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, ryan.roberts@arm.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org,
 usamaarif642@gmail.com, lorenzo.stoakes@oracle.com, npache@redhat.com,
 dev.jain@arm.com, Liam.Howlett@oracle.com
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-2-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250910024447.64788-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hey Yafang,

On 2025/9/10 10:44, Yafang Shao wrote:
> Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
> the khugepaged_mm_slot to stop khugepaged from processing it.
> 
> After this change, the following semantic relationship always holds:
> 
>    MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
>    MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/khugepaged.h |  1 +
>   kernel/sys.c               |  6 ++++++
>   mm/khugepaged.c            | 19 +++++++++----------
>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index eb1946a70cff..6cb9107f1006 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -19,6 +19,7 @@ extern void khugepaged_min_free_kbytes_update(void);
>   extern bool current_is_khugepaged(void);
>   extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   				   bool install_pmd);
> +bool hugepage_pmd_enabled(void);
>   
>   static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a46d9b75880b..a1c1e8007f2d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -8,6 +8,7 @@
>   #include <linux/export.h>
>   #include <linux/mm.h>
>   #include <linux/mm_inline.h>
> +#include <linux/khugepaged.h>
>   #include <linux/utsname.h>
>   #include <linux/mman.h>
>   #include <linux/reboot.h>
> @@ -2493,6 +2494,11 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
>   		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
>   		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>   	}
> +
> +	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
> +	    !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
> +	    hugepage_pmd_enabled())
> +		__khugepaged_enter(mm);
>   	mmap_write_unlock(current->mm);

One minor style suggestion for prctl_set_thp_disable():

static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
				 unsigned long arg4, unsigned long arg5)
{
	struct mm_struct *mm = current->mm;

	[...]
	if (mmap_write_lock_killable(current->mm))
		return -EINTR;
	[...]
	mmap_write_unlock(current->mm);
	return 0;
}

It initializes struct mm_struct *mm = current->mm; at the beginning, but 
then uses both mm and current->mm. Could you change the calls using
current->mm to use the local mm variable for consistency? Just a nit ;)

Cheers,
Lance
>   	return 0;
>   }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..88ac482fb3a0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>   		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>   }
>   
> -static bool hugepage_pmd_enabled(void)
> +bool hugepage_pmd_enabled(void)
>   {
>   	/*
>   	 * We cover the anon, shmem and the file-backed case here; file-backed
> @@ -445,6 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>   
>   	/* __khugepaged_exit() must not run from under us */
>   	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	WARN_ON_ONCE(mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm));
>   	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
>   		return;
>   
> @@ -472,7 +473,8 @@ void __khugepaged_enter(struct mm_struct *mm)
>   void khugepaged_enter_vma(struct vm_area_struct *vma,
>   			  vm_flags_t vm_flags)
>   {
> -	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> +	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, vma->vm_mm) &&
> +	    !mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>   	    hugepage_pmd_enabled()) {
>   		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>   			__khugepaged_enter(vma->vm_mm);
> @@ -1451,16 +1453,13 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>   
>   	lockdep_assert_held(&khugepaged_mm_lock);
>   
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (hpage_collapse_test_exit_or_disable(mm)) {
>   		/* free mm_slot */
>   		hash_del(&slot->hash);
>   		list_del(&slot->mm_node);
>   
> -		/*
> -		 * Not strictly needed because the mm exited already.
> -		 *
> -		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> -		 */
> +		/* If the mm is disabled, this flag must be cleared. */
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>   
>   		/* khugepaged_mm_lock actually not necessary for the below */
>   		mm_slot_free(mm_slot_cache, mm_slot);
> @@ -2507,9 +2506,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>   	VM_BUG_ON(khugepaged_scan.mm_slot != mm_slot);
>   	/*
>   	 * Release the current mm_slot if this mm is about to die, or
> -	 * if we scanned all vmas of this mm.
> +	 * if we scanned all vmas of this mm, or if this mm is disabled.
>   	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
>   		/*
>   		 * Make sure that if mm_users is reaching zero while
>   		 * khugepaged runs here, khugepaged_exit will find


