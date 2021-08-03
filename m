Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8D3DE3CA
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhHCBED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233450AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327856"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327856"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480134"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 13/16] libbpf: Helpers to access XDP frame metadata
Date:   Mon,  2 Aug 2021 18:03:28 -0700
Message-Id: <20210803010331.39453-14-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Two new pairs of helpers: `xsk_umem__adjust_prod_data` and
`xsk_umem__adjust_prod_data_meta` for data that is being produced by the
application - such as data that will be sent; and
`xsk_umem__adjust_cons_data` and `xsk_umem__adjust_cons_data_meta`,
for data being consumed - such as data obtained from the completion
queue.

Those function should usually be used on data obtained via
`xsk_umem__get_data`. Didn't change this function to avoid API breaks.

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 tools/lib/bpf/libbpf.map |  4 ++++
 tools/lib/bpf/xsk.c      | 26 ++++++++++++++++++++++++++
 tools/lib/bpf/xsk.h      |  7 +++++++
 3 files changed, 37 insertions(+)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 492db50a4cd7..663585f7f186 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -375,4 +375,8 @@ LIBBPF_0.5.0 {
 		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__gen_loader;
 		libbpf_set_strict_mode;
+		xsk_umem__adjust_cons_data;
+		xsk_umem__adjust_cons_data_meta;
+		xsk_umem__adjust_prod_data;
+		xsk_umem__adjust_prod_data_meta;
 } LIBBPF_0.4.0;
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index e9b619aa0cdf..17e8045eac0e 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -119,6 +119,30 @@ int xsk_socket__fd(const struct xsk_socket *xsk)
 	return xsk ? xsk->fd : -EINVAL;
 }
 
+void *xsk_umem__adjust_prod_data(void *umem_data, const struct xsk_umem *umem)
+{
+	return umem_data + umem->config.frame_headroom + umem->config.xdp_headroom;
+}
+
+void *xsk_umem__adjust_prod_data_meta(void *umem_data, const struct xsk_umem *umem)
+{
+	if (!umem->config.xdp_headroom)
+		return NULL;
+	return umem_data;
+}
+
+void *xsk_umem__adjust_cons_data(void *umem_data, const struct xsk_umem *umem)
+{
+	return umem_data;
+}
+
+void *xsk_umem__adjust_cons_data_meta(void *umem_data, const struct xsk_umem *umem)
+{
+	if (!umem->config.xdp_headroom)
+		return NULL;
+	return umem_data;
+}
+
 static bool xsk_page_aligned(void *buffer)
 {
 	unsigned long addr = (unsigned long)buffer;
@@ -135,6 +159,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 		cfg->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 		cfg->frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM;
 		cfg->flags = XSK_UMEM__DEFAULT_FLAGS;
+		cfg->xdp_headroom = XSK_UMEM__DEFAULT_XDP_HEADROOM;
 		return;
 	}
 
@@ -143,6 +168,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 	cfg->frame_size = usr_cfg->frame_size;
 	cfg->frame_headroom = usr_cfg->frame_headroom;
 	cfg->flags = usr_cfg->flags;
+	cfg->xdp_headroom = usr_cfg->xdp_headroom;
 }
 
 static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
index 01c12dca9c10..7f4143150746 100644
--- a/tools/lib/bpf/xsk.h
+++ b/tools/lib/bpf/xsk.h
@@ -248,12 +248,18 @@ static inline __u64 xsk_umem__add_offset_to_addr(__u64 addr)
 LIBBPF_API int xsk_umem__fd(const struct xsk_umem *umem);
 LIBBPF_API int xsk_socket__fd(const struct xsk_socket *xsk);
 
+LIBBPF_API void *xsk_umem__adjust_prod_data(void *umem_data, const struct xsk_umem *umem);
+LIBBPF_API void *xsk_umem__adjust_prod_data_meta(void *umem_data, const struct xsk_umem *umem);
+LIBBPF_API void *xsk_umem__adjust_cons_data(void *umem_data, const struct xsk_umem *umem);
+LIBBPF_API void *xsk_umem__adjust_cons_data_meta(void *umem_data, const struct xsk_umem *umem);
+
 #define XSK_RING_CONS__DEFAULT_NUM_DESCS      2048
 #define XSK_RING_PROD__DEFAULT_NUM_DESCS      2048
 #define XSK_UMEM__DEFAULT_FRAME_SHIFT    12 /* 4096 bytes */
 #define XSK_UMEM__DEFAULT_FRAME_SIZE     (1 << XSK_UMEM__DEFAULT_FRAME_SHIFT)
 #define XSK_UMEM__DEFAULT_FRAME_HEADROOM 0
 #define XSK_UMEM__DEFAULT_FLAGS 0
+#define XSK_UMEM__DEFAULT_XDP_HEADROOM 0
 
 struct xsk_umem_config {
 	__u32 fill_size;
@@ -261,6 +267,7 @@ struct xsk_umem_config {
 	__u32 frame_size;
 	__u32 frame_headroom;
 	__u32 flags;
+	__u32 xdp_headroom;
 };
 
 LIBBPF_API int xsk_setup_xdp_prog(int ifindex,
-- 
2.32.0

