Return-Path: <bpf+bounces-50143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54305A23450
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F223A5A58
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733BD1F1533;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0DeSL/E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74411F12ED;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263799; cv=none; b=VQHYHcJbz+HghH2mLkFDba4s7e5c9prUrvDVJ8YeDiZV8zU0WoDZXfz1OBz1sAMnXGmo+R7JjSDqGKhs/4J5AruzXFBjAnDTHsx4wuaCIxtMiRqRSzyR5qaCHnhjJ+LDJqKx0aOcmnfjNjf3vcor2MYbuI6GZqCqG36CU90gRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263799; c=relaxed/simple;
	bh=GV/xWCoZFid0mpIVbI9fDNnzQrsXcfIeUz8m8HN20LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiUZ+PzXgMkKiB8YF02bMkI+qBb0c9CvzoXwV6/dHrtuorD89iiSWUaARz05FX/5DDW/k+joFWTCg4rEnKcFQ4ugIME2r13Br4Ph6DvRe5azh2xUZGKgGAVchA9dadszaLXyv5GTLppgs0mEkzaQCnqishSJFcnieo5FBL5FIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0DeSL/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A286C4CEE9;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=GV/xWCoZFid0mpIVbI9fDNnzQrsXcfIeUz8m8HN20LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0DeSL/EfQxlGjsUmoBCDDToOzUVjDtISaw7tchV+TesO+xYEyO24XUZeJCiyff1V
	 QMBre7KafH6lEvw/on/KSz7ctMpBJa5+ua5cNa3qXqOgb8MoOyCqoXqXz0uKn7Uwxe
	 fCmeXkpqaJdbmAs04jFRQzGyZenisF+fKqfuv6bmHCEXZpIIcc/ZoBkXirF74UWegK
	 xGucB0J6DEImghuKl5dL8UciVu0BcUfOGAZtfxOsCBsQWHki34N0fET4JeLf3hcc5p
	 v6thqj1LknDp7Cqk8xBox8hLS61luKznkiUxyVuY3ujRIylku3Zu8iq2gKwCG7ioDj
	 90gR0IFAtHsEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DDFFCCE37DF; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 05/20] srcu: Make SRCU readers use ->srcu_ctrs for counter selection
Date: Thu, 30 Jan 2025 11:03:02 -0800
Message-Id: <20250130190317.1652481-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
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
index c794d599db5c..1b01ced61a45 100644
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
index d4e9cd917a69..9af86ce2dd24 100644
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


