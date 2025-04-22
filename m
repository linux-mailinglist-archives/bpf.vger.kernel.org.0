Return-Path: <bpf+bounces-56405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB7A96C95
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C6617D054
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866128A408;
	Tue, 22 Apr 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="SuCCUHhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uwKFMBhy"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733928A405;
	Tue, 22 Apr 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328267; cv=none; b=bZYZCqe+qz4RXM7UN8NJSlhw/i7gaoq8pcObNqDfrV25HzUrloEsc/5rt6f7CxIT11s/COpImu5OswjdaQoPoCSvhnIOUl9VXI1SoxKjl8b+jD3HO+Teqb/pUvXACRuhbUaCcxgi5mX289nSrEqG8LfkFJTPNt0JvYzEhziU0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328267; c=relaxed/simple;
	bh=JUAW5zKhoh1gEt+uDqxamWyv7bQBdByaqpWySARwDRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDBelqeELLopIceUYtD9a52VItjT6Vo9FdXvFJCWSmtHd8dSKBLa7dBl8KKmMaYiQ8HdMlQwvgriL4debFPjxNQTXqBRk+RPf3HxTbMzJk/e3ZJKCPLX0g4yltQf8nJ6mhChOTaQc77xheEeNKokruUp3Zkz4O/xGVhd3CmanMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=SuCCUHhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uwKFMBhy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06DD025401E0;
	Tue, 22 Apr 2025 09:24:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328263; x=1745414663; bh=8f28jDQPEmvbf4LJMMI2IiTAzkwJLo8/
	AF+qQUgJU5E=; b=SuCCUHhgu32dkR1OS9+8AGICasYXZa/bjMjg5ymqPUH0h0Vj
	RbSY91Q8YFvw0HRMZNwPKOQ9yJ6dCPgc8HvNB7hyxsTlm3iDPhJcgXa0093Zd6Nd
	XA4e7f1ZCmOem1l/9NSJ9kQO+MciV9LDduycf8XCiEJ99Gm5v0ufI+ENAUP5xYa7
	jP7dNWwL6upxpuEXxJchp2G5wdbDk5eGwhR9lecdsJBToG8dBTKeR1DLh6AKGCMd
	inbkPPqrgmeQAbo0vxt2FKDAqcuMJmSu+gv7z9Pq7J17LJFSkckHaYN5F6iCR7Er
	hydujAvf53qqu9FgQkHg1RJpHevTmCsiv2Scxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328263; x=
	1745414663; bh=8f28jDQPEmvbf4LJMMI2IiTAzkwJLo8/AF+qQUgJU5E=; b=u
	wKFMBhyWX96hQJC+WAcNXC8ZWBek0F4fL43iVMhRi5+lWznwVZsUDZSNHiWZTtyT
	i3v77at9tIELpHq9VvBFhIDDBjN6z0yVdC1GND24iu/4WDSPFSww1HzkdlUg0FKI
	+XD90gAt4T7uaWXNRjSbq4ijAXT8m6RtFNG2mVlDW8gQdNoUhxvVUultCXHKW0SN
	9BMNmXsJE6b8tEO0BNmMfXkq5+g2aeX7DZXhc5vnYfsEcXNMM42a4g4iqsnjaDZP
	vwlMSo1LJ6pIXPaSO3IOmhFdKd7kohYJ2OLIgyUDAapmQwsL3VHWrX4l0xjcvLLF
	hMDsUtR7CUYn8xDdF4Xkw==
X-ME-Sender: <xms:h5gHaHeunmnzsfvpWWzqakWKHmcDEntre42b0Abf9_2zsjKamY7hhw>
    <xme:h5gHaNNO-dguKB0dHRATZuj_P04SImbwVkMvIHUQkDEDGeipxdfWlu1T9D1G4SsaD
    6lOmVNpEBuBz88hgc8>
X-ME-Received: <xmr:h5gHaAh63Pr8xKyiRfvlOKfj-KGjOulR91jGuN5cuI85yWcYTUkOHQPiK3W0YLg3AsLk3fB6BsuFkb8m-_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekveffjeegtdegveejtefgleelgeehjeetteejffefgfeftdfgudegvefhgfdu
    geenucffohhmrghinhepgiguphdruggrthgrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgt
    ohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihrghnsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehhrgifkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggu
    uhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehthhhoihhlrghnugesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepjhgsrhgrnhguvggsuhhrghestghlohhuughf
    lhgrrhgvrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h5gHaI-Rxpl-0T8qwrBfCcmwqEG1iZfwfkoT_WO4ygq53f5Oyp3i4g>
    <xmx:h5gHaDs4ak6i5gLehiNgk38ATnJgGUyqLvH-jo3QIMclhNP-F5QoyQ>
    <xmx:h5gHaHGPCVMAzdFX0_4ddyKHC8ySS0dwfNEQAgnP-wyzBHo4yykcaw>
    <xmx:h5gHaKMqu57FchZpBBUMAkCKNcrBY35GnGvwNeEJyh58KBek3O9O1g>
    <xmx:h5gHaLB5usm3-kHhOeOr_F0tZOhoGcjofzqltf3-AsNbI94AW2Q0_wKa>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:22 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:43 +0200
Subject: [PATCH RFC bpf-next v2 14/17] mlx5: move xdp_buff scope one level
 up
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-14-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com
X-Mailer: b4 0.14.2

From: Jesper Dangaard Brouer <hawk@kernel.org>

This is in preparation for changes.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.h    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 103 +++++++++++----------
 4 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 32ed4963b8adaa8111f1b8a83735773b1a6da19b..95d1e61bcb23205caeedadac1b6f0e07832ed48f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -585,14 +585,16 @@ struct mlx5e_mpw_info {
 #define MLX5E_MAX_RX_FRAGS 4
 
 struct mlx5e_rq;
+struct mlx5e_xdp_buff;
 typedef void (*mlx5e_fp_handle_rx_cqe)(struct mlx5e_rq*, struct mlx5_cqe64*);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe_mpwrq)(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			       struct mlx5_cqe64 *cqe, u16 cqe_bcnt,
-			       u32 head_offset, u32 page_idx);
+			       u32 head_offset, u32 page_idx,
+			       struct mlx5e_xdp_buff *mxbuf);
 typedef struct sk_buff *
 (*mlx5e_fp_skb_from_cqe)(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			 struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+			 struct mlx5_cqe64 *cqe, u32 cqe_bcnt, struct mlx5e_xdp_buff *mxbuf);
 typedef bool (*mlx5e_fp_post_rx_wqes)(struct mlx5e_rq *rq);
 typedef void (*mlx5e_fp_dealloc_wqe)(struct mlx5e_rq*, u16);
 typedef void (*mlx5e_fp_shampo_dealloc_hd)(struct mlx5e_rq*, u16, u16, bool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
index 2b05536d564ac795c5f1dabd81444db40beeaa6a..8fe7c36de3140c66f198de5cff0d212d548d7eff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
@@ -249,7 +249,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
-						    u32 page_idx)
+						    u32 page_idx,
+						    struct mlx5e_xdp_buff *mxbuf_)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(wi->alloc_units.xsk_buffs[page_idx]);
 	struct bpf_prog *prog;
@@ -304,7 +305,8 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
 					      struct mlx5_cqe64 *cqe,
-					      u32 cqe_bcnt)
+					      u32 cqe_bcnt,
+					      struct mlx5e_xdp_buff *mxbuf_)
 {
 	struct mlx5e_xdp_buff *mxbuf = xsk_buff_to_mxbuf(*wi->xskp);
 	struct bpf_prog *prog;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
index cefc0ef6105d24705bdd450cfd7857435a9d0c67..0890c975042c7f58e512a61fc538f21b5e37c6b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.h
@@ -16,10 +16,12 @@ struct sk_buff *mlx5e_xsk_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq,
 						    struct mlx5_cqe64 *cqe,
 						    u16 cqe_bcnt,
 						    u32 head_offset,
-						    u32 page_idx);
+						    u32 page_idx,
+						    struct mlx5e_xdp_buff *mxbuf_);
 struct sk_buff *mlx5e_xsk_skb_from_cqe_linear(struct mlx5e_rq *rq,
 					      struct mlx5e_wqe_frag_info *wi,
 					      struct mlx5_cqe64 *cqe,
-					      u32 cqe_bcnt);
+					      u32 cqe_bcnt,
+					      struct mlx5e_xdp_buff *mxbuf_);
 
 #endif /* __MLX5_EN_XSK_RX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55beb4ed277a5ea896a6859350b72d21..7b5b81a42bedc2fb8da1ee2360a7d1fb46c24bd2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -63,11 +63,11 @@
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				u32 page_idx);
+				u32 page_idx, struct mlx5e_xdp_buff *mxbuf);
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				   u32 page_idx);
+				   u32 page_idx, struct mlx5e_xdp_buff *mxbuf);
 static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
 static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe);
@@ -1662,7 +1662,8 @@ static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 
 static struct sk_buff *
 mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
+			  struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = wi->frag_page;
 	u16 rx_headroom = rq->buff.headroom;
@@ -1684,17 +1685,15 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
-
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf))
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf))
 			return NULL; /* page/packet was consumed by XDP */
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -1710,14 +1709,14 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 
 static struct sk_buff *
 mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
-			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+			     struct mlx5_cqe64 *cqe, u32 cqe_bcnt,
+			     struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
 	struct mlx5e_wqe_frag_info *head_wi = wi;
 	u16 rx_headroom = rq->buff.headroom;
 	struct mlx5e_frag_page *frag_page;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	u32 frag_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -1737,8 +1736,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	net_prefetch(va + rx_headroom);
 
 	mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-			 frag_consumed_bytes, &mxbuf);
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+			 frag_consumed_bytes, mxbuf);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 	truesize = 0;
 
 	cqe_bcnt -= frag_consumed_bytes;
@@ -1750,7 +1749,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 		frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page,
 					       wi->offset, frag_consumed_bytes);
 		truesize += frag_info->frag_stride;
 
@@ -1760,7 +1759,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
@@ -1770,21 +1769,21 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 		return NULL; /* page/packet was consumed by XDP */
 	}
 
-	skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start, rq->buff.frame0_sz,
-				     mxbuf.xdp.data - mxbuf.xdp.data_hard_start,
-				     mxbuf.xdp.data_end - mxbuf.xdp.data,
-				     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+	skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
+				     mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
+				     mxbuf->xdp.data_end - mxbuf->xdp.data,
+				     mxbuf->xdp.data - mxbuf->xdp.data_meta);
 	if (unlikely(!skb))
 		return NULL;
 
 	skb_mark_for_recycle(skb);
 	head_wi->frag_page->frags++;
 
-	if (xdp_buff_has_frags(&mxbuf.xdp)) {
+	if (xdp_buff_has_frags(&mxbuf->xdp)) {
 		/* sinfo->nr_frags is reset by build_skb, calculate again. */
 		xdp_update_skb_shared_info(skb, wi - head_wi - 1,
 					   sinfo->xdp_frags_size, truesize,
-					   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+					   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 		for (struct mlx5e_wqe_frag_info *pwi = head_wi + 1; pwi < wi; pwi++)
 			pwi->frag_page->frags++;
@@ -1815,6 +1814,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1832,7 +1832,7 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_linear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1863,6 +1863,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	struct mlx5_eswitch_rep *rep = rpriv->rep;
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -1879,7 +1880,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb) {
 		/* probably for XDP */
 		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
@@ -1907,6 +1908,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -1932,7 +1934,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	skb = INDIRECT_CALL_2(rq->mpwqe.skb_from_cqe_mpwrq,
 			      mlx5e_skb_from_cqe_mpwrq_linear,
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
-			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx);
+			      rq, wi, cqe, cqe_bcnt, head_offset, page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -1979,7 +1981,7 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				   u32 page_idx)
+				   u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
@@ -1987,7 +1989,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
-	struct mlx5e_xdp_buff mxbuf;
 	unsigned int truesize = 0;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
@@ -2033,9 +2034,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 	}
 
-	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, &mxbuf);
+	mlx5e_fill_mxbuf(rq, cqe, va, linear_hr, linear_frame_sz, linear_data_len, mxbuf);
 
-	sinfo = xdp_get_shared_info_from_buff(&mxbuf.xdp);
+	sinfo = xdp_get_shared_info_from_buff(&mxbuf->xdp);
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
@@ -2046,7 +2047,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		else
 			truesize += ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
 
-		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf.xdp, frag_page, frag_offset,
+		mlx5e_add_skb_shared_info_frag(rq, sinfo, &mxbuf->xdp, frag_page, frag_offset,
 					       pg_consumed_bytes);
 		byte_cnt -= pg_consumed_bytes;
 		frag_offset = 0;
@@ -2054,7 +2055,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
@@ -2067,10 +2068,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		skb = mlx5e_build_linear_skb(rq, mxbuf.xdp.data_hard_start,
+		skb = mlx5e_build_linear_skb(rq, mxbuf->xdp.data_hard_start,
 					     linear_frame_sz,
-					     mxbuf.xdp.data - mxbuf.xdp.data_hard_start, 0,
-					     mxbuf.xdp.data - mxbuf.xdp.data_meta);
+					     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+					     mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL;
@@ -2080,13 +2081,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		wi->linear_page.frags++;
 		mlx5e_page_release_fragmented(rq, &wi->linear_page);
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			/* sinfo->nr_frags is reset by build_skb, calculate again. */
 			xdp_update_skb_shared_info(skb, frag_page - head_page,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 			pagep = head_page;
 			do
@@ -2097,12 +2098,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	} else {
 		dma_addr_t addr;
 
-		if (xdp_buff_has_frags(&mxbuf.xdp)) {
+		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
 			xdp_update_skb_shared_info(skb, sinfo->nr_frags,
 						   sinfo->xdp_frags_size, truesize,
-						   xdp_buff_is_frag_pfmemalloc(&mxbuf.xdp));
+						   xdp_buff_is_frag_pfmemalloc(&mxbuf->xdp));
 
 			pagep = frag_page - sinfo->nr_frags;
 			do
@@ -2124,7 +2125,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
-				u32 page_idx)
+				u32 page_idx, struct mlx5e_xdp_buff *mxbuf)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 rx_headroom = rq->buff.headroom;
@@ -2152,20 +2153,19 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog) {
-		struct mlx5e_xdp_buff mxbuf;
 
 		net_prefetchw(va); /* xdp_frame data area */
 		mlx5e_fill_mxbuf(rq, cqe, va, rx_headroom, rq->buff.frame0_sz,
-				 cqe_bcnt, &mxbuf);
-		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
+				 cqe_bcnt, mxbuf);
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
 				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-		rx_headroom = mxbuf.xdp.data - mxbuf.xdp.data_hard_start;
-		metasize = mxbuf.xdp.data - mxbuf.xdp.data_meta;
-		cqe_bcnt = mxbuf.xdp.data_end - mxbuf.xdp.data;
+		rx_headroom = mxbuf->xdp.data - mxbuf->xdp.data_hard_start;
+		metasize = mxbuf->xdp.data - mxbuf->xdp.data_meta;
+		cqe_bcnt = mxbuf->xdp.data_end - mxbuf->xdp.data;
 	}
 	frag_size = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 	skb = mlx5e_build_linear_skb(rq, va, frag_size, rx_headroom, cqe_bcnt, metasize);
@@ -2288,12 +2288,14 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	bool flush		= cqe->shampo.flush;
 	bool match		= cqe->shampo.match;
 	struct mlx5e_rq_stats *stats = rq->stats;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5e_mpw_info *wi;
 	struct mlx5_wq_ll *wq;
 
 	wi = mlx5e_get_mpw_info(rq, wqe_id);
 	wi->consumed_strides += cstrides;
+	mxbuf.xdp.flags = 0;
 
 	if (unlikely(MLX5E_RX_ERR_CQE(cqe))) {
 		mlx5e_handle_rx_err_cqe(rq, cqe);
@@ -2316,7 +2318,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
 		else
 			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+								  data_offset, page_idx, &mxbuf);
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
@@ -2377,6 +2379,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
 	u32 head_offset    = wqe_offset & ((1 << rq->mpwqe.page_shift) - 1);
 	u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+	struct mlx5e_xdp_buff mxbuf;
 	struct mlx5e_rx_wqe_ll *wqe;
 	struct mlx5_wq_ll *wq;
 	struct sk_buff *skb;
@@ -2404,7 +2407,7 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 			      mlx5e_skb_from_cqe_mpwrq_nonlinear,
 			      mlx5e_xsk_skb_from_cqe_mpwrq_linear,
 			      rq, wi, cqe, cqe_bcnt, head_offset,
-			      page_idx);
+			      page_idx, &mxbuf);
 	if (!skb)
 		goto mpwrq_cqe_out;
 
@@ -2632,6 +2635,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 ci;
@@ -2648,7 +2652,7 @@ static void mlx5i_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 	skb = INDIRECT_CALL_2(rq->wqe.skb_from_cqe,
 			      mlx5e_skb_from_cqe_linear,
 			      mlx5e_skb_from_cqe_nonlinear,
-			      rq, wi, cqe, cqe_bcnt);
+			      rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 
@@ -2722,6 +2726,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 {
 	struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 	struct mlx5e_wqe_frag_info *wi;
+	struct mlx5e_xdp_buff mxbuf;
 	struct sk_buff *skb;
 	u32 cqe_bcnt;
 	u16 trap_id;
@@ -2737,7 +2742,7 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 		goto wq_cyc_pop;
 	}
 
-	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt);
+	skb = mlx5e_skb_from_cqe_nonlinear(rq, wi, cqe, cqe_bcnt, &mxbuf);
 	if (!skb)
 		goto wq_cyc_pop;
 

-- 
2.43.0


