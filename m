Return-Path: <bpf+bounces-48104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD4A0416E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C341887707
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63A1F1929;
	Tue,  7 Jan 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIDQOl3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4C1F2C45;
	Tue,  7 Jan 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258428; cv=none; b=TjeFtc1Pbj3Lbccy6SgQp1xq42mqEHuavGwFpbcJJhKJLfLa61/O9UvBf/THIkVosiFDoPXJvAKSE5371VNXXUQT+h7hvgB77KjHj1hRGI/sqetZy5rxE6NTOFuH3lHeshKCUa7r65zHCuCoDknUymSjY8YMudusS7lFZ7kFj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258428; c=relaxed/simple;
	bh=eGu2DApzmi0L8HX4HzBePl4/npJqwEuQr5WMXWg1eJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgUfBI48zv5FolOZjaEiU6JW7R3S6ruVDPMVKSZHOEVLFxLixvxHDOMM96t1UFu6MltM7QbWZmb7NyKftU0Ps/iqa0u+gRKwu4aUWpJJTT7cPE9obtiGR2f3uZ5eANQPbTnbyVyEj3OwmojHWhZdFF39YzKzaYPB94a381YO6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIDQOl3+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436202dd730so111509015e9.2;
        Tue, 07 Jan 2025 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258421; x=1736863221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1S86x/E9hfFZDpeRh/A01JmFmw9TPvNNkAVeTNFDNE=;
        b=cIDQOl3+cGPAXbM3IlOTZT/fibeAvXYTfOgLn5KapdYzaZ50Ji863XQjlarGCZagW+
         bh1DYl1L5wVxv2L5iWDeCtX9o7FbNsL0WVVgqI0SSCZlOwQw7JVe65fbdl9cLvYKjJ9h
         iWb1+gNl59yK3RRSyzv80qi/QlQgTOwfKrD4M9gy6O4u7hgZLBue2bmNZDN34qX8ZdHk
         DuGnztRLqt2ZKK9vQmAqz1Fect9IVbC4vMPpCi2hWO3didXANnXV7w2BeHsa9uaZYpMj
         vaWpA1fUw5Pc+sdcCJoMArAXU7tGtTe38XB+sTq7lnrlAvE0YIRA+Mru5lPVVbdEqfTf
         mBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258421; x=1736863221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1S86x/E9hfFZDpeRh/A01JmFmw9TPvNNkAVeTNFDNE=;
        b=slXluWzDqIESxRU1FkwPmW8avqjhZsqMhvVvn1UvmYnBINClZiLqnDAtfIICuAm6DA
         ZILzHvBxJAcjzUeeiX/3+RUW8snYZJkirQTLfiY0IJAAFsLR23eICxmiHUgEzG22NdUH
         KhYflsprkiKqusFGoXVeiothbKkDFdY4GyFegO6szsSf59vaVDD6slCpgg/PCKo8Xgog
         PMpx+fcPpFKkJepWvhOjnejzB0urusPoq0N14fdzBuJrALaWW7ytwnzedwtNt6lm8Eqa
         KLqOWuWiW8H4Y/Ba/Xs5B8qSrmx15A5J9OAq4Bf3SLhT6aYSkDR7/EzhBKKh7b6vEHwP
         nAsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGO2KkQLQi+WDJ4azW5FYjovSt7DKUEPrTeP/VybaaPw9i+GOLzpCGxAXgHshePV2Hlmc3gSUwMD4nv/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ34erpFBaC2BQlnC+6/9BXnDsjiSSOkt1tgiEDIMs3iSdZFSN
	oxPAkBcun4aQUoVaTNBTdCpzZ6jLKuNyUpHq8iBq0nmBVuzKj+U+WOxE2U48f/usmA==
X-Gm-Gg: ASbGncsztGoAqXKPkjXhniDysZVoJHNM30YAb3ZVqhcaY5WeiV8Uhc1dbxdaMDvwDTm
	s/tvkRxd8W9bxZMUkbnXY8lcC06UhfpBUhZ+5IhUtxHRTyzYXVmjBaT7xP6i7HzQgUh5y29GVmg
	CDPYaQ4RvifS+hCcVEa7VcYa7FF51OJodoGbdE39OhUSZVdsfV3oFWRyq1J2ljDSaCu2/Ylxbge
	ctoV7w1tYUbRwBr4Kik5E5hT60bborOmY4AJoxW6b6m9Nw=
X-Google-Smtp-Source: AGHT+IG5QtsbWBTtMvCxIhoqEnfR3p382B1bTb4UdoM6BO6tHPbLKMHCpcoUiwmrRhOVEkJhPl8NGA==
X-Received: by 2002:a05:600c:1c21:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-43668b5dfcbmr455433875e9.20.1736258420846;
        Tue, 07 Jan 2025 06:00:20 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b41904sm631546265e9.37.2025.01.07.06.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:20 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/22] rqspinlock: Add support for timeouts
Date: Tue,  7 Jan 2025 05:59:49 -0800
Message-ID: <20250107140004.2732830-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5029; h=from:subject; bh=eGu2DApzmi0L8HX4HzBePl4/npJqwEuQr5WMXWg1eJE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCcqbELGAiDo/CBPuG96WSJATpKpcd71rfXPgHH ggfUleOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8RyrTYEA CilodL7VB9trSaR9ZMPNgzrexz4ir1vzg/2ADD5C1X043YoygPX4ux2T4NWz7+r7sLzdhpPz8mZaRo Md4PFbbWr7QGlgzFvyu4umiru8D9EhqeM/vtXR5iLwkklDqNteUryRg/9JT8A+Efw1Ib9KMhjZzeor FoUKFqV59fkhbfqMrvCk4W88Ub9NK/MumeHVdKCxCbjI7cuMJ/hVYOibiXt6aros77yqNwjpgu9Wl+ JWtEs6MNqpORNJYgiYGzffLYsmQ2qocp7JW0x2Hq9SSRmBsr7ziMetdUxpF4/mW8/xizx5xV3wbvgf f0aolfYU07gWwEgIJLSu/0fh+CcpJY6tDdbDJrt0HFJwpiDpzMElVBMbpAY9NE8kk4OHoyGNxxGTWZ wLQ5+/ZSCAc0+RFiJ1o4DH/mbq79dusO93rreHzy2Pu+VLTN8c/xKYWZHXQgQ2RdDymDRIKKj2eZQq 3OFGMeM6TrZ8cXNGoMbdlLNHr+5mTwzrGww8eRN7456kn6eIC3kv0z9QWuBxLiEESWP83J91jNQxJh 12jfdCN/dqmfHi0bRKGzSk1KxTgM+B+KOsQrBWIwvfzFkDfbvnSbMVIyw7z/hI2Q9XSzwV0rvsgR7L VvXYkxLRn9oef/q0Bc7sZC4x1LRE0RsPjpXnM6u9SC5E9r7thBFzpdam7szQ==
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
waiting loop, that is passed down from the caller of the slow path
function.  Use the RES_INIT_TIMEOUT macro to initialize it. The default
timeout value defined in the header (RES_DEF_TIMEOUT) is 0.5 seconds.

This macro will be used as a condition for waiting loops in the slow
path.  Since each waiting loop applies a fresh timeout using the same
rqspinlock_timeout, we add a new RES_RESET_TIMEOUT as well to ensure the
values can be easily reinitialized to the default state.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h |  8 +++++-
 kernel/locking/rqspinlock.c      | 46 +++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 5c2cd3097fb2..8ed266f4e70b 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -10,9 +10,15 @@
 #define __ASM_GENERIC_RQSPINLOCK_H
 
 #include <linux/types.h>
+#include <vdso/time64.h>
 
 struct qspinlock;
 
-extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+/*
+ * Default timeout for waiting loops is 0.5 seconds
+ */
+#define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
+
+extern void resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index fada0dca6f3b..815feb24d512 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -6,9 +6,11 @@
  * (C) Copyright 2013-2014,2018 Red Hat, Inc.
  * (C) Copyright 2015 Intel Corp.
  * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
+ * (C) Copyright 2024 Meta Platforms, Inc. and affiliates.
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
@@ -68,6 +71,44 @@
 
 #include "mcs_spinlock.h"
 
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
+		if (!((ts).spin++ & 0xffff))          \
+			(ret) = check_timeout(&(ts)); \
+		(ret);                                \
+	})
+
+/*
+ * Initialize the 'duration' member with the chosen timeout.
+ */
+#define RES_INIT_TIMEOUT(ts, _timeout) ({ (ts).spin = 1; (ts).duration = _timeout; })
+
+/*
+ * We only need to reset 'timeout_end', 'spin' will just wrap around as necessary.
+ */
+#define RES_RESET_TIMEOUT(ts) ({ (ts).timeout_end = 0; })
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -97,14 +138,17 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout)
 {
 	struct mcs_spinlock *prev, *next, *node;
+	struct rqspinlock_timeout ts;
 	u32 old, tail;
 	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	RES_INIT_TIMEOUT(ts, timeout);
+
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
-- 
2.43.5


