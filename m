Return-Path: <bpf+bounces-3101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82073963F
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A01C2101A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4516F23DB;
	Thu, 22 Jun 2023 04:19:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1961C02;
	Thu, 22 Jun 2023 04:19:58 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA42B10CE;
	Wed, 21 Jun 2023 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687407596; x=1718943596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtwbdSn3PxBMhABoZLMkSt6Wfnm48v4gql/S1jq6XPg=;
  b=WFSKNX3PIbuGIYpNud4Pq7ujruS71JAs/eyB+UvOBByu4QIhb/Al0KPl
   Qgdt9uIrpxymD7gnjwdPf/doe3O47q/cwa+kinzr9rxj4KGjRiiqoC/PX
   4gFOr1Gl6HiO8rd3TJxdEpEwef/4aPG44QWrJ0gpc6kA1eEmMSs+WNXQv
   4eGh97zMbVK9hqTteXolHUB8hSRzMVafSh+mOouGO1l6dMjq1uZDe6HcS
   0/m0sNHgiGi5TLKo2cgepX/Qnd7AL3Z5mFRDmDvC+uo2Js+oQ3YifpWQj
   aOwh1A1cDTtuKIUGwersWeWN6hTidwE3itfdXSrRAWIOQGAQCkJ/rLbny
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363811776"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="363811776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 21:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744453742"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="744453742"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 21:19:44 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tan@web.codeaurora.org, Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next 1/6] platform/x86: intel_pmc_core: Add IPC mailbox accessor function and add SoC register access
Date: Thu, 22 Jun 2023 12:19:00 +0800
Message-Id: <20230622041905.629430-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 drivers/platform/x86/intel/pmc/adl.c          |  2 +-
 drivers/platform/x86/intel/pmc/cnp.c          |  2 +-
 drivers/platform/x86/intel/pmc/core.c         | 63 ++++++++++++++++++-
 drivers/platform/x86/intel/pmc/icl.c          |  2 +-
 drivers/platform/x86/intel/pmc/mtl.c          |  2 +-
 drivers/platform/x86/intel/pmc/spt.c          |  2 +-
 drivers/platform/x86/intel/pmc/tgl.c          |  2 +-
 .../core.h => include/linux/intel_pmc_core.h  | 27 +++++++-
 9 files changed, 95 insertions(+), 8 deletions(-)
 rename drivers/platform/x86/intel/pmc/core.h => include/linux/intel_pmc_core.h (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb14589d14ab..bdb08a79a5f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10581,6 +10581,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
+F:	include/linux/intel_pmc_core*
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 5cbd40979f2a..b6a376c536c0 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 /* Alder Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 const struct pmc_bit_map adl_pfear_map[] = {
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 7fb38815c4eb..504034cc5ec3 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 const struct pmc_bit_map cnp_pfear_map[] = {
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index da6e7206d38b..0d60763c5144 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/io.h>
+#include <linux/intel_pmc_core.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -26,7 +27,9 @@
 #include <asm/msr.h>
 #include <asm/tsc.h>
 
-#include "core.h"
+#define PMC_IPCS_PARAM_COUNT           7
+
+static const struct x86_cpu_id *pmc_cpu_id;
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
 const char *pmc_lpm_modes[] = {
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
+	if (!pmc_cpu_id || !ipc_cmd || !rbuf)
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
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
 {
 	return readl(pmcdev->regbase + reg_offset);
@@ -1130,6 +1190,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	mutex_init(&pmcdev->lock);
 	core_init(pmcdev);
 
+	pmc_cpu_id = cpu_id;
 
 	if (lpit_read_residency_count_address(&slp_s0_addr)) {
 		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 2f11b1a6daeb..f18048ff9382 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 const struct pmc_bit_map icl_pfear_map[] = {
 	{"RES_65",		BIT(0)},
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index e8cc156412ce..7897f5fe9881 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/pci.h>
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 const struct pmc_reg_map mtl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index e16982236778..95ce490cf5d6 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 const struct pmc_bit_map spt_pll_map[] = {
 	{"MIPI PLL",			SPT_PMC_BIT_MPHY_CMN_LANE0},
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index c245ada849d0..a1719d809497 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include "core.h"
+#include <linux/intel_pmc_core.h>
 
 #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
 #define ACPI_GET_LOW_MODE_REGISTERS	1
diff --git a/drivers/platform/x86/intel/pmc/core.h b/include/linux/intel_pmc_core.h
similarity index 95%
rename from drivers/platform/x86/intel/pmc/core.h
rename to include/linux/intel_pmc_core.h
index 9ca9b9746719..82810e8b92a2 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/include/linux/intel_pmc_core.h
@@ -250,7 +250,16 @@ enum ppfear_regs {
 #define MTL_LPM_STATUS_OFFSET			0x1700
 #define MTL_LPM_LIVE_STATUS_OFFSET		0x175C
 
-extern const char *pmc_lpm_modes[];
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
 
 struct pmc_bit_map {
 	const char *name;
@@ -427,4 +436,20 @@ static const struct file_operations __name ## _fops = {			\
 	.release	= single_release,				\
 }
 
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
 #endif /* PMC_CORE_H */
-- 
2.25.1


