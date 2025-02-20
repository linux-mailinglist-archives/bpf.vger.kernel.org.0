Return-Path: <bpf+bounces-52011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C40A3CE09
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC471732CD
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC111798F;
	Thu, 20 Feb 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yWq/uhKW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D323A0
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010703; cv=none; b=umkIrUT4oGxb/dxbFk9OKgbIlBLv9nGnFGRtqIa70x1adX5dZs/PXFRbsaZuhjSR0J5SnJWPCIkXQIwOvA5OloLoJOONEXdR3C8hd/JsT7uyGMwYKjLXEZwF5glK/ovt1fmSHkubtCfBIwZgNu++L+gLXy6VkRMH9BFMqzubMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010703; c=relaxed/simple;
	bh=lczxXNo8KAGLAhmOJvMVTwpRkP9aRLwOp36UTrgSXVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pu8SMEhVEo5bQJ3AKKxlsHVEAPZ/sjOGEO7BAX+Zm0+OQYnq7gBb8jCMHzAXvPdrt7VnYRzcq18Ex2apGTmm0Ex/dLxqNg0C+f3VK0c3caJOpLLf95OW28Ced60kxX55IrPRS8dfTf2zlnnlGq8jtbgAcQzjyLVFxpQcl5M7VSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yWq/uhKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AECC4CED1;
	Thu, 20 Feb 2025 00:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740010702;
	bh=lczxXNo8KAGLAhmOJvMVTwpRkP9aRLwOp36UTrgSXVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yWq/uhKW5Z2fp1kGJijuBGSgTmlgqxvUB+2LO9ho2+Wm6TRXIwkZVhCkqkmRGO2te
	 jvbXDCtHjcraAoRyZsRGF6XQR7UxtI3jAeHP1xXzTf1hTy/+fifvl7mwdmkz/GaLEL
	 +llj+KL9dcVdXSzfw4pMify7AM/AbykTdjW3sYao=
Date: Wed, 19 Feb 2025 16:18:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
Message-Id: <20250219161821.6f05272f1a3131ddfe978865@linux-foundation.org>
In-Reply-To: <20250213152125.1837400-1-linux@jordanrome.com>
References: <20250213152125.1837400-1-linux@jordanrome.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 07:21:23 -0800 Jordan Rome <linux@jordanrome.com> wrote:

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
> ...
>
>  include/linux/mm.h |   3 ++
>  mm/memory.c        | 122 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/nommu.c         |  76 ++++++++++++++++++++++++++++

Is there any way in which we can avoid adding all this to vmlinux if
it's unneeded?

Any such ifdeffery would of course need removal or alteration if
callers other than BPF emerge.

> ...
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

Well that's a crappy little comment which you copied-n-pasted.  It
tells us "what" (which is utterly obvious) but not "why".  whodidthat.

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

I wonder if this can ever happen.  And if it does, should it WARN?  And
returen -Efoo?

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


