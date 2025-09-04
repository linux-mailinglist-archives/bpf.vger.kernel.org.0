Return-Path: <bpf+bounces-67520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1358B44A1E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 01:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712FC1BC3E3C
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3289A2F656D;
	Thu,  4 Sep 2025 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXQVDcgD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E902F49E9;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026646; cv=none; b=NkqVjsxqa0GjfsyzbQtIn7/vSGeMjsbb0CYzxbHzv16/FVKeaKH0RsxZjviQvkD9vgTYossri6ikxu3jxHAhfGcjISOAV4Z0jt9Nl5X5wtbHvxu98QrrT3EQlu/ORChfumK2UGHEGM5RF7R3fiFm5Bj5D5+AObyKtt0WVi8iB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026646; c=relaxed/simple;
	bh=jTTWcsBhfpRQV/+7ulqrdO4GHQws0cUm6n02XvU3z7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMtlVU7s+ekXmgStGQV/7tWJFVAtCtQtO/205GzfULEEBvspxC+QNenGAm1KYZm85/F7g1t+bz7rcsanaGyrk0zy2/9Twhu99STj+64H2Qx+/OD2Kc3eqbhaf145P2rlt09f3UxrS51P0OL5+3RSNWTdxY6+CBK++4ZbVR3ewcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXQVDcgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20AC8C4CEF5;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757026646;
	bh=jTTWcsBhfpRQV/+7ulqrdO4GHQws0cUm6n02XvU3z7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NXQVDcgD47QY6ZvHzois8Jcm4UDGwr1H5pcMHpmPGCHv83Yi4myL97y46VQbyImTo
	 YLaxa4wTvCFmqug9SXKl6s+11Y48xOmDSUBuI65ZoOjsDeppiApymnw+9XIj6m0LRc
	 I4yylyE9xGh/iXNoQzzs1N3svQPq7z6F9aW0BLsEvc/WVndNemsSQ0kgEeVFeYVVAp
	 PFIBZUTdoYEm9vuBd0CziITbKUvRZjBCKoaylOyE6XKB6XwjnRHD5mnahzQsXhaJ+f
	 OQezSLx+zKqZbnmMX9Th63KALP/Oju3IUNDxIcnF+ra4AsPJeN2ebiUJZCcQeYwumo
	 oA+y+bOz5WbIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50DCA1012;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 04 Sep 2025 15:53:35 -0700
Subject: [PATCH net-next v5 1/2] net/mlx5: DMA-sync earlier in
 mlx5e_skb_from_cqe_mpwrq_nonlinear
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-1-ea492f7b11ac@openai.com>
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
In-Reply-To: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
To: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757026645; l=3190;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=bwP/MTcnhWm0Jr7vtsKF6W2tCFcL1pVUhCGGU7dhD2w=;
 b=8Le5246O25dlFxrJBQIdJLpFAe6UXYR+piOCn7qifyIM55p3iKSKcWZa7ZjlMhnhfduNbtu+B
 NJgdvljZNbaCshXWa2Td0/aDDtdyI54TPhpbDCnDRVWzx6BG1Fcc4q2
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

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
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



