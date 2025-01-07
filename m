Return-Path: <bpf+bounces-48118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E88A04192
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42D81887857
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF81F63E0;
	Tue,  7 Jan 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhCc8Wz6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4B1F471A;
	Tue,  7 Jan 2025 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258448; cv=none; b=tzy2eXXR0+Hzs+T/pFCmGeU7OICUZJM5bW6qdMTZO+hFWHyiplqaeI1pub0CkrSu4qW7JejNONhiY0PlxCJrLLun0PrIpk3oFaN287erQlIXEgiTyrXxxTC4673U66jiuSnnT6sH40rR6yYDuv51gWc5BrP9kwbojPqafG1ZwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258448; c=relaxed/simple;
	bh=R4ohJqpzn8YJWRCAj2R17B9DlYMHmqsB4nDNq+DDEHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEDZrC+JpngNm79l8cVQxzdbtDRyKkQdUEHXIvhcCPxrs/MhWFCDbLczT1andvwS2UeScE743XuBfMzMmK/5gEQTnIadazWAeflJtyUR5dwx5SIg2t/PTszUtZmNBlk2aieeBxWxvtgBQpWAKVB7iTDi6AZx0eH7RVHvMlhy7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhCc8Wz6; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so154708475e9.1;
        Tue, 07 Jan 2025 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258440; x=1736863240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSIQwf/xhn+Vvk/yBtHoeOyyV8hDyNDuOxAfVy3+XQs=;
        b=RhCc8Wz6IYewMHV2YEGco9SYuuFS6Q58Zt5okoPM4cAPNG7O/iCIWzVIhJOMaZ2fFi
         l5zPS/DpYFpuTM51MWj6dn9KNYBKjLe3SefpUbLL6oalzQDs5+nLHohi99RDpJsw0Uwb
         TO+UzL4BG+VbNQM0vGqbhRdYC8L3Lb2q8qTS1hk/bkW9X5oYRB2h5lM3WliREHyyCgrr
         L9uoG/5Et6uPmKzNL6tL0rvW7V+1DckTcqQUrPE2cJJnsUY6ExYG03HRHg80CpK2GrEt
         7Nvi84cHrSJ3OU39cE3erOrhoyk7+IAvM5OgJmAXqYdUuAycQPtjWjUNzdHdd8QlKzMn
         zfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258440; x=1736863240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSIQwf/xhn+Vvk/yBtHoeOyyV8hDyNDuOxAfVy3+XQs=;
        b=FIKSrVzJKAZH9HcGPxyQvOsbTHIBj0GqFXXnbOjWSwzGEunVvQvAAFtbGRYntktL5n
         nun7/WhsL4hNtAwtpYnD84ONAEkMZkxm5986rFMH9FfzV4dQUhTBPxhejo/LZKFWHIBz
         vfY25hnJlvcpx4v0cgmt9we3SiaKTRAdC5Pgj+1p8KeAKl4QRKBkaCvyzwWq04bpAkE1
         NFEp19S1UTOU+zLbYO9ZCGzKIDjfHYf2ePglqq1cruxghsjlvq8hKdAO++zPLJL5D6dc
         5bPLNpHiQsWew2t2FTvJpONL0HAlOgL/yNGMC2/ZLZ7dF8/LQTS65vrwkhKS0dSwXKWv
         UugA==
X-Forwarded-Encrypted: i=1; AJvYcCWaTnK4WwRwvycc5G22weg2TaJXUmkZqtR0GS+6vSOCIaiM/5YsMBk10xWXAJ3KifwDKRIBZerRPkarbx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkH6O6zTKScfIfBa6mf+msyCq2X+7TRUhfdFfBEpjNFKAmjyGK
	AP5fAX0LveFgSUgVEFAueYIwxhc1KKm+UHS++3VZ7WOF4Xab8Rdl6ERB0XjGMmc68A==
X-Gm-Gg: ASbGncvDJAeH4ZzuoNqh+21iZuO1ErXn0sYYwJajl1gNEJ6Q+Nsk4XUlf5iEremcgeR
	QQWt+W6QlAH5MW8bWglTrCN0YiorQWXZYiSdX2xfyCbKKnCToCNIUEMNnIJ3fb2l/bBFkGXlNgw
	1L3rSZUxVaVVBv3yTcWTYW9RggBbnwNKngsPRjiXePTWLBlM+u1vlBvhmvcrp0vTI8HT80M1vM4
	RZpTuMSfrPOSLa0djQ3/wjl77YAG2eVGz08howW/eAy094=
X-Google-Smtp-Source: AGHT+IECxlWOQbSIVzLGSd31u9XGgCXmrBRi9x7P8KEqDg/cQeUwykViQ+WvGEJocWP+HmKZNwlncw==
X-Received: by 2002:a05:600c:1550:b0:434:f99e:a5b5 with SMTP id 5b1f17b1804b1-43668b61bcemr421443875e9.28.1736258440036;
        Tue, 07 Jan 2025 06:00:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:17::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm596240445e9.36.2025.01.07.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:39 -0800 (PST)
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
Subject: [PATCH bpf-next v1 20/22] bpf: Introduce rqspinlock kfuncs
Date: Tue,  7 Jan 2025 06:00:02 -0800
Message-ID: <20250107140004.2732830-21-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4948; h=from:subject; bh=R4ohJqpzn8YJWRCAj2R17B9DlYMHmqsB4nDNq+DDEHM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCfj+uG1kLqJyRw6f0+JDV22mvVEJTdDvXhAWLn M/WMKreJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnwAKCRBM4MiGSL8RypFYEA C400zC2/p8imWhavcvlPv7jdv2ocx1KY2ZDyUSBf0O+vMarzEI1EcG+AlLHQMvU3bJYwr5Hfpati6R 1gMfFNXm6DgfiWiq0q/xKxupv2eHErTckyrjai1ibDedm7eCTsS5H6h6jlWSvoACAcuAkBXbWS/TDE r9lHqm8Ml6jkQZVjfjJjGZokB3RRekr72+Y+hC5eGKj6ABxPysfAkn+I43hpxRfjyLxA7qDtDiU5gU SIxzzznRKkvH+J3zJe6fDI1YdRjDRjS1WRQgt0NaSn1r+bilNUH4OAEeA7KFENV0FbFHWxoGXdWb5j YZUl3+jR3BH0XIqhQeOjJellg0/mY9SgmEEyRYCzqPWixudUhDCcDkQBdR4GSs115CAFQ/cFTb3njD YDnzhZ04eduJH/jJSkqdSknr89Y7T8a8bVak4fmyY+SXS8sPbq85Jp5cP1X2fvne9lTD8LCTmlhiE9 zcb2Qe8T2qVttPL19D/SKJILQVQFGnC0qwoT3zuWS1k/FDdIRScQzOMTf7k8+4v9X9vBSQLR0xzf85 v/gl7fjEa+UplSQ2tG0i3F5UlaYfB/D1hdJVCi+qiLqosjOLTUZ4zvYPYjHSH3ezAJSbJk9+PTXu6S eF4TgYVsUVgKL3yekIlWWAQKagRP324AlvRkl+gXFMTPdaQeVVznexlAESQA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce four new kfuncs, bpf_res_spin_lock, and bpf_res_spin_unlock,
and their irqsave/irqrestore variants, which wrap the rqspinlock APIs.
bpf_res_spin_lock returns a conditional result, depending on whether the
lock was acquired (NULL is returned when lock acquisition succeeds,
non-NULL upon failure). The memory pointed to by the returned pointer
upon failure can be dereferenced after the NULL check to obtain the
error code.

Instead of using the old bpf_spin_lock type, introduce a new type with
the same layout, and the same alignment, but a different name to avoid
type confusion.

Preemption is disabled upon successful lock acquisition, however IRQs
are not. Special kfuncs can be introduced later to allow disabling IRQs
when taking a spin lock. Resilient locks are safe against AA deadlocks,
hence not disabling IRQs currently does not allow violation of kernel
safety.

__irq_flag annotation is used to accept IRQ flags for the IRQ-variants,
with the same semantics as existing bpf_local_irq_{save, restore}.

These kfuncs will require additional verifier-side support in subsequent
commits, to allow programs to hold multiple locks at the same time.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h |  4 ++
 include/linux/bpf.h              |  1 +
 kernel/locking/rqspinlock.c      | 78 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 53be8426373c..22f8770f033b 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -14,6 +14,10 @@
 #include <linux/percpu.h>
 #include <asm/qspinlock.h>
 
+struct bpf_res_spin_lock {
+	u32 val;
+};
+
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a..f93a4f40aaaf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -30,6 +30,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 9d3036f5e613..2c6293d1298c 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -15,6 +15,8 @@
 
 #include <linux/smp.h>
 #include <linux/bug.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
@@ -644,3 +646,79 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
 	return ret;
 }
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
+
+__bpf_kfunc_start_defs();
+
+#define REPORT_STR(ret) ({ ret == -ETIMEDOUT ? "Timeout detected" : "AA or ABBA deadlock detected"; })
+
+__bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
+{
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct qspinlock) != sizeof(struct bpf_res_spin_lock));
+	BUILD_BUG_ON(__alignof__(struct qspinlock) != __alignof__(struct bpf_res_spin_lock));
+
+	preempt_disable();
+	ret = res_spin_lock((struct qspinlock *)lock);
+	if (unlikely(ret)) {
+		preempt_enable();
+		rqspinlock_report_violation(REPORT_STR(ret), lock);
+		return ret;
+	}
+	return 0;
+}
+
+__bpf_kfunc void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock)
+{
+	res_spin_unlock((struct qspinlock *)lock);
+	preempt_enable();
+}
+
+__bpf_kfunc int bpf_res_spin_lock_irqsave(struct bpf_res_spin_lock *lock, unsigned long *flags__irq_flag)
+{
+	u64 *ptr = (u64 *)flags__irq_flag;
+	unsigned long flags;
+	int ret;
+
+	preempt_disable();
+	local_irq_save(flags);
+	ret = res_spin_lock((struct qspinlock *)lock);
+	if (unlikely(ret)) {
+		local_irq_restore(flags);
+		preempt_enable();
+		rqspinlock_report_violation(REPORT_STR(ret), lock);
+		return ret;
+	}
+	*ptr = flags;
+	return 0;
+}
+
+__bpf_kfunc void bpf_res_spin_unlock_irqrestore(struct bpf_res_spin_lock *lock, unsigned long *flags__irq_flag)
+{
+	u64 *ptr = (u64 *)flags__irq_flag;
+	unsigned long flags = *ptr;
+
+	res_spin_unlock((struct qspinlock *)lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(rqspinlock_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_res_spin_lock, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_res_spin_unlock)
+BTF_ID_FLAGS(func, bpf_res_spin_lock_irqsave, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_res_spin_unlock_irqrestore)
+BTF_KFUNCS_END(rqspinlock_kfunc_ids)
+
+static const struct btf_kfunc_id_set rqspinlock_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &rqspinlock_kfunc_ids,
+};
+
+static __init int rqspinlock_register_kfuncs(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &rqspinlock_kfunc_set);
+}
+late_initcall(rqspinlock_register_kfuncs);
-- 
2.43.5


