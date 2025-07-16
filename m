Return-Path: <bpf+bounces-63399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E47B06BB2
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED15B562BC0
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246841C6BE;
	Wed, 16 Jul 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWMNI8el"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0F2E36EF
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633001; cv=none; b=dyrBXY2pObnX0f1Db9IA/JkP9wXfOkrx/CR+8KZswrAgqu/QR4e3jvFXBPkhtynt27jGpK5HsChyb6fT4Lrw1F+XvkypzTl/RNE4KOUOn5M28d4iFI/psmHTbqnPOqoG9vzVtc+ZwOCKVeif7CjwaUkiDzovHJzUVKglzwSpEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633001; c=relaxed/simple;
	bh=eEO1vdDMoz3LbQYw8JkhiXOkvnPNyYO+uWMaafkzsyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5MQU0lsEvWWdkHpArPbiUDaCyDRhUbrlnyYHJyLvlqRQoWVq4wUMGGw/9Vycu8NFn6lq2Vte994FTBAMvykuQEbVUEuQc5P0bfeJpm0IgYTStGgD09ZW3Jj4fclOZcHtb0BandCFd5SAYCFnkc4ykBdqcQKMU1dYEB5e3b5Dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWMNI8el; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7436678b3a.2
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752632999; x=1753237799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zjha9CozwWf99QW/X18MFNvUU8jW7FfnrLuKdO90KA=;
        b=YWMNI8elvbTedC4kmD4Fl803CwaRH88SBa+odXHkFEZryLN8p554X64MakSkxYRd9q
         kTFXcpAO5JGuHxR0QPWWIng9ZBQ+Rk47KAUewg/eyOW26wOKZ+0/hehk06lT8wmP5CWx
         Rbcrfz9llhyiU/RDj3OJgFWgPI9CQKZqh9LG4xnRs602FF0RTkrmhsKV0LcxXHxrlZB9
         p7b3a6f174ZiGwRKLswDBthaTS0t7VZFKuMNB8ObILCtbH5rhp68YE2Ev3U5J6vKl5kx
         gC3CoKG6qAUdBQOH37+y0oVntp6tmO+sdbJF9mBTiPgm+kblOyxCMBxE0TLQeURv91BB
         7zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632999; x=1753237799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zjha9CozwWf99QW/X18MFNvUU8jW7FfnrLuKdO90KA=;
        b=CgtQYPj1XvCyMHguFNYSPBvuCvyoSuKcZ+8pNRd9yBHaLdw3znzz8WjcbtvF0IFkC6
         uItPXwiJHq+T08AekCcT0hQsQ0Jwjw5nFigWrF6UcV1MZ2WcV+b04tlJn1zKUSf+yzFF
         5FGKI44HtN+zMEjWy4QwynmPxY9yDAWCh315RYUn7HIwknHvaxC6LUhiYqVcE8N5LCCw
         fmfTjKhcYQHnyHdnp/DxPw6gOR8iVlbxjCm2vPpQ+OqUdZG3xUD+G2uA5ovQt3QMr80H
         NJh7w63y8sEbfqpQtDo+nsi23ijawrmADukU4ohdxxZCXmceRgZ+YHhqOJJLOUqUtoOF
         j/6w==
X-Gm-Message-State: AOJu0Yw6AJD6bv4RfDAJiiEm0RIfmG8MrnAXDVChv9HjDO4hyjhdkgtA
	Aj1IfE7RoMcjlSQR+AAc2jSZ4iZSnUlgAPzEx1DzjrjHRlP30vSKuDVlmSq89Q==
X-Gm-Gg: ASbGncv5FcvJs2b5tp9JCez2jHValuMe4KGXz1N/lWC39FQSDG1T1W3N2hzx07aSnij
	h3LHi2EcPPqTY1Jd9ZwYJddHUoCkNpBfYGcL8URZFiTmuOPFhWc4vmeCSYya8QcPp0t3pQTVWvP
	mo6zsTKSQRh/dG/M9EETEDjXAvkDmMwljyiu5ydzo4P+UEosgmBs6x1m9JpzL7EbPgqhQ4D3jYJ
	h0utke7IDtkUU1zt6sFoo5RJNmRZaEiA9VO0gTxU24/dM7GR1UK3Fk4EX3EUd2zapxtiBB6svIN
	lme5OHolYaM5aPO97lml2grNa7myAvvxn/r8bZ+9axaGB0nl3Jvuk0JJi7S8hXQgRB35yxCy1iP
	tCL8jCSn0j+apk/OtAUMbxAQ9z+2snHDJQT7nC3IVpdrfcnX0E0LIamq3Xtze16g=
X-Google-Smtp-Source: AGHT+IFebfSowSgobZGLnQwXyibCp3VA/xpNxqs6gg8v0Nnk5RUzLeSiwD8t1MjjItmTM+35tQlghg==
X-Received: by 2002:a05:6a00:98d:b0:755:9110:c00c with SMTP id d2e1a72fcca58-757250806bbmr1370126b3a.11.1752632999039;
        Tue, 15 Jul 2025 19:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd603asm13511470b3a.12.2025.07.15.19.29.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:29:58 -0700 (PDT)
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
Subject: [PATCH v3 2/6] locking/local_lock: Introduce local_lock_is_locked().
Date: Tue, 15 Jul 2025 19:29:46 -0700
Message-Id: <20250716022950.69330-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
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


