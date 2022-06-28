Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE955E9DC
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiF1QfB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiF1QeF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B2C52A42F
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cwk6GCxz2fKCIof6GdQC9jP34T0np9Gb9y3RuN9eduo=;
        b=ct4g6kt9opjt06j7+DMVHiVs7DarAtXEJPwFCJ+Kb/NdPucQGs7ptZ3X4hKTSMW9KFJQtC
        8RqQVsge55gGPR5YJ218ElHlTdCv/2vDMK/t/NC6UFo4NOv+7GQzTalCEKTLbnkzGgnx/u
        RUta41R6DfhsL4KxJumsZkbnKIHW8gg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-aLlBZah8OY6uOwD93nEA7g-1; Tue, 28 Jun 2022 12:30:55 -0400
X-MC-Unique: aLlBZah8OY6uOwD93nEA7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5A03101A586;
        Tue, 28 Jun 2022 16:30:54 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 859FF1121314;
        Tue, 28 Jun 2022 16:30:54 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id CD15730736C72;
        Tue, 28 Jun 2022 18:30:53 +0200 (CEST)
Subject: [PATCH RFC bpf-next 4/9] net: add net_device feature flag for
 XDP-hints
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:30:53 +0200
Message-ID: <165643385380.449467.7315334434679035377.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make it possible to turnoff XDP-hints for a given net_device.

It is recommended that drivers default turn on XDP-hints as the
overhead is generally low, extracting these hardware hints, and the
benefit is usually higher than this small overhead e.g. getting HW to
do RX checksumming are usually a higher gain.

Some XDP use-case are not ready to take this small overhead. Thus, the
possibility to turn off XDP-hints is need to keep performance of these
use-cases intact.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/linux/netdev_features.h |    3 ++-
 net/ethtool/common.c            |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..713f04eab497 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
+	NETIF_F_XDP_HINTS_BIT,		/* Populates XDP-hints metadata */
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
@@ -168,6 +168,7 @@ enum {
 #define NETIF_F_HW_HSR_TAG_RM	__NETIF_F(HW_HSR_TAG_RM)
 #define NETIF_F_HW_HSR_FWD	__NETIF_F(HW_HSR_FWD)
 #define NETIF_F_HW_HSR_DUP	__NETIF_F(HW_HSR_DUP)
+#define NETIF_F_XDP_HINTS	__NETIF_F(XDP_HINTS)
 
 /* Finds the next feature with the highest number of the range of start-1 till 0.
  */
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 566adf85e658..a9c62482220f 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -11,6 +11,7 @@
 const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_SG_BIT] =               "tx-scatter-gather",
 	[NETIF_F_IP_CSUM_BIT] =          "tx-checksum-ipv4",
+	[NETIF_F_XDP_HINTS_BIT] =        "xdp-hints",
 	[NETIF_F_HW_CSUM_BIT] =          "tx-checksum-ip-generic",
 	[NETIF_F_IPV6_CSUM_BIT] =        "tx-checksum-ipv6",
 	[NETIF_F_HIGHDMA_BIT] =          "highdma",


