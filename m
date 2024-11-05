Return-Path: <bpf+bounces-44037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC99BCDF9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4303F1C2185E
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D41D9A5B;
	Tue,  5 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA/3DpSs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2141D86C7;
	Tue,  5 Nov 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813694; cv=none; b=ane4FgL+IlhoT8+klbQ2zozHn1R50Mu7uvsLtu8B6EPou2j5nZbnH1Oeal+itAfCS3odpbCtF8/8/VkBgGl+fNHRKgTmW/tLuBKQOSBHPMQf7mIA3UHK3ccrAwl2PiMnLXB5SfdJfEhUZI/6RMQPYHjPmTERyaWWG4mHF9Wl2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813694; c=relaxed/simple;
	bh=APszTcX/BrIYGhd6xCUj6f8ck+yVAHrqlRKgkckhCtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8dxwe0b4tSV9OFag2IszUYcEGHw26lnrHrxpaMwZrBas7DuvaP96zkK58Yhu/xMPu1T+EVLW6YgO0lZ9NUcMO3XR0yZXvk3UNuw6q2BRUwvfg+AFfQk79/ltFUyxfGPyxjJpVhoufKfF85Muot3koWxjMQ7mo0Q0RbL1hDSDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA/3DpSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5097C4CED0;
	Tue,  5 Nov 2024 13:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813693;
	bh=APszTcX/BrIYGhd6xCUj6f8ck+yVAHrqlRKgkckhCtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KA/3DpSsylGmlKhntbIR31NnPmDouwtgeprKXrjhny6kyAFuF1nmL3vgbpj/mYTvH
	 4iGLXqpNjpM5t9SFd58/EixHBHr6cjrHVslX4tORM/dbT4fK01RxGjcogJ8pTrqw+D
	 8WFAwPJezyFCvv8QyZsUPo6qjuG5rp0H6DnvHWHaK488NUkxiBigkP5kxPBeD42x6s
	 P+M/AhoDtyVaynRF6WM6usBYI/dZfkfgaEx+KlAhaRR2Bv+gVuZc7LH0a4EnyUeQFz
	 gu+8lg1BCCbdpKA1xJEUD99P5YPxtk61vc3UHQE3jqxrcJ2JYPJqmn+wHeosWlYEDa
	 06YR1O92fZS0w==
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
Subject: [RFC perf/core 04/11] uprobes: Add data argument to uprobe_write_opcode function
Date: Tue,  5 Nov 2024 14:33:58 +0100
Message-ID: <20241105133405.2703607-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding data argument to uprobe_write_opcode function and passing
it to newly added arch overloaded functions:

  arch_uprobe_verify_opcode
  arch_uprobe_is_register

This way each architecture can provide custmized verification.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  6 +++++-
 kernel/events/uprobes.c | 25 +++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7d23a4fee6f4..be306028ed59 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -182,7 +182,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			       unsigned long vaddr, uprobe_opcode_t *insn, int len);
+			       unsigned long vaddr, uprobe_opcode_t *insn, int len, void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
@@ -215,6 +215,10 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode);
+extern int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
+				     uprobe_opcode_t *new_opcode, void *data);
+extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3e275717789b..944d9df1f081 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -264,7 +264,13 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+__weak bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data)
+{
+	return is_swbp_insn(insn);
+}
+
+int uprobe_verify_opcode(struct page *page, unsigned long vaddr,
+			 uprobe_opcode_t *new_opcode)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -292,6 +298,12 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	return 1;
 }
 
+__weak int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
+				     uprobe_opcode_t *new_opcode, void *data)
+{
+	return uprobe_verify_opcode(page, vaddr, new_opcode);
+}
+
 static struct delayed_uprobe *
 delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
 {
@@ -471,7 +483,8 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t *insn, int len)
+			unsigned long vaddr, uprobe_opcode_t *insn, int len,
+			void *data)
 {
 	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
@@ -480,7 +493,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(insn);
+	is_register = arch_uprobe_is_register(insn, len, data);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
@@ -491,7 +504,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, insn);
+	ret = arch_uprobe_verify_opcode(old_page, vaddr, insn, data);
 	if (ret <= 0)
 		goto put_old;
 
@@ -584,7 +597,7 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
 {
 	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
-	return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE);
+	return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE, NULL);
 }
 
 /**
@@ -600,7 +613,7 @@ int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
+			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE, NULL);
 }
 
 /* uprobe should have guaranteed positive refcount */
-- 
2.47.0


