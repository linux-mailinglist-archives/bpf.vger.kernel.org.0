Return-Path: <bpf+bounces-60907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2EBADEB1B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15D73A21F1
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C128DF20;
	Wed, 18 Jun 2025 12:00:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88AA288C29
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248036; cv=none; b=X58OlvI7N9xzpF5mtSGUPM1tHA89DxPQCS+KJcW6HFLASkR4SUvwTPGAeGV0Fq5pBKfQa4SwL7teoV8fcT/YBEGRT9W5vyExPmtGdBF5FNJTJeAnP89C5waSR26JCY4xa/k3zJPDi8luhMBWHd0I7KYRn7FfrhpXXi3hLt+Q4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248036; c=relaxed/simple;
	bh=2iqO7eQNAV+YgDrv6QeqkeUmG4rDnaxv9v7CVkxZzwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHFXAiyyJJbL3asahnRjvTrxmB7aGhyzK+sf2NrO0wp6O4+DIQWvFbYyRVfNZDSAOYSUyajPSIrbl4iJN6qRm8UwKMLYQQ1EWcjoELS3FCYEkWdWTNm51+tGIWMQIVzd0qH3ZdkUTi1kozuXd/Fg4A2GkOQEEPmVWhYSmT4Zbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:d189:60c:9a01:7dca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id E9A2066FC40
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:32 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B277342B559
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 12:00:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 29EEB42B50D;
	Wed, 18 Jun 2025 12:00:29 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 560da31b;
	Wed, 18 Jun 2025 12:00:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Jun 2025 14:00:03 +0200
Subject: [PATCH net-next v4 03/11] net: fec: switch from asm/cacheflush.h
 to linux/cacheflush.h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-fec-cleanups-v4-3-c16f9a1af124@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=2iqO7eQNAV+YgDrv6QeqkeUmG4rDnaxv9v7CVkxZzwk=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUqpIOh+pePAfrUw9h11M1LbpjtWPktc4wOq4A
 eYyf2THEs+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFKqSAAKCRAMdGXf+ZCR
 nCVWB/0RELPYGv01SjxvDftWfmQ9L9dLEyHXry0UNyxoHcG9pWCxLMD5GUyHw/bewdnSLMlAd4q
 Jr6Obc8ClsM4S0JBc5LPvR4Zx8i8OPPvl+vIpKjpyLvk5gnny61k0M7pPNZgFi9s7Co8IZf7RN9
 eekfj0AkzClDDERXhKbO+vQCvHpcTkOjNJgUdWTa+tMEbpNRLE0yj3PQIOdaLc30GkCAJpuY9Jz
 RYubuwtKmOit3B98Ybe1FTnCN3encL8lwTziXIo/r+bcAqdfkZaiXBLKhNv68bg5RVJACtkFGhm
 lQj6efYOgI9WW2h4b6AGvlE+qPyOt8wnh9xXko96/C1juOXP
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To fix the checkpatch warning, use linux/cacheflush.h instead of
asm/cacheflush.h.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 17e9bddb9ddd..dbfc191bcde1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -49,6 +49,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/cacheflush.h>
 #include <linux/clk.h>
 #include <linux/crc32.h>
 #include <linux/platform_device.h>
@@ -71,8 +72,6 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 
-#include <asm/cacheflush.h>
-
 #include "fec.h"
 
 static void set_multicast_list(struct net_device *ndev);

-- 
2.47.2



