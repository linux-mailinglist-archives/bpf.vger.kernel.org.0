Return-Path: <bpf+bounces-52347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9942AA4227C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A821606B6
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42261149C53;
	Mon, 24 Feb 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOPsBFVZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08081482E1;
	Mon, 24 Feb 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405762; cv=none; b=GFCJv4W/F7BFaUYfrrclWjvnI9cqLFdumDh3DDS2rZE3FEcX01xMuC4UKd2RYSyvnWPsor9uTiFd/wW1rAKPApz8LAUXPPY9t+Zqn3dlTVfoSX+UkVZ9KN61PZdbPz7/o+LaA2TbHVIbX4Y55SSp3G6RZSMhWksaU0VwfzCVVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405762; c=relaxed/simple;
	bh=1vjjZ48Ox6Uip99qBsyCo6U9XbffBGAbeDhJoXIFzG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdnaWpf8+YBjD5+3FiZJTPFfAMK4Su6PQwRjWYWq6gvu9NjzjdYyW7kSkWy0j+OM90/HlJjziNiigICjKpSCal3UC/MzlG4ZQDI7utLjHpjJgPVsiiPq15JspUR1AydhO9T4xNB0tMECiMAvhN+9zoqvnaBetxpEc+UI2TsNOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOPsBFVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193ECC4CEE6;
	Mon, 24 Feb 2025 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405762;
	bh=1vjjZ48Ox6Uip99qBsyCo6U9XbffBGAbeDhJoXIFzG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOPsBFVZQ0uLM24drCI4fSk9vxsOnDA0hnhVi5mD1RYN5XJFqNL3ERKb6AYlNghty
	 zPcSa5HwsLNSzKe1vspqIJGsok5kFgZ9D05tZWNkLEMkxY6QI1/rNQVQeD+LafpabJ
	 tIG59FPoNCCofIRmqzlcYHQLyQOFOYkN68IqPrjTmSoaF4r/LdqTXu+KrvA9RpcugE
	 /VkLFmzSayoYM3RUidK/s91ItfibP1xQarDBn0uYiI5p+KEaSYRdeWAFRb6tgvQg4w
	 pREAye8doZXNVnosqDLdYrFMlsy6jntQxnDa8COSjH9AXhwKV/vi8vcuNZMjlTB0XT
	 EEsePDHyGbbvw==
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
Subject: [PATCH RFCv2 04/18] uprobes: Add uprobe_write function
Date: Mon, 24 Feb 2025 15:01:36 +0100
Message-ID: <20250224140151.667679-5-jolsa@kernel.org>
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

Adding uprobe_write function that does what uprobe_write_opcode did
so far, but allows to pass verify callback function that checks the
memory location before writing the opcode.

It will be used in following changes to simplify the checking logic.

The uprobe_write_opcode now calls uprobe_write with verify_opcode as
the verify callback.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  4 ++++
 kernel/events/uprobes.c | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 8b295c1f28bf..732de4b796ce 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -185,6 +185,8 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode);
+
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -193,6 +195,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			uprobe_opcode_t *opcode, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 86c4eeda0ed9..50560b307522 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -472,6 +472,13 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode)
+{
+	return uprobe_write(auprobe, mm, vaddr, &opcode, verify_opcode);
+}
+
+int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
+		 unsigned long vaddr, uprobe_opcode_t *opcode,
+		 uprobe_write_verify_t verify)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -479,7 +486,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(&opcode);
+	is_register = is_swbp_insn(opcode);
 
 retry:
 	if (is_register)
@@ -489,7 +496,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify(old_page, vaddr, opcode);
 	if (ret <= 0)
 		goto put_old;
 
@@ -514,7 +521,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, opcode, UPROBE_SWBP_INSN_SIZE);
 
 	if (!is_register) {
 		struct page *orig_page;
-- 
2.48.1


