Return-Path: <bpf+bounces-56334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDF5A95832
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C816EA02
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AA1FFC5D;
	Mon, 21 Apr 2025 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxx6CmQa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAE1D95A3;
	Mon, 21 Apr 2025 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271933; cv=none; b=uDxwY6C42rELkzxvNVu0ThqyvFgx7PCidoqHXoKgwRq5J8U7vzMYW8EJTL/zlatPuxUVHrfiBzcItN8n0C0qQkl8wBnUvxXsO2Lwc4ViyfZQkX3UkKvCEq2DDlM7FSFPERClxp2X63na55pqmTX8wWq7+5rwnigiEDNT2MM7FDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271933; c=relaxed/simple;
	bh=WAr4VO6L2RSNG4Tm5YcaCBQFDkvAdBO38Tj4GEwe010=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpEHNnASJ6O3IheNQ5eQka8Hy6Mu3HOYgZ6ah3LmH73iS6J0F6N+CkT8dNb5dkl6CaAbxD48n267Df9IxeAQEttngvb8F2pwsndl9l0ByNgot8gVtkULsVKKq3PXpNbimqC1SDVBPBsHCl4h6nx22osyvuBuLY8o9WaFMfFelLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxx6CmQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE185C4CEEA;
	Mon, 21 Apr 2025 21:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271932;
	bh=WAr4VO6L2RSNG4Tm5YcaCBQFDkvAdBO38Tj4GEwe010=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bxx6CmQamaajAJ9qAbBIp+0TcE37OqNeN3UC6LGWz5oRqGeK1J10tWhI/fvB48Nw7
	 wzV6ea07yGmgVk3pqpCR+bj1eQ2ySpfcs6Swfu6v6SQTXBtN4HeUvu7cLUoeqmYOLW
	 YbFjEdCB4FrEsDSOar08XqgDLCQ2q9eK0+pBtVWgU55evSZmfiVc+a1qBM58aMaKpD
	 b1+ISufxdZeCtwow9AyyTltfkLq4NrzFYZXKCM5dJt7AWPNutequTXMvko5LpQ1J8e
	 qanwjD0PBRR83WbRCMilmxLyORhWvbVHbuV7DF7fa95fdZMULEZo3FeRH5MKIckM9F
	 lqN3o5Ul8H1WA==
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
Subject: [PATCH perf/core 05/22] uprobes: Add nbytes argument to uprobe_write
Date: Mon, 21 Apr 2025 23:44:05 +0200
Message-ID: <20250421214423.393661-6-jolsa@kernel.org>
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

Adding nbytes argument to uprobe_write and related functions as
preparation for writing whole instructions in following changes.

Also renaming opcode arguments to insn, which seems to fit better.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  6 +++---
 kernel/events/uprobes.c | 27 ++++++++++++++-------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 09fe93816173..b86a2f0475a4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -188,7 +188,7 @@ struct uprobes_state {
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *opcode);
+				     uprobe_opcode_t *insn, int nbytes);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -198,8 +198,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t opcode);
-extern int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
+extern int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3c5dc86bfe65..6dc7f0b2756d 100644
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
@@ -489,13 +490,13 @@ static int __uprobe_write(struct vm_area_struct *vma,
 int uprobe_write_opcode(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
 			uprobe_opcode_t opcode)
 {
-	return uprobe_write(vma, opcode_vaddr, opcode, verify_opcode);
+	return uprobe_write(vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
 }
 
-int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-		 uprobe_opcode_t opcode, uprobe_write_verify_t verify)
+int uprobe_write(struct vm_area_struct *vma, const unsigned long insn_vaddr,
+		 uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify)
 {
-	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
 	int ret, is_register;
 	unsigned int gup_flags = FOLL_FORCE;
@@ -504,7 +505,7 @@ int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
 	struct folio *folio;
 	struct page *page;
 
-	is_register = is_swbp_insn(&opcode);
+	is_register = is_swbp_insn(insn);
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
 		return -EINVAL;
@@ -526,7 +527,7 @@ int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify(page, opcode_vaddr, &opcode);
+	ret = verify(page, insn_vaddr, insn, nbytes);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -554,7 +555,7 @@ int uprobe_write(struct vm_area_struct *vma, const unsigned long opcode_vaddr,
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
+			ret = __uprobe_write(vma, &fw, folio, insn_vaddr, insn, nbytes);
 		folio_walk_end(&fw, vma);
 	}
 
-- 
2.49.0


