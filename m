Return-Path: <bpf+bounces-54447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604C8A6A533
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9446518926A9
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA12206B6;
	Thu, 20 Mar 2025 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGsrVw+O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFA21D5A4;
	Thu, 20 Mar 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470995; cv=none; b=cLrR0VuLYPSid98hDDKwtn2pZtQ+wVhg/qRzdF3qXmdWbjOAOp1yMJp1N7JALWDhfwXctTMb2xMQn3FDWPkCw6d/+8kGOtqA4+/BuKW2EOYVoXw0+Jgo6VcAYiKCaa3Jh7cM3UpJFSx487Q7UQSZKIdEECzzTB0I6Svo/xjdVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470995; c=relaxed/simple;
	bh=KSU2ukmX7mTdL+gi1iAK50sclTPx//DkxFIN2MWYSOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UF0xdx5aY9xwWmm98A9k+FrofFySOuq1zMJbBIDEmg3bW2J3yxyoBb9zyZ4cY1OqIY75/0O7TmDNiOg18AbVJC8rjLfCF3IsoWu9fRJppqpvHuDeGzHgGBIMm6RMlkOt0rXu+JrxGOEvmA8Gu0yYiRZSmqzCGKYDNhsJsCrID48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGsrVw+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D719CC4CEDD;
	Thu, 20 Mar 2025 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470993;
	bh=KSU2ukmX7mTdL+gi1iAK50sclTPx//DkxFIN2MWYSOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGsrVw+OteQ4vN4d4UHHiX3IFrPepawTkyn0Z1Rvk3QBApsGvtCSejGOUZCC3mDUE
	 cKU3reTjWSWUDQLjlUCEOfbNqGxUJ7nsFlphi3+hij6wdPec5GW1y4UdT5ut5UJ/Q4
	 dbpy6TkZep6virva1P5qeCMLg2yZd8HSXy2r1CG0hyQYitYwhlb6O/QCDU5f1aHWyc
	 /am0pVp2J9/ptjV17X/uqDwjTkUl6EusX5MKG2kCYAAOK/DpjeQFUp+tGsDwI/teSf
	 SejijpCJUz8KES81irEOd58Y61i0iWrvSdbhXC7dPRVHn9ohQ0QSCtiFA+k2EqahOJ
	 RpJB9I3YAF1IA==
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
Subject: [PATCH RFCv3 06/23] uprobes: Add orig argument to uprobe_write and uprobe_write_opcode
Date: Thu, 20 Mar 2025 12:41:41 +0100
Message-ID: <20250320114200.14377-7-jolsa@kernel.org>
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

The uprobe_write has special path to restore the original page when
we write original instruction back.

This happens when uprobe_write detects that we want to write anything
else but breakpoint instruction.

In following changes we want to use uprobe_write function for multiple
updates, so adding new function argument to denote that this is the
original instruction update. This way uprobe_write can make appropriate
checks and restore the original page when possible.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm/probes/uprobes/core.c |  2 +-
 include/linux/uprobes.h        |  5 +++--
 kernel/events/uprobes.c        | 22 ++++++++++------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c6e5f8..54a90b565285 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -30,7 +30,7 @@ int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(auprobe->bpinsn), false);
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index c69a05775394..1b6a4e2b5464 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -196,9 +196,10 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			       uprobe_opcode_t, bool);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool orig);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7ff1f07c8f79..92fed5e50ec1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -471,25 +471,23 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+			unsigned long vaddr, uprobe_opcode_t opcode, bool orig)
 {
-	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode);
+	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode, orig);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		 unsigned long vaddr, uprobe_opcode_t *insn,
-		 int nbytes, uprobe_write_verify_t verify)
+		 int nbytes, uprobe_write_verify_t verify, bool orig)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
-	int ret, is_register;
+	int ret;
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(insn);
-
 retry:
-	if (is_register)
+	if (!orig)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
 	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
@@ -505,14 +503,14 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		goto put_old;
 	}
 
-	if (WARN(!is_register && PageCompound(old_page),
+	if (WARN(orig && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
 		goto put_old;
 	}
 
 	ret = 0;
-	if (!is_register && !PageAnon(old_page))
+	if (orig && !PageAnon(old_page))
 		goto put_old;
 
 	ret = anon_vma_prepare(vma);
@@ -528,7 +526,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	copy_highpage(new_page, old_page);
 	uprobe_copy_to_page(new_page, vaddr, insn, nbytes);
 
-	if (!is_register) {
+	if (orig) {
 		struct page *orig_page;
 		pgoff_t index;
 
@@ -579,7 +577,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN, false);
 }
 
 static int set_swbp_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
@@ -614,7 +612,7 @@ int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			*(uprobe_opcode_t *)&auprobe->insn, true);
 }
 
 static int set_orig_refctr(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
-- 
2.49.0


