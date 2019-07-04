Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6B5F86A
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2019 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGDMnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jul 2019 08:43:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:48071 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfGDMnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jul 2019 08:43:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 05:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="315855035"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.252.32.218])
  by orsmga004.jf.intel.com with ESMTP; 04 Jul 2019 05:43:15 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, brouer@redhat.com
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, jakub.kicinski@netronome.com,
        xiaolong.ye@intel.com, qi.z.zhang@intel.com, maximmi@mellanox.com,
        sridhar.samudrala@intel.com, kevin.laatz@intel.com,
        ilias.apalodimas@linaro.org, kiran.patil@intel.com,
        axboe@kernel.dk, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org
Subject: [PATCH bpf-next v3 5/6] libbpf: add support for need_wakeup flag in AF_XDP part
Date:   Thu,  4 Jul 2019 14:42:13 +0200
Message-Id: <1562244134-19069-6-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562244134-19069-1-git-send-email-magnus.karlsson@intel.com>
References: <1562244134-19069-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds support for the new need_wakeup flag in AF_XDP. The
xsk_socket__create function is updated to handle this and a new
function is introduced called xsk_ring_prod__needs_wakeup(). This
function can be used by the application to check if Rx and/or Tx
processing needs to be explicitly woken up.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 tools/include/uapi/linux/if_xdp.h | 13 +++++++++++++
 tools/lib/bpf/xsk.c               |  4 ++++
 tools/lib/bpf/xsk.h               |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index faaa5ca..62b80d5 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -16,6 +16,15 @@
 #define XDP_SHARED_UMEM	(1 << 0)
 #define XDP_COPY	(1 << 1) /* Force copy-mode */
 #define XDP_ZEROCOPY	(1 << 2) /* Force zero-copy mode */
+/* If this option is set, the driver might go sleep and in that case
+ * the XDP_RING_NEED_WAKEUP flag in the fill and/or Tx rings will be
+ * set. If it is set, the application need to explicitly wake up the
+ * driver with a poll() (Rx and Tx) or sendto() (Tx only). If you are
+ * running the driver and the application on the same core, you should
+ * use this option so that the kernel will yield to the user space
+ * application.
+ */
+#define XDP_USE_NEED_WAKEUP (1 << 3)
 
 struct sockaddr_xdp {
 	__u16 sxdp_family;
@@ -25,10 +34,14 @@ struct sockaddr_xdp {
 	__u32 sxdp_shared_umem_fd;
 };
 
+/* XDP_RING flags */
+#define XDP_RING_NEED_WAKEUP (1 << 0)
+
 struct xdp_ring_offset {
 	__u64 producer;
 	__u64 consumer;
 	__u64 desc;
+	__u64 flags;
 };
 
 struct xdp_mmap_offsets {
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index b337402..5665b4d 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -224,6 +224,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,
 	fill->size = umem->config.fill_size;
 	fill->producer = map + off.fr.producer;
 	fill->consumer = map + off.fr.consumer;
+	fill->flags = map + off.fr.flags;
 	fill->ring = map + off.fr.desc;
 	fill->cached_cons = umem->config.fill_size;
 
@@ -241,6 +242,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,
 	comp->size = umem->config.comp_size;
 	comp->producer = map + off.cr.producer;
 	comp->consumer = map + off.cr.consumer;
+	comp->flags = map + off.cr.flags;
 	comp->ring = map + off.cr.desc;
 
 	*umem_ptr = umem;
@@ -564,6 +566,7 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		rx->size = xsk->config.rx_size;
 		rx->producer = rx_map + off.rx.producer;
 		rx->consumer = rx_map + off.rx.consumer;
+		rx->flags = rx_map + off.rx.flags;
 		rx->ring = rx_map + off.rx.desc;
 	}
 	xsk->rx = rx;
@@ -583,6 +586,7 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		tx->size = xsk->config.tx_size;
 		tx->producer = tx_map + off.tx.producer;
 		tx->consumer = tx_map + off.tx.consumer;
+		tx->flags = tx_map + off.tx.flags;
 		tx->ring = tx_map + off.tx.desc;
 		tx->cached_cons = xsk->config.tx_size;
 	}
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 833a6e6..aa1d612 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -32,6 +32,7 @@ struct name { \
 	__u32 *producer; \
 	__u32 *consumer; \
 	void *ring; \
+	__u32 *flags; \
 }
 
 DEFINE_XSK_RING(xsk_ring_prod);
@@ -76,6 +77,11 @@ xsk_ring_cons__rx_desc(const struct xsk_ring_cons *rx, __u32 idx)
 	return &descs[idx & rx->mask];
 }
 
+static inline int xsk_ring_prod__needs_wakeup(const struct xsk_ring_prod *r)
+{
+	return *r->flags & XDP_RING_NEED_WAKEUP;
+}
+
 static inline __u32 xsk_prod_nb_free(struct xsk_ring_prod *r, __u32 nb)
 {
 	__u32 free_entries = r->cached_cons - r->cached_prod;
-- 
2.7.4

