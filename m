Return-Path: <bpf+bounces-44034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9C9BCDEB
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28B8B21258
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824331D63F3;
	Tue,  5 Nov 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3RQRXzg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042791D5168;
	Tue,  5 Nov 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813662; cv=none; b=PGlbV6Fe3BJpgVOoTgR+0X5iJV7pt8n3N62wcRfrfoTA4J9nqpQXBPapqGSHJTLbPAuw9pJK3ZqjoEtm7u2A7Fzs4aXmDUkXKa5RatpRZOW3ltfRO3UUtzV2ofzcQo7pz5VTZr9DaRXbUsA5cobWCtC8dP+cJoEglilmNq55fho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813662; c=relaxed/simple;
	bh=Aiw3eLbvPv7sUQ1IuNCFQdOCQyxDHTYPh/lNZWaD2h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdJqYp3hBG9nKhAaDhYGqwCWgmQjO+Ra+N+M7yZwKF5Kg4bhf43QkJ8wESbzoFJiS1b6txzmcCu0735v9x3umdU612GL5iK32xund/wPXXy9jf3TkvoaKcuQ6vs581OJqir3JsID0UoShppTpTqfRFryvt6piSNqZ0JseuJK6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3RQRXzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D892C4CED0;
	Tue,  5 Nov 2024 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813661;
	bh=Aiw3eLbvPv7sUQ1IuNCFQdOCQyxDHTYPh/lNZWaD2h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3RQRXzgbPqJGFt2yrImDi9W67YB7PbPop6CkLTenMPzy//DMrNyJui2v6SN5m8i3
	 GUN7Ol5RgKQDOjdbbb9CXsofVDpMHEQjSUSPhwpluiaR2puSvd0ivsoJnpi5IkBbyz
	 wciaIXFNA5SzNJ4pVKAgoYf+pVzztFL6dSsc9HDOzTiR9vYZEC4Z12NRN8FVs6IHGz
	 XZrLyyaTQ/hPiQEoOeoXeFn8s3Lf72RqOzP7qWdr8o+ohLJ5HwBFGROWdmfKHxeN+W
	 ggzulEEW4XNanmbu4uSZUsCK1o3ubZ/+7JP0oT10bT9Sj8zohmwTPfkdX8RP9IWsoW
	 bmWiIEfomu0DQ==
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
Subject: [RFC perf/core 01/11] uprobes: Rename arch_uretprobe_trampoline function
Date: Tue,  5 Nov 2024 14:33:55 +0100
Message-ID: <20241105133405.2703607-2-jolsa@kernel.org>
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

We are about to add uprobe trampoline, so cleaning up the namespace.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 include/linux/uprobes.h   | 2 +-
 kernel/events/uprobes.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..22a17c149a55 100644
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
index 7a051b5d2edd..2f500bc97263 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -211,7 +211,7 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
-extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a76ddc5fc982..0b04c051d712 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1696,7 +1696,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
@@ -1728,7 +1728,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns = arch_uprobe_trampoline(&insns_size);
+	insns = arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.47.0


