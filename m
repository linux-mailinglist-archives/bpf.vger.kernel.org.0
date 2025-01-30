Return-Path: <bpf+bounces-50153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B269A2345D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F339C1630BC
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3E1F2C33;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCaBaHb+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC431F1510;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=O45jaa4B1e7XzBbArEKZumtd4sJqKj3zjN5zgb94GTgOW3tdYahMc27iHwLSmEW7mw8Z+HWO1NMgD+kxRRcuG+KOF1pgmEQwPi8XwXL7eAEnLqUh3tfKWZDAREcMxRx2LoXdGcLhRfNJT1SQSgdepc5QwRw3c0Kx6Kne9h3GcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=Hvqt6DoNLiwnHyQde4NsCplDkrMKpMldpmk4TAf6AK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mw/SBNIJQvAnfjfiPTwEpX+q3t64XOoH3IF4tzkhiofYDas97Zj+eao/Isfj1RXb/bvq2AS1hGE+4eFXKLrd1F97EXhJtD3yTV32lBWDZbJ2eMealH7VhmmkZX/Z/HnsZu6CAy6+IomxWRBsVadY3IQTetb726lvPh1wdQCKzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCaBaHb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A158DC4CEF5;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=Hvqt6DoNLiwnHyQde4NsCplDkrMKpMldpmk4TAf6AK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCaBaHb+gorxKIECeYN+mWyeQ1wkME0aQU+44jygHAXvHAJ3jBJ8C1bvt5tdHD8Cb
	 JOoYk0eh+et7aqicun0OKvVkEHavAdbnJb1OpIGdzo3KLVzuKqbwGuQMgPyQWPEP3/
	 mF1pjloFRu9QgFupxZYvD75NB36mUrKae5p0VTvOSM8YciphhYJI21nOGigh1GtE9s
	 GHPEzpZhTgO8nsMK1eK6/JfInviOrDBiKAp7nG6uW6A6Vf8/uutLHOL/8VG5XJ5Wqk
	 SV1QSfWyn7u5ft0sNOAzJTKHxUZ3sosDxrCm37myAhzevZZtX0f5c/3YbK8AzePUCG
	 urIWxrPlm2O6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EF5BCCE37F3; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 11/20] srcu: Pull integer-to-pointer conversion into __srcu_ctr_to_ptr()
Date: Thu, 30 Jan 2025 11:03:08 -0800
Message-Id: <20250130190317.1652481-11-paulmck@kernel.org>
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

This commit abstracts the srcu_read_unlock*() integer-to-pointer
conversion into a new __srcu_ctr_to_ptr().  This will be used
in rcutorture for testing an srcu_read_unlock_fast() that avoids
array-indexing overhead by taking a pointer rather than an integer.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 9 ++++++++-
 kernel/rcu/srcutree.c    | 6 ++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index f41bb3a55a04..55fa400624bb 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -218,6 +218,13 @@ static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __
 	return scpp - &ssp->sda->srcu_ctrs[0];
 }
 
+// Converts an integer to a per-CPU pointer to the corresponding
+// ->srcu_ctrs[] array element.
+static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ssp, int idx)
+{
+	return &ssp->sda->srcu_ctrs[idx];
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
@@ -252,7 +259,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);  /* Z */
+	this_cpu_inc(__srcu_ctr_to_ptr(ssp, idx)->srcu_unlocks.counter);  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
 }
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4643a8ed7e32..d2a694944553 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -765,7 +765,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);
+	this_cpu_inc(__srcu_ctr_to_ptr(ssp, idx)->srcu_unlocks.counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -794,10 +794,8 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
  */
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 {
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
-
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
-	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_unlocks);
+	atomic_long_inc(&raw_cpu_ptr(__srcu_ctr_to_ptr(ssp, idx))->srcu_unlocks);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
-- 
2.40.1


