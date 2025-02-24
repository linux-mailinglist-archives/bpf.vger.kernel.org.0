Return-Path: <bpf+bounces-52349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D633A4228B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95F417B0BC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980F1553BC;
	Mon, 24 Feb 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITDLs+Zy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D24154430;
	Mon, 24 Feb 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405784; cv=none; b=KxFic1iwvGHdkFRRtXj9W4zvgzdH3bnVVris8J7aifRqVtYuOvMcQWgpaoo15LB2ms7vAOMAgUi0td9amLFDnDcX0IjKSrWio3MBukeDR08vqRwIvRjuKJpYS/a/sZqRJmozO3tK8TY8GMOYifJebT5vk+JuqMewVuGmkP84s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405784; c=relaxed/simple;
	bh=QWCeB0t4biaaSmaCS4hAy6KgGL7EGSZY8hy6jheG62U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJQwEO35rDsOBm2pb+LzTJCIY9RqLWYs03cVs/cTiwbj6LRgEmkqm0I0OGfiz+THUmb1pOryH+1VjVfINpreAmwxMooZXRMvuOuNp9J3nDuk+j6qKmBnSPORVtTkugLNEa3aVs5kZVIwCuxejCsKr+p9zvQ9Mvdi3cGinEfuz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITDLs+Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E7EC4CED6;
	Mon, 24 Feb 2025 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405784;
	bh=QWCeB0t4biaaSmaCS4hAy6KgGL7EGSZY8hy6jheG62U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITDLs+Zy6eG7E6igcaJmRdwB1zbJ1pCGI56OhyzOz/8h2mcAZGHiWyITXSZT4FVL/
	 8ZOBvGynedhfLGY37RuzvOc3Q6ptiKlXlAZZIq7l1JktLxtofTRYXcw+cmmaDyicU0
	 TfeEOA0rJNlr1/uk6U3ZI13G8D+g48crIOZavVrVMbtPtIdb6MgzFN0IfcRqyYXR9I
	 0pcxZ/q3xb+AAETbMBdRxJHojrxahchD99VJl1fRsGPgGhMFUqjbZv+RdiUbSIzhWa
	 tofRrUCNLi7d3VVJ1BzbPiR3AfdKsk3FnmngaHa7JWoSdUEtqj4oAJAYV8O/HGHE+L
	 Nm9Gpv4xt1Zzg==
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
Subject: [PATCH RFCv2 06/18] uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
Date: Mon, 24 Feb 2025 15:01:38 +0100
Message-ID: <20250224140151.667679-7-jolsa@kernel.org>
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

The uprobe_write has special path to restore the original page when
we write original instruction back.

This happens when uprobe_write detects that we want to write anything
else but breakpoint instruction.

In following changes we want to use uprobe_write function for multiple
updates, so adding new function argument to denote that this is the
original instruction update. This way uprobe_write can make appropriate
checks and restore the original page when possible.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm/probes/uprobes/core.c |  2 +-
 include/linux/uprobes.h        |  5 +++--
 kernel/events/uprobes.c        | 22 ++++++++++------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c6e5f8..54a90b565285 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(auprobe->bpinsn), false);
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 8867b6a168b2..1abcae9cde48 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -194,9 +194,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			       uprobe_opcode_t, bool);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool orig);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ad5879fc2d26..2b542043089e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -471,25 +471,23 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+			unsigned long vaddr, uprobe_opcode_t opcode, bool orig)
 {
-	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
+	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode, orig);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		 unsigned long vaddr, uprobe_opcode_t *insn,
-		 int nbytes, uprobe_write_verify_t verify)
+		 int nbytes, uprobe_write_verify_t verify, bool orig)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret, is_register;
+	int ret;
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(insn);
-
 retry:
-	if (is_register)
+	if (!orig)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
@@ -500,14 +498,14 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret <= 0)
 		goto put_old;
 
-	if (WARN(!is_register && PageCompound(old_page),
+	if (WARN(orig && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
 		goto put_old;
 	}
 
 	ret = 0;
-	if (!is_register && !PageAnon(old_page))
+	if (orig && !PageAnon(old_page))
 		goto put_old;
 
 	ret = anon_vma_prepare(vma);
@@ -523,7 +521,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	copy_highpage(new_page, old_page);
 	uprobe_copy_to_page(new_page, vaddr, insn, nbytes);
 
-	if (!is_register) {
+	if (orig) {
 		struct page *orig_page;
 		pgoff_t index;
 
@@ -574,7 +572,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN, false);
 }
 
 static int set_swbp_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
@@ -609,7 +607,7 @@ int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			*(uprobe_opcode_t *)&auprobe->insn, true);
 }
 
 static int set_orig_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
-- 
2.48.1


