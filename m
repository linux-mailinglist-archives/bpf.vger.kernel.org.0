Return-Path: <bpf+bounces-54446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69DA6A52B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452B19818DE
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C938220688;
	Thu, 20 Mar 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVzP6ba8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133F21E0BC;
	Thu, 20 Mar 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470983; cv=none; b=trF/kfULW65GKKQy6lVFm3blnol80DPVBp7rG9c/7bLmdxQtXsG8iIcJVEJexetVASa9ypdZicCrbY4BVyEWOnD5RndBnCyHC+mm19Gye/o9LernoRWGNw1QMbo4MtK6p8DBlJeqHci9Jv8UltHjBfyUJDNh7Dt9VQWIhBrlfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470983; c=relaxed/simple;
	bh=hMoN5nrOBX6BPHmo1EYYh4t0YkawVfiChcxjCi7UeBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNnobbiKmF2DONnDyeRmNr2E/H/iE8c4OKWwosqwlLhrBWqJcL54AgVVSqTTsmGs+XgXJVqXjEFi8niDxm2zpgVBrQtlVu31WvKC/du6+bVBfeIHVK78ou5bCf1X/jG/ce1vAgbqsKpTx2bdH50d/HXHCn42/JKtOeABUe4kO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVzP6ba8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96620C4CEE8;
	Thu, 20 Mar 2025 11:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470982;
	bh=hMoN5nrOBX6BPHmo1EYYh4t0YkawVfiChcxjCi7UeBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVzP6ba8ZkwsUCYildrFJMpMgUrpPRlN2rFyyAhMNRmr2bealjh3SFYYlwDp7LbjV
	 TI/cGLzjPMpRTUJMKZx4q/3kj+NO1P5Gz0xDO4sfxDTUaQ98oogP6J2fHmh/uOOa2g
	 LB8pDTWDoVkgB0Wg3MavTkQteGVjkD/3r8Znvp+ytp6JmaakPYK4y8/4gL9tMgwaQ5
	 VPbblOBuO5OUlYHRCZr74/yaIhPBaTeJGzols8rIqTQhj002sRWzLo4YykTHyOPkc4
	 1bdVBizqwOtDwrLrKFXZiA/2Ad/0k7yXKqNm2zMsS5DoXy93z4MXMVpTwSU0hxiikQ
	 Eo9o5Kb2T8aiQ==
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
Subject: [PATCH RFCv3 05/23] uprobes: Add nbytes argument to uprobe_write_opcode
Date: Thu, 20 Mar 2025 12:41:40 +0100
Message-ID: <20250320114200.14377-6-jolsa@kernel.org>
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

Adding nbytes argument to uprobe_write_opcode as preparation
for writing whole instructions in following changes.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  4 ++--
 kernel/events/uprobes.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1dbaebc30ff9..c69a05775394 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -187,7 +187,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
-typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode);
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode, int nbytes);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -198,7 +198,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t *opcode, uprobe_write_verify_t verify);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 546e8755cf6d..7ff1f07c8f79 100644
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
 
@@ -526,7 +526,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	uprobe_copy_to_page(new_page, vaddr, opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, insn, nbytes);
 
 	if (!is_register) {
 		struct page *orig_page;
-- 
2.49.0


