Return-Path: <bpf+bounces-54129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F374A6339A
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77811889BF7
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A1C198A32;
	Sun, 16 Mar 2025 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDnpEO6k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BE192B9D;
	Sun, 16 Mar 2025 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097965; cv=none; b=NvXwkWXG1eMt8N1A3Nq3oC4EJrf21ColVRmUm3AiINzZOJ9uc86T3baPoLYPl/7qGyHESi7XP2mHtil1VVRIX+013zQuhykSoN62+6hpIdlkmLe4X7L/T7s87x1HLrIdbqcu92n9QhgFmUZcG6i06WN5xrms8cU1RYCP5UiFur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097965; c=relaxed/simple;
	bh=9lJX2DtyRTnUplpFVsYE5ziAxwiiosjb1D9cDEXkG+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkeO0s9cBw+SNFP7xKwqVDoyeJGi/1T7z141kPyHYNwiYRdfRe/LK505vtaL0rh5y24wJAltmU5THSMtlBtJ3XaERE1YBtJFT1Pnu4ZuzVdyasCSuRUWwS6KwY2uZ6L8GxniMb59vskItF6w/cjqV2WaE/8KOQkn0QJGWVJwR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDnpEO6k; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso4711655e9.0;
        Sat, 15 Mar 2025 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097962; x=1742702762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SJ4rKlnRTNLC7EmgTg9GusoyyGplCB9SKvBAwvhMho=;
        b=fDnpEO6k1iJmQ7l/pNxutdoDQE8I+y2ZIbxP0kYNVcIC79XmeKm1CnUWRItPSk5K1z
         oMXr173LZDTFaDgFbaz+r9rQ2WQc1gzXqFJ+Kv+nK8fLFh49u1xTc9S1IaT2XMN24BZg
         kwgJNg+oEOZKFbbh9/wjvsL1AS6rnwq/I8JmR2sxvoYIt3XuQRL83zJ71XHbVdZPmmlL
         R3bUmzrMBthOYHoX8ZcaW18bM31+Edxwv6fVwUHtBfAFTqSnzAArio9XIsCXrdvdMSUK
         nQJjlFkaeI9Y6jggnFnh7MtqN1NisLqOJemUGcxjP+Xx5GtTdrPoenQIz5iFqwO6Sq17
         jPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097962; x=1742702762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SJ4rKlnRTNLC7EmgTg9GusoyyGplCB9SKvBAwvhMho=;
        b=seDKnX9ZJp1lOibyEsuY29OoPxw3J+84PqQatzKlrss89Hx/01sdE/NSlJXHhFmbvb
         sVAbB76hdgxwJb0aN4LGUzfK9slzTSWhVzrBzZZ6TQ9eJmcDu7PQPxGEOY06XYpt4PVP
         y1d7gjD9AtoEFLkvQPlNU8Kxh2qThcOeh/TXWJOE5QKgIrNOICtDyuGWIk0hGea2zB9+
         BY7YCUFdLqb4q/DhtlgtexxldgG7OE7B3a40Uvi8TtaFf7wJ9trLLJ6QNgRo67aLPuFS
         y2F3gDH2aIu/mOkfdH3u6gbAdNlgJ6wzhIOOtCamyWSdr5aDZ4zuHYbao5bxNQPejwHC
         1uUg==
X-Forwarded-Encrypted: i=1; AJvYcCWLMGSGv3V7OzVGc0V1K62Rh/1yMimJhIwWhvOMeV919+nj3UwlCnAgftlR1QLO0pqbrrWmeFgH0yBpWjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuY0AQo2xS0NGeYIZb+pKH3JRzMtZu/bn1bSpvLu+oAI1xCm+s
	Qz4g3hzHKbUCpC9HOobp1ID7xRzrLY+nfE5eh24T69N/AEJiuTHVW/1XRlNupBo=
X-Gm-Gg: ASbGnct2xgV85g5BPVzBsm5FsiZhuRdtlD93L4dqXAybxQRcDJ3qjO0mkY8kieaNQ1c
	BoD40BKYoJlKLLYF47sZy7kheQlCXV1+VXaS8kGnl3IaAyoiiCL40HcYHqHW7h/3OS3nNYND0OP
	3V0ypHP6ytra5WdiO+9LSq+Wx8tf+kEhb7xWb31gDLgb2MEknKQTp9m3/a84QuWIJLkkjFKMG79
	pgBHpLMi4M0hSDu/rBbVMRfCe7s5UB+rvfqBuTvU1nklYtbx7D82pDmZ/c82RXvNrR+37x6WwP8
	dr/DV0jBfQ//q+iGoYsZ2ri9jtSvFQ006+8=
X-Google-Smtp-Source: AGHT+IEG8+7fAz+0OnMkkxzP6+jI+ColvkT10MRmYk8Gri8AF6ZxFi7vPhA4DMmTFfNK0LsRQARGzA==
X-Received: by 2002:a05:600c:1d1a:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43d1ec87be2mr100575065e9.15.1742097961450;
        Sat, 15 Mar 2025 21:06:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609dasm66578265e9.28.2025.03.15.21.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:00 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 14/25] rqspinlock: Add basic support for CONFIG_PARAVIRT
Date: Sat, 15 Mar 2025 21:05:30 -0700
Message-ID: <20250316040541.108729-15-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; h=from:subject; bh=9lJX2DtyRTnUplpFVsYE5ziAxwiiosjb1D9cDEXkG+8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3dEsMhP+74YqrqyvnIh88VKcNnAxL0cvJ1gkJa n7xGLWyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8Rynp7D/ 9jwO0LqsAd6i0H1M1SNcFjzNyEgzms+NwhZBtBuTdTvqAT3wwJj/F4EEK9EJQFykdau+00yKY/pgkR PEVdRrxlAgs2crbDzjqJYh+q9G8WNGP+ThpQ+Zt+aw/TVeYukHpS1pR9iEmD9srnDE2dwebiAGPgMM vTFWGqOETpp80HUL8s2G0XCRaH0zfVXr66xapYIetDVzQF3xUHsS3DDcFORGeinrUfxhoMZBRNkRpt xHq2rF0Oll2LPziNq1W4U5lK75qNdpx3oRkhj+J0GxrLo2VYmf1jZjs1Pu6Tjls7sPAuCKGc1sNfpS IDLbiiBhtgpaN8QlAzXc1TliiueghupnCo+aVENDvLEHG4QQhpeyGROKQPIJ0/cABmhk8YeMQ6eg1t NBNIZblT+x0GbPMC1SZ6cVNewgGcNju7EedsTRHf/SrbrIuDhXY0XZ2aZOzt8gKa4kk1obC3tFP+GE k1ddu1M9BmjHiqEhAX6NpIf1U2Rwsg3tljPLO06eQOH/TWhlonNlZYWV4s35e2UG0C3gGcj5Uk7p1E h5WyV089i3EAdv/Bmul3PVl64TmvbJSqqDNMSyPFFUS3n3IjFeEhF6GX8NEeNGPNzpYJAgQvnGibRB k7tvZ6agwzjq0rg4VW9szOQG84Ei1XQvpZiRUTuhGSeEo0cdLmuN9TNcntsA==
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
 arch/x86/include/asm/rqspinlock.h | 33 +++++++++++++++++++++++++++++++
 include/asm-generic/rqspinlock.h  | 14 +++++++++++++
 kernel/bpf/rqspinlock.c           |  3 +++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/x86/include/asm/rqspinlock.h

diff --git a/arch/x86/include/asm/rqspinlock.h b/arch/x86/include/asm/rqspinlock.h
new file mode 100644
index 000000000000..24a885449ee6
--- /dev/null
+++ b/arch/x86/include/asm/rqspinlock.h
@@ -0,0 +1,33 @@
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
+#ifdef CONFIG_QUEUED_SPINLOCKS
+typedef struct qspinlock rqspinlock_t;
+#else
+typedef struct rqspinlock rqspinlock_t;
+#endif
+extern int resilient_tas_spin_lock(rqspinlock_t *lock);
+
+#define resilient_virt_spin_lock resilient_virt_spin_lock
+static inline int resilient_virt_spin_lock(rqspinlock_t *lock)
+{
+	return resilient_tas_spin_lock(lock);
+}
+
+#endif /* CONFIG_PARAVIRT */
+
+#include <asm-generic/rqspinlock.h>
+
+#endif /* _ASM_X86_RQSPINLOCK_H */
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 12f72c4a97cd..a837c6b6abd9 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -35,6 +35,20 @@ extern int resilient_tas_spin_lock(rqspinlock_t *lock);
 extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
 #endif
 
+#ifndef resilient_virt_spin_lock_enabled
+static __always_inline bool resilient_virt_spin_lock_enabled(void)
+{
+	return false;
+}
+#endif
+
+#ifndef resilient_virt_spin_lock
+static __always_inline int resilient_virt_spin_lock(rqspinlock_t *lock)
+{
+	return 0;
+}
+#endif
+
 /*
  * Default timeout for waiting loops is 0.25 seconds
  */
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 714dfab5caa8..ed21ee010063 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -352,6 +352,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (resilient_virt_spin_lock_enabled())
+		return resilient_virt_spin_lock(lock);
+
 	RES_INIT_TIMEOUT(ts);
 
 	/*
-- 
2.47.1


