Return-Path: <bpf+bounces-44634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E949C5C0F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D8BB825A5
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC463200BB3;
	Tue, 12 Nov 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U91YU9b6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399491FF056;
	Tue, 12 Nov 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423150; cv=none; b=CRffaEMkr1ylxt/+x5aR+8K+hXrqkcdAQZJZWShjRsVEGJRwtCOvszTtybRn+VAjoIJnurow45PoeCo0Rfhhc6ysfTkYinP4L3rjEpKm9DgUKuLR8VxkxqsfPTj9F/nfz+OIuKVhsVaxmsXrnPPfXRpGzdyRkvP3feISW4JfYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423150; c=relaxed/simple;
	bh=QJOH44h7yAycsL8NQ2uV4M+pwPZccjc5Vep5GFxRuxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7hHsLTdJZ1rgaRYt+ulvfmHXqO6bQBFoODDVqDEWiXxKeNyIeNSYLN+TFfSGeqJh+CKLPaoqXFLcyXEPXtHANBtk574OpNVPSU9pn9JDAhS8tJzfsPtQtsTw7+segxjgOUjg810yebUH5rr5C7VSKes0NPZbOGRsTVuQ5u9nCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U91YU9b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBF3C4CECD;
	Tue, 12 Nov 2024 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423150;
	bh=QJOH44h7yAycsL8NQ2uV4M+pwPZccjc5Vep5GFxRuxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U91YU9b6TSi3vNs1qAwTlqUkUE5tp6I/w1TxduxAySrONB5SrOuDu6lghpnAWjFm2
	 2klk3QUsTT0OvHf2CA/Fezc8uMzqNrKcoE3e0bEMV+JntBCkZru6qVJ1SlWe6KJFuA
	 9kCpjGq7hXYQ6m77potKf3lONXQ7VZlEKFEceKkBL3/Qsqd82J5HKO5DuExkmMJIkU
	 JrchAsaDmllSLBD7Hhb6OQxbP41yLjKQYFbdxcJ0xq7QZhZWLmgRNOSrq9TCNbQOIQ
	 wbVzygkFB4hFPW95Z7alW9bxsnByjEycomRcsroJx+FsEYU/SkqrNGOO8gEuhZWC7x
	 dMnoLQqzaKkKA==
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
Subject: [PATCH 06/16] srcu: Standardize srcu_data pointers to "sdp" and similar
Date: Tue, 12 Nov 2024 15:51:49 +0100
Message-ID: <20241112145159.23032-7-frederic@kernel.org>
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

This commit changes a few "cpuc" variables to "sdp" to align with usage
elsewhere.

[ paulmck: Apply Neeraj Upadhyay feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/srcutree.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9774bc500de5..b85da944d794 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
 	}
 	return sum;
 }
@@ -456,11 +456,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
-			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
+			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
@@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
-		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
 	}
 	return sum;
 }
-- 
2.46.0


