Return-Path: <bpf+bounces-48110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DAA0417A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB33A59C6
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC61F4287;
	Tue,  7 Jan 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO+iZc8R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D401F2376;
	Tue,  7 Jan 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258437; cv=none; b=ciWUYikgAhoAcCOhSirZgbjW8vl7rShoC0jC4JaBXf8xJdu5sd0Q6iPoqAkmNeL2LcEzBB7Or3oA+IXjfXeCwEt//+FRiK3Xtus4eTPl9vYrquIldHrHlAEgDRf+rkQoJpHeDxr+hyy0XNHXiSv9rmbGCHRbvNu6t+YxvFsDF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258437; c=relaxed/simple;
	bh=NQnonbkW/L0ilYWBNW3FfTS4fYIHyEnpuydDkhm7gMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDU6ZTmWq+SSFqKjnRi9HySH0P6U3l9s65cBp6q9TnxXo1t/AbiAp3p8CRYb0o3YXVMNl9GGyLNBGNzWvdVs5mQLplFr8MK8S1hvBzX52ryxqEXRE5f/mQWvjruqqA7okzfun6tCsTe/r7/OZq8VctM0xYVBNavv+FdmW6Zmzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO+iZc8R; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4363ae65100so160609035e9.0;
        Tue, 07 Jan 2025 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258429; x=1736863229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43tlysq7zNNGdym4AGQ5BQPyh+ovqgtK3c5cIvqu77U=;
        b=EO+iZc8RV29si4rPbJe+GcuXdVSPEtyWqVf4UKAATIg5KxSqHBJKEIFn02k0OSzCvc
         bviZM6GfPFAR+e1rAaqkc0sGY6z261G+HTvcYeqSP/o7DgWMG7OOiY+hqSacYe3wHBDu
         7nokbVqzq9GoWlcxggG00JjDYp28nHiayI+djRLSwC1w8y82BwreOPcQo58RrOCnipYo
         YNmNqmTzT3313yI8DQ4Mf5Bza76oX9oFVZHS1vHtmlrP+atcMSkAfwu3GeI/QhMiykf3
         011TVmM6nirV1xhfGvZLjWwa+zSuHwcRB0Rmzj9829+c5wzs4E0jQiSPj4WLIwimqRYN
         WiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258429; x=1736863229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43tlysq7zNNGdym4AGQ5BQPyh+ovqgtK3c5cIvqu77U=;
        b=DbLcUML1kDRHjo6VmFlhsYxMjQi14dsWmyV0MKMkxUgPZkQ/pmxkzrtUJ35rLk90Dh
         6FfTRbu4aUMvFDZj0gErR9MMG/XwBZm6amDO5oJXUDGDdP/wFZ8NqIpyRW6ej2fjyGgq
         dCImFE2BnH8hMSt7NzU31f53WCHEtt5/9wAMMbi3f3NeCtpbGWhZelKbuYLdtgGzc8N4
         34+mDuFWUunbgjXwVTH3eKfeILFPSSywN21nBFiMWUfg7gwidw1cFf/mhCvLXlF0xQ6b
         h4mvhuZN75WlftWfo0tcMXOQeZ48cRA+C0Ze7nWPQ3eKEsIkVPAUB6A6QZoC7v3Tvcvb
         yoAg==
X-Forwarded-Encrypted: i=1; AJvYcCXmT7SaicYSUAeLGGmXAyw69xRfmdL+hdfDyXa0FJg6kF1+Dh7opPstWzeKNyb/kshAjrF00X4SMKNKVQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiQEUA2y69CpGJT2qON/4m9MAGKXYJEgp5z1kuvSxhC/KFk2O
	shLgZpmYhLr9XVYXQgynLXWj59cQUyTB59sraO4Vx6jGu8lKsP6KijJOSU1e3dS8Ow==
X-Gm-Gg: ASbGncuP50Jn3r7IW4CvemgYWBOhNZHfErAGSKa+i2poJkUDuvbZCE1wIQJV93+awfD
	2kMPeSFZgb29AAilaS95biExWauukByfG5aJi+15PuVuK4gaX6ZAaUW6kt38U3L3Tpj6haGDdNn
	/A79O4oAG19m0EBc6jdawc70fZQT53Or7V4ejAkOD3sgnYyGTzLfq2649aw5xWdq27MSJBx2Idk
	pmyj2cocrG0yJAr93IC7KBX3Ei+TJR2ucBkrwa9zA22ge0=
X-Google-Smtp-Source: AGHT+IEgs/CTyhXlpbJq4uE7mFMuNocBUtYTYAGlhXSBEO0EsyT4ki+VksmyEB1NVrQLSmsw8uKiog==
X-Received: by 2002:a05:600c:3b18:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-43668a3a329mr492775195e9.24.1736258428594;
        Tue, 07 Jan 2025 06:00:28 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:15::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4471bsm632262645e9.44.2025.01.07.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:28 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for CONFIG_PARAVIRT
Date: Tue,  7 Jan 2025 05:59:54 -0800
Message-ID: <20250107140004.2732830-13-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3736; h=from:subject; bh=NQnonbkW/L0ilYWBNW3FfTS4fYIHyEnpuydDkhm7gMc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCdeJqRobD31GnRq1Z9++ZTfPF+Ex0kHzRftxhT qxlsP8SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8RysMeD/ 4zwGKQ3IE/6zj+ChEvtzuu1W18Ht1uMsejMp6YIITG3U/2m5Aq0JWsiCpC1SsRv1uu4PdtdnAYeoDo iCgVCbn/mdw7AwmuLxa/TPWxuwQsP1fh9YwjJWFzTqb9dYcxS/C+WN7mKQUjQ3hnhm6sXJrY3+z06L r/sZPuH8uxpAmCgTaB5AdEEL5Mmq6I0vA9Dyj9IBvcnTDuYbZY9yl30TmD64is8Jj26dfor96bEsfj vswk8bkpL38CWWj4KJL14W7j3G331JL9trBQlJCEUTHmTp7Chofg4wBvhIG2qz7wy9BTa+1IBUV20E whWnvBcZ5N1hYbb7GCcd0IR+0ht2h3Oh0RQO5aoVaSYYQE3PQN0GWSe+WRqsA0UNcFCYhMJ6Mz2G+3 UguSrgciUmQqIUhqXnmf+ZRF0qOYElZN4Vk0OohrSeE7QgJrYAVf6VMAbOALNhbMCx7EdH1RJ81KnT lFPkIv+/z3LgK9kqu/NnmF8VgRKFKjl2rgq8Pxugf9L7bOTfYReEMxAekc6zwRYwSuGOmxtWLl23KS lX9zlyc/qmripuJZ5o/7WGKQ4K0a8vNtQ/F0Kk++wLN++tUjqx+8J+oSdwW1QGImdFkqYsjaQgRKkY ly6M/7lD2ej1RkeOnx91GpzjlpJ6xMRru6iIeQhO+o2qBKjFUlxZrdiO7k8Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

We ripped out PV and virtualization related bits from rqspinlock in an
earlier commit, however, a fair lock performs poorly within a virtual
machine when the lock holder is preempted. As such, retain the
virt_spin_lock fallback to test and set lock, but with timeout and
deadlock detection.

We don't integrate support for CONFIG_PARAVIRT_SPINLOCKS yet, as that
requires more involved algorithmic changes and introduces more
complexity. It can be done when the need arises in the future.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/include/asm/rqspinlock.h | 20 ++++++++++++++++
 include/asm-generic/rqspinlock.h  |  7 ++++++
 kernel/locking/rqspinlock.c       | 38 +++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 arch/x86/include/asm/rqspinlock.h

diff --git a/arch/x86/include/asm/rqspinlock.h b/arch/x86/include/asm/rqspinlock.h
new file mode 100644
index 000000000000..ecfb7dfe6370
--- /dev/null
+++ b/arch/x86/include/asm/rqspinlock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_RQSPINLOCK_H
+#define _ASM_X86_RQSPINLOCK_H
+
+#include <asm/paravirt.h>
+
+#ifdef CONFIG_PARAVIRT
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
+#define resilient_virt_spin_lock_enabled resilient_virt_spin_lock_enabled
+static __always_inline bool resilient_virt_spin_lock_enabled(void)
+{
+       return static_branch_likely(&virt_spin_lock_key);
+}
+
+#endif /* CONFIG_PARAVIRT */
+
+#include <asm-generic/rqspinlock.h>
+
+#endif /* _ASM_X86_RQSPINLOCK_H */
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index c7e33ccc57a6..dc436ab01471 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -17,6 +17,13 @@ struct qspinlock;
 
 extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
 
+#ifndef resilient_virt_spin_lock_enabled
+static __always_inline bool resilient_virt_spin_lock_enabled(void)
+{
+	return false;
+}
+#endif
+
 /*
  * Default timeout for waiting loops is 0.5 seconds
  */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index b7c86127d288..e397f91ebcf6 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -247,6 +247,41 @@ static noinline int check_timeout(struct qspinlock *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts) ({ (ts).timeout_end = 0; })
 
+#ifdef CONFIG_PARAVIRT
+
+static inline int resilient_virt_spin_lock(struct qspinlock *lock, struct rqspinlock_timeout *ts)
+{
+	int val, ret = 0;
+
+	RES_RESET_TIMEOUT(*ts);
+	grab_held_lock_entry(lock);
+retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		if (RES_CHECK_TIMEOUT(*ts, ret, ~0u)) {
+			lockevent_inc(rqspinlock_lock_timeout);
+			goto timeout;
+		}
+		cpu_relax();
+		goto retry;
+	}
+
+	return 0;
+timeout:
+	release_held_lock_entry();
+	return ret;
+}
+
+#else
+
+static __always_inline int resilient_virt_spin_lock(struct qspinlock *lock, struct rqspinlock_timeout *ts)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PARAVIRT */
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -287,6 +322,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 
 	RES_INIT_TIMEOUT(ts, timeout);
 
+	if (resilient_virt_spin_lock_enabled())
+		return resilient_virt_spin_lock(lock, &ts);
+
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
-- 
2.43.5


