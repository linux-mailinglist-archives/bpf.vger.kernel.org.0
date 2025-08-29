Return-Path: <bpf+bounces-66932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A428B3B1B3
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45F17BCBA8
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3E221F34;
	Fri, 29 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JghHnSxg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF91FF1A0;
	Fri, 29 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438602; cv=none; b=gWsMDmAbAgWJpgb9QU1Ze5FXwM5RD3+63DZ5qLprTCzB1eCtHxnIq2CXR+HyUh16LKJ/3KpTJ3GOwcvuGZ3XKh3eb6LL/wBcDvzvJzwwm4rpxx6HsYV0g8clAHrjE1nXUj3uh1uNkaH8oIAo9xBa0y5yzbx+J8aB9XhLxLDDjaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438602; c=relaxed/simple;
	bh=IJD7kFOE2PJTMk4Ak4BtV04HYJ8FbDFuUpRsW6Xu3AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuoRq045u5c220GNV/cUf0uoM+KEtXYdauyTvkZDBi0DlGseNn+GZKqFi6Cwij3ggrdLwEc/9sjJaNcxCfbH5QHVMA+q+XuZzy5DeUQyc9lsmTqRSu/u3X+fDm75sbaPgnMRHXsu2MHFRtNt2Rb4Mu5E2y/av+8q/1bGmy9Pq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JghHnSxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8FDAC4CEF1;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756438601;
	bh=IJD7kFOE2PJTMk4Ak4BtV04HYJ8FbDFuUpRsW6Xu3AQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JghHnSxg2JC9OraP9VH23hmB9bqHRU7j2/MvHDQu7UiLZtJJmRH4DDR/Pf8x6yJ0d
	 4Lx3hckzht2gL7VIBzoSi25tXhzK89cw1Ju+T1MlaSjKsvtY4JSwiHnlFRBfoFhdWy
	 0QultZpcKD2vjSwtS5ykmi1uloMRbDYNCAEcakdMvlrNKc/B+Ca5snPQxGTgVWmr5p
	 +5LvrteuHLVx90GKkqZBnSZaFijKF37LP933JA0Z/irav+2d9HO/VHGLjENgF8icUj
	 lRD/FgIiBAtaKEaHGdNZJkquwTgOJX37m0y/8X4++MylwdfpCZRzmUh288hoXMhyjR
	 UN3jzeeWBetoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1571CA0FF0;
	Fri, 29 Aug 2025 03:36:41 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 28 Aug 2025 20:36:18 -0700
Subject: [PATCH net-next v4 1/2] net/mlx5: DMA-sync earlier in
 mlx5e_skb_from_cqe_mpwrq_nonlinear
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
To: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756438601; l=3092;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=wZ6sujNCZEX35sUzLOUfZGnKZmRTmAIAxJyg34hRjcA=;
 b=rnMQRxqgOg0aVxfMv5HMSU/R+nK3utU0awxFrR/2DiC4G6bhKid5XH8jAzulXAnxLoff7+OtT
 D8Llm1LxhKaBrLKGLVNXb6iJQ+dNDLXYEaLMEs6QbeFGlWoZeutw/qI
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

Doing the call to dma_sync_single_for_cpu() earlier will allow us to
adjust headlen based on the actual size of the protocol headers.

Doing this earlier means that we don't need to call
mlx5e_copy_skb_header() anymore and rather can call
skb_copy_to_linear_data() directly.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..8bedbda522808cbabc8e62ae91a8c25d66725ebb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2005,17 +2005,19 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
 	struct bpf_prog *prog;
+	void *va, *head_addr;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
 	u16 linear_data_len;
 	u16 linear_hr;
-	void *va;
 
 	prog = rcu_dereference(rq->xdp_prog);
 
+	head_addr = netmem_address(head_page->netmem) + head_offset;
+
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
+		net_prefetchw(head_addr);
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
 							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
@@ -2028,6 +2030,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		linear_data_len = 0;
 		linear_frame_sz = MLX5_SKB_FRAG_SZ(linear_hr + MLX5E_RX_MAX_HEAD);
 	} else {
+		dma_addr_t addr;
+
 		skb = napi_alloc_skb(rq->cq.napi,
 				     ALIGN(MLX5E_RX_MAX_HEAD, sizeof(long)));
 		if (unlikely(!skb)) {
@@ -2039,6 +2043,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		net_prefetchw(va); /* xdp_frame data area */
 		net_prefetchw(skb->data);
 
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		dma_sync_single_for_cpu(rq->pdev, addr + head_offset, headlen,
+					rq->buff.map_dir);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2117,8 +2125,6 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		}
 		__pskb_pull_tail(skb, headlen);
 	} else {
-		dma_addr_t addr;
-
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
 
@@ -2133,9 +2139,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
-		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
-				      head_offset, head_offset, headlen);
+		skb_copy_to_linear_data(skb, head_addr, headlen);
+
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
 		skb->len  += headlen;

-- 
2.50.1



