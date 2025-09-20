Return-Path: <bpf+bounces-69061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D246FB8BC14
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE4A1C2247B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7C2D94AC;
	Sat, 20 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEPsU4qf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D92D6E7C;
	Sat, 20 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330005; cv=none; b=qB/U7Ta2tQL2fydjoaaZikFVYDXOYrl7H83U5T4wFPoSH9cpftQTWfdkR9fIN3G9gNFaqWmkdWvm9C0sO03lzM1rt7J1X0CHfq9arTrgE/arZebEb1TEuxovm9L60kQmsA/LXyDpCYoYS71+8GmHCfp8s8KFnb+wolqMYcD+bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330005; c=relaxed/simple;
	bh=N9jp6N2SzgjC06SRHqM28c/OV1NlzqVqY7PjEUB7WIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxjehNv5at32Ab7asPOW4X7CB3LRTFkWpG5wiz5sZFJHR5b9NQx8aCy0MxPKcLgAwx1JkKEBjN75R26k5Y93/1Fbe0jjfHTODuR4qgJCH+2wVA24hu4r1bQnx6IlAXKWj32yGdl4tkKAYTc9WLvinM4sR05QXEaajyLjoHVJ2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEPsU4qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC1C4CEF5;
	Sat, 20 Sep 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330004;
	bh=N9jp6N2SzgjC06SRHqM28c/OV1NlzqVqY7PjEUB7WIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gEPsU4qf8AwiF/2FWcC0sUCZXnBznVbC0z2crD0lwOWUeJLP2l2DH2/p9JKGyIb+T
	 AiuAid9Zzg9eN8YJWRAUhMef9bMDkx/0BZpaG1iQt0dkv7b0aF0la1a9K8i2IODotG
	 EEua5WKOmpfShBLxCuuDLoX0L4kHiY4vp5dNwnyZf6IjK/z+WxuAyMcIXvk6I7gq5o
	 EfymLneDl/9aUpE1muPSELn9/qgMvuIYEt6zg95WxSAJ6a4YY4WeVLuAaUIu1Ex8kj
	 HS6Y9tTP29okj1iXr9RmNKvILlTkSUU8kHTk3iwUVbxfHOniBlyc2zm24KdNqMJRwY
	 SWSccingEj7Iw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 28/46] sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
Date: Fri, 19 Sep 2025 14:58:51 -1000
Message-ID: <20250920005931.2753828-29-tj@kernel.org>
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

scx_bpf_dsq_move[_vtime]() calls scx_dsq_move() to move task from a DSQ to
another. However, @p doesn't necessarily have to come form the containing
iteration and can thus be a task which belongs to another scx_sched. Verify
that @p is on the same scx_sched as the DSQ being iterated.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 891b956a92b6..c60b58341d24 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6027,8 +6027,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
+	struct scx_sched *sch = src_dsq->sched;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
@@ -6038,6 +6038,11 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	if (unlikely(sch != scx_task_sched(p))) {
+		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
+			  p->comm, p->pid);
+	}
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
-- 
2.51.0


