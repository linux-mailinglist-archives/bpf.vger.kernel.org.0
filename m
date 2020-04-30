Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CC41BF6A9
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD3LWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 07:22:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726820AbgD3LWf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 07:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588245754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4s+5w2hStU9cVyP6Ci0mhapVgmDYyWOFWNPTXqkXolA=;
        b=QkPOtP/dJlVMdhivgPT1lOfcIojSqszy8LXUtzIqwCkhbBdiKWeaKBgZ7xaIdCrl5VCtW4
        elz+f8/ZM4B7wb4KhWPAaxV8LU0M/eI7HnT0qUVO1z2tJNEt7mfyDkgZFoU0tIZtAjKP14
        DD9vHNdStdtLPDOTJNvzi1BYQA7r7D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-RIV30SiBO5aQFZ1iajP-yg-1; Thu, 30 Apr 2020 07:22:32 -0400
X-MC-Unique: RIV30SiBO5aQFZ1iajP-yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C0F11005510;
        Thu, 30 Apr 2020 11:22:30 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AFD85D9F1;
        Thu, 30 Apr 2020 11:22:24 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 7A671324DB2C1;
        Thu, 30 Apr 2020 13:22:23 +0200 (CEST)
Subject: [PATCH net-next v2 24/33] ixgbevf: add XDP frame size to VF driver
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
Date:   Thu, 30 Apr 2020 13:22:23 +0200
Message-ID: <158824574342.2172139.1177853527820233237.stgit@firesoul>
In-Reply-To: <158824557985.2172139.4173570969543904434.stgit@firesoul>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch mirrors the changes to ixgbe in previous patch.

This VF driver doesn't support XDP_REDIRECT, but correct tailroom is
still necessary for BPF-helper xdp_adjust_tail.  In legacy-mode +
larger PAGE_SIZE, due to lacking tailroom, we accept that
xdp_adjust_tail shrink doesn't work.

Cc: intel-wired-lan@lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   34 +++++++++++++++++----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 4622c4ea2e46..62bc3e3b5b9c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1095,19 +1095,31 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 	return ERR_PTR(-result);
 }
 
+static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
+					      unsigned int size)
+{
+	unsigned int truesize;
+
+#if (PAGE_SIZE < 8192)
+	truesize = ixgbevf_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
+#else
+	truesize = ring_uses_build_skb(rx_ring) ?
+		SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
+		SKB_DATA_ALIGN(size);
+#endif
+       return truesize;
+}
+
 static void ixgbevf_rx_buffer_flip(struct ixgbevf_ring *rx_ring,
 				   struct ixgbevf_rx_buffer *rx_buffer,
 				   unsigned int size)
 {
-#if (PAGE_SIZE < 8192)
-	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
+	unsigned int truesize = ixgbevf_rx_frame_truesize(rx_ring, size);
 
+#if (PAGE_SIZE < 8192)
 	rx_buffer->page_offset ^= truesize;
 #else
-	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
-				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) :
-				SKB_DATA_ALIGN(size);
-
 	rx_buffer->page_offset += truesize;
 #endif
 }
@@ -1125,6 +1137,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 
 	xdp.rxq = &rx_ring->xdp_rxq;
 
+	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
+#if (PAGE_SIZE < 8192)
+	xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, 0);
+#endif
+
 	while (likely(total_rx_packets < budget)) {
 		struct ixgbevf_rx_buffer *rx_buffer;
 		union ixgbe_adv_rx_desc *rx_desc;
@@ -1157,7 +1174,10 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			xdp.data_hard_start = xdp.data -
 					      ixgbevf_rx_offset(rx_ring);
 			xdp.data_end = xdp.data + size;
-
+#if (PAGE_SIZE > 4096)
+			/* At larger PAGE_SIZE, frame_sz depend on len size */
+			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
+#endif
 			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
 		}
 


