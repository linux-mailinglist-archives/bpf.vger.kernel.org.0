Return-Path: <bpf+bounces-58289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E9AB860B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2BD1BC4500
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6035329B76D;
	Thu, 15 May 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIILs/bu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8413298271;
	Thu, 15 May 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311118; cv=none; b=iWuIepc9A6C0tyrElgJ/P2ge80uUnVVoBbhqu7HAgGg7dxTfP/hgYoh/v3ZZWorSJ65ke9LTm38sfPjJpZaPV/Af+H1JFCC8ZmJYtLfhUELHQ8MrUcm7CMbDqq0QF/buEU8QxescLP3AZFnG0nzPYk0WDbvxd9Ek93kaRvDieH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311118; c=relaxed/simple;
	bh=6IMDV/tvwa5R7fB0so0rGO1C5QSPfv7/cy1P2MbQwTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZnis+9kfHFwgTi+OGaneTNwzGd5GjyR9BtUHwNNJkK78cEXH1r6zuXfziR0PpQOxHQ5WO8zYcVqiPL75hBD8/cDDojaprsseTXq9BiTJXIYXBtjyi0xUJ/pK7IOCKfQlpWNVbmVSth6V+6/fFE9MMnv5BNr6YcWbKsyb1nkpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIILs/bu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D15FC4CEE7;
	Thu, 15 May 2025 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311118;
	bh=6IMDV/tvwa5R7fB0so0rGO1C5QSPfv7/cy1P2MbQwTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIILs/bubB0JeZ+9tWQzR7sZz7MBm1+kYSM7PojljQoGKwiMecPfjB/zeUOsCFqd1
	 /e/YApz7nWLXnzoGg6fKKXL5s0FryhhebxHPz67alemS6ZWQpajlRkGuUhNWXt6Vg4
	 v9Co+XZazA9Pvq/9wbOxCDzSESCi610lpC43YXvwraVBb1Ua+v8LCWm8OPx3PmjhNB
	 5n/KrJUkGY7346QG8L11hvuetJ1E/NDvMtLYgYB4cceWQsOPph4Jy++xzUKCn3gLPQ
	 YdDTNuxAfJgzTKw3DClZty4B3EANJnFsEPXHnrNLA/IlmBeu9Xdr2tJs/EIAvJDOXT
	 yYZK2SD912Cfw==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv2 perf/core 02/22] uprobes: Rename arch_uretprobe_trampoline function
Date: Thu, 15 May 2025 14:10:59 +0200
Message-ID: <20250515121121.2332905-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
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
index 6d383839e839..77050e5a4680 100644
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
index 516217c39094..01112f27cd21 100644
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
index 257581432cd8..4e8e607abda8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1727,7 +1727,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
@@ -1759,7 +1759,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns = arch_uprobe_trampoline(&insns_size);
+	insns = arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.49.0


