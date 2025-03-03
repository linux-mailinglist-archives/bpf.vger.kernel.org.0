Return-Path: <bpf+bounces-53078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097FA4C4FC
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE30174D3F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6D226888;
	Mon,  3 Mar 2025 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coviwiKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7921B9F1;
	Mon,  3 Mar 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015406; cv=none; b=rmSQlQJXrwjXacTui/LH/LCN0JCRk+6aQEi+5c/lhMvN3I5aCeBQvPkwKjQ+onRqqlGKmpKfaBygVdVV16r3o99yC/+eHSXhlaEpFgwjqIbubmn1cH1Cxl9dQcCUko69rWuWocjroXn1CCsWpAP8dnRqNVQi6pto9BfHcDR7ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015406; c=relaxed/simple;
	bh=1XvWGmZCOVeyUxqvFf8Y0s6SXxKLnF+WaHRbErsWH/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfJoSx7GfLR4KWXL9xnFnra6pSaeM/6XxFZzdp3jLy7gWiLxYWFg0rKNB7CSMo7jalQEtz9kyqtuLKDhRBHd0aKXFy5PmQVmSVvEclMezz87m/9Adk7vsOljY+2l3eSHAwC0Zso+/6Y6RhZZSH/l7ZBBIHUajgcRfzU3Sq/Ge4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coviwiKf; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-390df0138beso2442175f8f.0;
        Mon, 03 Mar 2025 07:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015402; x=1741620202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSHeNmV46kRt/dp4H0+hnJsEV9KJXQ8UwiwQeMlZ2+c=;
        b=coviwiKf8BvG3pKRk5I2UH0LUS0JqEWF6Q4VO+H0uI4xlrLbBElW8choyUqoBdPXmV
         8/OGXf+KGJ094ukTLMTNcDqRhZzYfMFlEUwfF8lByAa9WBfiJbPu5w5sRmcaYTQJqewS
         HX8FrkB0TlETmUGX5lXYTGDPmp0DEPiVOTIcxf84zDBMDDrfb3vcu/oa3BSxJ0rySoi2
         TBlgv4NTr3kqNgnL8VCOgTX2gj7XRNz0EgM0vyyl1pX98LwJzz0QhME+J4ESJgJdWPJE
         gwbUCG5FYr0n1u91JnvmUkRdZaokRu8ZEz9CG4s+/X5/xKbAXX5I/DpTElPGFe+WLL1Y
         REdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015402; x=1741620202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSHeNmV46kRt/dp4H0+hnJsEV9KJXQ8UwiwQeMlZ2+c=;
        b=UPMCCawzgLN1u73Y6FDenfFra4eeSHd3kSzMX5wyKS3Bo4ETj1CV30rXVYrEDfJiJ1
         CWRE5Se8dSw+zI34oGgYG9WeanJfYMBNotbjzY1YkbzF9Y5i/Q1yrZkGkGRkJQ3vQCVf
         s4UaCogyLbStSOFY2ClPJTrtMGVh4L3XtCHxIqCilueJomfz6DWKK9/GkcFcdIZ/wtDb
         kSbgMPc9B+qq+LEK/z1aC6FLQbD8IWamrM1+eIZE0ZmQmRTWkecehBR2Lc+hdo0zGliG
         2ki82wrvsryYoF2pbnr4kxCbHXHtkXgFRXxaai3fP3QAg+OLD+4r1Z0pBp9avRDZTeKj
         O8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFttPu1WrSjd4TIa2dKsNTZKeuLWMzveAs7+yW0kxSlt4ObtFSIsx0RGb0DiG5K4gQTJrijvx9PiyAsyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxTuFBYOUzI5U8vKCsQoB2MoITcm4FwJJQ+wbVUlSgw04vV/x
	q5VslEudZyDI2KK1b4ogmvC124jsbHyc+Tt63L/yMX5bLFqaab2jG+8gJXvPvTo=
X-Gm-Gg: ASbGncvOVHKb3YhT5JnofNHlqmIBPPHnCK6dQkxyds64Qe68Rj1r3gzvsNvga9JiYnZ
	krLfUmWrb/r+ZdB64+6XIJHd8Ve3amPZe15BzSAJfkgF4FI6V/TzN0px4GCelGDX2jsLZrvdkVH
	jclWzF/GFmannOMRGxSS8QwbuuedAY/wsVGnDTVp9w/oQvYtb5gzJQOkyZDehthDDCvP9e1A65l
	97rvNyaFmb2qS7fh293j3KWrkqRASEVCHXzOPQugV+euZR8vcSBS3TaHTKq+Tjaf5lc6ArH1cUL
	GYNwy2W+p1DO7ha4gezGV1xE0NnSvmUIKxI=
X-Google-Smtp-Source: AGHT+IEnT4A+TUqzNaTrtLXu5OtEH4QH2hmaxPGiGwoQEqitjFfl0aXZCCxloD3CNgY+V4T+aWGquw==
X-Received: by 2002:a05:6000:2c4:b0:390:fbba:e65e with SMTP id ffacd0b85a97d-390fbbb1ce1mr6065042f8f.32.1741015401792;
        Mon, 03 Mar 2025 07:23:21 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:51::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dcc1sm14484132f8f.87.2025.03.03.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:21 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/25] rqspinlock: Protect pending bit owners from stalls
Date: Mon,  3 Mar 2025 07:22:49 -0800
Message-ID: <20250303152305.3195648-10-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4562; h=from:subject; bh=1XvWGmZCOVeyUxqvFf8Y0s6SXxKLnF+WaHRbErsWH/c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWW53FYHDbQPTx2MaF10QE+C9S9CqxKdZN1xCD5 5EH85qGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlgAKCRBM4MiGSL8RygSbD/ 9QtT69Fbx2ynZFLU/vCOAn9155npdoPHm32pPMjxG7qV6+Th71XhvC5I9p08WQrwACm1JzGxkepYjm pDnmwck8jRMUBZWjdXi29dJEj7At072EjdZOXCp/Pzn/DxG1hBXTY/ZH9GJo3q8nxLqI/8mzOGpvR2 b9bpAUy1mnqdSz0AULDNnLik1YTh5mj/YEE1p2drByM6bXTGqqEfUlBQDrhOqf8KdBxa4dxNRcWKlB 0tNMmc0lPHuNsFGhIa98RSTjnkXRl2GzOutIcnXs93hpXKn8yL6/Un1t4hb0mHzlLTyxwVwY/g2PPn 0AA/IDGt1/cVQydezHH65YVA5Teh+546Vhq2IbW4nmbmef5EAMQ84COS1A81yPDyV5q0JTKBMjPvx1 p9XYSN4yy8hzTmwMquOoMa64dIFJQHMW0aXviAnk5fYkdWxSk5Gv34nqs96z8x2Eo7/RrZBWNCXpxA iRgBViTStzOx2G/rqo/jRde/IWmULIVwPeiAlMApDAYkehjUopupyV601mAfuY2y35Aiv6QNqYtJWc T6+pG9F4lzVDFo4lc2g8miE5ZrRBaoNA8GI9PRcWFMSNQAd8K0mEFPFYcYwWm/d8UaoZIqpQnY8Z2P uxJ+hkyt/kL3Vl61gkgHMJVOdMx+RocUAFG+5xXN2fv9S6IKl87+y7Q5xRlQ==
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
index 96cea871fdd2..d23793d8e64d 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -15,7 +15,7 @@
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
-extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
 
 /*
  * Default timeout for waiting loops is 0.25 seconds
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
index efa937ea80d9..6be36798ded9 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -154,12 +154,12 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
+int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	int idx, ret = 0;
 	u32 old, tail;
-	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -217,8 +217,25 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * clear_pending_set_locked() implementations imply full
 	 * barriers.
 	 */
-	if (val & _Q_LOCKED_MASK)
-		smp_cond_load_acquire(&lock->locked, !VAL);
+	if (val & _Q_LOCKED_MASK) {
+		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
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
@@ -227,7 +244,7 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	clear_pending_set_locked(lock);
 	lockevent_inc(lock_pending);
-	return;
+	return 0;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -378,5 +395,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * release the node
 	 */
 	__this_cpu_dec(rqnodes[0].mcs.count);
+	return 0;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
-- 
2.43.5


