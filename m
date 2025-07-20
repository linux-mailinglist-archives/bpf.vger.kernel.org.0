Return-Path: <bpf+bounces-63836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63878B0B570
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C74C189BE5D
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F151F91D6;
	Sun, 20 Jul 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWEX3Hw3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39A171CD;
	Sun, 20 Jul 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010546; cv=none; b=kJw0B4CVdL2u8hdmIqfbHRTznTX4iyfDqctwYQX3lDQHuIDY15878qw4K6/aewqKL98qzHYeNT7KGMRZnxgIjEaHjdcV/dQRCD3/HoXlXIdcTLiXC38TXPhK//xRKiOay/QjIWgceut4nGzy5liY0CTQd4gX7vpIqnOk4fztNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010546; c=relaxed/simple;
	bh=3wXeyTv9tW+xfofOElXBiVq6TuulrUU11jEdC+dU88A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qfsi+rnwu8xWleqhs4p+yyPZPci9p7lvgviPhT8+fm2f94cG0QT/e1en9DEkb5ofY6WPH0UumZfW30qb4n3lo6i93XVJvzt3uD5gy0+/R46I+V36+LyfA8vyzJfD3hVJAX/LfZoRTLLAmOJdLCnHDlObHk+1pmCmHRuz2DfjgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWEX3Hw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C039EC4CEE7;
	Sun, 20 Jul 2025 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010545;
	bh=3wXeyTv9tW+xfofOElXBiVq6TuulrUU11jEdC+dU88A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWEX3Hw3Cbqlvyut/LMUX6wFj5LHDIgfOSnZWHnVyvAJYznobT56jDTylyx28rYIG
	 2rYi3e2FxhBe0/AZrAeaV2tcSjjI8VaUHLwork1xp7JEwb+82u3LsmahMmP2W5lH9s
	 bsOURJu15AbB0+jksnPfDAHM3S7WkVyX0BJXN+5FTQ67LuzuMlzZTdrx1Zp3wa4/N8
	 1z0wVrqx4yiMSJln+U1PgvuhpNfuSYtkqmZOdWDmOSwEzlpDHiTj6tFfxkt+awjOQO
	 ZpwSrwjNzKOHk9G19PXghw/z5W4IsZqvevVyVK62vlGJEb/G9M3HB9RVvX1BR2ueBr
	 3QpLwzMNn8d7g==
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
Subject: [PATCHv6 perf/core 04/22] uprobes: Add uprobe_write function
Date: Sun, 20 Jul 2025 13:21:14 +0200
Message-ID: <20250720112133.244369-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
2.50.1


