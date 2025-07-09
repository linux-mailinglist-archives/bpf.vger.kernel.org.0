Return-Path: <bpf+bounces-62730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A68AFDD1B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D1C540B7C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4734192D68;
	Wed,  9 Jul 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaT4njuA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED0283A14
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025994; cv=none; b=lae4LTzv8sxdXZ1JmxKYs2XzUicRyVFogc2iLSE9Dlwtv8FYNZps5CQHlA3CYhpy8Xm05hXsOwgE0U8G3/ljDy/DWidBmjZxLScm7HbvRalnovAz5f92cr6L2S1cQ1ArGEXk9O+B1FIzNsqq7HXwIvjHAZaDZrbDst9KBQIu0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025994; c=relaxed/simple;
	bh=9qearIKx1jP9hJCEtlTVN/g0tbEdkcf7ojsXZOTl6UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvP5yVNEtXRWhQZbpJ2g0ZIe3ahZjJBwoJ/dnsUOavBafUGJjluPj7nIGmk5ttNPVEicCN48+uqSZegqlD6EbQDF5sWy5QDtXsTErkJ54ENbpdo8fVADSXgMPn+/qg5CnrUzW2yWv65AddwzpY+XkcVm+O55R0YXGCePjueMNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaT4njuA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso6285060a91.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025992; x=1752630792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK1/X+FNv8/ob6f3g3/3MAD4UEKgr0dVFZKZxYWhXQM=;
        b=GaT4njuAK5gAI6zK02x9xz87Ltf8uS5gEeFy7exiACoaUVk4MRf/dydXgptXQ5cFFL
         bmsrXfQxzxeOKPFhAhmXZr+BWRJr+qDtXWJZwoRBFDg/u5vtbgTU3VCWrzrEEZwqJOu2
         KCO1s2rOGFLeZh47maMJM7Zvoe6s9PQX9Fj21kV+0BDpepT0bTGZVT+PR9HtYWIWtWGO
         mPNp/FcvXkhPuC35MisE4N/y6/u1OO+qyLXam8UT4fYrAka/Kv7RfWktiTGkjS9thY7L
         AejXBlus0vj24Kw+xqWAkkLoWkCfBW9fgn1tES2/3TmvHaRBoT89w9PdzXIPMnMzc/bt
         Xs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025992; x=1752630792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK1/X+FNv8/ob6f3g3/3MAD4UEKgr0dVFZKZxYWhXQM=;
        b=orhyQU1Fm7+OeWzwVGfReuGlb+XgjkdAwRvO1OHZIbSHY79vOWH/BDGs6TAoZZ/CCS
         EI54Z3i8VW+nYpD12TXqWes2EwqAPVj0116FxCMhnFctgzYNIy/ih6JwsyahJR0JHPYO
         K3evYBElPKyrySrzvQ+L/hxVmqNHjfoywPJzjESpT4stD6c4wHq84Bt6w7RX5pHfz+w8
         bY0WDw91+NvsHVziA1NFslRSzJIKuNc4UxAAZ+yGiahVlYMHyg0yWEpiw0fL2xpXCTOH
         2ThG/bUx9yKI9XN9DhoC/bx1MdRlJ/YdJOshNexEUVG0Nf7bZc5qTj+63kO456+Idpum
         UpgA==
X-Gm-Message-State: AOJu0YyOD72mjoSE/Ko5tvvSs02s0220qXC5C4V/A235LZQxlbKl+qDd
	GQcoe+OVucaAckbFdNZcuHxr0T9xySzG5dC+DNOdN6DEYxXBx548qsGZkh63Ww==
X-Gm-Gg: ASbGnct1wFFKRWx6xzYBhfX9DINGrT/lQKYkDr9XQ8434b/+Xbc+IarqsITjAZaKvnl
	ceNMzPxiqxt97VEuaz1spLb15ylKAwVFnZHhmjQ2y7u+AtfKPxCefz1RqpaPlbAgxmJKgXOw8Nk
	KP+QdyoAmkhGxRXkId1Jese+0dNcFFId8WT0haZ9l/VXZKyMbr1Luv+/B87qWkW0eMyqyrXpPd6
	v9XmvMzgd0crnWHLStImIahWmJUWRMlVFR3n+OeCg+OOJNTQMPfRIapnnCrnZ0+zon1H+OF+Jxd
	BK4eYLgQhEb6Gdmt5d84h8j/AIgNaUM/0RimOVVQoum1PjL+3zE8busT/S+e0WAl1pejeNl/7IE
	S8Si1o31B53UPSfs6a0Xx3TkjWZs=
X-Google-Smtp-Source: AGHT+IFZHPmbHD2yROO8MdoTSXUTlKToJZfX1sUdAMJ3Qa1KzIJt/XCBBp2IOiGGLKSJJa47PZtR9w==
X-Received: by 2002:a17:90b:2f8f:b0:315:7ddc:4c2a with SMTP id 98e67ed59e1d1-31c2fcffcc9mr1320196a91.12.1752025991536;
        Tue, 08 Jul 2025 18:53:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a373sm122628495ad.7.2025.07.08.18.53.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH v2 2/6] locking/local_lock: Introduce local_lock_is_locked().
Date: Tue,  8 Jul 2025 18:52:59 -0700
Message-Id: <20250709015303.8107-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce local_lock_is_locked() that returns true when
given local_lock is locked by current cpu (in !PREEMPT_RT) or
by current task (in PREEMPT_RT).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          | 2 ++
 include/linux/local_lock_internal.h | 7 +++++++
 include/linux/rtmutex.h             | 9 +++++++++
 kernel/locking/rtmutex_common.h     | 9 ---------
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 16a2ee4f8310..092ce89b162a 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -66,6 +66,8 @@
  */
 #define local_trylock(lock)		__local_trylock(lock)
 
+#define local_lock_is_locked(lock)	__local_lock_is_locked(lock)
+
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
  *			   interrupts if acquired
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 85c2e1b1af6b..db61409f040c 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -165,6 +165,9 @@ do {								\
 		!!tl;						\
 	})
 
+/* preemption or migration must be disabled before calling __local_lock_is_locked */
+#define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
+
 #define __local_lock_release(lock)					\
 	do {								\
 		local_trylock_t *tl;					\
@@ -285,4 +288,8 @@ do {								\
 		__local_trylock(lock);				\
 	})
 
+/* migration must be disabled before calling __local_lock_is_locked */
+#define __local_lock_is_locked(__lock)					\
+	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
+
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08a..a8f2fe154487 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -44,6 +44,15 @@ static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
 	return READ_ONCE(lock->owner) != NULL;
 }
 
+#define RT_MUTEX_HAS_WAITERS	1UL
+
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
+{
+	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
+
+	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
+}
+
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
 
 /**
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 78dd3d8c6554..cf6ddd1b23a2 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -153,15 +153,6 @@ static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 			pi_tree.entry);
 }
 
-#define RT_MUTEX_HAS_WAITERS	1UL
-
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
-{
-	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
-
-	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
-}
-
 /*
  * Constants for rt mutex functions which have a selectable deadlock
  * detection.
-- 
2.47.1


