Return-Path: <bpf+bounces-61553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB041AE8B33
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619513B8CE3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72A273D74;
	Wed, 25 Jun 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfwNyA86"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F8262FC2;
	Wed, 25 Jun 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871170; cv=none; b=hWOOcKryiKeFb5r75x1cedXta2TQRMtdtXJKbZYihNVIZbx7Y5TD9V6zhOrmTswQJUIol6prtj0+SVq7sf2nec88UPUmIs4GZbaC9UAx8N19Iz/88C6WD+/5pxQcQrLQAQH/qN6R8AQ7OIs2QGslYtBDe4bI6tBDBYoZZws6qdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871170; c=relaxed/simple;
	bh=50VoEmYFQSaIUCRCbBSaRek4Ygn1fa8ozNyydDU/+Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PvDLX3wMcqSI9D1Z7Y5Kry/XhHPj1oAMQJGADKcQc36f8naG5qckIE2U+eU3oh3pdH36K6lzNl/4IKsDp20Q7kQqrvpRbC4QcRgGgm//5PBTrul3MRDQIWQfi+1x/alMKZHnwvwUntYMpIVJ6+klTD54up+jBmhTk/mC8cgImfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfwNyA86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8662EC4CEEA;
	Wed, 25 Jun 2025 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750871169;
	bh=50VoEmYFQSaIUCRCbBSaRek4Ygn1fa8ozNyydDU/+Lg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AfwNyA861PgKcrxOGaX33RQZUrCQ2qflq+X2dV/pAj7Fe0E3T/NzS1zcpVam36wjk
	 UDQL03tu9hbUCtZzjeoDvwVaoePmFa2TzG5zh6m+HfGwxmNCQ1mLiNc2oUOF0X4yWJ
	 xmD7iUQ2QyuJWjbXTJT5E1XsFPZlOEa2SFkC9hmfP6AJ6KmLpZisSpEYoTeLRerGFe
	 RK+VUK1FCt6Waa+Oqcg3EpyrWBjyRq7uA3lnIr7GZ5pP83wrQPtqdagtc8rPHsiPAB
	 7FeOQTDgyYYU5cCeWeUtnjssUNWKqcGkdPAg5U0XBuz2nNvd9nRzE1oFYrsJ7uKzn8
	 FbjEWBSM6Pogg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76853C77B7C;
	Wed, 25 Jun 2025 17:06:09 +0000 (UTC)
From: Jake Hillion via B4 Relay <devnull+jake.hillion.co.uk@kernel.org>
Date: Wed, 25 Jun 2025 18:05:46 +0100
Subject: [PATCH] sched_ext: Drop kfuncs marked for removal in 6.15
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-scx-kfunc-cleanup-v1-1-d93335286fd5@hillion.co.uk>
X-B4-Tracking: v=1; b=H4sIAGksXGgC/x3MQQqAIBBA0avErBtQSYmuEi1qGmsoTJQiiO6et
 HyL/x/InIQzdNUDiS/JcoQCXVdA6xgWRpmLwShjlTMWM924+TMQ0s5jOCO2RpOblG0ap6F0MbG
 X+3/2w/t+RlgswGMAAAA=
X-Change-ID: 20250625-scx-kfunc-cleanup-821c6b054461
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Jake Hillion <jake@hillion.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750871166; l=8916;
 i=jake@hillion.co.uk; s=20250530; h=from:subject:message-id;
 bh=aEhsz6x954cD1n/ZnKGKsFXTVr50Ueip0D4LRoGkidQ=;
 b=7ui4rXpCg6L0Wq2AA2bSocvv9al7b6Na2ABr4HpzvrV1ds2EUAm6eL2RVZs6HsBhdnCBC9QB7
 qmhFX91uX9rCk6SwrL5XM8XWsCf+WcUmk+Yc6op5ltokFV+nI8rLCJi
X-Developer-Key: i=jake@hillion.co.uk; a=ed25519;
 pk=8cznmqtMcMEcU8QH55k8DrySboD889OBB/BEUMJh3dw=
X-Endpoint-Received: by B4 Relay for jake@hillion.co.uk/20250530 with
 auth_id=419
X-Original-From: Jake Hillion <jake@hillion.co.uk>
Reply-To: jake@hillion.co.uk

From: Jake Hillion <jake@hillion.co.uk>

sched_ext performed a kfunc renaming pass in 6.13 and kept the old names
around for compatibility with old binaries. These were scheduled for
cleanup in 6.15 but were missed. Submitting for cleanup in for-next.

Removed the kfuncs, their flags, and any references I could find to them
in doc comments. Left the entries in include/scx/compat.bpf.h as they're
still useful to make new binaries compatible with old kernels.

Tested by applying to my kernel. It builds and a modern version of
scx_lavd loads fine.

Signed-off-by: Jake Hillion <jake@hillion.co.uk>
---
 include/linux/sched/ext.h | 10 +++----
 kernel/sched/ext.c        | 71 ++---------------------------------------------
 2 files changed, 7 insertions(+), 74 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index f7545430a54821193bcfecd0a1a21c326cc438b1..f0263f2578aeda4a42035ab58c9fd3a572e36ebd 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -164,7 +164,7 @@ struct sched_ext_entity {
 
 	/*
 	 * Runtime budget in nsecs. This is usually set through
-	 * scx_bpf_dispatch() but can also be modified directly by the BPF
+	 * scx_bpf_dsq_insert() but can also be modified directly by the BPF
 	 * scheduler. Automatically decreased by SCX as the task executes. On
 	 * depletion, a scheduling event is triggered.
 	 *
@@ -176,10 +176,10 @@ struct sched_ext_entity {
 
 	/*
 	 * Used to order tasks when dispatching to the vtime-ordered priority
-	 * queue of a dsq. This is usually set through scx_bpf_dispatch_vtime()
-	 * but can also be modified directly by the BPF scheduler. Modifying it
-	 * while a task is queued on a dsq may mangle the ordering and is not
-	 * recommended.
+	 * queue of a dsq. This is usually set through
+	 * scx_bpf_dsq_insert_vtime() but can also be modified directly by the
+	 * BPF scheduler. Modifying it while a task is queued on a dsq may
+	 * mangle the ordering and is not recommended.
 	 */
 	u64			dsq_vtime;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 28bb6810e5d1804e54eda6916d3d551e17e41fa7..4d6d15c85922b42fae92eea51cbc726360612595 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6291,7 +6291,8 @@ __bpf_kfunc_start_defs();
  * When called from ops.dispatch(), there are no restrictions on @p or @dsq_id
  * and this function can be called upto ops.dispatch_max_batch times to insert
  * multiple tasks. scx_bpf_dispatch_nr_slots() returns the number of the
- * remaining slots. scx_bpf_consume() flushes the batch and resets the counter.
+ * remaining slots. scx_bpf_dsq_move_to_local() flushes the batch and resets the
+ * counter.
  *
  * This function doesn't have any locking restrictions and may be called under
  * BPF locks (in the future when BPF introduces more flexible locking).
@@ -6315,14 +6316,6 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 	scx_dsq_insert_commit(p, dsq_id, enq_flags);
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
-				  u64 enq_flags)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()");
-	scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags);
-}
-
 /**
  * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
  * @p: task_struct to insert
@@ -6360,21 +6353,11 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 	scx_dsq_insert_commit(p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
-					u64 slice, u64 vtime, u64 enq_flags)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_vtime() renamed to scx_bpf_dsq_insert_vtime()");
-	scx_bpf_dsq_insert_vtime(p, dsq_id, slice, vtime, enq_flags);
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
@@ -6547,13 +6530,6 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 	}
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_consume() renamed to scx_bpf_dsq_move_to_local()");
-	return scx_bpf_dsq_move_to_local(dsq_id);
-}
-
 /**
  * scx_bpf_dsq_move_set_slice - Override slice when moving between DSQs
  * @it__iter: DSQ iterator in progress
@@ -6572,14 +6548,6 @@ __bpf_kfunc void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter,
 	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_SLICE;
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_slice(
-			struct bpf_iter_scx_dsq *it__iter, u64 slice)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_set_slice() renamed to scx_bpf_dsq_move_set_slice()");
-	scx_bpf_dsq_move_set_slice(it__iter, slice);
-}
-
 /**
  * scx_bpf_dsq_move_set_vtime - Override vtime when moving between DSQs
  * @it__iter: DSQ iterator in progress
@@ -6599,14 +6567,6 @@ __bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter,
 	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_VTIME;
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
-			struct bpf_iter_scx_dsq *it__iter, u64 vtime)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_set_vtime() renamed to scx_bpf_dsq_move_set_vtime()");
-	scx_bpf_dsq_move_set_vtime(it__iter, vtime);
-}
-
 /**
  * scx_bpf_dsq_move - Move a task from DSQ iteration to a DSQ
  * @it__iter: DSQ iterator in progress
@@ -6639,15 +6599,6 @@ __bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
 			    p, dsq_id, enq_flags);
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
-					   struct task_struct *p, u64 dsq_id,
-					   u64 enq_flags)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq() renamed to scx_bpf_dsq_move()");
-	return scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags);
-}
-
 /**
  * scx_bpf_dsq_move_vtime - Move a task from DSQ iteration to a PRIQ DSQ
  * @it__iter: DSQ iterator in progress
@@ -6673,30 +6624,16 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
 			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
-/* for backward compatibility, will be removed in v6.15 */
-__bpf_kfunc bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter,
-						 struct task_struct *p, u64 dsq_id,
-						 u64 enq_flags)
-{
-	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_vtime() renamed to scx_bpf_dsq_move_vtime()");
-	return scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags);
-}
-
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
-BTF_ID_FLAGS(func, scx_bpf_consume)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
@@ -6827,10 +6764,6 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {

---
base-commit: 7a972c4dc5288087cbb5a66d4cd6d5e6ced4b6c0
change-id: 20250625-scx-kfunc-cleanup-821c6b054461

Best regards,
-- 
Jake Hillion <jake@hillion.co.uk>



