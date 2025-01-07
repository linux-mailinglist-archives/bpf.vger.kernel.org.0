Return-Path: <bpf+bounces-48112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E164A0417F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D3F3A24A4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E52F1F428E;
	Tue,  7 Jan 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mST7U2fu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AF1F0E2A;
	Tue,  7 Jan 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258441; cv=none; b=Hp3121cRvt1DO+OEi1R+rfBCKmkXmAF6WpMUT1NW6qlrOwcwVaNJTGrwyV1jmyb+Mjdg6oEe9fcIHb2dQtImWm4+mvAKc9dtOVw6p+Ko5DsMdPBeeUFotPWSs8Lmss5I+Wkn/C70V3fiub9VUfZcs1gHYpzXSREFbJWgnZL9V0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258441; c=relaxed/simple;
	bh=+LjPicSWkajqb0Xpu6IbfX5g4qiRLkXWCPBEaqfWN64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmHuwot803NzX26sYpXW4QO9SLhGI8YZKhccPjrw78gve15aMO/wbTSYshIsXNWqjb6+yXU8E7/GeOciIy945AXllZDDAepddMXza4aixRbNedsyDT6dslJd3FJE04WUfpe7aa9RKnY7suHlIx0VOG6/OTQQknGUONJembDW/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mST7U2fu; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso104023715e9.0;
        Tue, 07 Jan 2025 06:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258433; x=1736863233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyCQ/b9Hwl1sjqi5LX92l17x4cgrzCtqffije6Lab+Y=;
        b=mST7U2fuB95PWvetwS5+KTmsEG1qg3Pp7SNUjEoP57rl1UrzdemYKXfkVHS051xiFa
         5/HL2SgyERsvjLD71ADXr5B6/9cXsFUgP9BFXDpoePVTJXj9yGZVfNlYAZYl3dOCkJno
         +1XjBpL+ipatTY0uyKT2hc2KLKPhtQGF6/hnqZU47RC4djA2gYq7ZeXTvDS/wM2BhW7I
         rquteIqXPVwNC2Wp/2omEflQSioMbvEASedMJoCZTgeFcNKGzOUMq8/gpRBoiopAKICi
         GB7DTzffOE1tMrcpxpqljpASFq9DfAPnGXK+N1P3l8k3oyHBZ2IzsJua2U5wYNIwH3Qp
         XHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258433; x=1736863233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyCQ/b9Hwl1sjqi5LX92l17x4cgrzCtqffije6Lab+Y=;
        b=JeAtJ0an4nZ2Xf9prornlcx48J/ccGUX2u2NqcubvrS+f9Tijjmj74vantuaSGKVE0
         L4SiZnrGuc59hbE9yDtNI6ly84YTbbgruX4ChYrF2NiQnBJl+hWuK/tEivL4jZ8qhzi0
         zZrh3IVofvU+/fIeAYbfLchNj7DgMJd5kUlja+nAsf+H4DlQII8gSf3uh40eLoLWcijl
         HMpboRb5nY9qdT1JMJ8it6oNGQ8RdE8ckGL6AqawguaWc5YRrJTwX5X4nK2MIafGQb/L
         MFln0y7hyvllbknhMCByMIXlyXGZIQIXgZs6YprNWnYJqz66kmKclfPCGT9ZzqD9Kqq2
         tCgg==
X-Forwarded-Encrypted: i=1; AJvYcCVgEH7Gj+grCZ079lOZcfANiKjZ4Os7LW5JE7qvqWUG+Xr/zCmAsQHUFmUcmd9v79o84rqMF8wyar1yzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzomJ6Ujj7oNt6vMYO01F31jalraNCThFGn1+WxXCzFqmD2TL+2
	eb3Q2QxB1SKQ6+e+E0px/X97tBOXKtAUA3xYV28Y6NzfHge8GriZfAxdVVAUf8UyrQ==
X-Gm-Gg: ASbGncvpnlw68TER7SN+Cqfxdxew+SsT6T++92hP9hRjRZ7hyfaYLiSm5sygr5+0W4t
	CxqLe6YGkl5M1pVjzQr+QQcCe+lNy+K3zBT/DTVvH1AmZn8FRdDSd6YyXFtw+VUiriZOX9WioWK
	6DFmuxxdzJfuewJkcyXjCw9g+pet3bBScHJBEQL5FyUB3RHlZmPSAZTaooaakwH61tu3cEMerJk
	ZT4ZokwxIOrE3/P71ImPI5L/JQjeNCC5EwMh/hJovm9Tzk=
X-Google-Smtp-Source: AGHT+IEoOtzaKn9Hqerbc7iyfSKnixD4sPkQhM5aoAhUWrNCcXx9tUDa+tCHP3fa5ikF6sNyHEkU4w==
X-Received: by 2002:a05:6000:18ab:b0:385:e013:73f6 with SMTP id ffacd0b85a97d-38a22408c41mr43988884f8f.50.1736258431536;
        Tue, 07 Jan 2025 06:00:31 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:18::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ac97fsm49838266f8f.92.2025.01.07.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:30 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/22] rqspinlock: Add macros for rqspinlock usage
Date: Tue,  7 Jan 2025 05:59:56 -0800
Message-ID: <20250107140004.2732830-15-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; h=from:subject; bh=+LjPicSWkajqb0Xpu6IbfX5g4qiRLkXWCPBEaqfWN64=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCePj2nHYP6pfgRdaD9WEGv4aJ0AuKHRXa8C0Wd tgrlumyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8RylSREA CBV3QvbmPWrun/4G/yhVb42L5Zg9tVBotobyB8aw5Xqy4t8hYhJfqG93yUROGUMhP/R803YxDPUOW5 4dXL6ET9GQ7vzV8eXd40JmN8ds2kGQhChELZC1Cic6ezd2O63V3MgXlRoQqSm51pb4OMi9h2ri+v4k oKXcURtM3Ds1h/wXb6gx0v4awwm6EggYSTpWHHGsLVfxesEOSNToVFEmG02netYfzgmbkGNUeZ8Zxj wxJYgU4e8WKK0zPK7rwwo636SaIBK5QskO/uv0fLx3fc8x2NvIibDlFjXtW2QGuQVUZx1uYwQm9qYe I364nLFCqqiNtZJwqLlEYxUz+PO9v3bONHmYmRBPUKJYUlL+t8fcDtW2wauYKsDK61+4UZgpL741pS rMlaKUwiBOmOOGBZI+5WVJUzemrrB2+GXVhEQ+6v00edfpJ0Mu7X7VskrVNc8Er5pthrvBuzQ1P8zZ 06PP5LA0v9dA4yOAoKEbit965/bwjsu5s2WIkj6bUhqqzsgtgqMeWRVHzu0sDkpzRjYmrNTMwh9WzW 6EicSg5xg3XEWTFkAF14HAa5/9KMyZ/ew8D7oxhOGR2FAPUkrewOP/Us0cTgWQKdfr/IYoddjFekOK SkJKo+eeJtZlpzJg92OXBnB5JNeZBNj6D4aLpQ0kxNLMBrn+AuVbBjaztthg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce helper macros that wrap around the rqspinlock slow path and
provide an interface analogous to the raw_spin_lock API. Note that
in case of error conditions, preemption and IRQ disabling is
automatically unrolled before returning the error back to the caller.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index dc436ab01471..53be8426373c 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -12,8 +12,10 @@
 #include <linux/types.h>
 #include <vdso/time64.h>
 #include <linux/percpu.h>
+#include <asm/qspinlock.h>
 
 struct qspinlock;
+typedef struct qspinlock rqspinlock_t;
 
 extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
 
@@ -82,4 +84,60 @@ static __always_inline void release_held_lock_entry(void)
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }
 
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
+static __always_inline void res_spin_unlock(rqspinlock_t *lock)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (unlikely(rqh->cnt > RES_NR_HELD))
+		goto unlock;
+	WRITE_ONCE(rqh->locks[rqh->cnt - 1], NULL);
+	/*
+	 * Release barrier, ensuring ordering. See release_held_lock_entry.
+	 */
+unlock:
+	queued_spin_unlock(lock);
+	this_cpu_dec(rqspinlock_held_locks.cnt);
+}
+
+#define raw_res_spin_lock_init(lock) ({ *(lock) = (struct qspinlock)__ARCH_SPIN_LOCK_UNLOCKED; })
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


