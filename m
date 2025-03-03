Return-Path: <bpf+bounces-53082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DBA4C50B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D961633FE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D338A22E410;
	Mon,  3 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if2UKnKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767242144DA;
	Mon,  3 Mar 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015411; cv=none; b=L74UweeZsizcJtdM2e2TVeXp8HbGXOpfQiXppnaN/EVqBiHbiAGfGGW5VItyvce7q7zFSZy4aGSeez7Tqi2l6dPO0Nx6deIzdQbJSYsotSsL0Nl50EdqvFJZhI1hnY++2xAHZ4Kn4dIECvDyBohgsLhvxdd29UYZJ4ZucUB4uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015411; c=relaxed/simple;
	bh=o1MKDNUhE9EFH4RwMPASaZvJKuJrMCZ8uocCQm849Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8K1Ci0Qf+JbVPG7rNJA3eEamLwcvhem4/r4xxZ42QxukbL+Eq6bIz2atjjxlL+5LPVCFhpTdTH2FAmwN8qoQHq7YM5hMWb+nC0spNXikebfxtcIy1+KFaq5IixgPVIsPdQVuVfLlb7hHQme39Bpx7vSCasCbSKD0ssupgU/GPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if2UKnKk; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-390ec7c2cd8so2125332f8f.1;
        Mon, 03 Mar 2025 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015407; x=1741620207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Narwm03ehkHlcNbrRom2a3WOE/jJ7XHKhd4vuGjJYfQ=;
        b=if2UKnKkmKtTN+nRd8KBMZL9tSyE2nMh+MkKabwRqw6KdaCqGAyZoNWiw1CK2x5T+o
         O3b3EDVoq96b/fVgqHyH0YFJ86YAcOZh0giiN6vx9XhMKyZUrTtgXQ1yTn50+8jqTMfl
         K4rrPzkA1mEAxTQDHW1gLTay4rDwfAUVP6SNDkzsdI48weZL9J6VuTxS67fe6O907LwJ
         y7UtDts0jga0c8zhJ8NskTuolRfwEgWyMhmDzb8cNIs3UiWh8ALOYrLI6ZhE1IAQVtK2
         3Rz4QxM8BNPMSoqbdJni1pxvUi44shZuu2IzltI2eGlVFjkuCH8h7tR7dcolKn75/bu8
         3u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015407; x=1741620207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Narwm03ehkHlcNbrRom2a3WOE/jJ7XHKhd4vuGjJYfQ=;
        b=gcBgEKjbq5qGU6kBI564fZB4I1N1rM4cwOzo2WN1c6y6AyZdFVakxRK2Lb7OXjjR+7
         eoiOdj4DseEiDL8Bxf1T9Z/7z5sXdcXFPHQjgS/Yao3yXzcqES9hrDMykz9aZBuvLRuj
         R6MrU+i9d9KoGecGtXhPCs5hnIDFiyilwPiVkuBp6zlJoZgODaj9ieSnX7CNd8xCAb6f
         hOErFqNYcSdTYk45HmxxvuCHJ9YWxkBNZ7F8RiABe0r6wpbVj4SG0v04EnOhxNSwDL7s
         VgqBJc1W/D+e07DvY2l1S9sBVUMMVweKVynnlDtPTk7M8YTOCw0fdXl9Batluzfnclta
         42Og==
X-Forwarded-Encrypted: i=1; AJvYcCUC4uCpoNSbC0tjc5dwu/ld1ijwxCbKT1aJzSo6J127pa8cem8nweSUtHzEZqyxNktOuQca8ib7CzFUPTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSdGDWoaZRgZjLij3I1V5KJg6ksW2Unf2SfsfJsi3RSkpSWFX
	cmKuypz6tsbIk17vIr5O1+iMfoqPc1JmM+g3sTlAE+AdwfYZ7tnBSWlT4/eJZs4=
X-Gm-Gg: ASbGncsd7frVPbtj1TvU+puz76lPdgONbTsZ6rHoue/CkpCICjevifreYQ+k8H60lCe
	0LH+k2uf1I+d96kCludPzlFfvn3q2Kqc0bUv3WVMUrVbGMK+bAE0yEtmNoOUAOayAcrIrSkOmi6
	Yv6LF1e+czDUOXQPjnLm7fdahMy759XRUiSl8FTmO9fiKSk5exGwcY0qE3sCQNgN3HkbGZKMPKY
	WERbJTbeDnDsYjY/nC4sqkd6OHFuXNlZkIq83jxhoj+WHfxlck3zYGuBv9yZUETlaB/k9O4HijT
	QglEiE/bfClGSMdbebIQNIOJwv3jTdw9mCQ=
X-Google-Smtp-Source: AGHT+IHQPjApFZs3HhsmlujTPNCDLSejJ0ltemem59qnL0CWos33mq2nn38IumeJ2bsiNZQ67lldHQ==
X-Received: by 2002:a05:6000:1f8d:b0:390:fb37:1bd with SMTP id ffacd0b85a97d-390fb370470mr6319805f8f.46.1741015407243;
        Mon, 03 Mar 2025 07:23:27 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm14509941f8f.88.2025.03.03.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:26 -0800 (PST)
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
Subject: [PATCH bpf-next v3 13/25] rqspinlock: Add a test-and-set fallback
Date: Mon,  3 Mar 2025 07:22:53 -0800
Message-ID: <20250303152305.3195648-14-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4064; h=from:subject; bh=o1MKDNUhE9EFH4RwMPASaZvJKuJrMCZ8uocCQm849Ik=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWXyKg4wB+6V7Ple/tkprfUEWpR0Hl6dgveKapl mmrrb5WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlwAKCRBM4MiGSL8RyrORD/ 9X6zKnZ50odRHn/aTMB5eerXFYbZYCFEA0zhWN7wOz/mXTLzA+cu1Kx16cILZLnewteP+spWp6TfeG oO/uEEbmEQvn0We0uAupBYIt8VRyjDPQs99CWCu4QGxc3xxkMS5+mQTJ2ons155TFMD85j8Vt7WBeN Gp3Q7X7RM7uzhQ4y+EgVeTAa8/W6GwRYnV/14RG89yraqvQIzLJtA/BHAHhJwp3um17ldvOg30GGTG ljTKl/gZXoBY1wmcLDkkukm03I2d3VP267EdahhXrctgXkA3dPZCyVzJg/lHJF41jU28pRqEqdU1fZ NB5PW9KYd1XzxvhBhwPdgXR2qunX1i8LP/jJn9SDb6JtxKugtHFL9y+ODarv6pIP3Of+NZLd7dwdtO cLPFwRPp5fOfnOfrSQBkPYD+CksR9o5ApDj8rMEimbPEIeKSfuHi4JgiExIi0TmcmH2AHxW+M+Jons MY9cSj6MOAtu7gTUDpDFMkHrkip9TL0zZhiW9CJHxYfOVZLWIFlgX00dUWHbzWPbhiRM6gc8tnmL4e gYYeCoy81wYg2HhX5/dCjB6beylFJO8aHhgT+X4oqKJx85F7LbFa6OameusA/gU2YMVg/nDYQKZMxs TIUKm5h4/2zgx4el81Kce6UG+hDPxefexA5tXAA1BD6DWZNiRUU8p7hniQGw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Include a test-and-set fallback when queued spinlock support is not
available. Introduce a rqspinlock type to act as a fallback when
qspinlock support is absent.

Include ifdef guards to ensure the slow path in this file is only
compiled when CONFIG_QUEUED_SPINLOCKS=y. Subsequent patches will add
further logic to ensure fallback to the test-and-set implementation
when queued spinlock support is unavailable on an architecture.

Unlike other waiting loops in rqspinlock code, the one for test-and-set
has no theoretical upper bound under contention, therefore we need a
longer timeout than usual. Bump it up to a second in this case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 17 ++++++++++++
 kernel/locking/rqspinlock.c      | 45 ++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index b685f243cf96..b30a86abad7b 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -12,11 +12,28 @@
 #include <linux/types.h>
 #include <vdso/time64.h>
 #include <linux/percpu.h>
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#endif
+
+struct rqspinlock {
+	union {
+		atomic_t val;
+		u32 locked;
+	};
+};
 
 struct qspinlock;
+#ifdef CONFIG_QUEUED_SPINLOCKS
 typedef struct qspinlock rqspinlock_t;
+#else
+typedef struct rqspinlock rqspinlock_t;
+#endif
 
+extern int resilient_tas_spin_lock(rqspinlock_t *lock);
+#ifdef CONFIG_QUEUED_SPINLOCKS
 extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+#endif
 
 /*
  * Default timeout for waiting loops is 0.25 seconds
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index ce2bc0a85a07..27ab4642f894 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -21,7 +21,9 @@
 #include <linux/mutex.h>
 #include <linux/prefetch.h>
 #include <asm/byteorder.h>
+#ifdef CONFIG_QUEUED_SPINLOCKS
 #include <asm/qspinlock.h>
+#endif
 #include <trace/events/lock.h>
 #include <asm/rqspinlock.h>
 #include <linux/timekeeping.h>
@@ -29,9 +31,12 @@
 /*
  * Include queued spinlock definitions and statistics code
  */
+#ifdef CONFIG_QUEUED_SPINLOCKS
 #include "qspinlock.h"
 #include "lock_events.h"
 #include "rqspinlock.h"
+#include "mcs_spinlock.h"
+#endif
 
 /*
  * The basic principle of a queue-based spinlock can best be understood
@@ -70,8 +75,6 @@
  *
  */
 
-#include "mcs_spinlock.h"
-
 struct rqspinlock_timeout {
 	u64 timeout_end;
 	u64 duration;
@@ -262,6 +265,42 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Provide a test-and-set fallback for cases when queued spin lock support is
+ * absent from the architecture.
+ */
+int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
+{
+	struct rqspinlock_timeout ts;
+	int val, ret = 0;
+
+	RES_INIT_TIMEOUT(ts);
+	grab_held_lock_entry(lock);
+
+	/*
+	 * Since the waiting loop's time is dependent on the amount of
+	 * contention, a short timeout unlike rqspinlock waiting loops
+	 * isn't enough. Choose a second as the timeout value.
+	 */
+	RES_RESET_TIMEOUT(ts, NSEC_PER_SEC);
+retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+			goto out;
+		cpu_relax();
+		goto retry;
+	}
+
+	return 0;
+out:
+	release_held_lock_entry();
+	return ret;
+}
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -610,3 +649,5 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	return ret;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
+
+#endif /* CONFIG_QUEUED_SPINLOCKS */
-- 
2.43.5


