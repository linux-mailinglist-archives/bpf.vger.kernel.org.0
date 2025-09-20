Return-Path: <bpf+bounces-69069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308FB8BC53
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A413CB63C11
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC942E1747;
	Sat, 20 Sep 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz9prfzs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F181D6188;
	Sat, 20 Sep 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330012; cv=none; b=Z+bA+LqV884aXXwTDW2cFecUxP1Jso2KgpnxWKHj35ylHbNibgL01G8lcoYMPCybRAhL5A9NZ1YWsM2v/TGY7F10HEGKV7jpka/cEq3vodwzo+BT830N+LT6m2uVC5Rtp3fATS+pjkfE0RyJ8AIQ6SvbM8ABSlcXfsgIgsklzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330012; c=relaxed/simple;
	bh=KzmSiQNYCYgYK7tUFP2/hc9AJ6o5wRY/9mkPeVJPJtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0ox2jZT3Me1rwqf4yXA3SeMWSXXecVUqxY18CNT9DkcNHwjCCSF5vdXNez8f/1SqBAejlh/z2qehmKFySrorRqZBHw4IHiugI/joHiXMTHEekx96N3ajHYAl5VyRvvjxt6CuH/ZkdHSBduHXVbsln8RJniqez92QUAaIzCCa/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz9prfzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0FC4CEF5;
	Sat, 20 Sep 2025 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330012;
	bh=KzmSiQNYCYgYK7tUFP2/hc9AJ6o5wRY/9mkPeVJPJtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz9prfzsxSkS4/BGMqnu+AeztlVY8vTiivaFoQnqfnTY48aPzmbhIAnmXU7/eImiT
	 VK9U+BWsMuQxbFQ0AZfcQrdQdBcikEBocqx24/KmPPZ3uJPRyYU9Ormpft7kcq1iTx
	 skMhfYgyM2ungaKD6qk7yRK70cryQmLfWITweemZ6/c8+PXSxmkPNnmSnKdvplHEv0
	 oPV+T+xdSyxU5MHOL2iR23lg9qr5kgD8mzVSqu1uhN7uKS2MerRM2qBkr2dRICrDNa
	 19xWUV6VnTYLlnhytT8j3Cqj9VYEJlRS4FBF7HC/wCL0TEpRREunkMzP5gsPkFGiwl
	 W8ZG7PqUWo8Gg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 35/46] sched_ext: Dispatch from all scx_sched instances
Date: Fri, 19 Sep 2025 14:58:58 -1000
Message-ID: <20250920005931.2753828-36-tj@kernel.org>
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

The cgroup sub-sched support involves invasive changes to many areas of
sched_ext. The overall scaffolding is now in place and the next step is
implementing sub-sched enable/disable.

To enable partial testing and verification, update balance_one() to
dispatch from all scx_sched instances until it finds a task to run. This
should keep scheduling working when sub-scheds are enabled with tasks on
them. This will be replaced by BPF-driven hierarchical operation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 714b45a55112..75a4b05fced4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2239,7 +2239,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root, *pos;
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
@@ -2283,9 +2283,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/* dispatch @sch */
-	if (scx_dispatch_sched(sch, rq, prev))
-		goto has_tasks;
+	/*
+	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
+	 * hierarchical operation.
+	 */
+	list_for_each_entry_rcu(pos, &scx_sched_all, all)
+		if (scx_dispatch_sched(pos, rq, prev))
+			goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
-- 
2.51.0


