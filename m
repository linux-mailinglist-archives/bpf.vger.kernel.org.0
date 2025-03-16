Return-Path: <bpf+bounces-54131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBDA6339B
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224D11680F9
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EA19C566;
	Sun, 16 Mar 2025 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1L9qma+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4B197A8F;
	Sun, 16 Mar 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097968; cv=none; b=ACS1noguW14XanDYaihjT0qjXN55x+65LQeKXtsGjDCwW/PgdvINdgAyKKmKwQwZ1TuNSwsSCdew4eTEW28++pFAt7aZWvm9luPLNGrhZ7t+sepo/kj/wFzhqjkH0WuNJjgH7PXd7WWLiF0LqsAk4Jjxyp8JIPyQ+/DemMvm694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097968; c=relaxed/simple;
	bh=Yp6VTxKtpBDQhUgfKGSHMWzJmZu3deRDpy/hLhkjXfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZyzhXoWYLfUR5TX7XQQjVqLxQgyizh4CH8k50cOTATYX4WeYJe/+8fH6Dy0JeXFYBMutTv4RNfi/bqHYENIER4LeO4BifuJ+EarOuehmPs9YBp9vsdidG1twn5bTOXtWXDmJQVfEEa/T8/6MX2RWMhFoNVraMkthfbmvA5CI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1L9qma+; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso9865675e9.2;
        Sat, 15 Mar 2025 21:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097964; x=1742702764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVJp3+JT7y8+ub6buLRsxOUyy8d6vFpxA5yFbRAEMPI=;
        b=Q1L9qma+XiAWK6JbYpNLupqgch5MmwFPlE/5TssWPKM+iaNVXZvsSDk0aohkPyZNJ8
         Vge17l+ncR66vgUQ7d1lA04plvsowEKBFaHxeXBJXycRm8DQ6gaTg666XlIduz4//h+q
         phC6P7xGb7AjW3TAwqw5+vAl9btpiKNWw+TxhMTfRd1bfZCIjO90IH5jVcccWEqXxjK2
         utSl01mauvq+KaaJcuNaiB8leAFBXBAlkkrBZPuelGzEdebRNjGeuGp3xeCv5PjB40X+
         IkMgP5M5Fdz7fCswSAoYHf8QHSVubAEHVVdvh2+ZQc55bgO+hHUs4FxLJinArXFRmJhU
         PZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097964; x=1742702764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVJp3+JT7y8+ub6buLRsxOUyy8d6vFpxA5yFbRAEMPI=;
        b=uNwp7z8h7WlWVKe+BdMmRz8naKo9ZvaalIehJuKPaCSQoDDxUizFG2hJZ8UGcHoKIq
         tly6DJALr8b6UcMfBzKUN2iFQ+XWBNTQDcOG+ES+VaVRUvTxyPNP2Lgec8DlPJw3Sjy7
         Ic3h7wtCpGfnM4qr2lZMZPRc6d7monrDl94indmHw7gRh0d3ot7l6pEP1BYvPM7ntEj8
         gVOcDAEQ56FGzD898ZP277iR15JJes9zmhPGAJonkd8kX2Oy5zFpv8T5bvxORkyeOKgH
         FLImy/HIhMfV6m+9d4r3PAcvALZB24VczqZQSqhYFi51rLVD1sO9pyjz3IcnWjA5zxG1
         tQdA==
X-Forwarded-Encrypted: i=1; AJvYcCW+lU8c4PGTZAeeso0sfkOIpxpQUkk0PgXv31o1Zb0+AacMX/Jiw9bkQu8l+LtTrZR9xjoM9XPubSpKmRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGloP3QrbUh8cKk7Daxy/BoHk0PVCucSEj1iuY/WniXJFvvaOQ
	nYNHRW13YvXDUITYsuUCWRq2PY4935kk5E/IVzbPFYJceTqOFiPlCFt9rf1hx8A=
X-Gm-Gg: ASbGncu4BLmAaurCHbRilelIpYsCFb8EL6dpb1SGxQcUU1MiuYAqKWNqQBryKzl4V/X
	hybbpglGav3mHla/ViBlu2IkXh6I78BpfXe11HjJXEmld8ZQnSADDaDH3A/HQxNq4ZshYLH1yxJ
	RVaJmX7IA/v0lDAldvComJKGluCjGv676Mb9hJtTcpe3go79eEjtWFIe9owBm+3Oomn/pocwQi8
	Jxijd5DfmKO2qresJnPhS7qkvMxmU4i7bT8c8dZTWTqrs2rI7fOf/rqvYoJgYmtYQH7uS4V5Uae
	ie6dVKQ1ZkXPHeh8jf8c3XJTQ39ZTpUfOqA=
X-Google-Smtp-Source: AGHT+IEqbu6eKdKbUR9hLIUzBRTM7W+fO2MaRKuwN5PjghpeobTfOg76MZ+yqvlOP3B3sgZbmvRoKw==
X-Received: by 2002:a05:600c:3c89:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-43d1ecd7926mr80182815e9.22.1742097964115;
        Sat, 15 Mar 2025 21:06:04 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d25593a94sm21073705e9.3.2025.03.15.21.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 16/25] rqspinlock: Add macros for rqspinlock usage
Date: Sat, 15 Mar 2025 21:05:32 -0700
Message-ID: <20250316040541.108729-17-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4185; h=from:subject; bh=Yp6VTxKtpBDQhUgfKGSHMWzJmZu3deRDpy/hLhkjXfk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3d7ne1febSzud04+mu0CKRHqx+H8Jq+gCO2ZsR MN8cyy6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8RykcmD/ 9gTc/RWOMn5cBBm9fdR7z3Whng8H/b1v47vd75XWWl34N0yLT/YWBxTTQ+sPVZzGGuo6B9xsO7eKc9 SZp8I4okxcB2aM74N8m344h+WeCA3ZDdOAN1PStTNACyJB8JKCSwhxf5/MD4VnGmAAvRd7JcgDsl3T lkua13O2hBIxLJEBPb7jFRav4gDcQhaWZZY8+I8wIj4D2LsynzlcQxPMMg/IOGoojbmx1IZpibvTSS cOab748UkW42TGSTq4cdoSqNEyQkllc5IG3CoplNecSOYw91jN/9/nfpRQLlkeNk4MMkIpW1wkerkH stNypWjI3+zMxxxWOpnatrs1AhcbL9xdZy/yI6HeaBpRLCWE7EP2tyRtxMLNP0xZTzDUbhelU5s2xS ISufWNdpb9hhDr2p7Az4+QCAW0/IGguxT1YSSJ3VIvP0PSGYdPGn7h5UGMmLAsKRteUQPiIinHVfjq jswG4p2GalFrgmjtSAlgCOgfnnBgdFSBZ8KrUhAEDyoSkn3oC7EfkzE4RurRDNaK7Dla53h3swFtN6 ebHJiW8K6xEarRowvHg21BJJhRkrGgUz7TcTos8teOYQ7GScBu5AHx4/hAgO+A+G8EAYCC6p9bLmWT uhQX3Azu8Y8rim3+JoGB/tvJ9vAcTAUH3AyLU5MWGMfUmvqRvuAqdg2eMQjQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce helper macros that wrap around the rqspinlock slow path and
provide an interface analogous to the raw_spin_lock API. Note that
in case of error conditions, preemption and IRQ disabling is
automatically unrolled before returning the error back to the caller.

Ensure that in absence of CONFIG_QUEUED_SPINLOCKS support, we fallback
to the test-and-set implementation.

Add some comments describing the subtle memory ordering logic during
unlock, and why it's safe.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index a837c6b6abd9..23abd0b8d0f9 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -153,4 +153,91 @@ static __always_inline void release_held_lock_entry(void)
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+
+/**
+ * res_spin_lock - acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * Return:
+ * * 0		- Lock was acquired successfully.
+ * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
+ * * -ETIMEDOUT - Lock acquisition failed because of timeout.
+ */
+static __always_inline int res_spin_lock(rqspinlock_t *lock)
+{
+	int val = 0;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL))) {
+		grab_held_lock_entry(lock);
+		return 0;
+	}
+	return resilient_queued_spin_lock_slowpath(lock, val);
+}
+
+#else
+
+#define res_spin_lock(lock) resilient_tas_spin_lock(lock)
+
+#endif /* CONFIG_QUEUED_SPINLOCKS */
+
+static __always_inline void res_spin_unlock(rqspinlock_t *lock)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (unlikely(rqh->cnt > RES_NR_HELD))
+		goto unlock;
+	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
+unlock:
+	/*
+	 * Release barrier, ensures correct ordering. See release_held_lock_entry
+	 * for details.  Perform release store instead of queued_spin_unlock,
+	 * since we use this function for test-and-set fallback as well. When we
+	 * have CONFIG_QUEUED_SPINLOCKS=n, we clear the full 4-byte lockword.
+	 *
+	 * Like release_held_lock_entry, we can do the release before the dec.
+	 * We simply care about not seeing the 'lock' in our table from a remote
+	 * CPU once the lock has been released, which doesn't rely on the dec.
+	 *
+	 * Unlike smp_wmb(), release is not a two way fence, hence it is
+	 * possible for a inc to move up and reorder with our clearing of the
+	 * entry. This isn't a problem however, as for a misdiagnosis of ABBA,
+	 * the remote CPU needs to hold this lock, which won't be released until
+	 * the store below is done, which would ensure the entry is overwritten
+	 * to NULL, etc.
+	 */
+	smp_store_release(&lock->locked, 0);
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+}
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t)__ARCH_SPIN_LOCK_UNLOCKED; })
+#else
+#define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
+#endif
+
+#define raw_res_spin_lock(lock)                    \
+	({                                         \
+		int __ret;                         \
+		preempt_disable();                 \
+		__ret = res_spin_lock(lock);	   \
+		if (__ret)                         \
+			preempt_enable();          \
+		__ret;                             \
+	})
+
+#define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
+
+#define raw_res_spin_lock_irqsave(lock, flags)    \
+	({                                        \
+		int __ret;                        \
+		local_irq_save(flags);            \
+		__ret = raw_res_spin_lock(lock);  \
+		if (__ret)                        \
+			local_irq_restore(flags); \
+		__ret;                            \
+	})
+
+#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
+
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
-- 
2.47.1


