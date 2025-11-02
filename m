Return-Path: <bpf+bounces-73315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32046C2A49B
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DBC3AFFE2
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD822C0F62;
	Mon,  3 Nov 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thHYWLwl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D032BEC59;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=biAP56elZ+5K1Ms8BF9D3fNp+pb5vNpDGGvRscrvvJbcZ8nXOVi6S3MAMIzS1K3viEIojzmCOmDUXiJo0heu9yNM79O11dRpccZENhux1krtaBGs19vssNWkRIqUrEfJshJHDEhyrX52ovRDmYX0g1oluUKQ0a8SEVaQ1Z7AA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=bygEsSTdrpTNsepCJbQrl8IEFAGJacekELf8ihO/Yz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MaBPKQT10JxqenaRttLT+mAzOjm0JEMnA1Iw1x6rVNMBfqKLVW/GE6g1/5CH5oDVk/457OlTOy2HMgj5reDPLyiqtz80FpXw7D04gBu5DTuzidTNpBUHTR095LVjuW+bolZwRV5+Mn8Du10E5ByUrzQvl2p38trxE9rm2j2X4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thHYWLwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31477C16AAE;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=bygEsSTdrpTNsepCJbQrl8IEFAGJacekELf8ihO/Yz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thHYWLwlERq0sMfLXWMZtoaM7fzvVlxq3j/ao6p6PjeWEcCCfhYhO1/tLf8YXHW1E
	 IVWQ7lBA+Q/1fTe+5Rt+5vNNQ6Ncx8EK4cIfnuheI3RNaBUEOEJk2yg5pMacV1gq9l
	 CHjecUVOtgLIPUfc+qIihMz70S1DnPoyQfljIAKq9SKZcAUBsTE9FvVxA5+Cn2y6yF
	 eLOwBQkFl84ZcnozsMM8sVuKHaWog8tKbMihVb7KSeGKimMWiqVCZ4NFXDA+ap9CyI
	 jiTGRDqtSQnPCxXmoI/dHW/ELanlQabdS+y9E+2FvAu15qYC4ygvR7zzlOtiSyEwAu
	 h9GpcUSA3CYOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6E60CE16F7; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 2/9] context_tracking: Remove rcu_task_trace_heavyweight_{enter,exit}()
Date: Sun,  2 Nov 2025 15:06:52 -0800
Message-Id: <20251102230659.3906740-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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
index fb5be6e9b423..a743e7ffa6c0 100644
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


