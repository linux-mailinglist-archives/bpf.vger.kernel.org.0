Return-Path: <bpf+bounces-41472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E5B997427
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DE1F21B0D
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8F1E2840;
	Wed,  9 Oct 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvpQuhSg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE61E1C27;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=ZU1tRaQNMz8w/Ovb545TLFgNF/Q0bSi5Kp3W3+FIC8r6NV6rszfkupDd+1BZjrk1DvTzMJeMXqwOWdU4pPBMP/L9IbyBkMZLhu6eYOpPiNOO2xQ7gMNoer7EE3Sf77OEi/GHkR3HaFEOGpVq67ndQ1IjCZdTzJQfsf+djLrkj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=Am8qbMwuc4d4Iuj/D9Siigqz78XzeMZGAjUM0tNr9Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfuGCpZj/V0cje+Kwk6WG+5AuUwf8TO2T7yFmEx2rWI2EJ4BwNkckviC0w3glJmvzCd4pAGXI0E4QCyVqJ22pVDXXrgmB9xpTQrdHcWWN2ufOj+6oSQfgyYu/j6zPp09aysWXcpOPwbdXoraUpuTN2gECDPaxzAbHqRlZDFqMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvpQuhSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A9C4CEE6;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=Am8qbMwuc4d4Iuj/D9Siigqz78XzeMZGAjUM0tNr9Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvpQuhSgcrnfmB1VxjAkD2SLSay9WhILI/5HriHPtNESgCazoSBxu75AssIeIG2wN
	 SM6uTRFf1it7J3XG4Lli+CW5p2/HYlsoLQRoGRNDDxm+vSFs01M0Wd3lsQUgTWxG9H
	 ljfGH6kKV8qIBzopt78bS1rk9FBrDNtwGyioUgcs1p2eZizMvJShs6b4jRN8cTGVmY
	 L6/9BW7aOJAc1v+Muq2Fmjw9L2RChw0C1AOPolRiIZHcCheArodrX9/L8xUuMMlf7T
	 6vNu3MR0QKp9CfGaC2b0XIdh1TgV2tN6RnBDSAuZI9ntgJVR36CM0uPOwA7CPBN9Hb
	 dWKxCMy2zzvZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33CF9CE2325; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 12/12] refscale: Add srcu_read_lock_lite() support using "srcu-lite"
Date: Wed,  9 Oct 2024 11:07:19 -0700
Message-Id: <20241009180719.778285-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
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
index be66e5a67ee19..897d5b5494949 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -216,6 +216,36 @@ static const struct ref_scale_ops srcu_ops = {
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
@@ -1133,27 +1163,26 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
-		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &sched_clock_ops, &clock_ops,
-		&jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
+		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
+		&sched_clock_ops, &clock_ops, &jiffies_ops, &typesafe_ref_ops, &typesafe_lock_ops,
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


