Return-Path: <bpf+bounces-40160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E397DDFE
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 18:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C43280D8D
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF117B418;
	Sat, 21 Sep 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTRNUrss"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD591547DA;
	Sat, 21 Sep 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937591; cv=none; b=jJt5Oql7x0J02NXZLmL9uvUD6xT/uQ+3P2uP4RdRDcPS7zLQxIF4agVKP2m+u9jljtvsbgG2F2fnvst3855dcah3BPABzo1+CxkpLyVDEeqXiXz0rnlW4dssLQh1dPxoVNUzik30mBLiEUNezZcdTW7vxfqsABZHj7MSvRlwiO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937591; c=relaxed/simple;
	bh=ySUc9WSYN+irTtZy0COsP164L2CZaBehasfOZt7YPEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH4C+TsGg/azkCfX6oKsMqerJsJ6QsMupPuMlSsdp5H39XwDVhPVoHJKvmCfIL/c90ruv/TKDMWTzEN+HAvAUgspyfSG3plEVT6z7BdERrWo465Lu8B1iu1R+L1HNfbrDp7z2AwhJT4Fr4PBLn0IljyfUgllMpeHw19668WNAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTRNUrss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C12C4CEC2;
	Sat, 21 Sep 2024 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726937589;
	bh=ySUc9WSYN+irTtZy0COsP164L2CZaBehasfOZt7YPEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTRNUrss/XvTAGiHVye1+lkmMl/JhzE5NDleFz32ZSOYX/4+hwvbG64f5CfQwxZqt
	 yXDQc/zVoVkH5PsJ0zP/4EZ6sidAUpHLW6ngeCXitVI+/4Cu2l5f/XbppsX8gYWGQ/
	 OBTjyuFgXwIkDMTnDHD6dmu9P82TBm3/4UjcYUOijbO35xjHRp+zO8OUIiEhU34OT1
	 PTv1HO+ml8E9B6f8atHHrlwkNdjW6D8V4PaIRKWURSNVhL2X7xijTFfg8JJsMjemS5
	 cbyNcO43H1xweWC7X7z24+YQQi9XxwgrW7fJ232JGE4+qChhzY/xxlPvnLTSWT/oc1
	 d9I9tL+rfR6GA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	toke@toke.dk,
	aleksander.lobakin@intel.com,
	sdf@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	mst@redhat.com,
	jasowang@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Subject: [RFC bpf-next 1/4] net: xdp: Add xdp_rx_meta structure
Date: Sat, 21 Sep 2024 18:52:57 +0200
Message-ID: <0e22c103ecafc5c79c6a27107348765913647afa.1726935917.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1726935917.git.lorenzo@kernel.org>
References: <cover.1726935917.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce xdp_rx_meta structure as a container to store the already
supported xdp rx hints (rx_hash and rx_vlan) in the xdp_buff and
xdp_frame structures (the rx_timestamp will be added to the skb_shared_info
area). Rely on the xdp_buff/xdp_frame flag field to indicate what kind of
rx hints have been populated by the driver. This is a preliminary patch to
preserve xdp rx hints running XDP_REDIRECT.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c917..5e08b58a2a10f 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -70,12 +70,27 @@ struct xdp_txq_info {
 	struct net_device *dev;
 };
 
+struct xdp_rx_meta {
+	struct {
+		u32 val;
+		u32 type;
+	} hash;
+	struct {
+		__be16 proto;
+		u16 tci;
+	} vlan;
+};
+
 enum xdp_buff_flags {
 	XDP_FLAGS_HAS_FRAGS		= BIT(0), /* non-linear xdp buff */
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	XDP_FLAGS_META_RX_HASH		= BIT(2), /* hw rx hash */
+	XDP_FLAGS_META_RX_VLAN		= BIT(3), /* hw rx vlan */
 };
+#define XDP_FLAGS_META_RX		(XDP_FLAGS_META_RX_HASH |	\
+					 XDP_FLAGS_META_RX_VLAN)
 
 struct xdp_buff {
 	void *data;
@@ -86,6 +101,7 @@ struct xdp_buff {
 	struct xdp_txq_info *txq;
 	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	struct xdp_rx_meta rx_meta; /* rx hw metadata */
 };
 
 static __always_inline bool xdp_buff_has_frags(struct xdp_buff *xdp)
@@ -113,6 +129,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline bool xdp_buff_has_rx_meta(struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_META_RX);
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -175,6 +196,7 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 	u32 frame_sz;
 	u32 flags; /* supported values defined in xdp_buff_flags */
+	struct xdp_rx_meta rx_meta; /* rx hw metadata */
 };
 
 static __always_inline bool xdp_frame_has_frags(struct xdp_frame *frame)
@@ -187,6 +209,11 @@ static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static __always_inline bool xdp_frame_has_rx_meta(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_META_RX);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
@@ -257,6 +284,8 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
 	xdp->flags = frame->flags;
+	if (xdp_frame_has_rx_meta(frame))
+		xdp->rx_meta = frame->rx_meta;
 }
 
 static inline
@@ -284,6 +313,8 @@ int xdp_update_frame_from_buff(struct xdp_buff *xdp,
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 	xdp_frame->flags = xdp->flags;
+	if (xdp_buff_has_rx_meta(xdp))
+		xdp_frame->rx_meta = xdp->rx_meta;
 
 	return 0;
 }
-- 
2.46.1


