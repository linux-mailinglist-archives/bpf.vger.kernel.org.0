Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E755E9E0
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiF1QfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiF1Qea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39DB32C120
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656433882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVhjnFy1p4yXXxHSIbHIAdGS4VuHqSqKY57qMTPzco4=;
        b=dObPZMOLwOMAyFvkZPjiw1LOEyqX/hpRmiUImiDw+nMmEDxtuTW6IriTneWt5ECNgcARML
        LhYbCGqWPoDPVHtMFf2sNcA8UYlOjj15go3B01tavKLNTOUuO54ZuM+420Qy9sAwrj7afF
        YnE6aABr0WmQFE4nl/raBH5S1biuq/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-sGnRsmI9PH2hbPVnVXIyeA-1; Tue, 28 Jun 2022 12:31:20 -0400
X-MC-Unique: sGnRsmI9PH2hbPVnVXIyeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D2CD38149B4;
        Tue, 28 Jun 2022 16:31:20 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19E9A1678F;
        Tue, 28 Jun 2022 16:31:20 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 1A7E630736C72;
        Tue, 28 Jun 2022 18:31:19 +0200 (CEST)
Subject: [PATCH RFC bpf-next 9/9] mvneta: add XDP-hints support
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue, 28 Jun 2022 18:31:19 +0200
Message-ID: <165643387907.449467.15379243921107938760.stgit@firesoul>
In-Reply-To: <165643378969.449467.13237011812569188299.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Similar to i40e driver, add xdp hw-hints support for mvneta driver in
order to report rx csum offload for xdp_redirect.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/marvell/mvneta.c |   61 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 384f5a16753d..4f73ba905741 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -40,6 +40,7 @@
 #include <net/page_pool.h>
 #include <net/pkt_cls.h>
 #include <linux/bpf_trace.h>
+#include <linux/btf.h>
 
 /* Registers */
 #define MVNETA_RXQ_CONFIG_REG(q)                (0x1400 + ((q) << 2))
@@ -371,6 +372,9 @@
 #define MVNETA_RX_GET_BM_POOL_ID(rxd) \
 	(((rxd)->status & MVNETA_RXD_BM_POOL_MASK) >> MVNETA_RXD_BM_POOL_SHIFT)
 
+static struct btf *mvneta_btf;
+static s32 btf_id_xdp_hints;
+
 enum {
 	ETHTOOL_STAT_EEE_WAKEUP,
 	ETHTOOL_STAT_SKB_ALLOC_ERR,
@@ -2308,12 +2312,15 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 		     struct mvneta_rx_desc *rx_desc,
 		     struct mvneta_rx_queue *rxq,
 		     struct xdp_buff *xdp, int *size,
-		     struct page *page)
+		     struct page *page, u32 status)
 {
 	unsigned char *data = page_address(page);
 	int data_len = -MVNETA_MH_SIZE, len;
+	struct xdp_hints_common *xdp_hints;
 	struct net_device *dev = pp->dev;
 	enum dma_data_direction dma_dir;
+	u32 xdp_hints_flags;
+	u16 cksum;
 
 	if (*size > MVNETA_MAX_RX_BUF_SIZE) {
 		len = MVNETA_MAX_RX_BUF_SIZE;
@@ -2336,6 +2343,18 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	xdp_buff_clear_frags_flag(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
 			 data_len, false);
+
+	if (!(pp->dev->features & NETIF_F_XDP_HINTS))
+		return;
+
+	xdp_hints = xdp->data - sizeof(*xdp_hints);
+	cksum = mvneta_rx_csum(pp, status);
+	xdp_hints_flags = xdp_hints_set_rx_csum(xdp_hints, cksum, 0);
+	xdp_hints_set_flags(xdp_hints, xdp_hints_flags);
+	xdp_hints->btf_id = btf_id_xdp_hints;
+	xdp->data_meta = xdp->data - sizeof(*xdp_hints);
+
+	xdp_buff_set_hints(xdp, BTF_ORIGIN_VMLINUX, true);
 }
 
 static void
@@ -2385,9 +2404,24 @@ mvneta_swbm_add_rx_fragment(struct mvneta_port *pp,
 	*size -= len;
 }
 
+static void
+mvneta_set_skb_cksum_from_xdp(struct xdp_buff *xdp, struct sk_buff *skb)
+{
+	struct xdp_hints_common *xdp_hints;
+
+	if (!(xdp_buff_has_hints_compat(xdp)))
+		return;
+
+	if (xdp->data - xdp->data_meta < sizeof(*xdp_hints))
+		return;
+
+	xdp_hints = xdp->data - sizeof(*xdp_hints);
+	skb->ip_summed = xdp_hints->xdp_hints_flags & HINT_FLAG_CSUM_TYPE_MASK;
+}
+
 static struct sk_buff *
 mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
-		      struct xdp_buff *xdp, u32 desc_status)
+		      struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 	struct sk_buff *skb;
@@ -2404,7 +2438,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
-	skb->ip_summed = mvneta_rx_csum(pp, desc_status);
+	mvneta_set_skb_cksum_from_xdp(xdp, skb);
 
 	if (unlikely(xdp_buff_has_frags(xdp)))
 		xdp_update_skb_shared_info(skb, num_frags,
@@ -2424,8 +2458,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 	struct net_device *dev = pp->dev;
 	struct mvneta_stats ps = {};
 	struct bpf_prog *xdp_prog;
-	u32 desc_status, frame_sz;
 	struct xdp_buff xdp_buf;
+	u32 frame_sz;
 
 	xdp_init_buff(&xdp_buf, PAGE_SIZE, &rxq->xdp_rxq);
 	xdp_buf.data_hard_start = NULL;
@@ -2458,10 +2492,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 
 			size = rx_desc->data_size;
 			frame_sz = size - ETH_FCS_LEN;
-			desc_status = rx_status;
-
 			mvneta_swbm_rx_frame(pp, rx_desc, rxq, &xdp_buf,
-					     &size, page);
+					     &size, page, rx_status);
 		} else {
 			if (unlikely(!xdp_buf.data_hard_start)) {
 				rx_desc->buf_phys_addr = 0;
@@ -2487,7 +2519,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		    mvneta_run_xdp(pp, rxq, xdp_prog, &xdp_buf, frame_sz, &ps))
 			goto next;
 
-		skb = mvneta_swbm_build_skb(pp, rxq->page_pool, &xdp_buf, desc_status);
+		skb = mvneta_swbm_build_skb(pp, rxq->page_pool, &xdp_buf);
 		if (IS_ERR(skb)) {
 			struct mvneta_pcpu_stats *stats = this_cpu_ptr(pp->stats);
 
@@ -5613,7 +5645,7 @@ static int mvneta_probe(struct platform_device *pdev)
 	}
 
 	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
-			NETIF_F_TSO | NETIF_F_RXCSUM;
+			NETIF_F_TSO | NETIF_F_RXCSUM | NETIF_F_XDP_HINTS;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -5817,6 +5849,16 @@ static int __init mvneta_driver_init(void)
 {
 	int ret;
 
+	mvneta_btf = btf_get_module_btf(THIS_MODULE);
+	if (mvneta_btf) {
+		btf_id_xdp_hints = btf_find_by_name_kind(mvneta_btf,
+							 "xdp_hints_common",
+							 BTF_KIND_STRUCT);
+		if (btf_id_xdp_hints < 0)
+			pr_warn("%s: BTF cannot find struct xdp_hints_common",
+				MVNETA_DRIVER_NAME);
+	}
+
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "net/mvneta:online",
 				      mvneta_cpu_online,
 				      mvneta_cpu_down_prepare);
@@ -5844,6 +5886,7 @@ module_init(mvneta_driver_init);
 
 static void __exit mvneta_driver_exit(void)
 {
+	btf_put_module_btf(mvneta_btf);
 	platform_driver_unregister(&mvneta_driver);
 	cpuhp_remove_multi_state(CPUHP_NET_MVNETA_DEAD);
 	cpuhp_remove_multi_state(online_hpstate);


