Return-Path: <bpf+bounces-54123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94DA6338D
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C859017051B
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574418BC26;
	Sun, 16 Mar 2025 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Ji1RIe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CD181CFD;
	Sun, 16 Mar 2025 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097957; cv=none; b=a3HFG9B66t2gr874erL5+1RWGwh8FRaqxHnEFzYGA7u3E0/OMbw5csBdBIUnWMU7NFn10ZcyZ9caZRyWfqsw7gVcLLpIwj8t+1U2hjBLLFOqMfNU6VS2vY1Ew+7S2qArk1zfzb4Ni7zV2gcyJsROt4WUuJhxTA64csw4Abihovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097957; c=relaxed/simple;
	bh=lKBJ9aBAw973+or/w6UqktipL8hdcm3y+5hYOVP0ZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H46vlqJvMyUhtgYcGtlAe7olrgyMBlpFOTI8a5Y9x5GlVMZuwziFrhFOjEye6I2AzSlaTARhux5HiD1ZAFvOQPUSKgZgGVKUPvR97U9+sp1KR66w7Em/FAOvpDU0vTAm+vr69M2EKo4fBes3nVVDNLzUr9cKFGTEuvKy1OH+gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+Ji1RIe; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43d0618746bso7043485e9.2;
        Sat, 15 Mar 2025 21:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097953; x=1742702753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFK9QP2ryp6S9vfpdoBhpsIqnMqrZRtjhBu2k3+ZF1k=;
        b=M+Ji1RIeKKXYAXjx0rj32Nh27HypTbunzD9AE4oXM8wJ0fsGgJYyKMoa1/kyf/fqrB
         CTuK2NptxwqNrv2XyaXkBDIlN1wltVeI9aezOv30/v/ngPoYK9j+v6ll9xv/CHYNkN/f
         0Bvtazu27YQaKqtlEFQypuNId8+DwGt8H0Ew3IWJFlaUMqwZP8YggvD3BTudnAPRMDzW
         /AxP6vO33TNzvmUj7QLOFOLbUzqmC9T0vjGbilArQemIelKHPGhg9TeBNM4t2lZ2BcTr
         MgQ06vzJwGZj7IN7uFQsQ3kb/0LNuHpranTGikmQ001QhSkJGQMQ8JhyJJMurw89xlvO
         VG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097953; x=1742702753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFK9QP2ryp6S9vfpdoBhpsIqnMqrZRtjhBu2k3+ZF1k=;
        b=RXotwSamRTRiYdp/OFqGWeZ5Pn4WVMYtDmGqJsVEtC1IgAZ4iRRE23ZABqpCT2vJ6S
         Z6GHo/kKD2le9CsPw78vusN0SsrLBRDgNqMEE//EdntwDRA4aaolNU2QZub+HtRgnndY
         sm/lwwzTgnNzkHGTGNwhkuc9W0pGS4ie0slQJ+oEq6VrZBJKZGysll+hV2yYzlSUjB1e
         r2ZV6G4UY6A0I+342QNcoNCXbQyyIVskCHYIKH+Oy3x4sCgIotMehAlGB8ndYuWTDvP4
         pF8AXy7sAuZBSuK+5pm7x/FFZzZd51joBENTyK/4fCcaAKO+GLAV3Q1KBml5bikAWePp
         jncg==
X-Forwarded-Encrypted: i=1; AJvYcCWbdZFUoeF3qMxXeea5MSPJNAlz0zcr/1I2iI9bBRl+aAksBzlEJIfHsXEcx+dctnUGojD+eJG7aCaV248=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePdmyibB4vf054k1OjJO5IutACeAUFfbLmCPoVd1FA6bTM9uE
	84Z+aQrBH2yB4yrNOf0/FcEzGSDsLARYqhS4Uv69EJY2pixr4WRVhMmEFQxRD5U=
X-Gm-Gg: ASbGncuF2Vmq3DZF5sCUQgPls65/soL7x/sCQF7CiLTOgk64Vs3yhkHRog/SNCqGK/z
	3Z1G7td6jLRKW9VJuTDRjTKXh1voh/GzcDTZ1PpWGV1mSXS079Y9Wwvj+ROwuD4soPYXhpawFwW
	Gmtx8i3s4faClQTraAvrBffSzIzqgrxkx27SQBQBX9m7ON/P1KSOVIlI+tB0oyCHcuTMVO669lx
	ytZLxDBCmzmpLKLYgFddcmj0kcBb6+mpYIJonYoJDND/wI3rN9pSJqxhIUrc9E45UX25m2ZmcSC
	H+lXrnkRGsQtJg/VcvKBvJieO2DRG92bIA==
X-Google-Smtp-Source: AGHT+IGhUW+f1q1VNdCXhZBFgRFdmfv75hlIFEK2IxoeJXmnqDxRW8wtCa/CmOIyhQqKD2xosxaDyg==
X-Received: by 2002:a05:6000:1aca:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-397209627cbmr11722558f8f.35.1742097953204;
        Sat, 15 Mar 2025 21:05:53 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b91sm67304495e9.31.2025.03.15.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/25] rqspinlock: Hardcode cond_acquire loops for arm64
Date: Sat, 15 Mar 2025 21:05:24 -0700
Message-ID: <20250316040541.108729-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6176; h=from:subject; bh=lKBJ9aBAw973+or/w6UqktipL8hdcm3y+5hYOVP0ZOk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3cMbmNKFvx4Ik3/qHmmldYWMH/I0PyXp8ZVeBa UGufzLyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8RynLiD/ 9hx5tU4NN3EbyQPx9n+eKNGaPXqNZPXxhQCFKmNLAzfKnq/pcezJXwAaBvF3MvIZVzVlUV27hYJOaT VPdqeyvrqyrQLXnxKw6ZyYJH2pYpdUil8/2N6BpCLOUHygH+NSQiJ34gEdnURzGDh3RFatKjQifwQj lDUDg2B3dBHy3a6sRr+8+0JMw9/DK+acuvbq6yAHzyfOVH7EAeE7PdjvyFOsJ6AfH1Ljn2Ef3zbnuU 4Kqfx0mCHSNEKwZ0r8BjSLhmMaDqE/5s0iAaMrUyXfyyyNVJOuJXT1uPjOdz+svu+4lrBlI5NJUzSw vc3EODS08XuQXKt5+uiNPa+moqvRfm9TtSz/S9Rm6uUPIqM4LPg45KROS4P27UjPZ8jACSk0pQRrk1 IQrUW4DQinLN6Jf2g6ub0hZHFhXkkBZp9VYetZWXYCyaDyoLnKM2lzdUeRof5bkUQac+W3mWbGSYhs 1ZNsPxQs2uHgi2xFAHk3Z5vYT46PZIa1+0Dv3eLErjz6D62AmpZar3lhqeQ7Ta7XuCzKvDvHNqyisy aDrHLSUt2eVz4sbmWW6daJ4kEbOdjsCeHybPzY3n20R7UPwcoiGQld4ZgBGXkP06x2uAvOfgJMIG0M 9QbNJoAG58//G++hEQlk7Pm0zJfn+jEgToyvLCWCL5AFtls4uNh/Ru6sTjkA==
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
 kernel/bpf/rqspinlock.c             | 15 +++++
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
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 0d8964b4d44a..d429b923b58f 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
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
2.47.1


