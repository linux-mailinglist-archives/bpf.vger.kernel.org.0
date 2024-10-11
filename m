Return-Path: <bpf+bounces-41760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD099AA84
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EADB236CE
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FE1CEE86;
	Fri, 11 Oct 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnyJ0mPn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D61BE86E;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=VE7sbfkFiZXatFItYEYDTHBvHf2A6rbrxpwpKTCsPWG/e1oSH2daQhV6T6zxWcfxdOvIBG4FcJK+930B+KycSVs4pKv2rCFRcpHOum3drvp3QYuroFqaKSy0WLqggD0gVRQp8/vQB3s1np/yWwee2Yy2TtDgt7GEdhV9j1gLZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjoP/cqx4o8EzUiXXPfc6oluqWs4MDLTDPwRUTzDI7BNUw+eGnjy3s+ASYOWaPS0TYBDcKHxhooG2h013HVzU9JwuL9GhFcs/byCbxMydvjzaKoN2NBuMr5vIoeatxeR50w3jFQZ4qn6RRdmYhAAjHQsVmj8wHKjN517D0vE0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnyJ0mPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CE3C4CECE;
	Fri, 11 Oct 2024 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnyJ0mPn2Mju9oCnyXhNKnku/qSFeWAAZ6DUyXDP0ok1IcZsp2GZrj7eR6/Gq32Sc
	 9rlDtu66GRN/b4PC31YGdIuOK1bp7mKJlxlRyWBlL77A5T312HTNK3mDgbVTit4WZo
	 RBKnW7vJkrT+y0cd/fYsPLddZjLN9ZksJOhmFmKtYSTdfXKapP40q3REtQTtnVOazn
	 MpEu4vZ3G9xnmhfsn4bFJlVTBezcpggpyRzNCEHzYUp9cgIGCggNrQLW2Agadt8xWa
	 Tf4/AfEVolX/7k0gRmZ2B3qw73nD+sW8egkB0Jl3PZM3cMfWfX0+9FSoqg0YU+d2QW
	 TEi51Dk/1bN6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C27DCE0BB3; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
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
Subject: [PATCH v2 rcu 02/13] srcu: Introduce srcu_gp_is_expedited() helper function
Date: Fri, 11 Oct 2024 10:39:20 -0700
Message-Id: <20241011173931.2050422-2-paulmck@kernel.org>
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

Even though the open-coded expressions usually fit on one line, this
commit replaces them with a call to a new srcu_gp_is_expedited()
helper function in order to improve readability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9ff4ded609ba5..e29c6cbffbcb0 100644
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
2.40.1


