Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9728539472B
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhE1SqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:46:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48410 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhE1SqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622227483; x=1653763483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSCbj2P0BmhDgjrc5nD19bEkBZY7VMm1q7Cl/M+0Kaw=;
  b=K0epOpu05nGFOewEgCpRWQyduFWNUvUCwrTYUrsqY2ZCgEbp0L89YU8a
   uxetVBVZABG7W9hSyte+FgZnJ4Uc+C92Pn6X5UUfdfdCmbsLQLs/z4bN4
   HuV9j8LbcmjqCaj3lfgvzcs72miNXI74nweA0P7q4tmNLGlY/E9CX5fQ/
   JMX15BUcnbsjniygR4iBkEJNN8aSOlPLsi+xbNFYdbMWv7EWurLvhN0PZ
   5fxYR1eZwlT57K2gVnZVHBHqsvDyU/hE9wWEwemckYveg0BF8CTU6u2iX
   X+y+ZRpD8M3/ZYSUlwZ4hc/jzhuEN0rH6q7m7ptSNTkM6dxrVmjzbkmCr
   g==;
IronPort-SDR: Qn3Hw1vHALSbEau6HITTS9Qu6Jk8RZdtKkVmqfBgvh6rqGmATkeU5sU9ikuCCrEFbM+i4T3lgg
 E/brPs9dQvsBcAA+Olo6gsAeplSjo0vaRLjb6J8g8UFs1r1QBcKTnjMvWE5S4VbwSTOBCr+msD
 sUAvWrbmzqb5nJQqOkZFLj1SV7sy/I7G8oc/ZmNArtIvNwj8aXAczaK0xPx3Hu9kgkEDuEmDOu
 QWj+DJ63BkdrBUeP4/3ntsImX/b2VZErV6qdOsBIJppjoL6TGlGkj/BHUT+iOpgsgCs34woxF+
 s2E=
X-IronPort-AV: E=Sophos;i="5.83,230,1616428800"; 
   d="scan'208";a="174577187"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2021 02:44:43 +0800
IronPort-SDR: rV3vi4fN0EOUO/GnINKbAcF6BdnXCw1k93j0WnccOekUe+Mma4r2JaT28+A8i8vAAoiLjyQv3l
 CUGddz4NSob6aA+dke2KVce6dhpBc+ZLTFfUdgr6UtLpkbDViwkz4DdcScjYgdoyx9iJ0N8VGj
 mq4k2mVrERwt53i7AhcL0HrpFQisX8LnwG8czLIDTuRZXTghpiMM+hp1a2sw0D4sOvpjArFqMq
 dO5c7eAxxozIzu2O3Z/NTgG3jIx6wWpd4nY2YlHvn4cLsoZfZpXUkOTnyuHlj4LG2MdQQ7pEFE
 2LJAIoML/gkbKvkP3RjS3p2E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 11:22:46 -0700
IronPort-SDR: AVruf/7aToosJVgWRfM+MP7aYp6PQsYmZ+WL/WFP3Blg4dLOXCMxNs/3kGzcB/wP4StASFedhC
 2LjuUwoZgffZfxZ2WT/mVU75h7yKVSj1S7veRm6e8C5/QAAy0OXPULU9nG4ZyzAS6o42YV2iKp
 BpR868dhCEpZvzrt24Zf/u4xJYaotZz3i/11dA2r9c8EQtQg2ZjPr/3TNsrK9aqtoDyFS3ukIo
 5tbvTAm+hmwyyjKzCE43xBHiDZT6Odc+Dm5PoB1gT/QXtHTBlo5rlTeev48+92kpmPPrsOgtog
 oic=
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.wdc.com) ([10.225.163.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2021 11:44:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        bpf@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alan Kao <alankao@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [RFC v2 4/7] RISC-V: Add a simple platform driver for RISC-V legacy perf
Date:   Fri, 28 May 2021 11:44:02 -0700
Message-Id: <20210528184405.1793783-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528184405.1793783-1-atish.patra@wdc.com>
References: <20210528184405.1793783-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The old RISC-V perf implementation allowed counting of only
cycle/instruction counters using perf. Restore that feature by implementing
a simple platform driver under a separate config to provide backward
compatibility. Any existing software stack will continue to work as it is.
However, it provides an easy way out in future where we can remove the
legacy driver.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/perf/Kconfig            |  9 ++++
 drivers/perf/Makefile           |  3 ++
 drivers/perf/riscv_pmu_legacy.c | 92 +++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h  |  1 +
 4 files changed, 105 insertions(+)
 create mode 100644 drivers/perf/riscv_pmu_legacy.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index fc42ab613ea0..1546a487d970 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -64,6 +64,15 @@ config RISCV_PMU
 	  Say y if you want to use CPU performance monitors on RISCV-based
 	  systems.
 
+config RISCV_PMU_LEGACY
+	depends on RISCV_PMU
+	bool "RISC-V legacy PMU implementation"
+	default y
+	help
+	  Say y if you want to use the legacy CPU performance monitor
+	  implementation on RISC-V based systems. This only allows counting
+	  of cycle/instruction counter and will be removed in future.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 76e5c50e24bb..e8aa666a9d28 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
+ifeq ($(CONFIG_RISCV_PMU), y)
+obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
+endif
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
new file mode 100644
index 000000000000..0978f0b675b4
--- /dev/null
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V performance counter support.
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ *
+ * This implementation is based on old RISC-V perf and ARM perf event code
+ * which are in turn based on sparc64 and x86 code.
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/perf/riscv_pmu.h>
+#include <linux/platform_device.h>
+
+#define RISCV_PMU_LEGACY_CYCLE		0
+#define RISCV_PMU_LEGACY_INSTRET	1
+#define RISCV_PMU_LEGACY_NUM_CTR	2
+
+static int pmu_legacy_ctr_get_idx(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	if (event->attr.type != PERF_TYPE_HARDWARE)
+		return -EOPNOTSUPP;
+	if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
+		return RISCV_PMU_LEGACY_CYCLE;
+	else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
+		return RISCV_PMU_LEGACY_INSTRET;
+	else
+		return -EOPNOTSUPP;
+}
+
+/* For legacy config & counter index are same */
+static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
+{
+	return pmu_legacy_ctr_get_idx(event);
+}
+
+static u64 pmu_legacy_read_ctr(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u64 val;
+
+	if (idx == RISCV_PMU_LEGACY_CYCLE) {
+		val = riscv_pmu_ctr_read_csr(CSR_CYCLE);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = (u64)riscv_pmu_ctr_read_csr(CSR_CYCLEH) << 32 | val;
+	} else if (idx == RISCV_PMU_LEGACY_INSTRET) {
+		val = riscv_pmu_ctr_read_csr(CSR_INSTRET);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = ((u64)riscv_pmu_ctr_read_csr(CSR_INSTRETH)) << 32 | val;
+	} else
+		return 0;
+
+	return val;
+}
+
+static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 initial_val = pmu_legacy_read_ctr(event);
+
+	/**
+	 * The legacy method doesn't really have a start/stop method.
+	 * It also can not update the counter with a initial value.
+	 * But we still need to set the prev_count so that read() can compute
+	 * the delta. Just use the current counter value to set the prev_count.
+	 */
+	local64_set(&hwc->prev_count, initial_val);
+}
+
+/**
+ * This is just a simple implementation to allow legacy implementations
+ * compatible with new RISC-V PMU driver framework.
+ * This driver only allows reading two counters i.e CYCLE & INSTRET.
+ * However, it can not start or stop the counter. Thus, it is not very useful
+ * will be removed in future.
+ */
+void riscv_pmu_legacy_init(struct riscv_pmu *pmu)
+{
+	pr_info("Legacy PMU implementation is available\n");
+
+	pmu->num_counters = RISCV_PMU_LEGACY_NUM_CTR;
+	pmu->ctr_start = pmu_legacy_ctr_start;
+	pmu->ctr_stop = NULL;
+	pmu->event_map = pmu_legacy_event_map;
+	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
+	pmu->ctr_get_width = NULL;
+	pmu->ctr_clear_idx = NULL;
+	pmu->ctr_read = pmu_legacy_read_ctr;
+}
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 72802b2df0cd..26f8f25df395 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -53,6 +53,7 @@ struct riscv_pmu {
 
 #define to_riscv_pmu(p) (container_of(p, struct riscv_pmu, pmu))
 unsigned long riscv_pmu_ctr_read_csr(unsigned long csr);
+void riscv_pmu_legacy_init(struct riscv_pmu *pmu);
 struct riscv_pmu *riscv_pmu_alloc(void);
 
 #endif /* CONFIG_RISCV_PMU */
-- 
2.25.1

