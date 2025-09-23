Return-Path: <bpf+bounces-69418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2EB963C9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCE9178118
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705EC328576;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMOeIG9B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EF327A1A;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637314; cv=none; b=egAdWiGu3ZTaWBX5qDDph2Pb8Mkin4vwRPAb4bFuR/efCDBeBV/H6MhEJvRHKZbznahiRD0xTEl+ZRK9VbT6ivMmibbYkl8IwHe/QSIk4eAJ38W2CS/ffutFgW5YgxL5V6KZYIQKSX3YGa7stmCj9ERmZsro7227GeUGqNxef8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637314; c=relaxed/simple;
	bh=ZhOe7rNnjZ2YNl4vA1vdnXfrcjpjHHIwSM1yRejM3bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGCjID4lnv/6tnIaUiN/tbacgC4Uu88OQemF0T1qCFKMnv8BEsOs8OdV3HBa5rdFsNV8pundXN65AnIs2zP/IOdecA453hoGWBgfkrfAzyuuJFIr/q6PHQ+mBpmeVWgZ5byZPmiLLLSGzRalyUhikl4m7f4by+OYtOxO/fzf3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMOeIG9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6EC113CF;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=ZhOe7rNnjZ2YNl4vA1vdnXfrcjpjHHIwSM1yRejM3bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMOeIG9BRilsBzGHPtTMcJFpJE5CgdGJ4eJlXzk/4XarRfrzuUysdwecFf/GJE2bj
	 BrZe5HZQZ9rwFIQH0DQeJnUa3u61WRuVf+OZdC/omqUFPanI6nFiyCqBpjEoNeF/nV
	 Fc7E5K44JJUHad/7D5sxkY2voarGVL+9MXYlbrFP6xCXgLjC/8ABRNqw4It+yPteHj
	 PKnO0MDlq9lsNaWl6qWY4+VoSyAubeAe8YHp2rk5fPyDqtiop3+0phMIiIlEATHorz
	 l8lxGfB26AH96uKkp1R+wyRpN4E8IGrSWs+/pNLyZ17MS9sV8QL9C5d8NRsbDSJ8EF
	 3mSZu8ZUtQcHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEC00CE0F71; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 04/34] rcu: Remove ->trc_holdout_list from task_struct
Date: Tue, 23 Sep 2025 07:20:06 -0700
Message-Id: <20250923142036.112290-4-paulmck@kernel.org>
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
the ->trc_holdout_list task_struct field is only initialized, and never
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
index 3f840cfa941132..e62c99e44a5502 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -941,7 +941,6 @@ struct task_struct {
 	int				trc_reader_nesting;
 	struct srcu_ctr __percpu	*trc_reader_scp;
 	union rcu_special		trc_reader_special;
-	struct list_head		trc_holdout_list;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index dd6226251689c8..91c37f66ec8e9a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -166,7 +166,6 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
 	.trc_reader_special.s = 0,
-	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
diff --git a/kernel/fork.c b/kernel/fork.c
index 69d34c123b9e5f..12388e895d2955 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1781,7 +1781,6 @@ static inline void rcu_copy_process(struct task_struct *p)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
 	p->trc_reader_special.s = 0;
-	INIT_LIST_HEAD(&p->trc_holdout_list);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-- 
2.40.1


