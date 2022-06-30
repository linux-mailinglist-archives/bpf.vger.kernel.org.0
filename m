Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1605617B1
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiF3KW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiF3KWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 06:22:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F79457A8;
        Thu, 30 Jun 2022 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656584551; x=1688120551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3p1haOctquxewPlqf+5TUBaW2f+6nbsODmUnBqHiBj8=;
  b=czvmURcH2n4bMfcMUGETEp+7YBFfWI7zaPsBP2v5Ohn1mqL23XrsCtrt
   We8sAmpN9OgkccNACm31apncjpV8Y8ikVpH+oTiSDkMrttId6tYWVEHkT
   wWUNfyyi7blesgQBip+u7/s5RD0AqdsSOAqh43s7ZJT5Km9gHMnbzhHeq
   Mgv1CxQnPIa5hPr868xI2xgT2NlK7UQlO5kG/eYehOkkFKNUKn9pzhYJ9
   22QXJiRUJdvcmmLIcM3EE1/wo3F1LF+fp+y0ExcnKLEwa14FU8Z69T6Oy
   AjeyUTXTm80tccdwvdpKu7u5yIqVOrBqSBUa/ABBJ2WfZOGPpzPU7V61g
   g==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="180172499"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 03:22:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 03:22:23 -0700
Received: from CHE-LT-I17769U.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 03:22:15 -0700
From:   Arun Ramadoss <arun.ramadoss@microchip.com>
To:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Woojung Huh <woojung.huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        "Song Liu" <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [Patch net-next v14 06/13] net: dsa: microchip: lan937x: add dsa_tag_protocol
Date:   Thu, 30 Jun 2022 15:50:34 +0530
Message-ID: <20220630102041.25555-7-arun.ramadoss@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630102041.25555-1-arun.ramadoss@microchip.com>
References: <20220630102041.25555-1-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch update the ksz_get_tag_protocol to return LAN937x specific
tag if the chip id matches one of LAN937x series switch

Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 3 +++
 drivers/net/dsa/microchip/ksz_common.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 83e44598d00c..07b6f34a437e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1254,6 +1254,9 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	    dev->chip_id == KSZ9567_CHIP_ID)
 		proto = DSA_TAG_PROTO_KSZ9477;
 
+	if (is_lan937x(dev))
+		proto = DSA_TAG_PROTO_LAN937X_VALUE;
+
 	return proto;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f69dc872752..bf4f3f3922a5 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -403,6 +403,15 @@ static inline void ksz_regmap_unlock(void *__mtx)
 	mutex_unlock(mtx);
 }
 
+static inline int is_lan937x(struct ksz_device *dev)
+{
+	return dev->chip_id == LAN9370_CHIP_ID ||
+		dev->chip_id == LAN9371_CHIP_ID ||
+		dev->chip_id == LAN9372_CHIP_ID ||
+		dev->chip_id == LAN9373_CHIP_ID ||
+		dev->chip_id == LAN9374_CHIP_ID;
+}
+
 /* STP State Defines */
 #define PORT_TX_ENABLE			BIT(2)
 #define PORT_RX_ENABLE			BIT(1)
-- 
2.36.1

