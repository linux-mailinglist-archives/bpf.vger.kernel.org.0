Return-Path: <bpf+bounces-69046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B0B8BBBD
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D809170E64
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44268259CB6;
	Sat, 20 Sep 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhXfRxMS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA554258CD9;
	Sat, 20 Sep 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329986; cv=none; b=b4JUAvy80XCCuLg0XvKecApIAmFDJuFJO92ugr0uc6V0gx6Vy+XjMAFEh26t04YgA+rQcJx96XWOvoCzdbdbZMtXA4ZzV3XMXPjWBhg/Hw3muia4wCyWEiulj/dUXR/E9GhcvjFxBvNjleraqzrhnC0ZVynmrRU2jLSK74uwATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329986; c=relaxed/simple;
	bh=IWegEyR1c1/atVD9N7JvMZdR4sBXsOyYkuHm6qOODWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDoX3UIWCT8ZyaTEJLRm1qQD8m47DyBskXn9uZv59m/bjs/aD5qrZ2Wh7aBDmZM+QXblwp3ZCDksSK6TmN+JI8d85oqBZVCF27LfFu0Co7swYz2O/tXGxqZ0A3KR9Lb7kvQli624uHm8Nym9mlojRAC7TfJhIOKeuhVGLJZ6zPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhXfRxMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BB8C4CEF0;
	Sat, 20 Sep 2025 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329986;
	bh=IWegEyR1c1/atVD9N7JvMZdR4sBXsOyYkuHm6qOODWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhXfRxMSuv8Z+H2RcVfLZNTY+L/0UX4YyFIoPn9BxrT2pTSn4rNVxkyZ4XAHLE6vQ
	 XwYbC7uPdedcr0+GlT1T9bKYW6ADW4Enm5HPzcAHuFYbSbgj20XCbWNqiIxpGMqxIF
	 jXZgbhCZP9Kk8mQb7i0ZexEEWythpIczntgawnR1JNXc1LZEkzQGnzh1oUQe8IMxav
	 cFkinkW/r4mQp+JMqdIOi7hJQ9p6YbT5Uo9YuSV8E7geWdDKFHA5PbGFQml/cYQhmC
	 1Zq6QDtf9Nr9g4BiOuTsFHjnNdzPm+tbrrlciZV0jZHEEQzYBAf/VIWL0pNTjdvwvh
	 vONORSPWN/8sA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/46] sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
Date: Fri, 19 Sep 2025 14:58:35 -1000
Message-ID: <20250920005931.2753828-13-tj@kernel.org>
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

In preparation for multiple scheduler support, add the @sch parameter to
scx_dsq_insert_preamble/commit() and update the callers to read $scx_root
and pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56ca09f46d1e..1455f8c56d5c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5240,7 +5240,8 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
-static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
+static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
+				    u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
@@ -5260,8 +5261,8 @@ static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 	return true;
 }
 
-static void scx_dsq_insert_commit(struct task_struct *p, u64 dsq_id,
-				  u64 enq_flags)
+static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
+				  u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct task_struct *ddsp_task;
@@ -5325,7 +5326,14 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
 				    u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(p, enq_flags))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
 		return;
 
 	if (slice)
@@ -5333,7 +5341,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_commit(p, dsq_id, enq_flags);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 }
 
 /**
@@ -5360,7 +5368,14 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 					  u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(p, enq_flags))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
 		return;
 
 	if (slice)
@@ -5370,7 +5385,7 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_commit(p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.51.0


