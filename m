Return-Path: <bpf+bounces-49102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E177A14307
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F4D3A7FB0
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF88242252;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDkFYGRW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F6241685;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=sK3P/VXYpIwYVci0jMjzHStuCeSAu1QRFX+R6aS4wjcCGeAiUmc3YiaTAO30cWBTGo5W7+6fWyFdYN2qwkDqbLFAIAzubQJq5nEuyp1El/jjVz9dQ36DJOMIdlowgrolZsiPFOTuyGsF2hzZZyM7wzGUusKd3Y1bDRwt1cx+tZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=pL1/Lgx7fk6aIW5sHuHV7UEq+eyS6XB5BVEwlDIVglQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/3QiBblyMKDskQEA/XHwqE8kXumkf0g1PVcLduUb5Phy87Y9BCet7ihBeUsNpceUBWQ/E3xhvLzMQ9+7hQmqtI/XKRd94t8iZBTCZzGpAK1XTq12xseKwII7pxyqUtEixnxmFZ/tkJk2vkwMl4bSzyNwSh46x/bc1xEzc8/Kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDkFYGRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD4C4CEE9;
	Thu, 16 Jan 2025 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=pL1/Lgx7fk6aIW5sHuHV7UEq+eyS6XB5BVEwlDIVglQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SDkFYGRWeK+T0nHPVLoFcz57JLXQ2scfvgISoxzSQ6eRNmggPcq0K8ouIr1//C/9/
	 u/R5VJqUg9V1wfKOYnqNxSPi36sD98P3DhjCc49iq0X827OePgc8ZHi2zFx0703GNR
	 JAiPhT2hj6SoYkPpcPHxTqNadX0NeRbwliu8AdJ80XpDk8o13xuC151scj2b9d/1JU
	 00IyAxTnll2vzOwRT4VwKXEsWIYcjan8y77pncm68D0G278XDgaTV2za/fLHfHzseu
	 iblw/AdeOJKy2Uq0PHtQncEkehC9IaGIGKCmmpIy6PM2JzMc2oUbnUud7Gh6M1m9Xz
	 ryvlJq/ntY/Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C838CE37C1; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 05/17] srcu: Make SRCU readers use ->srcu_ctrs for counter selection
Date: Thu, 16 Jan 2025 12:21:00 -0800
Message-Id: <20250116202112.3783327-5-paulmck@kernel.org>
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

This commit causes SRCU readers to use ->srcu_ctrs for counter
selection instead of ->srcu_idx.  This takes another step towards
array-indexing-free SRCU readers.

[ paulmck: Apply kernel test robot feedback. ]

Co-developed-by: Z qiang <qiang.zhang1211@gmail.com>
Signed-off-by: Z qiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h |  9 +++++----
 kernel/rcu/srcutree.c    | 23 +++++++++++++----------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index c794d599db5c1..1b01ced61a45b 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -101,6 +101,7 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
+	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	struct lockdep_map dep_map;
 	struct srcu_usage *srcu_sup;		/* Update-side data. */
@@ -167,6 +168,7 @@ struct srcu_struct {
 #define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
 {												\
 	.sda = &pcpu_name,									\
+	.srcu_ctrp = &pcpu_name.srcu_ctrs[0],							\
 	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 }
 
@@ -222,13 +224,12 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
  */
 static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
+	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d4e9cd917a69f..9af86ce2dd248 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -253,8 +253,10 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
 	ssp->srcu_sup->sda_is_static = is_static;
-	if (!is_static)
+	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
+	}
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
@@ -742,12 +744,11 @@ EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
+	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -772,13 +773,12 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 {
-	int idx;
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+	struct srcu_ctr __percpu *scpp = READ_ONCE(ssp->srcu_ctrp);
+	struct srcu_ctr *scp = raw_cpu_ptr(scpp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
+	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scpp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
@@ -1152,6 +1152,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
+	WRITE_ONCE(ssp->srcu_ctrp,
+		   &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
@@ -2004,6 +2006,7 @@ static int srcu_module_coming(struct module *mod)
 		ssp->sda = alloc_percpu(struct srcu_data);
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
 	}
 	return 0;
 }
-- 
2.40.1


