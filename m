Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFAC188C0C
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 18:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCQR36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 13:29:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53460 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgCQR35 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Mar 2020 13:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584466196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8ADgiXCNrjUwtxx6VSppVeHIxTSGzYqm7aWz4SrIA0=;
        b=BT4fanIL02AWmoziPxMAID/TStz+lSvSxyEaUdwvs5n0wMyHjDacmFTX6MJ/4Ot6MWEhLj
        lVo2xxaMZfXjPYGKgu5eMgYcrrNo9zl/ug2A28S14HxHprYkQpyI5nKb8o4aAs0+oceV6o
        LreeCqWRE/ra019KK5YVJMakHr4jpYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-mgRM24zENyqrL7KKCXJgIw-1; Tue, 17 Mar 2020 13:29:52 -0400
X-MC-Unique: mgRM24zENyqrL7KKCXJgIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C349CDB23;
        Tue, 17 Mar 2020 17:29:39 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3657260BEE;
        Tue, 17 Mar 2020 17:29:39 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 3B73D30721A66;
        Tue, 17 Mar 2020 18:29:38 +0100 (CET)
Subject: [PATCH RFC v1 06/15] sfc: fix XDP-redirect in this driver
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, zorik@amazon.com, akiyano@amazon.com,
        gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue, 17 Mar 2020 18:29:38 +0100
Message-ID: <158446617817.702578.15401678499421072150.stgit@firesoul>
In-Reply-To: <158446612466.702578.2795159620575737080.stgit@firesoul>
References: <158446612466.702578.2795159620575737080.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

TODO: Drop as already accepted in net-next as
 commit 86e85bf6981c ("sfc: fix XDP-redirect in this driver")

XDP-redirect is broken in this driver sfc. XDP_REDIRECT requires
tailroom for skb_shared_info when creating an SKB based on the
redirected xdp_frame (both in cpumap and veth).

The fix requires some initial explaining. The driver uses RX page-split
when possible. It reserves the top 64 bytes in the RX-page for storing
dma_addr (struct efx_rx_page_state). It also have the XDP recommended
headroom of XDP_PACKET_HEADROOM (256 bytes). As it doesn't reserve any
tailroom, it can still fit two standard MTU (1500) frames into one page.

The sizeof struct skb_shared_info in 320 bytes. Thus drivers like ixgbe
and i40e, reduce their XDP headroom to 192 bytes, which allows them to
fit two frames with max 1536 bytes into a 4K page (192+1536+320=2048).

The fix is to reduce this drivers headroom to 128 bytes and add the 320
bytes tailroom. This account for reserved top 64 bytes in the page, and
still fit two frame in a page for normal MTUs.

We must never go below 128 bytes of headroom for XDP, as one cacheline
is for xdp_frame area and next cacheline is reserved for metadata area.

Fixes: eb9a36be7f3e ("sfc: perform XDP processing on received packets")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/sfc/efx_common.c |    9 +++++----
 drivers/net/ethernet/sfc/net_driver.h |    6 ++++++
 drivers/net/ethernet/sfc/rx.c         |    2 +-
 drivers/net/ethernet/sfc/rx_common.c  |    6 +++---
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index b0d76bc19673..1799ff9a45d9 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -200,11 +200,11 @@ void efx_link_status_changed(struct efx_nic *efx)
 unsigned int efx_xdp_max_mtu(struct efx_nic *efx)
 {
 	/* The maximum MTU that we can fit in a single page, allowing for
-	 * framing, overhead and XDP headroom.
+	 * framing, overhead and XDP headroom + tailroom.
 	 */
 	int overhead = EFX_MAX_FRAME_LEN(0) + sizeof(struct efx_rx_page_state) +
 		       efx->rx_prefix_size + efx->type->rx_buffer_padding +
-		       efx->rx_ip_align + XDP_PACKET_HEADROOM;
+		       efx->rx_ip_align + EFX_XDP_HEADROOM + EFX_XDP_TAILROOM;
 
 	return PAGE_SIZE - overhead;
 }
@@ -302,8 +302,9 @@ static void efx_start_datapath(struct efx_nic *efx)
 	efx->rx_dma_len = (efx->rx_prefix_size +
 			   EFX_MAX_FRAME_LEN(efx->net_dev->mtu) +
 			   efx->type->rx_buffer_padding);
-	rx_buf_len = (sizeof(struct efx_rx_page_state) + XDP_PACKET_HEADROOM +
-		      efx->rx_ip_align + efx->rx_dma_len);
+	rx_buf_len = (sizeof(struct efx_rx_page_state)   + EFX_XDP_HEADROOM +
+		      efx->rx_ip_align + efx->rx_dma_len + EFX_XDP_TAILROOM);
+
 	if (rx_buf_len <= PAGE_SIZE) {
 		efx->rx_scatter = efx->type->always_rx_scatter;
 		efx->rx_buffer_order = 0;
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 9f9886f222c8..f96b1f9fe119 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -91,6 +91,12 @@
 #define EFX_RX_BUF_ALIGNMENT	4
 #endif
 
+/* Non-standard XDP_PACKET_HEADROOM and tailroom to satisfy XDP_REDIRECT and
+ * still fit two standard MTU size packets into a single 4K page.
+ */
+#define EFX_XDP_HEADROOM	128
+#define EFX_XDP_TAILROOM	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+
 /* Forward declare Precision Time Protocol (PTP) support structure. */
 struct efx_ptp_data;
 struct hwtstamp_config;
diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
index a2042f16babc..260352d97d9d 100644
--- a/drivers/net/ethernet/sfc/rx.c
+++ b/drivers/net/ethernet/sfc/rx.c
@@ -302,7 +302,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
 	       efx->rx_prefix_size);
 
 	xdp.data = *ehp;
-	xdp.data_hard_start = xdp.data - XDP_PACKET_HEADROOM;
+	xdp.data_hard_start = xdp.data - EFX_XDP_HEADROOM;
 
 	/* No support yet for XDP metadata */
 	xdp_set_data_meta_invalid(&xdp);
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index ee8beb87bdc1..e10c23833515 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -412,10 +412,10 @@ static int efx_init_rx_buffers(struct efx_rx_queue *rx_queue, bool atomic)
 			index = rx_queue->added_count & rx_queue->ptr_mask;
 			rx_buf = efx_rx_buffer(rx_queue, index);
 			rx_buf->dma_addr = dma_addr + efx->rx_ip_align +
-					   XDP_PACKET_HEADROOM;
+					   EFX_XDP_HEADROOM;
 			rx_buf->page = page;
 			rx_buf->page_offset = page_offset + efx->rx_ip_align +
-					      XDP_PACKET_HEADROOM;
+					      EFX_XDP_HEADROOM;
 			rx_buf->len = efx->rx_dma_len;
 			rx_buf->flags = 0;
 			++rx_queue->added_count;
@@ -433,7 +433,7 @@ static int efx_init_rx_buffers(struct efx_rx_queue *rx_queue, bool atomic)
 void efx_rx_config_page_split(struct efx_nic *efx)
 {
 	efx->rx_page_buf_step = ALIGN(efx->rx_dma_len + efx->rx_ip_align +
-				      XDP_PACKET_HEADROOM,
+				      EFX_XDP_HEADROOM + EFX_XDP_TAILROOM,
 				      EFX_RX_BUF_ALIGNMENT);
 	efx->rx_bufs_per_page = efx->rx_buffer_order ? 1 :
 		((PAGE_SIZE - sizeof(struct efx_rx_page_state)) /


