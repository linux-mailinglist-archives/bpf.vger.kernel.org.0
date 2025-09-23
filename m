Return-Path: <bpf+bounces-69407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 011ADB9638D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B98F188CDD7
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EB279335;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA0ivHQN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926A22A7F1;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=r/YLGEYnHofrgsQLyM5TlIMYKOjFSToIAiZjFgqNFRoiAhhkvcjY2LOPvh8Qk9VsL6lNpOBg7WHA4kyOLWD2/W6eiLULVi4+SyxR+P0A8TxvbmoARpgirn9o0VIhylZUnUet6b0oT281EqYSDyFtbegmwgHYA1w13vbvTlq4vlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=xsMVIazrHCxbo8kiV/02R0kxVkmtf66xKO9RsbF5hME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2r2fHYTi+IBDAOn2OHdzkzNx9Y8F9y1vQJabXU8fty4cJrI1r9bZF0Q348uZ11OodDPfHH9qt3iZTzoEICVEwf8wke04aGl3D15L9fk1hQXgK6EQ46F6dHofrMuI5F43HOZb8MZrrMnz5KjdUlDB5ipXar+M+7Gc9P5CM5vGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA0ivHQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCCBC116D0;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=xsMVIazrHCxbo8kiV/02R0kxVkmtf66xKO9RsbF5hME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA0ivHQNN+qep6DSP67RPLXjz/jEtlKdCPLlxaD6viNJUK68p6t45r78aSrTs97pH
	 R6NU/YnAMBNjhb0C3vydjuGb+/Du7zOFF68ywSOs8XllVQs9bDNHbw4dJRxREMIYf5
	 vCzfMBeexuz+5uagaJT8Pobh05vp7XRiuF+MKzrsh7iRSRai4Elx7trxZeyzKU/hKm
	 g7eD7FplcufHfRwvOhn+TXvSqYp1/tvsbANIFIaE7qdARjdGn6yvtYg2Eq0YugrkJn
	 WIXu1KqwDkRwBQ6J/WooW2xSh16bD+YQrAT5qx9TC+D7l/c12UTu2ruyN0gh/CGOJh
	 DKG4daNytfSsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC08ECE0F21; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 03/34] rcu: Remove ->trc_blkd_node from task_struct
Date: Tue, 23 Sep 2025 07:20:05 -0700
Message-Id: <20250923142036.112290-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RCU Tasks Trace has been re-implemented in terms of SRCU-fast,
the ->trc_blkd_node task_struct field is only initialized, and never
actually used.  This commit therefore removes it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/sched.h | 1 -
 init/init_task.c      | 1 -
 kernel/fork.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 47bd062b21c2bc..3f840cfa941132 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -942,7 +942,6 @@ struct task_struct {
 	struct srcu_ctr __percpu	*trc_reader_scp;
 	union rcu_special		trc_reader_special;
 	struct list_head		trc_holdout_list;
-	struct list_head		trc_blkd_node;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd9061..dd6226251689c8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -167,7 +167,6 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.trc_reader_nesting = 0,
 	.trc_reader_special.s = 0,
 	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
-	.trc_blkd_node = LIST_HEAD_INIT(init_task.trc_blkd_node),
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dca..69d34c123b9e5f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1782,7 +1782,6 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->trc_reader_nesting = 0;
 	p->trc_reader_special.s = 0;
 	INIT_LIST_HEAD(&p->trc_holdout_list);
-	INIT_LIST_HEAD(&p->trc_blkd_node);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-- 
2.40.1


