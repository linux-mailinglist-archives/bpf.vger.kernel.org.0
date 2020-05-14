Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0614F1D2D5E
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgENKun (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 06:50:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbgENKun (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 06:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589453442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dClE898SSO2c1QGlOHxQoQyzhVi936UcQ7MPR8OmHo=;
        b=F3mWe7xrIIkSWHbOYWRcCuSkrYAjNRyNrxn1ffulqyzToDm8rXis7nrZT5ew4x7U+5Yi1r
        wUjNsn9N0RQpVyKbNVXHjd5Bz5jTyFRGkt2kP6QVUxvr/qwmnxPHATkF07U5vVr0iCTp3t
        cI4je/3qNbtmSJBDrI39j/+HvWVCSqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-VNZAuQfMPtS0BXfAPlMRcQ-1; Thu, 14 May 2020 06:50:02 -0400
X-MC-Unique: VNZAuQfMPtS0BXfAPlMRcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EE611005510;
        Thu, 14 May 2020 10:50:00 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 937305DA7A;
        Thu, 14 May 2020 10:49:54 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 89863300020FC;
        Thu, 14 May 2020 12:49:53 +0200 (CEST)
Subject: [PATCH net-next v4 11/33] dpaa2-eth: add XDP frame size
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Date:   Thu, 14 May 2020 12:49:53 +0200
Message-ID: <158945339348.97035.8562488847066908856.stgit@firesoul>
In-Reply-To: <158945314698.97035.5286827951225578467.stgit@firesoul>
References: <158945314698.97035.5286827951225578467.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The dpaa2-eth driver reserve some headroom used for hardware and
software annotation area in RX/TX buffers. Thus, xdp.data_hard_start
doesn't start at page boundary.

When XDP is configured the area reserved via dpaa2_fd_get_offset(fd) is
448 bytes of which XDP have reserved 256 bytes. As frame_sz is
calculated as an offset from xdp_buff.data_hard_start, an adjust from
the full PAGE_SIZE == DPAA2_ETH_RX_BUF_RAW_SIZE.

When doing XDP_REDIRECT, the driver doesn't need this reserved headroom
any-longer and allows xdp_do_redirect() to use it. This is an advantage
for the drivers own ndo-xdp_xmit, as it uses part of this headroom for
itself.  Patch also adjust frame_sz in this case.

The driver cannot support XDP data_meta, because it uses the headroom
just before xdp.data for struct dpaa2_eth_swa (DPAA2_ETH_SWA_SIZE=64),
when transmitting the packet. When transmitting a xdp_frame in
dpaa2_eth_xdp_xmit_frame (call via ndo_xdp_xmit) is uses this area to
store a pointer to xdp_frame and dma_size, which is used in TX
completion (free_tx_fd) to return frame via xdp_return_frame().

Cc: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 0f3e842a4fd6..8c8d95aa1dfd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -331,6 +331,9 @@ static u32 run_xdp(struct dpaa2_eth_priv *priv,
 	xdp_set_data_meta_invalid(&xdp);
 	xdp.rxq = &ch->xdp_rxq;
 
+	xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE -
+		(dpaa2_fd_get_offset(fd) - XDP_PACKET_HEADROOM);
+
 	xdp_act = bpf_prog_run_xdp(xdp_prog, &xdp);
 
 	/* xdp.data pointer may have changed */
@@ -366,7 +369,11 @@ static u32 run_xdp(struct dpaa2_eth_priv *priv,
 		dma_unmap_page(priv->net_dev->dev.parent, addr,
 			       DPAA2_ETH_RX_BUF_SIZE, DMA_BIDIRECTIONAL);
 		ch->buf_count--;
+
+		/* Allow redirect use of full headroom */
 		xdp.data_hard_start = vaddr;
+		xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE;
+
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (unlikely(err))
 			ch->stats.xdp_drop++;


