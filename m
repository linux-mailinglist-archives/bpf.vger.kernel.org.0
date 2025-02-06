Return-Path: <bpf+bounces-50656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B42A2A68C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734D13A3B2E
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA1233120;
	Thu,  6 Feb 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIFuvR+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B645231CA4;
	Thu,  6 Feb 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839311; cv=none; b=YvpHI5v6klqUqvcOb4D8TKLm+9Y/5LeC0dW3EJc8GjcGgV/iCObwXogBorvTa5i3mZq7Yilw9df9uWeZJ/TkD/NnpBn3C5BT6ZzH2Ts1sYxg+HIlg/k5a11+77+nAZ3VOypqV7Bh4N7l8zGVakyFSiUgRc1x0R091jX/f3PaPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839311; c=relaxed/simple;
	bh=U/xq8I6EBeEZJrIOy3nlwnF6weOW6zwHeOpg6R+a+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeD/3r6MhnLE1QpOnR4vZXRCYEItul5H22zy5FW2lvYhmmG/Kdk0Jmy3SsC3oNZqncWLbUEYPlCruSYIrGxAcOQjextzoztJpy0hYtXFr80saUvTJktVx7k0hJmsXnRCWY8OL+yqypnLHPHdv38f15jFaerjynpItgwdBR6JPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIFuvR+D; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-38daf156e97so381910f8f.0;
        Thu, 06 Feb 2025 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839307; x=1739444107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY5xY00eKUhPVaK5CMP9UKPxhBmvTRnKdfB0Ehrzj4c=;
        b=iIFuvR+DEP18HjqK9dm7BqCGZxLhHCCmi3eZaAvdDnjQ3Mx1vzBOyv47zjXrtIMtBK
         a116vPC1kzm73eO0Z/65rCC420wDEJ4WqDurT/pCAycacoBs75Lmr4pyWrbuN9GLhPl+
         nJdUUG7lqIsuRnk4MnkbBWkVxm73WSGdyc0Lnnn5I3OF1l7JrMO+fJeeHjx45XlRPWud
         Ztys+6itWc8RnKqhdHqeG5NuHZWqqJp3SH8H/7rJRx1BNL5F2plwhmsN/Rh7rRMa1GWu
         S70YTAxOZPnnovhnK9JxL3rJzSxvUkuSpRFJfZ1mdH6WpeeCTYJTnVdtzXJ6/T7FPeeH
         AIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839307; x=1739444107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY5xY00eKUhPVaK5CMP9UKPxhBmvTRnKdfB0Ehrzj4c=;
        b=DvD/4+pHalowZivgcnJqeLAL+ioyqLR48V4folV59HDMN02i9WfD5Ii+zfV6V6Db1l
         V+EVqK+tx8Qi+wsyDVWYrzkyW/OA8lA1D1IT+8QODYK54kEfp5sOGTDODXMw05qX7nQA
         qgZc3/utC+WCfPsSLyq1poqNbYJKSvJ9/tUw5mu/mOELO454WFLG0D6uxtA2J6TbWmZX
         IS437l3nhX23v6xUyJ2BfWXYoVjhRlZXhAu42E1lJDARIMAIs0lwyX0dX2Y7Ry9bgKXO
         2iBOrKm1qlgbi+pTSG6M3kl+clEYcZc1Eerv/8gesAxq+cKgQpnFVUTl3IS9bLBhk865
         f4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJM5A818OAv5i9Pgp5vh7ZpGSG8knkQywXoTNpHE6p4ENdaiB1Ky50DujaqZDfEtzpr5Xgn8HKQ2gcHKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8fEoR2FJhseytPFGJ41HQxjNMk3C6BArs/8KdWLRFdcNmX3l
	jmhhnlnobX+fpbzwJ8XEWyb3TyjyxhVNbP4uhnC+Hstw94g7npEpGcnTx9filR0=
X-Gm-Gg: ASbGnctWwVrB4fvOviLNFJVUgX4VqWn6qG6tyuOayNo951DWc5ldmSvgjWkxOJ2jyUh
	gQOuKIeFkWFO1Gqggl6OlfFZ8/YsBCOtPvsRiOC7PIRnsojSU7jA6s69SZkcuEXZOfhAWbRYsxA
	oC03Zm4ftVV6yeKqlmmcuy07S3CO/HoysYi2hiRtMn/dco9J1o+ud6w/5sorg3xD/EMDMVbx5TY
	GwWiVCQ8bZ3tCbz38P9rrvjbuCcxUj+ZOV0AHXgjzJHuqBW4YjkmE75o3/0LA3VeN5kX6EGXvYZ
	6nTJ
X-Google-Smtp-Source: AGHT+IG9zXGoXyJKKHaq7JsfFOdulH8qStWXMMx7WVjIkbMNF6mgU4TITTZXCi7em7sIZ7mcLjLv5Q==
X-Received: by 2002:a05:6000:1567:b0:38a:5ce8:df51 with SMTP id ffacd0b85a97d-38db4857bb6mr4346951f8f.2.1738839307068;
        Thu, 06 Feb 2025 02:55:07 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1ddaesm1381571f8f.85.2025.02.06.02.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:06 -0800 (PST)
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
Subject: [PATCH bpf-next v2 22/26] bpf: Introduce rqspinlock kfuncs
Date: Thu,  6 Feb 2025 02:54:30 -0800
Message-ID: <20250206105435.2159977-23-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071; h=from:subject; bh=U/xq8I6EBeEZJrIOy3nlwnF6weOW6zwHeOpg6R+a+Dg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRnGE3AZgPoVzGUtERg5LFCbq+DcCX9yF59ua8N n7+cbDKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZwAKCRBM4MiGSL8RylLaD/ 0VpOorKWab0lqsTn/JbqVIfhX2mJDl4AszKROjW7ZbWS/ibRaNsagLSEBcUQD0xf70owiN9Yu/4znW OJaUpWXS7tNbAxPV2AbNa13K/5M2I9XFuZ6Ma44gw7XUBL2+eLtpDnsloEntdH23CIdCBlFgVoMhZi /9B64BlcRvucuNxfRyundNxbRTbW+WL+gdtObdVpvurkEZPU7XSKLpbhrzZvQ4wxTGIf/25YvUVXE4 S4KSqSp0B49pkPN4G9xW/jIyjgX3WLAwBlhBHZ6f15+/NQ+pg/hwN9hKNNehLoCE2vircPueBHstEE KegTCjgg9BggHBOklhXRKvmGFOY2CVPkx96cbQhQZG615Mp2ODEKab08GpR6au3L0Lg1QT3JQbi+tU DKBdLQMl1MjDsazZBZ1VwoZL4CT5etgBB13PQWNVWlid9dl1osLUMQE9UJ/QAqUtZVfz88GpkskFmi ol2YvLHaQVsp/3n/N56wQok42wK/y+P/xvxYD1rz0ExOWlNuLbEBjbjgFZsEQ1KAlLg2XUnKJ4yMrB aBVOWnLHU2q3mFDWBNz/iUcF0U3KO0efHZsiu7NYItC7HDIgvosgX8QFMNIjDG1EfiEFvUcisgaxYH JcTYydI991Jqy6AeM9QpCB99Wg4k4tVqvmj18ICTymjWeNb7929I4r8679rA==
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
index 46119fc768b8..8249c2da09ad 100644
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
index f3f50e29d639..35af09ee6a2c 100644
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
index b4cceeecf29c..d05333203671 100644
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
@@ -686,3 +688,79 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
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


