Return-Path: <bpf+bounces-53083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84963A4C502
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7545E188463C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07F23026F;
	Mon,  3 Mar 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe2xwk52"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB922D7A3;
	Mon,  3 Mar 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015413; cv=none; b=Bsa259LOdbz6/dah/kTmNpwVEGrbtQcE83gAVPBSKNMxxm5WAk4SPfOagRSGVE6vPbWTcuHqPUL9Ue3WbKkRptDARgoItXTYkUxw5QB7sRr0HxB5mtRxA9Axx22Pg8manHXjeGaYdu5Htz/o8mR15AL/ZOFKxhUS8w4tiqrjE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015413; c=relaxed/simple;
	bh=SCTiw9WUUkbOGd1OOljQ8eDMmea9HElqFJBZYwx5dAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asV59swEBzK4V2MdrL7XvJxH6Zae+lFT29zHPjeGwJPICH5e0Mh4JvdJx6wl1bqME+zZo9Wc6lf8U3Otmq8+8vh867xNI62MxpoUtYrqhfWTlg30n0mezY4Uxt170yr6wHmoJD1DOQx4qdxaQTVSRujphtGUhseKl0InMPLFNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe2xwk52; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso49255555e9.1;
        Mon, 03 Mar 2025 07:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015408; x=1741620208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbiXkX+sz+mKWhiZ2JD9Yjh7XLLMoN8o2kVSbNXCy0Y=;
        b=Fe2xwk522exit2mCEy2efsBasggJQNI7xwjAK9hBxseMbR/fvkvXQiC9IosGpavzX+
         ysav9vOyN5Hgo8wlLGpFH5wNadK5JnYWOWww9paSlSmgEZv+BJXv+8zPVe9xx3cjQXIY
         lAzq8hEGZmFadaZNGcAzYYnbOZNso7eKKoWpBWx9O/bRBFaIItZmGnM7ZPlfs8ExKvXa
         1Bjzrxyi4HDfISeIFKzJFvGHuyf8eQoiiGZLRnsJnc4ujJag7Cu549I2mp/DJcJjzkDr
         z80p84YJoeu3ukc+jJnwGKx8pqIG4bieUst8BKaANa9Vt6nmddYBVnle15ng0LsbpCfX
         2E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015408; x=1741620208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbiXkX+sz+mKWhiZ2JD9Yjh7XLLMoN8o2kVSbNXCy0Y=;
        b=PcsX0M8PkXazU0kpddiMOqcg7uRnheQnUDsGEgAPi7C6G70EDHUlxFDXBpqFePffr+
         V6Z1N+rGkisXxMtLTMEFwRkZbP2vYIrxD75XY97fHc+AUp4T5f3gPgsql1vMa1Wz7NNE
         1gtfzKz7WJkRYWOp+3Q8g7nR+ikbnY2CpQrJhnvfW40nzzCXRSEVNWZEBhWFCXdcD1uH
         rHPr0EPOwMy6waJqjEKaxro7Jm53wtpF1pvoZC4itYBWJZ4/5nlqtDaXxssP/Az7YND6
         6NQ1kVgsd1jEPLI9APVxQKZ0UlgOgwlwy32X+OAQGSaahz3Azy/WGHiRKzSdLd5f6ScW
         lvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhuh8dbieIzPoQglfKHfSDSHkAiCtGk/JI763W8wFFhVJ2ps9Vp4Cm+Sm4ba/iyXhynQUfekUlWGScZPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+WelQgsT4liVx49WKifQuOeo/pM/6+kgH/vjOwzBZ/rfBMex
	FHz9AWWoxanuEePc9l8urRUftGgEy3hntiliUhYK6c2KnsIXnihtfc9POrwbtbQ=
X-Gm-Gg: ASbGncsfmvG1ScNKacg5H+HT0xCLS4x+ecb1VeZMBsX8nqs/+R80Sja/RHyXjzOVgvF
	vmGicZRTa1LQ3GStM5J9pGXpmQliBV40VrRCX/lk/OmfDsFCg2stfAk3hfhkuJvP1JMIEJbJOVe
	pI+toWk4UsSBbZPbSOjte9e3CWxvqpAzF680fEie9buorXAgMfg6D5303uw9k4PpwK1WHDSsjvM
	3mflQ8gQlXZPwMerekFuQR/rP8k+HpYiJ8j4T8hfaDSXcZD/tM/EGiXoE48nWz9XNfjK3uGG+0/
	Bu6nb/cjQ4fm+ai42raOYhEATesnxJAxi0Y=
X-Google-Smtp-Source: AGHT+IGKz1oo1UHRACNo+L3weWdPcL06paS7sy9ejxox0qqfekJgP8kl/qKZCrzxii+jUg8vEiUMxA==
X-Received: by 2002:a05:600c:4685:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ba67045camr146732535e9.14.1741015408419;
        Mon, 03 Mar 2025 07:23:28 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm14531679f8f.85.2025.03.03.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:27 -0800 (PST)
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
Subject: [PATCH bpf-next v3 14/25] rqspinlock: Add basic support for CONFIG_PARAVIRT
Date: Mon,  3 Mar 2025 07:22:54 -0800
Message-ID: <20250303152305.3195648-15-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; h=from:subject; bh=SCTiw9WUUkbOGd1OOljQ8eDMmea9HElqFJBZYwx5dAE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWXfTMwb5GMWPgrjqrFJA/0gyw9UdNiWN2qmLrL O0hijiGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlwAKCRBM4MiGSL8Ryu1NEA CTUuGHPTrmc3ouIq7xk/7vEotpGLUGgeucb8GQwgQo6rcM9OI5bBvMW9JZfYy/los+WuIlwT/5IdCo AYY6qGCzJtoH464Llu8bFT1g6BAyOhZoDkX30C4FLyMD7aeKOCsD4w4X1KQJ0ITOJjLgSiO02ZBcsk G+vSU3qCtMZHbeLI9Q3/47WprV1GDIVEhOPmoC4z80iJULvFyEEv1KPAsKo+TyvXw2oYlSbxG+1gBi 1wmztdcoMQy6Y25bbcqgDlSLphn/5jKPVmwA/PqJCSlHPCcKKDENr5iG+htXq3ifKoKap5E/XN3j1P jGGqMu1j7i2P7YfUmNzvcqd+995DkNkOql0XTtz5YXJU70HWgDDjw2yhkdCHu8HgF+xp8nM1Y5yZHx UhdzTefDYMPL5JVyOInrepgDvHYQkN52ytGBNLKZt6tBQmXSeSSKJxhmpHya3TBUlZ78CPzq9vCVut qCdY7gXM8RU5a13RYFgs3bRptzVLJiuo+wnUZRwM7Cob+PtqcIIrMV1tm6IdmQBmSY8EzRJM447VxP ERz7W85ZSGfHanbBjbzfofA1Q57J4Au8euTPc7e/mx0ZR2sk/gqk632LbaDQKoQcxFXXSO+DEafFhX F8BMJap/MTZa0kNF5S+kGk3gqFtzwIqXvRBWM8HCOLgpW8KCnOFSK/bHk0mw==
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
 kernel/locking/rqspinlock.c       |  3 +++
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
index b30a86abad7b..f8850f09d0d6 100644
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
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 27ab4642f894..b06256bb16f4 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -345,6 +345,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
+	if (resilient_virt_spin_lock_enabled())
+		return resilient_virt_spin_lock(lock);
+
 	RES_INIT_TIMEOUT(ts);
 
 	/*
-- 
2.43.5


