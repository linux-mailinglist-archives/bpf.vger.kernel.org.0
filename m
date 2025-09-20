Return-Path: <bpf+bounces-69073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688EB8BC6C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919F81C01061
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BA51F3BBB;
	Sat, 20 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFziMckI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35B2E3B16;
	Sat, 20 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330016; cv=none; b=QBrJ7kwNBcxC63BCUz7cV8CFx2Vmf9Fu1WF+twfsd5o9CBGl8xyu/xKMYp8r0ydi+ooqrbvFzJZrsc7eWC4bbNHHu4izsnwb5NleYV2z7b46L+MQv3pCsJZCYXmxBtambzukdda8oMIBAqfkCZ84y90fBcII8FCddxPrtqbTX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330016; c=relaxed/simple;
	bh=IHujVRW/s5LLsGTI5u/4vhmSvu7RvgIEI8PbbZb/3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sylacMCX+6h8JVIEjk9HRRG4ANZxljfv/gHk2Q4nGFEMsmxbGGiDC8ekcQeYuV0iYI+8db1fuD2/14OCXEOJVmOtwr9fxlgyb7ygGHJT4iClIWRtmEQKaAa124G/gnCRDpz3wIdiiDcqeh91pI+KIlAPBP7YjVgHpa4l/JgJscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFziMckI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E895DC4CEF0;
	Sat, 20 Sep 2025 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330016;
	bh=IHujVRW/s5LLsGTI5u/4vhmSvu7RvgIEI8PbbZb/3b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFziMckI9nlWYZkZ5pQ3W8c6Z4WygVzkDV1bwobQp1tIJIs7lW7JhOy+lN455jwb5
	 T+/8tO8judnv36iWLHOSzmxLL0F7j716DtQ3EXi+wasHWa5KmTWOPMB1Da+FcVdz+C
	 oso86yTa8bg2Hqh7y7Y8CFTdKZuV73XSCJYhtjrxpaN/VGHbC7dIDMBC43SNawRYPe
	 VY+GgzBS98ZIBEo6TpQZv5rdRySps+eEk71pOPId8vZioxPR+mnJMDLilf8xWaVY2J
	 bRSkpoH95z0rBm0vExYO1gG0MFmJ400RkbSMjC6MV7Kcl1Rqqwx1wgCgSE1P41bExF
	 T/hdth1Pf+wYw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 39/46] sched_ext: Support dumping multiple schedulers and add scheduler identification
Date: Fri, 19 Sep 2025 14:59:02 -1000
Message-ID: <20250920005931.2753828-40-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend scx_dump_state() to support multiple schedulers and improve task
identification in dumps. The function now takes a specific scheduler to
dump and can optionally filter tasks by scheduler.

scx_dump_task() now displays which scheduler each task belongs to, using
"*" to mark tasks owned by the scheduler being dumped. Sub-schedulers
are identified with their level and cgroup ID.

The SysRq-D handler now iterates through all active schedulers under
scx_sched_lock and dumps each one separately. For SysRq-D dumps, only
tasks owned by each scheduler are dumped to avoid redundancy since all
schedulers are being dumped. Error-triggered dumps continue to dump all
tasks since only that specific scheduler is being dumped.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 54 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fafffe3ee812..1a48510e6f98 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4520,22 +4520,34 @@ static void ops_dump_exit(void)
 	scx_dump_data.cpu = -1;
 }
 
-static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
+static void scx_dump_task(struct scx_sched *sch,
+			  struct seq_buf *s, struct scx_dump_ctx *dctx,
 			  struct task_struct *p, char marker)
 {
 	static unsigned long bt[SCX_EXIT_BT_LEN];
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *task_sch = scx_task_sched(p);
+	const char *own_marker;
+	char sch_id_buf[32];
 	char dsq_id_buf[19] = "(n/a)";
 	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
 	unsigned int bt_len = 0;
 
+	own_marker = task_sch == sch ? "*" : "";
+
+	if (task_sch->level == 0)
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "root");
+	else
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "sub%d-%llu",
+			  task_sch->level, task_sch->ops.sub_cgroup_id);
+
 	if (p->scx.dsq)
 		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
 			  (unsigned long long)p->scx.dsq->id);
 
 	dump_newline(s);
-	dump_line(s, " %c%c %s[%d] %+ldms",
+	dump_line(s, " %c%c %s[%d] %s%s %+ldms",
 		  marker, task_state_to_char(p), p->comm, p->pid,
+		  own_marker, sch_id_buf,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
@@ -4563,11 +4575,18 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 	}
 }
 
-static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
+/*
+ * Dump scheduler state. If @dump_all_tasks is true, dump all tasks regardless
+ * of which scheduler they belong to. If false, only dump tasks owned by @sch.
+ * For SysRq-D dumps, @dump_all_tasks=false since all schedulers are dumped
+ * separately. For error dumps, @dump_all_tasks=true since only the failing
+ * scheduler is dumped.
+ */
+static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
+			   size_t dump_len, bool dump_all_tasks)
 {
 	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
-	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
 		.kind = ei->kind,
 		.exit_code = ei->exit_code,
@@ -4584,6 +4603,14 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (sch->level == 0)
+		dump_line(&s, "%s: root", sch->ops.name);
+	else
+		dump_line(&s, "%s: sub%d-%llu %s",
+			  sch->ops.name, sch->level, sch->ops.sub_cgroup_id,
+			  sch->cgrp_path);
+#endif
 	if (ei->kind == SCX_EXIT_NONE) {
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
@@ -4676,11 +4703,13 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 				seq_buf_set_overflow(&s);
 		}
 
-		if (rq->curr->sched_class == &ext_sched_class)
-			scx_dump_task(&s, &dctx, rq->curr, '*');
+		if (rq->curr->sched_class == &ext_sched_class &&
+		    (dump_all_tasks || scx_task_sched(rq->curr) == sch))
+			scx_dump_task(sch, &s, &dctx, rq->curr, '*');
 
 		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
-			scx_dump_task(&s, &dctx, p, ' ');
+			if (dump_all_tasks || scx_task_sched(p) == sch)
+				scx_dump_task(sch, &s, &dctx, p, ' ');
 	next:
 		rq_unlock(rq, &rf);
 	}
@@ -4712,7 +4741,7 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (ei->kind >= SCX_EXIT_ERROR)
-		scx_dump_state(ei, sch->ops.exit_dump_len);
+		scx_dump_state(sch, ei, sch->ops.exit_dump_len, true);
 
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
@@ -5662,9 +5691,12 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void sysrq_handle_sched_ext_dump(u8 key)
 {
 	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
+	struct scx_sched *sch;
 
-	if (scx_enabled())
-		scx_dump_state(&ei, 0);
+	guard(raw_spinlock_irqsave)(&scx_sched_lock);
+
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		scx_dump_state(sch, &ei, 0, false);
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_dump_op = {
-- 
2.51.0


