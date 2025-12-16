Return-Path: <bpf+bounces-76660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70750CC07D4
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA8A030019CA
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0B28A72B;
	Tue, 16 Dec 2025 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cZow14Da"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B441DB356
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849700; cv=none; b=AGKNihI1V/WrfVoZwQhUYO3arus7pBXqSQP8xGCVs8Q/081UcSL4/f0c9k01I8RDzSj1Gkf3D6L5rkR8rZKVgXWH4F1hmkaKsCOAp4hMwOCPXRoTlomw2w/L8V4faQcIBW4Z+0oh7K4+25+qH7bybGTBP+e/hpP3axCZA0uAsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849700; c=relaxed/simple;
	bh=rDYObsyVt0k7aR8oMEAY68o1gzyAa4BXH44HoG7kYmI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAGfyPkPa7YuqBhHRwD9cBuSM/sPrVB6YNVZz+r4OBA8XanhYFtBNQ2CDgoxzX9Ihob00adJRXTatt2DKy5aV5Z5Oc4+7c6bc/4yKCg5jVHJ/dvTN9sXzNeuaeG9EYOPBo146Fdd38kOUDhRe93QeHL3/46dOFczu6ThcMNymu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cZow14Da; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so4748769b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765849697; x=1766454497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPaduSWe86itOLJLDO9/qRxhQFQa/4nam9IeEV1MY2g=;
        b=cZow14DaSSBwHkOqLu+UPT+nmLYcdqoFHHTrbkYFelsRAvN3yMWeqUyFSKLsuTZRw1
         +rxOL4qTrk6oACuawUmd/jRZoTq1BCdUncP9i6Ll/IiQSCkSOMiE8RE2InEU5yvUF3oR
         ImDEurFsOvDIXGqiUXSR4O1I1qDokZxQZbKzZ1N7fqCVHza5xEBRTwQvchoP/MHuvFqL
         2fTgU9E6LtOYp15SgbhDVdUxrrShtrLcOwxCbFYk2zIjZRf7iGaunGz5A/C8YK7P9xWD
         tbUTTKGZuTtjIaEKLNSLgWlRukBywHlW5q7IfI/uymgDxnKTwfd03mSQ1k/flRg60VJV
         YTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849697; x=1766454497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPaduSWe86itOLJLDO9/qRxhQFQa/4nam9IeEV1MY2g=;
        b=MMx2+8dB6fFYeuboz9JvfpX2CZMFfu8ikVtBIy8GkwLfWoKjzQtW/R3XwDIC6xyeb0
         sFPCpfzMGy6fQ7YSZK1f1bd5VjaxRXvsA/1fSeCW4dygNXypNWQTUBpmZTJ8pXgP3WID
         iqswwwKNwAS4/d3sf3iLoqRj4vEAuBL1axlr5huT5/K8O8s5/R/SQCZC5B9lSnOE8yBS
         aEWSE9Otjl4lEuAO+z7LQyrDo0L/hUknQ5DpZaj3l/B2t2NUuu1y1XpxpbVskXtsk7Ud
         Ir5204oaGKv20eSwTBDDJukV0hh2bScdBYNMLEoNZvKkeXdZWWqnNK9XHObrZZsqkjgM
         pR4A==
X-Forwarded-Encrypted: i=1; AJvYcCXQdFTvN88ZWNAoKwgPGUydEKHEEZWoLwtapaL9zX/R3EkVwtIZJzR4edFVa3DkCC5bK/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9fr2knSCawtSGMlbkElyhI3A11UOu0dqGq7smPetk+9DXNx/
	C0TgNzeu1Z0Fcx64zSEWVbaNeoc8Nvt/dvZ2OFTZgtfyPAbv+sdoAgnBdo6/kg8+Bz8=
X-Gm-Gg: AY/fxX4KXhuHPvZOkubUsPMT6sA2kP7ELQVgpez8DmrBUClzpJtGp9i6rBZXSJOFBgE
	pr22e10015LZan5SwJXJnGF8U3bUN6aORkHAdbrQJ/KklL8rFHDTA7+Y3G9ksl57OKcFVUC0lNJ
	ev76fZhUCLqJHsYEKvXdZ9dUbcAKOmfe7mKwG33QJBrzOVBjn9DyctSgfribEp9uRymrASV7ZUG
	BqONETJr/PnHs53zewI0AEzDIayQwZVNMZfBno+htKyR8kqALRJ/iOY6AcF3YsZEE0NTxEM8Dqd
	SPqWEwHlFR7XMVEXM0duYYzIN3Xks7Gk5w/vfSbz7rgIIRnPpZjz86z11TO6KF15uzwNqIq9cq9
	a2y+LioPF4HxFWgB/s7cRAv3rA6Z2i+wZHejEajwyaXLAojn8u+ZiEmsTD1h/XTiVGRcIHOZPwB
	5nsJFZ0mZwAWDXAOr/Q1QvglKXZjjIA0tfiyVISfThraSh
X-Google-Smtp-Source: AGHT+IGq1tjZWtQhKRKbnMgnlKR2obxbHUXs706wZEaM0LNbNkdcq+HNiaw0vmfCMXTy97ide8fzgQ==
X-Received: by 2002:a05:6a20:6a20:b0:320:3da8:34d7 with SMTP id adf61e73a8af0-369adebe03amr13055886637.22.1765849696602;
        Mon, 15 Dec 2025 17:48:16 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c963b53sm13632790a12.36.2025.12.15.17.48.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Dec 2025 17:48:16 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andii@kernel.org,
	andybnac@gmail.com,
	apatel@ventanamicro.com,
	ast@kernel.org,
	ben.dooks@codethink.co.uk,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	charlie@rivosinc.com,
	cl@gentwo.org,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	cyrilbur@tenstorrent.com,
	daniel@iogearbox.net,
	debug@rivosinc.com,
	dennis@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	martin.lau@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	pulehui@huawei.com,
	ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	sdf@fomichev.me,
	song@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	thuth@redhat.com,
	yonghong.song@linux.dev,
	yury.norov@gmail.com,
	zong.li@sifive.com
Subject: [PATCH v3 3/3] riscv: store percpu offset into thread_info
Date: Tue, 16 Dec 2025 09:47:21 +0800
Message-Id: <20251216014721.42262-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251216014721.42262-1-cuiyunhui@bytedance.com>
References: <20251216014721.42262-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Originally we planned to add a register for the percpu offset,
which would speed up percpu variable R/W and reduce access
instructions. After discussion [1], it’s now stored in thread_info.

[1] https://lists.riscv.org/g/tech-privileged/topic/risc_v_tech_arch_review/113437553?page=2

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h         | 6 +-----
 arch/riscv/include/asm/percpu.h      | 4 ++++
 arch/riscv/include/asm/switch_to.h   | 8 ++++++++
 arch/riscv/include/asm/thread_info.h | 5 +++--
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/riscv/kernel/smpboot.c          | 7 +++++++
 arch/riscv/net/bpf_jit_comp64.c      | 9 +--------
 7 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index e9e8ba83e632f..137a49488325e 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,11 +91,7 @@
 
 #ifdef CONFIG_SMP
 .macro asm_per_cpu dst sym tmp
-	lw    \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, RISCV_LGPTR
-	la    \dst, __per_cpu_offset
-	add   \dst, \dst, \tmp
-	REG_L \tmp, 0(\dst)
+	REG_L \tmp, TASK_TI_PCPU_OFFSET(tp)
 	la    \dst, \sym
 	add   \dst, \dst, \tmp
 .endm
diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index c5bacf6d864ee..35a63420a76a4 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -7,7 +7,9 @@
 
 #include <asm/alternative-macros.h>
 #include <asm/cpufeature-macros.h>
+#include <asm/current.h>
 #include <asm/hwcap.h>
+#include <asm/thread_info.h>
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -239,6 +241,8 @@ _pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
 })
 #endif
 
+#define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920c..733b6cd306e40 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -88,6 +88,13 @@ static inline void __switch_to_envcfg(struct task_struct *next)
 			:: "r" (next->thread.envcfg) : "memory");
 }
 
+static inline void __switch_to_pcpu_offset(struct task_struct *next)
+{
+#ifdef CONFIG_SMP
+	next->thread_info.pcpu_offset = __my_cpu_offset;
+#endif
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
@@ -122,6 +129,7 @@ do {							\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
+	__switch_to_pcpu_offset(__next);		\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 36918c9200c92..8d7d43cc9c405 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -52,7 +52,8 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
-	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			preempt_count;	/* 0=>preemptible, <0=>BUG */
+	int			cpu;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -60,8 +61,8 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	unsigned long		pcpu_offset;
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
 	void			*scs_sp;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index af827448a609e..fbf53b66b0e06 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_SUM, task_struct, thread.sum);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
+	OFFSET(TASK_TI_PCPU_OFFSET, task_struct, thread_info.pcpu_offset);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d85916a3660c3..9e95c068b966b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -209,6 +209,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 }
 #endif
 
+void __init smp_prepare_boot_cpu(void)
+{
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+}
+
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
@@ -234,6 +239,8 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	__my_cpu_offset = per_cpu_offset(smp_processor_id());
+
 #ifdef CONFIG_HOTPLUG_PARALLEL
 	cpuhp_ap_sync_alive();
 #endif
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 5f9457e910e87..4a492a6a1cc1e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1345,15 +1345,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			if (rd != rs)
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
-			/* Load current CPU number in T1 */
-			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_lw(RV_REG_T1, offsetof(struct thread_info, pcpu_offset),
 				RV_REG_TP, ctx);
-			/* Load address of __per_cpu_offset array in T2 */
-			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-			/* Get address of __per_cpu_offset[cpu] in T1 */
-			emit_sh3add(RV_REG_T1, RV_REG_T1, RV_REG_T2, ctx);
-			/* Load __per_cpu_offset[cpu] in T1 */
-			emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
 			/* Add the offset to Rd */
 			emit_add(rd, rd, RV_REG_T1, ctx);
 #endif
-- 
2.39.5


