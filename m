Return-Path: <bpf+bounces-76255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2BCABFC6
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 04:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3149D30145B6
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 03:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28626561D;
	Mon,  8 Dec 2025 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JveqQe+4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13E237163
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165854; cv=none; b=lu1oECpMJ/hK0Jvoq4RAy2lr4BvAvGgkrneKGMyczYKtsjCzQxNWpZaBbtCGkm9yo4IhyuEfyon3WGygwaZzMZ7EL+6iUsfDImFW+nNGJloK7GlH8chmSt+iuiy5lWGltTzh31GminKpkY/nsLA4CdMgcZswlbmrCA8z4qbKQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165854; c=relaxed/simple;
	bh=s7J1/EJglygUlRcA2CA2RR3zp0EAzyaKlV4J61HRDG8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajsKueCkk7ZQWHeiXzZ7BalQhD879/EMX8SeE4inR6RFe3VM3v/tHscW/+IwSv46dePJ32d+6exEtvajUktx2fT/dTQXcWWdYGKttAru4nG4MBZbXjo4SckfgOgIIXlEvnoNyi69T/GWgnhOnujomPVx9HDG9fUDObeF+1zBf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JveqQe+4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298039e00c2so53974995ad.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 19:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765165853; x=1765770653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFr5RgkhvM6EE5Q/RHn3oG8Xllt/H7Gtrl4Nvhbq1ik=;
        b=JveqQe+4vnnBF9/JE6TGDJebpcfTVkSFSusxozXzEEzKIXzeB2X78bi0GfmBgnSmOn
         kBhLioroZZxLg6+rUzN8vLL03Bpmx3qmpTYXrL9C1XgetXZXYwOBY1ohjM++0F/8tR8r
         6SCGxW2lUeQF5YeyD0SKVSzUv50/+G8hfz5ZYCHTLlwLckrceok7uKXIZkv0E0yMaNir
         mcGlY0G86dLqRyD3ufuD0EwW3lkG3JyQ/Tmc/JaDqlr38E1XnZV+jz0CEy5/gTNJsypN
         XugjFk59HHasR44Zft1w14sI1vkhiwcRYcdBCs8B9zcY5Kcu7FCfJYmuZ36E0Mdl30YD
         MZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165853; x=1765770653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xFr5RgkhvM6EE5Q/RHn3oG8Xllt/H7Gtrl4Nvhbq1ik=;
        b=V1kwFSAkaWPppW65Q9YQmVeJoRBwkSW6w/4AZtoFhThJb9VSHzRELI07BIEmND/2no
         0oTPkiu3EP/s/Q/eRyyzm3KNtW68y93xrq/q/ZPDZ4k8v9vzRF6/pNNsAvdIAYyN3TIe
         6beuRPI8UVq1qqphr9t3X365/13b3nSf8lKDtAIOwrahqJ3TsddJXW1mG1yFRgZvFVdC
         SD3ISoZme1WVhB1xsY/dHrhHgCcmWksuzB62jsVIHtqoFxq1z4o8ptihuFxpah5f7t8Z
         WUMvhww4ehqvak6pMsPaHKYoNjXejIvOK06/0Fn1kdQaAWCxB0ZJ/tS8tv746RUxxK35
         a+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWdzX0DxYBXHT4aK7ccqZY3YvL3lzJobLj3t4mi0A3SCQm4HH3dJ/wTEo1uEBmBNCwqDuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXdrunL8M1CjB7srptV9DYcqbNsfFJ8EoucOQESVUdjcMPMJK
	lrqzOqpGUgWKagJ8NiYzZ9I9hpxFfd2uHdt8KODc3eaA0WrEL/0f9U+sjEow5qJDtPk=
X-Gm-Gg: ASbGncuZ8Vyms5OI/BdG7GZjc+x1uCp7opeyodZe0ph5p7cy2OpNPnw4mAAb90OBqzg
	qYkGRiCU2ayFqvWerJX5zXgh4VSChXnU9/AejOv8ZAJ0zeMj+ERh5Sa3Q8hFgKjFwxWIDHxUGN2
	jET9kPy1qs3sXf1EaZdq4gO8AO6WFSdlo9AuGSrFu1foSqBsuedbcBWl4JoVGhDiFq8w5s3oA+R
	rJln0wsh5wIzLuSYbByMELrXeTrm9/2XdPREUt/hObtkS79Ze3Yd5r0YBgqkggVFCkWPHAKa8CY
	vBL04KD1fWFam+38V28W6qAqqmx9iCc6hWJ1joX7RXf+KSDQW/Va97QcM21kf3UFN+xgbYmKsI4
	dhdcxribK4ft4SlFtqnZld58WPPt+LB3OFk0oMjF2IPU64ssdJPbgm/j00QdqMJhE/5d5EiEfNm
	11po+OtcRYvFhICLQfqwF8GCgMgG3J1/s9xHhDTONPGoq/
X-Google-Smtp-Source: AGHT+IGvReM+D+IE845FajcK0U2ifqJXm74OcYy9I6WIlw3gQeLkhNJjnOwLKfKhujYanWqb2gK1OA==
X-Received: by 2002:a17:903:15ce:b0:299:dea1:e791 with SMTP id d9443c01a7336-29df56772d0mr53566285ad.12.1765165852442;
        Sun, 07 Dec 2025 19:50:52 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6d96sm108871275ad.102.2025.12.07.19.50.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 19:50:52 -0800 (PST)
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
Subject: [PATCH v2 3/3] riscv: store percpu offset into thread_info
Date: Mon,  8 Dec 2025 11:49:44 +0800
Message-Id: <20251208034944.73113-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251208034944.73113-1-cuiyunhui@bytedance.com>
References: <20251208034944.73113-1-cuiyunhui@bytedance.com>
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
index b173729926126..18e282dded626 100644
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
@@ -233,6 +235,8 @@ _pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
 	ret__;								\
 })
 
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


