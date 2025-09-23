Return-Path: <bpf+bounces-69420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D9EB963F6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B28188CBC4
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA1832857D;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwSootcX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D92327A20;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637315; cv=none; b=hHApeDu4Ko6eL6RJ853mGlwt/i2B7jImbHtmbXjiAGxnUljfa9aVQ6fqlbfP7W/XLvxW8zBMlrb9UXNFBBW15Udl2njN6BpJI0sHoQE70ome8iqEExoBzL/jtWVAa8LPs5r1mgjb/BhTE5e3qK37odRQ/ceedQUTWIttIoBxiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637315; c=relaxed/simple;
	bh=gORzw/K5miRE/rNReHV1tjj65oo9eOSliJxhQHUaXtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHi9ls/20ybVNKqlYW+1a/mML9siYBMz9FpZRpRd9QrFZkzOsg42vhiPUDZfh5q2WyY5oGkUoCU5y6CQngN9AZAa6AghPBMfxYtRkMZ85WtNVmj8m/HyiVnNnyo6NCYhLGphjUFdUz3hq7O9ge4FyXVk7See3l3Ofrc7KnSFz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwSootcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A2C19421;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=gORzw/K5miRE/rNReHV1tjj65oo9eOSliJxhQHUaXtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwSootcX+hMz03OhUwZFvSEPmGOuAvoPBUqXbKeY+1HBzAKWcbk3vf8SYzkTIVI58
	 63B6udTAqRiPYP9xcnZSZvS5lyIp7dnsTk088VwtyzlihPrg/XW02yAiXYFewnAIps
	 67TKJO3GP3d6Mo5OwLcnF/L/gy2sGg9CUBG4RbpIXCE1aCXMvOZw1qLcBLudvqxaua
	 8PfH5Yy0ARtAZZPdon28prIgi+9JdstTRmWAuqGb5fzyKxhIEuUh/ipTzhMUM/j0uY
	 0VQDe2j0VN1yQJK42PG66b3aRnBVQMwblXjBwm0NKO74FHFIvMBBFN7Z0ujPuUAjqS
	 NBwKcqUvCjOdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C413ACE127E; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 06/34] context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()
Date: Tue, 23 Sep 2025 07:20:08 -0700
Message-Id: <20250923142036.112290-6-paulmck@kernel.org>
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

Because SRCU-fast does not use IPIs for its grace periods, there is
no need for real-time workloads to switch to an IPI-free mode, and
there is in turn no need for either rcu_task_trace_heavyweight_enter()
or rcu_task_trace_heavyweight_exit().  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/context_tracking.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index fb5be6e9b423f2..a743e7ffa6c00f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -54,24 +54,6 @@ static __always_inline void rcu_task_enter(void)
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
 
-/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
-static __always_inline void rcu_task_trace_heavyweight_enter(void)
-{
-#ifdef CONFIG_TASKS_TRACE_RCU
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-		current->trc_reader_special.b.need_mb = true;
-#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
-}
-
-/* Turn off heavyweight RCU tasks trace readers on kernel entry. */
-static __always_inline void rcu_task_trace_heavyweight_exit(void)
-{
-#ifdef CONFIG_TASKS_TRACE_RCU
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-		current->trc_reader_special.b.need_mb = false;
-#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
-}
-
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -85,7 +67,6 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_task_trace_heavyweight_enter();  // Before CT state update!
 	// RCU is still watching.  Better not be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !rcu_is_watching_curr_cpu());
 	(void)ct_state_inc(offset);
@@ -108,7 +89,6 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 */
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_task_trace_heavyweight_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
 }
 
-- 
2.40.1


