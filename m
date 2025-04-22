Return-Path: <bpf+bounces-56393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE785A96C72
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D1717C693
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05602836A3;
	Tue, 22 Apr 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="JwIS4UEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MCBeWFWA"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FE28152F;
	Tue, 22 Apr 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328238; cv=none; b=h0kAmNWBTgtaQq0CmSScaA8D2kkxodnLKOJBEjB2j2r1fMhHHLnuJ01lTv86AksBWQFbpPD4OIM/lNr7B/twA3vlyBg8qiBuEx6IkFxXC4M40NcSpXIG6FV9hgQlCZ7G/o/AlZJX8iuj1+6HWF6DT1olRDmvn7J6KklzTA9qEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328238; c=relaxed/simple;
	bh=OB5gSx0s4ZbsVGDRkPHGMd/iB+9Y4J/3PtheFw6Ggmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q64H22AnEgQi1QBN5vEn4KkNZZIqr0bkixA415wdlC9fi02uC+XxHzVxJVZMfncWTeCgSA+9nwsCj06EUwsV+p4lXPHrVLuXXDE/2Uw4ikCvDuI0z5QNYAsqQr4z2136jOLzH9C8wEbSqVNrbWwj6DQaD6NEOwHdb2gV1j6u0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=JwIS4UEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MCBeWFWA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC1A425401CA;
	Tue, 22 Apr 2025 09:23:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 09:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328234; x=1745414634; bh=6aStlzT7PniAM27ZPwf3jpyOc4IeIO+p
	KbqtOjWcK5Q=; b=JwIS4UEsHAkcQ+1IaqEuTeNWNdnxw2r8qXpV75IWZRdNyIlD
	mKoVP+eLDfBtnTb8lIINXiykAhJV76ix3wMCewxSExbmOlfZdthK6stRrsmsDQj1
	mpjWkJCxOBYwuVYrHqhJnt61IvuqkUulrM5yEBliK/4ysTkWUNR7QJ4W2Y6WL3oa
	ZVDYC100knx1wRQODyoSF88unws1maP8ytpqk415TL33SmzAjESGUD9pIGvepLQN
	yNgF3caEdrxKBKxX7YtXrbSIkdz9XQz5X64FCaGNNrIP363v+901kMSwVbt52rpk
	V60LMQR0miSG5SJUqxYe9v4/P4Nesujo0v5dkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328234; x=
	1745414634; bh=6aStlzT7PniAM27ZPwf3jpyOc4IeIO+pKbqtOjWcK5Q=; b=M
	CBeWFWA+pm4YLT4U6+i4q+HjgKKjgVJvJiF3d47wh9bSU4PGMTux/M5TE4CkOO8G
	0OePoUUZIu3t0Xm5LGG06nJX5XKhiZ/kjXvFm3GsM2SJoFs1WznA4e2B1WMgKuFQ
	usBpJzzhf/fq7ao6p7hsTGwAtK1QyXlZ/eesONwDJRQDPsscmJN+5Im75uH/2bgS
	mpBxBmFQ5hG3ufzpP8pGPZw8eudhSf4agVVYplQv+aGlfSyBmd+XsGVFhdVd9DLm
	mE/ekMpuGQVYw5RXoOlc6MiicRmVc41p8hfGokfgAUd8MYEAq083r9DDLJDDHa5v
	dS4ogVAGx+trCYZYVB1EA==
X-ME-Sender: <xms:apgHaFd0NMN6ma3Stkl2YM2Bkh1AoIWYH5zWY0U8yi1vfqneisXlLw>
    <xme:apgHaDPPBTiAi8gvCT32P6jvpQ_XBt-AIu9em5pyrT7RtNF5klFjRmtAMIKCaQHaW
    fwBe8Kmm7Ad_mm1w-0>
X-ME-Received: <xmr:apgHaOhiBUfBmDGgsmhMyaeimdVz9JyAj1FObJ8ccKt78mSMeDWbyq7H1k8re3s9It0lsn-aXrgNArljEl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:apgHaO_46rZeVqrAVhfKxnmLFIWflKjqK3wuRcLWrnpH82xXnVplKQ>
    <xmx:apgHaBt8Svgm2L6tDAHB6Eu9x-86lkq2IjP3Pvwt7EgaWLe4Cs-g1g>
    <xmx:apgHaNG1AfcC33-rrpL_fadVCDI-n-wp_aH2WA__ul862RLtFBHd8A>
    <xmx:apgHaIPBXQLUL6-noYS3hF2jTzmXLvpidjEvjMrK7ZmEas33HMEfMA>
    <xmx:apgHaIDdx5ivr49CfgG-q55zYkssXW6U-QAI4GPNbLu7eyAcZ-I4e_Jc>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:23:53 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:31 +0200
Subject: [PATCH RFC bpf-next v2 02/17] xdp: Track if metadata is supported
 in xdp_frame <> xdp_buff conversions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-2-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

xdp_buff stores whether metadata is supported by a NIC by setting
data_meta to be greater than data.

But xdp_frame only stores the metadata size (as metasize), so converting
between xdp_frame and xdp_buff is lossy.

This won't let us add "generic" functions for setting skb fields from
either xdp_frame or xdp_buff in drivers.

Switch to storing whether metadata is supported or not in a new
XDP_FLAG, as flags are copied as is between xdp_frame and xdp_buff.

This also resolves the slight awkward checks needed for calculating the
metadata length: data - data_meta can now always be used.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  5 -----
 include/net/xdp.h                              | 12 +++++++++---
 net/core/filter.c                              |  3 +--
 net/core/xdp.c                                 |  3 +--
 net/xdp/xsk.c                                  | 11 ++---------
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 4948b4906584e099515b1e1fc46428f6f0a56d1b..b009b88b5b410200500af717ca05ba72e7d2ffb8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2629,12 +2629,7 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 
 	switch (xdp_act) {
 	case XDP_PASS:
-#ifdef CONFIG_DPAA_ERRATUM_A050385
-		*xdp_meta_len = xdp_data_meta_unsupported(&xdp) ? 0 :
-				xdp.data - xdp.data_meta;
-#else
 		*xdp_meta_len = xdp.data - xdp.data_meta;
-#endif
 		break;
 	case XDP_TX:
 		/* We can access the full headroom when sending the frame
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 48efacbaa35da6c4ec76d8d8e78b86e8f7c23e4b..16c36813cbf8631ea170d2698f1d3408286129a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -76,6 +76,9 @@ enum xdp_buff_flags {
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	XDP_FLAGS_META_SUPPORTED	= BIT(2), /* metadata in headroom supported
+						   * by driver
+						   */
 };
 
 struct xdp_buff {
@@ -132,7 +135,10 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data_hard_start = hard_start;
 	xdp->data = data;
 	xdp->data_end = data + data_len;
-	xdp->data_meta = meta_valid ? data : data + 1;
+	xdp->data_meta = data;
+
+	if (meta_valid)
+		xdp->flags |= XDP_FLAGS_META_SUPPORTED;
 }
 
 /* Reserve memory area at end-of data area.
@@ -497,13 +503,13 @@ static inline void xdp_rxq_info_detach_mem_model(struct xdp_rxq_info *xdp_rxq)
 static __always_inline void
 xdp_set_data_meta_invalid(struct xdp_buff *xdp)
 {
-	xdp->data_meta = xdp->data + 1;
+	xdp->flags &= ~XDP_FLAGS_META_SUPPORTED;
 }
 
 static __always_inline bool
 xdp_data_meta_unsupported(const struct xdp_buff *xdp)
 {
-	return unlikely(xdp->data_meta > xdp->data);
+	return unlikely(!(xdp->flags & XDP_FLAGS_META_SUPPORTED));
 }
 
 static inline bool xdp_metalen_invalid(unsigned long metalen)
diff --git a/net/core/filter.c b/net/core/filter.c
index 79cab4d78dc3c6fe8a3a16e76fd0daf51af3282e..f9b3358e274fa4b85e39509b04192c282ba2009c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3937,8 +3937,7 @@ const struct bpf_func_proto bpf_xdp_get_buff_len_trace_proto = {
 
 static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)
 {
-	return xdp_data_meta_unsupported(xdp) ? 0 :
-	       xdp->data - xdp->data_meta;
+	return xdp->data - xdp->data_meta;
 }
 
 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a77eb63a96a85aa6d068d3e94f077..4ee9ff9dbd0e810425e00c1e8bcc0d7088ddaad4 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -580,8 +580,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	struct page *page;
 
 	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
-	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
-		   xdp->data - xdp->data_meta;
+	metasize = xdp->data - xdp->data_meta;
 	totsize = xdp->data_end - xdp->data + metasize;
 
 	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5696af45bcf711ce6b9df46a8783db0f4561e79a..eb771c7fcbd461b3899a5f45bf8a3071aeaa6a9a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -188,14 +188,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	return err;
 }
 
-static void *xsk_copy_xdp_start(struct xdp_buff *from)
-{
-	if (unlikely(xdp_data_meta_unsupported(from)))
-		return from->data;
-	else
-		return from->data_meta;
-}
-
 static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
 			u32 *from_len, skb_frag_t **frag, u32 rem)
 {
@@ -227,12 +219,13 @@ static u32 xsk_copy_xdp(void *to, void **from, u32 to_len,
 static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	u32 frame_size = xsk_pool_get_rx_frame_size(xs->pool);
-	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
+	void *copy_from, *copy_to;
 	u32 from_len, meta_len, rem, num_desc;
 	struct xdp_buff_xsk *xskb;
 	struct xdp_buff *xsk_xdp;
 	skb_frag_t *frag;
 
+	copy_from = xdp->data_meta;
 	from_len = xdp->data_end - copy_from;
 	meta_len = xdp->data - copy_from;
 	rem = len + meta_len;

-- 
2.43.0


