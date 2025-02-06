Return-Path: <bpf+bounces-50647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB2A2A679
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DC23A5716
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E722FE13;
	Thu,  6 Feb 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXwPRE7O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4322F3BF;
	Thu,  6 Feb 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839299; cv=none; b=pUtk56heu2d/nXAkL7Pug0/nybpo49raJVMNZeLpbQKcoP0QETVjQL5P9SJ4kTPz2pH2Jdbhp+wDnwAYSDdQ+QVXk8sHjtr3vB+1IT4aOn3ZL/PgzoB9qisSupQ18NWi9hCkq8AzFECwub5bjNTT+H8Hm39RXxQRPqRUWeJJCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839299; c=relaxed/simple;
	bh=zXQSTFNS/c2U8KM3FgC7kOLmnF5sm9qLW6KNbuMrArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/plZx4nVXL/2eJ6PoG+dXUPDyusHId5hvhqn+0KbXBA3Hlo7LneZ0isKe0AMJDeAfEazTUU9oAy2dc1f3mtLD+yb7feJ525m/1eG+vd6iU7S4h2ACO4NkzpLXMH/EElPf27ImAyUPg5bRHLEU4kgzm4gGWomfdYuvNePphsx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXwPRE7O; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4363ae65100so8239135e9.0;
        Thu, 06 Feb 2025 02:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839295; x=1739444095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U/x1GfGP9j2cvu14gMbHcehw03jG1C+3eyWlyvy1zM=;
        b=RXwPRE7O6g8nlieebruXbtuU+4mpat4A4cQgaIb38tWx+9o6KIlBMjM2y4nR1Mayeo
         BG/VWyKVBivH8hVZ85bWKigoIBtwnfU1xJDLkF200Nqjie6pk15BcNCuCDOY++IeNAyQ
         qh+iXs99YEs05FPWHBG6yFx5P0rqVjJYXezxbwUjI/W7aOl2kcT0P4fTOGGYRLCVFENB
         bVKYr6PoRMvTNerw4L13fTI7CLerH56g4CkynWo8CBT1oi3sl/Qww3brRZia0xVd4Q61
         EMMYUMLxZgtLI+g6dVnFT2xPHidjkYNxkvnbirPT4to6bHtAkHXwI91rktrpsf7Tv1qZ
         0JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839295; x=1739444095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U/x1GfGP9j2cvu14gMbHcehw03jG1C+3eyWlyvy1zM=;
        b=tXctsKSZbzAf1J2JDztORLrKB061n/lgRe9uzaNVlK41JYALO6A26PCnaKMkJhleAE
         mNBr1rQcWMMqpVkrSV9rdNLQhmp4Tdkeh8KuRgQ4M0/JUIsTaNIfjFBswt06ya+QIXNE
         jDp7pT38ymLtMr5joCY8cXn+m1XmwJFq+XbcCff+Pb+of091yPEIqWtYcJDvDq97fLsT
         Jkw4bzrPQts7fT8unB2bClIVg8CE1r3h9ZA2f3dFGEXlBoNwrKkG7vbSP12L0dDV+gl6
         rGR9DW0jYaRxipiDpRRgP9ha1LE/SEC1caGl0EMf6x3sQciQQpIjEooAvStfzirMy/kf
         XuOw==
X-Forwarded-Encrypted: i=1; AJvYcCUfUh6CVqQFaYeJhxopX4qpinFaH5QCf9pEdRCMcJLqiP5sWkBmJxi1R2R72SUXYLJ5adhjg47Rnol+VFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRqLxbktviDnvzh8rlNwWKWuq/qWtzbmBuehRgwECQXBuXaEK
	ObH6dGSTXnoipOZECPJCW1bkJcnraF16Ozb+zqzUhSjqeiRmAULSjL+AXpy+XoQ=
X-Gm-Gg: ASbGncuIgcmZYFkvuDwcB53Nj95oyRakiBtMxMHXIurVoVpc7gGeinGPmRFvB3lgvqQ
	tld5k0yLlfSjscyUTtx5TPCJ1jUi/ErOtrqYZWKllwFqXEhMqRfygQzKiLAqVsnxvxVhoe2mCeu
	HpIyAQIRmQZmGScbdmVSkRhOACuYe/+mbJz0i5B8JxE6qYO6P51blpBl3LMHcBP0Sq3vgEZZs7q
	KiQUQ5PB2SyUXOo0fwCokeQTqwgSoOeJCxUebvQhlmbO7tCc6w2SC/YSh9nlVSH5uV/aZutEEP7
	tqMF
X-Google-Smtp-Source: AGHT+IECKDGAzq+Depq2+nIptoAD3ksbrPRr2mBSOELhwPjJa2kOGcthn5Lo7ZSMn0/ZXamyQQJB4g==
X-Received: by 2002:a05:600c:4f05:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-4390d4350c4mr57549575e9.9.1738839295278;
        Thu, 06 Feb 2025 02:54:55 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd7f081sm1429621f8f.58.2025.02.06.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:54 -0800 (PST)
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
Subject: [PATCH bpf-next v2 13/26] rqspinlock: Add basic support for CONFIG_PARAVIRT
Date: Thu,  6 Feb 2025 02:54:21 -0800
Message-ID: <20250206105435.2159977-14-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3266; h=from:subject; bh=zXQSTFNS/c2U8KM3FgC7kOLmnF5sm9qLW6KNbuMrArs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRlcUneWOnutzdUSHTyEeSH9ShV4gvRxjc/jId8 1YMMoZSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RyojREA CAY3vlIDeTRuUpYBE+KFscZYPr9H8/q9UrVdKjYtlSmP4kUMnaYDdROM+/Z1eAE/ooLx/8vdb6tzBt fc3B+DxVL7tQO7jgkFhs8TWzKKlBa8uCE08YnUR183pRuI7FMMaaHbBakUz76eIN1rHwUUZnragSZK FI/5+wGEKE4O3AFSc0b6AVE2v7Ac5Qz5hBBsks/FANKm3Hdx0yJa1axdExsWkJREbmmLTO1RDjCoQZ MVoAxyPIBWrHsWFp3WUr3AGAwW/LT5cz1ADzDNURb97YC4QLdg4MG3NfjpdyWd2jj378mOBYDMydU7 ifjlmuV1KLLhJCbrDsvImh8rxY4aiH1tOMPpfC/pCCARozVsCCt/0NqyneZEa6ebt3Dn6xqnWrSM0D P8kjr4HmLnUenqsX6gCzKA1pntH7LoAXkWLdXVX0Ekt+LIx9dUbZSsloW9AwF+9r/JRRMOBYnNcUDq YDOdMDyfNFfvCjHd9qxbMa/52CU9Tl7upwFr/RbcEK4zY0ZgsV0kmffC3TAPnB+MzzJZwwtdF0ajVp nFsUX1lkdCe1xJTlMFPMzPgqFnxoN8cIGLIKW7BMNq3lr6eU9cBn3XZGlQqrCRwdk/yLylSriVacdL F0y6Ga5GbeLS7YaM3SQtcTwKK5K5ODeXnTU57iP8D7BcG5/WmFu88d6x4oxw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

We ripped out PV and virtualization related bits from rqspinlock in an
earlier commit, however, a fair lock performs poorly within a virtual
machine when the lock holder is preempted. As such, retain the
virt_spin_lock fallback to test and set lock, but with timeout and
deadlock detection. We can do this by simply depending on the
resilient_tas_spin_lock implementation from the previous patch.

We don't integrate support for CONFIG_PARAVIRT_SPINLOCKS yet, as that
requires more involved algorithmic changes and introduces more
complexity. It can be done when the need arises in the future.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/include/asm/rqspinlock.h | 29 +++++++++++++++++++++++++++++
 include/asm-generic/rqspinlock.h  | 14 ++++++++++++++
 kernel/locking/rqspinlock.c       |  3 +++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/x86/include/asm/rqspinlock.h

diff --git a/arch/x86/include/asm/rqspinlock.h b/arch/x86/include/asm/rqspinlock.h
new file mode 100644
index 000000000000..cbd65212c177
--- /dev/null
+++ b/arch/x86/include/asm/rqspinlock.h
@@ -0,0 +1,29 @@
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
+struct qspinlock;
+extern int resilient_tas_spin_lock(struct qspinlock *lock, u64 timeout);
+
+#define resilient_virt_spin_lock resilient_virt_spin_lock
+static inline int resilient_virt_spin_lock(struct qspinlock *lock, u64 timeout)
+{
+	return resilient_tas_spin_lock(lock, timeout);
+}
+
+#endif /* CONFIG_PARAVIRT */
+
+#include <asm-generic/rqspinlock.h>
+
+#endif /* _ASM_X86_RQSPINLOCK_H */
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 92e53b2aafb9..bbe049dcf70d 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -35,6 +35,20 @@ extern int resilient_tas_spin_lock(rqspinlock_t *lock, u64 timeout);
 extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val, u64 timeout);
 #endif
 
+#ifndef resilient_virt_spin_lock_enabled
+static __always_inline bool resilient_virt_spin_lock_enabled(void)
+{
+	return false;
+}
+#endif
+
+#ifndef resilient_virt_spin_lock
+static __always_inline int resilient_virt_spin_lock(struct qspinlock *lock, u64 timeout)
+{
+	return 0;
+}
+#endif
+
 /*
  * Default timeout for waiting loops is 0.5 seconds
  */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index ea034e80f855..13d1759c9353 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -325,6 +325,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (resilient_virt_spin_lock_enabled())
+		return resilient_virt_spin_lock(lock, timeout);
+
 	RES_INIT_TIMEOUT(ts, timeout);
 
 	/*
-- 
2.43.5


