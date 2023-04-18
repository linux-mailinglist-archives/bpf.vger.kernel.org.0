Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B236E6C99
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjDRTFN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjDRTFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 15:05:12 -0400
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC38E;
        Tue, 18 Apr 2023 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WXholCdDSFyDOnnZacgpwkrBGQRbCLY+pt3CFNncoBs=; b=w0MZYuuviijtTLZw/4D+tbIUei
        o16gjVRDr9fC1az/HUXpyEp7gxsX9hMiQvRxth1szwvbvSCtBQCuyqT/JuZuPGdvxu5kVgJAlb0RX
        rAfmD4ggyB2qhqSsGIlxeY5FpCjboLESoy2nal8WFD6tv3+OR43kAo15K4J7d03x40Gg=;
Received: from 88-117-57-231.adsl.highway.telekom.at ([88.117.57.231] helo=hornet.engleder.at)
        by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gerhard@engleder-embedded.com>)
        id 1poqdY-0002eV-0G; Tue, 18 Apr 2023 21:05:08 +0200
From:   Gerhard Engleder <gerhard@engleder-embedded.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next v3 4/6] tsnep: Move skb receive action to separate function
Date:   Tue, 18 Apr 2023 21:04:57 +0200
Message-Id: <20230418190459.19326-5-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418190459.19326-1-gerhard@engleder-embedded.com>
References: <20230418190459.19326-1-gerhard@engleder-embedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function tsnep_rx_poll() is already pretty long and the skb receive
action can be reused for XSK zero-copy support. Move page based skb
receive to separate function.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 39 +++++++++++++---------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 039629af6a43..2db94b96a1f0 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1076,6 +1076,28 @@ static struct sk_buff *tsnep_build_skb(struct tsnep_rx *rx, struct page *page,
 	return skb;
 }
 
+static void tsnep_rx_page(struct tsnep_rx *rx, struct napi_struct *napi,
+			  struct page *page, int length)
+{
+	struct sk_buff *skb;
+
+	skb = tsnep_build_skb(rx, page, length);
+	if (skb) {
+		page_pool_release_page(rx->page_pool, page);
+
+		rx->packets++;
+		rx->bytes += length;
+		if (skb->pkt_type == PACKET_MULTICAST)
+			rx->multicast++;
+
+		napi_gro_receive(napi, skb);
+	} else {
+		page_pool_recycle_direct(rx->page_pool, page);
+
+		rx->dropped++;
+	}
+}
+
 static int tsnep_rx_poll(struct tsnep_rx *rx, struct napi_struct *napi,
 			 int budget)
 {
@@ -1085,7 +1107,6 @@ static int tsnep_rx_poll(struct tsnep_rx *rx, struct napi_struct *napi,
 	struct netdev_queue *tx_nq;
 	struct bpf_prog *prog;
 	struct xdp_buff xdp;
-	struct sk_buff *skb;
 	struct tsnep_tx *tx;
 	int desc_available;
 	int xdp_status = 0;
@@ -1170,21 +1191,7 @@ static int tsnep_rx_poll(struct tsnep_rx *rx, struct napi_struct *napi,
 			}
 		}
 
-		skb = tsnep_build_skb(rx, entry->page, length);
-		if (skb) {
-			page_pool_release_page(rx->page_pool, entry->page);
-
-			rx->packets++;
-			rx->bytes += length;
-			if (skb->pkt_type == PACKET_MULTICAST)
-				rx->multicast++;
-
-			napi_gro_receive(napi, skb);
-		} else {
-			page_pool_recycle_direct(rx->page_pool, entry->page);
-
-			rx->dropped++;
-		}
+		tsnep_rx_page(rx, napi, entry->page, length);
 		entry->page = NULL;
 	}
 
-- 
2.30.2

