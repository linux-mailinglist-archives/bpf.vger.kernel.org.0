Return-Path: <bpf+bounces-36652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6E94B421
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2731F23854
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF64339AB;
	Thu,  8 Aug 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUnSYerA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC292EB02;
	Thu,  8 Aug 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076498; cv=none; b=d3qV28xdN5e1UeEO16Ey9ClV3bSTlMDx3SW4SLmyQSkGuRuhLYk/SOYugIgJ4tHuniCXCG6HHz2CGnPBnIWk0k0KSw6bS7N2oDxei5mTKDW2JTJs44mQy71D4p1qLkQV2bceL3a3I+xitkI/u+yRDotd9AgyrN1X/w5HpY6K2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076498; c=relaxed/simple;
	bh=RCnSWis6ptoXH653hNK1RkOV/09PEiUqkzNY8X6AUMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea2MgMUKyrpftQZQAUW4689peHZ+N0BePBL9i1d6yWSWZNt/wmtX9z0pYdZUI6/g7Eqlt6hmLAXuy6lXGrnll8rD19r8TB578LNMrnnDogjSyRSHL3+xJrla8fQnoIbfZCEJUr1pfeCHv+51KMdC8dfpWgJDVPj/e3UMgrnUcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUnSYerA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6E7C4AF0D;
	Thu,  8 Aug 2024 00:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723076497;
	bh=RCnSWis6ptoXH653hNK1RkOV/09PEiUqkzNY8X6AUMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUnSYerAS2CpU5dJ6/hB78tcazYT03ndgtGfxBUw9NSEBPax2otJdDzGuFI8Z+m0g
	 G2876+4X8/9KCF50QuCfHhOHmscGDtWB74of/KdSPygHWUB+QzbqTFrTp5Z46/MSm6
	 xFQnsoCLMMAXSPi2yOBjcZ4Wa9NZGDcOyB+kZf446Kl84QY2V7/H6bvmWu+5JkVlYN
	 DkA+3gUVKy+nJkm3Xlo0kOXhU9ZMHR7GLp3mM4QYIDmJ/8xA8Ued0x5VpuBZlSIswm
	 hpwqFpOFU131BxPS+q7x/NI15IIiGrqIhEspSAcy1QRSjK5v+MyHA6XobgjT9Ruyy/
	 eTgVenAfZCGEQ==
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
Subject: [PATCH v2 5/6] perf/uprobe: split uprobe_unregister()
Date: Wed,  7 Aug 2024 17:21:17 -0700
Message-ID: <20240808002118.918105-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808002118.918105-1-andrii@kernel.org>
References: <20240808002118.918105-1-andrii@kernel.org>
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
index f67f8d98c3c6..3a3154b74fe0 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -107,7 +107,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -156,7 +157,10 @@ uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
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
index 5bddd20b7053..419085741850 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1096,11 +1096,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
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
 
@@ -1118,7 +1118,11 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	}
 
 	put_uprobe(uprobe);
+}
+EXPORT_SYMBOL_GPL(uprobe_unregister_nosync);
 
+void uprobe_unregister_sync(void)
+{
 	/*
 	 * Now that handler_chain() and handle_uretprobe_chain() iterate over
 	 * uprobe->consumers list under RCU protection without holding
@@ -1130,7 +1134,7 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	 */
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /**
  * uprobe_register - register a probe
@@ -1188,7 +1192,13 @@ struct uprobe *uprobe_register(struct inode *inode,
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


