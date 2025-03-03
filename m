Return-Path: <bpf+bounces-53074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70BA4C4E5
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8264E3A3D14
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB9216E39;
	Mon,  3 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt/DfloQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F621577E;
	Mon,  3 Mar 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015400; cv=none; b=Oyl9jJ3xhlfk2frrOUnZggBdpZd3mpbgQFOveUFc7gtQDEyX/e91v8hNT/0HqjRtEvl4crxPoXejyuGmyzNzmvcLWUYNqbOem3iLKLBejg5gjDNKski8c3bgiuMzs6VXt02KKwrIgCyTU4c7JpHeHO40qPkow6avxQk105DW1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015400; c=relaxed/simple;
	bh=C0ciCNeduyvvQFAO0DwlqwtcddwN6zNDgdODlI5CgNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1VIvNd2CFJev7WdfDLJsRPDaBpZOxY4Tk43Un5+zGQTc8Yk/ui1Y85kvFzhnnlmMUFp7WA0u7u5D0kke25u6ZYPx0me2NPHd3NduMJrDjnjdTwnYbSEIc7+0QJVbyDfXLLeFwwHG2UZ3uN8qxFFI/hHZ0vOrwmFWiM5KrzgNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt/DfloQ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so29239935e9.2;
        Mon, 03 Mar 2025 07:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015397; x=1741620197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4KdASnnyjPBe0E8JbE/B8q1tkmUaCwFOXMgt/4BU28=;
        b=lt/DfloQHy0LC0EndTqHv1INvtUj8FZn/V4BmDCE2sGh1ywS768fs7KTuul71rFLC3
         aEdFpCEW8wzbKJTXILCa6u+OotXzX61tvWQFw9+wb31VwUdDs4RfuKbZNBFoNA6bmRQl
         ytPzu62VxIbOJeuqNZLo5eAn46FtWnUzJtLysKPlRRXDaKf4bdYcqOGWmDIRoC+1gkRA
         hZp0fcnjQIwVoVf8Ev34BbaoUWo+BbgbT7DCSqgzim6cmxSchz6gQRhYsOAwSxB6HfDk
         kycvXXL2WqBebE8wGQ0+ptE/5lDB9PNP2uKigcd5aEp5+LA480viirzvQKvqgM2wKqur
         7TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015397; x=1741620197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4KdASnnyjPBe0E8JbE/B8q1tkmUaCwFOXMgt/4BU28=;
        b=mVr0QDvmXSMukFhZ7R5v0SlCLP+DH7MiejYooXKBW7NDHRJB79CVd1ogGjoatShDRS
         jrDQdfyxbfjbp9zVMN42eZOLOO09ZbKhuBqGCUQzeeJPgn6pjhluoCCQ1dJnyfToh/05
         KTnCwc8YvhJW4SxpevQQIdlQGVeby8gKr2CUmwbsZvNJKUSz/S9Acqixaw7nZDvTP4j2
         LqjLKacFyb7ZNolE6dIq1AftEtVIYBPnV/r+ZukapjF2i90+xYW320cl4r5LvVvqPAht
         +NMcN9Att5W2AYPXIcWCn0qnKHA2yRqeZDj5iDOzkZyxovDF+vNEbTzWkT/qv4HhtBcr
         9yBA==
X-Forwarded-Encrypted: i=1; AJvYcCVjkmFw1Z6GDxOYGDfV+d/3xBNgD3jck/hXDRCwiFZVX6XvWDBFFAfssswC72Lht0zScPu41KyH8mpyyRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3Atno+Jq4Y8d6a0m1m7ioNdvhLiN8YUd9oHn4Uh5+CXKGFz6
	O3F8qbZ58BBqr12FPkDmyAjvuKq6oenCsOdCLHkIQZd82Ceu1ZTxHi+OuOs8QNI=
X-Gm-Gg: ASbGnctKNR+27FWDluihPb1n+rKM2pMbM+QVT8ifMrb31+jqqtu3PyZbvkvXEzRPziZ
	0hNKnf8WVubO+y9VOT9mEbNpSF34tsfuZ7hwufMoW2rl3WwSnVjXHwRYjxyaylOduG6gJgM/QpQ
	TjUW9oOfoMsSSnhvbAXvU1xXffdieEZcSS9zZKTqojrsbUCBgVv0j5C/F7lithBCrG0OQP1kEh3
	xXkzLN/hX7l6SDpXxpdoZso5dfOmk+ejGGNn0QA3fAzICq9pUGctbjw9Af5in7EYskiEzYvdFhR
	IYeSX3c/Dtea3tgYNQtreIQKyk+bxMolHHU=
X-Google-Smtp-Source: AGHT+IEXzqJkS/D47SGG6s47BNUvrMNCFfD+WCo/Ixy2e0y3ir/cTpzrdXL3Bgt5bdvzEI6kv6bwOQ==
X-Received: by 2002:a05:600c:3ba9:b0:439:a155:549d with SMTP id 5b1f17b1804b1-43ba66e74f8mr113912555e9.12.1741015396488;
        Mon, 03 Mar 2025 07:23:16 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:50::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc18452c3sm41377135e9.25.2025.03.03.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:15 -0800 (PST)
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
Subject: [PATCH bpf-next v3 05/25] rqspinlock: Add rqspinlock.h header
Date: Mon,  3 Mar 2025 07:22:45 -0800
Message-ID: <20250303152305.3195648-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; h=from:subject; bh=C0ciCNeduyvvQFAO0DwlqwtcddwN6zNDgdODlI5CgNw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWWmeJIFZGQqQJ9zuXTndNKetm3e9meOOzs99f5 56FqOzGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlgAKCRBM4MiGSL8RyoR+D/ 0VwsuuvPBO31kFGb0t61y+N4gbFPQVPDJBrXCTRuRgO0fOw5WCQWwcpin+e1kMbSgYKAZzVwfLS3fl USxgEUjPhUFvS788CF15UqpS6n/tM0irZYhiD/4t5EWU0g0ioKfKj6gj6yBwqsSMBTsIRoIbfdAtpW A1sQkzl5Q8TKau41XUFL5/fRetjHPVeJCUKabg5SUIG5I9iY6ZjqHLHvD+LFUnOo8bFfHwkb1uWXh3 hFp6LuX4Ip5Q0OVOMs+ec1b0966SfNEsHIk3+Z8XY4f0eqnk7Ez83Zc/Hjz7csGn6uh8bcb6eG7ZYC +/A6aSKaqeZbUC4ssfb84IHdHW7hVWFUk4czo8NMacOAr3Qy1tlY/IIaFasBI7NmhQiZgLc8EPbgHi 7TMVD7hKBCP+NHjd0dPY2vu1dxsGHJ7glfhHL4X9QrkiqZi5/Mkl3n7BQmfN/AKLVD7Azctv4JBglx VxQbreb1HGCpiW2R+/1KbXrT472iuSH/6kefuuYYh1hQbdVrvkEdNJfBXlKOJBdRGO9hA4i5b/tbBn 1CQPYg9cYRVAZ147OeK3geUwV37j9ZjgLrI0+k1TkwXMQtUgriZg5GETC7ZgO+AO2BGZkTI4gFTPr6 Jo2JmjrdfCTWQ/LMn3yeXbbAnc4me8NdPXySZtWjaqKhp7V4WbNvPwwg8qPw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This header contains the public declarations usable in the rest of the
kernel for rqspinlock.

Let's also type alias qspinlock to rqspinlock_t to ensure consistent use
of the new lock type. We want to remove dependence on the qspinlock type
in later patches as we need to provide a test-and-set fallback, hence
begin abstracting away from now onwards.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 19 +++++++++++++++++++
 kernel/locking/rqspinlock.c      |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/rqspinlock.h

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
new file mode 100644
index 000000000000..54860b519571
--- /dev/null
+++ b/include/asm-generic/rqspinlock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock
+ *
+ * (C) Copyright 2024 Meta Platforms, Inc. and affiliates.
+ *
+ * Authors: Kumar Kartikeya Dwivedi <memxor@gmail.com>
+ */
+#ifndef __ASM_GENERIC_RQSPINLOCK_H
+#define __ASM_GENERIC_RQSPINLOCK_H
+
+#include <linux/types.h>
+
+struct qspinlock;
+typedef struct qspinlock rqspinlock_t;
+
+extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+
+#endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 143d9dda36f9..414a3ec8cf70 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -23,6 +23,7 @@
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
 #include <trace/events/lock.h>
+#include <asm/rqspinlock.h>
 
 /*
  * Include queued spinlock definitions and statistics code
@@ -127,7 +128,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
-- 
2.43.5


