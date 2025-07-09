Return-Path: <bpf+bounces-62731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E53AFDD1C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25CA540CB1
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD46191F72;
	Wed,  9 Jul 2025 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfQw6mq1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E683A14
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025997; cv=none; b=IwP1bZfe6o2FZPoho+aTSmbyAOIWmOPDZttd2ow8FpL+EBxKXcJAg1n5oC8AlLG9GJPhWCemTIBPU+ewDZFlD57lqqmv5ktV9Hmm5ekqIt69CI53M3C4GPtF1jviiCXPdZdPrVw/RmTyXptyQc0w8TN+J8g9i6cHhI9V5gl6kO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025997; c=relaxed/simple;
	bh=LWLgOcns2oZX00zNapupXxQb4i1suI8mR1q9wNFCecM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/JkFCVoyYNnyBQDDjn4XsXGJoc9eoF42/6k/Itr1NF9jLDIQRZxpypXlz2iDAYHPm0NwDWdwC1LLXTFMKQucKKCg/XWiTq91AkL98JfammU6F+nxM3hWET1CkCsWLCvLae1+kTzc7u0IfqrQ3wMP3Abq0OpfPxI7k/WZpbUdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfQw6mq1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso4523803a91.0
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025994; x=1752630794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Ua5sKnsrIyRqKFLekLDDfmQREWYUJcYc6+mMsIips=;
        b=JfQw6mq1Th8gWb2pnvC9Vob/nP96NPyf9/C8jow3PhC8jRfayFlSBQ/1IXXYFNsiZh
         eNyFdW+gTE0QTJuq2neNE5qQl81yQu+KS7Gsym1/Wl0B/RheKHcGqvOKKbTPCaG7QyZe
         MPm+OkEvevJC6v2i6J6qXNBSqIW3r347XiiNz+ugLHzXlg1+QUgLl9ZstlkNOF10MBWW
         lw8FMvmb/DSuJEmIl4oDt6B6DDXTevHUjxDhJPHs6JEcto2qJFegAMBns4rwzRFENI+6
         /lbWxKWCWt3ioMITrPjSz61deUDnJxPwq7X+Ms6KUorIqeFNdog+l0dVRw6dyocJdtUb
         S4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025994; x=1752630794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/Ua5sKnsrIyRqKFLekLDDfmQREWYUJcYc6+mMsIips=;
        b=aroeGBe4f/9aDJvV5wgZBWbyPONpPWzZRObpCydSk0mXUvcdlNtMvknOQy90BXnlpK
         KnbqQTiFOIlsQf0UdO+7o6gapwMfHqETbsqyW7XIJsPjFE6Vcqg1fFD7xhSCU+n7BvLb
         qJsfKnogp9NYmLl/9r+PM/DI7L6eIp4Pjqx3K7kWCiZAeZIWoQVCcUj7H8GuL9r0c9hB
         OU57OZCYowzmBX1PuH4Vdn2+fBKqxR0XCMdFm46NgxPQJdJo7ImjX6rn6WFx7Wnujh3d
         9srI+Jp/gG0+F07e4rDTR48fk4HOZPZl5rlMBSTmk35usOhhT/6Na2CKtGyxi2CqsE5j
         AO8A==
X-Gm-Message-State: AOJu0YwLdIQg/wtzs5yLkC2Z6arJ1nQQFnjOtUwir+zXCEocLf7hshWc
	JOs4FwabwFAfuHRAi9EOeilIPKsGVQhC4WeRSXp01EhlVbOerv1UmImfeO59Ig==
X-Gm-Gg: ASbGnctOng3pLKlT3pfakypnh3EVt2Uqj9nszjjYguEPgnDcanR0XSVOhzNg5QJTv8Q
	7w8S20J42XaDquXSJ45CBOUszI+/Gn0019VVIeFi+PgFdHUYAi9qSUpXk8BchKTpQNZDFvcjeuz
	TGj43mwB4Fmt/1C5yD5DEeODwemUDe1qDBHVkDpmq+iWY7DYhnBWhnOcI+j1u9AAkh1irCOvDu2
	X3weBAIs6CLydkVimpdMJpc+ScLiBxFCvQF12PYBKQ9lRaQfJFx0ggBpobkBDY7pW81WxPurYux
	xo8bdLz30lQgc2EpM9QnWidRSin96SSPxHCxBlSZFlg7w7d06pzOs3+yCzyuNVmUq4RE8K7chxC
	kKyRZwEXo/FLVjpHh6XDLaq0y154=
X-Google-Smtp-Source: AGHT+IEn9bm8Gu9IwAgDOMIlYpQ4UCQB5S6UKhK7vqUV6G2PUzb1SmtZ/06k2i9CXCRL3vcfqpDstQ==
X-Received: by 2002:a17:90b:1b0f:b0:310:cea4:e3b9 with SMTP id 98e67ed59e1d1-31c2fdfb963mr886368a91.34.1752025994358;
        Tue, 08 Jul 2025 18:53:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc30sm440282a91.32.2025.07.08.18.53.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:14 -0700 (PDT)
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
Subject: [PATCH v2 3/6] locking/local_lock: Introduce local_lock_lockdep_start/end()
Date: Tue,  8 Jul 2025 18:53:00 -0700
Message-Id: <20250709015303.8107-4-alexei.starovoitov@gmail.com>
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

Introduce local_lock_lockdep_start/end() pair to teach lockdep
about a region of execution where per-cpu local_lock is not taken
and lockdep should consider such local_lock() as "trylock" to
avoid multiple false-positives:
- lockdep doesn't like when the same lock is taken in normal and
  in NMI context
- lockdep cannot recognize that local_locks that protect kmalloc
  buckets are different local_locks and not taken together

This pair of lockdep aid is used by slab in the following way:

if (local_lock_is_locked(&s->cpu_slab->lock))
	goto out;
local_lock_lockdep_start(&s->cpu_slab->lock);
p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
local_lock_lockdep_end(&s->cpu_slab->lock);

Where ___slab_alloc() is calling
local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
and all of them will not deadlock since this lock is not taken.

In other words this lockdep-aid avoids the following false positives:

    page_alloc_kthr/1965 is trying to acquire lock:
    ffff8881f6ebe0f0 ((local_lock_t *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0x9a9/0x1ab0

    but task is already holding lock:
    ffff8881f6ebd490 ((local_lock_t *)&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0xc7/0x1ab0

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock((local_lock_t *)&c->lock);
      lock((local_lock_t *)&c->lock);

and

    inconsistent {INITIAL USE} -> {IN-NMI} usage.
           CPU0
           ----
    lock(per_cpu_ptr(&lock));
    <Interrupt>
      lock(per_cpu_ptr(&lock));

Note that this lockdep-aid does _not_ reduce lockdep coverage for local_locks.
If the code guarded by local_lock_lockdep_start/end() will
attempt to deadlock via local_lock(&lockA); local_lock(&lockA);
__local_lock_acquire() logic will yell with lockdep_assert().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h    | 15 +++++++++++++++
 include/linux/lockdep_types.h |  4 +++-
 kernel/locking/lockdep.c      |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 092ce89b162a..04de6ae9e5f0 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -81,6 +81,21 @@
 #define local_trylock_irqsave(lock, flags)			\
 	__local_trylock_irqsave(lock, flags)
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define local_lock_lockdep_start(lock)					\
+	do {								\
+		lockdep_assert(!__local_lock_is_locked(lock));		\
+		this_cpu_ptr(lock)->dep_map.flags = LOCAL_LOCK_UNLOCKED;\
+	} while (0)
+
+#define local_lock_lockdep_end(lock)					\
+	do { this_cpu_ptr(lock)->dep_map.flags = 0; } while (0)
+
+#else
+#define local_lock_lockdep_start(lock) /**/
+#define local_lock_lockdep_end(lock) /**/
+#endif
+
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
 	     local_unlock(_T))
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9f361d3ab9d9..6c580081ace3 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -190,13 +190,15 @@ struct lockdep_map {
 	u8				wait_type_outer; /* can be taken in this context */
 	u8				wait_type_inner; /* presents this context */
 	u8				lock_type;
-	/* u8				hole; */
+	u8				flags;
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
 #endif
 };
 
+#define LOCAL_LOCK_UNLOCKED		1
+
 struct pin_cookie { unsigned int val; };
 
 #define MAX_LOCKDEP_KEYS_BITS		13
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd2bbf73718b..461f70f4ca28 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4963,6 +4963,7 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	lock->wait_type_outer = outer;
 	lock->wait_type_inner = inner;
 	lock->lock_type = lock_type;
+	lock->flags = 0;
 
 	/*
 	 * No key, no joy, we need to hash something.
@@ -5844,6 +5845,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	 */
 	kasan_check_byte(lock);
 
+	if (unlikely(lock->flags == LOCAL_LOCK_UNLOCKED))
+		trylock = 1;
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
-- 
2.47.1


