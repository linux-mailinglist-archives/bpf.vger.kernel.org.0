Return-Path: <bpf+bounces-4998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE275399D
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE531C213C9
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809213AFB;
	Fri, 14 Jul 2023 11:37:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91F13AD6;
	Fri, 14 Jul 2023 11:37:10 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C8D30CB;
	Fri, 14 Jul 2023 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334629; x=1720870629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=voQcv4ZcFGVey2qm8OfatkEyaAG96edID39xcVlUR14=;
  b=hD3930sc3zgvlyxAvhvuYTNRrFvVcH9knVIVgfQTyZlWxk/PXcuFlI1a
   7IgZgmG9zyple5f4fzGxtFkSVTUqiJhqbxXIXqFuaAXnlIi5i/SkXX5le
   9Ft5mis8FroH5ljT3+zrh2zJlvVM2ZKNzCsrDuZc4P57jPLqrzgef/9Tn
   gRZY62l5ku6vx5TYwCDkO6493ttxsOyvI/9+BBeYof3+wKrQkIdNK5L67
   LwPLezEm9Scru5foXX8p+7r1aTDZnS98kEPTSycekM1PEMfIH2aMe+jS3
   G33+47uvW+3dsAuYSwWDZtLjMd3DpLOPQWjbKCDMQkOeLJ7zSYdNeO7Pp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345048138"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345048138"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846425152"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846425152"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 04:36:58 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH v6 bpf-next 05/24] xsk: add support for AF_XDP multi-buffer on Rx path
Date: Fri, 14 Jul 2023 13:36:21 +0200
Message-Id: <20230714113640.556893-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
References: <20230714113640.556893-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Add multi-buffer support for AF_XDP by extending the XDP multi-buffer
support to be reflected in user-space when a packet is redirected to
an AF_XDP socket.

In the XDP implementation, the NIC driver builds the xdp_buff from the
first frag of the packet and adds any subsequent frags in the skb_shinfo
area of the xdp_buff. In AF_XDP core, XDP buffers are allocated from
xdp_sock's pool and data is copied from the driver's xdp_buff and frags.

Once an allocated XDP buffer is full and there is still data to be
copied, the 'XDP_PKT_CONTD' flag in'options' field of the corresponding
xdp ring descriptor is set and passed to the application. When application
sees the aforementioned flag set it knows there is pending data for this
packet that will be carried in the following descriptors. If there is no
more data to be copied, the flag in 'options' field is cleared for that
descriptor signalling EOP to the application.

If application reads a batch of descriptors using for example the libxdp
interfaces, it is not guaranteed that the batch will end with a full
packet. It might end in the middle of a packet and the rest of the frames
of that packet will arrive at the beginning of the next batch.

AF_XDP ensures that only a complete packet (along with all its frags) is
sent to application.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 net/core/filter.c |   7 +--
 net/xdp/xsk.c     | 110 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..b4410dc841a0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4345,13 +4345,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	enum bpf_map_type map_type = ri->map_type;
 
-	if (map_type == BPF_MAP_TYPE_XSKMAP) {
-		/* XDP_REDIRECT is not supported AF_XDP yet. */
-		if (unlikely(xdp_buff_has_frags(xdp)))
-			return -EOPNOTSUPP;
-
+	if (map_type == BPF_MAP_TYPE_XSKMAP)
 		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
-	}
 
 	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
 				       xdp_prog);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 8e2cf002573e..ad40e78eaaa6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -159,43 +159,107 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	return __xsk_rcv_zc(xs, xskb, len, 0);
 }
 
-static void xsk_copy_xdp(struct xdp_buff *to, struct xdp_buff *from, u32 len)
+static void *xsk_copy_xdp_start(struct xdp_buff *from)
 {
-	void *from_buf, *to_buf;
-	u32 metalen;
+	if (unlikely(xdp_data_meta_unsupported(from)))
+		return from->data;
+	else
+		return from->data_meta;
+}
 
-	if (unlikely(xdp_data_meta_unsupported(from))) {
-		from_buf = from->data;
-		to_buf = to->data;
-		metalen = 0;
-	} else {
-		from_buf = from->data_meta;
-		metalen = from->data - from->data_meta;
-		to_buf = to->data - metalen;
-	}
+static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
+			u32 *from_len, skb_frag_t **frag, u32 rem)
+{
+	u32 copied = 0;
+
+	while (1) {
+		u32 copy_len = min_t(u32, *from_len, to_len);
+
+		memcpy(to, *from, copy_len);
+		copied += copy_len;
+		if (rem == copied)
+			return copied;
+
+		if (*from_len == copy_len) {
+			*from = skb_frag_address(*frag);
+			*from_len = skb_frag_size((*frag)++);
+		} else {
+			*from += copy_len;
+			*from_len -= copy_len;
+		}
+		if (to_len == copy_len)
+			return copied;
 
-	memcpy(to_buf, from_buf, len + metalen);
+		to_len -= copy_len;
+		to += copy_len;
+	}
 }
 
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
+	u32 frame_size = xsk_pool_get_rx_frame_size(xs->pool);
+	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
+	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
 	struct xdp_buff *xsk_xdp;
-	int err;
+	skb_frag_t *frag;
+
+	from_len = xdp->data_end - copy_from;
+	meta_len = xdp->data - copy_from;
+	rem = len + meta_len;
+
+	if (len <= frame_size && !xdp_buff_has_frags(xdp)) {
+		int err;
 
-	xsk_xdp = xsk_buff_alloc(xs->pool);
-	if (!xsk_xdp) {
+		xsk_xdp = xsk_buff_alloc(xs->pool);
+		if (!xsk_xdp) {
+			xs->rx_dropped++;
+			return -ENOMEM;
+		}
+		memcpy(xsk_xdp->data - meta_len, copy_from, rem);
+		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+		err = __xsk_rcv_zc(xs, xskb, len, 0);
+		if (err) {
+			xsk_buff_free(xsk_xdp);
+			return err;
+		}
+
+		return 0;
+	}
+
+	num_desc = (len - 1) / frame_size + 1;
+
+	if (!xsk_buff_can_alloc(xs->pool, num_desc)) {
 		xs->rx_dropped++;
 		return -ENOMEM;
 	}
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		return -ENOBUFS;
+	}
 
-	xsk_copy_xdp(xsk_xdp, xdp, len);
-	xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
-	err = __xsk_rcv_zc(xs, xskb, len, 0);
-	if (err) {
-		xsk_buff_free(xsk_xdp);
-		return err;
+	if (xdp_buff_has_frags(xdp)) {
+		struct skb_shared_info *sinfo;
+
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		frag =  &sinfo->frags[0];
 	}
+
+	do {
+		u32 to_len = frame_size + meta_len;
+		u32 copied;
+
+		xsk_xdp = xsk_buff_alloc(xs->pool);
+		copy_to = xsk_xdp->data - meta_len;
+
+		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
+		rem -= copied;
+
+		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
+		__xsk_rcv_zc(xs, xskb, copied - meta_len, rem ? XDP_PKT_CONTD : 0);
+		meta_len = 0;
+	} while (rem);
+
 	return 0;
 }
 
@@ -225,7 +289,7 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
 
-	if (len > xsk_pool_get_rx_frame_size(xs->pool)) {
+	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
-- 
2.34.1


