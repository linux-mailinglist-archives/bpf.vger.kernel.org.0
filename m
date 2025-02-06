Return-Path: <bpf+bounces-50651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38374A2A681
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16390188795A
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53822FDFB;
	Thu,  6 Feb 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJHyOU5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386223099D;
	Thu,  6 Feb 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839304; cv=none; b=fYRcsZFPioB9fzlT31WzHx+A78oNeg15E5JOOCG1PW5Nzy1D8zKyyKGce9Nh15n37O+8Zfp+vW0Zj+ZOoolwUcdBWMSUjzJDUM7ianiO1+pdCNlz6RNF+kBiSgESbPINzVafNOLYQwPSOOdZUc/PYu/Qd4IQ0zO7eTOnnQ4CNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839304; c=relaxed/simple;
	bh=qYphScagVacMZI8xAzQRuNOSyn9/aS/2qYdw+lGxq8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNwOCAOzRGT1NqcFPZvC7drXZOXozIuzaS0kN+Cu8CuGP4ktinorw7CtmC4PA4VtbjYmwwdZmpPFQfnmI0WVXsEdnqPaiVd0RNIlZM0k/p+Sl1Dvk5cC8dVffb+7hDIHjVnL/ZTim/MGDqwFDisE1vXY3eK2oB3l0lhvVKI1G3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJHyOU5e; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso4508905e9.3;
        Thu, 06 Feb 2025 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839301; x=1739444101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz+NS5T4GU+VbAH0BNt16FcBYOnl5PXsvLXnbwAi+Qc=;
        b=IJHyOU5exJy6tBg+2Iq1wln2wZiqd1j3p1J/XnqH8azqafHIpjOi8mGKmq6kZgQb17
         swxHz+UsNucM3EZvyqR5b1O6t/Ew63d6N3Ai9+v+neUXt2MBDsdap3GAnWbOdQdMNcOC
         vSLDFiyzRt+jKKs2LXyrFvh5STUe39jOYLqoLyzjwCQ0y9w7cSsSdGp7pgUl18eRT3hS
         M+08d2pPGuZ2APCyE8C0HHDfii0QTEc+FkJ5vNhZScNy/r9/mQimaeyX1TQCZ5bKPVts
         QzCWB3Nt4QCkn+c1/zFtA3FcFgsnhOukr0okLYnpXJEMCb2jfQANfanQzplpdE5aObJD
         Gc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839301; x=1739444101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz+NS5T4GU+VbAH0BNt16FcBYOnl5PXsvLXnbwAi+Qc=;
        b=uyG6HCG/tgZLrgVGAOBDKfvLBOB/WdVcCPwYhsytb0+q+J2y0hXPb6dXNZi9A+Lied
         Jt/1I54fB0jTgieL5PZW7ErUp7QaVLctqzIW1ap4qiLud3dXqJlDswwNt8k+jEWGn8jV
         XiDcPUEoZz/025n7qOtnkyo0yWQZRQK9NkuEsoQothahQ3WPFZccXedgEtW+jJvgJs0d
         1oUVk1yGYfVn6z70RGscQQJG3s3SPH5LoZnuU+Or8vzMEXVqa2i9uAHlpcVWdFxbVSca
         0/mqYAzFHihChPTRGxpV0fYXZYLo3Bm0F1zy5IsCqY4VOw7Q2ZwEyjZgAhSZdNv8+uJp
         Ly+g==
X-Forwarded-Encrypted: i=1; AJvYcCVhtiI9jap7WMnlMVLzOtDWGgTr3aRDBnILcyw/GP4XygVtT7r/Yx9Yaxr9m8hLfpfJfyM7rH76h2I2GX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBjLSpI3snGz0a9WDsEXjCRQ8ukn2tQkBjbjVc3vPgP7ku9rX
	LIhC57RD+5asvwj4YOdpmaGqPfkI5vissPl6h4OSxc7FBJn9x208/37uCtnbLJM=
X-Gm-Gg: ASbGncshDurRLAC5rcB8uzK5CZfepiE5HpCTJ98PBSnMk6yl3bM0ZNeiLhNETmUBYTT
	fpPGuWzJiGG6OQNv6uTyLNXYRDOvMckVEa0Ge4V4ocVBrPdDhcWZaj6T9LGWoDXjh2/G3NWZVr9
	DaaFE50HTSgQQwLFXa6HKvZHIUjObuO/Ljc/623y09MUBxPH6qeYwFLRrUc1iQviVTNPV77/BLE
	hXbV3O0MuEQrGmTmWV4YHBndPaFgTljovJTav2YDoMEZm6ayo5rBH0eHF/g9w1S52ApFSiQUyMH
	fbifww==
X-Google-Smtp-Source: AGHT+IG3YUH0oYkY2WcU9nkb8nClyB5AjNsFI6WIkNWS0fGK3jGoBgR9RRDJA0dBgbN9twa+WCc61A==
X-Received: by 2002:a05:600c:1c87:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4390d5611fcmr49163655e9.23.1738839300786;
        Thu, 06 Feb 2025 02:55:00 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:25::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d7c7sm50627245e9.14.2025.02.06.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:00 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire loops to asm-generic implementation
Date: Thu,  6 Feb 2025 02:54:25 -0800
Message-ID: <20250206105435.2159977-18-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; h=from:subject; bh=qYphScagVacMZI8xAzQRuNOSyn9/aS/2qYdw+lGxq8I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmEQyiG868iJLdTJeV5rNF45XJkM3pzaj93Qpc DMdltmaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8RyjhAD/ 94L7gwFOANgho2OHK/jFtxh/dQWudROmLlLNyaJh+qGxZ9/Y6D95iWxtze9d8A8JWUeVYuNcNzGuEN q2gb1bS2T8Pk+VCqcFRqsioDWHNnqM+BwLGq26+gTj0p3zop+cgAPklesV00m68IlSy1LhMcIzIF2E slsAxGCoT6w+U1KGge2lPNChfW8Kf4kMiHr5s4V3lqgjh5jDkHofe2E0f88YBI6NEK9X3fm/gk1V+J VIaptHRDqsUJmlPLmvdU51DFEwmGDVtxxc8mvgA6F08d9d87r+yOm0Oos298QtBiQcb6IqHR1aka9N ITML8aqrOeF2zgN99ZZVlzpqrJWuvSp/jTdyiXKWVRaHjVEtHs0pTh7ybdJy+0D0bEzNBE9I5MQHe+ WHend498nQc8gE/neaaMboKfxVnAocxfFtQoQknslS76Z48WT/MN4FdUGVjS9jgF8kAQB/iTqc+2A2 jb0b9ivFQZN1YJgTlFTR4zPHbYRw/NOF7HTisjbVAjun3ow+FP3VgcwZPkruEl+31v44pUzsmk7WZm PBqeRGaWYJACjXqHGBEueZu13cMlJCXDoarHrZqbMc5frds4B2dEW+0qLeFUe/LZJqdKgR+36oA8nE hBOileJ273cIjtBiGXGnEU1vWDHPgN8zSEOKxP4Z77q0bv5ucidRdFRkNFZA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, for rqspinlock usage, the implementation of
smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
susceptible to stalls on arm64, because they do not guarantee that the
conditional expression will be repeatedly invoked if the address being
loaded from is not written to by other CPUs. When support for
event-streams is absent (which unblocks stuck WFE-based loops every
~100us), we may end up being stuck forever.

This causes a problem for us, as we need to repeatedly invoke the
RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
expires.

Hardcode the implementation to the asm-generic version in rqspinlock.c
until support for smp_cond_load_acquire_timewait [0] lands upstream.

  [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com

Cc: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 41 ++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 49b4f3c75a3e..b4cceeecf29c 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -325,6 +325,41 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout)
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
 
+/*
+ * Hardcode smp_cond_load_acquire and atomic_cond_read_acquire implementations
+ * to the asm-generic implementation. In rqspinlock code, our conditional
+ * expression involves checking the value _and_ additionally a timeout. However,
+ * on arm64, the WFE-based implementation may never spin again if no stores
+ * occur to the locked byte in the lock word. As such, we may be stuck forever
+ * if event-stream based unblocking is not available on the platform for WFE
+ * spin loops (arch_timer_evtstrm_available).
+ *
+ * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
+ * workaround.
+ *
+ * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
+ */
+#define res_smp_cond_load_relaxed(ptr, cond_expr) ({		\
+	typeof(ptr) __PTR = (ptr);				\
+	__unqual_scalar_typeof(*ptr) VAL;			\
+	for (;;) {						\
+		VAL = READ_ONCE(*__PTR);			\
+		if (cond_expr)					\
+			break;					\
+		cpu_relax();					\
+	}							\
+	(typeof(*ptr))VAL;					\
+})
+
+#define res_smp_cond_load_acquire(ptr, cond_expr) ({		\
+	__unqual_scalar_typeof(*ptr) _val;			\
+	_val = res_smp_cond_load_relaxed(ptr, cond_expr);	\
+	smp_acquire__after_ctrl_dep();				\
+	(typeof(*ptr))_val;					\
+})
+
+#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
+
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -419,7 +454,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts);
-		smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
 	}
 
 	if (ret) {
@@ -568,8 +603,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 * does not imply a full barrier.
 	 */
 	RES_RESET_TIMEOUT(ts);
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-				       RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
+					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
 waitq_timeout:
 	if (ret) {
-- 
2.43.5


