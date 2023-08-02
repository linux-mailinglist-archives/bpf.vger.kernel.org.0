Return-Path: <bpf+bounces-6643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EBA76C186
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88406281C5A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E8A5F;
	Wed,  2 Aug 2023 00:33:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE92A40;
	Wed,  2 Aug 2023 00:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43811C433C9;
	Wed,  2 Aug 2023 00:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690936382;
	bh=A3BXXpE0ZGUshoZprV1BnkEKcp6ww7lalvidLo2qbSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4uBXlRlNFxPWQIM2eX9KwDX0ToY8JUnt3C62TcUW/kHHFaN4B7uDdaZ7uL4D4cFg
	 Hw7/zEglOX4c9axzBXqYgBeis2+mUbdYiZgnvDl4Oto6ov579fuAbyKcuhx+3p+Wa9
	 jaVWeql1S5DiwwqIhnkMCM19gM1isCONXRvSp77IweH39eCzSwTL1HWqeBx/G054g9
	 6tpuCAfCLBS07IgdvbY35cYLI9MssvIAyo6MCVHX90+lDbOSb5YqUcqXt/YXtW82XK
	 SAQ9Jww38AuUT8aPK8G5ayZpkxTSDS3gCdZPDnMcr00ZxuCMOoBbdaP1mS0vOB8bqw
	 NtdfBjE/c6ZBg==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	amritha.nambiar@intel.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	shayagr@amazon.com,
	akiyano@amazon.com,
	ioana.ciornei@nxp.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	linux-imx@nxp.com,
	dmichail@fungible.com,
	jeroendb@google.com,
	pkaligineedi@google.com,
	shailend@google.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	grygorii.strashko@ti.com,
	longli@microsoft.com,
	sharmaajay@microsoft.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	gerhard@engleder-embedded.com,
	simon.horman@corigine.com,
	leon@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH bpf-next 1/3] eth: add missing xdp.h includes in drivers
Date: Tue,  1 Aug 2023 17:32:44 -0700
Message-ID: <20230802003246.2153774-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802003246.2153774-1-kuba@kernel.org>
References: <20230802003246.2153774-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handful of drivers currently expect to get xdp.h by virtue
of including netdevice.h. This will soon no longer be the case
so add explicit includes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: j.vosburgh@gmail.com
CC: andy@greyhouse.net
CC: shayagr@amazon.com
CC: akiyano@amazon.com
CC: ioana.ciornei@nxp.com
CC: claudiu.manoil@nxp.com
CC: vladimir.oltean@nxp.com
CC: wei.fang@nxp.com
CC: shenwei.wang@nxp.com
CC: xiaoning.wang@nxp.com
CC: linux-imx@nxp.com
CC: dmichail@fungible.com
CC: jeroendb@google.com
CC: pkaligineedi@google.com
CC: shailend@google.com
CC: jesse.brandeburg@intel.com
CC: anthony.l.nguyen@intel.com
CC: horatiu.vultur@microchip.com
CC: UNGLinuxDriver@microchip.com
CC: kys@microsoft.com
CC: haiyangz@microsoft.com
CC: wei.liu@kernel.org
CC: decui@microsoft.com
CC: peppe.cavallaro@st.com
CC: alexandre.torgue@foss.st.com
CC: joabreu@synopsys.com
CC: mcoquelin.stm32@gmail.com
CC: grygorii.strashko@ti.com
CC: longli@microsoft.com
CC: sharmaajay@microsoft.com
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: gerhard@engleder-embedded.com
CC: simon.horman@corigine.com
CC: leon@kernel.org
CC: linux-hyperv@vger.kernel.org
CC: bpf@vger.kernel.org
---
 drivers/net/bonding/bond_main.c                       | 1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.h          | 1 +
 drivers/net/ethernet/engleder/tsnep.h                 | 1 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h      | 1 +
 drivers/net/ethernet/freescale/enetc/enetc.h          | 1 +
 drivers/net/ethernet/freescale/fec.h                  | 1 +
 drivers/net/ethernet/fungible/funeth/funeth_txrx.h    | 1 +
 drivers/net/ethernet/google/gve/gve.h                 | 1 +
 drivers/net/ethernet/intel/igc/igc.h                  | 1 +
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h | 1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c         | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h          | 1 +
 drivers/net/ethernet/ti/cpsw_priv.h                   | 1 +
 drivers/net/hyperv/hyperv_net.h                       | 1 +
 drivers/net/tap.c                                     | 1 +
 include/net/mana/mana.h                               | 2 ++
 16 files changed, 17 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7a0f25301f7e..2f21cca4fdaf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,7 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/xdp.h>
 
 #include "bonding_priv.h"
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 248b715b4d68..a1134152ecce 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/bpf.h>
+#include <net/xdp.h>
 
 #include "ena_com.h"
 #include "ena_eth_com.h"
diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index 11b29f56aaf9..6e14c918e3fb 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -14,6 +14,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/miscdevice.h>
+#include <net/xdp.h>
 
 #define TSNEP "tsnep"
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index d56d7a13262e..bfb6c96c3b2f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -12,6 +12,7 @@
 #include <linux/fsl/mc.h>
 #include <linux/net_tstamp.h>
 #include <net/devlink.h>
+#include <net/xdp.h>
 
 #include <soc/fsl/dpaa2-io.h>
 #include <soc/fsl/dpaa2-fd.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 8577cf7699a0..7439739cd81a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -11,6 +11,7 @@
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
 #include <linux/dim.h>
+#include <net/xdp.h>
 
 #include "enetc_hw.h"
 
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8f1edcca96c4..5a0974e62f99 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -22,6 +22,7 @@
 #include <linux/timecounter.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/firmware/imx/sci.h>
+#include <net/xdp.h>
 
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_txrx.h b/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
index 53b7e95213a8..5eec552a1f24 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
+++ b/drivers/net/ethernet/fungible/funeth/funeth_txrx.h
@@ -5,6 +5,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/u64_stats_sync.h>
+#include <net/xdp.h>
 
 /* Tx descriptor size */
 #define FUNETH_SQE_SIZE 64U
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4b425bf71ede..a31256f70348 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/u64_stats_sync.h>
+#include <net/xdp.h>
 
 #include "gve_desc.h"
 #include "gve_desc_dqo.h"
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9db384f66a8e..4bffc3cb502f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -15,6 +15,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/bitfield.h>
 #include <linux/hrtimer.h>
+#include <net/xdp.h>
 
 #include "igc_hw.h"
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 27f272831ea5..eb7d81b5e9f8 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -14,6 +14,7 @@
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/switchdev.h>
+#include <net/xdp.h>
 
 #include <vcap_api.h>
 #include <vcap_api_client.h>
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ac2acc9aca9d..21665f114fe9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -11,6 +11,7 @@
 
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
+#include <net/xdp.h>
 
 #include <net/mana/mana.h>
 #include <net/mana/mana_auxiliary.h>
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4ce5eaaae513..f838a13b9447 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -23,6 +23,7 @@
 #include <linux/reset.h>
 #include <net/page_pool.h>
 #include <uapi/linux/bpf.h>
+#include <net/xdp.h>
 
 struct stmmac_resources {
 	void __iomem *addr;
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 34230145ca0b..67ca005fd990 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -7,6 +7,7 @@
 #define DRIVERS_NET_ETHERNET_TI_CPSW_PRIV_H_
 
 #include <uapi/linux/bpf.h>
+#include <net/xdp.h>
 
 #include "davinci_cpdma.h"
 
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index c9dd69dbe1b8..810977952f95 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -16,6 +16,7 @@
 #include <linux/hyperv.h>
 #include <linux/rndis.h>
 #include <linux/jhash.h>
+#include <net/xdp.h>
 
 /* RSS related */
 #define OID_GEN_RECEIVE_SCALE_CAPABILITIES 0x00010203  /* query only */
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9137fb8c1c42..b196a2a54355 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -22,6 +22,7 @@
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
 #include <net/sock.h>
+#include <net/xdp.h>
 #include <linux/virtio_net.h>
 #include <linux/skb_array.h>
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 024ad8ddb27e..1ccdca03e166 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -4,6 +4,8 @@
 #ifndef _MANA_H
 #define _MANA_H
 
+#include <net/xdp.h>
+
 #include "gdma.h"
 #include "hw_channel.h"
 
-- 
2.41.0


