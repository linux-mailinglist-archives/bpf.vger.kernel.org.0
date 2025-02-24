Return-Path: <bpf+bounces-52348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F10A4225E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07C5189D33A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2213B298;
	Mon, 24 Feb 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvA3hzvn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CE481DD;
	Mon, 24 Feb 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405774; cv=none; b=iXljRePMFpIXC3Xu5FrDMWnSdFvXjpVAtFzkSfLmrricVboKl5UPoo/DqJPz8KesSRnAHdhy4IcG1O8AXmuabBBW3UydcBzVl8uGO9CtWqfMa67h6lhsT0DnZPq1YWfh4NoCrH8GLNOFIA0zPMz1XrEDEDEPwhP0DLoWe007Omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405774; c=relaxed/simple;
	bh=kvVWa75J3CxacDmBPUCeUCky4uXBgbtWg8zknwELx5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e91bUwhrd64c/TuA/tJJwdgZYl+elUDv/tpB5zrHlB+zN1PWm6Qlza9VzwC/R5BGLxxfruV/wLt5ySO74EmB9zJQbGfJ+hw42nuVAU7qk3ewE+JK9wwxdbLbPP6/vHSrA7DxyDf3FlK6TAM6YsP4Mb+h9T1p0jlycVorvGKmi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvA3hzvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562C1C4CED6;
	Mon, 24 Feb 2025 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405773;
	bh=kvVWa75J3CxacDmBPUCeUCky4uXBgbtWg8zknwELx5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvA3hzvnqrSKCLMYclxGEvNtSoz1AZTxanuXVSfIOWSJo9VUiam7nxvuFPJx90kfG
	 RFarPC3uUtzMBz4SGf89RZMNGQ9Rgl59H0n7AkzkeG59j061mWczhDH0jOQUkY4na2
	 e+x01+jKLL61yT/inc8Cn4GXUASTyNtPh4AEPvc7QvtItvRcGeN3vmKh3prCKoXxYV
	 3LBUTB3N/b65kmF/fWkBnYUKBXn/M0Dv6FfiLzR63ikUbUlw7GQjZSSSO9kDwc/b4Y
	 SUAQiOW5GtUC0IcNut9Ryeo9rB6fLKXn6Uh8sVs4sDyU7UdM0aoAS8lv7IWNYkuna4
	 cySY4fqirEyQA==
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
Subject: [PATCH RFCv2 05/18] uprobes: Add nbytes argument to uprobe_write_opcode
Date: Mon, 24 Feb 2025 15:01:37 +0100
Message-ID: <20250224140151.667679-6-jolsa@kernel.org>
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

Adding nbytes argument to uprobe_write_opcode as preparation
for writing whole instructions in following changes.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  4 ++--
 kernel/events/uprobes.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 732de4b796ce..8867b6a168b2 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -185,7 +185,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
-typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode);
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode, int nbytes);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -196,7 +196,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t *opcode, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 50560b307522..ad5879fc2d26 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -264,7 +264,7 @@ static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const vo
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode, int nbytes)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -473,12 +473,12 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode)
 {
-	return uprobe_write(auprobe, mm, vaddr, &opcode, verify_opcode);
+	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
-		 unsigned long vaddr, uprobe_opcode_t *opcode,
-		 uprobe_write_verify_t verify)
+		 unsigned long vaddr, uprobe_opcode_t *insn,
+		 int nbytes, uprobe_write_verify_t verify)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -486,7 +486,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(opcode);
+	is_register = is_swbp_insn(insn);
 
 retry:
 	if (is_register)
@@ -496,7 +496,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify(old_page, vaddr, opcode);
+	ret = verify(old_page, vaddr, insn, nbytes);
 	if (ret <= 0)
 		goto put_old;
 
@@ -521,7 +521,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	uprobe_copy_to_page(new_page, vaddr, opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, insn, nbytes);
 
 	if (!is_register) {
 		struct page *orig_page;
-- 
2.48.1


