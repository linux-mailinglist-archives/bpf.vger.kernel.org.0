Return-Path: <bpf+bounces-63835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA22B0B56E
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D5B189979E
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8C1FBE83;
	Sun, 20 Jul 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUmGCOBC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9643171CD;
	Sun, 20 Jul 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010535; cv=none; b=FgI7+2+0OsUhvv6FdstGxOt8SlJ5PZKIWJUb+psnnIa29okRLRDsOFgewXKmnwMM+YYL/NCpfTwlvmaWG6zouQLyNCJ+O5CpTTG0aAAF1bTUSwxYc0pdPuzst7pdqlhfgNCoRQjLxKChCruRPWjfkKscBsWvYg8Eyw4r4kGkdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010535; c=relaxed/simple;
	bh=geL5wi99WBaQQVMYMa32ctB7eAy6HUwiWFY7cutaiQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygj6QaMyrOz3uleDEpGlI8n+P1/5+5fp/wIjhln0JupFj7eloAsLHZtPO7ndl/MEIZmYkv7vrk7GVskGdKsvQMWsPQs5qmNN663luk0Itrvh4lxHngVMHeVHPj7uq30Q0i0elzrTwI/B0dQ2BzpFpjOJmZXGeXNHlQON2jy7zJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUmGCOBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1EAC4CEE7;
	Sun, 20 Jul 2025 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010534;
	bh=geL5wi99WBaQQVMYMa32ctB7eAy6HUwiWFY7cutaiQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUmGCOBCmJy+UbVSdn/p0rfRXJ+dbwbMGBGRS6R9b+tqhDu9dhuTxFEXn98AchXuC
	 Ucfhqnmn/uTjS51Eqg/RInpRqmUonwSD1yGul1m7EDumINqxcWVPWB8Hp4SiT4i3rB
	 s3TGtW8+fyrfWvlSNrs40GP6cNLItOA9uSzkdCe6ycXKCqpJTQHZyqRgFFCCuWzRUM
	 b/Dm4J/jdPGPZAtyKnDkCVLn24/Fv1dithZugXUEL2hW38C5w6jBOXk2/1GU3BFEjC
	 uhD57d3JxHS69ZYXKTBWCuQ4oau1pzd3tl9H/peUQ+wJnB7+LiNBliHJsJRtAUiuFt
	 i/rjskdKoksNQ==
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
Subject: [PATCHv6 perf/core 03/22] uprobes: Make copy_from_page global
Date: Sun, 20 Jul 2025 13:21:13 +0200
Message-ID: <20250720112133.244369-4-jolsa@kernel.org>
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

Making copy_from_page global and adding uprobe prefix.
Adding the uprobe prefix to copy_to_page as well for symmetry.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
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
2.50.1


