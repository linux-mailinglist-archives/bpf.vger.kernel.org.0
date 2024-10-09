Return-Path: <bpf+bounces-41471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365C997425
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF761C2448C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF541E283B;
	Wed,  9 Oct 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIebKXLR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CD1E1C06;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497242; cv=none; b=shN8k6ZFxGfqq7cBdTRUowp9nz2d/Kc1pgpKlOrSV/Cr9rQIGD05g+EoXOudnaWwm9OFG/VjYQdJHUYyuFgDziGusH5P4AZpcT0/xYVqQBBDercECZ4kLs8huUisIxEU8wBvUXt9iahpT/L7QOQCHfjDnTSabwSAK/8xmTQ1KGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497242; c=relaxed/simple;
	bh=fJSvDPbs5qEe3xzeWqWg6cC0gjZ2F5XS48/PJ5m/X38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DppF1/R3wd7nVk5cTtcA44SIMC/Z+R+3j0WATyW+wtZDgFbznooZXWsLxrLvwD2FeCulURM3mVPMP/3Rv0dC0/hTLnbI2IuchEZ1nn1TuXFDeeTpX61TomrnwEzTkm0mBXJ3TdwD/zl0zGWrSeVzQM3tKVATHZi/Iu+6PpNNlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIebKXLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F9BC4CEE2;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=fJSvDPbs5qEe3xzeWqWg6cC0gjZ2F5XS48/PJ5m/X38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIebKXLRBvuGkKsUXQp3OUpXr4QkO4OifoHojg5c6FpRqIe8J+1Cm3ubv3rMhbh2B
	 3RileIR4LzHrqZMx1H0jLs59/FC1WibWZyEstgc7+N/1bRkC7tIicYSr0U4QjFfXFV
	 CF/x8efgx9UPPQSJnM+WakwXapvWFFybFmL5XUrlJk1gAN0NMaJDLaFus1wnZao1Y2
	 UBRPbVF+Ejnl2CQusdrvY84v2+S+jX4Iso2sVyziNM9pOY7NXIJfLT1d1PS0AoLjXM
	 h6haaafswXNwSADUYq3Ezy5Arf9rVtHE+zebxi6PIi6MgE818FYnDTvCBPWDZG7GXB
	 JzUdItZrQEGxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2991CCE1408; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
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
Subject: [PATCH rcu 09/12] rcutorture: Add reader_flavor parameter for SRCU readers
Date: Wed,  9 Oct 2024 11:07:16 -0700
Message-Id: <20241009180719.778285-9-paulmck@kernel.org>
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

This commit adds an rcutorture.reader_flavor parameter whose bits
correspond to reader flavors.  For example, SRCU's readers are 0x1 for
normal and 0x2 for NMI-safe.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++++
 kernel/rcu/rcutorture.c                       | 30 ++++++++++++++-----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7edc5a5ba9c98..2d5a09ff6449b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5421,6 +5421,14 @@
 			The delay, in seconds, between successive
 			read-then-exit testing episodes.
 
+	rcutorture.reader_flavor= [KNL]
+			A bit mask indicating which readers to use.
+			If there is more than one bit set, the readers
+			are entered from low-order bit up, and are
+			exited in the opposite order.  For SRCU, the
+			0x1 bit is normal readers and the 0x2 bit is
+			for NMI-safe readers.
+
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
 			allows some CPUs to go into dyntick-idle mode
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ea71a23b45d8b..daf60c988299d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -111,6 +111,7 @@ torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disab
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
+torture_param(int, reader_flavor, 0x1, "Reader flavors to use, one per bit.");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -646,10 +647,20 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
 
 static int srcu_torture_read_lock(void)
 {
-	if (cur_ops == &srcud_ops)
-		return srcu_read_lock_nmisafe(srcu_ctlp);
-	else
-		return srcu_read_lock(srcu_ctlp);
+	int idx;
+	int ret = 0;
+
+	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7)) {
+		idx = srcu_read_lock(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx;
+	}
+	if (reader_flavor & 0x2) {
+		idx = srcu_read_lock_nmisafe(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 1;
+	}
+	return ret;
 }
 
 static void
@@ -673,10 +684,11 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
 static void srcu_torture_read_unlock(int idx)
 {
-	if (cur_ops == &srcud_ops)
-		srcu_read_unlock_nmisafe(srcu_ctlp, idx);
-	else
-		srcu_read_unlock(srcu_ctlp, idx);
+	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & 0x2)
+		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
+	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7))
+		srcu_read_unlock(srcu_ctlp, idx & 0x1);
 }
 
 static int torture_srcu_read_lock_held(void)
@@ -2404,6 +2416,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
+		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
@@ -2416,6 +2429,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
+		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis);
 }
-- 
2.40.1


