Return-Path: <bpf+bounces-42079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF199F270
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3B1F21F49
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF81FAF0F;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLTU9ovS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88B1F76DD;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008675; cv=none; b=laFi3NAhqex4qZrQmPlCHD5vJs50+D8wcf/ailyez20TSKd5rb+ihtnJhG6sKvDGZxHN2PukdJAbFSDH60xX6jEM+y5efm+iTyE0gGO/rAFxIgQPbGT5tvWv7Ru2s0YiizIVtvHaWaKf5jFdVON00f0qNzxTdttH3/5sS92rpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008675; c=relaxed/simple;
	bh=ShAY23PXWJnTwN9m3aELbGSryO452AQIXFVffiHUjJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=edC1hSAa87U7INZi/fDo6Y9MX5TrkcdP2PGXdisj5iI/ePQW4TQqoXUFPjrL8l8nKT8prwzQqDkivl9A+xg8tsjOYYNS94t6LPJ8vex1jAfngaIbqGYS8vDH4fYqbdpKELKdGCzRstfvB8gWo2bCUAI8ISSZj5wji92m4NLPIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLTU9ovS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B44C4CEF3;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=ShAY23PXWJnTwN9m3aELbGSryO452AQIXFVffiHUjJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLTU9ovS7V5DQluJGRKqzRlmP20klBZWltdZIpdgvfxcg0+/eG4Cwaj0xEwHOUAtP
	 /Ji4tT90mMEUhTGub0zGqCrKbSRtoU0ZcEkTlBPiwEUgJT3i7k+Q1uQK5hUmjME8AW
	 a9+f43D+BOtWUeqpm3NgeL/Mj50NU6YTTGCwmXq4mz/vgAkDmNJvMlxQlNS60Rlg8k
	 kW9uwTlFFSMXAy6/Xgx+GouyhP3baIHbf5FP6BUawXwrvTg+Q4AEwjLtCPi4H3evOx
	 bjnrCixHk3GLKz0Si3mNEHHxCIswE1nf1dBxbRZ5TjMyKmSDrgDdce5q+4CCqW91Rg
	 gVitZYy3/GhFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7376CE1FD6; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 14/15] refscale: Add srcu_read_lock_lite() support using "srcu-lite"
Date: Tue, 15 Oct 2024 09:11:11 -0700
Message-Id: <20241015161112.442758-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates a new srcu-lite option for the refscale.scale_type
module parameter that selects srcu_read_lock_lite() and
srcu_read_unlock_lite().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 51 +++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f2..09ee27ced2a78 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -212,6 +212,36 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static void srcu_lite_ref_scale_read_section(const int nloops)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		srcu_read_unlock_lite(srcu_ctlp, idx);
+	}
+}
+
+static void srcu_lite_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_lite(srcu_ctlp, idx);
+	}
+}
+
+static const struct ref_scale_ops srcu_lite_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_lite_ref_scale_read_section,
+	.delaysection	= srcu_lite_ref_scale_delay_section,
+	.name		= "srcu-lite"
+};
+
 #ifdef CONFIG_TASKS_RCU
 
 // Definitions for RCU Tasks ref scale testing: Empty read markers.
@@ -1082,27 +1112,26 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
-		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&clock_ops, &jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops,
+		&typesafe_seqlock_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
 		return -EBUSY;
 
 	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
-		cur_ops = scale_ops[i];
-		if (strcmp(scale_type, cur_ops->name) == 0)
+		cur_ops = scale_ops[i]; if (strcmp(scale_type,
+		cur_ops->name) == 0)
 			break;
 	}
 	if (i == ARRAY_SIZE(scale_ops)) {
-		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
-		pr_alert("rcu-scale types:");
-		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
+		pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
+		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
+		i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
-		pr_cont("\n");
-		firsterr = -EINVAL;
-		cur_ops = NULL;
+		pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
 		goto unwind;
 	}
 	if (cur_ops->init)
-- 
2.40.1


