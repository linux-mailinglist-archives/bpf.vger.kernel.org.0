Return-Path: <bpf+bounces-54443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60353A6A51F
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC17B460D09
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40321D5B3;
	Thu, 20 Mar 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyB1Nh4c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70221C9EB;
	Thu, 20 Mar 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470949; cv=none; b=e/IBqi4EFmB4t+cVllsWM859BbArWr5BauF5Pmf9BYBglCPu4IYywZKRrLA/gdXzaamxg/IFeonqGThK8JIyK9VFklexb0C61xtQ7Zqo63gPt0UaDPCViN6DxDLhW8+/rj01iEjSflcSPdzfC7w4GSfy5mUsQlSZ5E3XK9ot5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470949; c=relaxed/simple;
	bh=K+Q/GpzLS4iDPo/yApzgOMkS86rFYEuicCjjsPFTtcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGon8DHfoEYIm8Q8TGE7sRz6kS7coekEn1+j4uvR9YJ8tJBauGZMfOInGwGhQXwY++Iyio1ECxryWjxulc566NwSEsEolWCOPkwTjqjvOOio+7DD+jfzChXcODu3Q/oU1/KoilvCULoJLGMJAyvKy4V5el351xhXu/e0gTW7s7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyB1Nh4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0587BC4CEDD;
	Thu, 20 Mar 2025 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470948;
	bh=K+Q/GpzLS4iDPo/yApzgOMkS86rFYEuicCjjsPFTtcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyB1Nh4c76pAoR4t1MVnITU2aStnIT0sE0xAwAcK9engRjHBKkdtKZV+sj5TeK4sU
	 PP/k/qvGR053/2UzMH+SHDbmeuOwDXA9ROPARJ5OGtpz+humzuYIplCIylMnxxMfDV
	 C+MvCWdBu2eT5vjpaK5pLKwl4l9pwWJ2b9KGpOc6yaBGqOwa3TYwiiBCeA8iUji59r
	 Fk3WNDKraBzwal4YjXS/aKI7+oEFuXs/EAvLQOFM/n3f13Vs+2A+XTxGKXDDbN91sO
	 alvnK5tEX23BJrhikLfEZNxnGrXTyMyTWAitMxg4vj3wzS++3n6tqhqS6QxOIIhp2e
	 wVnhvCcic3Nwg==
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
Subject: [PATCH RFCv3 02/23] uprobes: Make copy_from_page global
Date: Thu, 20 Mar 2025 12:41:37 +0100
Message-ID: <20250320114200.14377-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
index 37cd745640b8..38803e8c8c3d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -226,6 +226,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e160445e7d07..5c9fc31c50f1 100644
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
@@ -530,7 +530,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 
 	if (!is_register) {
 		struct page *orig_page;
@@ -1036,7 +1036,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
 
 	return 0;
@@ -1380,7 +1380,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), uprobe_copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -1869,7 +1869,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	copy_to_page(page, vaddr, src, len);
+	uprobe_copy_to_page(page, vaddr, src, len);
 
 	/*
 	 * We probably need flush_icache_user_page() but it needs vma.
@@ -2364,7 +2364,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
-- 
2.49.0


