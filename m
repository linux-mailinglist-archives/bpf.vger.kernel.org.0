Return-Path: <bpf+bounces-49109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF7A14316
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A7616A995
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DDB24387E;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mApRL/Z9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C093B242240;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=Bj+HcAgj7oIlmV5rmGvDrXE6LK+5pqypg+0NpCqTUFltT1WM1CNL7EZh970T+vcXEwCVpajYeBjVktUeThbWfW/I13uQ5ZsaCTfFhBwy+MlCHpXimQya7bmwtkFzlArt7FC0r2G0/OmXyrnsx8xO0xz8fnJPPCver2Vjaq21sRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=F4djfqn8A/Pb1UhFQCW6zFEZ+HC21/X1BBN7u/MHvqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myS7ArDU2Go+LtyQCrRlO6yXzkovWRCR6VR1objhRb2ibFXJtPx+M6ODVc/f4FT5xfc7tFBJdGspQcCVxz8qbQdnJPTl4Zcax8sJfQxA88H/5eNdUQM81vDyFTk4s7b3Pku0Y7j2MhAM88UnIFf0PzrJuzo06khK1QgrA4QRVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mApRL/Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5556FC4CEF5;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=F4djfqn8A/Pb1UhFQCW6zFEZ+HC21/X1BBN7u/MHvqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mApRL/Z9n6zwPEprh17JaJ9/jJoPdtdwODQpkUIW9lpsmKXPc5s3Tu1OT0RxH1Kvm
	 Dsncby1c/Ve6Iofp2/kr8DUnqxb29glBt6aPKWoYJ4hPU06Spi7KaufI8qEv0O/Pam
	 e68w4h3yQ0LmnAH0UZYRE5sb19lIFvrh1Q4GqkQuDhQEUscuGKS9uEO+iTyhwa7crA
	 a0wep4/3y/OI63gswBIaunlIoSf3dnQCp7jvT01FH095U9Le9iO4a9iBAk/YA4xofW
	 HWNZElY5T3P2sFNJ9nyDcb2E/70n1XzQ0mCzT23yy3qjKNlr98cM7HhyoCR+etgMja
	 IbUzeZ3N/Vk8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B412CE37D8; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 11/17] srcu: Pull integer-to-pointer conversion into __srcu_ctr_to_ptr()
Date: Thu, 16 Jan 2025 12:21:06 -0800
Message-Id: <20250116202112.3783327-11-paulmck@kernel.org>
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
index f41bb3a55a048..55fa400624bb4 100644
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
index 4643a8ed7e326..d2a6949445538 100644
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


