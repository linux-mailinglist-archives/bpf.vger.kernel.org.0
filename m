Return-Path: <bpf+bounces-49111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC98A14311
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF98188B327
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B12442C1;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0v8+KM/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356424224C;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=RYD2iV+P0ZxrR8r2gC5iU+2ajaTn53yrV09p0s50rnCaVrcDOPNRuzzIophp7E1ltdkuBeiohqMm7Li6JIPgTMQGCi9HO3dS77JFJi97BEoNpq0m45yvMlD+LpEhJA7cUdj4y72FYb1XkqjT/s3qYbBN34s4iWov158ljwdQJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=bG4qKBMhSQIkQavcS9aqheWrdiR36LBjWLEYWEtdrVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2xXW6oJWH4nSs2A9VWWk/oHmPe0yfsTWuUleZzDyM14iXTH+HGMSlKLj4cbiUNoB8RjqRh9jVMMnHj6fM/gqgpxMJCuI+AHWK4r4fz26f0HJnRsj1DeT8QuZhhwETboTpVgu/JxzepvSufmi04oWnXT1NK639GC5M1H4MEow+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0v8+KM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1AAC4CEDD;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=bG4qKBMhSQIkQavcS9aqheWrdiR36LBjWLEYWEtdrVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0v8+KM/P1UA39NPguehW+6qihfUVZ4RJXk2VoQgIJeoEKNMnagRqCpcdVoDeVU55
	 GzX6futFwNq8/aGKUJQfZsqOqULQRJG+hIwSJz2GAypgQAiAiU6ATgGuSkYh2f4RkD
	 rzPKnJbfWd/31mEPxI6yHfDbbM6lddJX4JmRyxH2m2gis9Qg53eP/IZfBSJYrsPbAe
	 heA7GaiTlR4rxaxV++pElzlfEDXf9l4tAE6PWpu1uVl4QQ0ky0DnpXQmmwcku+KRnR
	 Noe5rr6mAS4QcgmpwGxIsQvk7ok0tPvpgeHIevwV0c5WHtSup3gAiOFPbWGf1qURGW
	 Kw3S32uv5p76A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A56AACE37DC; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 15/17] refscale: Add srcu_read_lock_fast() support using "srcu-fast"
Date: Thu, 16 Jan 2025 12:21:10 -0800
Message-Id: <20250116202112.3783327-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit creates a new srcu-fast option for the refscale.scale_type
module parameter that selects srcu_read_lock_fast() and
srcu_read_unlock_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/refscale.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 1b47376acdc40..f11a7c2af778c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -216,6 +216,36 @@ static const struct ref_scale_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+static void srcu_fast_ref_scale_read_section(const int nloops)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static void srcu_fast_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	struct srcu_ctr __percpu *scp;
+
+	for (i = nloops; i >= 0; i--) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock_fast(srcu_ctlp, scp);
+	}
+}
+
+static const struct ref_scale_ops srcu_fast_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_fast_ref_scale_read_section,
+	.delaysection	= srcu_fast_ref_scale_delay_section,
+	.name		= "srcu-fast"
+};
+
 static void srcu_lite_ref_scale_read_section(const int nloops)
 {
 	int i;
@@ -1163,7 +1193,7 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static const struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
+		&rcu_ops, &srcu_ops, &srcu_fast_ops, &srcu_lite_ops, RCU_TRACE_OPS RCU_TASKS_OPS
 		&refcnt_ops, &rwlock_ops, &rwsem_ops, &lock_ops, &lock_irq_ops,
 		&acqrel_ops, &sched_clock_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.40.1


