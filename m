Return-Path: <bpf+bounces-34375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0392CE5C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961C0B25F93
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CE18FA10;
	Wed, 10 Jul 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTZigf1f"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C813777F;
	Wed, 10 Jul 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604421; cv=none; b=fCGdOqmB5M0NOk2NvTWbWEXeOKUeBhMcvgK2nOWgiYPLdKHe/WsFoK5IszbfMGxICuBVC+dFIbhjNLSt4WWAgJ3QTMYj33XNI2XS2AMr4r8syt11xkiDA2U/P8CDxCmyrS5XUBfb268uTyxrc/A8L6LqJl8UfEQZf7RLtrs/epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604421; c=relaxed/simple;
	bh=61L9rkQ9dqZ3QSieSK9JvifiNh4ZOARWpXT+HEj3SOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad1cspxVyq93R3TzNHulfaq2kgbDswP8e8oiJm7HoSok1uuJU5vQc7xSMyef/uXeD2xcy5PAjjgROyZPPOqSS3Msh/8AciCuvrajHBxQouk+Ou2CEuWCZzwvtvdW3sV/qp//ZGz8upm2qisHo85TrgFMGHkwQYTwdhJEAWBLtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JTZigf1f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eEGyTTl/W/CCsANw8ThDof7pn/KbfM1qr9ZJYXfiiyo=; b=JTZigf1fyby+hNl6845U/wiln+
	C/g6HrgrMqpYjR6qvFIwN2htygfrc5+eq/a0CeC3g1G6ghz0SCo5/E2PW0dhaIdfTvOs45McNSSBz
	r0U6WMv+7pTWS8COtR5UIIUQOde2nv4wNm+k6G4SGOwTTmjIUH5zsGt7kt8O+10r0aJ9IlX0fl5MO
	UjUvkW0ISFVe4tlQLZCpYNXGlqt6NA1FCh67UqDxYM+/EigP+9PcKDMk3aasuXI4uKZKklTJfC+SF
	79oFIsgctpyfpv3H1qNQawvpZSXlhm95al2eRWD9h4xz1eXn/wHwncrBBLMd6HpnYWGofehaSHYym
	yQL86TyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRTo5-00000000t0L-44IM;
	Wed, 10 Jul 2024 09:40:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 99542300694; Wed, 10 Jul 2024 11:40:13 +0200 (CEST)
Date: Wed, 10 Jul 2024 11:40:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240710094013.GF28838@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710091631.GT27299@noisy.programming.kicks-ass.net>

On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:

> If it were an actual sequence count, I could make it work, but sadly,
> not. Also, vma_end_write() seems to be missing :-( If anything it could
> be used to lockdep annotate the thing.
> 
> Mooo.. I need to stare more at this to see if perhaps it can be made to
> work, but so far, no joy :/

See, this is what I want, except I can't close the race against VMA
modification because of that crazy locking scheme :/


--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
 	return is_trap_insn(&opcode);
 }
 
-static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
+#ifndef CONFIG_PER_VMA_LOCK
+static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
+{
+	return NULL;
+}
+#else
+static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
 {
 	struct mm_struct *mm = current->mm;
 	struct uprobe *uprobe = NULL;
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, bp_vaddr, bp_vaddr);
+
+	guard(rcu)();
+
+again:
+	vma = mas_walk(&mas);
+	if (!vma)
+		return NULL;
+
+	/* vma_write_start() -- in progress */
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
+		return NULL;
+
+	/* 
+	 * Completely broken, because of the crazy vma locking scheme you
+	 * cannot avoid the per-vma rwlock and doing so means you're racy
+	 * against modifications.
+	 *
+	 * A simple actual seqcount would'be been cheaper and more usefull.
+	 */
+
+	if (!valid_vma(vma, false))
+		return NULL;
+
+	struct inode = file_inode(vma->vm_file);
+	loff_t offset = vaddr_to_offset(vma, bp_vaddr);
+
+	// XXX: if (vma_seq_retry(...)) goto again;
+
+	return find_uprobe(inode, offset);
+}
+#endif
+
+static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
+{
+	struct uprobe *uprobe = __find_active_uprobe(bp_vaddr)
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	if (uprobe)
+		return uprobe;
 
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);

