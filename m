Return-Path: <bpf+bounces-63686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA4B099B6
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AE4A604E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E205970825;
	Fri, 18 Jul 2025 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx5k6yYh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D917597
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805017; cv=none; b=aFIW8hE89jtM7prxy4WndVLH+sKfuEqXYyl5HXeYLJLbkNoxyy5BBfNaFKo3y/+iypnOji2YGcRmJiYIxvA2RtONlQBB1u0RDvUq/aybYhvkWhPyPLQcm+SBjR/ywsoMdLEJO4T+7JzPhlSylApH9cDQGfbgzsjcxx3IpYBrvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805017; c=relaxed/simple;
	bh=WH/nN3YY1cNfC4PBbfuLBafDCPaz6c1Seo5Bg85aSM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dH2wzCst/kZ5ygoMWphdTpJ3Wtxqn+N15IlHpReOfAS554+vFh4t+ZA21jVxZfK8Z1mJvd/fuTARje9ELNL52Qwd1FAb354aJbek5ulfd2pj3E89eRFFDGRFLbm//SHlDvBQgV7ulYSW8O6AaRpr2XaYPZ7pHACeRiPyvZ4SM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx5k6yYh; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so1278424a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805015; x=1753409815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QPfGz9hyNuSzeIbSFrflGYEbZW75nC7LqiC3enF+gU=;
        b=Fx5k6yYh9tL9lDCSUhelghyVCc/ptRGAXaeSD2j+04L0gSiVx0V/GOKvu3leBELkjn
         YX8GGlwpqkhhvtoCc7+F0elCqgX+UAyKP1jXv9kmDXm1J7+s/Qd67O3bfaePbF/z6+1s
         qwhpZzf6Mi7aCSVUbjbl98GqIy6K43s7YFkSmV28v8Pbl3INhyTBvwQIGelUY/c9hlQm
         CzOZN2TMYbcubmn0asmj1Av0nehHc9Jkbh66F7049CQkheI9n55kA8EaO45qhQya5upl
         QtHVxmdBQiwwz9h9dL/xkYl1TpesHnnzdG3wR6WwaSXu4yLElu/eIzs6wOzYxVwQy7AD
         2kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805015; x=1753409815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QPfGz9hyNuSzeIbSFrflGYEbZW75nC7LqiC3enF+gU=;
        b=kcCc58pS9/gIN1kV9602mB8kuGZ4H/lASMcREV2v8zF55MP/mQ2vnz08AiC2mxlUsb
         imCi9p2RfdbBXhNHV0iAM26paNcy2K6/SWtX9l7egWe6Qs38lHdq3gPsNgiqEybvU4B2
         0pJGSVTZ5iHZoe1icaqGZ6ACGso521l3LiJmTUGoYPJF1DxnqddS29oWacwgTxC0INE/
         s55xY4xThBdW5pxKP84nkrlKCfF3hVpwBJ9KteufAGnsypbyh5VJnuJjruHt2rVMuz7p
         Dd9E5fFxA0/CzzaHD9nhOqzUQ1SENys+YoTNAmqg5JS8izc11CnY/RptnqLjbk/gLUb8
         dw4g==
X-Gm-Message-State: AOJu0YzNIdTUsC4RegT2zgaQqdN2E0kUENfoHB2BZxichVrrxXaczZJT
	dIn6yEmSHzW4p8XyO+2X/CHxynlnV3JI+MJWsEUVu0tEsmbfA9RazWCOJ0fFtw==
X-Gm-Gg: ASbGnctZJ/f41qv/1KMFp7c7UbOtaeFf4NwdY9h1jVex/KPgpF+H8V4OukcUiYaeSu7
	5dLGd8s8zga8UzIiQ/e6lIfOoW0fmzg187Qb1opVLVBp0xI2lRB5D7m9TRo5VMTzV66zTgf78gf
	3PUn78PI1aK+SVN2QvC+t3yd7b0nF1/zjfBm8Lk+1sWgMqCNfzu4R+pnOLDNdpC7ppasMrKwyTS
	vltLpzYhXPO6wVmaHlgDrzakI8J1PtsSkPOj+KKfPTIGK1ny49gKQ/4nz+++e4RrYJgHIogMn1h
	U0fL3jWHz3jBk7elSMBv/3LeSaj8vamHlEPk2XyMORAso8bp43M3SH+2TCkOjJhuoL8vncNWnqH
	OYbvRK+6E/II6Sl6dgPtla0lfKtX2BtXmo4+U5lRcH8wNZXjoWeehJNZ97UKZl+7IVFGFbzS12g
	==
X-Google-Smtp-Source: AGHT+IFqshWLuYL3hiVrY/cvf94EL2o5tpDcrxRmMAgP2cCNokNJ8dULFXwjqBQyApqZRBONGsor5A==
X-Received: by 2002:a05:6a20:7343:b0:237:a825:8b54 with SMTP id adf61e73a8af0-2381313e9dfmr14531524637.38.1752805014909;
        Thu, 17 Jul 2025 19:16:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff5eecfsm235416a12.47.2025.07.17.19.16.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:16:54 -0700 (PDT)
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
Subject: [PATCH v4 2/6] locking/local_lock: Introduce local_lock_is_locked().
Date: Thu, 17 Jul 2025 19:16:42 -0700
Message-Id: <20250718021646.73353-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
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
The goal is to detect a deadlock by the caller.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  2 ++
 include/linux/local_lock_internal.h |  7 +++++++
 include/linux/rtmutex.h             | 10 ++++++++++
 kernel/locking/rtmutex_common.h     |  9 ---------
 4 files changed, 19 insertions(+), 9 deletions(-)

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
index 7d049883a08a..98391601fe94 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -44,6 +44,16 @@ static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
 	return READ_ONCE(lock->owner) != NULL;
 }
 
+#ifdef CONFIG_RT_MUTEXES
+#define RT_MUTEX_HAS_WAITERS	1UL
+
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
+{
+	unsigned long owner = (unsigned long) READ_ONCE(lock->owner);
+
+	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
+}
+#endif
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


