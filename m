Return-Path: <bpf+bounces-73278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60EC2976C
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2FF14E31AD
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B12252904;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUhFNUhU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362D244693;
	Sun,  2 Nov 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119878; cv=none; b=LksKexR9M90QpqLpssD/Sr9IqjiX1q9c2+IMs9Q1h6LAzaHtJJgGq8p2X9N/ymtper+x02IG7iYah/tkGlHeKmWPOmTH/InVF6/Dkbo/kMVaK0CqinqCTFwuZh1uD2sLdgf4EVU2IawvQlhM45VGU0axVZzBeUoiH3Mr6Z+h2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119878; c=relaxed/simple;
	bh=MZmvN2dS91ATVvwCaKa51PWDnZiCJGVXmJf2Q3doHC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQAf88UpUTRHP+Mn7Xiso7/sTdwjdzP7wa1dK9wGpsNHQAsg0DxsDqjQRzTgT3ndY6MoT3qbO3MViQzYlyyMRd11O7h+TWjTokBNB4eyWVt21/diZQOuDSDE2iImW4pkPpOhs/KH7ttdVkKLLimjOtu5ZeheWLY9l2izUSy/CcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUhFNUhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CD1C113D0;
	Sun,  2 Nov 2025 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119878;
	bh=MZmvN2dS91ATVvwCaKa51PWDnZiCJGVXmJf2Q3doHC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUhFNUhU6PsLXIhM6mDZX4XJV0ggyvdfkkIxVBcQisnQN/djlHGan60y62tWZK9Fh
	 bVPQX0b0nwRWEca9g6/EJj67emEjOCykJD/kYDNhl5DflBLsy4T4VNiP/gzZtYRwUS
	 rQYkOTC51E4KprOlDRVWJ25bVKLq24neMKZBKHNZDWpcFP3hq6nWb1or96vFAiqL4p
	 F8V+CRaxViLW0X/9oCqx0peu8Jwd5ANqDBaxnqq7/QLydMstPcs6qjMsHks81M4wae
	 sWrqhP59bg5Z0juENowamugvp+rPeHOY3GD8qGw+Aevvpmq+dR5b06jZyF8CRJXZ+j
	 fa8PYAZ3KyLwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C4C4CE1257; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 08/19] srcu: Make SRCU-fast readers enforce use of SRCU-fast definition/init
Date: Sun,  2 Nov 2025 13:44:25 -0800
Message-Id: <20251102214436.3905633-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
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


