Return-Path: <bpf+bounces-69411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20EB963A2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE02E45ED
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DA2E336E;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWfk/tc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F092652AF;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=trCmbb8Z0owHqSvdRtHRj7JN+EmbgJeWoP4w5C3biXoWRHRYyw8EOyNQ7hs0do+tkKNUjhHxgpJZQZsNBHYA7Qv4k+oy1OSp2Q/OQHWclKwUU/p0ArKrw7bGVTgu+1Ocw+v2oatcYsQevakBrXGbc9QLMvL2/1brHE//o9/k++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=ywaNuK6aAoHek5VbjiDHoWBoyJGmii7APxujsObI1Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R59ll+h1qupbJrgWNLD8m4vZhp972Vp0xtWwnSIiuOMrpnjGePqxDI75Ca0aEb5VLAJf5rKICaJLVhDBotpKJvfMArNGvcLq5KRyieh6jiT6cRoVXottxyOF/CcIDcepBf5WKlkUSqjcuNggjWQaCYCu1QFNUF3NV97pn2sUC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWfk/tc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE7C113CF;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=ywaNuK6aAoHek5VbjiDHoWBoyJGmii7APxujsObI1Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAWfk/tcqGU2ZN9qQKIuvRLU0ExfB40CI1/8bxmGjEBXZFJggmySHlRiFHU3UMbQ1
	 HTrQNF2gBijNApZ/q+bF9A9X6EzRGIrEIplMIpbI1upvoE8Pa2FdHtsgsRKUXCF17w
	 AydEhEu0CxFHj+dRc0wid4MxrP7QQtNStIwtOwlfQSBuwnlOheWmyyyuaZMUVq7b8j
	 ROkH2hzMd7O+TtC34LIMEyEuK5CYQpvefsVW2hUqw4tqw6Cte09XaMvG/ryqJf/CuE
	 dMzV6gO6vnysPvpkgo5UF5vJI1UeG14K570Jo7BSKwdHdHaFB2kjpBWLtX4XhpOV4T
	 TeThG3uKEmisA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1435CE11D4; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 05/34] rcu: Remove rcu_tasks_trace_qs() and the functions that it calls
Date: Tue, 23 Sep 2025 07:20:07 -0700
Message-Id: <20250923142036.112290-5-paulmck@kernel.org>
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

Because SRCU-fast does not need quiescent-state helpers, this commit
removes rcu_tasks_trace_qs() and those things that only it uses, including
rcu_trc_cmpxchg_need_qs(), TRC_NEED_QS, and TRC_NEED_QS_CHECKED.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate.h | 26 +-------------------------
 kernel/rcu/tasks.h       | 12 ------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb1d..879525c5764a0c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -176,35 +176,11 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # endif
 
 # ifdef CONFIG_TASKS_TRACE_RCU
-// Bits for ->trc_reader_special.b.need_qs field.
-#define TRC_NEED_QS		0x1  // Task needs a quiescent state.
-#define TRC_NEED_QS_CHECKED	0x2  // Task has been checked for needing quiescent state.
-
-u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new);
 void rcu_tasks_trace_qs_blkd(struct task_struct *t);
-
-# define rcu_tasks_trace_qs(t)							\
-	do {									\
-		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
-										\
-		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
-		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
-		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
-			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
-			rcu_tasks_trace_qs_blkd(t);				\
-		}								\
-	} while (0)
 void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
-# else
-# define rcu_tasks_trace_qs(t) do { } while (0)
 # endif
 
-#define rcu_tasks_qs(t, preempt)					\
-do {									\
-	rcu_tasks_classic_qs((t), (preempt));				\
-	rcu_tasks_trace_qs(t);						\
-} while (0)
+#define rcu_tasks_qs(t, preempt) do { rcu_tasks_classic_qs((t), (preempt)); } while (0)
 
 # ifdef CONFIG_TASKS_RUDE_RCU
 void synchronize_rcu_tasks_rude(void);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 418fa242cf0288..967c43b1937bae 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1471,18 +1471,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
-/*
- * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
- * the four-byte operand-size restriction of some platforms.
- *
- * Returns the old value, which is often ignored.
- */
-u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
-{
-	return cmpxchg(&t->trc_reader_special.b.need_qs, old, new);
-}
-EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
-
 /* Add a newly blocked reader task to its CPU's list. */
 void rcu_tasks_trace_qs_blkd(struct task_struct *t)
 {
-- 
2.40.1


