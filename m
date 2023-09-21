Return-Path: <bpf+bounces-10536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363F7A98E6
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3270AB21526
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39511405CF;
	Thu, 21 Sep 2023 17:22:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F719BBE;
	Thu, 21 Sep 2023 17:22:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06651F78;
	Thu, 21 Sep 2023 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316627; x=1726852627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6y5ULZ42+b9n+Td0nzhf02tFYyolYBgBUdtJDkDQwc=;
  b=AQ2vavD7J3BjyQbxfpKodl0gLS0KngsreL+wI3xurF8H1hjSpAEwApc9
   E+bX2IbP6GI+BYUxgMCrj6iKrSnEnCa3MlI8LVR19//PogXHqte7fSgps
   OeNug+XzAeIO0ZV0DjrM19o6Ja2chCyTXqidv7tjoV0TrdFU5qXupTTUi
   le0L1KOjoYhhR908RzQtjDl1+fRHNpbmrunFcze2iSjIuEm1Pt/PPAIAP
   cBP8+a9ydKg0AHW8Zd6GWN+mHlmd+/3g0LA4vurmz4aa4QhG5WnLMWZ8e
   s21MdqOUodlW+cktJMDrHptVfReXETyNKu0XWuFvwyHREXrb0mmQiVu7L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444608167"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444608167"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862441720"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862441720"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 05:20:26 -0700
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
Cc: David E Box <david.e.box@intel.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org,
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
Subject: [PATCH net-next v3 1/5] arch: x86: Add IPC mailbox accessor function and add SoC register access
Date: Thu, 21 Sep 2023 20:19:42 +0800
Message-Id: <20230921121946.3025771-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "David E. Box" <david.e.box@linux.intel.com>

- Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
- Add support to use IPC command allows host to access SoC registers
through PMC firmware that are otherwise inaccessible to the host due to
security policies.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Chao Qin <chao.qin@intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 MAINTAINERS                                   |  2 +
 arch/x86/Kconfig                              |  9 +++
 arch/x86/platform/intel/Makefile              |  1 +
 arch/x86/platform/intel/pmc_ipc.c             | 75 +++++++++++++++++++
 .../linux/platform_data/x86/intel_pmc_ipc.h   | 34 +++++++++
 5 files changed, 121 insertions(+)
 create mode 100644 arch/x86/platform/intel/pmc_ipc.c
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dde038545d8..f608668fdfa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10730,8 +10730,10 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
 M:	David E Box <david.e.box@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	arch/x86/platform/intel/pmc_ipc.c
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
+F:	linux/platform_data/x86/intel_pmc_ipc.h
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..31fc8ece2b46 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -666,6 +666,15 @@ config X86_AMD_PLATFORM_DEVICE
 	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
 	  implemented under PINCTRL subsystem.
 
+config INTEL_PMC_IPC
+	tristate "Intel Core SoC Power Management Controller IPC mailbox"
+	depends on ACPI
+	help
+	  This option enables sideband register access support for Intel SoC
+	  power management controller IPC mailbox.
+
+	  If you don't require the option or are in doubt, say N.
+
 config IOSF_MBI
 	tristate "Intel SoC IOSF Sideband support for SoC platforms"
 	depends on PCI
diff --git a/arch/x86/platform/intel/Makefile b/arch/x86/platform/intel/Makefile
index dbee3b00f9d0..470fc68de6ba 100644
--- a/arch/x86/platform/intel/Makefile
+++ b/arch/x86/platform/intel/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_IOSF_MBI)			+= iosf_mbi.o
+obj-$(CONFIG_INTEL_PMC_IPC)		+= pmc_ipc.o
\ No newline at end of file
diff --git a/arch/x86/platform/intel/pmc_ipc.c b/arch/x86/platform/intel/pmc_ipc.c
new file mode 100644
index 000000000000..a96234982710
--- /dev/null
+++ b/arch/x86/platform/intel/pmc_ipc.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Core SoC Power Management Controller IPC mailbox
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
+ *          David E. Box <david.e.box@linux.intel.com>
+ */
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/platform_data/x86/intel_pmc_ipc.h>
+
+#define PMC_IPCS_PARAM_COUNT           7
+
+int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf)
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
+EXPORT_SYMBOL(intel_pmc_ipc);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel PMC IPC Mailbox accessor");
diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
new file mode 100644
index 000000000000..25ba57b8a7ea
--- /dev/null
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -0,0 +1,34 @@
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
+#ifndef INTEL_PMC_IPC_H
+#define INTEL_PMC_IPC_H
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
+/**
+ * intel_pmc_core_ipc() - PMC IPC Mailbox accessor
+ * @ipc_cmd:  struct pmc_ipc_cmd prepared with input to send
+ * @rbuf:     Allocated u32[4] array for returned IPC data
+ *
+ * Return: 0 on success. Non-zero on mailbox error
+ */
+int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
+
+#endif /* INTEL_PMC_IPC_H */
-- 
2.25.1


