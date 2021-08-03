Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CC33DE3C9
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhHCBEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:65281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhHCBEA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327846"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327846"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480129"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 09/16] net/xdp: Support for generic XDP hints
Date:   Mon,  2 Aug 2021 18:03:24 -0700
Message-Id: <20210803010331.39453-10-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

XDP hints are meta information about an XDP packet. This patch provides
macros that define a base set of hints, that drivers can use to
implement XDP hints support - as well as expand on that.

A future patch will show these macros being used by the igc driver.

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 include/net/xdp.h           | 62 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/if_xdp.h |  3 ++
 2 files changed, 65 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index ad5b02dcb6f4..59a0b91e1975 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -76,6 +76,68 @@ struct xdp_buff {
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
 };
 
+/*
+ * This is what the generic xdp hints struct looks like:
+ *
+ * struct xdp_hints {
+ *	u64 rx_timestamp;
+ *	u64 tx_timestamp;
+ *	u64 valid_map;
+ *	u32 btf_id;
+ * };
+ */
+
+/* New fields need to be added at the beginning, not at the end,
+ * as the known position on the metadata is the end (just before
+ * the data starts) */
+
+#define XDP_GENERIC_HINTS_STRUCT_MEMBERS \
+	u64 rx_timestamp; \
+	u64 tx_timestamp; \
+	u64 valid_map; \
+	u32 btf_id;
+
+#define BTF_INFO_ENC(kind, kind_flag, vlen) \
+	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
+
+#define BTF_TYPE_ENC(name, info, size_or_type) \
+	(name), (info), (size_or_type)
+
+#define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
+	((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
+
+#define BTF_TYPE_INT_ENC(name, encoding, bits_offset, bits, sz) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz),       \
+	BTF_INT_ENC(encoding, bits_offset, bits)
+
+#define BTF_STRUCT_ENC(name, nr_elems, sz)      \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_STRUCT, 1, nr_elems), sz)
+
+#define BTF_MEMBER_ENC(name, type, bits_offset) \
+	(name), (type), (bits_offset)
+
+#define XDP_GENERIC_MD_SUPPORTED_HINTS_NUM_MMBRS 4
+#define XDP_GENERIC_HINTS_NAME_OFFSET 62
+
+#define XDP_GENERIC_HINTS_NAMES "\0xdp_hints\0u32\0u64\0rx_timestamp\0" \
+				"tx_timestamp\0valid_map\0btf_id\0"
+
+#define XDP_GENERIC_HINTS_TYPES \
+	BTF_TYPE_INT_ENC(15, 0, 0, 64, 8), \
+	BTF_TYPE_INT_ENC(11, 0, 0, 32, 4)
+
+#define XDP_GENERIC_HINTS_STRUCT(nr_elems, sz) \
+	BTF_STRUCT_ENC(1, XDP_GENERIC_MD_SUPPORTED_HINTS_NUM_MMBRS + nr_elems, \
+		8 + 8 + 8 + 4 + sz)
+
+#define XDP_GENERIC_HINTS_MEMBERS(offset) \
+	BTF_MEMBER_ENC(19, 1, offset + 0), \
+	BTF_MEMBER_ENC(32, 1, offset + 64), \
+	BTF_MEMBER_ENC(45, 1, offset + 128), \
+	BTF_MEMBER_ENC(55, 2, offset + 192)
+
+#define XDP_GENERIC_HINTS_BIT_MAX   XDP_GENERIC_HINTS_TX_TIMESTAMP
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index a78a8096f4ce..345c757b8c3e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -12,6 +12,9 @@
 
 #include <linux/types.h>
 
+#define XDP_GENERIC_HINTS_RX_TIMESTAMP (1 << 0)
+#define XDP_GENERIC_HINTS_TX_TIMESTAMP (1 << 1)
+
 /* Options for the sxdp_flags field */
 #define XDP_SHARED_UMEM	(1 << 0)
 #define XDP_COPY	(1 << 1) /* Force copy-mode */
-- 
2.32.0

