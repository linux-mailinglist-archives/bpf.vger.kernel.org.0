Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557EB403B5F
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351903AbhIHOTE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348439AbhIHOTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 10:19:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AAC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K3c4admWR4gldQKEPEe5gWynZ3x1NgTqfELwQpcSQAA=; b=hhlydR8BQBq52CNAiv8V4H69XA
        ilaKtiTXaUa236OM8pPXT+zjwLzzYYPQd45e/F8zA7NtJdbP0yv8ghY+RurdF14B2qlz9Ob57FFMR
        Kx0twlQXQoDFZFiw8Hd/zZoOS66qOMrPX23o05foMdFG6QvBg8UpJqOy9SWAV6MyUAnWkjiGv+Fja
        a+itQadzctM3FDfwc0oxfG8K+Ov0ccxRR75hBpdwLLNnYnNIi+Vdems/Vz9RMsgjV8XZQsvsoqhX2
        3/uF02BVIDU1UFjq3Vz4drGPY9rkV4zhwHXV8f+dirafsVha5wHEumOia5nZVSR2nih+Ggv1WOCPB
        cHTNTviQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNyM7-008sCs-NL; Wed, 08 Sep 2021 14:15:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BFCE300332;
        Wed,  8 Sep 2021 16:15:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEF6E265A0281; Wed,  8 Sep 2021 16:15:13 +0200 (CEST)
Date:   Wed, 8 Sep 2021 16:15:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Luigi Rizzo <lrizzo@google.com>, liam.howlett@oracle.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Message-ID: <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908135326.GZ1200268@ziepe.ca>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
> 
> > > The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > > which added mmap_assert_locked() in find_vma() function. The mmap_assert_locked() function
> > > asserts that mm->mmap_lock needs to be held. But this is not the case for
> > > bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), which
> > > uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not held
> > > in bpf_get_stack[id]() use case, the above warning is emitted during test run.
> > > 
> > > This patch added function find_vma_no_check() which does not have mmap_assert_locked() call and
> > > bpf_get_stack[id]() helpers call find_vma_no_check() instead. This resolved the above warning.
> > > 
> > > I didn't use __find_vma() name because it has been used in drivers/gpu/drm/i915/i915_gpu_error.c:
> > >      static struct i915_vma_coredump *
> > >      __find_vma(struct i915_vma_coredump *vma, const char *name) { ... }
> > > 
> > > Cc: Luigi Rizzo <lrizzo@google.com>
> > > Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to find_vma*()")
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > 
> > Luigi / Liam / Andrew, if the below looks reasonable to you, any objections to route the
> > fix with your ACKs via bpf tree to Linus (or strong preference via -mm fixes)?
> 
> Michel added this remark along with the mmap_read_trylock_non_owner:
> 
>     It's still not ideal that bpf/stackmap subverts the lock ownership in this
>     way.  Thanks to Peter Zijlstra for suggesting this API as the least-ugly
>     way of addressing this in the short term.
> 
> Subverting lockdep and then adding more and more core MM APIs to
> support this seems quite a bit more ugly than originally expected.
> 
> Michel's original idea to split out the lockdep abuse and put it only
> in BPF is probably better. Obtain the mmap_read_trylock normally as
> owner and then release ownership only before triggering the work. At
> least lockdep will continue to work properly for the find_vma.

The only right solution to all of this is the below. That function
downright subverts all the locking rules we have. Spreading the hacks
any further than that one function is absolutely unacceptable.

The only sane approach is making the vma tree lockless, but so far the
bpf people have resisted doing the right thing because they've been
allowed to get away with these atrocities.

---
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 6fbc2abe9c91..e2c7ab0a41f4 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -48,8 +48,6 @@ static void do_up_read(struct irq_work *entry)
 	mmap_read_unlock_non_owner(work->mm);
 }
 
-static DEFINE_PER_CPU(struct stack_map_irq_work, up_read_work);
-
 static inline bool stack_map_use_build_id(struct bpf_map *map)
 {
 	return (map->map_flags & BPF_F_STACK_BUILD_ID);
@@ -148,67 +146,14 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u64 *ips, u32 trace_nr, bool user)
 {
 	int i;
-	struct vm_area_struct *vma;
-	bool irq_work_busy = false;
-	struct stack_map_irq_work *work = NULL;
-
-	if (irqs_disabled()) {
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			work = this_cpu_ptr(&up_read_work);
-			if (irq_work_is_busy(&work->irq_work)) {
-				/* cannot queue more up_read, fallback */
-				irq_work_busy = true;
-			}
-		} else {
-			/*
-			 * PREEMPT_RT does not allow to trylock mmap sem in
-			 * interrupt disabled context. Force the fallback code.
-			 */
-			irq_work_busy = true;
-		}
-	}
-
-	/*
-	 * We cannot do up_read() when the irq is disabled, because of
-	 * risk to deadlock with rq_lock. To do build_id lookup when the
-	 * irqs are disabled, we need to run up_read() in irq_work. We use
-	 * a percpu variable to do the irq_work. If the irq_work is
-	 * already used by another lookup, we fall back to report ips.
-	 *
-	 * Same fallback is used for kernel stack (!user) on a stackmap
-	 * with build_id.
-	 */
-	if (!user || !current || !current->mm || irq_work_busy ||
-	    !mmap_read_trylock_non_owner(current->mm)) {
-		/* cannot access current->mm, fall back to ips */
-		for (i = 0; i < trace_nr; i++) {
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
-		}
-		return;
-	}
 
+	/* cannot access current->mm, fall back to ips */
 	for (i = 0; i < trace_nr; i++) {
-		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
-			/* per entry fall back to ips */
-			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
-			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
-			continue;
-		}
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
-			- vma->vm_start;
-		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
-	}
-
-	if (!work) {
-		mmap_read_unlock_non_owner(current->mm);
-	} else {
-		work->mm = current->mm;
-		irq_work_queue(&work->irq_work);
+		id_offs[i].status = BPF_STACK_BUILD_ID_IP;
+		id_offs[i].ip = ips[i];
+		memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 	}
+	return;
 }
 
 static struct perf_callchain_entry *
@@ -714,16 +659,3 @@ const struct bpf_map_ops stack_trace_map_ops = {
 	.map_btf_name = "bpf_stack_map",
 	.map_btf_id = &stack_trace_map_btf_id,
 };
-
-static int __init stack_map_init(void)
-{
-	int cpu;
-	struct stack_map_irq_work *work;
-
-	for_each_possible_cpu(cpu) {
-		work = per_cpu_ptr(&up_read_work, cpu);
-		init_irq_work(&work->irq_work, do_up_read);
-	}
-	return 0;
-}
-subsys_initcall(stack_map_init);
