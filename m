Return-Path: <bpf+bounces-38792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D34E96A482
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF7B1C242A7
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389FB190064;
	Tue,  3 Sep 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjYHreFM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7318BBB5;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=a278Wdjsx/Fv6P88kmZR0W8fwGSHLl642wmMj/XbwzKDqFyoTH9hpo1RJGhVQ8o83JQtHAWGPYG+dOJxO7YQsBsX7Hjv7zFXqjh0lBZxp6P+DRDYDAsFPBxCWFbeYiQTWeXFiDTkSMNUjBWKL0eGj8iUIlM6+qbxcwgLGzpPAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=ORSEn+B9SzOpd0/AL3CBTF/ZpRsAEqz4d839A5gC5sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXLF8Aydp7JO9s1vBn90peSmG9soz877I3B7pLN97uViamiJQurk4ITFuzVOts7ULHt2c+h8ICU4+Pc/7W2nIpgbgqdSJYsr7+X2Jn4bOS2qOz58HG7sSjzcUWmR0uVaNhVgRAHCVJL95zg9uBvnRXmiIpOPVlttfhX8rxafWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjYHreFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162C2C4CEE0;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381200;
	bh=ORSEn+B9SzOpd0/AL3CBTF/ZpRsAEqz4d839A5gC5sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjYHreFMEJABi8rm5iwHj/RrmcCk0Kf/PHA4n30wzpI04KjU2pFZznzl/JtuRD4YT
	 oAHVBCD/B3D6Rd4B5JDx70+PJMcmFiz2HBD9NAc9YqvnHnJY6eimoKtxbSdaSsUq+M
	 0lbriXS903tC2MF8tAxEb34yhr+ijfgSt5fP4gNPfRri53555OBVeFV5az+Fa/MfhP
	 YfuW2W0Mg2MgwAtTAxxC4sBoEOjILPGsKpXDJYDDoFp1BYSF8FtXw1zSuZ779i+9kh
	 38yhplX2dr6iACG/XKnvmXnbTLXdZTZBvaqHVFyrG4wKR53OoVxU+ZzYpEf7Od+eQz
	 1X3WJtOcS3Dog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 58FE3CE2AA7; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/11] refscale: Add srcu_read_lock_lite() support using "srcu-lite"
Date: Tue,  3 Sep 2024 09:33:18 -0700
Message-Id: <20240903163318.480678-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
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
 kernel/rcu/refscale.c | 54 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index be66e5a67ee19..9a392822cd5a7 100644
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
@@ -1133,27 +1163,25 @@ ref_scale_init(void)
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
-	}
-	if (i == ARRAY_SIZE(scale_ops)) {
-		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
-		pr_alert("rcu-scale types:");
-		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
+	} if (i == ARRAY_SIZE(scale_ops)) {
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


