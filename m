Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344B451A3AC
	for <lists+bpf@lfdr.de>; Wed,  4 May 2022 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352240AbiEDPXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 May 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352162AbiEDPXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 May 2022 11:23:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E8D443E8;
        Wed,  4 May 2022 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651677569; x=1683213569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwpY0QqOSAbtY9VHcl/I4EdlwTY/X8eSY0+d5A5CThs=;
  b=iUHVansTbb1Am5DQkgV8kBITsFfArBT5Fe8fxn3gkolYw17D5DVfznPk
   Lgc8PjvgqBG4oeNGmgIugEyisEIm3D5jgh7da1t2n/Eury+miWoYD+TWL
   oKfcz3SmTXKCJEmdTejXRdxqeIKxy/hnDccVpGYi5fQU15dR0/X5SwUkB
   Ry7fSv8alvqZNLIOZA0wH2kcJClbPJOK47ScQH3z4OgpQvxUVennH0JMz
   yi6TYukzNHOyl4GW7c8ldrOekLWR7rk9+/EwQoeneJDy3ZqOwMOnJvSie
   ziyhJNkOUVLdJb30GnsBFtUZ6eZvBoFDBrdgCjKZXLDtaHUO+xHEKSfGI
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="162308996"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 May 2022 08:19:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 4 May 2022 08:19:26 -0700
Received: from CHE-LT-I17769U.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 4 May 2022 08:19:12 -0700
From:   Arun Ramadoss <arun.ramadoss@microchip.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        "Martin KaFai Lau" <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Vladimir Oltean" <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [Patch net-next v13 04/13] net: dsa: tag_ksz: add tag handling for Microchip LAN937x
Date:   Wed, 4 May 2022 20:47:46 +0530
Message-ID: <20220504151755.11737-5-arun.ramadoss@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220504151755.11737-1-arun.ramadoss@microchip.com>
References: <20220504151755.11737-1-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Prasanna Vengateshan <prasanna.vengateshan@microchip.com>

The Microchip LAN937X switches have a tagging protocol which is
very similar to KSZ tagging. So that the implementation is added to
tag_ksz.c and reused common APIs

Signed-off-by: Prasanna Vengateshan <prasanna.vengateshan@microchip.com>
Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/Kconfig   |  4 ++--
 net/dsa/tag_ksz.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 934958fda962..e19da7c00ba0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -53,6 +53,7 @@ struct phylink_link_state;
 #define DSA_TAG_PROTO_SJA1110_VALUE		23
 #define DSA_TAG_PROTO_RTL8_4_VALUE		24
 #define DSA_TAG_PROTO_RTL8_4T_VALUE		25
+#define DSA_TAG_PROTO_LAN937X_VALUE		26
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -81,6 +82,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_SJA1110		= DSA_TAG_PROTO_SJA1110_VALUE,
 	DSA_TAG_PROTO_RTL8_4		= DSA_TAG_PROTO_RTL8_4_VALUE,
 	DSA_TAG_PROTO_RTL8_4T		= DSA_TAG_PROTO_RTL8_4T_VALUE,
+	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 8cb87b5067ee..6d0414c9f7f4 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -87,10 +87,10 @@ config NET_DSA_TAG_MTK
 	  Mediatek switches.
 
 config NET_DSA_TAG_KSZ
-	tristate "Tag driver for Microchip 8795/9477/9893 families of switches"
+	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
 	  Say Y if you want to enable support for tagging frames for the
-	  Microchip 8795/9477/9893 families of switches.
+	  Microchip 8795/937x/9477/9893 families of switches.
 
 config NET_DSA_TAG_OCELOT
 	tristate "Tag driver for Ocelot family of switches, using NPI port"
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 3509fc967ca9..38fa19c1e2d5 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -193,10 +193,69 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
 DSA_TAG_DRIVER(ksz9893_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893);
 
+/* For xmit, 2 bytes are added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|tag1(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag0 : represents tag override, lookup and valid
+ * tag1 : each bit represents port (eg, 0x01=port1, 0x02=port2, 0x80=port8)
+ *
+ * For rcv, 1 byte is added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag0 : zero-based value represents port
+ *	  (eg, 0x00=port1, 0x02=port3, 0x07=port8)
+ */
+#define LAN937X_EGRESS_TAG_LEN		2
+
+#define LAN937X_TAIL_TAG_BLOCKING_OVERRIDE	BIT(11)
+#define LAN937X_TAIL_TAG_LOOKUP			BIT(12)
+#define LAN937X_TAIL_TAG_VALID			BIT(13)
+#define LAN937X_TAIL_TAG_PORT_MASK		7
+
+static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	const struct ethhdr *hdr = eth_hdr(skb);
+	__be16 *tag;
+	u16 val;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+		return NULL;
+
+	tag = skb_put(skb, LAN937X_EGRESS_TAG_LEN);
+
+	val = BIT(dp->index);
+
+	if (is_link_local_ether_addr(hdr->h_dest))
+		val |= LAN937X_TAIL_TAG_BLOCKING_OVERRIDE;
+
+	/* Tail tag valid bit - This bit should always be set by the CPU */
+	val |= LAN937X_TAIL_TAG_VALID;
+
+	put_unaligned_be16(val, tag);
+
+	return skb;
+}
+
+static const struct dsa_device_ops lan937x_netdev_ops = {
+	.name	= "lan937x",
+	.proto	= DSA_TAG_PROTO_LAN937X,
+	.xmit	= lan937x_xmit,
+	.rcv	= ksz9477_rcv,
+	.needed_tailroom = LAN937X_EGRESS_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(lan937x_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_LAN937X);
+
 static struct dsa_tag_driver *dsa_tag_driver_array[] = {
 	&DSA_TAG_DRIVER_NAME(ksz8795_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),
+	&DSA_TAG_DRIVER_NAME(lan937x_netdev_ops),
 };
 
 module_dsa_tag_drivers(dsa_tag_driver_array);
-- 
2.33.0

