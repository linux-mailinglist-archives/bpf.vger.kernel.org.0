Return-Path: <bpf+bounces-77479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6544ECE802A
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E53B302A123
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4146286400;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlO2+I/4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE323A98E;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=IVxkeKzu1YAIQC8bIRsaJGYa8CpEA4gCoMaNxVNyHgRsCwTlb82zTCZjUvyJ6docCZwjxPCiUDwSow7nHblX3RS7cpXChamZ/UW5AFsU/mDNhMb3QiNrDapRP4AanVkIk5ug3qbaZtwv//mz8p6O0GuCl+KIcdiZNDKmhWH1Rkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=H1OYPAFLY33QGyp3X+2tKdJZfWJ6CMrZ3iYMWsERzxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmLNxCvlX+yuW+Qa6pPC/+GdJgYty9TfgaYyp6h6moKVM4Objhwr2iu39f9xjLa+ndv+LE1r3ELvOueON0A4eJRsLJ/BIn7NH3HZybnyUGTYXSOp7wDDuXO5DiBlh6wFaLuRrb7aBhQYBmJhHgPk+xCmsMpIR0hXBo/4Rusq8t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlO2+I/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC06FC16AAE;
	Mon, 29 Dec 2025 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035466;
	bh=H1OYPAFLY33QGyp3X+2tKdJZfWJ6CMrZ3iYMWsERzxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlO2+I/4vlAsAG6ulFZ+cjRLNfVRd5kvKMWEbsXkY3HBLrKPyW6hWC1j7F2H7vin5
	 KNLfChK0Oo+S3bH/4/IprHwAUN1nkZ7mI/j0PY/2cZ3/388R/kY/abNo0QQKcfc2RG
	 BRWSg8PY6FbDuVshHdl+Cr/IWppsK/UmQuHCaskaGupp2rpHR8naM63U+5em65i6Cn
	 MAuN5Y6EgOrsQWGuu6JSrsY+SKs98B25B475RS+1oIm/T8xW0Yw2qtCyCFY5cRBN8r
	 Fj/zR/hq5nj1RYi9AlgRuaZ0nmC3ZSYt19lbeUiKNnIXIFwAQ0BRwyUTQHgcGO+ZAQ
	 Vj0UUO17WbE5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6E51ACE0CAF; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
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
Subject: [PATCH v4 2/9] context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()
Date: Mon, 29 Dec 2025 11:10:57 -0800
Message-Id: <20251229191104.693447-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
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
index fb5be6e9b423f..a743e7ffa6c00 100644
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


