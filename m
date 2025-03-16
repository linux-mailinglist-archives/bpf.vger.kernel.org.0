Return-Path: <bpf+bounces-54128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A76A63399
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC177A8E00
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD68194C8B;
	Sun, 16 Mar 2025 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TULKFKkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A86F1922DD;
	Sun, 16 Mar 2025 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097964; cv=none; b=rmKsSciqp9ORnl0FjhBu6+Dufe5YU612YZQuv26PxTNusMF3UVl9cC0Eq5YKvcvoDUxw4ZBRsQjR76i8pOeuZUK04GV4h5KlFq2QLoZC/IZEiBwyD3ZMFI4B/yVc0OCPozPXdN4mjCm69a+ThLd758uCPzWwGYgrhqA4dzCxV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097964; c=relaxed/simple;
	bh=6EUILfgiZohkAPsyvtNzcRk40CzXPZuYHAK+ukHSlzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuPjbZQLRpJXi4k9sJ4/hUyNV146WfcY11QsxK2Fs8OAsu14wHNmZQcqVq3Lhn6gQ7QprpCyAaANTNPkIfhrn+rfNQBV3b/T47QZDnaMnUSXPtVGar0lIwE40+FBoXg4TX6jIVYhL4T0fkZBAlM34jmpJ3l0bngyVpufGs9MjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TULKFKkz; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1633099f8f.1;
        Sat, 15 Mar 2025 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097960; x=1742702760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClBpfryF0l26LJucqaea+hnSd7y5tppZSgQBloKDt3A=;
        b=TULKFKkzejGgC+4zTarO0YgDxwTdK4PPPpAuNOsz4zNq1j1J1828R1yI3Dge+Cbk3l
         b35BpaRJi0HOrVb2CP029m2EujiwaQ9rrqHemhKSNoAzmzVij/0iHZnxzXCGqCdbaYuj
         z/fgoPa6f2+u8atkNJSIt50Zmlx4lEjW9sMbgltsmqr3heldJzImmkxgnddJ5ELBBrcR
         zjAkW1KJXhYH95VaSUoxuwGHGJp/9GX7agwPTzURfD0yRsZNvtdu9Mgi3vJqMAQIj2Y5
         F28wnuIL2cVz+9ZUEqJgQw3EM/P9YtcSP2K70AphfACR8FFxH7SWBnl4rrBOn/WskwHS
         dBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097960; x=1742702760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClBpfryF0l26LJucqaea+hnSd7y5tppZSgQBloKDt3A=;
        b=eCL8Z4rJLOhhT7tPs5kPw7VxqLsyVIAiaalh0TY5+Roymddy4518AFMSP36u9/L1fZ
         p+z2fMSgvJVtQbrZ9x9zD0iuMQueoADgxXtDRIChudrWhJ+Mwb+WwmoKLsBSzk9j1IqL
         n6qZPXZoyyotPbyjmJtdoCE1zrgMiTj1G4846BmsVwubVJpwPdkTI6J4WVoANrTJThJq
         mHc+Lzghw9YP/850oF5mha0QQBMTWsnsuiMg7Igf6JmCk97LNwq5JXM+AOkKYXFzJdgf
         sbIAjwGhaQVey00qaFiDG2wSg6rgiS0R9cw7FUcGWiLCbeFLCqxZxoYnaqVdfm4wcnya
         66rg==
X-Forwarded-Encrypted: i=1; AJvYcCX8r2hfBCE5EJ62EjVcRwTbIOz+EWf4mHsIuROfmBslEQ5YcYj6cPrdieIfJd3t8PJK/KB8JC88u+nSxB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbhHc5X9zz8inS5GyOnskh2SrPkHN74gMoujyYVCcUS1UFthj
	uIkv73BhGbhWoR+IVFsoea5Oxdgcc9l9KoS9mVE8Yz5f0gr3PWY+NsqkpN/mYlo=
X-Gm-Gg: ASbGncuy3SRjIFfXe/YdVk+PkzwTgxbP1L2j3sa7cNitSLGCmslFYWVDEVG4Ex3oXCB
	yzACpWtRzQzXiDdWvx3oyNnNv9KNdnuWD2h3rescYBKxaP3faRCipRZQF8kKcLiwKFRc8pzFCpm
	hMW2eL9GCe5uwOsUnzKS958NTZodBpZeQ618+w54SL9CAZgzZQK2iUdQ8cWvi4RToZodCWvtnXi
	ZmU6ID42dZ6Ieo2E14cwGU82/s724chwAKjKMeDJY1uhmwPENir6kuFM9LQetfMMH5bWievtSbv
	SvR4qtmn5QfUqUp2HS8YhWqIyow34Isdp1g=
X-Google-Smtp-Source: AGHT+IH/e6sr7Q8NtaxNCMMeZqQ+z9X8uI7I1YSl5ZwD64++FRmjeUrFOkqAexRXD/7ze8hpT1OmbA==
X-Received: by 2002:a05:6000:1562:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-395b70b7668mr13114610f8f.4.1742097960004;
        Sat, 15 Mar 2025 21:06:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda30esm68369765e9.5.2025.03.15.21.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 13/25] rqspinlock: Add a test-and-set fallback
Date: Sat, 15 Mar 2025 21:05:29 -0700
Message-ID: <20250316040541.108729-14-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4142; h=from:subject; bh=6EUILfgiZohkAPsyvtNzcRk40CzXPZuYHAK+ukHSlzU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3dWZVH4cGT4jygyYaRMgYBKoSMntnk4oFzqRKP +TJ3LmiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8RyhmDEA C1zcUyxSUagfAmjyxuovyTwYJTtWqoL5BpkcoMeatgpoXvSFS4tL7BP+3f57t/dG51OVYvBhT2RXN3 nhHuP1IuXSpAdZG+q3swIHEVfIED9SS3PCn0geldDUhkAzxMkpbZqWPwJhh4IcqZB+IWBsN7BZYtW+ eiq/JKntCpyChduNnwrkkDRMWiws3F5N+JllmYp8XC54/J48uYmiFyJaYYEUR7ONy+IL/f21dHKQrT 8xCYRQblvr2tXiLe/rj9uJrq5h9J1j+Qw16WsNZ8WDBUWx52xoX1xV1UdOS/8vQX9HCEOJ8KDbo/db spk5jmSQFHBWJjYK39tihe0CXejyi/J+FpiRzMRNopnL44+efFbw10U5IgaVjMEP9LkozIVmnowmrI jCZ5a0OfO+eZf6xAeHlknuB9N5Zl0SNEZhWh3ayRtPeF/OpHs9sZrE+CaTsjnHnh2g8vIQt/VzzuU9 bJyTo/zGSOiYSFmfYQPN3JfpgR58GeJTqb15WlpNy21ivZWR9dptXHGTECX7xeEoJ7ns+MuNnYAC9e miR4qDevVacWqmiWfTKfc8CbfAmZI//+1NKlJgfhOomrfHwGNvSEeKxTnMs0pANCDx/wKI/kHLuWqC rR72s0G1l2FIBNETNQNhbftHp/sZqx1oEyYMlCsrRgBNyzGuhAHxNLnCg7Ww==
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
 kernel/bpf/rqspinlock.c          | 46 ++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 34c3dcb4299e..12f72c4a97cd 100644
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
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index bddbcc47d38f..714dfab5caa8 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
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
 #include "../locking/qspinlock.h"
 #include "../locking/lock_events.h"
 #include "rqspinlock.h"
+#include "../locking/mcs_spinlock.h"
+#endif
 
 /*
  * The basic principle of a queue-based spinlock can best be understood
@@ -70,8 +75,6 @@
  *
  */
 
-#include "../locking/mcs_spinlock.h"
-
 struct rqspinlock_timeout {
 	u64 timeout_end;
 	u64 duration;
@@ -263,6 +266,43 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
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
+EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -616,3 +656,5 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
+
+#endif /* CONFIG_QUEUED_SPINLOCKS */
-- 
2.47.1


