Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB811D2A41
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgENIhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 04:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENIhe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 04:37:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25000C061A0C;
        Thu, 14 May 2020 01:37:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so907081plo.7;
        Thu, 14 May 2020 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=141oB8TWZ67Z5jV15DS4TmImJIizqMgHTfHkaYBVlsQ=;
        b=DAIrUMmAog6wEXEq4wRgYf4cFOPxY/QbO4/hxh4LofWpyzNhWyG6unzKk12jadbA21
         DhNYo0TcOXGj3QA7crxFo6Oo6STxQxOBYW3q4m7NS/D7gH2LGbFpGTGBkPO3TRWPlSpt
         r7SfbmEaVtzleft61LLhgz3LMht68gTJnFxkzxUW52MpGPFr25XD8LZy8pWAxsLGxDFl
         9Sbj/cUrSy1zfCYSrLmNFoRVzyBaS5Ulbrp1n9hufL4rmVvE0uth8+dja4Y85yMdbmG1
         OieV2bQJTwTvPGC3XNZva4pj1D8YuxETiCwEKhhxDCS+7tz3fbdQf2Gu9eLaf5dvHo/b
         ouhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=141oB8TWZ67Z5jV15DS4TmImJIizqMgHTfHkaYBVlsQ=;
        b=HL8qKkSUGWMy8/lDSbfQEOsZ9fbv4Kp+NCgMCg7IgVicVSJXK+d0UU7KFv2qczEeAN
         t3sI1We4pu3IMS3peP799Qq3YHmwC7Bk9ChBZetk6AgkBf2FSbHp6EUQAqloXhh/VUD3
         JREtVYyrNWYoIaIzIA6QWNputLvHyGvJIx9G9IJhN1gZUVg15C/U5/8fHl8dYSpYP/JY
         hUS5zTWROn9Ap/Dbv88htYdDFOSrxV7p3eVqrs6wZrarZ9N6YiXp6swNo5rjOcIk9oT8
         EAcc1z6HO/FZ9qTmUsL2a7dCjGfOY/Hcw2E9pZDIzfPVS9jlrLXQb+ZCfUEZe3wuRDnm
         tFzg==
X-Gm-Message-State: AOAM530JLlaqs8t+f8DB8oarOJ8JmU4R2Ug+cpgcf3rNO8RJinhPrQDi
        Kc8AkHqsTX+V5pSrq2dBUxI=
X-Google-Smtp-Source: ABdhPJxMZw+ewlEbRx6kpXmYVNZM2d+JfbheG+FzadHhhG+STC5O6ufGNxfbKnqASCKsZ+3ZryGdmQ==
X-Received: by 2002:a17:902:8d87:: with SMTP id v7mr2999653plo.153.1589445453421;
        Thu, 14 May 2020 01:37:33 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id k4sm1608058pgg.88.2020.05.14.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:37:32 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        jeffrey.t.kirsher@intel.com
Cc:     maximmi@mellanox.com, maciej.fijalkowski@intel.com,
        bjorn.topel@intel.com
Subject: [PATCH bpf-next v2 02/14] xsk: move driver interface to xdp_sock_drv.h
Date:   Thu, 14 May 2020 10:36:58 +0200
Message-Id: <20200514083710.143394-3-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514083710.143394-1-bjorn.topel@gmail.com>
References: <20200514083710.143394-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Move the AF_XDP zero-copy driver interface to its own include file
called xdp_sock_drv.h. This, hopefully, will make it more clear for
NIC driver implementors to know what functions to use for zero-copy
support.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/umem.c |   2 +-
 include/net/xdp_sock.h                        | 203 +----------------
 include/net/xdp_sock_drv.h                    | 207 ++++++++++++++++++
 net/ethtool/channels.c                        |   2 +-
 net/ethtool/ioctl.c                           |   2 +-
 net/xdp/xdp_umem.h                            |   2 +-
 net/xdp/xsk.c                                 |   2 +-
 14 files changed, 227 insertions(+), 207 deletions(-)
 create mode 100644 include/net/xdp_sock_drv.h

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2a037ec244b9..d6b2db4f2c65 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11,7 +11,7 @@
 #include "i40e_diag.h"
 #include "i40e_xsk.h"
 #include <net/udp_tunnel.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 /* All i40e tracepoints are defined by the include below, which
  * must be included exactly once across the whole kernel with
  * CREATE_TRACE_POINTS defined
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 0b7d29192b2c..452bba7bc4ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 
 #include "i40e.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8279db15e870..955b0fbb7c9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 #include "ice.h"
 #include "ice_base.h"
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 74b540ebb3dc..5b6edbd8a4ed 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2018 Intel Corporation. */
 
 #include <linux/bpf_trace.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 
 #include "ixgbe.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index c4a7fb4ecd14..b04b99396f65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -31,7 +31,7 @@
  */
 
 #include <linux/bpf_trace.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include "en/xdp.h"
 #include "en/params.h"
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
index cab0e93497ae..a8e11adbf426 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
@@ -5,7 +5,7 @@
 #define __MLX5_EN_XSK_RX_H__
 
 #include "en.h"
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 
 /* RX data path */
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.h
index 79b487d89757..39fa0a705856 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.h
@@ -5,7 +5,7 @@
 #define __MLX5_EN_XSK_TX_H__
 
 #include "en.h"
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 
 /* TX data path */
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/umem.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/umem.c
index 4baaa5788320..5e49fdb564b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/umem.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/umem.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2019 Mellanox Technologies. */
 
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include "umem.h"
 #include "setup.h"
 #include "en/params.h"
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index a26d6c80e43d..6a986dcbc336 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -15,6 +15,7 @@
 
 struct net_device;
 struct xsk_queue;
+struct xdp_buff;
 
 /* Masks for xdp_umem_page flags.
  * The low 12-bits of the addr will be 0 since this is the page address, so we
@@ -101,27 +102,9 @@ struct xdp_sock {
 	spinlock_t map_list_lock;
 };
 
-struct xdp_buff;
 #ifdef CONFIG_XDP_SOCKETS
-int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
-/* Used from netdev driver */
-bool xsk_umem_has_addrs(struct xdp_umem *umem, u32 cnt);
-bool xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr);
-void xsk_umem_release_addr(struct xdp_umem *umem);
-void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries);
-bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
-void xsk_umem_consume_tx_done(struct xdp_umem *umem);
-struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries);
-struct xdp_umem_fq_reuse *xsk_reuseq_swap(struct xdp_umem *umem,
-					  struct xdp_umem_fq_reuse *newq);
-void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq);
-struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev, u16 queue_id);
-void xsk_set_rx_need_wakeup(struct xdp_umem *umem);
-void xsk_set_tx_need_wakeup(struct xdp_umem *umem);
-void xsk_clear_rx_need_wakeup(struct xdp_umem *umem);
-void xsk_clear_tx_need_wakeup(struct xdp_umem *umem);
-bool xsk_umem_uses_need_wakeup(struct xdp_umem *umem);
 
+int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(void);
 
@@ -153,125 +136,24 @@ static inline u64 xsk_umem_add_offset_to_addr(u64 addr)
 	return xsk_umem_extract_addr(addr) + xsk_umem_extract_offset(addr);
 }
 
-static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
-{
-	unsigned long page_addr;
-
-	addr = xsk_umem_add_offset_to_addr(addr);
-	page_addr = (unsigned long)umem->pages[addr >> PAGE_SHIFT].addr;
-
-	return (char *)(page_addr & PAGE_MASK) + (addr & ~PAGE_MASK);
-}
-
-static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
-{
-	addr = xsk_umem_add_offset_to_addr(addr);
-
-	return umem->pages[addr >> PAGE_SHIFT].dma + (addr & ~PAGE_MASK);
-}
-
-/* Reuse-queue aware version of FILL queue helpers */
-static inline bool xsk_umem_has_addrs_rq(struct xdp_umem *umem, u32 cnt)
-{
-	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
-
-	if (rq->length >= cnt)
-		return true;
-
-	return xsk_umem_has_addrs(umem, cnt - rq->length);
-}
-
-static inline bool xsk_umem_peek_addr_rq(struct xdp_umem *umem, u64 *addr)
-{
-	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
-
-	if (!rq->length)
-		return xsk_umem_peek_addr(umem, addr);
-
-	*addr = rq->handles[rq->length - 1];
-	return addr;
-}
-
-static inline void xsk_umem_release_addr_rq(struct xdp_umem *umem)
-{
-	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
-
-	if (!rq->length)
-		xsk_umem_release_addr(umem);
-	else
-		rq->length--;
-}
-
-static inline void xsk_umem_fq_reuse(struct xdp_umem *umem, u64 addr)
-{
-	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
-
-	rq->handles[rq->length++] = addr;
-}
-
-/* Handle the offset appropriately depending on aligned or unaligned mode.
- * For unaligned mode, we store the offset in the upper 16-bits of the address.
- * For aligned mode, we simply add the offset to the address.
- */
-static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 address,
-					 u64 offset)
-{
-	if (umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG)
-		return address + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
-	else
-		return address + offset;
-}
 #else
+
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
 	return -ENOTSUPP;
 }
 
-static inline bool xsk_umem_has_addrs(struct xdp_umem *umem, u32 cnt)
-{
-	return false;
-}
-
-static inline u64 *xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr)
-{
-	return NULL;
-}
-
-static inline void xsk_umem_release_addr(struct xdp_umem *umem)
-{
-}
-
-static inline void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries)
-{
-}
-
-static inline bool xsk_umem_consume_tx(struct xdp_umem *umem,
-				       struct xdp_desc *desc)
-{
-	return false;
-}
-
-static inline void xsk_umem_consume_tx_done(struct xdp_umem *umem)
-{
-}
-
-static inline struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries)
+static inline int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
-static inline struct xdp_umem_fq_reuse *xsk_reuseq_swap(
-	struct xdp_umem *umem,
-	struct xdp_umem_fq_reuse *newq)
-{
-	return NULL;
-}
-static inline void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq)
+static inline void __xsk_map_flush(void)
 {
 }
 
-static inline struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
-						     u16 queue_id)
+static inline struct xdp_sock *__xsk_map_lookup_elem(struct bpf_map *map,
+						     u32 key)
 {
 	return NULL;
 }
@@ -291,75 +173,6 @@ static inline u64 xsk_umem_add_offset_to_addr(u64 addr)
 	return 0;
 }
 
-static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
-{
-	return NULL;
-}
-
-static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
-{
-	return 0;
-}
-
-static inline bool xsk_umem_has_addrs_rq(struct xdp_umem *umem, u32 cnt)
-{
-	return false;
-}
-
-static inline u64 *xsk_umem_peek_addr_rq(struct xdp_umem *umem, u64 *addr)
-{
-	return NULL;
-}
-
-static inline void xsk_umem_release_addr_rq(struct xdp_umem *umem)
-{
-}
-
-static inline void xsk_umem_fq_reuse(struct xdp_umem *umem, u64 addr)
-{
-}
-
-static inline void xsk_set_rx_need_wakeup(struct xdp_umem *umem)
-{
-}
-
-static inline void xsk_set_tx_need_wakeup(struct xdp_umem *umem)
-{
-}
-
-static inline void xsk_clear_rx_need_wakeup(struct xdp_umem *umem)
-{
-}
-
-static inline void xsk_clear_tx_need_wakeup(struct xdp_umem *umem)
-{
-}
-
-static inline bool xsk_umem_uses_need_wakeup(struct xdp_umem *umem)
-{
-	return false;
-}
-
-static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 handle,
-					 u64 offset)
-{
-	return 0;
-}
-
-static inline int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline void __xsk_map_flush(void)
-{
-}
-
-static inline struct xdp_sock *__xsk_map_lookup_elem(struct bpf_map *map,
-						     u32 key)
-{
-	return NULL;
-}
 #endif /* CONFIG_XDP_SOCKETS */
 
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
new file mode 100644
index 000000000000..98dd6962e6d4
--- /dev/null
+++ b/include/net/xdp_sock_drv.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Interface for implementing AF_XDP zero-copy support in drivers.
+ * Copyright(c) 2020 Intel Corporation.
+ */
+
+#ifndef _LINUX_XDP_SOCK_DRV_H
+#define _LINUX_XDP_SOCK_DRV_H
+
+#include <net/xdp_sock.h>
+
+#ifdef CONFIG_XDP_SOCKETS
+
+bool xsk_umem_has_addrs(struct xdp_umem *umem, u32 cnt);
+bool xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr);
+void xsk_umem_release_addr(struct xdp_umem *umem);
+void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries);
+bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
+void xsk_umem_consume_tx_done(struct xdp_umem *umem);
+struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries);
+struct xdp_umem_fq_reuse *xsk_reuseq_swap(struct xdp_umem *umem,
+					  struct xdp_umem_fq_reuse *newq);
+void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq);
+struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev, u16 queue_id);
+void xsk_set_rx_need_wakeup(struct xdp_umem *umem);
+void xsk_set_tx_need_wakeup(struct xdp_umem *umem);
+void xsk_clear_rx_need_wakeup(struct xdp_umem *umem);
+void xsk_clear_tx_need_wakeup(struct xdp_umem *umem);
+bool xsk_umem_uses_need_wakeup(struct xdp_umem *umem);
+
+static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
+{
+	unsigned long page_addr;
+
+	addr = xsk_umem_add_offset_to_addr(addr);
+	page_addr = (unsigned long)umem->pages[addr >> PAGE_SHIFT].addr;
+
+	return (char *)(page_addr & PAGE_MASK) + (addr & ~PAGE_MASK);
+}
+
+static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
+{
+	addr = xsk_umem_add_offset_to_addr(addr);
+
+	return umem->pages[addr >> PAGE_SHIFT].dma + (addr & ~PAGE_MASK);
+}
+
+/* Reuse-queue aware version of FILL queue helpers */
+static inline bool xsk_umem_has_addrs_rq(struct xdp_umem *umem, u32 cnt)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	if (rq->length >= cnt)
+		return true;
+
+	return xsk_umem_has_addrs(umem, cnt - rq->length);
+}
+
+static inline bool xsk_umem_peek_addr_rq(struct xdp_umem *umem, u64 *addr)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	if (!rq->length)
+		return xsk_umem_peek_addr(umem, addr);
+
+	*addr = rq->handles[rq->length - 1];
+	return addr;
+}
+
+static inline void xsk_umem_release_addr_rq(struct xdp_umem *umem)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	if (!rq->length)
+		xsk_umem_release_addr(umem);
+	else
+		rq->length--;
+}
+
+static inline void xsk_umem_fq_reuse(struct xdp_umem *umem, u64 addr)
+{
+	struct xdp_umem_fq_reuse *rq = umem->fq_reuse;
+
+	rq->handles[rq->length++] = addr;
+}
+
+/* Handle the offset appropriately depending on aligned or unaligned mode.
+ * For unaligned mode, we store the offset in the upper 16-bits of the address.
+ * For aligned mode, we simply add the offset to the address.
+ */
+static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 address,
+					 u64 offset)
+{
+	if (umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG)
+		return address + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
+	else
+		return address + offset;
+}
+
+#else
+
+static inline bool xsk_umem_has_addrs(struct xdp_umem *umem, u32 cnt)
+{
+	return false;
+}
+
+static inline u64 *xsk_umem_peek_addr(struct xdp_umem *umem, u64 *addr)
+{
+	return NULL;
+}
+
+static inline void xsk_umem_release_addr(struct xdp_umem *umem)
+{
+}
+
+static inline void xsk_umem_complete_tx(struct xdp_umem *umem, u32 nb_entries)
+{
+}
+
+static inline bool xsk_umem_consume_tx(struct xdp_umem *umem,
+				       struct xdp_desc *desc)
+{
+	return false;
+}
+
+static inline void xsk_umem_consume_tx_done(struct xdp_umem *umem)
+{
+}
+
+static inline struct xdp_umem_fq_reuse *xsk_reuseq_prepare(u32 nentries)
+{
+	return NULL;
+}
+
+static inline struct xdp_umem_fq_reuse *xsk_reuseq_swap(
+	struct xdp_umem *umem, struct xdp_umem_fq_reuse *newq)
+{
+	return NULL;
+}
+
+static inline void xsk_reuseq_free(struct xdp_umem_fq_reuse *rq)
+{
+}
+
+static inline struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
+						     u16 queue_id)
+{
+	return NULL;
+}
+
+static inline char *xdp_umem_get_data(struct xdp_umem *umem, u64 addr)
+{
+	return NULL;
+}
+
+static inline dma_addr_t xdp_umem_get_dma(struct xdp_umem *umem, u64 addr)
+{
+	return 0;
+}
+
+static inline bool xsk_umem_has_addrs_rq(struct xdp_umem *umem, u32 cnt)
+{
+	return false;
+}
+
+static inline u64 *xsk_umem_peek_addr_rq(struct xdp_umem *umem, u64 *addr)
+{
+	return NULL;
+}
+
+static inline void xsk_umem_release_addr_rq(struct xdp_umem *umem)
+{
+}
+
+static inline void xsk_umem_fq_reuse(struct xdp_umem *umem, u64 addr)
+{
+}
+
+static inline void xsk_set_rx_need_wakeup(struct xdp_umem *umem)
+{
+}
+
+static inline void xsk_set_tx_need_wakeup(struct xdp_umem *umem)
+{
+}
+
+static inline void xsk_clear_rx_need_wakeup(struct xdp_umem *umem)
+{
+}
+
+static inline void xsk_clear_tx_need_wakeup(struct xdp_umem *umem)
+{
+}
+
+static inline bool xsk_umem_uses_need_wakeup(struct xdp_umem *umem)
+{
+	return false;
+}
+
+static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 handle,
+					 u64 offset)
+{
+	return 0;
+}
+
+#endif /* CONFIG_XDP_SOCKETS */
+
+#endif /* _LINUX_XDP_SOCK_DRV_H */
diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 389924b65d05..658a8580b464 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 
 #include "netlink.h"
 #include "common.h"
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 226d5ecdd567..c54eb042fb93 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -24,7 +24,7 @@
 #include <linux/sched/signal.h>
 #include <linux/net.h>
 #include <net/devlink.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <linux/ethtool_netlink.h>
 #include <generated/utsrelease.h>
diff --git a/net/xdp/xdp_umem.h b/net/xdp/xdp_umem.h
index a63a9fb251f5..32067fe98f65 100644
--- a/net/xdp/xdp_umem.h
+++ b/net/xdp/xdp_umem.h
@@ -6,7 +6,7 @@
 #ifndef XDP_UMEM_H_
 #define XDP_UMEM_H_
 
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 
 int xdp_umem_assign_dev(struct xdp_umem *umem, struct net_device *dev,
 			u16 queue_id, u16 flags);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 45ffd67b367d..8bda654e82ec 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -22,7 +22,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
-#include <net/xdp_sock.h>
+#include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 
 #include "xsk_queue.h"
-- 
2.25.1

