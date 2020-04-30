Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DF1BF6AB
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD3LWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 07:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgD3LWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 07:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588245759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hENIVc271T9dVoIScmAiXOssU9Iccm+zn9gVpNT73bY=;
        b=V4kAZgi5schPG25LUQz/kp8Qbt79LyZLVx1wPKMjWImgfm7u+R8DJvENG9lrQXinYsGoC9
        oRyvXPikCZs1MAEIKgp3enmBUzQWcv4Q01maQhAHB54l1Gc4aPVP8N2OiZxjj9eLI3AuaW
        9rB5QVwhhJCjulq2+hK1ptGIoypYCVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-ruuPug_BOXeNal4G1gVU1g-1; Thu, 30 Apr 2020 07:22:37 -0400
X-MC-Unique: ruuPug_BOXeNal4G1gVU1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5942845F;
        Thu, 30 Apr 2020 11:22:35 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943D51001920;
        Thu, 30 Apr 2020 11:22:29 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 90185324DB2C0;
        Thu, 30 Apr 2020 13:22:28 +0200 (CEST)
Subject: [PATCH net-next v2 25/33] i40e: add XDP frame size to driver
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     sameehj@amazon.com
Cc:     intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Date:   Thu, 30 Apr 2020 13:22:28 +0200
Message-ID: <158824574851.2172139.7223362531741646155.stgit@firesoul>
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This driver uses different memory models depending on PAGE_SIZE at
compile time. For PAGE_SIZE 4K it uses page splitting, meaning for
normal MTU frame size is 2048 bytes (and headroom 192 bytes). For
larger MTUs the driver still use page splitting, by allocating
order-1 pages (8192 bytes) for RX frames. For PAGE_SIZE larger than
4K, driver instead advance its rx_buffer->page_offset with the frame
size "truesize".

For XDP frame size calculations, this mean that in PAGE_SIZE larger
than 4K mode the frame_sz change on a per packet basis. For the page
split 4K PAGE_SIZE mode, xdp.frame_sz is more constant and can be
updated once outside the main NAPI loop.

The default setting in the driver uses build_skb(), which provides
the necessary headroom and tailroom for XDP-redirect in RX-frame
(in both modes).

There is one complication, which is legacy-rx mode (configurable via
ethtool priv-flags). There are zero headroom in this mode, which is a
requirement for XDP-redirect to work. The conversion to xdp_frame
(convert_to_xdp_frame) will detect this insufficient space, and
xdp_do_redirect() call will fail. This is deemed acceptable, as it
allows other XDP actions to still work in legacy-mode. In
legacy-mode + larger PAGE_SIZE due to lacking tailroom, we also
accept that xdp_adjust_tail shrink doesn't work.

Cc: intel-wired-lan@lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   30 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b8496037ef7f..a3772beffe02 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1507,6 +1507,22 @@ static inline unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
 	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
 }
 
+static unsigned int i40e_rx_frame_truesize(struct i40e_ring *rx_ring,
+					   unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = i40e_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+#else
+	truesize = i40e_rx_offset(rx_ring) ?
+		SKB_DATA_ALIGN(size + i40e_rx_offset(rx_ring)) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+		SKB_DATA_ALIGN(size);
+#endif
+	return truesize;
+}
+
 /**
  * i40e_alloc_mapped_page - recycle or make a new page
  * @rx_ring: ring to use
@@ -2246,13 +2262,11 @@ static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
 				struct i40e_rx_buffer *rx_buffer,
 				unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
+	unsigned int truesize = i40e_rx_frame_truesize(rx_ring, size);
 
+#if (PAGE_SIZE < 8192)
 	rx_buffer->page_offset ^= truesize;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(i40e_rx_offset(rx_ring) + size);
-
 	rx_buffer->page_offset += truesize;
 #endif
 }
@@ -2335,6 +2349,9 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	bool failure = false;
 	struct xdp_buff xdp;
 
+#if (PAGE_SIZE < 8192)
+	xdp.frame_sz = i40e_rx_frame_truesize(rx_ring, 0);
+#endif
 	xdp.rxq = &rx_ring->xdp_rxq;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
@@ -2389,7 +2406,10 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 			xdp.data_hard_start = xdp.data -
 					      i40e_rx_offset(rx_ring);
 			xdp.data_end = xdp.data + size;
-
+#if (PAGE_SIZE > 4096)
+			/* At larger PAGE_SIZE, frame_sz depend on len size */
+			xdp.frame_sz = i40e_rx_frame_truesize(rx_ring, size);
+#endif
 			skb = i40e_run_xdp(rx_ring, &xdp);
 		}
 


