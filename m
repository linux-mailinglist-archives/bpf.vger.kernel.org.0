Return-Path: <bpf+bounces-44036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2E9BCDF4
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC128343D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360861D8E1A;
	Tue,  5 Nov 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN/2UF1a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF731D8A10;
	Tue,  5 Nov 2024 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813683; cv=none; b=bcmY1rWV2p+8dpXjum96jbCoLNwi8kaJiYhpHHNzXBWb9chQq5qgQA6vHQN9zKW5z3JoF0pVzMkYGtdxXNCGLXjXTFaQQZSpABTbGQqEKHHwQucxXIImX/Wzj8s5nJca8QQk0VIpTwTJk56iH0F1LBjIOYk60aq3VGe1VRgRgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813683; c=relaxed/simple;
	bh=stFTvQD4RtZMfQ6w+MnxEIvGsnQkeuy7rwuTg/tvlHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkdBLvF+RwaPqXPMqTsoON5+n2puFXwtX3Xfj0VeatnwPtE7fVKf391zHrBq0+RBhiZZlZRXNO/CgAMJ84OsWtYmHObMdqJPD4G7/+BlqUOZEyqQWL55XnOrfNF1lYo3uDI9ySL3IyI+OCX+ZCCbiwTvvVDljdrMAq3CLg3GpqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN/2UF1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B98C4CECF;
	Tue,  5 Nov 2024 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813683;
	bh=stFTvQD4RtZMfQ6w+MnxEIvGsnQkeuy7rwuTg/tvlHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FN/2UF1aOH0s7w0ifCu5cg/nAujo0R0EFb7hQQ5HPXWrH1AIW/90sFpOi0ualdiiT
	 wHMVyBVEAPfSAszrmfeq1A/tXsn6J5FpyzXJxBZZohdurz2VIGbq6AodIOtzRHavob
	 jK0Wrrojx/W71Dtwd+LrcZqp65S4Ed+C51+ru6N7RMd8EIYLCvgBePoQh/Thh3jQWC
	 cb5+dqT2UnmCHcEGfxmHB/Ic3vpxQ+8vajPoRexYDwrLGIvpu1jWAyUDFciVYZr6Mq
	 YuHPUxg2ZFuBroRonb3HzHVveuRFKJe+lt7NVjP8UFwSfYUm/z1dxiEyUpswavAFK7
	 er9AjIRvdOHtg==
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
Subject: [RFC perf/core 03/11] uprobes: Add len argument to uprobe_write_opcode
Date: Tue,  5 Nov 2024 14:33:57 +0100
Message-ID: <20241105133405.2703607-4-jolsa@kernel.org>
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

Adding len argument to uprobe_write_opcode as preparation
fo writing longer instructions in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  3 ++-
 kernel/events/uprobes.c | 14 ++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 28068f9fcdc1..7d23a4fee6f4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -181,7 +181,8 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
+			       unsigned long vaddr, uprobe_opcode_t *insn, int len);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e9308649bba3..3e275717789b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -471,7 +471,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * Return 0 (success) or a negative errno.
  */
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+			unsigned long vaddr, uprobe_opcode_t *insn, int len)
 {
 	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
@@ -480,7 +480,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
 
-	is_register = is_swbp_insn(&opcode);
+	is_register = is_swbp_insn(insn);
 	uprobe = container_of(auprobe, struct uprobe, arch);
 
 retry:
@@ -491,7 +491,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify_opcode(old_page, vaddr, insn);
 	if (ret <= 0)
 		goto put_old;
 
@@ -525,7 +525,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	__SetPageUptodate(new_page);
 	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_to_page(new_page, vaddr, insn, len);
 
 	if (!is_register) {
 		struct page *orig_page;
@@ -582,7 +582,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
  */
 int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE);
 }
 
 /**
@@ -598,7 +600,7 @@ int __weak
 set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(auprobe, mm, vaddr,
-			*(uprobe_opcode_t *)&auprobe->insn);
+			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
 }
 
 /* uprobe should have guaranteed positive refcount */
-- 
2.47.0


