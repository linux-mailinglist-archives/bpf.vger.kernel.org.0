Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A650490F83
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiAQRaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbiAQRaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Jan 2022 12:30:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE8AC061401;
        Mon, 17 Jan 2022 09:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7BEBB81136;
        Mon, 17 Jan 2022 17:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCACC36AE7;
        Mon, 17 Jan 2022 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642440603;
        bh=s5AmFZVUyY/UUvlptTEbG+/zJHg4mFgJLiJMFxu/o0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghktZ/YMZzTmg+85OcTTXnSzbAx+B4Jg95M16i8bhRKw7lZUDlkj29mXQWpT3A4uF
         RgGAbK1Gg0dTanD0POA6mbz7Lbf6pGd75dSyjAlU260DPB3SJiCqDKw81gB0fSdUlg
         rpDfy+0EIjO9BUKh5cWbBVO+tTn+W97sZRlr5VHJ6qQmphzQ3WDET8EgoYORTVk0nW
         lBbXMPNe7aWVrMKQELoWd+KrsXFn7GC+OLKgnYiFpzyxuDTD1CFlGqlhOf6j7BbT3X
         A8YWiKIFZcgt3prUxjDyENZ2ZyZoMtYeJrpZLk07kMknsevGFakSYrxo1a+avfEFSs
         gX6zwtvc8lSUQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH v22 bpf-next 12/23] bpf: add multi-frags support to the bpf_xdp_adjust_tail() API
Date:   Mon, 17 Jan 2022 18:28:24 +0100
Message-Id: <087fe9459f451a2dfed4054b693251029f57f848.1642439548.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642439548.git.lorenzo@kernel.org>
References: <cover.1642439548.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Eelco Chaudron <echaudro@redhat.com>

This change adds support for tail growing and shrinking for XDP multi-frags.

When called on a multi-frags packet with a grow request, it will work
on the last fragment of the packet. So the maximum grow size is the
last fragments tailroom, i.e. no new buffer will be allocated.
A XDP multi-frags capable driver is expected to set frag_size in
xdp_rxq_info data structure to notify the XDP core the fragment size.
frag_size set to 0 is interpreted by the XDP core as tail growing is
not allowed.
Introduce __xdp_rxq_info_reg utility routine to initialize frag_size field.

When shrinking, it will work from the last fragment, all the way down to
the base buffer depending on the shrinking size. It's important to mention
that once you shrink down the fragment(s) are freed, so you can not grow
again to the original size.

Acked-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 drivers/net/ethernet/marvell/mvneta.c |  3 +-
 include/net/xdp.h                     | 16 ++++++-
 net/core/filter.c                     | 65 +++++++++++++++++++++++++++
 net/core/xdp.c                        | 12 ++---
 4 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fc3d19467de7..9a3ec41d5f12 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3298,7 +3298,8 @@ static int mvneta_create_page_pool(struct mvneta_port *pp,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, pp->dev, rxq->id, 0);
+	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, pp->dev, rxq->id, 0,
+				 PAGE_SIZE);
 	if (err < 0)
 		goto err_free_pp;
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 6caea9b633e4..9bb9a2b81ef2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -60,6 +60,7 @@ struct xdp_rxq_info {
 	u32 reg_state;
 	struct xdp_mem_info mem;
 	unsigned int napi_id;
+	u32 frag_size;
 } ____cacheline_aligned; /* perf critical, avoid false-sharing */
 
 struct xdp_txq_info {
@@ -304,6 +305,8 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 	return xdp_frame;
 }
 
+void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
+		  struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
 void xdp_return_buff(struct xdp_buff *xdp);
@@ -340,8 +343,17 @@ static inline void xdp_release_frame(struct xdp_frame *xdpf)
 	__xdp_release_frame(xdpf->data, mem);
 }
 
-int xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
-		     struct net_device *dev, u32 queue_index, unsigned int napi_id);
+int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
+		       struct net_device *dev, u32 queue_index,
+		       unsigned int napi_id, u32 frag_size);
+static inline int
+xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
+		 struct net_device *dev, u32 queue_index,
+		 unsigned int napi_id)
+{
+	return __xdp_rxq_info_reg(xdp_rxq, dev, queue_index, napi_id, 0);
+}
+
 void xdp_rxq_info_unreg(struct xdp_rxq_info *xdp_rxq);
 void xdp_rxq_info_unused(struct xdp_rxq_info *xdp_rxq);
 bool xdp_rxq_info_is_reg(struct xdp_rxq_info *xdp_rxq);
diff --git a/net/core/filter.c b/net/core/filter.c
index 332f8e7802bc..7fa699396dff 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3830,11 +3830,76 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+static int bpf_xdp_multi_frags_increase_tail(struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags - 1];
+	struct xdp_rxq_info *rxq = xdp->rxq;
+	unsigned int tailroom;
+
+	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
+		return -EOPNOTSUPP;
+
+	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
+	if (unlikely(offset > tailroom))
+		return -EINVAL;
+
+	memset(skb_frag_address(frag) + skb_frag_size(frag), 0, offset);
+	skb_frag_size_add(frag, offset);
+	sinfo->xdp_frags_size += offset;
+
+	return 0;
+}
+
+static int bpf_xdp_multi_frags_shrink_tail(struct xdp_buff *xdp, int offset)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, n_frags_free = 0, len_free = 0;
+
+	if (unlikely(offset > (int)xdp_get_buff_len(xdp) - ETH_HLEN))
+		return -EINVAL;
+
+	for (i = sinfo->nr_frags - 1; i >= 0 && offset > 0; i--) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		int shrink = min_t(int, offset, skb_frag_size(frag));
+
+		len_free += shrink;
+		offset -= shrink;
+
+		if (skb_frag_size(frag) == shrink) {
+			struct page *page = skb_frag_page(frag);
+
+			__xdp_return(page_address(page), &xdp->rxq->mem,
+				     false, NULL);
+			n_frags_free++;
+		} else {
+			skb_frag_size_sub(frag, shrink);
+			break;
+		}
+	}
+	sinfo->nr_frags -= n_frags_free;
+	sinfo->xdp_frags_size -= len_free;
+
+	if (unlikely(!sinfo->nr_frags)) {
+		xdp_buff_clear_frags_flag(xdp);
+		xdp->data_end -= offset;
+	}
+
+	return 0;
+}
+
 BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 {
 	void *data_hard_end = xdp_data_hard_end(xdp); /* use xdp->frame_sz */
 	void *data_end = xdp->data_end + offset;
 
+	if (unlikely(xdp_buff_has_frags(xdp))) { /* xdp multi-frags */
+		if (offset < 0)
+			return bpf_xdp_multi_frags_shrink_tail(xdp, -offset);
+
+		return bpf_xdp_multi_frags_increase_tail(xdp, offset);
+	}
+
 	/* Notice that xdp_data_hard_end have reserved some tailroom */
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 3be94198d104..f989ac34dc39 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -162,8 +162,9 @@ static void xdp_rxq_info_init(struct xdp_rxq_info *xdp_rxq)
 }
 
 /* Returns 0 on success, negative on failure */
-int xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
-		     struct net_device *dev, u32 queue_index, unsigned int napi_id)
+int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
+		       struct net_device *dev, u32 queue_index,
+		       unsigned int napi_id, u32 frag_size)
 {
 	if (!dev) {
 		WARN(1, "Missing net_device from driver");
@@ -185,11 +186,12 @@ int xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
 	xdp_rxq->dev = dev;
 	xdp_rxq->queue_index = queue_index;
 	xdp_rxq->napi_id = napi_id;
+	xdp_rxq->frag_size = frag_size;
 
 	xdp_rxq->reg_state = REG_STATE_REGISTERED;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xdp_rxq_info_reg);
+EXPORT_SYMBOL_GPL(__xdp_rxq_info_reg);
 
 void xdp_rxq_info_unused(struct xdp_rxq_info *xdp_rxq)
 {
@@ -369,8 +371,8 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
  * is used for those calls sites.  Thus, allowing for faster recycling
  * of xdp_frames/pages in those cases.
  */
-static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
-			 struct xdp_buff *xdp)
+void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
+		  struct xdp_buff *xdp)
 {
 	struct xdp_mem_allocator *xa;
 	struct page *page;
-- 
2.34.1

