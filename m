Return-Path: <bpf+bounces-39878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B40978C71
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08591C24F23
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538338F58;
	Sat, 14 Sep 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHzUmrW6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE338C;
	Sat, 14 Sep 2024 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278021; cv=none; b=Hqxd0Sv91XNYK6a/LJ561s4Iajp1EFRnwN12u9K1guu0AXBQoGHw0vD+ulPLVosqAc1us6V/oGgrgAkkCxDCrGqHWudBh4Va5FJ04BPjt9QGUkhsbqLY+FO1xJKmNiabLBdSotpNQeIOXJM6TjzowZV1KOKmxOnftSABFIBA8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278021; c=relaxed/simple;
	bh=b2anS5rR6OZ5jXoHMGC0/vcLNMsTsR3jDOk7jVdHGu8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QoB2DIbeMTxyc9/aG7knELW7IS2ZiI6cy8nW7DjT5UnL3UAYmblGceaThsxvaB8tq04iJQgtzizbb5B/Jtxlhg2CevCAt3VXqP0fHWmK79J6epCLatLFKqt60JSgBI3VB9vVgUKSB2mfYYiKonNudvMpcG/vZD4e5o0GKuPZgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHzUmrW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B1C4CEC0;
	Sat, 14 Sep 2024 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726278021;
	bh=b2anS5rR6OZ5jXoHMGC0/vcLNMsTsR3jDOk7jVdHGu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UHzUmrW6q+uwwUrk5jMQ5dhMYPFsOsxwGLLevef52TkBTNSN+9zpdY82EszJ6hd0i
	 Q+6Evut5QICsuuOlescKq8eV5wTvBPri6eF+z2OcCzoVFvkOtLj+rCzTq32D6H2gX6
	 QOQORvCYTrRa4ejBgwHHk7BuCeNVCeonUfGY1q7mSa+GVmAdC5WZNGitxHFXOOxjm+
	 +fU1K3iaXrD1omphKyATxQecMgSYENcD7ptzhSsUChXRtRMNasQizLTSq1zUj+xJKg
	 oB7Y2PQrKrtgCQ5d19o3FLtCLF1ERJsIY6abcNfz0ZEnxLEMTTXRw7wrMkbPxyBY9J
	 yDPWMVlw9PcLw==
Date: Sat, 14 Sep 2024 10:40:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
 mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH] uprobes: switch to RCU Tasks Trace flavor for better
 performance
Message-Id: <20240914104016.0803799fa677b696766bf03d@kernel.org>
In-Reply-To: <20240910174312.3646590-1-andrii@kernel.org>
References: <20240910174312.3646590-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 10:43:12 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> This patch switches uprobes SRCU usage to RCU Tasks Trace flavor, which
> is optimized for more lightweight and quick readers (at the expense of
> slower writers, which for uprobes is a fine tradeof) and has better
> performance and scalability with number of CPUs.
> 
> Similarly to baseline vs SRCU, we've benchmarked SRCU-based
> implementation vs RCU Tasks Trace implementation.
> 
> SRCU
> ====
> uprobe-nop      ( 1 cpus):    3.276 ± 0.005M/s  (  3.276M/s/cpu)
> uprobe-nop      ( 2 cpus):    4.125 ± 0.002M/s  (  2.063M/s/cpu)
> uprobe-nop      ( 4 cpus):    7.713 ± 0.002M/s  (  1.928M/s/cpu)
> uprobe-nop      ( 8 cpus):    8.097 ± 0.006M/s  (  1.012M/s/cpu)
> uprobe-nop      (16 cpus):    6.501 ± 0.056M/s  (  0.406M/s/cpu)
> uprobe-nop      (32 cpus):    4.398 ± 0.084M/s  (  0.137M/s/cpu)
> uprobe-nop      (64 cpus):    6.452 ± 0.000M/s  (  0.101M/s/cpu)
> 
> uretprobe-nop   ( 1 cpus):    2.055 ± 0.001M/s  (  2.055M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.677 ± 0.000M/s  (  1.339M/s/cpu)
> uretprobe-nop   ( 4 cpus):    4.561 ± 0.003M/s  (  1.140M/s/cpu)
> uretprobe-nop   ( 8 cpus):    5.291 ± 0.002M/s  (  0.661M/s/cpu)
> uretprobe-nop   (16 cpus):    5.065 ± 0.019M/s  (  0.317M/s/cpu)
> uretprobe-nop   (32 cpus):    3.622 ± 0.003M/s  (  0.113M/s/cpu)
> uretprobe-nop   (64 cpus):    3.723 ± 0.002M/s  (  0.058M/s/cpu)
> 
> RCU Tasks Trace
> ===============
> uprobe-nop      ( 1 cpus):    3.396 ± 0.002M/s  (  3.396M/s/cpu)
> uprobe-nop      ( 2 cpus):    4.271 ± 0.006M/s  (  2.135M/s/cpu)
> uprobe-nop      ( 4 cpus):    8.499 ± 0.015M/s  (  2.125M/s/cpu)
> uprobe-nop      ( 8 cpus):   10.355 ± 0.028M/s  (  1.294M/s/cpu)
> uprobe-nop      (16 cpus):    7.615 ± 0.099M/s  (  0.476M/s/cpu)
> uprobe-nop      (32 cpus):    4.430 ± 0.007M/s  (  0.138M/s/cpu)
> uprobe-nop      (64 cpus):    6.887 ± 0.020M/s  (  0.108M/s/cpu)
> 
> uretprobe-nop   ( 1 cpus):    2.174 ± 0.001M/s  (  2.174M/s/cpu)
> uretprobe-nop   ( 2 cpus):    2.853 ± 0.001M/s  (  1.426M/s/cpu)
> uretprobe-nop   ( 4 cpus):    4.913 ± 0.002M/s  (  1.228M/s/cpu)
> uretprobe-nop   ( 8 cpus):    5.883 ± 0.002M/s  (  0.735M/s/cpu)
> uretprobe-nop   (16 cpus):    5.147 ± 0.001M/s  (  0.322M/s/cpu)
> uretprobe-nop   (32 cpus):    3.738 ± 0.008M/s  (  0.117M/s/cpu)
> uretprobe-nop   (64 cpus):    4.397 ± 0.002M/s  (  0.069M/s/cpu)
> 
> Peak throughput for uprobes increases from 8 mln/s to 10.3 mln/s
> (+28%!), and for uretprobes from 5.3 mln/s to 5.8 mln/s (+11%), as we
> have more work to do on uretprobes side.
> 
> Even single-thread (no contention) performance is slightly better: 3.276
> mln/s to 3.396 mln/s (+3.5%) for uprobes, and 2.055 mln/s to 2.174 mln/s
> (+5.8%) for uretprobes.
> 
> We also select TASKS_TRACE_RCU for UPROBES in Kconfig due to the new
> dependency.
> 

Looks good to me. Peter, do you have any comment?

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/Kconfig            |  1 +
>  kernel/events/uprobes.c | 38 ++++++++++++++++----------------------
>  2 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..a0df3f3dc484 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -126,6 +126,7 @@ config KPROBES_ON_FTRACE
>  config UPROBES
>  	def_bool n
>  	depends on ARCH_SUPPORTS_UPROBES
> +	select TASKS_TRACE_RCU
>  	help
>  	  Uprobes is the user-space counterpart to kprobes: they
>  	  enable instrumentation applications (such as 'perf probe')
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4b7e590dc428..a2e6a57f79f2 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -26,6 +26,7 @@
>  #include <linux/task_work.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/khugepaged.h>
> +#include <linux/rcupdate_trace.h>
>  
>  #include <linux/uprobes.h>
>  
> @@ -42,8 +43,6 @@ static struct rb_root uprobes_tree = RB_ROOT;
>  static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
>  static seqcount_rwlock_t uprobes_seqcount = SEQCNT_RWLOCK_ZERO(uprobes_seqcount, &uprobes_treelock);
>  
> -DEFINE_STATIC_SRCU(uprobes_srcu);
> -
>  #define UPROBES_HASH_SZ	13
>  /* serialize uprobe->pending_list */
>  static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
> @@ -652,7 +651,7 @@ static void put_uprobe(struct uprobe *uprobe)
>  	delayed_uprobe_remove(uprobe, NULL);
>  	mutex_unlock(&delayed_uprobe_lock);
>  
> -	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
> +	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
>  }
>  
>  static __always_inline
> @@ -707,7 +706,7 @@ static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
>  	struct rb_node *node;
>  	unsigned int seq;
>  
> -	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
> +	lockdep_assert(rcu_read_lock_trace_held());
>  
>  	do {
>  		seq = read_seqcount_begin(&uprobes_seqcount);
> @@ -935,8 +934,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
>  	bool ret = false;
>  
>  	down_read(&uprobe->consumer_rwsem);
> -	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> -				 srcu_read_lock_held(&uprobes_srcu)) {
> +	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		ret = consumer_filter(uc, mm);
>  		if (ret)
>  			break;
> @@ -1157,7 +1155,7 @@ void uprobe_unregister_sync(void)
>  	 * unlucky enough caller can free consumer's memory and cause
>  	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
>  	 */
> -	synchronize_srcu(&uprobes_srcu);
> +	synchronize_rcu_tasks_trace();
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
>  
> @@ -1241,19 +1239,18 @@ EXPORT_SYMBOL_GPL(uprobe_register);
>  int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	struct uprobe_consumer *con;
> -	int ret = -ENOENT, srcu_idx;
> +	int ret = -ENOENT;
>  
>  	down_write(&uprobe->register_rwsem);
>  
> -	srcu_idx = srcu_read_lock(&uprobes_srcu);
> -	list_for_each_entry_srcu(con, &uprobe->consumers, cons_node,
> -				 srcu_read_lock_held(&uprobes_srcu)) {
> +	rcu_read_lock_trace();
> +	list_for_each_entry_rcu(con, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		if (con == uc) {
>  			ret = register_for_each_vma(uprobe, add ? uc : NULL);
>  			break;
>  		}
>  	}
> -	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> +	rcu_read_unlock_trace();
>  
>  	up_write(&uprobe->register_rwsem);
>  
> @@ -2123,8 +2120,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  
>  	current->utask->auprobe = &uprobe->arch;
>  
> -	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> -				 srcu_read_lock_held(&uprobes_srcu)) {
> +	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		int rc = 0;
>  
>  		if (uc->handler) {
> @@ -2162,15 +2158,13 @@ handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe = ri->uprobe;
>  	struct uprobe_consumer *uc;
> -	int srcu_idx;
>  
> -	srcu_idx = srcu_read_lock(&uprobes_srcu);
> -	list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> -				 srcu_read_lock_held(&uprobes_srcu)) {
> +	rcu_read_lock_trace();
> +	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
>  		if (uc->ret_handler)
>  			uc->ret_handler(uc, ri->func, regs);
>  	}
> -	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> +	rcu_read_unlock_trace();
>  }
>  
>  static struct return_instance *find_next_ret_chain(struct return_instance *ri)
> @@ -2255,13 +2249,13 @@ static void handle_swbp(struct pt_regs *regs)
>  {
>  	struct uprobe *uprobe;
>  	unsigned long bp_vaddr;
> -	int is_swbp, srcu_idx;
> +	int is_swbp;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
>  	if (bp_vaddr == uprobe_get_trampoline_vaddr())
>  		return uprobe_handle_trampoline(regs);
>  
> -	srcu_idx = srcu_read_lock(&uprobes_srcu);
> +	rcu_read_lock_trace();
>  
>  	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
>  	if (!uprobe) {
> @@ -2319,7 +2313,7 @@ static void handle_swbp(struct pt_regs *regs)
>  
>  out:
>  	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
> -	srcu_read_unlock(&uprobes_srcu, srcu_idx);
> +	rcu_read_unlock_trace();
>  }
>  
>  /*
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

