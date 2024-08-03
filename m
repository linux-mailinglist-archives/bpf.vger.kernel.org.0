Return-Path: <bpf+bounces-36336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158919468C0
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2596C1C20E40
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AAB14D6F7;
	Sat,  3 Aug 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oCm4PHwh"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B57101F2;
	Sat,  3 Aug 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722675205; cv=none; b=UExf03JiRDJDLB7LvRdstj0BjfVFqcTK8ebMUXoJgDf2SkVSeW5nRoJHqTgT3yxYulEf4HGGypqcqYClsgHN4FQIJOriyhVJe7rxXNUgo0WE4GFcdO6jZc4xs65Bjv5u8oDcimySAcfACOfhCvCCi0D+Xec4VewfQWRWlICS9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722675205; c=relaxed/simple;
	bh=FN3JigGqi+AqC3qFvKF2f0KSO2Q07QphUSLACrnt8KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feMnWu3bWaBEtTjFWsxmWxGVbMYErzQvc2pSNRvhhPzcm8u9HfmmHCpQyB8gIgTCdFWdSuXiK6vUZutcsPt6GGwWu6iuW8NtsMzIvBDDA+vMvwQ5gbhI3w3ilmlBUrJQhc6Vu21SIMJo0vgrZhrtn1IVaFYwwsOj+MkognanPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oCm4PHwh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PhdhUksfUrXzRQyfRQLDw9DD3fn7ZoTv+mL/aWtytIU=; b=oCm4PHwh9nfp+Ktp8SEyatnliI
	hUAisKmS+ksr00SUfr5jWNGy0F2kWr1307vyoa979kKuItsxB4mZDdzwvSmw539Lwddh25x9MZFsk
	4EiHv8kv3pff2prFl0ma2LMZf6CKPKiKU0ojWIWWNPopO+0qB9+4QL1F/L0JeCbzv9orY6BR5wCj3
	0sTpun3QPb81AY2pAQhCI107fbbu74TMLOwO1fYdQBRPl7DBcpCgvXYnqtyPcNcev6TMvpdzvzEnI
	/CH0qqQvzo4RTccgCgr6E9Y6aiQYq5alPUe10BaK8dGvpe4SQePIoWBnYzLIBvuxEa92RKukScjH0
	O+k4l6MQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saAVl-00000005sji-341Y;
	Sat, 03 Aug 2024 08:53:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B9C7E300820; Sat,  3 Aug 2024 10:53:12 +0200 (CEST)
Date: Sat, 3 Aug 2024 10:53:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240803085312.GP39708@noisy.programming.kicks-ass.net>
References: <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org>
 <20240730131058.GN33588@noisy.programming.kicks-ass.net>
 <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
 <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com>

On Fri, Aug 02, 2024 at 10:47:15PM -0700, Andrii Nakryiko wrote:

> Is there any reason why the approach below won't work?

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8be9e34e786a..e21b68a39f13 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2251,6 +2251,52 @@ static struct uprobe
> *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>         struct uprobe *uprobe = NULL;
>         struct vm_area_struct *vma;
> 
> +#ifdef CONFIG_PER_VMA_LOCK
> +       vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE, vm_flags;
> +       struct file *vm_file;
> +       struct inode *vm_inode;
> +       unsigned long vm_pgoff, vm_start, vm_end;
> +       int vm_lock_seq;
> +       loff_t offset;
> +
> +       rcu_read_lock();
> +
> +       vma = vma_lookup(mm, bp_vaddr);
> +       if (!vma)
> +               goto retry_with_lock;
> +
> +       vm_lock_seq = READ_ONCE(vma->vm_lock_seq);

So vma->vm_lock_seq is only updated on vma_start_write()

> +
> +       vm_file = READ_ONCE(vma->vm_file);
> +       vm_flags = READ_ONCE(vma->vm_flags);
> +       if (!vm_file || (vm_flags & flags) != VM_MAYEXEC)
> +               goto retry_with_lock;
> +
> +       vm_inode = READ_ONCE(vm_file->f_inode);
> +       vm_pgoff = READ_ONCE(vma->vm_pgoff);
> +       vm_start = READ_ONCE(vma->vm_start);
> +       vm_end = READ_ONCE(vma->vm_end);

None of those are written with WRITE_ONCE(), so this buys you nothing.
Compiler could be updating them one byte at a time while you load some
franken-update.

Also, if you're in the middle of split_vma() you might not get a
consistent set.

> +       if (bp_vaddr < vm_start || bp_vaddr >= vm_end)
> +               goto retry_with_lock;
> +
> +       offset = (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start);
> +       uprobe = find_uprobe_rcu(vm_inode, offset);
> +       if (!uprobe)
> +               goto retry_with_lock;
> +
> +       /* now double check that nothing about VMA changed */
> +       if (vm_lock_seq != READ_ONCE(vma->vm_lock_seq))
> +               goto retry_with_lock;

Since vma->vma_lock_seq is only ever updated at vma_start_write() you're
checking you're in or after the same modification cycle.

The point of sequence locks is to check you *IN* a modification cycle
and retry if you are. You're now explicitly continuing if you're in a
modification.

You really need:

   seq++;
   wmb();

   ... do modification

   wmb();
   seq++;

vs

  do {
	  s = READ_ONCE(seq) & ~1;
	  rmb();

	  ... read stuff

  } while (rmb(), seq != s);
  

The thing to note is that seq will be odd while inside a modification
and even outside, further if the pre and post seq are both even but not
identical, you've crossed a modification and also need to retry.

> +
> +       /* happy case, we speculated successfully */
> +       rcu_read_unlock();
> +       return uprobe;
> +
> +retry_with_lock:
> +       rcu_read_unlock();
> +       uprobe = NULL;
> +#endif
> +
>         mmap_read_lock(mm);
>         vma = vma_lookup(mm, bp_vaddr);
>         if (vma) {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cc760491f201..211a84ee92b4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
>                         NULL);
>         files_cachep = kmem_cache_create("files_cache",
>                         sizeof(struct files_struct), 0,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> + SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
>                         NULL);
>         fs_cachep = kmem_cache_create("fs_cache",
>                         sizeof(struct fs_struct), 0,

