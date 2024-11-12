Return-Path: <bpf+bounces-44642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85B9C5B13
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831081F22144
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5852200114;
	Tue, 12 Nov 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsLl9uQv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36908202F9E;
	Tue, 12 Nov 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423188; cv=none; b=I0Q8hUOnP5j6qgP2hsyCK5dmVkJHie6c+fwYEoXl0Z+GEoGWhxDZa1HPAlxuXEuXU4REaDjiRpT3VENeayLSVMBrty2MkIvhun8Tp5hgAeDMLKJCvmsu1S46sso7pDaV4uiF5M5eUtET1alrNAg5X/M28Qnlg03ynoyF7+Miges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423188; c=relaxed/simple;
	bh=DSNbca3lQ8LSXso6jqYZBWuI3HmmlzLJZscELXWEgfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPdN6G9DxNiLLsoT5gv5afnOVDfNVbsuvFyrhHpnHutiv4C/ZwBG6M59t64DNxSUgwEz3mXcw7ouGGuvKFPVEB9SnPQJZ+ru4zYNIuZm88Gf3VtYN+Mh/wV0C7bWb7rWVy08YHpU0KOwXZPq+fhA0AJT/dDTrldm1gDfIrI9pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsLl9uQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F2BC4CEDB;
	Tue, 12 Nov 2024 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423187;
	bh=DSNbca3lQ8LSXso6jqYZBWuI3HmmlzLJZscELXWEgfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsLl9uQvLt8thmWmeMZSNMaub4BZv51O5iIP//APEUCfgN+bjQ1CZ0MVStIZmS3b+
	 hu13ktakC0BZhufXS5q+zV6kXHDF5BfegCMlNst9SX4dJV5SHY/2IQkl8TTMw2VXVB
	 8EYtfrQ/3ifIbHLbEKFzAVvlt8FXyjb8f72itSwXtENX0m3Pga+QZ+BwltzddhfucA
	 LV/oJmR7CyqxJ7H2n+MIcfvhTV9IU/0m6VvXTv9K1M08knmIFXVzelFXEp/6H+RdNm
	 ijMQrQmvib3MXp2qmJ9SVrRKFVuSbr1ffRdXmc5f6qboI0ZKmPR171otuGyYSf17uk
	 S9O9wym6AR+NQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 15/16] refscale: Add srcu_read_lock_lite() support using "srcu-lite"
Date: Tue, 12 Nov 2024 15:51:58 +0100
Message-ID: <20241112145159.23032-16-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit creates a new srcu-lite option for the refscale.scale_type
module parameter that selects srcu_read_lock_lite() and
srcu_read_unlock_lite().

[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/refscale.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 0db9db73f57f..338e7c5ac44a 100644
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
@@ -1082,9 +1112,10 @@ ref_scale_init(void)
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
-- 
2.46.0


