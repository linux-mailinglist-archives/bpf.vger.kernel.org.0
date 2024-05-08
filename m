Return-Path: <bpf+bounces-29126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140558C0643
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 23:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ABA2810BD
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61071327EB;
	Wed,  8 May 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjzVVlwa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C313248E;
	Wed,  8 May 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715203578; cv=none; b=KMSfhf0YQuNStjoQK2JLiSrVxWfeuYpHfJIvOWXTwYbf6hVNLMXufqSNmN3u56t/sk5HvylE5d5XDxKCi4+GLMZpruMgak9SrjnbvsGCxWtrmv5rYf4Dx5NRTkKsN0j95jZH0uC6cIz7wKVnTRh8MA3cYXBqHQq2elizfQlTZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715203578; c=relaxed/simple;
	bh=pRmppip20JV7W3kP/rLg2NLJC295oDyg0/sigGT7o9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOmBALKYGgnf4WqtWOOIXu1ko2VeiWYG9MtGdXdF6THsbBvWeRaqnM1MhbRVo0x3DEsBhor8En87YuXOJdA2Rh939niALtyxatDyCMxPOXPhyoK4YIMSPTbCSYjrUXUQn/EGA7FS7WlYEyD68Wh68aI09GqWYZCrAh40pggGFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjzVVlwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E1AC113CC;
	Wed,  8 May 2024 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715203577;
	bh=pRmppip20JV7W3kP/rLg2NLJC295oDyg0/sigGT7o9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjzVVlwaPSpEzfCSRZDP8dQ4ctyv5p56PJ3ad+qZkF619T7Iq7rU1aiqv+nfItbRR
	 djMyS9hvZEXcmV5mxggvSNFKWnhffRXUGQF2n/Kgdfub8jTRu8+ZsNe3cNJ1pTP5iq
	 7i9yVYMhRZ7Q99fD6/kOrtvj7ndj6WFJ53IsZHvyTmdnvVltKFtYT9OnoZCl0l1RE5
	 4KSW8ODG4mRnop8NR9SVD4Do7Z3zIVGbkrrDf3P3D8xDVCPPoMWx3VOJhhV3GBfx5K
	 VcHNcgudelNr62c6vRVisINadlJmwzneJ1axUNDD8GbxAn2fVYAkZuVB5wIZjfDVyF
	 KL52qiBCGcejQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Riham Selim <rihams@meta.com>
Subject: [PATCH 2/4] perf,uprobes: fix user stack traces in the presence of pending uretprobes
Date: Wed,  8 May 2024 14:26:03 -0700
Message-ID: <20240508212605.4012172-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508212605.4012172-1-andrii@kernel.org>
References: <20240508212605.4012172-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kernel has pending uretprobes installed, it hijacks original user
function return address on the stack with a uretprobe trampoline
address. There could be multiple such pending uretprobes (either on
different user functions or on the same recursive one) at any given
time within the same task.

This approach interferes with the user stack trace capture logic, which
would report suprising addresses (like 0x7fffffffe000) that correspond
to a special "[uprobes]" section that kernel installs in the target
process address space for uretprobe trampoline code, while logically it
should be an address somewhere within the calling function of another
traced user function.

This is easy to correct for, though. Uprobes subsystem keeps track of
pending uretprobes and records original return addresses. This patch is
using this to do a post-processing step and restore each trampoline
address entries with correct original return address. This is done only
if there are pending uretprobes for current task.

Reported-by: Riham Selim <rihams@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/callchain.c | 42 ++++++++++++++++++++++++++++++++++++++-
 kernel/events/uprobes.c   |  9 +++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..2f7ceca7ae3f 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -11,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uprobes.h>
 
 #include "internal.h"
 
@@ -176,13 +177,50 @@ put_callchain_entry(int rctx)
 	put_recursion_context(this_cpu_ptr(callchain_recursion), rctx);
 }
 
+static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
+					       int start_entry_idx)
+{
+#ifdef CONFIG_UPROBES
+	struct uprobe_task *utask = current->utask;
+	struct return_instance *ri;
+	__u64 *cur_ip, *last_ip, tramp_addr;
+
+	if (likely(!utask || !utask->return_instances))
+		return;
+
+	cur_ip = &entry->ip[start_entry_idx];
+	last_ip = &entry->ip[entry->nr - 1];
+	ri = utask->return_instances;
+	tramp_addr = uprobe_get_trampoline_vaddr();
+
+	/* If there are pending uretprobes for current thread, they are
+	 * recorded in a list inside utask->return_instances; each such
+	 * pending uretprobe replaces traced user function's return address on
+	 * the stack, so when stack trace is captured, instead of seeing
+	 * actual function's return address, we'll have one or many uretprobe
+	 * trampoline addresses in the stack trace, which are not helpful and
+	 * misleading to users.
+	 * So here we go over the pending list of uretprobes, and each
+	 * encountered trampoline address is replaced with actual return
+	 * address.
+	 */
+	while (ri && cur_ip <= last_ip) {
+		if (*cur_ip == tramp_addr) {
+			*cur_ip = ri->orig_ret_vaddr;
+			ri = ri->next;
+		}
+		cur_ip++;
+	}
+#endif
+}
+
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
-	int rctx;
+	int rctx, start_entry_idx;
 
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
@@ -215,7 +253,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
+			start_entry_idx = entry->nr;
 			perf_callchain_user(&ctx, regs);
+			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 		}
 	}
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d60d24f0f2f4..1c99380dc89d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2149,6 +2149,15 @@ static void handle_trampoline(struct pt_regs *regs)
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
+			/* pop current instance from the stack of pending return instances,
+			 * as it's not pending anymore: we just fixed up original
+			 * instruction pointer in regs and are about to call handlers;
+			 * this allows fixup_uretprobe_trampoline_entries() to properly fix up
+			 * captured stack traces from uretprobe handlers, in which pending
+			 * trampoline addresses on the stack are replaced with correct
+			 * original return addresses
+			 */
+			utask->return_instances = ri->next;
 			if (valid)
 				handle_uretprobe_chain(ri, regs);
 			ri = free_ret_instance(ri);
-- 
2.43.0


