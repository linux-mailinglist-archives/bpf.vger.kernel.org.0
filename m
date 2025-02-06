Return-Path: <bpf+bounces-50646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86EA2A676
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18F63A6D8E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A457722FDE9;
	Thu,  6 Feb 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKvykQx7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E6222F39D;
	Thu,  6 Feb 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839298; cv=none; b=HskPDnwhDvHeebgRwtbCT9/HRlQ8tVvfF7EL3h3cxHhvDvXrb3ouOCnWyMSJsWZ88mFg2zB0SzAF8peIQoI4anN/abZ+9GAeJ1x9C5RH6/4riDNqOCoXWQLu1We0bN6dAK7eZZlOKsy0Exal/Urx/RiqlL+4E7t/NLJ/bNA8Ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839298; c=relaxed/simple;
	bh=nWMxFCMQuXMGccLr9BZ8Vd2VRz48kOmVrJhLP51E7zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDexyDr/gBKcwjfVLpsOx1Bpv/Cz5l+0Ln1aNlL1yfrMThCJbrQuXcaMaRXJ89UR+Dtrhm996+3hazKC47l5mLwaSgvqmSdzIaJDaVGuZthNcq/FrwUGzS8BiRgWAeDXuJ7vzE/wIJSeogbu7tUu/vETlElw3Hoo3qq9kXCIYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKvykQx7; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso4874265e9.0;
        Thu, 06 Feb 2025 02:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839294; x=1739444094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bppDtbpuPfpz/O7JpsRY6fQstRsmaQoxcIF1IN9rk84=;
        b=lKvykQx7hIDaQEaIawKB926FqTY6u6JFeoS/9InKxfBAWYofN3t9Ty/FmNFH8OqaFs
         4zvdlaMKUKqDlHNlNNcuU4sAI5Nc7oxF06VP8b9Sj8nALnZf/N3pOyj2bFK8lf3E2/kz
         ylRgZ0bCSPLYLa6McMuRpgHC248d8A99HcVzUP8bT703cbnoSF0DNTq0/CkxHgpZLU/P
         w8IacNrhgFyUXdw6ExFcmHGpChKOpNJTtqOSMe4Jooz20Q6/Dlv8i90J4je/AxC70VCB
         EcB2donrKHWk+fb16gqQ9wjIFL3eeJsrk6ubkndgGwW3TeZGW43cCIupAXqUC3iJ9jWw
         n6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839294; x=1739444094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bppDtbpuPfpz/O7JpsRY6fQstRsmaQoxcIF1IN9rk84=;
        b=cs3l2blPAyEl3kSmR+mQwgJIvZBP1wGaPDqGlZZbb+OOnwS18U4+avcLIFpYszK3nO
         A5HhyvHmAIK5GUIVq2vIOrP6yGay1hh9ZXuj3TaxZKAdL2fTnyIlU8mtfJOcUkB8aZyE
         LSEG/9xzB4OVQPC/vyU6ps87Ns/FblMULBKGNMINP76gOETELMV/VLaCwMjUEHA91s3L
         ZcoRbfvAFNW3oA/+RRx610oCA7BJhyQ+AM2dSew1mRczckSYNosLVqNNdshcF2gKhbL4
         ozL0jB60D29dMlbdlBize0B6oqEAUuhFAwys5XIX8sb1BdVgOk+ndD8Z7YiozUtZoq2F
         ZQDw==
X-Forwarded-Encrypted: i=1; AJvYcCX+/ZQvPthRiXoZW3P526VW+P6au0RNaNksp6EoX/QhsLvIHhvWeUgIKEiDcTK2Q2QN2eiZSS6nO9qxR9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIT3D+88q6s3qZLTTkwEZQMYtNDUP8CL3iLNKRsqiX5/Mr7WNR
	V7oejxWsG97XuglhfpHGYKBRPVvg5s3n807/sXevKSgqlKqy+6xuILqEDBXxhx8=
X-Gm-Gg: ASbGnctqt8IA13/g38iI0GVNVfp8AwWnrUn5yAU0nRX41rYK2j6QoRaWCZYSmXhFbvu
	dVRJuXsrSmyu6w++tWrLZcy0A29Qozq0kBqHYfnS6r03wY15ZWmBqxzLIfZWqe0cGbHKQFqDSNe
	mu5KwpoL0q5k+mBHOfbwD57zUmK6owk2EFjz5DT0fWKniWkAEVIYuv1y1aDvdKMXOZNaappSp1l
	seT5Yqv+1JSM95oIkULe8Ib9zQBCHZDFR+QFp76VIjw0dK1JafFscK0R9q5Nz5Twdh9zc0+Y+PD
	3Ihk
X-Google-Smtp-Source: AGHT+IH4Mj74Q6s6ESR+HQuLAWKyeMTzag9eq/JQXW9Gs5KkYpw8nRAczk2OFAZMAasQewSLnwMzRQ==
X-Received: by 2002:a05:600c:1c90:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4390d56e3admr51736725e9.29.1738839293937;
        Thu, 06 Feb 2025 02:54:53 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd36346sm1391806f8f.27.2025.02.06.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:53 -0800 (PST)
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
Subject: [PATCH bpf-next v2 12/26] rqspinlock: Add a test-and-set fallback
Date: Thu,  6 Feb 2025 02:54:20 -0800
Message-ID: <20250206105435.2159977-13-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3427; h=from:subject; bh=nWMxFCMQuXMGccLr9BZ8Vd2VRz48kOmVrJhLP51E7zU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRlMFpWa3g5n8jTl6bpUsPGHtx8MXyfjnnCKJt9 AHs008SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RyvWnD/ 9ElDHw+LJcUwAOu/LB12XiFVDPKFpTcnqBAIIgWpttUZIU9wtEERsQL0IYyZVGNxKf6NjzmCa5aWjB 6dG2OM5EHYXz75cwkHfgazZPzdvgoVeDK/X6Rt2/k5eFlhkvDpaZ1RJQQbPSvRy3B4iNrYvUxPRntH 0siGNJGxXXk2/BF8QAsO0/9VyB0myTjnkvBLTYazkhPxYeGYJPOVUfjk9cl5Z2kz+zKGi7S7EVov5k EoVNvIcbjJp6aOpxZ0Cl81l9juNQk5dH73X0Y6yLqqcmxRePAdscK6ygQ0v6j5b5bZg1vt9NqzHfbx bcepMH3rFrZmAqXnSuel7pnTFM4tuaOV9SyNfh2zbTXiyWyQFXxPuGFx1+OLztjitTNulOf0KE+BUh HpLSN8XCqNmM10ErdfqRD80ZDXesuP0vqDokTCpTWKQXbVlnLiWGEwIOnyoE0LWBwqn/XvqhOIFrv4 DYsmQzW+k7QJRAtKWsWYpWOHweuglwIcQeVSluJEnfGNkaIUyHbEU8X0V7jEnkdX5De3i1bERuidMP wM5fvNrUBt5JbXAuZjfP1QaTVtQYh+Rc0k6cDl6I0PUPAi5aAglDK3T8+HJtDTOjLvWN3st8/uhyl5 rLuvZDv3ZySigXnWcS+rrjCZ06WAgFBD5LZbLsv4etjiyzSaJO4h2bT6JiIA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Include a test-and-set fallback when queued spinlock support is not
available. Introduce a rqspinlock type to act as a fallback when
qspinlock support is absent.

Include ifdef guards to ensure the slow path in this file is only
compiled when CONFIG_QUEUED_SPINLOCKS=y. Subsequent patches will add
further logic to ensure fallback to the test-and-set implementation
when queued spinlock support is unavailable on an architecture.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 17 +++++++++++++++
 kernel/locking/rqspinlock.c      | 37 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index c1dbd25287a1..92e53b2aafb9 100644
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
 
+extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
+#ifdef CONFIG_QUEUED_SPINLOCKS
 extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
+#endif
 
 /*
  * Default timeout for waiting loops is 0.5 seconds
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 42e8a56534b6..ea034e80f855 100644
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
@@ -29,8 +31,10 @@
 /*
  * Include queued spinlock definitions and statistics code
  */
+#ifdef CONFIG_QUEUED_SPINLOCKS
 #include "qspinlock.h"
 #include "rqspinlock.h"
+#endif
 #include "qspinlock_stat.h"
 
 /*
@@ -252,6 +256,37 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts) ({ (ts).timeout_end = 0; })
 
+/*
+ * Provide a test-and-set fallback for cases when queued spin lock support is
+ * absent from the architecture.
+ */
+int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout)
+{
+	struct rqspinlock_timeout ts;
+	int val, ret = 0;
+
+	RES_INIT_TIMEOUT(ts, timeout);
+	grab_held_lock_entry(lock);
+retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u)) {
+			lockevent_inc(rqspinlock_lock_timeout);
+			goto out;
+		}
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
@@ -581,3 +616,5 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	return ret;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
+
+#endif /* CONFIG_QUEUED_SPINLOCKS */
-- 
2.43.5


