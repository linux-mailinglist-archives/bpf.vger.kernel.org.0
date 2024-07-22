Return-Path: <bpf+bounces-35219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B85938C67
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 11:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F6F1F22CE7
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4717107B;
	Mon, 22 Jul 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="OTFHcMlH"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476C16F82F
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641438; cv=none; b=QZLCavQly1DcxpXhEpKcAfqTPI6lHYT5jD4E1tC7hFHxVAe6FyCUZbor9jALHIsDZNl/LGMAo5iYMCqQ58dU5/QNRFpneImXrzpvU/ztw7lBsz+dgBxrh1nLYhWCAgaT5CDGVAq9Q4RBrG2W9oghPAGJ31dVNsBe+BsOFicMPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641438; c=relaxed/simple;
	bh=i2aOZ3R/x/jElpWRK+yCYwSFaQECMP30EAy6IJbselM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amFV5npnXDfYaS1WxqKpGQpZceRKy0t55XQKArMmJPoiwUzohuKgr2+fWrgqcI/UZ/+xPMyxAh/8IaNzaTaQW8ty87I9X37A8IXDjOBiiHs5TMDX309UdjWKOos31XqKff7LkgKz3LUOZ9mSAMBX7p6SODJtJcC1/pNsdaeI+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=OTFHcMlH; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 5A32080BA3E
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 11:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641434;
	bh=i2aOZ3R/x/jElpWRK+yCYwSFaQECMP30EAy6IJbselM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTFHcMlHaC2e0XvVxtUvsBhWBDbf40/ljDQqBMEYcYgOd1fPN5F7VJLGUTuCHRQe/
	 AX6RLWNnba28LpgfDcMXRV8VzNZMfPCrA+IahAq7M+6YuW7Hp62PO4c4j27ceN0tAl
	 BKgtCi3yfoLECKhIT48lFOtXkHVZwiH8unu/u+tQ=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 2515E80ADFD; Mon, 22 Jul 2024 11:43:54 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 8995280BC25; Mon, 22 Jul
 2024 11:43:53 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 4F84C40317; Mon, 22 Jul
 2024 11:43:53 +0200 (CEST)
X-Secumail-id: <ae77.669e29d9.85e02.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Guillaume Thouvenin <thouveng@gmail.com>,
 Luc Michel <luc@lmichel.fr>, Jules Maselbas <jmaselbas@zdiv.net>,
 bpf@vger.kernel.org
Subject: [RFC PATCH v3 35/37] kvx: Add IPI driver
Date: Mon, 22 Jul 2024 11:41:46 +0200
Message-ID: <20240722094226.21602-36-ysionneau@kalrayinc.com>
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

The Inter-Processor Interrupt Controller (IPI) provides a fast
synchronization mechanism to the software. It exposes eight independent
sets of registers that can be used to notify each processor in the cluster.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: new patch
V2 -> V3:
- Restructured IPI code according to reviewer feedback
  - move from arch/kvx/platform to drivers/irqchip/
  - remove bogus comment
  - call set_smp_cross_call() to set smpboot.c's ipi function pointer
  - feedbacks: https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#mb02884ea498e627c2621973157330f2ea9977190
---
 arch/kvx/include/asm/ipi.h         |  16 ++++
 drivers/irqchip/Kconfig            |   4 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-kvx-ipi-ctrl.c | 143 +++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+)
 create mode 100644 arch/kvx/include/asm/ipi.h
 create mode 100644 drivers/irqchip/irq-kvx-ipi-ctrl.c

diff --git a/arch/kvx/include/asm/ipi.h b/arch/kvx/include/asm/ipi.h
new file mode 100644
index 0000000000000..a23275d19d225
--- /dev/null
+++ b/arch/kvx/include/asm/ipi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IPI_H
+#define _ASM_KVX_IPI_H
+
+#include <linux/irqreturn.h>
+
+int kvx_ipi_ctrl_init(struct device_node *node, struct device_node *parent);
+
+void kvx_ipi_send(const struct cpumask *mask, unsigned int operation);
+
+#endif /* _ASM_KVX_IPI_H */
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index da1dbd79dab54..65db9990cf475 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -337,6 +337,10 @@ config KVX_CORE_INTC
 	depends on KVX
 	select IRQ_DOMAIN
 
+config KVX_IPI_CTRL
+	bool
+	depends on KVX
+
 config KVX_APIC_GIC
 	bool
 	depends on KVX
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 30b69db8789f7..f8fa246df74d2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_KVX_CORE_INTC)		+= irq-kvx-core-intc.o
+obj-$(CONFIG_KVX_IPI_CTRL)		+= irq-kvx-ipi-ctrl.o
 obj-$(CONFIG_KVX_APIC_GIC)		+= irq-kvx-apic-gic.o
 obj-$(CONFIG_KVX_ITGEN)			+= irq-kvx-itgen.o
 obj-$(CONFIG_KVX_APIC_MAILBOX)		+= irq-kvx-apic-mailbox.o
diff --git a/drivers/irqchip/irq-kvx-ipi-ctrl.c b/drivers/irqchip/irq-kvx-ipi-ctrl.c
new file mode 100644
index 0000000000000..09d955a5c109a
--- /dev/null
+++ b/drivers/irqchip/irq-kvx-ipi-ctrl.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ *
+ * Author(s): Clement Leger
+ *            Jonathan Borne
+ *            Luc Michel
+ */
+
+#define pr_fmt(fmt)	"kvx_ipi_ctrl: " fmt
+
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/irqchip.h>
+#include <linux/of_irq.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/cpuhotplug.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/ipi.h>
+
+#define IPI_INTERRUPT_OFFSET	0x0
+#define IPI_MASK_OFFSET		0x20
+
+/*
+ * IPI controller can signal RM and PE0 -> 15
+ * In order to restrict that to the PE, write the corresponding mask
+ */
+#define KVX_IPI_CPU_MASK	(~0xFFFF)
+
+/* A collection of single bit ipi messages.  */
+static DEFINE_PER_CPU_ALIGNED(unsigned long, ipi_data);
+
+struct kvx_ipi_ctrl {
+	void __iomem *regs;
+	unsigned int ipi_irq;
+};
+
+static struct kvx_ipi_ctrl kvx_ipi_controller;
+
+void kvx_ipi_send(const struct cpumask *mask, unsigned int operation)
+{
+	const unsigned long *maskb = cpumask_bits(mask);
+	unsigned long flags;
+	int cpu;
+
+	/* Set operation that must be done by receiver */
+	for_each_cpu(cpu, mask)
+		set_bit(operation, &per_cpu(ipi_data, cpu));
+
+	/* Commit the write before sending IPI */
+	smp_wmb();
+
+	local_irq_save(flags);
+
+	WARN_ON(*maskb & KVX_IPI_CPU_MASK);
+	writel(*maskb, kvx_ipi_controller.regs + IPI_INTERRUPT_OFFSET);
+
+	local_irq_restore(flags);
+}
+
+static int kvx_ipi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(kvx_ipi_controller.ipi_irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int kvx_ipi_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(kvx_ipi_controller.ipi_irq);
+
+	return 0;
+}
+
+static irqreturn_t ipi_irq_handler(int irq, void *dev_id)
+{
+	unsigned long *pending_ipis = &per_cpu(ipi_data, smp_processor_id());
+
+	while (true) {
+		unsigned long ops = xchg(pending_ipis, 0);
+
+		if (!ops)
+			return IRQ_HANDLED;
+
+		handle_IPI(ops);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int __init kvx_ipi_ctrl_init(struct device_node *node,
+			     struct device_node *parent)
+{
+	int ret;
+	unsigned int ipi_irq;
+	void __iomem *ipi_base;
+
+	BUG_ON(!node);
+
+	ipi_base = of_iomap(node, 0);
+	BUG_ON(!ipi_base);
+
+	kvx_ipi_controller.regs = ipi_base;
+
+	/* Init mask for interrupts to PE0 -> PE15 */
+	writel(KVX_IPI_CPU_MASK, kvx_ipi_controller.regs + IPI_MASK_OFFSET);
+
+	ipi_irq = irq_of_parse_and_map(node, 0);
+	if (!ipi_irq) {
+		pr_err("Failed to parse irq: %d\n", ipi_irq);
+		return -EINVAL;
+	}
+
+	ret = request_percpu_irq(ipi_irq, ipi_irq_handler,
+						"kvx_ipi", &kvx_ipi_controller);
+	if (ret) {
+		pr_err("can't register interrupt %d (%d)\n",
+						ipi_irq, ret);
+		return ret;
+	}
+	kvx_ipi_controller.ipi_irq = ipi_irq;
+
+	ret = cpuhp_setup_state(CPUHP_AP_IRQ_KVX_STARTING,
+				"kvx/ipi:online",
+				kvx_ipi_starting_cpu,
+				kvx_ipi_dying_cpu);
+	if (ret < 0) {
+		pr_err("Failed to setup hotplug state");
+		return ret;
+	}
+
+	set_smp_cross_call(kvx_ipi_send);
+	pr_info("controller probed\n");
+
+	return 0;
+}
+IRQCHIP_DECLARE(kvx_ipi_ctrl, "kalray,coolidge-ipi-ctrl", kvx_ipi_ctrl_init);
-- 
2.45.2






