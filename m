Return-Path: <bpf+bounces-35217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E1938C5E
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00871C21608
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85816F262;
	Mon, 22 Jul 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GCjdeaRu"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61B16EC18
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641433; cv=none; b=i5lCcN5rOIbUgE8Uii24pJUTkINzA88VwTwHXzba3+8J6T8du07z9wVvXWX4UYJCMZAD30EhQ+10iLf5oWFudAnhC2UqzEOy64evSW/M/DxLacP51DXjPs6QK0QDEmxYT4Kw88pVLAuBtct9/NIL7HLO/CV2x9iXzg/VZU+lN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641433; c=relaxed/simple;
	bh=E3NqyE5MkJRoUNLDK5J4AjC7b5sHyADHFow0omJkUhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3D0DZ0xHKYBfn1DsR8NvFQFRgFTZv9TDw86iuYIWYwtZBD+zaVPPJWEk2bp9moV4uoeML6fhM5mkGrDH7Lc83iCxXvAx3trVsXNNXo6uI6sR+cipNTWDYdj/+VIh9wqtktwfZV//QVFUfzYcFwZMm8Ls074SXDXSi064baNG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=GCjdeaRu; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id ED22532259D
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641430;
	bh=E3NqyE5MkJRoUNLDK5J4AjC7b5sHyADHFow0omJkUhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCjdeaRuEmvCwtVZJUef4AGJhwwfRcSHGVt/SDvRjM4YXH6ZCpneX4uVrwFo5i/HV
	 NbSdNWeIeiyI8JTw7jGX97xuqbrnI2wtn/cGRE0PTgTh8GFnM6mZdDqR29L68xw727
	 aVHzkNXCff9qlvobkFba3tTF8pbbRrxHyUMXQl2w=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id BD7A73223EC; Mon, 22 Jul
 2024 11:43:49 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 2500B3221BA; Mon, 22 Jul
 2024 11:43:49 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id E3D8E40317; Mon, 22 Jul
 2024 11:43:48 +0200 (CEST)
X-Secumail-id: <9d64.669e29d5.235af.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Julien Hascoet <jhascoet@kalrayinc.com>,
 Louis Morhet <lmorhet@kalrayinc.com>, Luc Michel <luc@lmichel.fr>, Marius
 Gligor <mgligor@kalrayinc.com>, bpf@vger.kernel.org
Subject: [RFC PATCH v3 30/37] kvx: Add multi-processor (SMP) support
Date: Mon, 22 Jul 2024 11:41:41 +0200
Message-ID: <20240722094226.21602-31-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Coolidge v1 SoC has 5 clusters of 17 kvx cores:
 - 16 application cores aka PE
 - 1 privileged core, the Resource Manager, aka RM.

Linux can run in SMP config on the 16 cores of a Cluster.

Memory coherency between all cores is guaranteed by the L2 cache.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Julien Hascoet <jhascoet@kalrayinc.com>
Signed-off-by: Julien Hascoet <jhascoet@kalrayinc.com>
Co-developed-by: Louis Morhet <lmorhet@kalrayinc.com>
Signed-off-by: Louis Morhet <lmorhet@kalrayinc.com>
Co-developed-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2:
- removed L2 cache driver
- removed ipi and pwr-ctrl driver (split into their own patch)

V2 -> V3:
- Refactored smp_init_cpus function to use
  `of_get_cpu_hwid` and `set_cpu_possible`
- boot secondary CPUs via "smp_ops" / DT enable-method
- put most IPI code in its own driver in drivers/irqchip
  which fills a smp_cross_call func pointer.
  see remarks in there:
  - https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#m5786c05e937e99a4c7e5353a4394f870240853d8
- don't hardcode probing of pwr-ctrl in smpboot.c
  instead let a driver in drivers/soc/kvx probe and register smp_ops
  see remarks in there:
  - https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#mf43bfb87d7a8f03ec98fb15e66f0bec19e85839c
  - https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#m1da9ac16c5ed93f895a82687b3e53ba9cdb26578
---
 arch/kvx/include/asm/smp.h |  63 ++++++++++++++++
 arch/kvx/kernel/smp.c      |  83 +++++++++++++++++++++
 arch/kvx/kernel/smpboot.c  | 146 +++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h |   2 +
 4 files changed, 294 insertions(+)
 create mode 100644 arch/kvx/include/asm/smp.h
 create mode 100644 arch/kvx/kernel/smp.c
 create mode 100644 arch/kvx/kernel/smpboot.c

diff --git a/arch/kvx/include/asm/smp.h b/arch/kvx/include/asm/smp.h
new file mode 100644
index 0000000000000..7a8dab6b1300e
--- /dev/null
+++ b/arch/kvx/include/asm/smp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jonathan Borne
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_SMP_H
+#define _ASM_KVX_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+
+#include <asm/sfr.h>
+
+void smp_init_cpus(void);
+
+#ifdef CONFIG_SMP
+
+extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
+asmlinkage void __init start_kernel_secondary(void);
+
+/* Hook for the generic smp_call_function_many() routine. */
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+/* Hook for the generic smp_call_function_single() routine. */
+void arch_send_call_function_single_ipi(int cpu);
+
+void __init setup_processor(void);
+int __init setup_smp(void);
+
+#define raw_smp_processor_id() ((int) \
+	((kvx_sfr_get(PCR) & KVX_SFR_PCR_PID_MASK) \
+					>> KVX_SFR_PCR_PID_SHIFT))
+
+#define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		do { } while (0)
+extern void handle_IPI(unsigned long ops);
+
+struct smp_operations {
+	int  (*smp_boot_secondary)(unsigned int cpu);
+};
+
+struct of_cpu_method {
+	const char *method;
+	const struct smp_operations *ops;
+};
+
+#define CPU_METHOD_OF_DECLARE(name, _method, _ops)			\
+	static const struct of_cpu_method __cpu_method_of_table_##name	\
+		__used __section("__cpu_method_of_table")		\
+		= { .method = _method, .ops = _ops }
+
+extern void smp_set_ops(const struct smp_operations *ops);
+
+#else
+
+void smp_init_cpus(void) {}
+
+#endif /* CONFIG_SMP */
+
+#endif
diff --git a/arch/kvx/kernel/smp.c b/arch/kvx/kernel/smp.c
new file mode 100644
index 0000000000000..c2cb96797c90b
--- /dev/null
+++ b/arch/kvx/kernel/smp.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jonathan Borne
+ *            Yann Sionneau
+ */
+
+#include <linux/cpumask.h>
+#include <linux/irq_work.h>
+
+static void (*smp_cross_call)(const struct cpumask *, unsigned int);
+
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_IRQ_WORK,
+	IPI_MAX
+};
+
+void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
+{
+	smp_cross_call = fn;
+}
+
+static void send_ipi_message(const struct cpumask *mask,
+			     enum ipi_message_type operation)
+{
+	if (!smp_cross_call)
+		panic("ipi controller init failed\n");
+	smp_cross_call(mask, (unsigned int)operation);
+}
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_message(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
+static void ipi_stop(void *unused)
+{
+	local_cpu_stop();
+}
+
+void smp_send_stop(void)
+{
+	struct cpumask targets;
+
+	cpumask_copy(&targets, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &targets);
+
+	smp_call_function_many(&targets, ipi_stop, NULL, 0);
+}
+
+void arch_smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+void handle_IPI(unsigned long ops)
+{
+	if (ops & (1 << IPI_RESCHEDULE))
+		scheduler_ipi();
+
+	if (ops & (1 << IPI_CALL_FUNC))
+		generic_smp_call_function_interrupt();
+
+	if (ops & (1 << IPI_IRQ_WORK))
+		irq_work_run();
+
+	WARN_ON_ONCE((ops >> IPI_MAX) != 0);
+}
diff --git a/arch/kvx/kernel/smpboot.c b/arch/kvx/kernel/smpboot.c
new file mode 100644
index 0000000000000..ab7f29708fed2
--- /dev/null
+++ b/arch/kvx/kernel/smpboot.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ *            Yann Sionneau
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/sched/mm.h>
+#include <linux/mm_types.h>
+#include <linux/of_platform.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/tlbflush.h>
+#include <asm/ipi.h>
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+void *__cpu_up_task_pointer[NR_CPUS];
+static struct smp_operations smp_ops __ro_after_init;
+extern struct of_cpu_method __cpu_method_of_table[];
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+void __init smp_set_ops(const struct smp_operations *ops)
+{
+	if (ops)
+		smp_ops = *ops;
+};
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	int ret;
+
+	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
+	__cpu_up_task_pointer[cpu] = tidle;
+	/* We need to be sure writes are committed */
+	smp_mb();
+
+	if (!smp_ops.smp_boot_secondary) {
+		pr_err_once("No smp_ops registered: could not bring up secondary CPUs\n");
+		return -ENOSYS;
+	}
+
+	ret = smp_ops.smp_boot_secondary(cpu);
+	if (ret == 0) {
+		/* CPU was successfully started */
+		while (!cpu_online(cpu))
+			cpu_relax();
+	} else {
+		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+	}
+
+	return ret;
+}
+
+
+
+static int __init set_smp_ops_by_method(struct device_node *node)
+{
+	const char *method;
+	struct of_cpu_method *m = __cpu_method_of_table;
+
+	if (of_property_read_string(node, "enable-method", &method))
+		return 0;
+
+	for (; m->method; m++)
+		if (!strcmp(m->method, method)) {
+			smp_set_ops(m->ops);
+			return 1;
+		}
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+void __init smp_init_cpus(void)
+{
+	struct device_node *cpu, *cpus;
+	u32 cpu_id;
+	unsigned int nr_cpus = 0;
+	int found_method = 0;
+
+	cpus = of_find_node_by_path("/cpus");
+	for_each_of_cpu_node(cpu) {
+		if (!of_device_is_available(cpu))
+			continue;
+
+		cpu_id = of_get_cpu_hwid(cpu, 0);
+		if ((cpu_id < NR_CPUS) && (nr_cpus < nr_cpu_ids)) {
+			nr_cpus++;
+			set_cpu_possible(cpu_id, true);
+			if (!found_method)
+				found_method = set_smp_ops_by_method(cpu);
+		}
+	}
+
+	if (!found_method)
+		set_smp_ops_by_method(cpus);
+
+	pr_info("%d possible cpus\n", nr_cpus);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (num_present_cpus() <= 1)
+		init_cpu_present(cpu_possible_mask);
+}
+
+/*
+ * C entry point for a secondary processor.
+ */
+asmlinkage void __init start_kernel_secondary(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+
+	setup_processor();
+	kvx_mmu_early_setup();
+
+	/* All kernel threads share the same mm context.  */
+	mmgrab(mm);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+	trace_hardirqs_off();
+
+	local_flush_tlb_all();
+
+	local_irq_enable();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b62..aa35c19dbd99a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -147,6 +147,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
+	CPUHP_AP_IRQ_KVX_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
@@ -176,6 +177,7 @@ enum cpuhp_state {
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
+	CPUHP_AP_KVX_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.45.2






