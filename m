Return-Path: <bpf+bounces-62661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB486AFCBDB
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA7C18989AA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FA2DEA6C;
	Tue,  8 Jul 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGafFHGK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7A2DCBF7;
	Tue,  8 Jul 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981051; cv=none; b=Ga/fp++esH60jv5g/oxkSopgjXh6SMkrg2/PMSrCyHPsKvLmoozCxr9eOztRXBiXA4flJ+D6bhZjMTYHif0EkM8/LG7UXe882hldWv/6VoQ+zonS8Q7yguD4exaAFD46q/CtjvdNLOxQqWa0n8UQfxOW88g1RFdp0tAU5u2mmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981051; c=relaxed/simple;
	bh=9lFlVOdytSTp+Mlnaj/abCNFlmJvW5VU8XlxoHegnqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLsMVQDlTP8KfCNZHK12LR7VmdNWmvVAHhsHqpmxCld8wlCjKcFVrY1TQKopo0yo7QGWe+/h8dOpEB1n3mnvO4Vj5ZjoqDBL6HsYqglwU6wUHnN1Dc4BLUdgCteByr5LYXW6jdH5ep0QglUAXdkRoBTUuYbeLdD2AHyZEjnoSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGafFHGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB6C4CEED;
	Tue,  8 Jul 2025 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981051;
	bh=9lFlVOdytSTp+Mlnaj/abCNFlmJvW5VU8XlxoHegnqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGafFHGKLnShijrG4GwB8Lvb0eufCcpRfXfk79AHYLx1a0iORNyu7DVXlW3+sF4D8
	 WYxP4L2+M6P3yuTQ2R1rXNZpBi6FyeuFL93GqQVIPsQE8ahEPoVBZmqDWIiPiz9O78
	 i3S/2xIj035iWOwyv0YA1OJfdiRHIjt8PCQzFfBC28Mrao0GoCJAN2zZaKGfP2vG6m
	 bsmXpF9DO0RIKIeQ6okdYscA3B/DjIF1HBmtdgag+pHzfHMO/95V3/uQ85iOHPDtoU
	 CHuBs2zgb1VNkbwHPyY7i2oxQvs+nvbeBbt+yMTRVwyHmO7xOxF810AkMGT+ikOlTo
	 3QwHYcrIivhJg==
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
Subject: [PATCHv4 perf/core 02/22] uprobes: Rename arch_uretprobe_trampoline function
Date: Tue,  8 Jul 2025 15:23:11 +0200
Message-ID: <20250708132333.2739553-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are about to add uprobe trampoline, so cleaning up the namespace.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
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
2.50.0


