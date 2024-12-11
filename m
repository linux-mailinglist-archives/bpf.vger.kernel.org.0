Return-Path: <bpf+bounces-46628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963D79ECD49
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B47916969C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EA2336A9;
	Wed, 11 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY+sRvGL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF64229126;
	Wed, 11 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924082; cv=none; b=kDE9OdKY6c5Y9UuN/lco2k9Cnye+Ae5Nb5dvlUu/zMP+e6/eA/ioYLMpI89pNg+zpXFwNDAFfViUgWcu+3pM4kM0DnkfPZtaICEQNQqG7q06Sby2SgvLRUD25a5rhvrWNmXInW1lSdVQOefxdlTCHR/hBwqPcCle7ZUgyYHqb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924082; c=relaxed/simple;
	bh=JATuSHj8SuCkBQq5YKjQDIs8JNzgBKNYnCgW7ApmQfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM2reorf9d5khjiLCi8GzxiSE95Ndn/4M4WsgKkJ6j6gbwOk7zrHETonAfO+LM1lCBPbwbZvyQJ+8d7DvYp4CvoZYse9VKJqXs7gRKto6Op9JQ/gzIl5heE+jH1cYCQnt9KudCA7Ui/jXt9fxUJ84FRJUT9WwzzALBZ0sbI0BTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY+sRvGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1076C4CED2;
	Wed, 11 Dec 2024 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924081;
	bh=JATuSHj8SuCkBQq5YKjQDIs8JNzgBKNYnCgW7ApmQfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oY+sRvGLFwypjI2ecJCnd0URsdR/C5OeMOXV9wmXgTq3CQIzEZJvG9bhpg4wkS/Yx
	 7ljZ92jKwP3SAI6Xqt/5g4Q5siPHphJjpO5W4Qqw57R6Iei4P+nXVUUIQYjqOGN3in
	 BPLB0m1Bup6AXlH7T2l+yg5BgUi7svQH+UrH5ZlQ84HWVWhmr5mBCu61G3LZpRnMRw
	 ibhRSpF1s/94SqyUQUuwjPk0gGPNC2MNzBkCosP9KQlknJ1C0sMoK5/Gd2THXHSf13
	 oexQUqC9z06VqitpMpvSdFdmXHyxACRGLiRLz0d4q+qcKLuu1uzFb0Ch29HTM1ztmK
	 q8LodqZT2UtEQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 03/13] uprobes: Add nbytes argument to uprobe_write_opcode
Date: Wed, 11 Dec 2024 14:33:52 +0100
Message-ID: <20241211133403.208920-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding nbytes argument to uprobe_write_opcode as preparation
fo writing longer instructions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  3 ++-
 kernel/events/uprobes.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e24fbe496efb..cc723bc48c1d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -181,7 +181,8 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			       uprobe_opcode_t *insn, int nbytes);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 61ec91f635dc..7c2ecf11a573 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -470,7 +470,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+			unsigned long vaddr, uprobe_opcode_t *insn, int nbytes)
 {
 	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
@@ -479,7 +479,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(&opcode);
+	is_register = is_swbp_insn(insn);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
@@ -490,7 +490,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify_opcode(old_page, vaddr, insn);
 	if (ret <= 0)
 		goto put_old;
 
@@ -524,7 +524,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, insn, nbytes);
 
 	if (!is_register) {
 		struct page *orig_page;
@@ -581,7 +581,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE);
 }
 
 /**
@@ -597,7 +599,7 @@ int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
 }
 
 /* uprobe should have guaranteed positive refcount */
-- 
2.47.0


