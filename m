Return-Path: <bpf+bounces-70089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11CBB0CE6
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786193A9F61
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136CD2FCBF1;
	Wed,  1 Oct 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAjk6kgo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0232550D4;
	Wed,  1 Oct 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330117; cv=none; b=ezpM+OzqX+Qv/Kwz4NHzis3SRaRVUovudGP/grPxE85mDCUQi/KtlhBVNdd2v8tvy8vkQsD86hRr4QfFAKJox7s6DR31rLsyBqMDFbUfNOSf9Fi8hc9hPMUti+LKcg9yegeSGsMiarXXWvbsUPLpJgljhZ020A0ACQ90gAebPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330117; c=relaxed/simple;
	bh=gORzw/K5miRE/rNReHV1tjj65oo9eOSliJxhQHUaXtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8ogYNaBFCWfeq8RdEdTVEKjsFXgO5HfK+B8HdnHJcTwIrEY7LzXkW/DteGC+eq89/UdpqwMjLom9VqLMw+YJeiY8DpuAq8jJmZY2aWUIWwn9qGghsR4HkW7igb3INlvRVl37O4Ycs2E17+GPK5UGTgMvYeIu7Otg9me2ixoAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAjk6kgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA60C4CEF1;
	Wed,  1 Oct 2025 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330117;
	bh=gORzw/K5miRE/rNReHV1tjj65oo9eOSliJxhQHUaXtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAjk6kgoN0vOc2F0MkIZtzNr7hH4kTxjfAyN/4fVnEOvFSXXNfHvbBtn1rXkw5DjZ
	 YXNsEI/ph4XsHnjkmHjPryT3fASSsNefGPzmPJ1EHwqrWrpm82yhlUB8lKMGlZIIXN
	 kQsF8svNELpG7AUexB8v1tTConjdElRG9zjdyJ3j7TUZ7YhUK1gVKh0mFS+qYoqXU6
	 lEJM58sgpLQZBoEs3/kaZwYHDbCFMguvdHZ2LCeVAnApaW1uC4U32eJRzcXGbHv6bO
	 dL2iI7gfjXo4EFMMfaSkiYZEiAj0ozo/qDJOeooxunJ9bzaexSDHVxR+867XQC1p1R
	 zALpxcOb3+CNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 677A3CE10DB; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
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
Subject: [PATCH v2 03/21] context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()
Date: Wed,  1 Oct 2025 07:48:14 -0700
Message-Id: <20251001144832.631770-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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


