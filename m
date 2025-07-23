Return-Path: <bpf+bounces-64213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C52B0FB6D
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F5B1665CC
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E7238149;
	Wed, 23 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHLoX8Wa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34E230BEE;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302484; cv=none; b=SAeRWxpkwpo6SB5r7zGldi400iSAewFmBPBqTgO2739BlcWGEc0gBD08Lxlfh5BTB2i/Cc+l6xovJZQOxrrfP94IvkrI/0LqKiB8jeBfi7nY3UkujtTFeNxfxf8sjo0eaqH6ROzGq0RUnsyPN8FqDb74H13ffEBZMJ94n0HA83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302484; c=relaxed/simple;
	bh=bLAjkr0rM9XAbo8UHtiwK4eJ6EnmjrJMGttjy+b6bi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbRF2UhUFThtLQo9Mjpz2p2L3jdGMbqhwoGaldBha2c6y8Vy0fRsHRqX5QEmbzxSGGr7WISDToM3kew/iDlBOqVb6DE0xUXHREJr2f3MCpeq0d3TrmI9Mmxo7teDaRWjnv5Sjy5ICfVZxW/mfsxzOTnmhxXFFIM+WZbkwhD1nqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHLoX8Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C8BC4CEE7;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302484;
	bh=bLAjkr0rM9XAbo8UHtiwK4eJ6EnmjrJMGttjy+b6bi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHLoX8WaSr8rGPNBsi/CR4rvQbKi79eO2QNAIQxa//G3uQz6Cc0seeeZo+YhUqvWn
	 X9EPzvAwn3wfZCEXCOytFxekbTunm3elUGhlNzd8AVzk1mf/2iX9Ley7vU4X+qkwDP
	 kwoDEsYgXv3/42e7EXuFzreErA38xfyTVi3O6Kk3qvfvZvmWJ9dLUiHVj9gD15IO4r
	 fTzNPviaLWhzubYbVKMmN7TUdm8dGPKm9grhl2a1fm3Nj4mYs+VYYJXX69X39R8LKh
	 K77safqG4BOEHDhTpmlBVIDYoar0wPp+3PUYUHB7WZbmkyOYCqXr3r1HltN2jPwXly
	 AdNDx0rxs2S/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04E89CE08DF; Wed, 23 Jul 2025 13:28:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/6] srcu: Move rcu_is_watching() checks to srcu_read_{,un}lock_fast()
Date: Wed, 23 Jul 2025 13:27:55 -0700
Message-Id: <20250723202800.2094614-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_is_watching() warnings are currently in the SRCU-tree
implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
However, this makes it difficult to create _notrace variants of
srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
srcu_down_read_fast(), and srcu_up_read_fast().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 4 ++++
 include/linux/srcutree.h | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f179700fecafb..478c73d067f7d 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -275,6 +275,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 {
 	struct srcu_ctr __percpu *retval;
 
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	retval = __srcu_read_lock_fast(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
@@ -295,6 +296,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_down_read_fast().");
 	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
 	return __srcu_read_lock_fast(ssp);
 }
@@ -389,6 +391,7 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 /**
@@ -405,6 +408,7 @@ static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
 	__srcu_read_unlock_fast(ssp, scp);
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_up_read_fast().");
 }
 
 /**
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index bf44d8d1e69ea..043b5a67ef71e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -244,7 +244,6 @@ static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
 		this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	else
@@ -275,7 +274,6 @@ static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_
 		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
 	else
 		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-- 
2.40.1


