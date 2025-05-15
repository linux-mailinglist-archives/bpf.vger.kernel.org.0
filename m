Return-Path: <bpf+bounces-58292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4BAB8614
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215824E5C51
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C329AAEA;
	Thu, 15 May 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/ni5BTn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3C298C20;
	Thu, 15 May 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311160; cv=none; b=p+dTtcS+TWaSogN4njqqkT+8SZC9d0H3TsJSdBc9tjlz3UXaH0XTE9K4JXldvxDK3y97CrTuiPUUZys+mL/wl0hZ073Fk7As7yxKQH6Oq6z6h2qV5+4DHN0V5HBkpczS3I8NRr0QQLGpr3V24gtId9AGfhje7zT/7/p+K4QZcIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311160; c=relaxed/simple;
	bh=f3y1gc/5GMb6J/v0333Uq/qC8N5P9TK+hMiVa1kZgvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0hucTnY/QjrbWzNmKR6q8hHEaEeexHArnAz+qSodj1HN7Jz32qnC102l476lCHHwEnGupwha28xAYmV+fdvcQjnOW7OKH/UjHje5e78xQc/v9KLsWewY+b9kEneR05fAyaW7LrRAj6T6liPfa1jHOZjCyLYloC8u0gsywfm4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/ni5BTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FA3C4CEE7;
	Thu, 15 May 2025 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311159;
	bh=f3y1gc/5GMb6J/v0333Uq/qC8N5P9TK+hMiVa1kZgvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/ni5BTnOi/nWh09T09jNCOkd67wZHdTA9SaCBXHkwZtJnHxWW9CLSHHMWYoR3VRM
	 Hp06iMO/jNFaS1liftpydKcjpr45uSFUQ5A3ublWf6K84+yH+Qb0LMxDs9Fqb0ont8
	 EZAA1kQMRS2076AIE4gXBtuPa9LSKqTaI4geFoSPd32fk7UIsEsykFaHDGwv3tThA/
	 nfig4xF+nSosLkfLx2gOE+k9yzcW49CgQ6pjnvmHjoqSrATuZjMYBBI0RJgD3Tw5wb
	 2r6KG9+BYBCQ5KFwJbfl5ABHnKbwtxxncGwV6jLztH4yCiJIZIxYq9ZBKs319/wWLk
	 IxodaEWQ0wJpA==
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
Subject: [PATCHv2 perf/core 05/22] uprobes: Add nbytes argument to uprobe_write
Date: Thu, 15 May 2025 14:11:02 +0200
Message-ID: <20250515121121.2332905-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding nbytes argument to uprobe_write and related functions as
preparation for writing whole instructions in following changes.

Also renaming opcode arguments to insn, which seems to fit better.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  4 ++--
 kernel/events/uprobes.c | 26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e13382054435..147c4a0a1af9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -188,7 +188,7 @@ struct uprobes_state {
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *opcode);
+				     uprobe_opcode_t *insn, int nbytes);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -199,7 +199,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 777de9b95dd7..f7feb7417a2c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -191,7 +191,8 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
+			 int nbytes)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -208,7 +209,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp = is_swbp_insn(&old_opcode);
 
-	if (is_swbp_insn(new_opcode)) {
+	if (is_swbp_insn(insn)) {
 		if (is_swbp)		/* register: already installed? */
 			return 0;
 	} else {
@@ -401,10 +402,10 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
 
 static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
-		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+		unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes)
 {
-	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
-	const bool is_register = !!is_swbp_insn(&opcode);
+	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
+	const bool is_register = !!is_swbp_insn(insn);
 	bool pmd_mappable;
 
 	/* For now, we'll only handle PTE-mapped folios. */
@@ -429,7 +430,7 @@ static int __uprobe_write(struct vm_area_struct *vma,
 	 */
 	flush_cache_page(vma, vaddr, pte_pfn(fw->pte));
 	fw->pte = ptep_clear_flush(vma, vaddr, fw->ptep);
-	copy_to_page(fw->page, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_to_page(fw->page, insn_vaddr, insn, nbytes);
 
 	/*
 	 * When unregistering, we may only zap a PTE if uffd is disabled and
@@ -489,13 +490,14 @@ static int __uprobe_write(struct vm_area_struct *vma,
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
-	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
+	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
-		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_verify_t verify)
+		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
+		 uprobe_write_verify_t verify)
 {
-	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
 	int ret, is_register, ref_ctr_updated = 0;
@@ -505,7 +507,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	struct folio *folio;
 	struct page *page;
 
-	is_register = is_swbp_insn(&opcode);
+	is_register = is_swbp_insn(insn);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
@@ -528,7 +530,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify(page, opcode_vaddr, &opcode);
+	ret = verify(page, insn_vaddr, insn, nbytes);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -567,7 +569,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
+			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
 		folio_walk_end(&fw, vma);
 	}
 
-- 
2.49.0


