Return-Path: <bpf+bounces-30255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892258CB889
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449412833F3
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308FA94F;
	Wed, 22 May 2024 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ0UPcnK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB579C4;
	Wed, 22 May 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341935; cv=none; b=ieDJaSuJ5hCCUJ26L0bU0EjQm/L5lQZW19Rs8gqirLisXX1KOTRsXYiUc7nIrbqca2nBov6nRLjF4z01QgAe9CCPOgTWzXL9YIyv23p+7OytSEhHeI41XSiKduWLh4UD7ODSeQ88snpXToHh0X4ZSoyeuK8N1TOCLBqZuXmDrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341935; c=relaxed/simple;
	bh=VrP1X4Gz4MX8XOFsrUPiW3NaGtzmRwltDxE5E1Rzj6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcT5VEUwBQ4DrzrXRg2Bl7jw5G3ZCDVJqpx4Aq1znNANmp7Owp9FIhcUJJZtrjQ+A4JjOTE7I52rZ1CJqVBuLowkvax6YUjOBfh9esm+BzNse9udO7CUjtzn0Tu9WZO6Qdw1fIKarthTzzO+hUgd3lQV/GADEsKA9XOI7FA6cFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ0UPcnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F1BC2BD11;
	Wed, 22 May 2024 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716341934;
	bh=VrP1X4Gz4MX8XOFsrUPiW3NaGtzmRwltDxE5E1Rzj6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQ0UPcnKifjz85E/M1a+NpC7LhZpHBqX8L6+vSwlTBge217zXkMPmkVVjcAVmOy6q
	 wTl6+V7MkIDMlMgMwnYSjHVj58iNg+DysNrUDopazwnajbuQaEoVCllQeDCbca/n2S
	 5o2K/LsaNk/MeyOHhdC2CdIR6RJ+k8MXgyLT8OE8cl/ky/OFNV9hSDq44YX6fzS77O
	 ZyE32SjLKWmQDAE8QT6oA+W6bDuWpx06BsQImafLIUpsU4fPiY5EPllDTby7E0zehc
	 CtvwTCZ6abuw4+hI3bU+jJTSnMOUlfv5l1AbHjAy5gPP6Cs4x2HIOYK+Xv7OSDoRoM
	 ohxc5y45RuBNw==
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
Subject: [PATCH v2 2/4] perf,uprobes: fix user stack traces in the presence of pending uretprobes
Date: Tue, 21 May 2024 18:38:43 -0700
Message-ID: <20240522013845.1631305-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522013845.1631305-1-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
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

This is a similar approach to what fprobe/kretprobe infrastructure is
doing when capturing kernel stack traces in the presence of pending
return probes.

Reported-by: Riham Selim <rihams@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/callchain.c | 43 ++++++++++++++++++++++++++++++++++++++-
 kernel/events/uprobes.c   |  9 ++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..b17e3323f7f6 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -11,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/sched/task_stack.h>
+#include <linux/uprobes.h>
 
 #include "internal.h"
 
@@ -176,13 +177,51 @@ put_callchain_entry(int rctx)
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
+	/*
+	 * If there are pending uretprobes for the current thread, they are
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
@@ -215,7 +254,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
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


