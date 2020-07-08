Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B32181C1
	for <lists+bpf@lfdr.de>; Wed,  8 Jul 2020 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGHHuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 03:50:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:17896 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgGHHup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 03:50:45 -0400
IronPort-SDR: cL2MzDurO1pk5PKSl2PK4Uy1CB3IPwNGyFoYsvLFX7V6V4OWOJcUgVAoCqV3VD+NBlq4r1RNAd
 ylg4OFZ7Lb+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147761879"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="147761879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:50:45 -0700
IronPort-SDR: y1XqIQZO0v8nXjza3I/nmXKUKbrUKVKhT60VF91BDI7m90HuM1mNzJt9exTYsSeX8F5jV5xml+
 OSUVJOEO8TRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="358030359"
Received: from silpixa00399839.ir.intel.com (HELO localhost.localdomain) ([10.237.222.116])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 00:50:44 -0700
From:   Ciara Loftus <ciara.loftus@intel.com>
To:     bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next 3/3] xsk: add xdp statistics to xsk_diag
Date:   Wed,  8 Jul 2020 07:28:35 +0000
Message-Id: <20200708072835.4427-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708072835.4427-1-ciara.loftus@intel.com>
References: <20200708072835.4427-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add xdp statistics to the information dumped through the xsk_diag interface

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 include/uapi/linux/xdp_diag.h | 11 +++++++++++
 net/xdp/xsk_diag.c            | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/uapi/linux/xdp_diag.h b/include/uapi/linux/xdp_diag.h
index 78b2591a7782..66b9973b4f4c 100644
--- a/include/uapi/linux/xdp_diag.h
+++ b/include/uapi/linux/xdp_diag.h
@@ -30,6 +30,7 @@ struct xdp_diag_msg {
 #define XDP_SHOW_RING_CFG	(1 << 1)
 #define XDP_SHOW_UMEM		(1 << 2)
 #define XDP_SHOW_MEMINFO	(1 << 3)
+#define XDP_SHOW_STATS		(1 << 4)
 
 enum {
 	XDP_DIAG_NONE,
@@ -41,6 +42,7 @@ enum {
 	XDP_DIAG_UMEM_FILL_RING,
 	XDP_DIAG_UMEM_COMPLETION_RING,
 	XDP_DIAG_MEMINFO,
+	XDP_DIAG_STATS,
 	__XDP_DIAG_MAX,
 };
 
@@ -69,4 +71,13 @@ struct xdp_diag_umem {
 	__u32	refs;
 };
 
+struct xdp_diag_stats {
+	__u64	n_rx_dropped;
+	__u64	n_rx_invalid;
+	__u64	n_rx_full;
+	__u64	n_fill_ring_empty;
+	__u64	n_tx_invalid;
+	__u64	n_tx_ring_empty;
+};
+
 #endif /* _LINUX_XDP_DIAG_H */
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 0163b26aaf63..21e9c2d123ee 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -76,6 +76,19 @@ static int xsk_diag_put_umem(const struct xdp_sock *xs, struct sk_buff *nlskb)
 	return err;
 }
 
+static int xsk_diag_put_stats(const struct xdp_sock *xs, struct sk_buff *nlskb)
+{
+	struct xdp_diag_stats du = {};
+
+	du.n_rx_dropped = xs->rx_dropped;
+	du.n_rx_invalid = xskq_nb_invalid_descs(xs->rx);
+	du.n_rx_full = xs->rx_queue_full;
+	du.n_fill_ring_empty = xs->umem ? xskq_nb_queue_empty_descs(xs->umem->fq) : 0;
+	du.n_tx_invalid = xskq_nb_invalid_descs(xs->tx);
+	du.n_tx_ring_empty = xskq_nb_queue_empty_descs(xs->tx);
+	return nla_put(nlskb, XDP_DIAG_STATS, sizeof(du), &du);
+}
+
 static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 			 struct xdp_diag_req *req,
 			 struct user_namespace *user_ns,
@@ -118,6 +131,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	    sock_diag_put_meminfo(sk, nlskb, XDP_DIAG_MEMINFO))
 		goto out_nlmsg_trim;
 
+	if ((req->xdiag_show & XDP_SHOW_STATS) &&
+	    xsk_diag_put_stats(xs, nlskb))
+		goto out_nlmsg_trim;
+
 	mutex_unlock(&xs->mutex);
 	nlmsg_end(nlskb, nlh);
 	return 0;
-- 
2.17.1

