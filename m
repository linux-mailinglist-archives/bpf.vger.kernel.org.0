Return-Path: <bpf+bounces-41770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1A99AA90
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AAD284DFC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE61D0155;
	Fri, 11 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ2hdvVT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC31C9B97;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=uguEun9STXNTjAQhmkXPao6ZLWBy3OuqC4AmHGQoUT/l7ORyr17sEACR4hpzHqVlMIOiPV53Tj93s3L6Pwy5xVFkaWBnD43jmGjMDeek9T/+kFAua2EqBpczlJNLAXs58B31q8iC+QYSfbtvqGQ6jwpCA02l0tRGVyj3qqstcts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=ShAY23PXWJnTwN9m3aELbGSryO452AQIXFVffiHUjJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJz9TsROkCFsVzCyPLFJ9Ctc0knsHok5Iyx+5fVAv1AJ2QTMlMTRVWfv8rOH9j9O8JQqAfmqSgl+V/ghrc0npzDtCYyvTrhy+Xhx8lt27V0A2rNUwWFQU/vLiTQy1KATml8eA7UnTgEX06Sfkc6zBVd4+E47D/WJvlQEwKotGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ2hdvVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0D5C4CEDF;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=ShAY23PXWJnTwN9m3aELbGSryO452AQIXFVffiHUjJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZ2hdvVT0seSG7P9xAp+Nfp1Cy6Rc+ziKChMFejj4pIc0mrXe0g5jULUHzjt7mlPP
	 rRQu1Ze3UPmPQ+Se3f27pjFL99b7v0K/yD63UbKadhzN0/BNM6buzq5kUXqEg/TJPw
	 rdxgnSSTZYn11tlHhsYaQY7+D9wWKOs9NpCuMIzro+u6RWslj7KMZIgfzLgLmHm+i0
	 bhBfQiBc6Bn0iFHApB8WK3DfmTJWyPvQQBGIpXeXa3Pp1CtYpAlnJzljPvuPiu1+ff
	 4fz3hbFScFXgVVBfHdqH927XZnTNjX10qfVbbmVjV/1PKCpXiUUC15IBh26eyC09/e
	 5oTCbLg0JfanA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B8907CE0FA0; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
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
Subject: [PATCH v2 rcu 12/13] refscale: Add srcu_read_lock_lite() support using "srcu-lite"
Date: Fri, 11 Oct 2024 10:39:30 -0700
Message-Id: <20241011173931.2050422-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
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


