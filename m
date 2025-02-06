Return-Path: <bpf+bounces-50649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E95A2A67D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FAF1889383
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10223099C;
	Thu,  6 Feb 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBk2H9hP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E322E400;
	Thu,  6 Feb 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839302; cv=none; b=KsJELJGzsZg3Lp94ZkZeEYC5WUVyY708HqLGRFNUwsSxbFhMEfSu0kyr+tyLcW8+gst9l84yhO/UXYZ86mqEiIUKTmrpOwsQw/SQfP61vyV1tTNf0pktq9W+gPochMt2MgAmaPtetnRrR+5yokFwP78qpaBo5Smn4175DVd4Eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839302; c=relaxed/simple;
	bh=itMjJLB45N5MLJdgdgQDHOOS7VmFDUaHlV/BKezdr3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUXxM2wY8tnrwxHdSbqNhzZtcs2euyIvOpfKUnlRF6zwaU5bggm0xhCRjTOjXKCva0cvG0VaUE/CHyenn1Ey5mzwIR1gc4UV9ZbPFRj4EBic6S73JDk32qvALnIt7eu08hRUZsOYWBDqd+2yKJubJqyBcMYzWPK3QBXfLAwgu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBk2H9hP; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-38da72cc47bso558595f8f.2;
        Thu, 06 Feb 2025 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839298; x=1739444098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X1+UYLXLNf68smwsb01lX6eFqtHiz/IPso40v3JOxM=;
        b=MBk2H9hPtikCu9S4CJ1dc393fliGxfmwrKgiBA16IPei5Iqxnc/k8lsCXyw70xc93O
         M4tb+HdP8o6evN9tGF7g4bIJaIZmKxzbyb+yId5roUDQyieuTN5NSZnzy/pxrWyLp7I/
         JHHmOacm0xxME0fVbCDZBDfPL8G+6wn+ws6Xan1Q4/v5zm2Hwr3DX96WccDNchoA7969
         lWAt7CMDctFRuKnPihjFe7F6VIi2wnkXHjD9vFIdfsglBT0RiMLuLQFup0X+CvYji55L
         63MMy06QmDVzhQEBlqK8VxbTfRxl1vKwowtPS3n11+2iSBvoaHcrzhhpHXdLB1OGUZsN
         kgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839298; x=1739444098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X1+UYLXLNf68smwsb01lX6eFqtHiz/IPso40v3JOxM=;
        b=Iv+xWJJ8D+1dqxP2YIrgJLKFfVHaZHhYOXA/485ycE+LBDS9Zt7BMLTJf33GgZ3vmH
         KPoy0CjUT2uYm9PbDQqiukE8RVBMD/tCfLzT/NRBn/nU6EHcy3h5/LxDh+ic3our6UF7
         4KJHTC3P8X4s0QzaPQHfLNjEsx5aysExytjL9G2naR2dVkI7nyAsDlpQ7S4/0UyWXfSc
         HZ5k68RZItEacn89rlDuzcRGTuqRSLiULMtli+H9XGk+qekd7Ejh7rLKoewX3HK7gtxH
         bghP1f21Aykn600tCyGFwa1jvMegpW/lcr2SZUpPxRe4QKL1kD+veMx0ip1VCEkV0aqU
         DsQg==
X-Forwarded-Encrypted: i=1; AJvYcCXeXiAR0d4u1J7G2S29wFwLvp3t8Ltn3ht/apt1Ol+XSKhE1cK3/vxINJCqJ/Z5wv9AoC0+CYSUyMGw6Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnlPL1KYMU3ooWMszTcwAxEJJxCd2w1aul9iYlqaBczNVj+9bn
	ki2X06075b4qV61pYWPEhsCEvCnyP0PXSggcNjjCMAPLeRnrj/1iULnckjNMeKU=
X-Gm-Gg: ASbGncsQai+W4u/0CGlG7WhOLcFY5ctB8rwbymPC5WLCqIHfwVJSj86bNMFCgu1zkTn
	asttklAGomAp368am6Eshkiv2xonPR+4Sxd6dmva4e/2OFzcbxNjcKT55b4t9ut4bUX4ZDG4EF5
	6Inm4oHfhHIpmBjzK5h5E+TE/SkUTndghg3eVU6rIiF09o0UQnzq3yT104vvri9Tshpt48faDFu
	TxbEFzfJibC2HEd7gT1SjXui1qc51YBv4jDHTsy5BGyOZ5UX3CYqLUvEtls9rplFqAMA2xKbqBv
	m7e1lg==
X-Google-Smtp-Source: AGHT+IHFPsmZFGzMQgNIZxyin0+PS7DDeJ1kbh/KGqhqHLUU4fvdAQOI2sLLSlmyZkzlKcZIDN7WyQ==
X-Received: by 2002:a5d:5222:0:b0:38d:b051:5a0e with SMTP id ffacd0b85a97d-38db495f8c3mr3602518f8f.49.1738839297924;
        Thu, 06 Feb 2025 02:54:57 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:16::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd36776sm1432693f8f.32.2025.02.06.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:57 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 15/26] rqspinlock: Add macros for rqspinlock usage
Date: Thu,  6 Feb 2025 02:54:23 -0800
Message-ID: <20250206105435.2159977-16-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270; h=from:subject; bh=itMjJLB45N5MLJdgdgQDHOOS7VmFDUaHlV/BKezdr3U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmSdisG+iOEzxKLgDdJjXZN/mncOFg8pv5dO3d bZNJg+GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8RyqPRD/ 9gG2FU1oHAJPUn4UJ3fwKsuQm4i95ajoiPlT/m5kT+DPF9gSa+xO4hKuGYliwEJvf+nuxUe7FMhCUo nbsTx4KiQesdJvFLBEyC8lMRvIh0qaD//aym3Fhb4D5zAgaUBULNbyDh5gj/mVvu5FLRbI+DT3LJmw r1bostFusx1GdFieKe+yhrTChSjrfqKbnpY9R/8w5UkGN/g+vLsyykEbwnbgHhL0Ycvk+yqbXaob++ hWud3ejpfkcyQRqDBeycTn+q3cMN4T33wASR6VfBgNAggDQplTQ0NL97l+Dn3qdgtj1L8+PzWkyEy7 uzYnLPsU1re215zb4P38apAspYJP0lf30MOhhmObWuxKLqtviREsn0uOBZNsmdc4R3mfydqsDy2K3i fXrNShGCY4YJFjLqUeWDnW9g2IHVA0Y3GNq49DhGgN8ZGExFHkkLHKfWWt1vd80tJx+3FcaAcbrHN6 jqnPSeoZw9H/Gv0GIoXD05hjLkUhPcZYt3gM2eUbE0LjEPwU3A1PAq0320Z5j0ZxsuHnEQt80v5ElR 1N2IG2VJNeILB6c4gNBsyn59IW7xvMo0y6wnEpgTgAJHBxYZqffi0Js1mYt58TEIo6iaH05Sdjgvz5 U5PZ/7rUM15c0KeEcHBAwD6NKswh6LfL192Y9X7h+EChg4E+eQnBkpyXm7gw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce helper macros that wrap around the rqspinlock slow path and
provide an interface analogous to the raw_spin_lock API. Note that
in case of error conditions, preemption and IRQ disabling is
automatically unrolled before returning the error back to the caller.

Ensure that in absence of CONFIG_QUEUED_SPINLOCKS support, we fallback
to the test-and-set implementation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index bbe049dcf70d..46119fc768b8 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -134,4 +134,75 @@ static __always_inline void release_held_lock_entry(void)
 	smp_wmb();
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
+	return resilient_queued_spin_lock_slowpath(lock, val, RES_DEF_TIMEOUT);
+}
+
+#else
+
+#define res_spin_lock(lock) resilient_tas_spin_lock(lock, RES_DEF_TIMEOUT)
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
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+	/*
+	 * Release barrier, ensures correct ordering. See release_held_lock_entry
+	 * for details.  Perform release store instead of queued_spin_unlock,
+	 * since we use this function for test-and-set fallback as well. When we
+	 * have CONFIG_QUEUED_SPINLOCKS=n, we clear the full 4-byte lockword.
+	 */
+	smp_store_release(&lock->locked, 0);
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


