Return-Path: <bpf+bounces-6969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F176FC5B
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373031C216AC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11060947D;
	Fri,  4 Aug 2023 08:47:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C89445;
	Fri,  4 Aug 2023 08:47:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BA049EB;
	Fri,  4 Aug 2023 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691138827; x=1722674827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGt94uchbGNgCTOyUJqO1F4CC7iK2MkSjUEctU7dhGs=;
  b=XjD1puV7+eb4l+Rap9JU1JQPHaelVv6h32nO1QVw8L63zLsyBGfsOa19
   hHINJLn10sEawUK3VHzanYa7+hEpFlsXf+hQOkJdgH4K7+S0hGyZRH/L5
   ZUJaSPG4asnfdvnCaFi2hSHAIVaPCga7H+2Xjj7s3PQHgHqTSoQnRmPSD
   oNc7HQx1Q1TS9Shu/So3Fd1gCBOM2JaH1gmbeV/u1ECHgNOu4xaVXf4LC
   wfrdmLf1fPPGtkTZDXaTnI+roDri+aZ8Git+kUpl5YGmvkQcO7FvbAq22
   8vHlpSYA4e6qVQLEOBB1XNfgW2F38y0i7kvsHZrcr+LEvQ1gaHWhkd3t+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456478343"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456478343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765017898"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765017898"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:46:55 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next v2 1/5] platform/x86: intel_pmc_core: Add IPC mailbox accessor function and add SoC register access
Date: Fri,  4 Aug 2023 16:45:23 +0800
Message-Id: <20230804084527.2082302-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "David E. Box" <david.e.box@linux.intel.com>

- Exports intel_pmc_core_ipc() for host access to the PMC IPC mailbox
- Add support to use IPC command allows host to access SoC registers
through PMC firmware that are otherwise inaccessible to the host due to
security policies.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 MAINTAINERS                                   |  1 +
 drivers/platform/x86/intel/pmc/core.c         | 60 +++++++++++++++++++
 .../linux/platform_data/x86/intel_pmc_core.h  | 41 +++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 include/linux/platform_data/x86/intel_pmc_core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 069e176d607a..8a034dee9da9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10648,6 +10648,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
+F:	linux/platform_data/x86/intel_pmc_core.h
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5a36b3f77bc5..6fb1b0f453d8 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/platform_data/x86/intel_pmc_core.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -28,6 +29,8 @@
 
 #include "core.h"
 
+#define PMC_IPCS_PARAM_COUNT           7
+
 /* Maximum number of modes supported by platfoms that has low power mode capability */
 const char *pmc_lpm_modes[] = {
 	"S0i2.0",
@@ -53,6 +56,63 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
+int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object params[PMC_IPCS_PARAM_COUNT] = {
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+		{.type = ACPI_TYPE_INTEGER,},
+	};
+	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
+	union acpi_object *obj;
+	int status;
+
+	if (!ipc_cmd || !rbuf)
+		return -EINVAL;
+
+	/*
+	 * 0: IPC Command
+	 * 1: IPC Sub Command
+	 * 2: Size
+	 * 3-6: Write Buffer for offset
+	 */
+	params[0].integer.value = ipc_cmd->cmd;
+	params[1].integer.value = ipc_cmd->sub_cmd;
+	params[2].integer.value = ipc_cmd->size;
+	params[3].integer.value = ipc_cmd->wbuf[0];
+	params[4].integer.value = ipc_cmd->wbuf[1];
+	params[5].integer.value = ipc_cmd->wbuf[2];
+	params[6].integer.value = ipc_cmd->wbuf[3];
+
+	status = acpi_evaluate_object(NULL, "\\IPCS", &arg_list, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = buffer.pointer;
+	/* Check if the number of elements in package is 5 */
+	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
+		const union acpi_object *objs = obj->package.elements;
+
+		if ((u8)objs[0].integer.value != 0)
+			return -EINVAL;
+
+		rbuf[0] = objs[1].integer.value;
+		rbuf[1] = objs[2].integer.value;
+		rbuf[2] = objs[3].integer.value;
+		rbuf[3] = objs[4].integer.value;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_pmc_core_ipc);
+
 static inline u32 pmc_core_reg_read(struct pmc *pmc, int reg_offset)
 {
 	return readl(pmc->regbase + reg_offset);
diff --git a/include/linux/platform_data/x86/intel_pmc_core.h b/include/linux/platform_data/x86/intel_pmc_core.h
new file mode 100644
index 000000000000..9bb3394fedcf
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_pmc_core.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel Core SoC Power Management Controller Header File
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
+ *          David E. Box <david.e.box@linux.intel.com>
+ */
+#ifndef INTEL_PMC_CORE_H
+#define INTEL_PMC_CORE_H
+
+#define IPC_SOC_REGISTER_ACCESS			0xAA
+#define IPC_SOC_SUB_CMD_READ			0x00
+#define IPC_SOC_SUB_CMD_WRITE			0x01
+
+struct pmc_ipc_cmd {
+	u32 cmd;
+	u32 sub_cmd;
+	u32 size;
+	u32 wbuf[4];
+};
+
+#if IS_ENABLED(CONFIG_INTEL_PMC_CORE)
+/**
+ * intel_pmc_core_ipc() - PMC IPC Mailbox accessor
+ * @ipc_cmd:  struct pmc_ipc_cmd prepared with input to send
+ * @rbuf:     Allocated u32[4] array for returned IPC data
+ *
+ * Return: 0 on success. Non-zero on mailbox error
+ */
+int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
+#else
+static inline int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_INTEL_PMC_CORE */
+
+#endif /* INTEL_PMC_CORE_H */
-- 
2.25.1


