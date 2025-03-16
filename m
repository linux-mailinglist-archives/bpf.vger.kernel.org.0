Return-Path: <bpf+bounces-54121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C4A63389
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5931D7A7E40
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574D188587;
	Sun, 16 Mar 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeTLCboX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322091714B4;
	Sun, 16 Mar 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097956; cv=none; b=Ms8pp4rHiFpIJqWjqRK/c37uJ1YWzy3OwU3GBjTm6wPQaEsRd7p4ECcGr/HWohBXGtL/CcwzuRjL0MBKK7Lp1mo7s2uv8EjJF85iyIgvd0yMhGb5Al97fV+2dHMKlrTPZP6ce+eOGAaKUgJ+IrZPeHRB6SCGuy5toPHu4diA0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097956; c=relaxed/simple;
	bh=y9/H+/hm8Whgobd7BHik2UQJXH7cEJPayXzZNcl5svk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3rlmNqDpBzcCcl8P8lqCgARrT4h0IRbR3/cO3+YhTgKm59a7kRjKU575hPditk6oKGL2x7FN3sRGWDDB77gjbA5FxbaVRv7mRcfZPbygLwzqSqyvLeN7MnsfdmJSHfR3dK7rh1hYrczsznQ4Y9QCpb59rR3u0B3H4NFsXh/kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeTLCboX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so11225925e9.2;
        Sat, 15 Mar 2025 21:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097952; x=1742702752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VRGS9P+jyMhEgNXbehIAgq9LwV+0ThEZLQ6VCSjK78=;
        b=GeTLCboX3FrIIr+Y6zZ4avA7EorZ3gRXzKm4yflCDz1brbDk08VIC/LHqPLBI2Ztc/
         9shAF046wf9pEgNV/Gf0IBrGlHZZ8Yj5Zye9Nv+8o+6LBqrC9GOsp8ut7OSxacJdiBw1
         Sgahu6x5LZzxLw2G+GwCTbHnD0O4ghe5CeRhAwknPbEvdTvjCiUXGd2MBwcmuXc+Ulhd
         QtKgcHoGD/ouU3RZmu50zXwoixvITEpG2sdRy9sf7dyWaGdGEij2FTUZ/d8X9UcWAE7+
         KTWGDLP1qWoE1Tqrrj1/J4qUHuXoTnsjdcVWw94gIF87Iycvk1a2WbAroPrPtBnqw18L
         mOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097952; x=1742702752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VRGS9P+jyMhEgNXbehIAgq9LwV+0ThEZLQ6VCSjK78=;
        b=XqtQhoJ+OSCD4KlxTj745yNskyp6UZWh109LNgWbYZYTbIiEV/Ylz9hT85myLr130o
         iaLXVbnMzRxqjIEib5qYetPgbg1IgsNbX4mlqk9N+cXeW9BlTRyEFlNjn1Z5D8t1kdzh
         TRfun9Wok3RiOSIsXnQuNR7AWSpELLE4YUloS4rMsrgpvWiEGbN9yW7J9/VGex7um6CW
         oC1FNjFA9HI0fLtvsDl6N0XuOTPV2Jggt2GR7FGxIT4zInUTjm4Kue0iccrAQanzZ6j5
         BwvFLozYpwBn69cSJDJzOaAA9BmCeSU7G1AuMgBya3G6U9nAZC2yYO9miRxc+qW3PX7f
         Oqsw==
X-Forwarded-Encrypted: i=1; AJvYcCU3HmqnaPRcKQ/mHgglPLHLBoAeiVTjT2FgHeXnmYBwxQpuVbs98aRZZHB8Hr/NJwTitRBPJ2aykwufTB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAy5arXC/EyCqYCPnCmVubSJMlzHfLihp9ddvxfqi23k0kH305
	WIrDFyodH7dXAKACkT/BLefUy8XcYeu3AlA8wIJmEx2o7Gg2+VF+QLgROfagfR0=
X-Gm-Gg: ASbGncv2OAHKFMrIskU1TA3uM2H9lmqfZN4boboaQHXSH6AIF9mzzzYOE1CA5Sj3u6/
	diUNQ/eFiquqChXUNU+FO4I8JjKeXHjNQhCYIQNoAi6qVj4puu8biS2HGEOW3Tyoo4xHrUKcYfG
	IKbV6yvN1HSPeqp/aWkWFMEnQBd/KfyETKk2ucs0hIeOiFUR8GzLlIbNUAlGLkmfYekpgcd68SL
	tP/CiY2mH4OOqAHi1MI1t9Z3wNojgD0QJwZNA9crJPy1DcwBGPgGMuF3A2NLmt5/ass94JUbrCC
	q0U/rR52BTOEbn46yj/O9FL55AiV2kIZtp4=
X-Google-Smtp-Source: AGHT+IFz3AnPPrWkJH2W87H/P68UdDnYxlyg4j1YFp+J6rmRetr1S1beo6FRJwr3WTZ5ZKGh7xpY2g==
X-Received: by 2002:a5d:64e3:0:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-3971ee4421fmr11004162f8f.41.1742097952104;
        Sat, 15 Mar 2025 21:05:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318afbsm11186285f8f.72.2025.03.15.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
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
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/25] rqspinlock: Add support for timeouts
Date: Sat, 15 Mar 2025 21:05:23 -0700
Message-ID: <20250316040541.108729-8-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4618; h=from:subject; bh=y9/H+/hm8Whgobd7BHik2UQJXH7cEJPayXzZNcl5svk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3c971BRmRrbtZ27c2Isb9sJ77Is1kCbCdZsV6t 1TF9L6+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8RysI2EA CWS2QokbV6D30J2uxyFyVfcIaONPfZhICR7q5XYFdtmvsNs0zVjHot9yAnnznptXBAiSS+cpG5Aawg z2RsgVOs+pD0nZva8ZR6I0u3fDlBkTQkxzWXNevfnkDzWf6uUiNYOYliNQaW5nWk7Xw7ZhjvCiKRPX 5A+tArW1n6UuDrD81t1KOunXMvupCUoGslJanF+8gDOt4ww2O9a2OMUAEYlDam8nqkz9cM0CzCd7lj QMx+mD23eRdYJPFBaZ0DwuFWjSBsFEv1inLqSt9M2aRZyPyhN91AjHkP7RVP+M9mho4L+KwU5R0cXs ze0x9jqRuyREct7IZSep7fJflgyK3LtyZ98G5SfXEQFt45kdMIOrFHPRuBnQm4E6sCs4aJuA0iCmAf dZlv2k2m5XIg3dN0guZFl2s1WPD8cB9W0MpgJTmOTnOl4cdR5tCYbuQwVZ8AuFNtt9E5raXpwdig8A 3cVwVvesOvJ3R3L0nMCpCVvkK2xGt3HgFD3qTNJiFpVZ1DYfR37iPcxY/fvZQlkrC//giZDQ8bcvxJ GzzbGGJVJzdeQQcjyz/aBTh+kag7lpu9O1tyMEIIWMI7H0OfiLPjxnjWKbSoAZGBcrjRyr2gPN67vS 42Su7CQ/jdGZQj58ck+gkVIG4s5JTH4rC9is1NwbNmozjCDyE+65OdLS++Gg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce policy macro RES_CHECK_TIMEOUT which can be used to detect
when the timeout has expired for the slow path to return an error. It
depends on being passed two variables initialized to 0: ts, ret. The
'ts' parameter is of type rqspinlock_timeout.

This macro resolves to the (ret) expression so that it can be used in
statements like smp_cond_load_acquire to break the waiting loop
condition.

The 'spin' member is used to amortize the cost of checking time by
dispatching to the implementation every 64k iterations. The
'timeout_end' member is used to keep track of the timestamp that denotes
the end of the waiting period. The 'ret' parameter denotes the status of
the timeout, and can be checked in the slow path to detect timeouts
after waiting loops.

The 'duration' member is used to store the timeout duration for each
waiting loop. The default timeout value defined in the header
(RES_DEF_TIMEOUT) is 0.25 seconds.

This macro will be used as a condition for waiting loops in the slow
path.  Since each waiting loop applies a fresh timeout using the same
rqspinlock_timeout, we add a new RES_RESET_TIMEOUT as well to ensure the
values can be easily reinitialized to the default state.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h |  6 +++++
 kernel/bpf/rqspinlock.c          | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 22f8094d0550..5dd4dd8aee69 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -10,10 +10,16 @@
 #define __ASM_GENERIC_RQSPINLOCK_H
 
 #include <linux/types.h>
+#include <vdso/time64.h>
 
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
 extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
 
+/*
+ * Default timeout for waiting loops is 0.25 seconds
+ */
+#define RES_DEF_TIMEOUT (NSEC_PER_SEC / 4)
+
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index c2646cffc59e..0d8964b4d44a 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -6,9 +6,11 @@
  * (C) Copyright 2013-2014,2018 Red Hat, Inc.
  * (C) Copyright 2015 Intel Corp.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
+ * (C) Copyright 2024-2025 Meta Platforms, Inc. and affiliates.
  *
  * Authors: Waiman Long <longman@redhat.com>
  *          Peter Zijlstra <peterz@infradead.org>
+ *          Kumar Kartikeya Dwivedi <memxor@gmail.com>
  */
 
 #include <linux/smp.h>
@@ -22,6 +24,7 @@
 #include <asm/qspinlock.h>
 #include <trace/events/lock.h>
 #include <asm/rqspinlock.h>
+#include <linux/timekeeping.h>
 
 /*
  * Include queued spinlock definitions and statistics code
@@ -68,6 +71,45 @@
 
 #include "../locking/mcs_spinlock.h"
 
+struct rqspinlock_timeout {
+	u64 timeout_end;
+	u64 duration;
+	u16 spin;
+};
+
+static noinline int check_timeout(struct rqspinlock_timeout *ts)
+{
+	u64 time = ktime_get_mono_fast_ns();
+
+	if (!ts->timeout_end) {
+		ts->timeout_end = time + ts->duration;
+		return 0;
+	}
+
+	if (time > ts->timeout_end)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+#define RES_CHECK_TIMEOUT(ts, ret)                    \
+	({                                            \
+		if (!(ts).spin++)                     \
+			(ret) = check_timeout(&(ts)); \
+		(ret);                                \
+	})
+
+/*
+ * Initialize the 'spin' member.
+ */
+#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 1; })
+
+/*
+ * We only need to reset 'timeout_end', 'spin' will just wrap around as necessary.
+ * Duration is defined for each spin attempt, so set it here.
+ */
+#define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -100,11 +142,14 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
+	struct rqspinlock_timeout ts;
 	u32 old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	RES_INIT_TIMEOUT(ts);
+
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
-- 
2.47.1


