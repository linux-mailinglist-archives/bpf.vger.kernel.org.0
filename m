Return-Path: <bpf+bounces-60910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A6ADEB1F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB592169A38
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5E2DE1EC;
	Wed, 18 Jun 2025 12:00:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E1D28A1F5
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248036; cv=none; b=UrmjpWaqWVCbQSpLwC5zrzChS/w+9lshZF8QkhDeZciGEze516DpDYsUO+Bfey9dXfDRotIfxvZWx0m8lE86ErwHvx+tY0wP9iLkkB6/0F1yoIgxSPSBfL1MprNbE7tcAzFvlctI0WVok9HOSJ4Ae1HbGCVxSkhgvLDSMppM8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248036; c=relaxed/simple;
	bh=VYJMovtGxdXZkHpWqywTu3uAJHSI58Pp1fUIXcI9pgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trSDBDKNoYOFiHZX62K+TDHxhMtHKvpbSyCgBOkPy9srITjUVr2iZnQdKBA1jsB9AwGcz+IQpiJLhTeuBmX33zqwn45tpZnyw8QJzp6ASpPfJeMa6tHGEQA8z9hFtSrpbGTO9fGxW8QQapHyM1Rwz4YU4TO/jLO7fyY73dyS7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 329CD66FC44
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:33 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EF52C42B55F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 488EE42B50F;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 950a2536;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:04 +0200
Subject: [PATCH net-next v4 04/11] net: fec: sort the includes by
 alphabetic order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-4-c16f9a1af124@pengutronix.de>
References: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
In-Reply-To: <20250618-fec-cleanups-v4-0-c16f9a1af124@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, bpf@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=VYJMovtGxdXZkHpWqywTu3uAJHSI58Pp1fUIXcI9pgw=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpKv55JNsh2H9F4WAzaA5+/vQfJC1Zv+Fw4U
 sFpmuUoomeJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqSgAKCRAMdGXf+ZCR
 nJj/B/9toLY5u7rFfv4LwgM9yTMa8J2CBVOo8eNXWYnuFFY1EKhLs66QhzuqxxAazM361yL0c4R
 xygMznzya02W7i8HwSiAYu3M0Qp/eHr4pEGANV3m0i88j1esisDdtIWlQ9QHT0B6rvU0m7ZMRFU
 UwzNSR/o6ZFKP9Ho8ER73CDnM1DmMhWlZmKe3TViDfcMySbIVoRpwYW91ng/+H+hCDEIWLzj0Qo
 YA+LvMGGiL62/dPk1cnfdIil5vK5amCFRQtowZD1e/X1bDadY8SUu/Hbb3COYHB1279JVbUSY8m
 QESE4BUTrdCa0KtfVvxSezMYNdqXrZe+8qKwfECOWk/vGFnO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This is a preparation patch to make addition of new includes easier
without breaking the alphabetic order.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h      |  6 +--
 drivers/net/ethernet/freescale/fec_main.c | 80 +++++++++++++++----------------
 drivers/net/ethernet/freescale/fec_ptp.c  | 38 +++++++--------
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ce1e4fe4d492..5c8fdcef759b 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -14,14 +14,14 @@
 #define	FEC_H
 /****************************************************************************/
 
+#include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/bpf.h>
 #include <linux/clocksource.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/net_tstamp.h>
 #include <linux/pm_qos.h>
-#include <linux/bpf.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
-#include <dt-bindings/firmware/imx/rsrc.h>
-#include <linux/firmware/imx/sci.h>
 #include <net/xdp.h>
 
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index dbfc191bcde1..3b1a4506caa6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -22,55 +22,55 @@
  * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/pm_runtime.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
+#include <linux/bitops.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
+#include <linux/cacheflush.h>
+#include <linux/clk.h>
+#include <linux/crc32.h>
 #include <linux/delay.h>
-#include <linux/netdevice.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
-#include <linux/skbuff.h>
+#include <linux/fec.h>
+#include <linux/filter.h>
+#include <linux/gpio/consumer.h>
+#include <linux/icmp.h>
+#include <linux/if_vlan.h>
 #include <linux/in.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/ip.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mdio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/prefetch.h>
+#include <linux/property.h>
+#include <linux/ptrace.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
-#include <linux/tcp.h>
-#include <linux/udp.h>
-#include <linux/icmp.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
-#include <linux/bitops.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/cacheflush.h>
-#include <linux/clk.h>
-#include <linux/crc32.h>
-#include <linux/platform_device.h>
-#include <linux/property.h>
-#include <linux/mdio.h>
-#include <linux/phy.h>
-#include <linux/fec.h>
-#include <linux/of.h>
-#include <linux/of_mdio.h>
-#include <linux/of_net.h>
-#include <linux/regulator/consumer.h>
-#include <linux/if_vlan.h>
-#include <linux/pinctrl/consumer.h>
-#include <linux/gpio/consumer.h>
-#include <linux/prefetch.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <soc/imx/cpuidle.h>
-#include <linux/filter.h>
-#include <linux/bpf.h>
-#include <linux/bpf_trace.h>
 
 #include "fec.h"
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index d6d9f0d6ca99..afe162c9eed8 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -7,30 +7,30 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
 #include <linux/bitops.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/phy.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
 #include <linux/fec.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
+#include <linux/pci.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/ptrace.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "fec.h"
 

-- 
2.47.2



