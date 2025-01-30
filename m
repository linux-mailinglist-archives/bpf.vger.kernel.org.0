Return-Path: <bpf+bounces-50148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E3A23457
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378243A6CDC
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EA1F2391;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPW4joMO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92F1F130A;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=Id5ScfQ37eiYRGjlyqt5FD0k3D/LIJxsmnPaCle4cq5wetka4HeBHf1pSpYIGJ/UENhuS1w3MwO8BkN1z/TxhVNYLma/taWmGY+cP3zDvFo2iJSdYNCn+y3E2O6Ma/U7tGq5fCflHqqaF2I++0fNc8XYA0ag4LhVxTiDRdggLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=JMjVn7hGBwLqe/AJTTND/j6yiSqNT/VZe/53RMnXCO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fErFczgpms5z92aetjupz2eI5+X4aVr2IuiEjzC53lcdmingSEGUFShPprcedshPcKpKT8W2IVV7Y7Pbj8wOXZSbJaVQwhtzQ6xL5C67K8Qkcoy2SK1qmy2UzRpqJTLm4DstxJuE3PP/iuBXBm2IRXfwBtOGv+9wHgiu7n67AK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPW4joMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A635C4CEF0;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=JMjVn7hGBwLqe/AJTTND/j6yiSqNT/VZe/53RMnXCO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPW4joMO3CNVIOSuedcuy/4wW/WWT5yvuHOwSEC+0imJYhVQmFUhNfr5Js1oMBgx0
	 cq4aKwwpNxMTGrE4YvCU2LRsEyFYgpLQoFgZaKr9MKsBtwVKm+CgZGsypHQouhh8UH
	 dO+r+6JiGFEwsJNY1f6dkeS7zLrUQw4+UVbLXGZ1hQyLfAh+EIFD6/KExYgHjcCS2o
	 wroFBfjGsji6QvlzCVHPFXMni+XUS4sg4MY+SCt8IIE2AKUAF+nZmtzacSW8e6Eqj3
	 e8MWR+uDwTazhT3T1GD6AHQEyF2iEg12OrJH8Z1yhFy5Wjd4tOoPuWTK+7PSn/gY23
	 qrUvsgFNX6AvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC8B5CE37EA; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 10/20] srcu: Pull pointer-to-integer conversion into __srcu_ptr_to_ctr()
Date: Thu, 30 Jan 2025 11:03:07 -0800
Message-Id: <20250130190317.1652481-10-paulmck@kernel.org>
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

This commit abstracts the srcu_read_lock*() pointer-to-integer conversion
into a new __srcu_ptr_to_ctr().  This will be used in rcutorture for
testing an srcu_read_lock_fast() that returns a pointer rather than
an integer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 9 ++++++++-
 kernel/rcu/srcutree.c    | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e29cc57eac81..f41bb3a55a04 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -211,6 +211,13 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+// Converts a per-CPU pointer to an ->srcu_ctrs[] array element to that
+// element's index.
+static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
+{
+	return scpp - &ssp->sda->srcu_ctrs[0];
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
@@ -228,7 +235,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
 	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 973e49d04f4f..4643a8ed7e32 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,7 +753,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 
 	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -783,7 +783,7 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 
 	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return scpp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scpp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
-- 
2.40.1


