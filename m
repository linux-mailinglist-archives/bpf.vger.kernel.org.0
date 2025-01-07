Return-Path: <bpf+bounces-48105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06469A0416F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC46D18875A0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26581F37C4;
	Tue,  7 Jan 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYdijnxF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DE1F2C38;
	Tue,  7 Jan 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258429; cv=none; b=Y/Nv3C34Rp6S98Aj9qZg7iLvRTPk2Qncn6er56Tmv97qSMQIJsfduiZzWVSuTWJdwY14+vAJ1dHuGS4r4RpXxM+kHLEpSD3L4TuZ5GU3Pg1fhh2woHP9AGlDTxB/xPF2r7FNdjw9+a1eyV6KT0lOY4JEylncecmOjAAQha4HkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258429; c=relaxed/simple;
	bh=A6BHHwSDGZxil39BCj+tpzF00ye2bwkndcWT1dWcfPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMCzfsz32TAyDTJQj65/4QxfN5eaiigGQK+N/YRWaa82YdmRK7StKYW/xDaUcXJ29zjKNZz4tDBEb9JZBs77/Bs1LIrP0jnW2k+0TaCmUNDMxi0deZHdYAHKshw5BAuRz7yk9PDecllJk3Uo/vsPAVFrie8NmOXKQANwMPzHLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYdijnxF; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-385eed29d17so7425923f8f.0;
        Tue, 07 Jan 2025 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258422; x=1736863222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTnzMjvTX9PnixeDb/QJMwtogTLFCd+4yLgtlaH77/k=;
        b=UYdijnxF53y6eyCUrvdkwMUWJujLBPIM81AUOl1R4iHOMYGzfhb+vlpfZsGEMh1f93
         4+JQjuogC62QiYol9RC2SwwZb/EiG7TlllIVW9EFGv/NIX1Z1++8/SIVGvBfDRNrs7Ep
         eqNiVgQYq2bQBk5FtNPZx9Y2lyB2tQDyTiIfwdeTsjM/ZpAP8sy6Qnzo+Z0wCAmlI/59
         wJw7F2iqxD/ipc3KPyFMTJkbrRbqW2DYHN4jy037AYDMoSzaupXk6IyIBOrGcU3PJH5s
         z0QVPyy6luXzOzR5IFdpk0AQbyCBbrwhrrzIf7ZAtVUuWg1hrqEnBBEJHLr0TxAH2nBM
         1D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258422; x=1736863222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTnzMjvTX9PnixeDb/QJMwtogTLFCd+4yLgtlaH77/k=;
        b=pbGWVSsNMSB3S9cloUEWRwHQRKdJ5TZ1vRQWDBFbRi/Y0cRIyv8Xd1dCxx7kcVijsf
         4wkPe0ZFDkbkdRKaRxvaDFlw55tnWyivWv+eE+RD0xMTA3rx9F8VGW3Tvc3qhaTyCslt
         Vk0GYT9M+ml3tL4i64XsB5KK24zWcIVt8rfCQhVkEQcrnwRjsh5mnmqza36awtpyn1Ox
         hSfa+1D//2+AIg2amY1FXNKWQvKshijP35zz/EgWaPvx80cojLOTpJAOvMQFYiXFIsVx
         lmh033ZPFOKU/V/qCeVWBjz5ox5Nmg85O2MOK2m0hxRx8jTBRu+wNVNyqTGy3t69b3H0
         Wz5w==
X-Forwarded-Encrypted: i=1; AJvYcCUceFow4B8LOA3X8bLTcLnYbm+p2o6Qhlgh4z9QwWEcRQgWMV6Foxkgbmaf2RAL7wSVHbbf6J5/za8t3gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXrwptRzb2AFxQql224GndxPpLf82ZcXaqQ58qiwCdFwuj3zU
	5yyHs4ktagDCNlAaWub0sPm8I+2qSaXex/d1fNwGrWjet1GEYjgM+m/U7s5vcqwHfw==
X-Gm-Gg: ASbGncuzLmCpZGw7mZy4mWUWc741QGF1GR8A+vie4iDIGiSckYJwqJJTdcf0m2++64Y
	HQ5cZV9ZxQXFRhWLdoPfncaWx8y61Cm8234Fg6ngU2vQVXwUjxOKte1PjkROGqW7Ha51Xy58+qw
	dl+sA4o5v6WfB3y3np2lGfVtVi7Fjwd/7qxFBpycG2NJOd92tn/LmGMG348khZnLfVFgTzyrgxh
	XBEch3vrJLOJF+uu1CFzr3Bu/TJzeSmC0BDR7d1GJsN9N0=
X-Google-Smtp-Source: AGHT+IHbtviyqxBl7c1L8MU/GwBDVrdaPEaDF6MwBXfI0O5tMtuU/Xq44c7pMTK+/rsL3T0ooXlakQ==
X-Received: by 2002:a5d:47c8:0:b0:385:f470:c2e1 with SMTP id ffacd0b85a97d-38a221e2f49mr51032448f8f.2.1736258422100;
        Tue, 07 Jan 2025 06:00:22 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:10::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm50400353f8f.61.2025.01.07.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:21 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/22] rqspinlock: Protect pending bit owners from stalls
Date: Tue,  7 Jan 2025 05:59:50 -0800
Message-ID: <20250107140004.2732830-9-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; h=from:subject; bh=A6BHHwSDGZxil39BCj+tpzF00ye2bwkndcWT1dWcfPI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCdyyu7Mfh83I9m8FVMYzvYUcbFbHtdjpbRNpaL FhDZMdOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8RylnnD/ 9mm9iqO78Iqz7RiZh5jUB1BxqwxazQw/vDBoz50U3d3TVVllnh4QiyH7MdiNxmM26YLDhltB9BDHrc Ppi99o8iKdVAS7M0uyE4m0pkX7PXa8C3sZxQdVPJNWTUDJR70mdqubhbj6je5KzC4G8bqnG9sj/2nn oeOdgP4Ot1VnAmya13OglO8DgPWdHebSD5iXzirtb6GDwOWpSTPALQjNqiQRjW4o/pJr5eJLk/dCv7 bAbWoMKsv9aW8eRhCwaY9MQVmQSccLwV6v7c4SBz0QQxs/xqgHvb/vd9jOaLJwdOTebhX+MX4ULiMw vSTNHvMtInrUCifywL4LbyBcr4TfowXAsUJJQRhjC7PC/yqLH5D1HUXWV+pq38KyKxlpCC4CPy+gq3 yTdLnPxZI1Z6YxWnJK5QilrMiMR5qN3achUpq64zcZ76vOQEtH5Gsp3dcsTqrLkK1bFe0hrTYhXWqc RktOzqC6O83gXVpDdtQfoEN19/oM3ava4k+XmPYa2jGyzjSL+/qc9YOSV+UZ/0kCoyWQcsPq/2Th1W RmxWzFEFPBzRlHYQPu69mhloAozAy8gvVzRNNPTinXZB3xG81e7OY5+q5ZUju37g+vn6X/KlQPdkBB lgIybkmfPXIw9BXxE0b1PbVNKS2CKt5jrbFu/kMCSbpoJlQbj2xEhAo3Te3A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The pending bit is used to avoid queueing in case the lock is
uncontended, and has demonstrated benefits for the 2 contender scenario,
esp. on x86. In case the pending bit is acquired and we wait for the
locked bit to disappear, we may get stuck due to the lock owner not
making progress. Hence, this waiting loop must be protected with a
timeout check.

To perform a graceful recovery once we decide to abort our lock
acquisition attempt in this case, we must unset the pending bit since we
own it. All waiters undoing their changes and exiting gracefully allows
the lock word to be restored to the unlocked state once all participants
(owner, waiters) have been recovered, and the lock remains usable.
Hence, set the pending bit back to zero before returning to the caller.

Introduce a lockevent (rqspinlock_lock_timeout) to capture timeout
event statistics.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h  |  2 +-
 kernel/locking/lock_events_list.h |  5 +++++
 kernel/locking/rqspinlock.c       | 28 +++++++++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 8ed266f4e70b..5c996a82e75f 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -19,6 +19,6 @@ struct qspinlock;
  */
 #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
 
-extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
+extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..c5286249994d 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -49,6 +49,11 @@ LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
 LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
 #endif /* CONFIG_QUEUED_SPINLOCKS */
 
+/*
+ * Locking events for Resilient Queued Spin Lock
+ */
+LOCK_EVENT(rqspinlock_lock_timeout)	/* # of locking ops that timeout	*/
+
 /*
  * Locking events for rwsem
  */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 815feb24d512..dd305573db13 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -138,12 +138,12 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout)
+int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	int idx, ret = 0;
 	u32 old, tail;
-	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -201,8 +201,25 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 * clear_pending_set_locked() implementations imply full
 	 * barriers.
 	 */
-	if (val & _Q_LOCKED_MASK)
-		smp_cond_load_acquire(&lock->locked, !VAL);
+	if (val & _Q_LOCKED_MASK) {
+		RES_RESET_TIMEOUT(ts);
+		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
+	}
+
+	if (ret) {
+		/*
+		 * We waited for the locked bit to go back to 0, as the pending
+		 * waiter, but timed out. We need to clear the pending bit since
+		 * we own it. Once a stuck owner has been recovered, the lock
+		 * must be restored to a valid state, hence removing the pending
+		 * bit is necessary.
+		 *
+		 * *,1,* -> *,0,*
+		 */
+		clear_pending(lock);
+		lockevent_inc(rqspinlock_lock_timeout);
+		return ret;
+	}
 
 	/*
 	 * take ownership and clear the pending bit.
@@ -211,7 +228,7 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 */
 	clear_pending_set_locked(lock);
 	lockevent_inc(lock_pending);
-	return;
+	return 0;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -362,5 +379,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32
 	 * release the node
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
+	return 0;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
-- 
2.43.5


