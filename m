Return-Path: <bpf+bounces-46472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033289EA53F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A799F188B0AE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473519FA64;
	Tue, 10 Dec 2024 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJv1fdgK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73B27456
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798397; cv=none; b=aRrt7Z21C0mfb7aWhFakkfmQpMTqZEkzGF6UvM/aAoPYCXb39aGlJQC/oJ0U/uqxjXLHzUm/rlxiPt7MNBXydjnCjrECQ+jvRnuv6octyHLovCKoIlDb1VjumUGeX1VO2tKXFGrSZ6QbKP0RNQXV1lAeYvCtWakoCg30bszHWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798397; c=relaxed/simple;
	bh=KYyuDO6Ahs01hjYzBDC8IjaST0acLjXnJda3FVGwIv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTGbL+ORl3dSYxCvCdhH8TFpgMA1p+yHaRsW4eWP+DUSeDOjwyoOolxblueZCMMNhsMvTrGUgYIFr56We4IUex9YKTa9r3LHi04gtC+Mgiw1BDC+nonPFAJ6C5d+30m2y1L6IAjNZ5r63qVNCz18YcyWpAc0MJRsqredKxXVuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJv1fdgK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216426b0865so16316905ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798394; x=1734403194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT/DPo97yF9oIvPtZgU314ePao/rByOm5QF7hTFkWYs=;
        b=QJv1fdgKXn/2RhJSh1x8ajX87Hn2Na/ZZS31Rbg6VchynMN/sSbhIaOOedFR/xpsgm
         I7S1mHrDPS8V5S+/wa+r5VLQmMn5dvBjkrxPpckqDgsk7EdyGLCcqAPQoCWUsn6Z/WTQ
         DeWpRPN1mx5i8lJ8n0PcmNI1ATKiqPpGYJndu319edyB7of4Vhh9niRlvwOpMB4AE8kE
         B1QbkfMLu6/ObifX99iu72aUlB3dU45zNwv0JxaPUymJj2p69fa+9jbIZg/66wea2Si2
         qjr/tmRdo27WhgM5l5J7qD9weFe5ljfJG4anr9xlDIh94Hh+8XjhMJx9l9DbraBdYJsh
         rlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798394; x=1734403194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT/DPo97yF9oIvPtZgU314ePao/rByOm5QF7hTFkWYs=;
        b=PZt7da0RWUuO4/kDmpCR8mU2kkq8PTc6/uOcoP+iWMzROuOao70sa1pBBikIPcHKwv
         h75jb4fAFeQropx1oEuXTappEgyV1PtGPrQr/4KKNb65SiWqr/BBufwWLR0PtjKL0FBw
         PLBYYOXrCE5ZJECRDzd2GmWt18xud/3pI1y4w59TWrddL5Lm2vNsOc1ENvX12pK5AGQW
         lIilhiW5D6jIwXPTRNaW0eC8ayieDcsFheKRr7lx9J672wmEgQP4HBwpGmT4jFGnLQxZ
         yemYZDEPoYSqvqtj20eGgeMs7/aMxiuj+hlsTn73qjkGu7oBBlleQzqQZLsFV9WtRm1/
         ITAg==
X-Gm-Message-State: AOJu0YyrVjplVK5YchI4cNBe0Mi9Cey4hb3w6cd/oXHJS4E+0/uMJ3bk
	/+MY2mVa/Va8+D427poYHgss2D1x8Sb7WnYzuUvAbxIfzCmc+uK71VgTgg==
X-Gm-Gg: ASbGncuA2JJZWsk3survv4tr5IXEVmfHRYAwO4eSsV43JZuGkot+ul0rvk1s/vcbngy
	+oOoIfoCuYp4+2Fegy4ay6f6KbOh7lPSuuZ6iUTM6DdUAg4C7ixCeLggx64lBd32SexU9dze2uC
	0H29sfmWBvr5NJy4az7b5tg6OG7ASi8/0wRpjos6Xx6oeuzcFI3JQ5JOrMvO6WijJZucrSRYkxl
	oOf4tIHlowNy67Qa+PjFut08/BnenV6odt5VNL8GaW99/eBHIihJIzoEsKG1pf6IIWTAuhiLI6b
	q6tBZA==
X-Google-Smtp-Source: AGHT+IGKLmePoGcXe+HAKRjlAgf3YSGz9J3cPaKQKdSbicAELPOmItuHpzzqliawMg0yEsYXj3ExxQ==
X-Received: by 2002:a17:902:ecc5:b0:215:4fbf:11da with SMTP id d9443c01a7336-21669fc28d6mr43610845ad.21.1733798394490;
        Mon, 09 Dec 2024 18:39:54 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f031sm79221425ad.82.2024.12.09.18.39.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:39:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce local_trylock_irqsave()
Date: Mon,  9 Dec 2024 18:39:33 -0800
Message-Id: <20241210023936.46871-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Similar to local_lock_irqsave() introduce local_trylock_irqsave().
It uses spin_trylock in PREEMPT_RT and always succeeds when !RT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  9 +++++++++
 include/linux/local_lock_internal.h | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb..6880c29b8b98 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -30,6 +30,15 @@
 #define local_lock_irqsave(lock, flags)				\
 	__local_lock_irqsave(lock, flags)
 
+/**
+ * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			   interrupts. Always succeeds in !PREEMPT_RT.
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ */
+#define local_trylock_irqsave(lock, flags)			\
+	__local_trylock_irqsave(lock, flags)
+
 /**
  * local_unlock - Release a per CPU local lock
  * @lock:	The lock variable
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8dd71fbbb6d2..2c0f8a49c2d0 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -31,6 +31,13 @@ static inline void local_lock_acquire(local_lock_t *l)
 	l->owner = current;
 }
 
+static inline void local_trylock_acquire(local_lock_t *l)
+{
+	lock_map_acquire_try(&l->dep_map);
+	DEBUG_LOCKS_WARN_ON(l->owner);
+	l->owner = current;
+}
+
 static inline void local_lock_release(local_lock_t *l)
 {
 	DEBUG_LOCKS_WARN_ON(l->owner != current);
@@ -45,6 +52,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
@@ -91,6 +99,13 @@ do {								\
 		local_lock_acquire(this_cpu_ptr(lock));		\
 	} while (0)
 
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		local_irq_save(flags);				\
+		local_trylock_acquire(this_cpu_ptr(lock));	\
+		1;						\
+	})
+
 #define __local_unlock(lock)					\
 	do {							\
 		local_lock_release(this_cpu_ptr(lock));		\
@@ -148,6 +163,14 @@ typedef spinlock_t local_lock_t;
 		__local_lock(lock);				\
 	} while (0)
 
+#define __local_trylock_irqsave(lock, flags)			\
+	({							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		migrate_disable();				\
+		spin_trylock(this_cpu_ptr((__lock)));		\
+	})
+
 #define __local_unlock(__lock)					\
 	do {							\
 		spin_unlock(this_cpu_ptr((__lock)));		\
-- 
2.43.5


