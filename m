Return-Path: <bpf+bounces-69042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05CB8BBAE
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0093A1C21E17
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879852459CF;
	Sat, 20 Sep 2025 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHBIk/ta"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4E241CB7;
	Sat, 20 Sep 2025 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329983; cv=none; b=E8fTuRbS3qyY0LEOf6ed/bsEp8vJicRLRapbjsWnjVIj7EKAeFKZ4DGy6hz3zlrcMrDmGPzRIfNGX6tA5m6zdTSU3bxtBUilLpDAgu57mqF7y+VJq+ogKn98TFNQTbNnNFHBH42ZYKl0baXDqqmY0MLekri0SI4mOQ5hqRyRbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329983; c=relaxed/simple;
	bh=jS8B27EZgJNAB+RxeI7M5SPmwNU6LGe4HCSeTNE5PIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJrSDmTjknQf3hjSbNafItdJ3mfy8qquOCf6WTAZLpoNDciLihtnQFUKFInOLiBxpl93AcDAmfbFBE3K3TGMyrAG6LQqAWGTdhY7fIr5CfAUJARuZtp/Uz7o1MDBouBZ+lM/fqCFOt8SSAJcM3MgxNZ8qJtS0GX43FYhGJzGw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHBIk/ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C192C4CEF0;
	Sat, 20 Sep 2025 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329982;
	bh=jS8B27EZgJNAB+RxeI7M5SPmwNU6LGe4HCSeTNE5PIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHBIk/taeouVRZX8hJcDrN5/2fRyMVdtcEwDBMcmY0avYfxaa0STEJg+n/lSdCGFN
	 UmZae2NyGH6stZiv0Egsv8NRTxy8J1koS1ohLfBPINgmAqcOi3NnzfJkpOOhWTRIEf
	 Y5XkWDUxnF9N6Ocsm4tt7t7q6D9LhxSodBhga3tH6MmW1l4wpQ0O/bNAjRGKdfS3/i
	 meOb+XuRnQG3pVYFwg8q3pp8tXBWr1Ig4aIJ16RsKyYxjnyNOpz+LEfofVidAl3RLL
	 g4OG6tBYs7ma0NG4nQq+FmiogR8RC0+U1wj+Qm9P4BIcLB1+vy1xHuEY0yCn3MQyXq
	 QDEHQy6wvyQKw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/46] sched_ext: Separate out scx_kick_cpu() and add @sch to it
Date: Fri, 19 Sep 2025 14:58:31 -1000
Message-ID: <20250920005931.2753828-9-tj@kernel.org>
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

In preparation for multiple scheduler support, separate out scx_kick_cpu()
from scx_bpf_kick_cpu() and add the @sch parameter to it. scx_bpf_kick_cpu()
now acquires an RCU read lock, reads $scx_root, and calls scx_kick_cpu()
with it if non-NULL. The passed in @sch parameter is not used yet.

Internal uses of scx_bpf_kick_cpu() are converted to scx_kick_cpu(). Where
$sch is available, it's used. In the pick_task_scx() path where no
associated scheduler can be identified, $scx_root is used directly. Note
that $scx_root cannot be NULL in this case.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d131e98156ac..560ac5a575bd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -136,7 +136,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
-static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
+static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
 
@@ -2125,10 +2125,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * balance(), we want to complete this scheduling cycle and then
 		 * start a new one. IOW, we want to call resched_curr() on the
 		 * next, most likely idle, task, not the current one. Use
-		 * scx_bpf_kick_cpu() for deferred kicking.
+		 * scx_kick_cpu() for deferred kicking.
 		 */
 		if (unlikely(!--nr_loops)) {
-			scx_bpf_kick_cpu(cpu_of(rq), 0);
+			scx_kick_cpu(sch, cpu_of(rq), 0);
 			break;
 		}
 	} while (dspc->nr_tasks);
@@ -2417,7 +2417,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		p = first_local_task(rq);
 		if (!p) {
 			if (kick_idle)
-				scx_bpf_kick_cpu(cpu_of(rq), SCX_KICK_IDLE);
+				scx_kick_cpu(rcu_dereference_sched(scx_root),
+					     cpu_of(rq), SCX_KICK_IDLE);
 			return NULL;
 		}
 
@@ -3721,7 +3722,7 @@ static void scx_clear_softlockup(void)
  *
  * - pick_next_task() suppresses zero slice warning.
  *
- * - scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during PM
+ * - scx_kick_cpu() is disabled to avoid irq_work malfunction during PM
  *   operations.
  *
  * - scx_prio_less() reverts to the default core_sched_at order.
@@ -5809,17 +5810,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
 
 __bpf_kfunc_start_defs();
 
-/**
- * scx_bpf_kick_cpu - Trigger reschedule on a CPU
- * @cpu: cpu to kick
- * @flags: %SCX_KICK_* flags
- *
- * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
- * trigger rescheduling on a busy CPU. This can be called from any online
- * scx_ops operation and the actual kicking is performed asynchronously through
- * an irq work.
- */
-__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct rq *this_rq;
 	unsigned long irq_flags;
@@ -5872,6 +5863,26 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	local_irq_restore(irq_flags);
 }
 
+/**
+ * scx_bpf_kick_cpu - Trigger reschedule on a CPU
+ * @cpu: cpu to kick
+ * @flags: %SCX_KICK_* flags
+ *
+ * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
+ * trigger rescheduling on a busy CPU. This can be called from any online
+ * scx_ops operation and the actual kicking is performed asynchronously through
+ * an irq work.
+ */
+__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_kick_cpu(sch, cpu, flags);
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
-- 
2.51.0


