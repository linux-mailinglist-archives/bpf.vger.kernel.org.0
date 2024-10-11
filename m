Return-Path: <bpf+bounces-41768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0176C99AA8F
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE2EB2402B
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270431D0143;
	Fri, 11 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWt70X3v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8691C8FC1;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=QiIagrMLGsIOFdQFsez8A/7GSGXUfbFk0T7s/yC1gOQHnbwraOqLxPn60aGQAyaz+f5ZO4HYn7dWoYOPNF8PPgZbAQXtGjWr/Q48k02hAaIV3zRA9JCPaqxUG7QYfBLnNNaqQV1q3n1YW95Giy+oogntqLshX4FXkkpg+qv3N/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=USWy1f2+MRE4E6Ag+HiaCUvOKEVnE9SJTDypoSyYrTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4qDN1q2r7u5I9FWNKgGVm0fPpGobyOAuX43/b3FTV2sv5GwBDc5Clfsh+Str8yF9EBr9+bXufxF88zYyVaFtVuZdGbZum4+Gx7NL3HeanryXZlUpseNfLVome6qzVEqMIhDrOgXHGut/I6QJSI4FmLdJeMNjA8kfvTC6K2DcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWt70X3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5471AC4CEE0;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=USWy1f2+MRE4E6Ag+HiaCUvOKEVnE9SJTDypoSyYrTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWt70X3vWL4k1++QjbqhK9UTXcYfoXrqaN3XJc2cMveljYcrGtmmVMtfq4zYc1jgp
	 dAc7XV0/Vj1QouUrgvGS9ytfnOkFnaVAiWd7/QvSOHo/GbggKfkhSEMm/FmG2pD4CZ
	 Te9OmCZCqufJ0miu62e84WhJClzHpmYoHJQ6dCxXQdWr8uADAYN73WLbkdcNTm6GuB
	 N5aUJRSNfJvJ1WGY8ib8FHlpkXgpx89wJprESjVSy+Frj98gaWgXDRwyHM+RV46Lab
	 ojj9QPzPhfRH8jKojCu37UiLAKCUZYFtDEeDiaVm/bGjy0LDrP82erJlflQhFoqigq
	 dxXb65Zf5uFCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B037ECE0F96; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
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
Subject: [PATCH v2 rcu 09/13] rcutorture: Add reader_flavor parameter for SRCU readers
Date: Fri, 11 Oct 2024 10:39:27 -0700
Message-Id: <20241011173931.2050422-9-paulmck@kernel.org>
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


