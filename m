Return-Path: <bpf+bounces-52345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FDA4224D
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36668189E488
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9613541B;
	Mon, 24 Feb 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf2mzUR6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020E51C4A;
	Mon, 24 Feb 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405740; cv=none; b=n1WRXSZ8ZxBsnpYZxfqzT6S2tsBd0DSB9NFvcA1UxNDpm58ohB//Br55T0OCrKAX+y0X8FQClsi89WNnIKo1hFBRUM3ytWZCuqCQv8aJVJNr73j4m0JDu9jd3Dr7wIExlsH26teQiyufFxSCs43Zl9XEgdDJ/70WpD7UktJ64z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405740; c=relaxed/simple;
	bh=TBGQ9p3hupR2F3rEPXtlaajYGbVbvGJLqr018KN4N4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcPrx+RoseyR6l7avlK/6BJH/xnwbB6Ki2veDuK195Q8zKi1WTCFi7s0FL/HY44Xf9HStMLTEbQGAM0qmPI2YsaLl4Nh1vCUcyCi9gjb8IUX6DpSW8/wQ/kbGIZ+i3IawCq2iQd/wZjU6FVEecBftZS18qcSQwmFfPAT6/UEONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf2mzUR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0572C4CEE8;
	Mon, 24 Feb 2025 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405739;
	bh=TBGQ9p3hupR2F3rEPXtlaajYGbVbvGJLqr018KN4N4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rf2mzUR6En/Ml15VfijJG0A6zgWBFTbfs5xxtggvTt43LUQb7T/7DS7/4r30mSobp
	 Ck0/n3V/WjkL92Nz1Qku44xjokQQDKgw1jC8UBaTVh7MFLB+ef/8gOmpYjKzDyLFLF
	 3VyPi5nFj9A+BYXzeobPe7oNKWxz46KwRqTPUAHK3SAT8BCbgtB0aC1cI0oYGlQxx9
	 6O+5a6bZ3Lkfz5s5onLq4Tf8R1y1fK3uUnIBGtd2BBKJMsDwORgC5EMVaGoycdy8M1
	 QdlPx+xl1Eaubi8muj8OzCfSHKokP+IQDbaY+vw2YmnLyy9pdVG/MhhLCmscrVPaQV
	 AYARuELVsFUfw==
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
Subject: [PATCH RFCv2 02/18] uprobes: Make copy_from_page global
Date: Mon, 24 Feb 2025 15:01:34 +0100
Message-ID: <20250224140151.667679-3-jolsa@kernel.org>
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

Making copy_from_page global and adding uprobe prefix.
Adding the uprobe prefix to copy_to_page as well for symmetry.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e3ed0d5c5ffe..8b295c1f28bf 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -224,6 +224,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cf4c4e730f0d..f07b6b7b199c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -250,14 +250,14 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
 	kunmap_atomic(kaddr);
 }
 
-static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
+static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
@@ -278,7 +278,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -525,7 +525,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 
 	if (!is_register) {
 		struct page *orig_page;
@@ -1027,7 +1027,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
 
 	return 0;
@@ -1371,7 +1371,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), uprobe_copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -1860,7 +1860,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	copy_to_page(page, vaddr, src, len);
+	uprobe_copy_to_page(page, vaddr, src, len);
 
 	/*
 	 * We probably need flush_icache_user_page() but it needs vma.
@@ -2355,7 +2355,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
-- 
2.48.1


