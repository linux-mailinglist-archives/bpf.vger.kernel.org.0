Return-Path: <bpf+bounces-54137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D67A633A8
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C584116D3BF
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECF1A5BB5;
	Sun, 16 Mar 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI6DVTXn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A11A3155;
	Sun, 16 Mar 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097975; cv=none; b=fN44B9cy4AZB3iD1qd76hiArV6Smjothd393j5j/q8SG48p7bxjnx1heqVQ4/QrMeFR6Ol6ENlitXx1MPtRWHyQ7/QipDA9GZwBaiiXPGSY/spT/sg9KqqdPmPqiOw1MnDKVP3KV+XeU4lCTpOxMyjXvqbyeJVo8Tk77sJ+gbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097975; c=relaxed/simple;
	bh=5BKl9hYgLyro6F1bzOCMfYjd/K5FyedLnNqGmCHan+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMnkx1xbne+3h8HzwebIUmV2g8mx+GSNcgVgK31AxHkG5Ydnzjy80HMT8SD24aj6XgtYASxa58E+GX4vL2uRDDB8uJgPAMKCSGtzCQbO2h9kUjlVZLEYtTmSCo4ctEFxTLc2AoOPVbwhH6wjwuPBp834aESNy+3EHj8AgMj+tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI6DVTXn; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf680d351so5110285e9.0;
        Sat, 15 Mar 2025 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097971; x=1742702771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VnxgBQ3rAJeGHFIGyB+ChpGIi/1tYmBGxWhiMsjK7I=;
        b=PI6DVTXni17Mtb76ppSFIVtCY//VZCA+sTwshIHKXkxfYzOq4MJyBxY1rS74toXHar
         4gQdYSbKv1PvhbYwUjMHJFQVWEqld2aazM/vtL8iPAZlNT4UtYBYAZt0BFIqIrqUAlZ0
         aOPVET2nOniV6Ce8P96w7ceaQ0MICfO8xBup+I4ZCNH1ULu96GPUkoSyMSgvxwJ5rTBN
         u1cLs1XjB15v1yXSO9pThoBbYftMeH6vW+duJPENQ3fMzWdVEh+IOd6bkSpFThDg8z6H
         WI3qnS7O0tgohcieJL7lcXvfPpC1ELUjb+4AmngHKWEkcCsks4iDjY6Pxx8VcqEg8pFl
         yDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097971; x=1742702771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VnxgBQ3rAJeGHFIGyB+ChpGIi/1tYmBGxWhiMsjK7I=;
        b=VyTNYhtEDyrm3D/AnHQ5SiqOF65LnwX+PVIMxaPJYIAxr42IGyGGo9a5xLf0IFHt8Y
         w5MLrLLfvTt4ZWaF98veewA5OMNU0+9Dan77Gtx2VzdQg427Hjhf9vYe0z3hA61ffFb5
         9pyxLsLlvnw0M7V+dTc6fNW/u9uoLxjDlhMCQSkUKYdupyw6wOKPS06C72W+WUaIvV+2
         HJj/fp507PEwirNO6UlnD2FjX2mzG9wGF3dZGDR5z9Rkkj1/Ufqthtwlq+yfVkc4r/HQ
         oAPyzZLUvYTU8ESxVRPghJ4GdRPm2+4S5i/dVDF+FqCHNMw3i18EcZ+vkY7ecPKujSdp
         4qIg==
X-Forwarded-Encrypted: i=1; AJvYcCWgUhUbdHGPSgOgI6rCH8goQrDRRO3HPTz7TOofGc1XJXUEJmoWhiwHvhUeODfNLDulZX/nCnYERwS+F3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88cat0CruQj9AKdZR6FpSO4QWQ6KeGpeHjVPkVBS6xcuZoXkc
	p7dSvNXhgOZZ9cVt06wkwBFwK1JIOIicIas0sXGzM5wsNORksAWFJJgDjVr5oUA=
X-Gm-Gg: ASbGnctf+kgunPJdWLkTUDyieBqMqcFo0J7CYL3gQ9Fi+3xKKwckSDY1jKvMj2hMs6l
	pLlhcx3MeDeTFzztbUA8tYAMDJFRL4QrbtCk0IQPGYOl4r6Vc8hvRcF25TvXsEq+AdHtObqpOdn
	VPMa96IS5vXjE3HcvSx4zwWR/qbMDdCwYQz3WGoJpYmaUPf6/Memt6rLTw0b3lWwQ6dqGILVSId
	O11dOmvY2TxaM14HiLWnR07IZkbSLBeEjvjAPR4BuMWaCuHphpBDHQwB6Ro8eqh8NcLYDW2sUpP
	kjJj287FnBHY2/mR1zZEs0MZvYL1e/+wmJ4xQh/PS6h2Eg==
X-Google-Smtp-Source: AGHT+IHykLJ5NvwHyRbYtDv/1bZEgjZY12X6M0CYxwI6OW/IzydFKfy0Lmd5AEeKjh0K2mfT3jL26Q==
X-Received: by 2002:a7b:c2a9:0:b0:43b:bb72:1dce with SMTP id 5b1f17b1804b1-43d1806bfc6mr111911795e9.5.1742097971213;
        Sat, 15 Mar 2025 21:06:11 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm11124023f8f.91.2025.03.15.21.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 22/25] bpf: Introduce rqspinlock kfuncs
Date: Sat, 15 Mar 2025 21:05:38 -0700
Message-ID: <20250316040541.108729-23-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5059; h=from:subject; bh=5BKl9hYgLyro6F1bzOCMfYjd/K5FyedLnNqGmCHan+A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3e+fudrbbc/TgS+/ixztDuZ5UbJUeXYBElGNak SEdzC0OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8Ryqz4D/ oCflyjgtF5/HlKZj4F2D61xd+E+vDVH2+zf1tMkPdHH8lyU299BGDRQqY2WtOTwcBLUY9OqorBhQ8H rjwEGY2fs77qokXPHkKwGo9ZCV9KoFXcx2t1akp8zymB9tkkxVrbMvKrD4LJLkmJp4+0Gk0P4dmTT6 uL5NE4sFMWsPdIdSevyjlGvL/98JDGWrIzfqzVSbHA9M6AJbeyaL5upuniadERgB4b7/UNXbBeSzt4 ZLFS9zpB8NYwZecwzgOydM6/jWOQPjeh0pUyf8lwSq17ZzhYsHp2945rJhtVwSxt82T3WDRPib5MTU 7t4sgoBzUKN9xFg23oq0eZbuWRdF0BXps6RORdd5fgrSHtEYt5KHaSYff51NxW87b+eNlFzdKM57pA Pez01gQmSKdydkbA0jpu+VYH962Jkoigu2ho3Khwrr2JuWqOcAz+5Y/SnXDhbU8W/UpTH3SK2Wy4kF QMpW9/D0CW2bAdIgChF/jU9dRdCKMMLFH+OpADrQQfn4zvU7cWdzA/1BPNh0bLBYEX7K2va7cXSA+g uHGz5ivgqNl9TakLfq+7exi7BFGrnYDGJZ9qjvtAdu3EDnpEX3iX5MFWcOfOHBmWnOTiGMi5x2ks/7 zQL3CJIhr4Uc+LeK+wpPS9WJnwsrk8CuEMSTyIC9XeeQUQWEeb4pfptwOM1A==
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
 kernel/bpf/rqspinlock.c          | 78 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 23abd0b8d0f9..6d4244d643df 100644
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
index 0d7b70124d81..a6bc687d6300 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -30,6 +30,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index ad0fc35c647e..cf417a736559 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -15,6 +15,8 @@
 
 #include <linux/smp.h>
 #include <linux/bug.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
@@ -690,3 +692,79 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
 
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
2.47.1


