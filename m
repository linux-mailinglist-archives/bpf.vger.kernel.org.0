Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0851939472F
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhE1Sqf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 14:46:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48410 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhE1Sq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 14:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622227490; x=1653763490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UzQit8vvo3jY7pyeyhpVhnucH9bPaiaNXneEyvn1kdE=;
  b=AXbjgB4klAFc4wbjmOCBzdgDIQmflPgzk2FkS8w8Gz0lb65PSFmthFoK
   IbD13ASP7+h9wqe8pfQEQoMH1N1z9Ykvn5wVYJw6/cRIgpBN9D0Gwm/oj
   A1rK4roHaRyVF7CmFGxKWVcOQSHj3lVgKoJMhxKdEPEGh+fPklg1WnYxN
   8M2WE81V9yfhrmcsys5bySEFyUYbdGyc6c1/muYBk+xCS+4OxPh93Lbsj
   I3eFZfV/v4OspcdbmPLGnetWOPp3udkTgV1k04w7+3KH/ZmoC5in1eyJF
   6VIv5vxdDtZgho/e0ss3lzQunAjJht7H0/RZpF2KGmLWwgmb417r1CsaF
   w==;
IronPort-SDR: VTh1LdsNpch8vhm5cfYkCf0FxxkJ//g2vih/xrpMg7z5U11WwUsFFLr8qAMxO8rHZACDhNFmZU
 jcMc5x0IrW4pLXeDbDjQfSw4kqDtZZko5FfzDJbqjKb+2Ysrw5THhChMrTvgw/yBHMjTUsceD1
 mvkLwC9dG2HrZHO2HqwAg//+HeYbReFICF0GaetLRTOR+ywqC4lbFjHXNkIvBg+1tXKjwyHVeN
 m6ui3xBCldJdjyIs++zAu8G1JCF2KJS6lrZfDGBx5G9IWsXlbCUx8RMCTgvd75HCRD7/zyEg7T
 ouE=
X-IronPort-AV: E=Sophos;i="5.83,230,1616428800"; 
   d="scan'208";a="174577196"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2021 02:44:49 +0800
IronPort-SDR: TEOY4YAfqmDqK4JZbaAmKSSQx9vfAKixWH8SrPR5OLLWd+fYS+Bag53o0UqPesugu7tRe4Bn0S
 W9CcypHIT3uMkO7VU6WDUlX7bXq1iewl5W6BzWuvObFe4lwn6Y+XLI/Lf6zbjt9cZiDBPHG07w
 I0ELPj0AGCKa/jVXdwx9q40knnGBNRLwYnytUKG+5BOv3P3j8GPlQcwu9X/GG/pme9l08Cjerw
 HRIQzkR5WMEPli6zkrD1NUBTttVmhEc1nSQCCA08BlWEYN9+gVK06ZzRuTAj3x2C1tLxFrLkpt
 Lkepxb2WQ3jXaWFB+/IAaxc1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 11:22:51 -0700
IronPort-SDR: ChXQfyg95hi7tLAmWBjJvvM5CNe9wONH9Yer0YGAUWM0eQ3T3gINuf60oCNlCMSFaoB/WwrI+L
 V4ymahnUO9GeyA8cF2U+FwkwggvY6VIQtRZx8nOFY7S0LqCJGa6MssBoIlsK9AS09vfAGP328K
 nxjC2gFdo5qvy21DxhxGodAnOlIsIfkR+rOG9Pr4YGuRTUGIeATK/erV9H4eIrtVifdwS1kVa3
 dmCkkmmoGjlehuEzzTOaWtAhwQd/MkuERPdiYSx+ZK6WaonGeWbm3mg945jTF2Zyo9e6J9hpHJ
 WEc=
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.wdc.com) ([10.225.163.91])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2021 11:44:46 -0700
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
Subject: [RFC v2 5/7] RISC-V: Add RISC-V SBI PMU extension definitions
Date:   Fri, 28 May 2021 11:44:03 -0700
Message-Id: <20210528184405.1793783-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528184405.1793783-1-atish.patra@wdc.com>
References: <20210528184405.1793783-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds all the definitions defined by the SBI PMU extension.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sbi.h | 94 ++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0d42693cb65e..9a1cb78df15c 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -27,6 +27,7 @@ enum sbi_ext_id {
 	SBI_EXT_IPI = 0x735049,
 	SBI_EXT_RFENCE = 0x52464E43,
 	SBI_EXT_HSM = 0x48534D,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
@@ -70,6 +71,99 @@ enum sbi_hsm_hart_status {
 	SBI_HSM_HART_STATUS_STOP_PENDING,
 };
 
+
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+};
+
+#define RISCV_PMU_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_RAW_EVENT_IDX 0x20000
+
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/**
+ * Special "firmware" events provided by the firmware, even if the hardware
+ * does not support performance events. These events are encoded as a raw
+ * event type in Linux kernel perf framework.
+ */
+enum sbi_pmu_fw_generic_events_t {
+	SBI_PMU_FW_MISALIGNED_LOAD	= 0,
+	SBI_PMU_FW_MISALIGNED_STORE	= 1,
+	SBI_PMU_FW_ACCESS_LOAD		= 2,
+	SBI_PMU_FW_ACCESS_STORE		= 3,
+	SBI_PMU_FW_ILLEGAL_INSN		= 4,
+	SBI_PMU_FW_SET_TIMER		= 5,
+	SBI_PMU_FW_IPI_SENT		= 6,
+	SBI_PMU_FW_IPI_RECVD		= 7,
+	SBI_PMU_FW_FENCE_I_SENT		= 8,
+	SBI_PMU_FW_FENCE_I_RECVD	= 9,
+	SBI_PMU_FW_SFENCE_VMA_SENT	= 10,
+	SBI_PMU_FW_SFENCE_VMA_RCVD	= 11,
+	SBI_PMU_FW_SFENCE_VMA_ASID_SENT	= 12,
+	SBI_PMU_FW_SFENCE_VMA_ASID_RCVD	= 13,
+
+	SBI_PMU_FW_HFENCE_GVMA_SENT	= 14,
+	SBI_PMU_FW_HFENCE_GVMA_RCVD	= 15,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_SENT = 16,
+	SBI_PMU_FW_HFENCE_GVMA_VMID_RCVD = 17,
+
+	SBI_PMU_FW_HFENCE_VVMA_SENT	= 18,
+	SBI_PMU_FW_HFENCE_VVMA_RCVD	= 19,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_SENT = 20,
+	SBI_PMU_FW_HFENCE_VVMA_ASID_RCVD = 21,
+	SBI_PMU_FW_MAX,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_event_type {
+	SBI_PMU_EVENT_TYPE_HW = 0x0,
+	SBI_PMU_EVENT_TYPE_CACHE = 0x1,
+	SBI_PMU_EVENT_TYPE_RAW = 0x2,
+	SBI_PMU_EVENT_TYPE_FW = 0xf,
+};
+
+/* SBI PMU event types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
+#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 3)
+#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 6)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
 #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
-- 
2.25.1

