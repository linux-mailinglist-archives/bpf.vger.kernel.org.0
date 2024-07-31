Return-Path: <bpf+bounces-36180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F2594382E
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170C6B22019
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EBB16E86E;
	Wed, 31 Jul 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvzgkVl/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E316DED4;
	Wed, 31 Jul 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462200; cv=none; b=UdP+eazNk8wNod4Vj0uPAtEJZpN4O2+lQmUjLvnJsG4WOfgJZAB/HqFXmdyiwa4XhtaYX/0ZbslszRoozTFGxafDpzITCkhrBPX1k1FaXaahaFIOHqZ/XZ/5b3HESCRuOMDp8JH38qavhofzZOkIomEuV22r9pn0l9coOaZrE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462200; c=relaxed/simple;
	bh=OXneoaSHgN47v89buTd9dhC+vJ69+0jbyb3rqA0zcIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNhFEiX+ts7E4qjIqgcxXdNTQzD8T9APVPCxfa633mgYW1bYVp8Pzt5HnQssXbf63p/LhXC4Kg3eePmDN+kDX6FjFtC4J+eefNTi1mbWdqHTa6Dar24CKWMX8v3+0OOY+zg6Q5QJYx6/8HkgNFSRmFogCyPhJ+r6k+/DWa4Dcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvzgkVl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23354C32786;
	Wed, 31 Jul 2024 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462200;
	bh=OXneoaSHgN47v89buTd9dhC+vJ69+0jbyb3rqA0zcIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvzgkVl//LTT/5TxY0dEvZ//q3peJnpA4pASiNIXIYG3piXXU8w+tZXgNdM8WpOUm
	 iY4OLzNejlG0krZtkXx17aI0AwPwbwM4FHJOgJEhnhd103N6GLbil345buVWioFMzQ
	 WDZTRa9k1DU9VQNAcoj7QAjyLnPTkQY1U5rdVvxpiJi8Vs7oefh8INbNQ0G7SFpjop
	 LkYK8j1q40dgKm3TmszB2DSAR6R7QIaQi1oi6ZM5iuGwo+7t48f47PnC0v1vW926Cs
	 WETm5uKjDf3vpsFAAA+X2pO1NjdxdkljJXD7TKQE51QUXknXLY53Gsjhp0e1RUFv+a
	 jMbOt7Pv2RvdA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 6/8] perf/uprobe: split uprobe_unregister()
Date: Wed, 31 Jul 2024 14:42:54 -0700
Message-ID: <20240731214256.3588718-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731214256.3588718-1-andrii@kernel.org>
References: <20240731214256.3588718-1-andrii@kernel.org>
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

With recent uprobe_register()'s error handling reusing full
uprobe_unregister() call, we need to be careful about returning to the
caller before we have a guarantee that partially attached consumer won't
be called anymore. So add uprobe_unregister_sync() in the error handling
path. This is an unlikely slow path and this should be totally fine to
be slow in the case of an failed attach.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h                        |  8 ++++++--
 kernel/events/uprobes.c                        | 18 ++++++++++++++----
 kernel/trace/bpf_trace.c                       |  5 ++++-
 kernel/trace/trace_uprobe.c                    |  6 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c    |  3 ++-
 5 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a1686c1ebcb6..8f1999eb9d9f 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -105,7 +105,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -154,7 +155,10 @@ uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
 	return -ENOSYS;
 }
 static inline void
-uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
+uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc)
+{
+}
+static inline void uprobes_unregister_sync(void)
 {
 }
 static inline int uprobe_mmap(struct vm_area_struct *vma)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3b42fd355256..b0488d356399 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1089,11 +1089,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
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
 
@@ -1109,10 +1109,14 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		return;
 
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
+void uprobe_unregister_sync(void)
+{
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /**
  * uprobe_register - register a probe
@@ -1170,7 +1174,13 @@ struct uprobe *uprobe_register(struct inode *inode,
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
index 73a6b041bcce..928c73cde32e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -478,7 +478,8 @@ static void testmod_unregister_uprobe(void)
 	mutex_lock(&testmod_uprobe_mutex);
 
 	if (uprobe.uprobe) {
-		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_nosync(uprobe.uprobe, &uprobe.consumer);
+		uprobe_unregister_sync();
 		uprobe.offset = 0;
 		uprobe.uprobe = NULL;
 	}
-- 
2.43.0


