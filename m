Return-Path: <bpf+bounces-53076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A8A4C4F6
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9516B98B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1021B9F4;
	Mon,  3 Mar 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+IrzupR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6F217F46;
	Mon,  3 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015403; cv=none; b=fhmcXD2o5wyr+iXCNNR811c3evct1V0TJ4DVQzzh5m6yvySl+NRORxd6LNNQEA62VAnI/owNo9arm4xFx/c8do1x/Sy1BMFMeMo3KAJT3CN5rLyQF1oHY3HGvYljDr8/JOGyyPgvQvot1WQRKGq8g1wmh4gBqVnyAJwAzPZ3baA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015403; c=relaxed/simple;
	bh=yvqL/a4hlJcETEVluNNRDX4NLx5YZM2izb98JHL7vqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLnvRMaJno3sYgKKmVNIYGLc2uv2hKclwmxaaqzVI03xY95Hehmr+Oa+rBlr23oJYwPikjFU/FXL4xHMRZdtTYy6fQfw0gne5IKjrk7v0yXIZ4hKIPtpDE/D893Z4t9LKG8rGY/FFPCNf5tcGc7/rhKJzzNqNvjnPIf69G6MXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+IrzupR; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so43690825e9.3;
        Mon, 03 Mar 2025 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015399; x=1741620199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/HTxEZqZcqCwShvGdM3eA0fWGvVAu5JcH2SiIADZmE=;
        b=b+IrzupRyeEecmDU1c1L87OUw+ZaA3EpXUTie8OXAYLIrH/crnDwkbdZXbI5fkCGgr
         FVERZuXKnprHRACrcvqxPRdu9ysstt7tFALWCvSQA+qFtRoN100mGFSXkMTIYrwhSg6n
         Z0n9t1nFfqdhMMe9cn6kvvQIzIctLsdjgZrS2gClJtYQN2xiFhB+zAhYzmzUeLyngAtU
         jaJrooyLb+KoYFEngMQDEIQvFcIfs1pO34769Q2+yQ6sxajz7YHS3ll6yRIHI3V3Daw+
         O47a+1wszwp2Fb3ccw/496HA5yqYqIs5yZr2BMPaGJVIaAvByUI6M4r6KeYiU/pWwsOV
         xzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015399; x=1741620199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/HTxEZqZcqCwShvGdM3eA0fWGvVAu5JcH2SiIADZmE=;
        b=H1w0Ptr00YcIiqVbo3mtN/H+MBV/72hJEo6XyYu3ss+rPYXQPXISENaWe1DfR3hptL
         PNsdZacAY/mb5YRhHrMkv/rfIEAMn1IhVCYGtCZCIPTGNDfmYpPxVZjCcV5CqGEql6px
         +pptyrcI2OS8ejZ4swfKG2fxFJJIKOVvWcPPkDT/BItZRvZGMvhhfCMeTlisQXZ3G2E6
         2YaubY6BNejAuaTKqsY/yQAHCrxvyta9vqTaVvL5Rhh3rr825ZNRLDlCTlu0UiuwNFmq
         kGjN5nOP+mOzmClRAXbnOwF5dJmiUZNfKZsouD4TH7p9Rldg743Cy2VIV8939ux1xe6A
         iKvA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRFs2d1lrG2aXxFJRCBUSbWBLEqpUEMQHeQI//ozhHBKFOx5VttvNaetikrcwRn/+G/BxgspqMeKerUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxig7dPLWSck70lBe4/N3G2ejqhKFKvbkmBN/5cqN2M6yXTVCdD
	9Qj4EC/QrJsbtQyU2hghkFT6r/J/nZACF2/1k375Tm4PAabbvrggVVwCJPU+G10=
X-Gm-Gg: ASbGncvOsNyNnBe3yI3JU/f36rXNdlc7Kdllqux5tRqV2hadkorOoL10ga5ZH49km30
	URl8+voKKNjLxnY4D4WIppBxSJWEh/EHtyaFq6QU37f8NjqWVLB1Qfaa7Z8bS0P4RaeAoK2VqeW
	Cf6n5n/lDOD5qwU2EFrFCJs0a6I+4MgC4jzFe/nWL5jIxKnwOEUi/2xJBkN+PIe41SvmK2exQWs
	Q0VItx248hy314jfT9YN3wD4Z+nO1gQBiSvQuBN4xV9W6n5N4xkuFyAd5hpDhA6f1PNLC7kdxPF
	T7mAkPPJxdy5cOCo+NjceIoUI/1GytWDsDk=
X-Google-Smtp-Source: AGHT+IEbsAZvJmITJ9ICif5ulCDnUNtcT3LryQIPvfnsjMgh8qRyST/7vsmVWTkT2yKdvlAmVbm5gQ==
X-Received: by 2002:a05:600c:138e:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-43ba675a8fbmr94459815e9.24.1741015399077;
        Mon, 03 Mar 2025 07:23:19 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bca26676esm4051765e9.8.2025.03.03.07.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:18 -0800 (PST)
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
Subject: [PATCH bpf-next v3 07/25] rqspinlock: Add support for timeouts
Date: Mon,  3 Mar 2025 07:22:47 -0800
Message-ID: <20250303152305.3195648-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4618; h=from:subject; bh=yvqL/a4hlJcETEVluNNRDX4NLx5YZM2izb98JHL7vqQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWW5YAHky9QnaXijfLpbPfmrcJbz9mGABaMN7Gq 0o42/62JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlgAKCRBM4MiGSL8RyhFZD/ 98oVQe8PFJhIllEShh4nhwUHn8NyXfjHgZA8EYD/afmXUtbe6cebWH5AkecePI/ENfeIJGVq2k75qO bvWe4RtiqLDWBsJl0E7U+s2KeDZ0DSk9f2WEvtzxSmCp/7UvUNNCppI/KwpLK+0e7hAe+GARXNg60S gvFuMulaOvXckRa9tpI+Hr6QKTNcN2LRmRExBXLd9T3LEoZTDJmyajfWO+Rfz5YU0g5KANdcy5e0qn GSzgVdRNgcSQOk3Zbp4619EukeKa9f23Tg02x5DCOUpx6mZ5nLqck/vFZ9oU8Webx+07h2RX91o2Kv TN1pq4jrCnQVVKWpOXrlnqPje97GpGVOCULGt1HNSZjpiEHi1aaxH6G0Y04RUnW0tHWAoxe7UDJk0o fCSuU0DhZpfltTY7/WE+Vf0bJFidSjLAaFUBjfaGSjVpQiuT/NaM6RgcLOAfFZ+kZKor4iNdDigsyS uMikiOXPVSq5YpOAmNxGz++xsEFagK0j1pVs6TqaC0dd7hKb57Ww60taY11XX+2jebXLUb/Ujov7TM eHo97ARRBCdiHc7+5UtfXPPw64OraEi2LfbonjvDU0tqtoL2yij/h7RNtLLUQP0RCqFJfuaR1AezSv BHNMKZgxnulhR86H/4dzv/v/FYXTwu9j3CZEhgrEpd9sdWsCL1hOwLpR5Hcg==
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
 kernel/locking/rqspinlock.c      | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 54860b519571..96cea871fdd2 100644
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
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 98cdcc5f1784..6b547f85fa95 100644
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
@@ -68,6 +71,45 @@
 
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
2.43.5


