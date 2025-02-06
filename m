Return-Path: <bpf+bounces-50641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA92A2A66C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3730B167F51
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353B22DFB3;
	Thu,  6 Feb 2025 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJpMS/J7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426322D4C9;
	Thu,  6 Feb 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839290; cv=none; b=Q7OgrT988aWQIDg4nGl2NVRsv+2XuaWo7ui1G4UApV1SBtVcSNrmpsKK63klScy7jKzHabiXeMeHPA5tFpG/VgzWCPcVgxn+ZpkOqIBzlHyncoES8SHPcLaAYqrkZf7TD00n0vKGpyViNIZXXs+hMiLMNj4ilCDuS8qXKpMJq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839290; c=relaxed/simple;
	bh=+CI7RDk98Onq/s+jrg9zfcbapKjfoHyX6Gf/cOAFD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRLZkVqPoRWZIB2DoS3K8nlpGHdxxwwxph3beZyIVOwQBknOU89+LcbGWBzY2QNn8VGjq6JEo/fyf64iwV/37bjR6ATeKAJ3iOSiFTZBjwDL+WyFXFazXEugIX7DHbTqPehym25wgN3g6beGhZofpmTiSJdjhAjHgCZK/cUfx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJpMS/J7; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43621d27adeso4637535e9.2;
        Thu, 06 Feb 2025 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839286; x=1739444086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg5Aj/VI1QlQmysdMT47W3wgHFqoKVdLw8Vt35/615c=;
        b=UJpMS/J7uhBwYNK5Fk9Mm+HrFEyvW6k3QUe3YMoyJ4f2WgQi8Kdik6AIssuhT5St1l
         5nm7SYdpfAuYSFJtGkAd/k3TTzborYKdMOpohIVb8wVLbPhlKUHSh9fUtA4s8Q5aflEz
         9P/odUuETv942Z0KrAVlVHzZWIPJQsWCxMbfxaczmQf4LajcAhjPuLtkV7X0m7FbFL5+
         xfOUJtbao4UL7ULo11TO0/9Zm84vmdki54HR8Nio13lJyzlJr78zswbm88Os3Huacp5D
         jR9Uja8BLq/ZPN4CUW0MRjEHsSfwUXoBnJXY+BXD3F0dINGn0XRtc8EniiN1S5qg1Uol
         NeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839286; x=1739444086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg5Aj/VI1QlQmysdMT47W3wgHFqoKVdLw8Vt35/615c=;
        b=QdzAWHH1l2qFgAKuRLE7LzeBSw07xLz6yN+bIV7QCAetzRre3sqhuXFeEf8vQmlbaz
         zLF7cgOkYO1FWfJ1/AEaSs2XvFxci1lXMC7epu8f2Vey2GI31/xx6qbsDpS82r00rdL5
         FW367L3PY+JI0UUuEdqrql2N63YFCdKe35UukQQ+5AyY+fn4xi5A2s4l2EIlIaGV0CnK
         xC+sDIEVsiqgA1s8fNs7hgzU+jz8Y8SPG9En59hogJgZNtV2+MVkgEg7OREQXACtGv+1
         M+COWdk/012QmntK34SN+0b2Vu9WrZ78oSs2M3d0+WayYdMDrkGmP1szCNJuvnRGSTe0
         ODfg==
X-Forwarded-Encrypted: i=1; AJvYcCWyaKviVuEBos/PyWdtxPWR06l04+qVBPz5VgLnKzvmph8YsLZD1nBQR9tW63epcBevMvagOpQewewQtZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGQxxobir3JGmUvFfSz6rir8v8phLYoyY+RKZuyL/yxItZ3qw
	k0o8pmwx8sToQwC5j9qFtDeAkuTRlUjkxaFvdGp4YEjj/dWFRziDnwQSpsyCVTw=
X-Gm-Gg: ASbGnctI7qfmx+2kutYrZ17biecb/3AiBFpppK1E2KOMW33xAWk9xc0lxvvdxrqT+5k
	H8kP8fEnQhKnUiCNxk9i+MYer/ZB0FVu3lqwejYWcHGpYO5FFFzNDHOxNgNFDs+tNvR3IDsNX1z
	mKrkq7d908ycNgyuDSVTSYEDS6WlM8MLsCgsozh/ioYnPKDjPJVC6n1h2MVN9JBYddDmtmXAAnN
	grnhYmfgdVpLf8qQeO98Wq+QZlPde7sowAlgoBdHLxzIlf5zWwuXk2eUVTy1FOD2V5ULQqvzKLd
	Y4L2
X-Google-Smtp-Source: AGHT+IHYw/0AC8066ElVuaB+bONKwChfk8mv0EyRa3QvFZYateFuU3S3W5RTQoK6xFXLzRpsK0lELg==
X-Received: by 2002:a5d:64ec:0:b0:38c:1281:260d with SMTP id ffacd0b85a97d-38db48d5ef1mr4800897f8f.31.1738839286065;
        Thu, 06 Feb 2025 02:54:46 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1ddb9sm1383042f8f.84.2025.02.06.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:45 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/26] rqspinlock: Add support for timeouts
Date: Thu,  6 Feb 2025 02:54:15 -0800
Message-ID: <20250206105435.2159977-8-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5055; h=from:subject; bh=+CI7RDk98Onq/s+jrg9zfcbapKjfoHyX6Gf/cOAFD9E=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRko56eerusglxFABuTrjI0BeTNdWet/EFfKlxx n6KicXiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZAAKCRBM4MiGSL8RypHfD/ 9HHaEjSUQc5CtopQiXE6c0Vwac7KpTMW4wwJycT3bCu1KquGtKAhLC2KFqVX2wHK4bl/OLK9vxVSmT Y9HJRDo6MOTwwlMcflPNZ3sTdgVaOaqei2zDvi0fcuAdVHriJxcP1KZX+BOtNaX4oIBqMixlOnWT8n zk9/HR/PwfXvbdewufYQssneftjxoWOvuQQeFEhZlkhohK0wkeQGgYZ6x6dpnN/VU3PpQQVTbRQFDI q2nwG3DsniPReJ/kfk+KKkvpMIXwuCUQCswIjrMd6X+f8Gbx4HkDaoCK0jNJmLXz7x/qnXM7efk5aJ eNUrFK4ZNtavQLPKEs7/u1ksDubcrsL+PcEjSLPmM7S83+t6sEMMKte4jA9A3EhlIe3pOMdshKIwMZ ox0u8m96KQo3KwGtgfkm1xYVf6D/WMtXXhPzrlPQ9no39v7Bzx0BPhb1CwvoxQHGMvECHciFWXf1E1 lwy9QUGhK6aq/O7Wbf9dLtTyqUL22WhmoHXboRhy8E1Q5+h+jywgW08oMQ80fekxqIfrp7xeQuJxbs 6tUwh0BODBW6hRLhfkjt3Qu89gY3T/J/7YxiR5wbSV5A47TQLxdDH3gvALoDmdy9OiVYWlvfv6LgUD KhAG4jecaMw2SpR61+5VnBT3O5WvSYhyuAOcyVQLr68OWpdNT5LRRVSCKKDg==
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
index 54860b519571..c89733cbe643 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -10,10 +10,16 @@
 #define __ASM_GENERIC_RQSPINLOCK_H
 
 #include <linux/types.h>
+#include <vdso/time64.h>
 
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
-extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+/*
+ * Default timeout for waiting loops is 0.5 seconds
+ */
+#define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
+
+extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 52db60cd9691..200454e9c636 100644
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
+		if (!(ts).spin++)                     \
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
-void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
+void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout)
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


