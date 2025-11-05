Return-Path: <bpf+bounces-73724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C2C37BFE
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D60274F7374
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20B34DB4E;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQgi5fxR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672734AB1C;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=RD7PJ3LLlsWJr6dG0YKz7Mf1P5XBppJVYxAUNfURCGxISf/q8KYYSeKFdAp++HmxR4BvlDnjwP/RZLKlsknL9lljIKllWoIB8j4XmwiiSjjNGX4j6S6y9q/UeOdbmnvEv6I0jIzo/nQd0DlRjxGjsfWDem5KRdYNpylaU6601p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=MZmvN2dS91ATVvwCaKa51PWDnZiCJGVXmJf2Q3doHC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hln0L4p7r1bqWk/0D64Ki07vEvAQkYxTVvC92Cm8DbHGz0A7zAVWedAJlvYAl+Esvr70cvREgj86k70w8vQ5HGcC722JSCHgimo1ECAg+AumoKELxkyJ1CzmNCWXAZ0pFmHPW8KrlcHKUUPevfcuRbYXB+fyrrBLcRlLeG7OnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQgi5fxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADDFC4AF0C;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=MZmvN2dS91ATVvwCaKa51PWDnZiCJGVXmJf2Q3doHC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQgi5fxR5PnrnjE9tykMd/2rpgOQ3qY2iIK4XVLA2X5khMkAPigAY2KTHP4pDomK6
	 I0tUH7i9ex4SxbivNVt/0mK2uGBWmD6weNBXpMFi3qESqGpjgrv7cPaYXcWqPHKs2o
	 QYo55dC6FmT5uVB50KueuWZJCZcm3JriQ8FxecR0LOso0bdDMsIZ/nD450AtJPV5VM
	 +cdGmurTFNDxR2u9hJWqCCoMi0cY1aC7oKCsFKmTE04XbHf2GnghHNgCTp5Tjm6b7G
	 nGl5lDwYvi97C7/tCNIO+b9emJYX+x9qTUHj/0NwNfngPxadTDMLV3rkBpNrtMMJ9g
	 /wIhNv5IbIsgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9950ACE0F65; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 08/16] srcu: Make SRCU-fast readers enforce use of SRCU-fast definition/init
Date: Wed,  5 Nov 2025 12:32:08 -0800
Message-Id: <20251105203216.2701005-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes CONFIG_PROVE_RCU=y kernels enforce the new rule
that srcu_struct structures that are passed to srcu_read_lock_fast()
and other SRCU-fast read-side markers be either initialized with
init_srcu_struct_fast() on the one hand or defined with DEFINE_SRCU_FAST()
or DEFINE_STATIC_SRCU_FAST() on the other.

This eliminates the read-side test that was formerly included in
srcu_read_lock_fast() and friends, speeding these primitives up by
about 25% (admittedly only about half of a nanosecond, but when tracing
on fastpaths...)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     |  6 +++---
 include/linux/srcutiny.h |  1 -
 include/linux/srcutree.h | 16 +---------------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 2982b5a6930f..41e27c1d917d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -297,7 +297,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	struct srcu_ctr __percpu *retval;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -312,7 +312,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
 {
 	struct srcu_ctr __percpu *retval;
 
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	return retval;
 }
@@ -333,7 +333,7 @@ static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
-	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	return __srcu_read_lock_fast(ssp);
 }
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 92e6ab53398f..1ecc3393fb26 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -112,7 +112,6 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 
 static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
-#define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 7ff4a11bc5a3..6080a9094618 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -307,21 +307,7 @@ __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
-// Record reader usage even for CONFIG_PROVE_RCU=n kernels.  This is
-// needed only for flavors that require grace-period smp_mb() calls to be
-// promoted to synchronize_rcu().
-static inline void srcu_check_read_flavor_force(struct srcu_struct *ssp, int read_flavor)
-{
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
-
-	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & read_flavor))
-		return;
-
-	// Note that the cmpxchg() in __srcu_check_read_flavor() is fully ordered.
-	__srcu_check_read_flavor(ssp, read_flavor);
-}
-
-// Record non-_lite() usage only for CONFIG_PROVE_RCU=y kernels.
+// Record SRCU-reader usage type only for CONFIG_PROVE_RCU=y kernels.
 static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-- 
2.40.1


