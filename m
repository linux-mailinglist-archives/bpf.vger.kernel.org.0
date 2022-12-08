Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF336468A5
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 06:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLHFlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 00:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHFlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 00:41:09 -0500
Received: from mx02lb.world4you.com (mx02lb.world4you.com [81.19.149.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5A81392;
        Wed,  7 Dec 2022 21:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qBiNkycqJaZVMSfXgU/O6KmyYN7BmV7kqdW0xUnelh4=; b=AE612lPih2e7up1ehshko8cFce
        EvCXaIza8a4hhQ9xma/q3gFri4XDoWvVrRzLgb3aNmJpPZvCSB31q4+BAcHhdPCOXIPESmV93kXPN
        rVsnuy6rIp90NASx7g5odjnk7d5Skphe520PR/L7tVoqXBKF0XOOVF1NEJOUKUB7gFK8=;
Received: from 88-117-56-227.adsl.highway.telekom.at ([88.117.56.227] helo=hornet.engleder.at)
        by mx02lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gerhard@engleder-embedded.com>)
        id 1p39ec-0002ut-BU; Thu, 08 Dec 2022 06:41:06 +0100
From:   Gerhard Engleder <gerhard@engleder-embedded.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v2 1/6] tsnep: Add adapter down state
Date:   Thu,  8 Dec 2022 06:40:40 +0100
Message-Id: <20221208054045.3600-2-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221208054045.3600-1-gerhard@engleder-embedded.com>
References: <20221208054045.3600-1-gerhard@engleder-embedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add adapter state with flag for down state. This flag will be used by
the XDP TX path to deny TX if adapter is down.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep.h      |  1 +
 drivers/net/ethernet/engleder/tsnep_main.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index f93ba48bac3f..f72c0c4da1a9 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -148,6 +148,7 @@ struct tsnep_adapter {
 	phy_interface_t phy_mode;
 	struct phy_device *phydev;
 	int msg_enable;
+	unsigned long state;
 
 	struct platform_device *pdev;
 	struct device *dmadev;
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index bf0190e1d2ea..a28fde9fb060 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -43,6 +43,10 @@
 #define TSNEP_COALESCE_USECS_MAX     ((ECM_INT_DELAY_MASK >> ECM_INT_DELAY_SHIFT) * \
 				      ECM_INT_DELAY_BASE_US + ECM_INT_DELAY_BASE_US - 1)
 
+enum {
+	__TSNEP_DOWN,
+};
+
 static void tsnep_enable_irq(struct tsnep_adapter *adapter, u32 mask)
 {
 	iowrite32(mask, adapter->addr + ECM_INT_ENABLE);
@@ -1143,6 +1147,8 @@ static int tsnep_netdev_open(struct net_device *netdev)
 		tsnep_enable_irq(adapter, adapter->queue[i].irq_mask);
 	}
 
+	clear_bit(__TSNEP_DOWN, &adapter->state);
+
 	return 0;
 
 phy_failed:
@@ -1165,6 +1171,8 @@ static int tsnep_netdev_close(struct net_device *netdev)
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 	int i;
 
+	set_bit(__TSNEP_DOWN, &adapter->state);
+
 	tsnep_disable_irq(adapter, ECM_INT_LINK);
 	tsnep_phy_close(adapter);
 
@@ -1518,6 +1526,7 @@ static int tsnep_probe(struct platform_device *pdev)
 	adapter->msg_enable = NETIF_MSG_DRV | NETIF_MSG_PROBE |
 			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
+	set_bit(__TSNEP_DOWN, &adapter->state);
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = TSNEP_MAX_FRAME_SIZE;
@@ -1614,6 +1623,8 @@ static int tsnep_remove(struct platform_device *pdev)
 {
 	struct tsnep_adapter *adapter = platform_get_drvdata(pdev);
 
+	set_bit(__TSNEP_DOWN, &adapter->state);
+
 	unregister_netdev(adapter->netdev);
 
 	tsnep_rxnfc_cleanup(adapter);
-- 
2.30.2

