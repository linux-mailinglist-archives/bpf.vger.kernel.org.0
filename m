Return-Path: <bpf+bounces-42078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F199F26F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63CE1F2311B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA81FAF0E;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VluLbv0D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94491F76D9;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008675; cv=none; b=oWd1GegFrMEitlPMFmfNom/67P3sAiWAetkAQvAleXQNJbs62q9p8a7vZYeTuM9NwaKXIK6SmstkJureM+qQEoLe0StAb96zD/8JjCu+BlitDPxER70swJlL+PHwpjld0DIeWAtDKHovc06O0Z6AwthMBF1S+EyzeSoE4G71m7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008675; c=relaxed/simple;
	bh=USWy1f2+MRE4E6Ag+HiaCUvOKEVnE9SJTDypoSyYrTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8zmlbRPLWDW94Ci6OuDHBoiuFEjVeOJT1dso/IK5x1TkWYw8JxfCRkLrFUqK8UWJigpWy3LJAm1vgJyu7gCHcqMhgyiCXnQqOfUM27vTqOp9P0EJLqUK5Tb8IPdvPd8R4Bq8pFaG3hoYt9It39T2rQ+HCZdX83PligwSMgP1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VluLbv0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DAFC4CEE4;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=USWy1f2+MRE4E6Ag+HiaCUvOKEVnE9SJTDypoSyYrTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VluLbv0DeB/aePpRB2If4lR9PZW2xAiiLjEKlpvhbZYRhtKBvek4K8DIwRWS7DVKv
	 wNQidWf2fSt5/42jtGoFKqZCWU6JHqAWBx6eB+jmwMLHIWjlD6K/zy0wonIGVBA3Rc
	 SJVSamA/SawXue+wuT8PGVj5w1yyDZDiAUfKraWI9ElF4SDWQQXtRyH0ckXL+9B/Zl
	 uzCKheq7oTkLWOiwo/PdDCvuNZhEpPCAIzpaXxi393dPJ7DxDgX3DI1LggSxyTbpHO
	 m/B14GCYJwLH/3dh9/kfExnjwz/lQQ/AYq+TBS3v/aKzQmyO7263Cn1wwq++it6bQ1
	 sNHIDtV1kX26A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CF578CE16F0; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
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
Subject: [PATCH rcu 11/15] rcutorture: Add reader_flavor parameter for SRCU readers
Date: Tue, 15 Oct 2024 09:11:08 -0700
Message-Id: <20241015161112.442758-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
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
index 1518343bbe223..52922727006fc 100644
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
index f96ab98f8182f..405decec33677 100644
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
2.40.1


