Return-Path: <bpf+bounces-46626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2E9ECD46
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48F22811F9
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355F2336B7;
	Wed, 11 Dec 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWd7yEfV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396223FD1E;
	Wed, 11 Dec 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924061; cv=none; b=AKPf1P6gkk8HdujHPz0l3CbLU7pJAIZ0JtzGpiJv3YfAbjxgu/L7p9dhOwygeTh8g3IztON5SqAJxsfdsG8Pv87WV/IEwAzloZZdUV5b8RR04zapjrNoTdeVIyyfmVV6GyPFDWmBkfVFxhqMru8p5SjvEtOJvi4+xoQzC7kjIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924061; c=relaxed/simple;
	bh=Z7IK1SBqeAl5DybsxkEFcQSaPfCG+Bu6/uH1+f3Yn5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+LHo3IoG0kyZNdSqITopwzOmVkxYOx4N6UGkWo4rnwQospZYu7MKaG57zmYoBpF/D5dPSZT+mdk732JKBJKBQHSi30hB2Pt5zF+dVqihK4iKJqskDT+12sOV+3cWNTJ5q9wr46PDpU1TUTZUBJIi7JIurTnSaXVD019GYovBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWd7yEfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CCC4CED2;
	Wed, 11 Dec 2024 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924060;
	bh=Z7IK1SBqeAl5DybsxkEFcQSaPfCG+Bu6/uH1+f3Yn5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWd7yEfVgO54c8ga+ehSoBNk5mZe1KzZ4jRcRou0UuTHfdK8eap9TWXL0hppYq0BC
	 XS/v/UqiOt+nDTXoxG17NnhVoTQno9NQGPJ5RrHvAwmshr3ePLt/WOYfhzt63wNAEc
	 MZnetHnLk5zTYWT2/ffY3vaz+l1k1CkBEKX+8K3jMETfQYQ7FAwfDRMNubR0UlaBsM
	 R7BmyTvr7JCcUBvY4e6o3vJ9bpR/V0XlcFgTFhAgYmCApiXP7fBsidi5XA1K0ounUv
	 FFkz4gpMQpKkEmb6XwBcEiZIKhLz3AJSuhpY8ZL71UyQoqjr5Yeb/eHZfueBxPf7A8
	 SyklJ+hNN37Bw==
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
Subject: [PATCH bpf-next 01/13] uprobes: Rename arch_uretprobe_trampoline function
Date: Wed, 11 Dec 2024 14:33:50 +0100
Message-ID: <20241211133403.208920-2-jolsa@kernel.org>
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
index e0a4c2082245..09a298e416a8 100644
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
index fa04b14a7d72..e0e3ebb4c0a1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1695,7 +1695,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
-void * __weak arch_uprobe_trampoline(unsigned long *psize)
+void * __weak arch_uretprobe_trampoline(unsigned long *psize)
 {
 	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 
@@ -1727,7 +1727,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	init_waitqueue_head(&area->wq);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
-	insns = arch_uprobe_trampoline(&insns_size);
+	insns = arch_uretprobe_trampoline(&insns_size);
 	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
-- 
2.47.0


