Return-Path: <bpf+bounces-69404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A7AB96360
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADCA19C48B9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0224BBE4;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUibeIJt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583ED23D7DE;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637296; cv=none; b=HzAmTYB9DX/Sn/o0uu+kzMIbQjF9FloKLaAhg5ovnFxhwy6R7Bl2Es5VOqeryumRnfBteaXktjJhEEOelYrhpwo+awbXlBsKZTrf7J4ssF7ooEX7MYcQUDO7LgAvXCzw1fWDMjzo47znkZ9l/sB15qYTKXIZ7QLOg1V/jVmC5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637296; c=relaxed/simple;
	bh=tGrdv4Ck+rLWm+HN+jcwDBzUoYqwe2sdQlV4IgJA9RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhRULcqwEIeMUZYHxrpA+Au2W/7nYJMHvbe+5PDCteEykshL/HTvkNjfblXNjadB1RkgFQw2rdtmsqbCfiYDgtJoUqwfIHx8Jl60qHoUBQHgc4RNBiHPpG1QVtT5IyuDnWnXTE6VTuTZ4I8pSxActrhJ9BbApkmqkoNkJg0xJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUibeIJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6D6C116C6;
	Tue, 23 Sep 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637296;
	bh=tGrdv4Ck+rLWm+HN+jcwDBzUoYqwe2sdQlV4IgJA9RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUibeIJt/wqdPZLe9AI0KGHncnoL+JeQiFLJdbp6I7qDqXV2wT/VS1Qvr6tP3zxWz
	 Mc3hE8M31wH9b3yJGiD8zuKDfYHU6c60zJkYKvdhDsBlCLGw0LY3EOXdZ/bqcdCXtR
	 qduLK80KKrp4h//haoid6++l/+qiTgDngdcGg67TPT3TllpfS3OLEWsk+vauqCEkK1
	 3htGb1D33khli0dTd9WwWYuVa0RovDagtASHQhn1bLAhr7JoX4k3qFkFaklKwTHFQV
	 510w3O5LLND1GqAE3Q5onwfTnxY52JKTwbZCyDf6PFcPVual1nNC6UCm51dCMQtNfJ
	 NsUHidnEDRbcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 172BDCE18F1; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 32/34] srcu: Require special srcu_struct define/init for SRCU-fast readers
Date: Tue, 23 Sep 2025 07:20:34 -0700
Message-Id: <20250923142036.112290-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds CONFIG_PROVE_RCU=y checking to enforce the new rule that
srcu_struct structures passed to srcu_read_lock_fast() and other SRCU-fast
read-side markers be either initialized with init_srcu_struct_fast()
on the one hand or defined using either DEFINE_SRCU_FAST() or
DEFINE_STATIC_SRCU_FAST().  This will enable removal of the non-debug
read-side checks from srcu_read_lock_fast() and friends, which on my
laptop provides a 25% speedup (which admittedly amounts to about half
a nanosecond, but when tracing fastpaths...)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h  | 34 ++++++++++++++++++++++------------
 kernel/rcu/srcutree.c |  1 +
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 26de47820c58cd..2982b5a6930fa6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -271,17 +271,26 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
  * @ssp: srcu_struct in which to register the new reader.
  *
  * Enter an SRCU read-side critical section, but for a light-weight
- * smp_mb()-free reader.  See srcu_read_lock() for more information.
- *
- * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
- * then none of the other flavors may be used, whether before, during,
- * or after.  Note that grace-period auto-expediting is disabled for _fast
- * srcu_struct structures because auto-expedited grace periods invoke
- * synchronize_rcu_expedited(), IPIs and all.
- *
- * Note that srcu_read_lock_fast() can be invoked only from those contexts
- * where RCU is watching, that is, from contexts where it would be legal
- * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.  This
+ * function is NMI-safe, in a manner similar to srcu_read_lock_nmisafe().
+ *
+ * For srcu_read_lock_fast() to be used on an srcu_struct structure,
+ * that structure must have been defined using either DEFINE_SRCU_FAST()
+ * or DEFINE_STATIC_SRCU_FAST() on the one hand or initialized with
+ * init_srcu_struct_fast() on the other.  Such an srcu_struct structure
+ * cannot be passed to any non-fast variant of srcu_read_{,un}lock() or
+ * srcu_{down,up}_read().  In kernels built with CONFIG_PROVE_RCU=y,
+ * __srcu_check_read_flavor() will complain bitterly if you ignore this
+ * restriction.
+ *
+ * Grace-period auto-expediting is disabled for SRCU-fast srcu_struct
+ * structures because SRCU-fast expedited grace periods invoke
+ * synchronize_rcu_expedited(), IPIs and all.  If you need expedited
+ * SRCU-fast grace periods, use synchronize_srcu_expedited().
+ *
+ * The srcu_read_lock_fast() function can be invoked only from those
+ * contexts where RCU is watching, that is, from contexts where it would
+ * be legal to invoke rcu_read_lock().  Otherwise, lockdep will complain.
  */
 static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
@@ -317,7 +326,8 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  * srcu_down_read() for more information.
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
- * and srcu_read_lock_fast().
+ * and srcu_read_lock_fast().  However, the same definition/initialization
+ * requirements called out for srcu_read_lock_safe() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
 {
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8a871976c37dfe..204edd2801c21b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -766,6 +766,7 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	WARN_ON_ONCE(ssp->srcu_reader_flavor && read_flavor != ssp->srcu_reader_flavor);
 	WARN_ON_ONCE(old_read_flavor && ssp->srcu_reader_flavor &&
 		     old_read_flavor != ssp->srcu_reader_flavor);
+	WARN_ON_ONCE(read_flavor == SRCU_READ_FLAVOR_FAST && !ssp->srcu_reader_flavor);
 	if (!old_read_flavor) {
 		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
 		if (!old_read_flavor)
-- 
2.40.1


