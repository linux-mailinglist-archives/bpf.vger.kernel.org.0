Return-Path: <bpf+bounces-65800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F907B28906
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B743AB8F6
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C831EA80;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9OiDTq1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC629478;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302761; cv=none; b=uYgD/aD07IRKnEmIscgZRwXKwnnojmHz00fFF+j66g4RCgE2IaWiCkYqPSmYuDZK77HIGUYZzaw4z6EuBGM7CZs8KrpL3GMEZRW4o5eMq4YmV64jao4Phm2kVM0JCddH2xj2D/8ye+sj8zNG8hatmINJMdTgcgJzT3Kalro9cCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302761; c=relaxed/simple;
	bh=pvHoXIq/XZZkE26WZ9PeQrCmEPRe5uY95ng191EMoZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfl30zfYhyt8N1qsHhKBaJ1xaq0yTgPxkONAZA+bAMZuH/N+OEmadJPJUiBWzjCLXM5AQwA8RHGmogNDAZ7ETuvAUxYwdnOdE29hr47I6Lay6iBb94VBESS4CMpf70at2hiN23vEULbjE1hWOApCzWDlUJrMUI2ehRUQqR6RaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9OiDTq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46135C4CEF4;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302761;
	bh=pvHoXIq/XZZkE26WZ9PeQrCmEPRe5uY95ng191EMoZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9OiDTq1hkz7FglPboA2M+TXIoQPEBTp3KbyJC2a0njYKMcI35pqvyrM11VApJkTh
	 zxExpCsvCB8V/v8B5buo8zqa5BMvZ1jLP0ihcgVBguLtQIqbOChfqIu/EqoEu+uVhv
	 D9jODUyNbVdzxZ3GCtZeoDqCHy+6MR+El8kQ3hySVgMxkLrKR+5fSvPlTQcMFl+1rY
	 hU2+7T1YmkO2J8xfyoaD/lKwiWqbsQsTSpV3LoKkrIWFXJSBr/tL3laUI1534J3RF1
	 U+XqN/uAa1LaMEskZv3metAc6p+XTCIA9xFX5UIBshR1+nIz0/OGl/E9bMfJ57EXmD
	 ZpTR3+yVzHVNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 830C7CE0B2D; Fri, 15 Aug 2025 17:06:00 -0700 (PDT)
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
Subject: [PATCH v6 1/6] srcu: Move rcu_is_watching() checks to srcu_read_{,un}lock_fast()
Date: Fri, 15 Aug 2025 17:05:54 -0700
Message-Id: <20250816000559.2622626-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
References: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
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
index f179700fecafb8..478c73d067f7d3 100644
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
index bf44d8d1e69eab..043b5a67ef71eb 100644
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


