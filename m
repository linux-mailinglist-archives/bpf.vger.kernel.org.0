Return-Path: <bpf+bounces-67820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE050B49E6C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EB7AA8F6
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B3216E23;
	Tue,  9 Sep 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyoKXzEV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA021FF4A
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379615; cv=none; b=P7blURnoZwVzK50Swg36jRJT6/3LtDPYHDAUfs3jNGaf2AIQpgwo+HtGkaQiLDNBJL7ue/dL3Fsw9WhgKsA0cimAR4wh62a1qGnDd3vCdGy4cEd3HE3i7QmsjH8YLN3DIFHk8cy+mErbDKGBcBrxh58dDCkdSTSW/SEuy/iPt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379615; c=relaxed/simple;
	bh=M9PQGG0oeCTh7MmM0ClfF4e0pIEvQP5vo15W9Qm5ix0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bc/01iQItBPJ/yjxUQlKmL9El/R67sksOWwidUarkBrxXjkL9vhEj6IWrQ9viEazb2d12NWFdSIzBOSgoQeITkBp09ajZCetC5EyTiPA8JsWzA9XRCX1vj4FyYCcb+J7l4lr7cd1kLP+AbLmbsnMaOp8oFvTVtTqNd5ZuZWDoGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyoKXzEV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772488c78bcso4988844b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379613; x=1757984413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQaXiO7Rj6JeUoLNyDKccCslPjkrNZKqfhPqinjWMVs=;
        b=iyoKXzEV69QwxCEiocIsPxycvuSJGA9AaMb5JKN2EqokZxsuaTcUy1mD0HbpRAQ1kK
         h3q1otCYFD0kNjzadmwZJelP7uv62upwb76hVEIPxSZcxfnHEr8ORPAMGrLB6APlBLNB
         HKkpAlRJlTbnYr9emUa+zNWbOWb/PruleguinAMjGn+ellqjSXKgnpfTiSmip2wikp0d
         5Zzrb15PyTFWfFrJ6a3/PDVRjwhIm3YVvJwOzTTo+EPwZ7WhSC+H3H5POQUFG/1bDMVt
         HSkqu6EOC04vkBgxWUpMpRAn+QKNwjSglvW4Y39nxF8ti+N7R4Kqq9Ghq+cnlPmIXIWK
         SYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379613; x=1757984413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQaXiO7Rj6JeUoLNyDKccCslPjkrNZKqfhPqinjWMVs=;
        b=SY/ZDthKmEKO7qiVAV0AWKfUbV894pOUGBZ7tLjHkdXHapzbUPqcGt5qeFKpxI9xxr
         FDlE30+XbT7AXwyUplYQrpihL+1O96wqDb60pvbLB+NTe14I4H2+plxqEp8D+SHAthSp
         cRKh52SQVXCx1+V1woo9CVoVlMuI//uDN7tmtssAFWjwgfz8L4BZcsGh9gMitZg3p2vB
         Of1bDWNInmYUAdXUOj3fbJNCNofanQqtZF69PsSPAWqmkIcCN2lDzgWYAODI6qmXENBo
         9w1th8PSUnjXM2cRp9wx1rmOiIUKLbhDFIcZ7DKjTg9rj4Ls7HnHthBxaBN5HInNyEFW
         x7Tg==
X-Gm-Message-State: AOJu0YyzsMNTr1vDq7NROFrqqXWf1ylvK6L3XYwwxmSJDAF2HGzKV0nn
	QHcMvwKSK3lfDg14B6+UC4ZdIH5j9G3UrMawE4UE1Vh2llMcfDjoYkJtxsbMsw==
X-Gm-Gg: ASbGncuixqwnTPfYuc1oH5b0jlDGkjS6oIe7ZeAWhBlYLTRSAEJV2TKT0zcbB8sl4e+
	Yj3Yrl4+0TGs2tEXYg9t18xvvDShCmY5GPSYqu8gsQb47gh0n6AX0DR7/ibverIgVVEiXjVxl5L
	YMcJ+s4cm44c9PZOLwiQuGAAmKZFD8XO+AfyNyyxrrUzqpgSpax6sURBEqiIYXUO7ozTDib8YE6
	fTin5Pyl+yk7ZCZBgx+aPX02AbYLnBcZHc/l2krVtdcDSHB6djbWAv7r2o2z5cKy71IdkfhOmjU
	tdB2vlvfFjwSlxqgzNb4+M+t3BgHtTHbLS65S8ePP2fbtxkI8PbNURanpxbLqV8GOfk/tBeoyhR
	s2nzsUdKyhVDhM8G44FJqbckX8viGXRRCUpXC8lvENn6djgrgTlLIbLoHPOQxJWc=
X-Google-Smtp-Source: AGHT+IEyyyLEKg31IihQi/ou94RxqHeZu017zfwcJX6SGzpwddIuJtEgCWvNWfw0XBs7sZ8NiG6v/g==
X-Received: by 2002:a05:6a00:1394:b0:771:ef79:9338 with SMTP id d2e1a72fcca58-7742def5d1emr11646157b3a.21.1757379612566;
        Mon, 08 Sep 2025 18:00:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628fca0sm205235b3a.56.2025.09.08.18.00.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:12 -0700 (PDT)
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
Subject: [PATCH slab v5 1/6] locking/local_lock: Introduce local_lock_is_locked().
Date: Mon,  8 Sep 2025 18:00:02 -0700
Message-Id: <20250909010007.1660-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
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
index 2ba846419524..0d91d060e3e9 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -66,6 +66,8 @@
  */
 #define local_trylock(lock)		__local_trylock(this_cpu_ptr(lock))
 
+#define local_lock_is_locked(lock)	__local_lock_is_locked(lock)
+
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
  *			   interrupts if acquired
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 949de37700db..a4dc479157b5 100644
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
index fa9f1021541e..ede4c6bf6f22 100644
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
2.47.3


