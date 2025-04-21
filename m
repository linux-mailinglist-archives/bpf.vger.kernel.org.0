Return-Path: <bpf+bounces-56335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A48A95836
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E66A16E251
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AC21A421;
	Mon, 21 Apr 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfnF32vF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5021ABAD;
	Mon, 21 Apr 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271945; cv=none; b=YpiJveEYsiUxoODo/YX/38+nPn/2q669du3FJww95B3mywTaVI0DjldYGCIjDBvyuHdJzojYOJVuHhmWRSFF8QcbgOoUZeXQXLXAXNT4M5wMD3tRAAuiXH52TDvmNJwwxZTtMaVUhaLWMeP42skNE/z7QFWMY6pL/10s9msoXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271945; c=relaxed/simple;
	bh=q0HSJq8brWtnkLHhuXhWrk+19fIQLZuRxYst30BTAT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3uw7x4RYKx9mo2Fvv86AD7AUW54juQ6oiBhKatIdpZs+Sup9jqeZbbAMlUENvXHvr+1f59UII/0HRul5O5scLhQcIooI/OeN7tXYe642nNkHwB4oXLpcRSyToEs0Y6HIvfLfZ2hID7RqBO7+W56GjUfDKzvgPRwwLcV2JOjJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfnF32vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D73C4CEEA;
	Mon, 21 Apr 2025 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271945;
	bh=q0HSJq8brWtnkLHhuXhWrk+19fIQLZuRxYst30BTAT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfnF32vFpurWGYwhwhhehrWxQdnZjOS4Y60E6yQYYPKswy5yzjbgg0cwBNSDHxPfw
	 x9d4AjZLaTHuClc9WgcV9O960O/+26Jvf1vBcK7+4ZoiLZQQr8UOuMcJFBl8yPYzcq
	 eAwryTQSRV/V2OgXOEgLqtEIknbZPji0IrbgsRRNOyJO9q8C7PzXj7vjhbZ4JBgeEi
	 CPTR9XgIrn4KTm8JZxHuhgxeiwDGuc8Vt9LONQMLYC45wcI+dqWMlXs9n73+pjlSB9
	 ragCvSDRaXtGx4fwQcZ4tKZrY/4sZ/eliVDgurUZg3saAEGXFC3t+hmYWg+j188jWf
	 mhNJmtJsvvH1Q==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 06/22] uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
Date: Mon, 21 Apr 2025 23:44:06 +0200
Message-ID: <20250421214423.393661-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uprobe_write has special path to restore the original page when we
write original instruction back. This happens when uprobe_write detects
that we want to write anything else but breakpoint instruction.

Moving the detection away and passing it to uprobe_write as argument,
so it's possible to write different instructions (other than just
breakpoint and rest).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm/probes/uprobes/core.c |  2 +-
 include/linux/uprobes.h        |  5 +++--
 kernel/events/uprobes.c        | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index 885e0c5e8c20..3d96fb41d624 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, vma, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(auprobe->bpinsn), true);
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b86a2f0475a4..6af61e977bfb 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -197,9 +197,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t opcode);
+extern int uprobe_write_opcode(struct vm_area_struct *vma, unsigned long vaddr,
+			       uprobe_opcode_t opcode, bool is_register);
 extern int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6dc7f0b2756d..c8d88060dfbf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -402,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
 
 static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
-		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
+		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
+		bool is_register)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
-	const bool is_register = !!is_swbp_insn(insn);
 	bool pmd_mappable;
 
 	/* For now, we'll only handle PTE-mapped folios. */
@@ -488,25 +488,25 @@ static int __uprobe_write(struct vm_area_struct *vma,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t opcode)
+			uprobe_opcode_t opcode, bool is_register)
 {
-	return uprobe_write(vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
+	return uprobe_write(vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
+			    verify_opcode, is_register);
 }
 
 int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
-		 uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify)
+		 uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify,
+		 bool is_register)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
-	int ret, is_register;
+	int ret;
 	unsigned int gup_flags = FOLL_FORCE;
 	struct mmu_notifier_range range;
 	struct folio_walk fw;
 	struct folio *folio;
 	struct page *page;
 
-	is_register = is_swbp_insn(insn);
-
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
 		return -EINVAL;
 
@@ -555,7 +555,7 @@ int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
+			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes, is_register);
 		folio_walk_end(&fw, vma);
 	}
 
@@ -593,7 +593,7 @@ int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
 int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		unsigned long vaddr)
 {
-	return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(vma, vaddr, UPROBE_SWBP_INSN, true);
 }
 
 static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
@@ -628,7 +628,7 @@ static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, un
 int __weak set_orig_insn(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
-	return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
+	return uprobe_write_opcode(vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn, false);
 }
 
 static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
-- 
2.49.0


