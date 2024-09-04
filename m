Return-Path: <bpf+bounces-38901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583EE96C46E
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBD1C20B3C
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3391E0B78;
	Wed,  4 Sep 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1XC0cEM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21901DCB26;
	Wed,  4 Sep 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468739; cv=none; b=uxqSAbpRSLY7QkMGDJZ4PaAQH/JaJB/0kO13qa44oIr9iMigb50I/1MgwcaGnBp77eqS3eRkxayTrJVuGZdsksCi7tSESqXEfhgKOWSzEo0dW4bvnPaSTB+yDp9gbzKMA3FCfzbu9EhShO6HSSs4sjI7FhRaWcJdxfBz2KVT64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468739; c=relaxed/simple;
	bh=RGoONpYhc5Jj+VJ2EHBXmVJCVocOOPXD8LyLnGTVIis=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S51BeJy6ny3/AQiHnYvbWkloei+umR1kl9RBp1zs9U90B+cbrJKmHXJBWcxHw9bWORiDQaEhqbwXmYfZUSXw/BYHsEP/jz7z/6UWd3z0JsZHR6a13p3WHfOaktUk+si7Oaq2wfhZkKaf67uSdU7RfDQntYhOFkgrxfeRHcssuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1XC0cEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDB1C4CEC2;
	Wed,  4 Sep 2024 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725468739;
	bh=RGoONpYhc5Jj+VJ2EHBXmVJCVocOOPXD8LyLnGTVIis=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=u1XC0cEMsnqo0n5hqzL/cowvT1eQHgx1kTrn9333VW0ZCr9uhU/sm1d48l67e9ByA
	 AlEIue46+woBXyNYfSrzEWBR5NolpN6SW2/kG9kNMjYuDWx1U4BwUHKBgC6gASPOvH
	 fQ1kLM/UTEMeELseqFotWI6uSoSLv6DemocUpM0nOCGIjz7DX4gOOMOglmFaj3kczq
	 7FD6zHJ+60HtvjEXklSX0SvVQHlAD+DuTNBmyf3toEv7fA8tMOCjZ2zQmN3w85Tz+O
	 RM6jY6bpo3mglJQJGIUPNjqkpDOSlrKgL43HLTRM+3nd2q8UxPXqBFSNxX8gYYcSGy
	 Y8SwU9RowwL0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C71C3CE0FED; Wed,  4 Sep 2024 09:52:18 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:52:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH rcu [12/11] srcu: Allow inlining of
 __srcu_read_{,un}lock_lite()
Message-ID: <2821abf8-c9ce-4fed-aa58-710ad4f67b8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>

srcu: Allow inlining of __srcu_read_{,un}lock_lite()

This commit moves __srcu_read_lock_lite() and __srcu_read_unlock_lite()
into include/linux/srcu.h and marks them "static inline" so that they
can be inlined into srcu_read_lock_lite() and srcu_read_unlock_lite(),
respectively.  They are not hand-inlined due to Tree SRCU and Tiny SRCU
having different implementations.

Please note that this is early days for this series, and especially for
this particular patch.  Moving these functions from the seclusion of
kernel/rcu/srcutree.c to the more widely exposed include/linux/srcutree.h
might have #include consequences on some yet-as-unsuspected architecture
or combination of Kconfig options.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8074138cbd624..778eb61542e18 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -209,4 +209,43 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns an index that must be passed to the matching
+ * srcu_read_unlock_lite().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
+{
+	int idx;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return idx;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_lite(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
+}
+
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bab888e86b9bb..124ad43c189d6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -763,47 +763,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
-/*
- * Counts the new reader in the appropriate per-CPU element of the
- * srcu_struct.  Returns an index that must be passed to the matching
- * srcu_read_unlock_lite().
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-int __srcu_read_lock_lite(struct srcu_struct *ssp)
-{
-	int idx;
-
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
-	barrier(); /* Avoid leaking the critical section. */
-	return idx;
-}
-EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
-
-/*
- * Removes the count for the old reader from the appropriate
- * per-CPU element of the srcu_struct.  Note that this may well be a
- * different CPU than that which was incremented by the corresponding
- * srcu_read_lock_lite(), but it must be within the same task.
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-{
-	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
-}
-EXPORT_SYMBOL_GPL(__srcu_read_unlock_lite);
-
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 
 /*

