Return-Path: <bpf+bounces-50642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CCCA2A66E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A747B3A5D3D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F0C22E413;
	Thu,  6 Feb 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsIqNL3N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1522DF83;
	Thu,  6 Feb 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839291; cv=none; b=fAWodnHGEGJMs/7gxa8Tt2T4lVj/GZCgviaW93TfxwruD6t8jpmrbLYOG8qpIC9d41o3KU3doJp5IsV3qFpv1Diuw0egGrXU7n7RfFC2RI34LdkCiPOgORbaYrRC2HriF7R7CN/qqdqLsLhZTijZO4y1BVZL42lmOn1yPFOsUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839291; c=relaxed/simple;
	bh=PZAstj2WMwdJ5zpDKugp3FElz+LV+4cvINkXq1LfzVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIQ+Xjg6DZsYEKmFYRTMmkjgrqzJwFaAS8vNGC5ALvqiQb6I3ZTw1HKLKf/eckcMgcAxvWOusoAmdA0tzM2mZTqLIELbZNoQQSfaDNR9YRCMHW/CoKM3eVQVzjcSnOUpUAD6PG+IcWoxLlJc0RsIUyn2v79D2xr5iD6r4trVgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsIqNL3N; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-436202dd730so4838265e9.2;
        Thu, 06 Feb 2025 02:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839288; x=1739444088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6HfEz6FnLcnMW+Wa6mBmkJ5vtGaoNq/ogsTG9QK4tE=;
        b=DsIqNL3NHzc+TwaRhNpYtb5rVfOVljK8851/P1LBlARdh/p4Gwb5gIVQLlqK5nmvSg
         Rz/31tijGNQYnEz/jRT3bDsqCWJRlUk2y6Mh/xHhSe6AfajwVxD6UD+Cm0ntxrhynVgl
         11NFY9S0/aZ3Eo7yGz97L1yicF6HuF1XZsf+lQnoRzoQNvrKGMftP5jNn9+bON/9IkVq
         u1iK4QtxuRTG/RbCeW2KaLH1eRxearIAVUgQFYt/nzrVUGUxvon+AQWcScGgAKKiZ4sj
         YpGnS7DHJKhM44CAHtL8/sKRS3RrPHfMkFqGKo9wyvzqvTaheJ4KdyDOEShoOy3oIOR3
         HI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839288; x=1739444088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6HfEz6FnLcnMW+Wa6mBmkJ5vtGaoNq/ogsTG9QK4tE=;
        b=G4FFpPtB0dISMnDfqc1EQRvP4twCL8klNOWXMaJwbWh6ba0TQCoL5XYxTYimDvaGDf
         yo3sdgcBnr3Pqlm2zq1suNt3gyKhHTgAvPP/b0i/6NKmRMGkYZoWQmk0kCsE20CS+AUl
         1hxD3GTXzyJWd0LENQxFtcRxj13EET70yG2ncKuSAzRybal3Zg6u2Idb2VuoJslcpN85
         wueJjUs36zsSyGTsGZ3tGPMyshzqHTOqpxK5m8oVEqvq/GfIM4qTFNTHMQ9mECiS0h0K
         yPu1UlqMAv3fd2g47v/IBcWbMa2jkrOJL120SNZltk4AOIu8SPHusuZHeeRV9gjLUP/Z
         mHSg==
X-Forwarded-Encrypted: i=1; AJvYcCW90CIZJMnY01ruJOaTdlrLjdkUcLN3Ji9RSrpibV3JRZY9E+4PefY6fMYM3O7l5JRRnvLTVD82bDs6ou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNinOHzSHfPgXsotrQMebc6Zulb8a/F7zMoAFbvrtnXiWdWWj8
	n2Apaa3/4UlQq7AXMNYGFfoxfs0PDYn1KU3LPxHu85R/X5b5ruGDP0hLzED5f1o=
X-Gm-Gg: ASbGnctErxvaH2ujtc7zt3e/NcDN+nzWy9T7OcluVijBCNpw2r75UvQ8sWQm7RGTMOk
	VHAHemYF8/bAG+S4gdMjmpBsVTul4ziKVXPptbGrGufILQISLboQJAbPNodTMbe2oWkROkBqlmu
	UfJaEm3xH9ItjJRTQSWMHDfzhpoQcoa7cczbr//8bRC8VFoGDNxQ9WA0+JXAWbIpQWGv1TNfIGE
	XWlOZ3cS68379ZApYc+6+qAWrxoSr7EYiZLupR03Tual/G8pNeBEr7NDYP/aqo6bsZ1aqrnjO/4
	hS0K9g==
X-Google-Smtp-Source: AGHT+IEFTmIDnkApoCxo9XEdAou5ZGEMDlqk297HAU+HLuXK1+LhNaJhCM/rdUs7kriHnIXhGFI/oA==
X-Received: by 2002:a5d:5988:0:b0:38c:1362:41b5 with SMTP id ffacd0b85a97d-38db486108amr4754830f8f.6.1738839287460;
        Thu, 06 Feb 2025 02:54:47 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fd3csm1414640f8f.62.2025.02.06.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:46 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/26] rqspinlock: Protect pending bit owners from stalls
Date: Thu,  6 Feb 2025 02:54:16 -0800
Message-ID: <20250206105435.2159977-9-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4602; h=from:subject; bh=PZAstj2WMwdJ5zpDKugp3FElz+LV+4cvINkXq1LfzVc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRlQkqPybkJ7GSLq/QqBmQtgES+UrYcxxOebbfU QQitnoeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RyrK9D/ 9TAnlSHxA1Q3uFCYcCdMIawjW1IJgTMIKG08AH5HflcEBfh12ex5nIURCNNtVmT8KNdznwDtmSyf9F Dz9E3Hb1omPeX7fZXLE7IFq92YLTS8ZhF954tYzs/ccHTnFSiRQUEYaPNN5BjAreKu7VsuNJTWWwh2 Zk18PTGBgcCoITYY2U9kPpt8H0ss5SjjE/v472ug3Sxr+ikSfRFCNfqHQlM07gdJeffwM2YhPLmyrA pS/ZOZBqjyv6FJgGZvfHKwzMoadC1/BvbPU7eQpAJasZGBSDhGpgWqGWPnrkd1Xx+Qpo5SaJTQv2Bf FVE3fsLPC8zh8SYzTkjlRiUuMQDkkUeC71FmooULzLbfpkqhhr5IlQIpcVaKafW3bGY7gkNkxgbUcR ZjGTHp06O6I30+WbvFpEoQXIBKla/RBxSi2qHXXdZ5xlHp/f0BpJfujOwZr5R+QHWNX4h8hvTigyRu JMiZjgK3a/DfYdZdkC7+3+Y4IWzCH5XFsthPvV6ZgI+HUdIaJu6gLuw1LHLahy0sUtSdl3j3nbkdnN nk5039QdF/msE7FiR8sEyIhyL9JjjIcbswOwvAx+cPa7i/XoU9RVLyZ+toJUpPQsXNfR7MRq1YEGFC OwvNNjfgANI5dQmuZkKEQfmCLhErAm7WdD82gJqews3JIUZe0bapo/LeUq6A==
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
index c89733cbe643..0981162c8ac7 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -20,6 +20,6 @@ typedef struct qspinlock rqspinlock_t;
  */
 #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
 
-extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
+extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
 
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
index 200454e9c636..8e512feb37ce 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -138,12 +138,12 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout)
+int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	int idx, ret = 0;
 	u32 old, tail;
-	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -201,8 +201,25 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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
@@ -211,7 +228,7 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	clear_pending_set_locked(lock);
 	lockevent_inc(lock_pending);
-	return;
+	return 0;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -362,5 +379,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 * release the node
 	 */
 	__this_cpu_dec(qnodes[0].mcs.count);
+	return 0;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
-- 
2.43.5


