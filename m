Return-Path: <bpf+bounces-36994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E6994FCB3
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F341F21DF0
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE53CF63;
	Tue, 13 Aug 2024 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAoZgFKT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496F3B79C;
	Tue, 13 Aug 2024 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523397; cv=none; b=c1IeHLymn263Mud0RstBNY5dER52W/jKaHIlbF0CCixs2u+LCBm4ROgHsqMFfLL+aNBQm63R4YI8SvvuwPIM5dsQSRMn276jIxYVKaPpGhVp9WS/E+y24c7pWYeDmGSVtBfXYfhmGQockfcydILeJeATRRLfLLuT7fd7IhxzLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523397; c=relaxed/simple;
	bh=OvL70QsrDczQ8iqrV8LJBOmNylKoE4hwbFie5j0/JPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laPX1b1UheY/lY0xw9uDOrDbmEAH5N2vsgYRJ/CCoQVEmlKDf9fAts0qlxAl99bHW14uLsz1PY6LaSqdFwNoHQePO02/ZpGNYW2pLqjuZKzSY3MIR3r6FDCF/dsR4jDNAqD75ieb+zQA0t2T/ckt5Hl68qYA8i17m1pDQsItqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAoZgFKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5C7C4AF0E;
	Tue, 13 Aug 2024 04:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523396;
	bh=OvL70QsrDczQ8iqrV8LJBOmNylKoE4hwbFie5j0/JPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAoZgFKTFKJp/F2BB4J2mNKQlWMd/tPk5d1k6V28UkayC+B9VzjbEtAD7etxoMPox
	 KbZZ8pfGDdndUki76uP9d1Kumyi0kPPI6sR/mMdVZYktNRy+zZF2VF4FgLznIFMRDF
	 Wnc8+PRlNA7CWER/Q74/5uVayvtjMRD+3OsBCDbKWF0OmUwmbbCxQaVEn1ciPrBF0a
	 yiCvHr2Ob6iZoAIhxLuxutP9ciBwGSQhbNGS+RQr7bpqmB3oYXkxFk1emantskGrWr
	 tE2e4ayy7/6Y+TPrt6ChbeoQK4OEY08fTqQfq2h7dQ7/HpRo+auNBL31UQ1bu5IBxW
	 QkhqNdR7Z5qiA==
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
Subject: [PATCH v3 05/13] perf/uprobe: split uprobe_unregister()
Date: Mon, 12 Aug 2024 21:29:09 -0700
Message-ID: <20240813042917.506057-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
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
 include/linux/uprobes.h                       |  8 +++++--
 kernel/events/uprobes.c                       | 21 +++++++++++++------
 kernel/trace/bpf_trace.c                      |  5 ++++-
 kernel/trace/trace_uprobe.c                   |  6 +++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 ++-
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 29c935b0d504..e41cdae5597b 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -108,7 +108,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
-extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
+extern void uprobe_unregister_sync(void);
 extern int uprobe_mmap(struct vm_area_struct *vma);
 extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void uprobe_start_dup_mmap(void);
@@ -157,7 +158,10 @@ uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
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
index 7de1aaf50394..0b6d4c0a0088 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1094,11 +1094,11 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
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
 
@@ -1112,12 +1112,15 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
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
@@ -1129,7 +1132,7 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 	 */
 	synchronize_srcu(&uprobes_srcu);
 }
-EXPORT_SYMBOL_GPL(uprobe_unregister);
+EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
 /**
  * uprobe_register - register a probe
@@ -1187,7 +1190,13 @@ struct uprobe *uprobe_register(struct inode *inode,
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


