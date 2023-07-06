Return-Path: <bpf+bounces-4322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C972174A558
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BF12814B9
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB317AC5;
	Thu,  6 Jul 2023 20:48:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD94D2E9;
	Thu,  6 Jul 2023 20:48:08 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644201999;
	Thu,  6 Jul 2023 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676487; x=1720212487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WFKgb5AzswkxhGKUB0vMwZF/3arvglZ7d5qB13kyBk=;
  b=l/cYstNrsZ5h3aJ4Rj6z4Ny1C9dhVwhpj+o0c0vDi5zXpAVO+gA1rslJ
   KjkpMH105ziDwktzXhlAtNVs/URASVQ2gqOg/FF5glPSAkQ2N/JfJD0zB
   FzEE4ueaZcFMtaunIgxJaBXqFnZ6dpjluLWLu90407FJnHlLMNKIBjv3r
   Puxg0P1e/m1LjTd59LCIPVw2FTAllGvYTNFZpjj0Q9ExHeNiLoNB6arFi
   qdkCIYp1srnZ1akOjOM55JKVYNOLZ3ReVPljMLiRQavptxDqA99jXyJYE
   xUvckTwNcB90xD38crHvz87Pc95n9zieZlBPrS7g224cF7G60C8v2unW+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195541"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059700"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059700"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:04 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 17/24] xsk: add multi-buffer documentation
Date: Thu,  6 Jul 2023 22:46:43 +0200
Message-Id: <20230706204650.469087-18-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Add AF_XDP multi-buffer support documentation including two
pseudo-code samples.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 Documentation/networking/af_xdp.rst | 211 +++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index 247c6c4127e9..ce6fcda3d409 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -453,8 +453,92 @@ XDP_OPTIONS getsockopt
 Gets options from an XDP socket. The only one supported so far is
 XDP_OPTIONS_ZEROCOPY which tells you if zero-copy is on or not.
 
+Multi-Buffer Support
+====================
+
+With multi-buffer support, programs using AF_XDP sockets can receive
+and transmit packets consisting of multiple buffers both in copy and
+zero-copy mode. For example, a packet can consist of two
+frames/buffers, one with the header and the other one with the data,
+or a 9K Ethernet jumbo frame can be constructed by chaining together
+three 4K frames.
+
+Some definitions:
+
+* A packet consists of one or more frames
+
+* A descriptor in one of the AF_XDP rings always refers to a single
+  frame. In the case the packet consists of a single frame, the
+  descriptor refers to the whole packet.
+
+To enable multi-buffer support for an AF_XDP socket, use the new bind
+flag XDP_USE_SG. If this is not provided, all multi-buffer packets
+will be dropped just as before. Note that the XDP program loaded also
+needs to be in multi-buffer mode. This can be accomplished by using
+"xdp.frags" as the section name of the XDP program used.
+
+To represent a packet consisting of multiple frames, a new flag called
+XDP_PKT_CONTD is introduced in the options field of the Rx and Tx
+descriptors. If it is true (1) the packet continues with the next
+descriptor and if it is false (0) it means this is the last descriptor
+of the packet. Why the reverse logic of end-of-packet (eop) flag found
+in many NICs? Just to preserve compatibility with non-multi-buffer
+applications that have this bit set to false for all packets on Rx,
+and the apps set the options field to zero for Tx, as anything else
+will be treated as an invalid descriptor.
+
+These are the semantics for producing packets onto AF_XDP Tx ring
+consisting of multiple frames:
+
+* When an invalid descriptor is found, all the other
+  descriptors/frames of this packet are marked as invalid and not
+  completed. The next descriptor is treated as the start of a new
+  packet, even if this was not the intent (because we cannot guess
+  the intent). As before, if your program is producing invalid
+  descriptors you have a bug that must be fixed.
+
+* Zero length descriptors are treated as invalid descriptors.
+
+* For copy mode, the maximum supported number of frames in a packet is
+  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
+  descriptors accumulated so far are dropped and treated as
+  invalid. To produce an application that will work on any system
+  regardless of this config setting, limit the number of frags to 18,
+  as the minimum value of the config is 17.
+
+* For zero-copy mode, the limit is up to what the NIC HW
+  supports. Usually at least five on the NICs we have checked. We
+  consciously chose to not enforce a rigid limit (such as
+  CONFIG_MAX_SKB_FRAGS + 1) for zero-copy mode, as it would have
+  resulted in copy actions under the hood to fit into what limit the
+  NIC supports. Kind of defeats the purpose of zero-copy mode. How to
+  probe for this limit is explained in the "probe for multi-buffer
+  support" section.
+
+On the Rx path in copy-mode, the xsk core copies the XDP data into
+multiple descriptors, if needed, and sets the XDP_PKT_CONTD flag as
+detailed before. Zero-copy mode works the same, though the data is not
+copied. When the application gets a descriptor with the XDP_PKT_CONTD
+flag set to one, it means that the packet consists of multiple buffers
+and it continues with the next buffer in the following
+descriptor. When a descriptor with XDP_PKT_CONTD == 0 is received, it
+means that this is the last buffer of the packet. AF_XDP guarantees
+that only a complete packet (all frames in the packet) is sent to the
+application. If there is not enough space in the AF_XDP Rx ring, all
+frames of the packet will be dropped.
+
+If application reads a batch of descriptors, using for example the libxdp
+interfaces, it is not guaranteed that the batch will end with a full
+packet. It might end in the middle of a packet and the rest of the
+buffers of that packet will arrive at the beginning of the next batch,
+since the libxdp interface does not read the whole ring (unless you
+have an enormous batch size or a very small ring size).
+
+An example program each for Rx and Tx multi-buffer support can be found
+later in this document.
+
 Usage
-=====
+-----
 
 In order to use AF_XDP sockets two parts are needed. The
 user-space application and the XDP program. For a complete setup and
@@ -532,6 +616,131 @@ like this:
 But please use the libbpf functions as they are optimized and ready to
 use. Will make your life easier.
 
+Usage Multi-Buffer Rx
+---------------------
+
+Here is a simple Rx path pseudo-code example (using libxdp interfaces
+for simplicity). Error paths have been excluded to keep it short:
+
+.. code-block:: c
+
+    void rx_packets(struct xsk_socket_info *xsk)
+    {
+        static bool new_packet = true;
+        u32 idx_rx = 0, idx_fq = 0;
+        static char *pkt;
+
+        int rcvd = xsk_ring_cons__peek(&xsk->rx, opt_batch_size, &idx_rx);
+
+        xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);
+
+        for (int i = 0; i < rcvd; i++) {
+            struct xdp_desc *desc = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++);
+            char *frag = xsk_umem__get_data(xsk->umem->buffer, desc->addr);
+            bool eop = !(desc->options & XDP_PKT_CONTD);
+
+            if (new_packet)
+                pkt = frag;
+            else
+                add_frag_to_pkt(pkt, frag);
+
+            if (eop)
+                process_pkt(pkt);
+
+            new_packet = eop;
+
+            *xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) = desc->addr;
+        }
+
+        xsk_ring_prod__submit(&xsk->umem->fq, rcvd);
+        xsk_ring_cons__release(&xsk->rx, rcvd);
+    }
+
+Usage Multi-Buffer Tx
+---------------------
+
+Here is an example Tx path pseudo-code (using libxdp interfaces for
+simplicity) ignoring that the umem is finite in size, and that we
+eventually will run out of packets to send. Also assumes pkts.addr
+points to a valid location in the umem.
+
+.. code-block:: c
+
+    void tx_packets(struct xsk_socket_info *xsk, struct pkt *pkts,
+                    int batch_size)
+    {
+        u32 idx, i, pkt_nb = 0;
+
+        xsk_ring_prod__reserve(&xsk->tx, batch_size, &idx);
+
+        for (i = 0; i < batch_size;) {
+            u64 addr = pkts[pkt_nb].addr;
+            u32 len = pkts[pkt_nb].size;
+
+            do {
+                struct xdp_desc *tx_desc;
+
+                tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx + i++);
+                tx_desc->addr = addr;
+
+                if (len > xsk_frame_size) {
+                    tx_desc->len = xsk_frame_size;
+                    tx_desc->options = XDP_PKT_CONTD;
+                } else {
+                    tx_desc->len = len;
+                    tx_desc->options = 0;
+                    pkt_nb++;
+                }
+                len -= tx_desc->len;
+                addr += xsk_frame_size;
+
+                if (i == batch_size) {
+                    /* Remember len, addr, pkt_nb for next iteration.
+                     * Skipped for simplicity.
+                     */
+                    break;
+                }
+            } while (len);
+        }
+
+        xsk_ring_prod__submit(&xsk->tx, i);
+    }
+
+Probing for Multi-Buffer Support
+--------------------------------
+
+To discover if a driver supports multi-buffer AF_XDP in SKB or DRV
+mode, use the XDP_FEATURES feature of netlink in linux/netdev.h to
+query for NETDEV_XDP_ACT_RX_SG support. This is the same flag as for
+querying for XDP multi-buffer support. If XDP supports multi-buffer in
+a driver, then AF_XDP will also support that in SKB and DRV mode.
+
+To discover if a driver supports multi-buffer AF_XDP in zero-copy
+mode, use XDP_FEATURES and first check the NETDEV_XDP_ACT_XSK_ZEROCOPY
+flag. If it is set, it means that at least zero-copy is supported and
+you should go and check the netlink attribute
+NETDEV_A_DEV_XDP_ZC_MAX_SEGS in linux/netdev.h. An unsigned integer
+value will be returned stating the max number of frags that are
+supported by this device in zero-copy mode. These are the possible
+return values:
+
+1: Multi-buffer for zero-copy is not supported by this device, as max
+   one fragment supported means that multi-buffer is not possible.
+
+>=2: Multi-buffer is supported in zero-copy mode for this device. The
+     returned number signifies the max number of frags supported.
+
+For an example on how these are used through libbpf, please take a
+look at tools/testing/selftests/bpf/xskxceiver.c.
+
+Multi-Buffer Support for Zero-Copy Drivers
+------------------------------------------
+
+Zero-copy drivers usually use the batched APIs for Rx and Tx
+processing. Note that the Tx batch API guarantees that it will provide
+a batch of Tx descriptors that ends with full packet at the end. This
+to facilitate extending a zero-copy driver with multi-buffer support.
+
 Sample application
 ==================
 
-- 
2.34.1


