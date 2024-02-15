Return-Path: <bpf+bounces-22055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32454855944
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D57B261A4
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C858F6F;
	Thu, 15 Feb 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwh153S9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2388F68;
	Thu, 15 Feb 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966493; cv=none; b=HATGunwvAixTwUSVl3t5rWoT+fJey1Wpd7IFYzKzjdyYGx92BoaQ5oZBEhwl0W13qJ6TQU7VYVcR/S84CB5oxTEcqPYE76cp3fcaBQHJhrbvYDpG35ETKYsSRqS+6uxbm/dXRAkg/rbgnTB+eH43vEsX7/J8zkePSQX4B2LktCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966493; c=relaxed/simple;
	bh=74BgQfGIQ9eFHmrbRL0VFPUvmEq6wbG/DaTUmCN+X3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmbtclEyFzwuKydpR8wicn9k/GvLkOoj+q7Hply0mvBYOAgduIQZz6DIvb9CjeWoTCHLzrD2MeBUivBIvX90OIMiomXX6i6AVAwTGYru0KGmLYvp3HGbWu/uHUGg4DtGUm7cWfi++mO8iha8CjbMn4xSj66+rTHGJ7+DS70Kayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwh153S9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707966492; x=1739502492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=74BgQfGIQ9eFHmrbRL0VFPUvmEq6wbG/DaTUmCN+X3E=;
  b=Wwh153S9H6/clyvNgP6HBvC/66+RlcuXmw73vz2iG0c2iAobLweSj3lz
   FrEhjVcy12ArjU+9rukjZJQ9aUHrUS2DN17teivyMW58TB4XEV/rfm+wO
   Hoe8gpTwGkVjNcTFvYEzjWral4H/0qA9khzRh5vyw9auoDD9uAgyXkr3G
   6tSPo9AYI/uLZ8MvK2sN3sBpUjQ9sCOF+Osq1n0F70XiOwnHHkyzRIzMd
   5mJdrH2zJF1qOxqsDUWMe1oJhBCEacoYQr0czhGRjvt6mLNFDvZZiQWti
   Y2YhSeNjYQxhAll2w0BxuetzNF5JQ6Fl4OZ5IIa4rQdsEtFxAmb3syxii
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19461332"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="19461332"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3385795"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 19:08:02 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: [PATCH net-next v5 5/9] arch: x86: Add IPC mailbox accessor function and add SoC register access
Date: Thu, 15 Feb 2024 11:04:55 +0800
Message-Id: <20240215030500.3067426-6-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
References: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 2b775f4369e0..0276f1d53caf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10996,8 +10996,10 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
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
index 5edec175b9bf..bceae28b9381 100644
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
index 000000000000..d47b89f873fc
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
+ * intel_pmc_ipc() - PMC IPC Mailbox accessor
+ * @ipc_cmd:  struct pmc_ipc_cmd prepared with input to send
+ * @rbuf:     Allocated u32[4] array for returned IPC data
+ *
+ * Return: 0 on success. Non-zero on mailbox error
+ */
+int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
+
+#endif /* INTEL_PMC_IPC_H */
-- 
2.34.1


