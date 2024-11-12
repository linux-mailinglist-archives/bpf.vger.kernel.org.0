Return-Path: <bpf+bounces-44639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51D9C5B0A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C011E281299
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809E20262B;
	Tue, 12 Nov 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfbzR/zI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956D1FC7FF;
	Tue, 12 Nov 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423175; cv=none; b=bdXk2PJH71nGFkBuT7pz44HZEJfBYB8YCq7cYAXUk+NcCie8P/4/dOlGg6ZIV4UFsTe2DrsPvAlFbZpaqKgqpzuf9xaYI5GjjVRSANf/sUdS8X1TfdWrypJ9M2/h+EXOffA5Jp0Vr/cjqfMS+juEQVW9x0KSyX/c4hs8PJ8SJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423175; c=relaxed/simple;
	bh=nwvp2zP98ddDicB9bTU8Bfx4YUep7GYbMP51FFzAyzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwife1PDpoyOUTVsivN/b2OeowlTtCrEcpFlZPaBcr4IvADongW4OgcMdoz6kYZ7WNZ21w/yjzAeyn6rbKxz5ja9apN3Bv/ht6OnZUSxfrilrZeriQtZYCsefuQ/3FT1s8a9yWkrXtozgwMp8yFigqZVz2y9+C/BxpJTJWNbRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfbzR/zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A4EC4CED5;
	Tue, 12 Nov 2024 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423174;
	bh=nwvp2zP98ddDicB9bTU8Bfx4YUep7GYbMP51FFzAyzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfbzR/zIwPybRU4kHWdRwXJC90OaHRePLkpfDo6BXICoCko2XfJ3ITVSRCo8f57pY
	 EOoVZySC+3ln6C3ei5iOL3L9IFMINF6htbqW2Vc/vWhqHlV77Of2B/ogmT3RNauq5C
	 k28UrH8JTCg+VWkxxuQwMqyN03puoGx0gfvTQDJWaFAfBu3IiYaAWvqqXm1qF6cqrk
	 YtWcJeM3U61O1M0+fAej6UgO5+s7LcwJoXkjda1NUG1V7e+qUOgtcXxKApmmuNnZQ8
	 irl2ywmN84qDYqB4ECwqWTH34DY8jZ/g2hvwxTXvM25DKAbIzEv+dRFVmhUgk3qQ+x
	 sYDC3FEKB45iA==
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
Subject: [PATCH 12/16] rcutorture: Add reader_flavor parameter for SRCU readers
Date: Tue, 12 Nov 2024 15:51:55 +0100
Message-ID: <20241112145159.23032-13-frederic@kernel.org>
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

This commit adds an rcutorture.reader_flavor parameter whose bits
correspond to reader flavors.  For example, SRCU's readers are 0x1 for
normal and 0x2 for NMI-safe.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++++
 kernel/rcu/rcutorture.c                       | 30 ++++++++++++++-----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..52922727006f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5426,6 +5426,14 @@
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
index f96ab98f8182..405decec3367 100644
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
@@ -644,10 +645,20 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
 
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
@@ -671,10 +682,11 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
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
@@ -2389,6 +2401,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
+		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
 		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
@@ -2401,6 +2414,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
+		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
 		 test_nmis);
 }
-- 
2.46.0


