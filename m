Return-Path: <bpf+bounces-38796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DB596A483
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3AD1C24113
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4319006E;
	Tue,  3 Sep 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi4Kr189"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BE18E043;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=GrYU8HwGRmvUeA2E7Xx6JW4ZXwMFKTignB12+FuZ2li02XNiNoD0D20gJnekQA5IO2lA3dOlDs4mnwao4tqu4b6nhQTIVdy7Gd53hUF11pxE62iIa7hp/e34NTBvzuMFBHLRMZ54Up+fgPkmMiRltwXBU+RDaT9z1ikS0MZQvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=uKR68c+V4pJy0YKy7y9IE8aC7SiIn/4UU6r9rgwqIV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5rrNGHMlUjHx+anQzawKD2F2TAwa5LbZQe7pxmlRMHFYINwlfB/akYaBirYl9mwLPtsKrGL6qi47FI4mzVc7j6JHdAYGq/4fdHjn7svwYf92IaN5PCc5SH3Ek+pp/zn54xgNp9apQggAIJ/1tlMSwuzya4chZIwiX8lzcEKW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi4Kr189; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072B1C4CEDA;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381200;
	bh=uKR68c+V4pJy0YKy7y9IE8aC7SiIn/4UU6r9rgwqIV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fi4Kr1893E/gJv5nIJGg3xwC/TAzxDDZaTKiztQqIqk8cfnNRSIKzVLggSfXkpz7d
	 JTIoTj1TkseUovjTJ/rRDB3CnLLM1NrckoVLXrMFy36gZsLtL7NIRDyPsdaQd1gpi5
	 M1NXZx/Vhv5s9P6REN1HBzpH3KisAYmyEsqL3WSJXuio2yoSahF48YD3oQJsaLWBIh
	 DGwGoimj5gJK89uop38M2XBt8D8igW6zzqTZjaO5Cfp/cSS6yxfhiiVD2gyr+xZUrn
	 iAZ2zOzrpeIwZRj6elGJo+NWfExsJV/CdeB8ZNGMEHcCo2L8swCLtPdrgFr6LrOSmS
	 Vu1fEIi39XaFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5340CCE2A89; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
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
Subject: [PATCH rcu 09/11] rcutorture: Add reader_flavor parameter for SRCU readers
Date: Tue,  3 Sep 2024 09:33:16 -0700
Message-Id: <20240903163318.480678-9-paulmck@kernel.org>
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
index f8f0800852585..e107c82f0b21b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5352,6 +5352,14 @@
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
index d883f01407178..1a3e0fdca7139 100644
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
@@ -2399,6 +2411,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
+		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
@@ -2411,6 +2424,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
+		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis);
 }
-- 
2.40.1


