Return-Path: <bpf+bounces-65438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D2B22D1A
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8672A16B62A
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59732F7474;
	Tue, 12 Aug 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVPgQkwM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699212EB5C5;
	Tue, 12 Aug 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015344; cv=none; b=Jt3tHY4wbRbeBIVn2LKpnzGg8c1RfVxFnfimuZjzJnEg+p0sE+Q6kFoG8HLcNmy0cKcL++NrK/B5k7RrQKFBlaFPGTBqUupbPrYHAUSqJhfnnIcMorCyEZMqccR6W/7j0lD41NCNdswCBZI/6n6vzc6R8QWW9JYzl6PeJSp4Cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015344; c=relaxed/simple;
	bh=OH/wwHqRD7WHmtkg2z40iDvgF4fgD12OWh7nGgbdyV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOAmeEZraQpgRySU6ZQa/VHcyQIZLiXND8CaGeFWNKQ6vxv7J3WyVcmy1A+n75n5coC4eMZ2MDC8r+xAp974rjfw8VqD1+1r502iaTJbOGwvvh/IlQl+0fIPAAwCvnlIh+d4NruKElk7Zrv8jqOmRTrtG2hHlx1x/U0jVEHQhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVPgQkwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DCEC4CEF0;
	Tue, 12 Aug 2025 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015344;
	bh=OH/wwHqRD7WHmtkg2z40iDvgF4fgD12OWh7nGgbdyV8=;
	h=From:To:Cc:Subject:Date:From;
	b=QVPgQkwMw/uvSPcV92klRpzhniw2Fgb8Srav5QmZj8XSue+1+sDV9W2njhgKCjc9d
	 XYaEIkHDdnB8aaKtNI8ZZxkpACCp/xdyw0PsgmYS0n9/y0eaZ6JpaLzI9kxuO5U2z0
	 0uLtvyf9+8vmYypBXZfDbt215ohEuVrVEEdTsiuT+9yo3uSYMyCYfMl9XDp8uHit7R
	 UGjqjHB7kZMsTZqaGb6o809MvoYcbIzbfpdsNlT3RT6BUh6mCgKWTPNsSlFze5gcqF
	 1rnECf555pLL5h09/564SAj34VpY0x99Y4GtJYhwVdIryvTr+9papNVbFgh2bivOFW
	 HsOZyODqiMWqg==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	lorenzo@kernel.org,
	toke@redhat.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	michael.chan@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	marcin.s.wojtas@gmail.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	eperezma@redhat.com
Subject: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
Date: Tue, 12 Aug 2025 09:15:28 -0700
Message-ID: <20250812161528.835855-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_update_skb_shared_info() needs to update skb state which
was maintained in xdp_buff / frame. Pass full flags into it,
instead of breaking it out bit by bit. We will need to add
a bit for unreadable frags (even tho XDP doesn't support
those the driver paths may be common), at which point almost
all call sites would become:

    xdp_update_skb_shared_info(skb, num_frags,
                               sinfo->xdp_frags_size,
                               MY_PAGE_SIZE * num_frags,
                               xdp_buff_is_frag_pfmemalloc(xdp),
                               xdp_buff_is_frag_unreadable(xdp));

Keep a helper for accessing the flags, in case we need to
transform them somehow in the future (e.g. to cover up xdp_buff
vs xdp_frame differences).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Does anyone prefer the current form of the API, or can we change
as prosposed?

Bonus question: while Im messing with this API could I rename
xdp_update_skb_shared_info()? Maybe to xdp_update_skb_state() ?
Not sure why the function name has "shared_info" when most of
what it updates is skb fields.

CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: lorenzo@kernel.org
CC: toke@redhat.com
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: michael.chan@broadcom.com
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: marcin.s.wojtas@gmail.com
CC: tariqt@nvidia.com
CC: mbloch@nvidia.com
CC: eperezma@redhat.com
CC: bpf@vger.kernel.org
---
 include/net/xdp.h                             | 21 +++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  4 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  4 ++--
 drivers/net/ethernet/marvell/mvneta.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  7 +++----
 drivers/net/virtio_net.c                      |  2 +-
 net/core/xdp.c                                | 11 +++++-----
 8 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..2ff47f53ba26 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -104,17 +104,16 @@ static __always_inline void xdp_buff_clear_frags_flag(struct xdp_buff *xdp)
 	xdp->flags &= ~XDP_FLAGS_HAS_FRAGS;
 }
 
-static __always_inline bool
-xdp_buff_is_frag_pfmemalloc(const struct xdp_buff *xdp)
-{
-	return !!(xdp->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
-}
-
 static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 {
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
+{
+	return xdp->flags;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -272,10 +271,10 @@ static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
 }
 
-static __always_inline bool
-xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
+static __always_inline u32
+xdp_frame_get_skb_flags(const struct xdp_frame *frame)
 {
-	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
+	return frame->flags;
 }
 
 #define XDP_BULK_QUEUE_SIZE	16
@@ -314,7 +313,7 @@ static inline void xdp_scrub_frame(struct xdp_frame *frame)
 static inline void
 xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 			   unsigned int size, unsigned int truesize,
-			   bool pfmemalloc)
+			   u32 skb_flags)
 {
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 
@@ -328,7 +327,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 	skb->len += size;
 	skb->data_len += size;
 	skb->truesize += truesize;
-	skb->pfmemalloc |= pfmemalloc;
+	skb->pfmemalloc |= skb_flags & XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
 /* Avoids inlining WARN macro in fast-path */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 58d579dca3f1..b35d4a8a8dac 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -471,6 +471,6 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
 				   BNXT_RX_PAGE_SIZE * num_frags,
-				   xdp_buff_is_frag_pfmemalloc(xdp));
+				   xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 048c33039130..9cbd614a0d57 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2154,7 +2154,7 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
 		xdp_update_skb_shared_info(skb, skinfo->nr_frags + nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdp->frame_sz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 
 		/* First buffer has already been processed, so bump ntc */
 		if (++rx_ring->next_to_clean == rx_ring->count)
@@ -2209,7 +2209,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdp->frame_sz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 
 		i40e_process_rx_buffs(rx_ring, I40E_XDP_PASS, xdp);
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 29e0088ab6b2..014b321e487e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1038,7 +1038,7 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdp->frame_sz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 
 	return skb;
 }
@@ -1118,7 +1118,7 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 		xdp_update_skb_shared_info(skb, skinfo->nr_frags + nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdp->frame_sz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 	}
 
 	return skb;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 476e73e502fe..79a6bd530619 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2419,7 +2419,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 		xdp_update_skb_shared_info(skb, num_frags,
 					   sinfo->xdp_frags_size,
 					   num_frags * xdp->frame_sz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 
 	return skb;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..abbe24f71f6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1798,8 +1798,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(
-						&mxbuf->xdp));
+					   xdp_buff_get_skb_flags(&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -2107,7 +2106,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(
+						   xdp_buff_get_skb_flags(
 							&mxbuf->xdp));
 
 			pagep = head_page;
@@ -2124,7 +2123,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(
+						   xdp_buff_get_skb_flags(
 							&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d14e6d602273..152b0d5c2122 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2188,7 +2188,7 @@ static struct sk_buff *build_skb_from_xdp_buff(struct net_device *dev,
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size,
 					   xdp_frags_truesz,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 
 	return skb;
 }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 491334b9b8be..789051763209 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -665,7 +665,7 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size, tsize,
-					   xdp_buff_is_frag_pfmemalloc(xdp));
+					   xdp_buff_get_skb_flags(xdp));
 	}
 
 	skb->protocol = eth_type_trans(skb, rxq->dev);
@@ -692,7 +692,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 	struct skb_shared_info *sinfo = skb_shinfo(skb);
 	const struct skb_shared_info *xinfo;
 	u32 nr_frags, tsize = 0;
-	bool pfmemalloc = false;
+	u32 flags = 0;
 
 	xinfo = xdp_get_shared_info_from_buff(xdp);
 	nr_frags = xinfo->nr_frags;
@@ -714,11 +714,12 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
 		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
 
 		tsize += truesize;
-		pfmemalloc |= page_is_pfmemalloc(page);
+		if (page_is_pfmemalloc(page))
+			flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 	}
 
 	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
-				   tsize, pfmemalloc);
+				   tsize, flags);
 
 	return true;
 }
@@ -826,7 +827,7 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 		xdp_update_skb_shared_info(skb, nr_frags,
 					   sinfo->xdp_frags_size,
 					   nr_frags * xdpf->frame_sz,
-					   xdp_frame_is_frag_pfmemalloc(xdpf));
+					   xdp_frame_get_skb_flags(xdpf));
 
 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
-- 
2.50.1


