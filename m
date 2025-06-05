Return-Path: <bpf+bounces-59733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4CACF05B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C55B3A931F
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D26235063;
	Thu,  5 Jun 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKIdevML"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3492309BE;
	Thu,  5 Jun 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129885; cv=none; b=Q9bhep7VC+P2zW52U+1zADkalL+pZqhwmaejKiYTIKXFreocwi13ZfHes8edA+pyCSN5661JAEeOseEGaV4Fo75kS40TpH6mLr0nGtv1/pMrHL4Lu37mVcidiOa6TxbEZiTSntNBLgHzGPGYZLeg5YsekJD3+z0dGXNuwxBXm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129885; c=relaxed/simple;
	bh=TO8n6IV3i/1oCFictxEe+7OnH1I5/rbOe7ggwlTSDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxfalDOhsyd2ZuSDUhCqNZ9D3lVfPzCKpgEgEeA9hoFDFTjSaOeT8xecBEwKpDy4Ok74IJ7qAw5Ecgd12TOInDjS2sAe3wyBqjBz/OghF5y0801RyFHBhI08Pu6gM+KGStuRj+f6R+vCHdt8ChwraWvKNo5qWcMnfhxLlOeSvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKIdevML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321E5C4CEE7;
	Thu,  5 Jun 2025 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129884;
	bh=TO8n6IV3i/1oCFictxEe+7OnH1I5/rbOe7ggwlTSDkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKIdevMLZ1fFeejbo5SnGTtCizT5xjAGofqLhs4JpiVB9MhRqknxNpda51greaTbr
	 f6aN1/0Hn3K/FAwIprWwOrTTaFvZjZPbi0Qq/HV3MOrwD2QBwoR+O+KwISah7PSbHK
	 MQxmsFI8orB8o3H1Nz7TlB3YyLGu3ImCC8HXZ7oylAEXW71friAeoH2QpPBL8QxiuA
	 GyHeQmJj53/cBtJqBHRcKx9XugkzG5k6yoP+XdoMjRsrWGhYoJP1AbnfxFl9cMVAXO
	 gfNzTq042eH3efFWBmUtvMmsxo78WrqxTq2LfZkse+7ct2xj0N5RGqSE+bi9WrdU6h
	 orjhOsM2bfk6Q==
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
Subject: [PATCHv3 perf/core 04/22] uprobes: Add uprobe_write function
Date: Thu,  5 Jun 2025 15:23:31 +0200
Message-ID: <20250605132350.1488129-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605132350.1488129-1-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe_write function that does what uprobe_write_opcode did
so far, but allows to pass verify callback function that checks the
memory location before writing the opcode.

It will be used in following changes to implement specific checking
logic for instruction update.

The uprobe_write_opcode now calls uprobe_write with verify_opcode as
the verify callback.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  5 +++++
 kernel/events/uprobes.c | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7447e15559b8..e13382054435 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -187,6 +187,9 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
+				     uprobe_opcode_t *opcode);
+
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -195,6 +198,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
+			uprobe_opcode_t opcode, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 37d3a3f6e48a..777de9b95dd7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -399,7 +399,7 @@ static bool orig_page_is_identical(struct vm_area_struct *vma,
 	return identical;
 }
 
-static int __uprobe_write_opcode(struct vm_area_struct *vma,
+static int __uprobe_write(struct vm_area_struct *vma,
 		struct folio_walk *fw, struct folio *folio,
 		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
@@ -488,6 +488,12 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		const unsigned long opcode_vaddr, uprobe_opcode_t opcode)
+{
+	return uprobe_write(auprobe, vma, opcode_vaddr, opcode, verify_opcode);
+}
+
+int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		 const unsigned long opcode_vaddr, uprobe_opcode_t opcode, uprobe_write_verify_t verify)
 {
 	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -510,7 +516,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	 * page that we can safely modify. Use FOLL_WRITE to trigger a write
 	 * fault if required. When unregistering, we might be lucky and the
 	 * anon page is already gone. So defer write faults until really
-	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write_opcode()
+	 * required. Use FOLL_SPLIT_PMD, because __uprobe_write()
 	 * cannot deal with PMDs yet.
 	 */
 	if (is_register)
@@ -522,7 +528,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify_opcode(page, opcode_vaddr, &opcode);
+	ret = verify(page, opcode_vaddr, &opcode);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -561,7 +567,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	/* Walk the page tables again, to perform the actual update. */
 	if (folio_walk_start(&fw, vma, vaddr, 0)) {
 		if (fw.page == page)
-			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr, opcode);
+			ret = __uprobe_write(vma, &fw, folio, opcode_vaddr, opcode);
 		folio_walk_end(&fw, vma);
 	}
 
-- 
2.49.0


