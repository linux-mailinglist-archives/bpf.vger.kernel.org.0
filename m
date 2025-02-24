Return-Path: <bpf+bounces-52350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBCA42268
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0253C189DA6C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EF878F4E;
	Mon, 24 Feb 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crLC4KtJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F8770FE;
	Mon, 24 Feb 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405796; cv=none; b=cAu8J57EYzhaCW4v/sOaPyz670zQE0z/Ahm7pIoEKcU1bk+YuGBHZxCrwgMuIIke1l7Ls3DVzj+xvY7oe+oOE9vAFWdQSL9VczRxsCW1jQhkZIQkNfD3gOShun5gtuzl1/J2i+WaSfLbtUp2NrHNHd1KJPvaBqFgbKGXLcJkyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405796; c=relaxed/simple;
	bh=gXStF15mrWuB86Dc5JXJRxTckI8b4HGElcV+Wws69jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyuqv9+IbGvQ0Ph2MMz9nPQP0OQgSqhO6CqdZimVkaw/mlvFR8wr6QP2Ct57ynE4We+75Az7iwsuP5RSdi5zWmFpiRWY7CCBEwWY/rm1LeflV795BxzDDUO5fqbFfEi4LQPDW+NCIoFgyD1R0OZ/caMewgCYIRLstCaHJT+vxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crLC4KtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FBCC4CED6;
	Mon, 24 Feb 2025 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405795;
	bh=gXStF15mrWuB86Dc5JXJRxTckI8b4HGElcV+Wws69jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crLC4KtJsmcEG1ukwai5/PDQHN3AznkvD4svx0WXZ48Hrfl94vBXne0kBy2wsNC4L
	 QWge4ax1zQlOMZ7FHHxb3xjSNhMCB+50j2rgmuraRhhd66XddSdNtS3hgGY80xUt6E
	 GQwb7YcDPbrdM7w//pl6w+ISa4m20wg1vDrPiahqXrUoiVa+hGZKjewKIC6NybHKn6
	 P+VP6o/m1PxinekmwqfaA8D6zthmEePAFwzX/ZSGhILdRhxhHzJr1YHb4bbrsyfHng
	 X4WWKfjBRNECoHbN+1Uvb2rYSjGIqfLN51eTui81EBFZSoEgBB119KijvtLIqy2SQ3
	 8mcpjb26/KF8w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 07/18] uprobes: Add swbp argument to arch_uretprobe_hijack_return_addr
Date: Mon, 24 Feb 2025 15:01:39 +0100
Message-ID: <20250224140151.667679-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding swbp argument to arch_uretprobe_hijack_return_addr, that
is passed all the way from handle_swbp function, so we can add
extra logic when it's called from syscall in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm/probes/uprobes/core.c     |  2 +-
 arch/arm64/kernel/probes/uprobes.c |  2 +-
 arch/csky/kernel/probes/uprobes.c  |  2 +-
 arch/loongarch/kernel/uprobes.c    |  2 +-
 arch/mips/kernel/uprobes.c         |  2 +-
 arch/powerpc/kernel/uprobes.c      |  2 +-
 arch/riscv/kernel/probes/uprobes.c |  2 +-
 arch/s390/kernel/uprobes.c         |  2 +-
 arch/sparc/kernel/uprobes.c        |  2 +-
 arch/x86/kernel/uprobes.c          |  2 +-
 include/linux/uprobes.h            |  3 ++-
 kernel/events/uprobes.c            | 10 +++++-----
 12 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 54a90b565285..4d854a310155 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -59,7 +59,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs, bool swbp)
 {
 	unsigned long orig_ret_vaddr;
 
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index cb3d05af36e3..a38bf900bca1 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -156,7 +156,7 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs, bool swbp)
 {
 	unsigned long orig_ret_vaddr;
 
diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
index 936bea6fd32d..81a950a73cb6 100644
--- a/arch/csky/kernel/probes/uprobes.c
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -124,7 +124,7 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs, bool swbp)
 {
 	unsigned long ra;
 
diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/uprobes.c
index 87abc7137b73..d8b221fafb71 100644
--- a/arch/loongarch/kernel/uprobes.c
+++ b/arch/loongarch/kernel/uprobes.c
@@ -96,7 +96,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 }
 
 unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-						struct pt_regs *regs)
+						struct pt_regs *regs, bool swbp)
 {
 	unsigned long ra = regs->regs[1];
 
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 401b148f8917..2727bcfd5331 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -196,7 +196,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *aup,
 }
 
 unsigned long arch_uretprobe_hijack_return_addr(
-	unsigned long trampoline_vaddr, struct pt_regs *regs)
+	unsigned long trampoline_vaddr, struct pt_regs *regs, bool swbp)
 {
 	unsigned long ra;
 
diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 95a41ae9dfa7..f3b3feb44586 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -195,7 +195,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 }
 
 unsigned long
-arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs)
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs, bool swbp)
 {
 	unsigned long orig_ret_vaddr;
 
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..ef8bc1f6a04e 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -128,7 +128,7 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs, bool swbp)
 {
 	unsigned long ra;
 
diff --git a/arch/s390/kernel/uprobes.c b/arch/s390/kernel/uprobes.c
index 5b0633ea8d93..48f79d9a25e9 100644
--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -141,7 +141,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 }
 
 unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
-						struct pt_regs *regs)
+						struct pt_regs *regs, bool swbp)
 {
 	unsigned long orig;
 
diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 305017bec164..aef4e0ff38f0 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -310,7 +310,7 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
 
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
-				  struct pt_regs *regs)
+				  struct pt_regs *regs, bool swbp)
 {
 	unsigned long orig_ret_vaddr = regs->u_regs[UREG_I7];
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 22a17c149a55..b06f3cd7551a 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1180,7 +1180,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 }
 
 unsigned long
-arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs)
+arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs, bool swbp)
 {
 	int rasize = sizeof_long(regs), nleft;
 	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit apps */
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1abcae9cde48..6c3c90a0d110 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -221,7 +221,8 @@ extern int  arch_uprobe_post_xol(struct arch_uprobe *aup, struct pt_regs *regs);
 extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
 extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
 extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
-extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
+extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs,
+						       bool swbp);
 extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx, struct pt_regs *regs);
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2b542043089e..cfcde7295e15 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2207,7 +2207,7 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 }
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
-			      struct return_instance *ri)
+			      struct return_instance *ri, bool swbp)
 {
 	struct uprobe_task *utask = current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
@@ -2225,7 +2225,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 	}
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
-	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
+	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs, swbp);
 	if (orig_ret_vaddr == -1)
 		goto free;
 
@@ -2503,7 +2503,7 @@ static bool ignore_ret_handler(int rc)
 	return rc == UPROBE_HANDLER_REMOVE || rc == UPROBE_HANDLER_IGNORE;
 }
 
-static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
+static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs, bool swbp)
 {
 	struct uprobe_consumer *uc;
 	bool has_consumers = false, remove = true;
@@ -2538,7 +2538,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->auprobe = NULL;
 
 	if (!ZERO_OR_NULL_PTR(ri))
-		prepare_uretprobe(uprobe, regs, ri);
+		prepare_uretprobe(uprobe, regs, ri, swbp);
 
 	if (remove && has_consumers) {
 		down_read(&uprobe->register_rwsem);
@@ -2720,7 +2720,7 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_ignore(&uprobe->arch, regs))
 		goto out;
 
-	handler_chain(uprobe, regs);
+	handler_chain(uprobe, regs, true);
 
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
-- 
2.48.1


