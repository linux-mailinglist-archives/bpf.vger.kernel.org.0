Return-Path: <bpf+bounces-44631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563CB9C5AF2
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC861F229FF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D802200121;
	Tue, 12 Nov 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9DUX3WW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13620010B;
	Tue, 12 Nov 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423138; cv=none; b=blvAE/txZHXtUw72M2Hd68zBZ6d/ZgLeSA39OGz2r7mYYeUTYJVzsSsRzsbseUOzH+TlrP1VgdboQexrdjTe4Hehuf39FA9cy+wfASEBngPGalkO+/tSnvcHd1rpXDIRQLycgbe/tp2IRuvD09U4bjsTfTyg/0HvGzb4pq4WWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423138; c=relaxed/simple;
	bh=5UY7zE2xDmZ/aGLmtXPVX1tGAih/WdNZc9gDIB70zsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0ebkmKRY8lLRsXIwTYy9w+Ol4zzpbEK2G2IvP+vSbgpHBxRBu1y6E1SJG4gPZqR0m1LgWx2slKBxYeFfMjPOYm4Q4cxjx5t0SRWwP90XNytfKJ+5BHyd/Rj0qiQ/xK+YCWsFMzZeLsG6eU/IJ48nCcqPdlTCbmJdrsUd3JlvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9DUX3WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09482C4CECD;
	Tue, 12 Nov 2024 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423137;
	bh=5UY7zE2xDmZ/aGLmtXPVX1tGAih/WdNZc9gDIB70zsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9DUX3WWJRRloLMHnjLBrMjIzfxWmhraywqbrSLtMP0pBdcsgVNveghEZEOFsYsTS
	 hiaTF3uRo5BmUl1IBbRoX6BrqaBSMxn0gdTIQHOmsCLWTW31LBfPGhzr9A8hJm5l+w
	 Q9tY4WQzCw+FuP7F0PCK3N9N/pmDmEpElM0JkqH757udj3UTKyyZOpw8m6Ly3eJ9Jg
	 gdZbrYV/FHpEKiiapcrlHqRD8S+iSRcH6QRaEj5NguI5pRBvvHF+xizCu5b3hbjZdJ
	 tR+SE4e19PF7tFidMBIpFeZd2zyHFX5GYAri4VhHEdIJqfSfW08qgV9UadYaNcHk0X
	 ex/f0xvtrPdGg==
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
Subject: [PATCH 03/16] srcu: Introduce srcu_gp_is_expedited() helper function
Date: Tue, 12 Nov 2024 15:51:46 +0100
Message-ID: <20241112145159.23032-4-frederic@kernel.org>
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

Even though the open-coded expressions usually fit on one line, this
commit replaces them with a call to a new srcu_gp_is_expedited()
helper function in order to improve readability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2fe0abade9c0..5b1a315f77bc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -418,6 +418,16 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
+/*
+ * Is the current or any upcoming grace period to be expedited?
+ */
+static bool srcu_gp_is_expedited(struct srcu_struct *ssp)
+{
+	struct srcu_usage *sup = ssp->srcu_sup;
+
+	return ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp));
+}
+
 /*
  * Returns approximate total of the readers' ->srcu_lock_count[] values
  * for the rank of per-CPU counters specified by idx.
@@ -622,7 +632,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
+	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
 		j = jiffies - 1;
@@ -867,7 +877,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	spin_lock_irq_rcu_node(sup);
 	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
+	if (srcu_gp_is_expedited(ssp))
 		cbdelay = 0;
 
 	WRITE_ONCE(sup->srcu_last_gp_end, ktime_get_mono_fast_ns());
-- 
2.46.0


