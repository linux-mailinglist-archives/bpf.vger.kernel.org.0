Return-Path: <bpf+bounces-54442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F2A6A528
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560403B333C
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9421D3D2;
	Thu, 20 Mar 2025 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVu0xotQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350427701;
	Thu, 20 Mar 2025 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470939; cv=none; b=haCX9GgppLpN13t4k+doip9olXfpg2KIATMrg2+xJD1z4H7gvJvOKw0DfxHyLVasfGfzjErdQ80QX1/uUlQO8hqJe4pov3uT/u+c+iyc3C7da5R7Smn/yqNGFtOD0VSCye31k1YcG84cSc4XImQB3Ky7jBCzls8yuhL17oTrYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470939; c=relaxed/simple;
	bh=RxoV3d2ZBlj2MUC4NlJgYHMT8H52lee9nUCz0po1uiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwRiAq5zH5IluB1dBlWdbv92EW/IhfF5l+H37dV9iA88WnPRakDanpHadYBTVEJmosnS9r/Rmxlmm/mkCoiyyyLwCRxU+v9nhZtBzaSLaMAfcImz60M+LBCbQkhfe1oSZtfQZhTvoFee8ii9HgvZTIHr2hrcrfBDMLnqE/lXXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVu0xotQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24C0C4CEDD;
	Thu, 20 Mar 2025 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742470937;
	bh=RxoV3d2ZBlj2MUC4NlJgYHMT8H52lee9nUCz0po1uiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVu0xotQZ1dUliACcuActJCcXcQ6F4him8d8ylgpswC6JWXJ1YarsElrl/JTnyH4k
	 H4GOjCiP09tZhkDw36MZ/uPU/YODOutS7KiRjg8dS/f5X1hjJ/j9DuuShMlpkiYutg
	 hIHg9Qot+l1xwPNAxAWaTtSz2X4Nt5iLcbqymHaigLiWbTVKeACJd2RJoPr20c9/zV
	 otD21Ry/4hNG+acHMUTbA1Z3JWg/0YCDy1gPuPMMTCdM6EEpFGpivRUcuIfh70ymMu
	 Z8iNnp+oGQUdAbXri51OMub5bVKLOnMsxsNkDvCl55kDyQy5/IyABGVAve0DE1eR+1
	 3cwQzLDMEB5SA==
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
Subject: [PATCH RFCv3 01/23] uprobes: Rename arch_uretprobe_trampoline function
Date: Thu, 20 Mar 2025 12:41:36 +0100
Message-ID: <20250320114200.14377-2-jolsa@kernel.org>
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

We are about to add uprobe trampoline, so cleaning up the namespace.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 include/linux/uprobes.h   | 2 +-
 kernel/events/uprobes.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..39521f1c4185 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -338,7 +338,7 @@ extern u8 uretprobe_trampoline_entry[];
 extern u8 uretprobe_trampoline_end[];
 extern u8 uretprobe_syscall_check[];
 
-void *arch_uprobe_trampoline(unsigned long *psize)
+void *arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 	struct pt_regs *regs = task_pt_regs(current);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2e46b69ff0a6..37cd745640b8 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -224,7 +224,7 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
-extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 70c84b9d7be3..e160445e7d07 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1708,7 +1708,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
@@ -1740,7 +1740,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns = arch_uprobe_trampoline(&insns_size);
+	insns = arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.49.0


