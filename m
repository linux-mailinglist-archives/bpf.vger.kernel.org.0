Return-Path: <bpf+bounces-52006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB8A3CDAF
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577D13B5045
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8F257457;
	Wed, 19 Feb 2025 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wZOEJqhN"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BA1DE4EF
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008001; cv=none; b=nl3nfifFZ6NbBcZIK88hfUUVCws1SH/C48OF28uQ3uTyjrL6f4SGfw5uriK0bTTz1u5PPaOIhbU2LAeBVzUSNRiJSQtwr1YNgp4NuXDsWKsoeEfok6gogwTOIYp2D2X3/wMNjVriu8ldM7TJ3O9FdNiUhQMCtxsqLLV8cru1sFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008001; c=relaxed/simple;
	bh=O/z8YaTejEdxc20JWTRa/YWjLIbsQp8lcSLf8TkzLaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzYRpVyDIE8rBl2eg96OKe0dfrRd8tv7jEsWwPphcW+abgz2MK/P0uGBIk3REge46cEEXT4IprsrVf0Ht2zI07MF8gvoy/M7ocvmdj3I2Tx7mp/nF++QADReRfAcUTOGPH+4GAh37zFjROJ7N0PZTQzr1XoXN4DWd4jb754Y1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZOEJqhN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Feb 2025 15:33:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740007996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jht595c86MqUyIgPf62UjPPfZmeUGCfiZOP9eYz5J+Q=;
	b=wZOEJqhNf9TUGhN44gExUpM3AHwFeMVC63OeNAePuED8ApSQ22ggG71E29ExUoZng74H5f
	CK20VDBv+W8UCsnhLMcOUVBy7bzUdm0ipTK8n1aieIRu1qp/wnij/x5eDwkmrCUEktPrvf
	r5AMmCje2XOohBPyxNwhL64i0PbsbPo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, 
	Jordan Rome <linux@jordanrome.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
Message-ID: <ca3nfe2a2xfkt5ws6qkghzwmv4vmlsto4f2o2pr72sy46lftwe@xh4kt72yeia5>
References: <20250213152125.1837400-1-linux@jordanrome.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213152125.1837400-1-linux@jordanrome.com>
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

Do you prefer this patch series to go though mm-tree or routing these
through bpf tree is fine with you?

Shakeel

On Thu, Feb 13, 2025 at 07:21:23AM -0800, Jordan Rome wrote:
> Similar to `access_process_vm` but specific to strings.
> Also chunks reads by page and utilizes `strscpy`
> for handling null termination.
> 
> The primary motivation for this change is to copy
> strings from a non-current task/process in BPF.
> There is already a helper `bpf_copy_from_user_task`,
> which uses `access_process_vm` but one to handle
> strings would be very helpful.
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/linux/mm.h |   3 ++
>  mm/memory.c        | 122 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         |  76 ++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..aee23d84ce01 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2486,6 +2486,9 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
> 
> +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags);
> +
>  long get_user_pages_remote(struct mm_struct *mm,
>  			   unsigned long start, unsigned long nr_pages,
>  			   unsigned int gup_flags, struct page **pages,
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..014fe35af071 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6803,6 +6803,128 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
> 
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * If there is any error return -EFAULT.
> + */
> +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
> +			      void *buf, int len, unsigned int gup_flags)
> +{
> +	void *old_buf = buf;
> +	int err = 0;
> +
> +	*(char *)buf = '\0';
> +
> +	if (mmap_read_lock_killable(mm))
> +		return -EFAULT;
> +
> +	/* Untag the address before looking up the VMA */
> +	addr = untagged_addr_remote(mm, addr);
> +
> +	/* Avoid triggering the temporary warning in __get_user_pages */
> +	if (!vma_lookup(mm, addr)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	while (len) {
> +		int bytes, offset, retval;
> +		void *maddr;
> +		struct page *page;
> +		struct vm_area_struct *vma = NULL;
> +
> +		page = get_user_page_vma_remote(mm, addr, gup_flags, &vma);
> +
> +		if (IS_ERR(page)) {
> +			/*
> +			 * Treat as a total failure for now until we decide how
> +			 * to handle the CONFIG_HAVE_IOREMAP_PROT case and
> +			 * stack expansion.
> +			 */
> +			*(char *)buf = '\0';
> +			err = -EFAULT;
> +			goto out;
> +		}
> +
> +		bytes = len;
> +		offset = addr & (PAGE_SIZE - 1);
> +		if (bytes > PAGE_SIZE - offset)
> +			bytes = PAGE_SIZE - offset;
> +
> +		maddr = kmap_local_page(page);
> +		retval = strscpy(buf, maddr + offset, bytes);
> +
> +		if (retval >= 0) {
> +			/* Found the end of the string */
> +			buf += retval;
> +			unmap_and_put_page(page, maddr);
> +			break;
> +		}
> +
> +		buf += bytes - 1;
> +		/*
> +		 * Because strscpy always NUL terminates we need to
> +		 * copy the last byte in the page if we are going to
> +		 * load more pages
> +		 */
> +		if (bytes != len) {
> +			addr += bytes - 1;
> +			copy_from_user_page(vma, page, addr, buf,
> +					maddr + (PAGE_SIZE - 1), 1);
> +
> +			buf += 1;
> +			addr += 1;
> +		}
> +		len -= bytes;
> +
> +		unmap_and_put_page(page, maddr);
> +	}
> +
> +out:
> +	mmap_read_unlock(mm);
> +	if (err)
> +		return err;
> +
> +	return buf - old_buf;
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address space.
> + * @tsk:	the task of the target address space
> + * @addr:	start address to read from
> + * @buf:	destination buffer
> + * @len:	number of bytes to copy
> + * @gup_flags:	flags modifying lookup behaviour
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination);
> + * not including the trailing NUL. Always guaranteed to leave NUL-terminated
> + * buffer. On any error, return -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (unlikely(len < 1))
> +		return 0;
> +
> +	mm = get_task_mm(tsk);
> +	if (!mm) {
> +		*(char *)buf = '\0';
> +		return -EFAULT;
> +	}
> +
> +	ret = __copy_remote_vm_str(mm, addr, buf, len, gup_flags);
> +
> +	mmput(mm);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +
>  /*
>   * Print the name of a VMA.
>   */
> diff --git a/mm/nommu.c b/mm/nommu.c
> index baa79abdaf03..11d2341c634e 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1708,6 +1708,82 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
> 
> +/*
> + * Copy a string from another process's address space as given in mm.
> + * If there is any error return -EFAULT.
> + */
> +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
> +			      void *buf, int len)
> +{
> +	unsigned long addr_end;
> +	struct vm_area_struct *vma;
> +	int ret = -EFAULT;
> +
> +	*(char *)buf = '\0';
> +
> +	if (mmap_read_lock_killable(mm))
> +		return ret;
> +
> +	/* the access must start within one of the target process's mappings */
> +	vma = find_vma(mm, addr);
> +	if (!vma)
> +		goto out;
> +
> +	if (check_add_overflow(addr, len, &addr_end))
> +		goto out;
> +	/* don't overrun this mapping */
> +	if (addr_end > vma->vm_end)
> +		len = vma->vm_end - addr;
> +
> +	/* only read mappings where it is permitted */
> +	if (vma->vm_flags & VM_MAYREAD) {
> +		ret = strscpy(buf, (char *)addr, len);
> +		if (ret < 0)
> +			ret = len - 1;
> +	}
> +
> +out:
> +	mmap_read_unlock(mm);
> +	return ret;
> +}
> +
> +/**
> + * copy_remote_vm_str - copy a string from another process's address space.
> + * @tsk:	the task of the target address space
> + * @addr:	start address to read from
> + * @buf:	destination buffer
> + * @len:	number of bytes to copy
> + * @gup_flags:	flags modifying lookup behaviour (unused)
> + *
> + * The caller must hold a reference on @mm.
> + *
> + * Return: number of bytes copied from @addr (source) to @buf (destination);
> + * not including the trailing NUL. Always guaranteed to leave NUL-terminated
> + * buffer. On any error, return -EFAULT.
> + */
> +int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> +		void *buf, int len, unsigned int gup_flags)
> +{
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (unlikely(len < 1))
> +		return 0;
> +
> +	mm = get_task_mm(tsk);
> +	if (!mm) {
> +		*(char *)buf = '\0';
> +		return -EFAULT;
> +	}
> +
> +	ret = __copy_remote_vm_str(mm, addr, buf, len);
> +
> +	mmput(mm);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(copy_remote_vm_str);
> +
>  /**
>   * nommu_shrink_inode_mappings - Shrink the shared mappings on an inode
>   * @inode: The inode to check
> --
> 2.43.5
> 

