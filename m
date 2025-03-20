Return-Path: <bpf+bounces-54445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF802A6A523
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDF9460D04
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5272206B6;
	Thu, 20 Mar 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlTnbktW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03621D5B1;
	Thu, 20 Mar 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470972; cv=none; b=RAfVKQlyzCFoixc9IrwyW5uQ86/9ye7APnc6T/xU79RK3pLCJohrvbWusfAGvurdTZZzQQMccGSHigdL6AoNq4VlnA6lg5MpySQAxJnrIY3DIXIM6eQzAfdKJB/bUl/fEKoD9abUuwtGdR06IUKWiTJ2XJ7ELB61aTCIT+9pvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470972; c=relaxed/simple;
	bh=N1xENbsrUrQxotsg7xlwvpaWh0l+dmWwjgkQ5pO+ETM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j50XKBnZZ1uIaSEOXc5Bp/PHDka2i8a/zmhYL6nfsPXoPsgQIgd2QjXktbl2uW5XYbrSLEMsp7HqK6DXEajQNVZk4bzLWwwQO3MUg0O4uDuSohlbAGigaUyH6Luye1oReyVnqWNEXfN/A/f4DSqzvOyxObRwpVCsvlJiePMBQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlTnbktW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B808C4CEE8;
	Thu, 20 Mar 2025 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470971;
	bh=N1xENbsrUrQxotsg7xlwvpaWh0l+dmWwjgkQ5pO+ETM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlTnbktWDjGUe8ykQq7/o3MVX5f7yixpYqQ+p9qYGcLOqPK6K4ELYXsvADgfCbU+m
	 rhISvb/1qlBvy04dXqjznw0KPDOllstjsWNq/1h6wunxZVc0gsV5LeXONbbp0wUpl8
	 jdKLdnThp89N54CYNljE5RpKTsThGm4IUogxsb5WSf72t1ZjdGdZJqXh1qlpW8N7lo
	 3Visn4DfT/t64YD7EHD9hOwQruNQUBvUZuEk/vlaRsjR/laOlL9eRLvyzALGJ8rPX/
	 5AcjJ2BIoQ8t9UJHN/0zStw+0yw9tu6iXOl7rxyRszs763gf9ejzMel8p2oTTcaU1P
	 63rFJPrUxu5Zw==
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
Subject: [PATCH RFCv3 04/23] uprobes: Add uprobe_write function
Date: Thu, 20 Mar 2025 12:41:39 +0100
Message-ID: <20250320114200.14377-5-jolsa@kernel.org>
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
index 38803e8c8c3d..1dbaebc30ff9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -187,6 +187,8 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode);
+
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -195,6 +197,8 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			uprobe_opcode_t *opcode, uprobe_write_verify_t verify);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 77b85b19f4c2..546e8755cf6d 100644
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
 
@@ -519,7 +526,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	uprobe_copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_to_page(new_page, vaddr, opcode, UPROBE_SWBP_INSN_SIZE);
 
 	if (!is_register) {
 		struct page *orig_page;
-- 
2.49.0


