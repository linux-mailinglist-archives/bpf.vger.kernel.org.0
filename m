Return-Path: <bpf+bounces-46216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B2F9E6224
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7B61884D74
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636943173;
	Fri,  6 Dec 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlD20J+T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731733B2BB;
	Fri,  6 Dec 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444669; cv=none; b=p+6RNgqNh4JaPgu4gRwSVMC06nsv477GO6vUDtpw9MmEHIni1WZUW/KaqsS0kMsslZC7X69OtToTNWiMGqFmlG4hq3Gzd+ywVqO8Ad4P4ZjJ3FLT9vSWKqgKyR4gPaG5hQLMOqUfXGi7xWmKthnJu7mCxcePC1ZKwxhX8YDgxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444669; c=relaxed/simple;
	bh=YtvsT/xx7eUlWVejaYL+t9ImUgUncT5Ai5/DofAYzYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYKi5SMxL5vcMTsPbsUNvlkw4sjmqWkKnFZaxvhBhIn0xi+6QXNBoJ0354H1FH6KzyLO+9DIIXQzDDby9FQFcbpoItdI1LSvmhqp4hPHcBuKwBlOkrJWkzyez/ZttXJNIH+rfDGVW4KH1zwMutJnLajfq4sJAHtD0ASUaSKmPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlD20J+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75A4C4CED1;
	Fri,  6 Dec 2024 00:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733444669;
	bh=YtvsT/xx7eUlWVejaYL+t9ImUgUncT5Ai5/DofAYzYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlD20J+TmIyLZFFsG/tst8Jleq1xlIbJOBFm1H3++8sXvlRY4qSq2WjyS5zzK9iP/
	 fPPzf9QUwfrCp2pXSHaQeQO5o1LFZ2fDPuARDMfk0Kzap1402H4kfPtk2T2AIM6j3F
	 twV3RilFDrwn23ObXHLbqpNDT9iGIR2nFSqSVrvScoF1fzQtWYznMKVEAGwHRQ14xa
	 B/EFSyk3VcUI1YdQa9+WX28mWEeCrTlGKzcuCvGn6uFzoIBmhOq1B+ntLwHXgxM3nN
	 Kd+rMrriB8ec95sVxLb3hYA1yvg9Ypik2FjDO0/k9+o+Mr+WEPyIUAkQxM52G9sWCh
	 W3r14S7gNBaSA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	liaochang1@huawei.com,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH perf/core 2/4] uprobes: decouple return_instance list traversal and freeing
Date: Thu,  5 Dec 2024 16:24:15 -0800
Message-ID: <20241206002417.3295533-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206002417.3295533-1-andrii@kernel.org>
References: <20241206002417.3295533-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_ret_instance() has two unrelated responsibilities: actually
cleaning up return_instance's resources and freeing memory, and also
helping with utask->return_instances list traversal by returning the
next alive pointer.

There is no reason why these two aspects have to be mixed together, so
turn free_ret_instance() into void-returning function and make callers
do list traversal on their own.

We'll use this simplification in the next patch that will guarantee that
to-be-freed return_instance isn't reachable from utask->return_instances
list.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6beac52239be..cca1fe4a3fb1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1888,10 +1888,8 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static struct return_instance *free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
+static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
 {
-	struct return_instance *next = ri->next;
-
 	if (cleanup_hprobe) {
 		enum hprobe_state hstate;
 
@@ -1901,7 +1899,6 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 
 	kfree(ri->extra_consumers);
 	kfree_rcu(ri, rcu);
-	return next;
 }
 
 /*
@@ -1911,7 +1908,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri, boo
 void uprobe_free_utask(struct task_struct *t)
 {
 	struct uprobe_task *utask = t->utask;
-	struct return_instance *ri;
+	struct return_instance *ri, *ri_next;
 
 	if (!utask)
 		return;
@@ -1921,8 +1918,11 @@ void uprobe_free_utask(struct task_struct *t)
 	timer_delete_sync(&utask->ri_timer);
 
 	ri = utask->return_instances;
-	while (ri)
-		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
+	while (ri) {
+		ri_next = ri->next;
+		free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri = ri_next;
+	}
 
 	kfree(utask);
 	t->utask = NULL;
@@ -2111,12 +2111,15 @@ unsigned long uprobe_get_trampoline_vaddr(void)
 static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 					struct pt_regs *regs)
 {
-	struct return_instance *ri = utask->return_instances;
+	struct return_instance *ri = utask->return_instances, *ri_next;
 	enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
-		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri_next = ri->next;
 		utask->depth--;
+
+		free_ret_instance(ri, true /* cleanup_hprobe */);
+		ri = ri_next;
 	}
 	rcu_assign_pointer(utask->return_instances, ri);
 }
@@ -2508,7 +2511,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
-	struct return_instance *ri, *next;
+	struct return_instance *ri, *ri_next, *next_chain;
 	struct uprobe *uprobe;
 	enum hprobe_state hstate;
 	bool valid;
@@ -2528,8 +2531,8 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 		 * or NULL; the latter case means that nobody but ri->func
 		 * could hit this trampoline on return. TODO: sigaltstack().
 		 */
-		next = find_next_ret_chain(ri);
-		valid = !next || arch_uretprobe_is_alive(next, RP_CHECK_RET, regs);
+		next_chain = find_next_ret_chain(ri);
+		valid = !next_chain || arch_uretprobe_is_alive(next_chain, RP_CHECK_RET, regs);
 
 		instruction_pointer_set(regs, ri->orig_ret_vaddr);
 		do {
@@ -2541,7 +2544,9 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			 * trampoline addresses on the stack are replaced with correct
 			 * original return addresses
 			 */
-			rcu_assign_pointer(utask->return_instances, ri->next);
+			ri_next = ri->next;
+			rcu_assign_pointer(utask->return_instances, ri_next);
+			utask->depth--;
 
 			uprobe = hprobe_consume(&ri->hprobe, &hstate);
 			if (valid)
@@ -2549,9 +2554,9 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			hprobe_finalize(&ri->hprobe, hstate);
 
 			/* We already took care of hprobe, no need to waste more time on that. */
-			ri = free_ret_instance(ri, false /* !cleanup_hprobe */);
-			utask->depth--;
-		} while (ri != next);
+			free_ret_instance(ri, false /* !cleanup_hprobe */);
+			ri = ri_next;
+		} while (ri != next_chain);
 	} while (!valid);
 
 	return;
-- 
2.43.5


