Return-Path: <bpf+bounces-53084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25865A4C506
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18093188483A
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB93230BF1;
	Mon,  3 Mar 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esHjuS0K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFA222F39C;
	Mon,  3 Mar 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015414; cv=none; b=lPmo1nEou5ToT3KmkeM6ua2qP84ORePFEaMgPX+2U9FG2q9Mh8aaMY+HJ3HG6OLKH8aP9aX/A3xwPb+VHjVNSeHsu8RZz7DQm5btQOeOPa3zbDRFwNAyK7lMqlxLQVWcAo2x3LivhW+z6hHP9HTFY/iOhe+9c1f6BDrdcBMyfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015414; c=relaxed/simple;
	bh=1vN5D7C4tfoaawMuUjp7ZN+fQy3wYGzp7nrXDJHdVAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbcPSTU82yOuyh4VdiVtBdZEEC2bkcj6uZLApt12b0ca/g8RBikIO3w2bedPNPpv5NXXF0g8bbQr8+kk54o2mKEygUkcTFdtPYmvZEvHZfKJVpijYECRF0a55VW9DRnx14NHHagoK/XFSj9QKtomQ5VE9WYVcVaD5vUw9pplt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esHjuS0K; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43994ef3872so29737585e9.2;
        Mon, 03 Mar 2025 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015411; x=1741620211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIFRymfR26T1V4pI+hLoHtvRY/1A7N6xjkuyA7wDGHE=;
        b=esHjuS0KUnRgpTrqDEV5y+TmxAwcmkjCUu9AkzwFK2Pk+WhPBiCOYwT4MrDO6Hs/RL
         P2YhT+kzmLdmHfP/OF1irzYkQwNiGS4IwX+7wAWa0LIq/LuxP+DE+IpK3sCfLs4UPvzi
         zdmDYGVgpalFeUBO91K9NxfyrQ3T7MA+O+OiPFPR7CEkdvzudPdoze9VkIJOkFcmx5cs
         UaHtCg5ebXkSpWYsUP6llSGIkf6652Yn4f51caXIyc1CE5vCXN1ldAh9UE/1b2zh1WZ6
         cPW8I3TcW9MfrVoPVAVUumNfB5vVc8josPWR/wjYU6B4oCFlrXt5ZsVyx5Ic9Z/dJI8k
         xyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015411; x=1741620211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIFRymfR26T1V4pI+hLoHtvRY/1A7N6xjkuyA7wDGHE=;
        b=fzG3TadPoQEStJiCIiwzZQc/GMxF3JyfUVUHxHP1ZdlWZxI8h1kbEGqe9M5NlER/Id
         sK/x7LzMekZ1hnn1hZEt25DD7ClQkmOhZBo7W6vhmslavY8s95kNRzu2DPaBnd6rNYxX
         Ct8sC43pSEIdKw+aN9CnJ+yJWzRmRMu4QpeedlrMSP7kWa1FBAJY+tOICjwsXJ/lFFwD
         cEV4TNtoIWB9nIbuhwR7EbtjgslAAfgL10ymArzjujCpdKlyZ36a7xgCckfc5PJAFrji
         q3mylCp4xgvYvIv8zRC29sFa82RhZ/iwyq1JPYsMEZrOThZJO+sftaU07zFZU9tglBqh
         u0bg==
X-Forwarded-Encrypted: i=1; AJvYcCUdV55WfzqjYBNADJ8hg5UgZhtfO3YNWojbiOlw23sc06Vpooy6C7+LgEzxlOukLwAnSy+1r91cTgH58jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJLpQHRqMeKVBlwtTPRrenp8NbidG03yhwwfoxcvloJL60xUHE
	IApFHsk77cvaN8k8RXIp65z0iWwHplA3/+YWbLyrO2pFbZgdh6edwFYcI6JdtOg=
X-Gm-Gg: ASbGncvXuQzR4QSBBk1DhmDQ+85RJQvVZuw2+9R3ucw23TtLQnhn8UUpBLYQ/98O/pm
	iqE/SOE+N+914e+F3Mnr1EgRu2YeOkU0XnIjEzC4JF2usYK/BaUlogbfHlhZKqud+QBF+5Vb5qw
	5p3YJu101uuE2P3PDaS84ROaYPYvBQIVRRYD4vqrK3ICKGxDMxkzM7OxBNqih7zUYwvZNM9qV8E
	okmpSy23si6d3AQDJPXTXr1sg9oalHSC9Sq2pgrNylTC6n0d4f2qugdnqxUmckyoFu4xs2Sz8yB
	fD83Wo9iNJs+DBZdDgJ25x33xsmocuY6jg==
X-Google-Smtp-Source: AGHT+IHhLXGjzf0udnyNXtByFw5OFSp0rn67LfLvjV3YqWbj0wvdktay+P0e8RZUkjfn4MvH3tUgiw==
X-Received: by 2002:a5d:5886:0:b0:390:efa5:9f6 with SMTP id ffacd0b85a97d-390efa50b8dmr10698291f8f.51.1741015410709;
        Mon, 03 Mar 2025 07:23:30 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dba4sm15037247f8f.92.2025.03.03.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:30 -0800 (PST)
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
Subject: [PATCH bpf-next v3 16/25] rqspinlock: Add macros for rqspinlock usage
Date: Mon,  3 Mar 2025 07:22:56 -0800
Message-ID: <20250303152305.3195648-17-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988; h=from:subject; bh=1vN5D7C4tfoaawMuUjp7ZN+fQy3wYGzp7nrXDJHdVAo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYD7W48Zy4MCJ4hC7Laq1GOwnd+65hIihP1XlI Lb5c/6OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8RyvneD/ 9CSceH24BxXpHlqBvfIHao0z3PNag/hh6hxWdzMJtXnIupGNQZXotn7KA2u9LloczdUDTDU6i5vyel pyxYLhk/EO2NcmqNvsUhMnV5AQmt3i0G4X/wKGhsKXL1avILr8mSIPCqUG6RFfbDQB7MpnGHT9wsVp cQasSdKg8ZNoIJzBhiV64wzVF1LDmN5meStwPmrIfdXHD02M3uHizakkrT2k6ueYJNn2a4tr/vVKoU iRwh0w3G9w3jgipmvotAi+BjklTirlbzwjKDUdCWzM60WlU06NkoPlkUgR2q9m+804yz5qTMaenuPO mDGBty0syn+pois9BdJv0UeaAwoksZN74YC6vuHDh/6BnSK4mOisuHLP/D7iby5FHVL4tFHia6FYXq 0+DkRs/a2OqWFTk+o+cN5A+NCwpDIUbZfEc88aigLqitRC4eJuZQEHywIriAiRmy9ImnyJodlammr7 s9AjvCAzf340XzmF6Gumn6IbMHZb4p5hLT33cHlh7X1AjJ8RCiWQU9k8Q+zrAYThzoK/jY88XCaIjI FPn+NFQHv4b/Llf94bia06KjI0S5GgJJFxeSqmSE2wqAdn52bTxowHvRwOUwjeeTpXHaxYnYDXqa7m FXdZOR4Qg1a7dlf/djjyVfSDMq679lEDbrl1aOKGxNSRnLgsYeiMckHq9q8Q==
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
 include/asm-generic/rqspinlock.h | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index f8850f09d0d6..418b652e0249 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -153,4 +153,86 @@ static __always_inline void release_held_lock_entry(void)
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+
+/**
+ * res_spin_lock - acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
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
2.43.5


