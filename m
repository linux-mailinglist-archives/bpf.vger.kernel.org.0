Return-Path: <bpf+bounces-38807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14A96A5C2
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A978BB21CBB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFFE190471;
	Tue,  3 Sep 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhx6yfQQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A11946B4;
	Tue,  3 Sep 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385584; cv=none; b=k1rCYdqHAFMsFjebVVsw2kEC4SIQz8wfP2PHcn/viwgY5aI07tq0/hUBCF35U/bOuqchqs8HocWZGsVy92rWuyEKKu0TAhAZJiMmr0e5vj6oFf9ewvTK5ZIbk5JXGfF2zE4rVrkNSzpZpojoCuadeag0earnL+9EGRxUapckqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385584; c=relaxed/simple;
	bh=+g5blMcMvR/SzeXxNsO+2FR1B0Xb/4hXSLWFzum/rNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQCT6tV1Af3GwhSLUpLCxGwQKcZMjW5QKiR682fH2Cpv5q/w+1BpTS9GHmXH5jutmGrxwe/biTtF1158oGXoAf4082Zqc6ZxlDrDVydBHpM3cucnmHmyDg4aLji1MUxkHehCP/6hnncbkx8UTEjtDgvq8/ajAAyil4tZKUgTUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhx6yfQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3520AC4CEC4;
	Tue,  3 Sep 2024 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385584;
	bh=+g5blMcMvR/SzeXxNsO+2FR1B0Xb/4hXSLWFzum/rNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qhx6yfQQFzXxpHP3LO+Fd1jKiUa4JhPuiOsfHedhqXJjYdmYOMAFnnX0y0a3/BRq/
	 zau5ZeAS43Xbm3KxfmouEia1A2VI7ZAacfnXnGy2G/qSuGT3ISARwoujzhXSfze6iN
	 Ob9hpzh5HONT6NCQ3pjUef3Y8joaErhmOh4R3/xZleSPb44UYga9B6QwejU9EmNibZ
	 whpmKRFcgTiO5x5NK49n22lMdZOz/WzO+14nZyR5/uWmmvH4GI2kLb9mfR2Dcxa8/a
	 ePAX0kEJML3yYA+dDB8kYj65pehwax5J3lyQXqe7o0/VZOTFnL1D3bm0T6IB+AEd9g
	 h3SuCX8DXCvvA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v5 5/8] perf/uprobe: split uprobe_unregister()
Date: Tue,  3 Sep 2024 10:46:00 -0700
Message-ID: <20240903174603.3554182-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903174603.3554182-1-andrii@kernel.org>
References: <20240903174603.3554182-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

With uprobe_unregister() having grown a synchronize_srcu(), it becomes
fairly slow to call. Esp. since both users of this API call it in a
loop.

Peel off the sync_srcu() and do it once, after the loop.

We also need to add uprobe_unregister_sync() into uprobe_register()'s
error handling path, as we need to be careful about returning to the
caller before we have a guarantee that partially attached consumer won't
be called anymore. This is an unlikely slow path and this should be
totally fine to be slow in the case of a failed attach.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h                       |  8 +++++--
 kernel/events/uprobes.c                       | 21 +++++++++++++------
 kernel/trace/bpf_trace.c                      |  5 ++++-
 kernel/trace/trace_uprobe.c                   |  6 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 ++-
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2785d1bedb74..968230d81798 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -116,7 +116,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -165,7 +166,10 @@ uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+}
+static inline void uprobe_unregister_sync(void)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 97e58d160647..e9b755ddf960 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1105,11 +1105,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 }
 
 /**
- * uprobe_unregister - unregister an already registered probe.
+ * uprobe_unregister_nosync - unregister an already registered probe.
  * @uprobe: uprobe to remove
  * @uc: identify which probe if multiple probes are colocated.
  */
-void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
@@ -1121,12 +1121,15 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	/* TODO : cant unregister? schedule a worker thread */
 	if (unlikely(err)) {
 		uprobe_warn(current, "unregister, leaking uprobe");
-		goto out_sync;
+		return;
 	}
 
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
-out_sync:
+void uprobe_unregister_sync(void)
+{
 	/*
 	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
 	 * uprobe->consumers list under RCU protection without holding
@@ -1138,7 +1141,7 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	 */
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /**
  * uprobe_register - register a probe
@@ -1196,7 +1199,13 @@ struct uprobe *uprobe_register(struct inode *inode,
 	up_write(&uprobe->register_rwsem);
 
 	if (ret) {
-		uprobe_unregister(uprobe, uc);
+		uprobe_unregister_nosync(uprobe, uc);
+		/*
+		 * Registration might have partially succeeded, so we can have
+		 * this consumer being called right at this time. We need to
+		 * sync here. It's ok, it's unlikely slow path.
+		 */
+		uprobe_unregister_sync();
 		return ERR_PTR(ret);
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 73c570b5988b..6b632710c98e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3184,7 +3184,10 @@ static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
 	u32 i;
 
 	for (i = 0; i < cnt; i++)
-		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
+		uprobe_unregister_nosync(uprobes[i].uprobe, &uprobes[i].consumer);
+
+	if (cnt)
+		uprobe_unregister_sync();
 }
 
 static void bpf_uprobe_multi_link_release(struct bpf_link *link)
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 7eb79e0a5352..f7443e996b1b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1097,6 +1097,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
+	bool sync = false;
 
 	tu = container_of(tp, struct trace_uprobe, tp);
 	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
@@ -1105,9 +1106,12 @@ static void __probe_event_disable(struct trace_probe *tp)
 		if (!tu->uprobe)
 			continue;
 
-		uprobe_unregister(tu->uprobe, &tu->consumer);
+		uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
+		sync = true;
 		tu->uprobe = NULL;
 	}
+	if (sync)
+		uprobe_unregister_sync();
 }
 
 static int probe_event_enable(struct trace_event_call *call,
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 3c0515a27842..1fc16657cf42 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -475,7 +475,8 @@ static void testmod_unregister_uprobe(void)
 	mutex_lock(&testmod_uprobe_mutex);
 
 	if (uprobe.uprobe) {
-		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_sync();
 		path_put(&uprobe.path);
 		uprobe.uprobe = NULL;
 	}
-- 
2.43.5


