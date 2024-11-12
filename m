Return-Path: <bpf+bounces-44555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E89C4ABC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77996282699
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 00:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D121EABA9;
	Tue, 12 Nov 2024 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDYlTgXE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05B18A6D7;
	Tue, 12 Nov 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371302; cv=none; b=FDFXGE2rPDW7J5qoUR7/8tGOVj6KjAccBbekC5Gx2bqgl9ON3UddI1hkz+BQPq6MNnL2WSyF0lKbjNQBKgN/0RCpPnl7B302OtLaVjjHGMfn7T1IDZdFIicJAQclvb1ijjvCjwp9bJA1y14G0cUGNnNunzJQ/eQ/RET7AKN19oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371302; c=relaxed/simple;
	bh=Scn310P0r99vSey/hQL+jqRA1Hjarl50/MAqC1aF+n0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lv7uNPMOCSXT+wRYPlEsaanmw3dMC6x0HspgtOVvZRD1Id/ETY0HjvUv1M9i8KJ3JUB61dvwbw0tY06aEnvxmfuomPVdj7gNgCvVAmq08mC/AwiZ/LsfiqBZfCquvf72vVTdANts1Jn/VmlSmXLcahWxHiHbOwey64XCfGlNrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDYlTgXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5ADC4CECF;
	Tue, 12 Nov 2024 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731371301;
	bh=Scn310P0r99vSey/hQL+jqRA1Hjarl50/MAqC1aF+n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mDYlTgXEJ00ryIZ8Gso0ZK7CQ4cUZiPP6562rahLnqteePUD/g86rKCq/WfzYy+4R
	 G27UCT8OZ2k+WfpgN4i+cOc1h3HMnj1OD2v3Trorde9mn96VFz3iveYkP8NPIOzXqU
	 kD664bn0nULlPznsJ/MehYkRvFC4Tf+tDwVjfuEPqjm8RINIH75dj8uvbyThHKTXoc
	 pcx/ZhEL1jJlaLHH4FSXPF+agBUs0azQcUVFw/pLGh6pJ63t13uALJFUk/eoSY+U1H
	 5WEHuEPxnvQbOYUWPhUTh4XdnQt9K4wD1yY6ynDjwCJsxdt6OUUXc+t4tUB870ujUZ
	 IyH6RLmV4AFbA==
Date: Tue, 12 Nov 2024 09:28:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
 willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
 brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de,
 richard.weiyang@gmail.com, zhangpeng.00@bytedance.com,
 linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Subject: Re: [PATCH v4 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-Id: <20241112092816.cf5b0aa1ef10f50ce872892f@kernel.org>
In-Reply-To: <20241028010818.2487581-5-andrii@kernel.org>
References: <20241028010818.2487581-1-andrii@kernel.org>
	<20241028010818.2487581-5-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Oct 2024 18:08:18 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Given filp_cachep is marked SLAB_TYPESAFE_BY_RCU (and FMODE_BACKING
> files, a special case, now goes through RCU-delated freeing), we can
> safely access vma->vm_file->f_inode field locklessly under just
> rcu_read_lock() protection, which enables looking up uprobe from
> uprobes_tree completely locklessly and speculatively without the need to
> acquire mmap_lock for reads. In most cases, anyway, assuming that there
> are no parallel mm and/or VMA modifications. The underlying struct
> file's memory won't go away from under us (even if struct file can be
> reused in the meantime).
> 
> We rely on newly added mmap_lock_speculation_{begin,end}() helpers to
> validate that mm_struct stays intact for entire duration of this
> speculation. If not, we fall back to mmap_lock-protected lookup.
> The speculative logic is written in such a way that it will safely
> handle any garbage values that might be read from vma or file structs.
> 
> Benchmarking results speak for themselves.
> 
> BEFORE (latest tip/perf/core)
> =============================
> uprobe-nop            ( 1 cpus):    3.384 ± 0.004M/s  (  3.384M/s/cpu)
> uprobe-nop            ( 2 cpus):    5.456 ± 0.005M/s  (  2.728M/s/cpu)
> uprobe-nop            ( 3 cpus):    7.863 ± 0.015M/s  (  2.621M/s/cpu)
> uprobe-nop            ( 4 cpus):    9.442 ± 0.008M/s  (  2.360M/s/cpu)
> uprobe-nop            ( 5 cpus):   11.036 ± 0.013M/s  (  2.207M/s/cpu)
> uprobe-nop            ( 6 cpus):   10.884 ± 0.019M/s  (  1.814M/s/cpu)
> uprobe-nop            ( 7 cpus):    7.897 ± 0.145M/s  (  1.128M/s/cpu)
> uprobe-nop            ( 8 cpus):   10.021 ± 0.128M/s  (  1.253M/s/cpu)
> uprobe-nop            (10 cpus):    9.932 ± 0.170M/s  (  0.993M/s/cpu)
> uprobe-nop            (12 cpus):    8.369 ± 0.056M/s  (  0.697M/s/cpu)
> uprobe-nop            (14 cpus):    8.678 ± 0.017M/s  (  0.620M/s/cpu)
> uprobe-nop            (16 cpus):    7.392 ± 0.003M/s  (  0.462M/s/cpu)
> uprobe-nop            (24 cpus):    5.326 ± 0.178M/s  (  0.222M/s/cpu)
> uprobe-nop            (32 cpus):    5.426 ± 0.059M/s  (  0.170M/s/cpu)
> uprobe-nop            (40 cpus):    5.262 ± 0.070M/s  (  0.132M/s/cpu)
> uprobe-nop            (48 cpus):    6.121 ± 0.010M/s  (  0.128M/s/cpu)
> uprobe-nop            (56 cpus):    6.252 ± 0.035M/s  (  0.112M/s/cpu)
> uprobe-nop            (64 cpus):    7.644 ± 0.023M/s  (  0.119M/s/cpu)
> uprobe-nop            (72 cpus):    7.781 ± 0.001M/s  (  0.108M/s/cpu)
> uprobe-nop            (80 cpus):    8.992 ± 0.048M/s  (  0.112M/s/cpu)
> 
> AFTER
> =====
> uprobe-nop            ( 1 cpus):    3.534 ± 0.033M/s  (  3.534M/s/cpu)
> uprobe-nop            ( 2 cpus):    6.701 ± 0.007M/s  (  3.351M/s/cpu)
> uprobe-nop            ( 3 cpus):   10.031 ± 0.007M/s  (  3.344M/s/cpu)
> uprobe-nop            ( 4 cpus):   13.003 ± 0.012M/s  (  3.251M/s/cpu)
> uprobe-nop            ( 5 cpus):   16.274 ± 0.006M/s  (  3.255M/s/cpu)
> uprobe-nop            ( 6 cpus):   19.563 ± 0.024M/s  (  3.261M/s/cpu)
> uprobe-nop            ( 7 cpus):   22.696 ± 0.054M/s  (  3.242M/s/cpu)
> uprobe-nop            ( 8 cpus):   24.534 ± 0.010M/s  (  3.067M/s/cpu)
> uprobe-nop            (10 cpus):   30.475 ± 0.117M/s  (  3.047M/s/cpu)
> uprobe-nop            (12 cpus):   33.371 ± 0.017M/s  (  2.781M/s/cpu)
> uprobe-nop            (14 cpus):   38.864 ± 0.004M/s  (  2.776M/s/cpu)
> uprobe-nop            (16 cpus):   41.476 ± 0.020M/s  (  2.592M/s/cpu)
> uprobe-nop            (24 cpus):   64.696 ± 0.021M/s  (  2.696M/s/cpu)
> uprobe-nop            (32 cpus):   85.054 ± 0.027M/s  (  2.658M/s/cpu)
> uprobe-nop            (40 cpus):  101.979 ± 0.032M/s  (  2.549M/s/cpu)
> uprobe-nop            (48 cpus):  110.518 ± 0.056M/s  (  2.302M/s/cpu)
> uprobe-nop            (56 cpus):  117.737 ± 0.020M/s  (  2.102M/s/cpu)
> uprobe-nop            (64 cpus):  124.613 ± 0.079M/s  (  1.947M/s/cpu)
> uprobe-nop            (72 cpus):  133.239 ± 0.032M/s  (  1.851M/s/cpu)
> uprobe-nop            (80 cpus):  142.037 ± 0.138M/s  (  1.775M/s/cpu)
> 
> Previously total throughput was maxing out at 11mln/s, and gradually
> declining past 8 cores. With this change, it now keeps growing with each
> added CPU, reaching 142mln/s at 80 CPUs (this was measured on a 80-core
> Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).
> 

Looks good to me, except one question below.

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 290c445768fa..efcd62f7051d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2074,6 +2074,47 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  	return is_trap_insn(&opcode);
>  }
>  
> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe *uprobe = NULL;
> +	struct vm_area_struct *vma;
> +	struct file *vm_file;
> +	loff_t offset;
> +	unsigned int seq;
> +
> +	guard(rcu)();
> +
> +	if (!mmap_lock_speculation_begin(mm, &seq))
> +		return NULL;
> +
> +	vma = vma_lookup(mm, bp_vaddr);
> +	if (!vma)
> +		return NULL;
> +
> +	/*
> +	 * vm_file memory can be reused for another instance of struct file,
> +	 * but can't be freed from under us, so it's safe to read fields from
> +	 * it, even if the values are some garbage values; ultimately
> +	 * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
> +	 * that whatever we speculatively found is correct

If vm_file is a garbage value, may `vm_file->f_inode` access be dangerous?

> +	 */
> +	vm_file = READ_ONCE(vma->vm_file);
> +	if (!vm_file)
> +		return NULL;
> +
> +	offset = (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vma->vm_start);
> +	uprobe = find_uprobe_rcu(vm_file->f_inode, offset);
                                       ^^^^ Here

if it only stores vm_file or NULL, there's no problem.

Thank you,

> +	if (!uprobe)
> +		return NULL;
> +
> +	/* now double check that nothing about MM changed */
> +	if (!mmap_lock_speculation_end(mm, seq))
> +		return NULL;
> +
> +	return uprobe;
> +}
> +
>  /* assumes being inside RCU protected region */
>  static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swbp)
>  {
> @@ -2081,6 +2122,10 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
>  	struct uprobe *uprobe = NULL;
>  	struct vm_area_struct *vma;
>  
> +	uprobe = find_active_uprobe_speculative(bp_vaddr);
> +	if (uprobe)
> +		return uprobe;
> +
>  	mmap_read_lock(mm);
>  	vma = vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

