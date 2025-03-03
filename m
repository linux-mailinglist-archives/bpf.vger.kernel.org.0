Return-Path: <bpf+bounces-53091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE840A4C51B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC851658D8
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45C23815D;
	Mon,  3 Mar 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArKuszSL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C169236442;
	Mon,  3 Mar 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015422; cv=none; b=C8Xt9BoRkZn01kTLtjeNAgm4YmsBijMeQpDfBGXNOORp7Ufnez6mnKlGC7Wf162iItbs/VmQD/BMoKMVIXM7uFvVHw3ZBPfvsFmRvt3o/ChGT6sfpuhiV8EyZKGH2adNX6c/HKnH1TY5zz+vy4D9sMSFMysrvieAM/QHCCrNoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015422; c=relaxed/simple;
	bh=S1zZ1+V5HXfDNJ9sHSSvG8gCJgMqlpTvJbjPruz8ZRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAdkvDynE0yoY21tC8qTOmeraaLweZGJ9O60D7jGci0ZPXAz/VK2H9qHeYPdIwSwZF0hwxxETbB2JH05C5atnKEScxtzCYDEHC5jXhu3FWzK1AMRtmvGDto+r7Ta99o9BDuRrQw/X7E6ZyogTJ75BrMyZ50rxk+EltStrfO/QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArKuszSL; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso6734085e9.1;
        Mon, 03 Mar 2025 07:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015418; x=1741620218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftGzO2s1hk5aoPF/5zj2qPXt6ZSl0PVETns25Hb5ycw=;
        b=ArKuszSLaiojNWM50p+lrlj2rYkb6lonEJgjF7+QNsXlWXSlicVRKd+5mH0pHJWl1F
         JXdbU64bGe6n7qXYycvL2uQyfWiTZXSJGZz3ANXtFSK6JsjQVylb5LXxM85Es1eSDDeO
         WKQLGk48ClITjHB9/ZksyOxLVP0UiT3dW3Ohry/MTgND0rrvPvrzhJ2gTR7lab21SUg+
         vPV9cgf2frIapzjo971MfBYTk+qbO7HCByqlYPym/6m2jRNkaOy+25hPweNFo4821YTS
         SFItmqLpccOI59wRPoFZ1+F2meNrUTLpTO6TjIFHmP9FiRV0ArbDaIHJO8D7yK5wt6jP
         HPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015418; x=1741620218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftGzO2s1hk5aoPF/5zj2qPXt6ZSl0PVETns25Hb5ycw=;
        b=tM+eKIL4gSd6Q9B20y97oMT1b1GDu+CyPdVLFBYerOrNr1sljhe2W6qTgp/L2auYXo
         nejL4G2x/mTOzdgMR21a80DVzYgcUJtktxkOAkmYlFXigk6V5NMheBeIpY3tZAskD4X8
         IQ93LU2br25v/SXQc97eZzwdYT7QswFtJqO/qJu7Y2ykRAKN6JXjeZNI6CUPnUDq3DLT
         d4KgCLHdS3gqtgMBDT/mlXD0X5TC3GAtMhWiYf8UDguvGhY5My/fsHvKP2kP1UGyJrlc
         JTdQX108Qz8u2/DtVNuUW/6lRPTisSr7hM5eNUizj8s1daJ1CkfxLwmjLvTSlNcP7/hQ
         FGfg==
X-Forwarded-Encrypted: i=1; AJvYcCUkzQ2+3lUMTs89UuayyrYLaTmjuf/KDtCvRqfTUIcEoESLyux9r4olVxbcNIKiklzddtaZ30I0IreFWw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QBop8TST4KX/+d1uHqqlRJ3Ksl+H+ReIkyWNtBfnhpHZdB6c
	t1shr/R06atMLYpPsv+PW6wb2sqd+7cwJX3sHVzdqj4m1831GVmqv7Es5yS/ZC4=
X-Gm-Gg: ASbGncvkxdVf9QLy4xdaboZU2rOJ2c9UQ72oib2i6tNy7DlMCBs2y1CuOcBCLbbYE07
	LcLmceLtNE8emHhOytfCK/nx8+/f/96BwnkirjZrnHdQCCYbaAFL0qMRIloYBbaOHfGqT/13YC2
	dInupfBjZfoZxy6it2aJuw3oN9mn9MTPwn1frBewGGBvAiVNywMPYLDERRUMKGIBQi8REkFHIh5
	d1uAS/7+W/x+mEWGCeoIQd1jyoJDWbxtH3mWKw2UbYO2hfhbAXIUWaHJUkt3g8SrxGUnHUBSF7b
	88lP/vx0w0AV9DrHYF2rWCKooXI+v00brQ==
X-Google-Smtp-Source: AGHT+IFUgzbddleUlZT0ehYk/Y59B0PJMzJQ++IN3Hp+ieXBjwlFjh5Q5E9wkdn7XokNgE0Z1HE0+g==
X-Received: by 2002:a05:600c:190b:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-43ba66fe855mr116664525e9.14.1741015418083;
        Mon, 03 Mar 2025 07:23:38 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc63bcaafsm23440385e9.28.2025.03.03.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:37 -0800 (PST)
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
Subject: [PATCH bpf-next v3 22/25] bpf: Introduce rqspinlock kfuncs
Date: Mon,  3 Mar 2025 07:23:02 -0800
Message-ID: <20250303152305.3195648-23-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071; h=from:subject; bh=S1zZ1+V5HXfDNJ9sHSSvG8gCJgMqlpTvJbjPruz8ZRU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWZSnBmS5ietCtuPE+4pmKWtJULnErXEc4IC9nN w/N0+8KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmQAKCRBM4MiGSL8RyvpbD/ 9n03epztxKLKXs5mq2JtSowibMlL/cxUOqIT/Er6iBycLJW6QrV68Gu4EXHFaJ9MZk5E3g2pzTcM3D JO8iLC+CLg/IwzMs+VQkPJBZpTbzrjX8NXMFOVdKOCPuTyBon/w6QQHN+dI0ms1DMMWkcHXpNgvkCp uHYwYc6JsQ4WUGaza1Vx3zZFXhgnXCN7o74lDcriARO1+lcB8Se5+bLCMqU6hcPK03ccyXEFk3RrYH c5lUO3C9t8W0edpQE1LWCGNLwrhhNivyOOOk7vLbdm4Exk01CJuRc5bDzvHgykGNsJg/UDR2EMGFIK 4uj6moeuOAxJcYm832dS62gCEz5OxXOr2LOg1Ee2XdP2obxhEA9pFLKdvbXo59xMfmioEC2XKuP0T3 WjHNHXhqtKaYrns10R6ilDge5CWxKksBPL30/9UkZDy9ERjZkfyD/SDxhmVdNy5ExqHKZCanzFCnMv iDoBAewmWR2hj287w0kBdw7CHaoPg9/HIyKMCv0MImIHZlzDasPBMAXnJaYyY0V7LM2fwr3F0UuOFF DrPYoPvey+vLaRgS1kIfcBQHd6v9z4fLn9JPWdc5ggzlJdRI3a8rLp2gDF14/LcQZJzK3T86HKBGUn Sv9e4xwbZoBil2FPHRU7/R9ghWKfT+cmbi6Iu1+TkNXFlGRHV+TPloE9KwMg==
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
 include/asm-generic/rqspinlock.h |  7 +++
 include/linux/bpf.h              |  1 +
 kernel/locking/rqspinlock.c      | 78 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 418b652e0249..06906489d9ba 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -23,6 +23,13 @@ struct rqspinlock {
 	};
 };
 
+/* Even though this is same as struct rqspinlock, we need to emit a distinct
+ * type in BTF for BPF programs.
+ */
+struct bpf_res_spin_lock {
+	u32 val;
+};
+
 struct qspinlock;
 #ifdef CONFIG_QUEUED_SPINLOCKS
 typedef struct qspinlock rqspinlock_t;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4c4028d865ee..aa47e11371b3 100644
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
index 0031a1bfbd4e..0c53d36e2f6c 100644
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
@@ -684,3 +686,79 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 EXPORT_SYMBOL(resilient_queued_spin_lock_slowpath);
 
 #endif /* CONFIG_QUEUED_SPINLOCKS */
+
+__bpf_kfunc_start_defs();
+
+#define REPORT_STR(ret) ({ ret == -ETIMEDOUT ? "Timeout detected" : "AA or ABBA deadlock detected"; })
+
+__bpf_kfunc int bpf_res_spin_lock(struct bpf_res_spin_lock *lock)
+{
+	int ret;
+
+	BUILD_BUG_ON(sizeof(rqspinlock_t) != sizeof(struct bpf_res_spin_lock));
+	BUILD_BUG_ON(__alignof__(rqspinlock_t) != __alignof__(struct bpf_res_spin_lock));
+
+	preempt_disable();
+	ret = res_spin_lock((rqspinlock_t *)lock);
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
+	res_spin_unlock((rqspinlock_t *)lock);
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
+	ret = res_spin_lock((rqspinlock_t *)lock);
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
+	res_spin_unlock((rqspinlock_t *)lock);
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


