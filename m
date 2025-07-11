Return-Path: <bpf+bounces-63015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A5B0162E
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB691CA1F4F
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE621D5BC;
	Fri, 11 Jul 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCV0TquO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7718D;
	Fri, 11 Jul 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222661; cv=none; b=sBwfWBAwzWijK2A7b3Y+EaL6STx8gtmOsLL0bSoovYhEkCYrUTPztfybnB+/aOWPWaVDdwDOyqCj1aC+/WHLKOgO93cGOGBy2zKn0275V1HlZwGqTRGJvNade1EfdvZd0a/dQgFn4Rs+1wmKQGxFXA1fgMXk0jD1kn1YPybeG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222661; c=relaxed/simple;
	bh=2hP1Tu4xcc4Mb0iEU7MwEniODUPLIiCnN5GMTbbIiF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr/i9VJtjTIsID6yM7bcwmUeUgnDz2s7xE3jdzvhPUMDh4uQaY0s+IY1j8CRl/sbGQ/MLA5wWwjK0utoMWn4+Nu67isAgQ76pWg5aHxUV25vWzYvQHiVaW9qnb3E+YdYTo8FNb/MvnKNmB04+cHL/HV9zDbxDKUswEGKyE5ssW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCV0TquO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9F9C4CEED;
	Fri, 11 Jul 2025 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222661;
	bh=2hP1Tu4xcc4Mb0iEU7MwEniODUPLIiCnN5GMTbbIiF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCV0TquOQ1fto9U/DXAAGu20dLELrqHJlSvw6fVqNQsLNxMICt3VegMxPaPp9sNdQ
	 ln6NbidKzglUj/OaTCMFB1jKE+glX+kCyUkhEWydf3lCpRDMBHBG7zBNQPQY3d6CBW
	 7E0n5mUuCXZ/eTRfXdVKuA2ByFXpqZUAql+ZNuBysvUBFqTlsk9lpbuK7qbm90W1uy
	 ZybnQCAIGfhlzf3GbcVxDkZeoMjHu15oifL2Lz5fJAx3l3H46eZnqlK0+7TSvOetRw
	 k8JZsXVrPnPzHSE4H6BzjL/8cRifvSNqE6f4zkduLBceX3wGqh2Uo76mAE5AI3UFw3
	 /ravqle13oFpQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv5 perf/core 06/22] uprobes: Add is_register argument to uprobe_write and uprobe_write_opcode
Date: Fri, 11 Jul 2025 10:29:14 +0200
Message-ID: <20250711082931.3398027-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm/probes/uprobes/core.c |  2 +-
 include/linux/uprobes.h        |  5 +++--
 kernel/events/uprobes.c        | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index 147c4a0a1af9..518b26756469 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -197,9 +197,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
+			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f7feb7417a2c..1e5dc3b30707 100644
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
@@ -488,26 +488,27 @@ static int __uprobe_write(struct vm_area_struct *vma,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+		const unsigned long opcode_vaddr, uprobe_opcode_t opcode,
+		bool is_register)
 {
-	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
+	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
+			    verify_opcode, is_register);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify)
+		 uprobe_write_verify_t verify, bool is_register)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
-	int ret, is_register, ref_ctr_updated = 0;
+	int ret, ref_ctr_updated = 0;
 	unsigned int gup_flags = FOLL_FORCE;
 	struct mmu_notifier_range range;
 	struct folio_walk fw;
 	struct folio *folio;
 	struct page *page;
 
-	is_register = is_swbp_insn(insn);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
@@ -569,7 +570,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
+			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes, is_register);
 		folio_walk_end(&fw, vma);
 	}
 
@@ -611,7 +612,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN, true);
 }
 
 /**
@@ -627,7 +628,7 @@ int __weak set_orig_insn(struct arch_uprobe *auprobe,
 		struct vm_area_struct *vma, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, vma, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			*(uprobe_opcode_t *)&auprobe->insn, false);
 }
 
 /* uprobe should have guaranteed positive refcount */
-- 
2.50.0


