Return-Path: <bpf+bounces-53077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCBA4C4F9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE44172311
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F5221D88;
	Mon,  3 Mar 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwp17mOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F6219A9B;
	Mon,  3 Mar 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015404; cv=none; b=n/UF7jKMIUgwh8oXverjEP4L2SpTYd19BVL1v3NnAuDUFvWKEt4gfd+tIQsGx54nB/GexDb9s6xX5MG52PyAFR5kEwh3xyT4qFXVNXRC0LEeLJRhvYMnr9OudKlPxyUoTzZDnuRAghX+rV9ZLu5PYO3m3dLCB6M2T3XAUGwE5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015404; c=relaxed/simple;
	bh=OXZjfkj9vlmQB5DKUaVgZP2eUXPIscjbGs4w8nWWb1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV8X02VIbpASsvvsTntkBrBmJvOLg2DAiNt7dYDW7fjwvK3bCcrFpzCAVKROw+5U7JWijJx+d9x0FMo0q1UGuN2UCU/OdgGkyaiaK5Jww0W9Z4LnFGAXcBGuEcL+09VgrJkL+Z8GS+IbaVwNQS0pIkIh7apReOtPLOtEwlO6oQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwp17mOC; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43994ef3872so29735825e9.2;
        Mon, 03 Mar 2025 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015401; x=1741620201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiH4DXwFE1Biytfxts8kRShbn5OFLAeIwdTEbcHfEBs=;
        b=Mwp17mOCz2Oihm1rAVi8dFSp3Z3rfI02Yv/BXOU4E6BJ9YD6dD7g2DiJ1lkfGteTKf
         3DjZ7/zjSfp+28w+01jhtnsk7xXce6+9PuIcrIvi4Q97Pj/auUAjFdxbJQSpama4jfvL
         Eeg5g/N+DkRVvRtGEn7ue2zuODVHuW3DcsZ386IAlD50PyPC9NYaD4diioaffX8yFKJN
         zLqbwv9zN2dY2LcD2RGau704mJJn+agZQARLNfoKHqxokqYLzBZAfRr4ydHtdN9/aygS
         WJNOHT2SACr/YEgbUKsz/eESZh1CFjC1VcnSPvYuFOhT6XVi2P6lZqCkNmYagqTwKTkb
         AZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015401; x=1741620201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiH4DXwFE1Biytfxts8kRShbn5OFLAeIwdTEbcHfEBs=;
        b=wE8pGxnHxLu7gHH+sCLx1u8XPI1f1kvOS4SzQoJwKxd5DtE+fSkW0gZW7GTIWkbWPa
         8T5+i/W2FaHun1RFN19+IH2fKpdjnrHhqHbtUeU8Fr5kQNzftf1wVC1FsvC9qUNIg4x9
         s7sFEbX9RiIHvCoKZQ0zR2zmIIdlN/jlQVoFdIrlRoaE7aYtCuf245yyJH4dDR6SglXc
         cMK7pmWbZccAEq5/7AgrPTiHuBlvu+d2PX1JmepUYedOVCjvbZrMJoNQib6HKDltmmgn
         7jYn7SucogrNaU/cl+CDpmWR+Pz9Da8GmEb6JExIc/8rcxdr/cg6rJZXgB6US6qJV8/x
         o98g==
X-Forwarded-Encrypted: i=1; AJvYcCXCTJoDovzn+c60tfPC4MylbyeWB+MVtqiAZjHDVma2oNuBDGeLqVmgJSDptVKIuoXLNaEybbbCmYgk26M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89SnkIu/HTimbvxdRU+FtNv6iTNB2qL+UV8zwBzkJrscXfUnf
	/JE03X27255Ffe4N5F2tj0G4uu9OrhM7MS6brFOIy+0u1cbfpyUYCiwybGQ2pb4=
X-Gm-Gg: ASbGncvlSmpwfE8Dd/BCXiYND9mqubJ0troQI7KKxI1NnF0PTHPakAVnOILbYrHrLA3
	aN81ZgNG0i72YmVqqjEiGegmF51QEhc0pOaTxdxN4T2/FwDPRHZ3LVW6XiN8sO4xwINkYxYtAYj
	xTei7Hb/BYGMaI2nvTdbD4H3fAMmAn+MAoe5RuyGLpZRy4qYRMWUlVmeea7Jr6edlYlTRdFIqJJ
	rg2DjQ0/58xEzdsv5sB1ZObYCcn0CIUR/JoAXURt7ipx57VaYwHDYbc0tlp9yQKN4xBR8oiVAGs
	tCjiF+xt3jDDBdEFAWbH4R+OY24scy+TfA==
X-Google-Smtp-Source: AGHT+IGX9Uo3KWT7ZP1Tg6bcJFL7kn9d7FzFa8+K2r3RPDuxVc4WDWiD0YgV40rXuhBZGtIqZf8VUA==
X-Received: by 2002:a05:600c:6b65:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bb3c30d77mr71469755e9.16.1741015400470;
        Mon, 03 Mar 2025 07:23:20 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc11e1c8esm42306695e9.32.2025.03.03.07.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:19 -0800 (PST)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 08/25] rqspinlock: Hardcode cond_acquire loops for arm64
Date: Mon,  3 Mar 2025 07:22:48 -0800
Message-ID: <20250303152305.3195648-9-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6192; h=from:subject; bh=OXZjfkj9vlmQB5DKUaVgZP2eUXPIscjbGs4w8nWWb1Y=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWWOoYAiRmhF6y065QEj1LrKSfWllbpNyyYNZSa qSwKiLWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlgAKCRBM4MiGSL8RyoQ1D/ wLlVGYocGxdNg4s1QyAFfYsSQi2WqV1eBWYZSjpNeeklY5NGh1Tkry86bADuiPA41U+6sKcb/xJFWh P98uXD3GNRpR3Qc0ZlcFxJ8UNRa1pt3WjaL+WU2IF7ab7pFZ78BILJH5IehQy38rq89MVWCIwd2y8a RHZEOFbn9h2lwC+gVyaVp6R/8EqwozY7peLmtmdEFyLzkanBkkKXXc+vmf2LUSP//uz18W5Dvlk/u0 Ij4Dh4XIXBZs+zio7QVmeQ1DgFpVZqqqb4UgpoAdO7QiQV0VZszEUsbM5tyg0NeNseWkS9u9vn89cy o5IFAwdAf7z+FqxhLOTysBwrma0uhfKDfzVTbqISED2s8YCgwTcFTVLcOnpawilUTon7ijZDzJQQza 5cEcDi2MdF3WOvcWqxiMLcgBJpoJwzQQ6MByaMhPTBx+dbyWoJwX54M+fwqGKqjL1nIy4s38v/fflb 5KSHn5vrHcWHNLNI4f1kxITi+5bQsaMeifIC5ltUctjwP0uh/WVhq+B63kLgKyxgW8zDe5RkYxvVVZ W2bMlEgbU71tVLuA5VUZTOizoax2TL2hJ1Ox21/A0q4t3m/Th739SY3jusfPle/dtSkQURdfj5CVS+ 7WI5z2oPcdvV5Fu3sRfrtb1EwqRYq3nUqzxzQ781Ej823z3Nf0EW8WW0F5Dg==
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

Let us import the smp_cond_load_acquire_timewait implementation Ankur is
proposing in [0], and then fallback to it once it is merged.

While we rely on the implementation to amortize the cost of sampling
check_timeout for us, it will not happen when event stream support is
unavailable. This is not the common case, and it would be difficult to
fit our logic in the time_expr_ns >= time_limit_ns comparison, hence
just let it be.

  [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com

Cc: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/include/asm/rqspinlock.h | 93 +++++++++++++++++++++++++++++
 kernel/locking/rqspinlock.c         | 15 +++++
 2 files changed, 108 insertions(+)
 create mode 100644 arch/arm64/include/asm/rqspinlock.h

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
new file mode 100644
index 000000000000..5b80785324b6
--- /dev/null
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RQSPINLOCK_H
+#define _ASM_RQSPINLOCK_H
+
+#include <asm/barrier.h>
+
+/*
+ * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
+ * version based on [0]. In rqspinlock code, our conditional expression involves
+ * checking the value _and_ additionally a timeout. However, on arm64, the
+ * WFE-based implementation may never spin again if no stores occur to the
+ * locked byte in the lock word. As such, we may be stuck forever if
+ * event-stream based unblocking is not available on the platform for WFE spin
+ * loops (arch_timer_evtstrm_available).
+ *
+ * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
+ * copy-paste.
+ *
+ * While we rely on the implementation to amortize the cost of sampling
+ * cond_expr for us, it will not happen when event stream support is
+ * unavailable, time_expr check is amortized. This is not the common case, and
+ * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
+ * comparison, hence just let it be. In case of event-stream, the loop is woken
+ * up at microsecond granularity.
+ *
+ * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
+ */
+
+#ifndef smp_cond_load_acquire_timewait
+
+#define smp_cond_time_check_count	200
+
+#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
+					 time_limit_ns) ({		\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	unsigned int __count = 0;					\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (__count++ < smp_cond_time_check_count)		\
+			continue;					\
+		if ((time_expr_ns) >= (time_limit_ns))			\
+			break;						\
+		__count = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
+					 time_expr_ns, time_limit_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = smp_load_acquire(__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+		if ((time_expr_ns) >= (time_limit_ns))			\
+			break;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
+				      time_expr_ns, time_limit_ns)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	int __wfe = arch_timer_evtstrm_available();			\
+									\
+	if (likely(__wfe)) {						\
+		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+	} else {							\
+		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+		smp_acquire__after_ctrl_dep();				\
+	}								\
+	(typeof(*ptr))_val;						\
+})
+
+#endif
+
+#define res_smp_cond_load_acquire_timewait(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
+
+#include <asm-generic/rqspinlock.h>
+
+#endif /* _ASM_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 6b547f85fa95..efa937ea80d9 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -92,12 +92,21 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
 	return 0;
 }
 
+/*
+ * Do not amortize with spins when res_smp_cond_load_acquire is defined,
+ * as the macro does internal amortization for us.
+ */
+#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret)                    \
 	({                                            \
 		if (!(ts).spin++)                     \
 			(ret) = check_timeout(&(ts)); \
 		(ret);                                \
 	})
+#else
+#define RES_CHECK_TIMEOUT(ts, ret, mask)	      \
+	({ (ret) = check_timeout(&(ts)); })
+#endif
 
 /*
  * Initialize the 'spin' member.
@@ -118,6 +127,12 @@ static noinline int check_timeout(struct rqspinlock_timeout *ts)
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
+#ifndef res_smp_cond_load_acquire
+#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
+#endif
+
+#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
+
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
-- 
2.43.5


