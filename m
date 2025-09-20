Return-Path: <bpf+bounces-69064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1152B8BC23
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF071C22635
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C72DC76E;
	Sat, 20 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKHdic09"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D32DA756;
	Sat, 20 Sep 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330007; cv=none; b=rucDOXNd4/Kjn4WMVU+vmoUtF+wIAgH2nhRxE3f9O0DyN2Z8uHspHcknS1c2c/uFwRWXq0FtjrFuMOTfqOC7qGVu/hnsIaVHwOi4QoURpZFikDlpRjy9cHIds+lPOELhqdQ7ERkQwOFrt6GO4RFFx139i9AKs42XnDL9YnkRP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330007; c=relaxed/simple;
	bh=sb621nQandoSffH7cpTMy1jY0BXouXNMutvsOCExl78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guoWihrea1g+OA3pDCaZGFkVEkec3IQRjMrXHEC7hWL03RWCvej+fX77YLttlMgTB6ICo3FEVMPs9AjT/Y09zIMICCgx1IUuExhXzCCOFFC+zF0CsTOnJHlEL1CktDmiiI0pnoRslyFSlKl3xUpWJ9BmC1iL9zS96UYkXg+QtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKHdic09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB92AC4CEF5;
	Sat, 20 Sep 2025 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330007;
	bh=sb621nQandoSffH7cpTMy1jY0BXouXNMutvsOCExl78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKHdic09sHhqjNeZtEQMKWMyQPRWn1kKd/3KRZS9yA19Q1DhZ9wZSe6NN59I9RGGg
	 1tEyMGoV/EUbuL0yey8tnr2yoau+bHV9Nh1mHsFwPlku5uDSFVn9JJQ5HZqnASy2AN
	 W/2kdjWly6p3NItXIs5d7qBdl4BwiTSQdU5513aaC/uftDzInI3geCU5Q5apJ8zpiy
	 a/2EhaDx7g9tzvzzOTZvSK5CDCacq9e1zsofx+6bpmCv6DPKIIrNg6KG3NC4z9NdQu
	 RwSWslIfQ4yuzAKPBnu93cpigb/mQpmu1CKZid617+tW/afzvJAKn80N+nvIFX+yrq
	 tADfbWcPFK4nA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 30/46] sched_ext: Make scx_prio_less() handle multiple schedulers
Date: Fri, 19 Sep 2025 14:58:53 -1000
Message-ID: <20250920005931.2753828-31-tj@kernel.org>
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

Call ops.core_sched_before() iff both tasks belong to the same scx_sched.
Otherwise, use timestamp based ordering.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5b02903ba3bb..2b8a1a950c74 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2602,16 +2602,17 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch_a = scx_task_sched(a);
+	struct scx_sched *sch_b = scx_task_sched(b);
 
 	/*
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
-	if (SCX_HAS_OP(sch, core_sched_before) &&
+	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_rq_bypassing(task_rq(a)))
-		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, core_sched_before,
+		return SCX_CALL_OP_2TASKS_RET(sch_a, SCX_KF_REST, core_sched_before,
 					      NULL,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
-- 
2.51.0


