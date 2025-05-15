Return-Path: <bpf+bounces-58290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF4AB860D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8507D3AD195
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392329A9EE;
	Thu, 15 May 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0T1HHhQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057D29A9E7;
	Thu, 15 May 2025 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311132; cv=none; b=XCXUi6UDazGDwyCP+fNDl9GqLqPXhmkH2rd+5Lk7iCTCPfgYcr7O7gOfqH2nizg7hcaBYLPPtBwCH8wApP50Sq8hEAXrN3xsTFDFT4hAAH5h3jGFIvvZ0b+NkoPIQXILtPGKl8xYU/ehuVFU/tkiS9z10BfWcLOqYrP+uv+zFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311132; c=relaxed/simple;
	bh=rJ1cFRSKhWEQ8ah2sABr5re09YS836ImvLcPjyZmMX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAM+rk544eBBBKmgID6pW3FOBEW/KP8U2IWNl2Il9H4soi/vIHN1wb4Zu5hFIeAgq5dY3xBXfFrY2S74Cfdhvp2pLJJTEoDNrTj3nOfn0psgrHioH74Ldxxmpl+H1MdDkkZNzbYMIXlVRhCjpSvNPDBYNgb64ywSEcM4rnGbKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0T1HHhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61593C4CEE7;
	Thu, 15 May 2025 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311131;
	bh=rJ1cFRSKhWEQ8ah2sABr5re09YS836ImvLcPjyZmMX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0T1HHhQ9jxI5+ON8RD+kMog1RMjR6ZNrhr7touOa4jlLVV4iNkUi8wZyuMizvcow
	 Wde9cgGyBghOTsXY9CCs22RD6Ul0NUPIKVz5im7mAcYg64JzwrinulDlpUuH6B376T
	 qhG+BbkWh2Ughi7clVd58ZoMYlJjYjxjkwMbZgrfQosWN8IIl3k1dpBnOcegvlM/4g
	 +eQiFy7lmLN5W+wb6JXQXJ4IbUKHAssgmpXprs7JfZEhKOIdwP56oGt3/AxcO2EjJa
	 4PA0FSw/u/Y6DRuRTxBrwozlQShhM1c7PStgy+KmbmwhmArcSprvk9yHON85R+ruIN
	 7HqRaeebXrBXQ==
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
Subject: [PATCHv2 perf/core 03/22] uprobes: Make copy_from_page global
Date: Thu, 15 May 2025 14:11:00 +0200
Message-ID: <20250515121121.2332905-4-jolsa@kernel.org>
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

Making copy_from_page global and adding uprobe prefix.
Adding the uprobe prefix to copy_to_page as well for symmetry.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 01112f27cd21..7447e15559b8 100644
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
index 4e8e607abda8..37d3a3f6e48a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -177,7 +177,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
 {
 	void *kaddr = kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
@@ -205,7 +205,7 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -1052,7 +1052,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
 
 	return 0;
@@ -1398,7 +1398,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
 
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -2394,7 +2394,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
-- 
2.49.0


