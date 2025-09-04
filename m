Return-Path: <bpf+bounces-67519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D59B44A07
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC43BDB23
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F792F656F;
	Thu,  4 Sep 2025 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbHubK3/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E192F3C3F;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026646; cv=none; b=cOsNraWRgeKzi95vvMj8TjB33zyLIbLFuHLOkoWP0lvLrbW17IayT9drkwFG6FfzPYJ8ZMxTSLxkbsD/PLH/YEQrQuq+zQJefMGhvuxL2drNJLXqracohjjHMwRN5RDQB0wspTcZOuaXVC2+/gBBvRdgya0PxAsRUGXrK5OIkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026646; c=relaxed/simple;
	bh=2yGEvFHHHhgvbQ3a6raTZkHh/9Kf0o5M7UdOoOos1pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtFkg+Aqsnf9Qa0oUjPURKIFFAXDZnKKNbzvG34CMxjJJiSmXdvvCXpW99O751SGf/3E7VpqK/mb7ND7n0g+lFUdkFU5Znf6XLTHD3eJL4ckDHp4vtawhJuSKxTUQUFw7HElZWH8uLu830+BIYqGASU6F6D19sCEJpY38tOVsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbHubK3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31493C4CEF4;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757026646;
	bh=2yGEvFHHHhgvbQ3a6raTZkHh/9Kf0o5M7UdOoOos1pc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jbHubK3/eo1eNnYNv3ULPGJWSNWMlqtJqDazdHsDFLhM754e77/99GtTly05Ia1eZ
	 VmST7OGIg+qp8WSqTzEPukaT+bRHiywiBGoefANKvAIGPrYL9Sq70kgxICYjYRbsZv
	 m4MwByKsAOujwukrYu+pJoEgDbtaqVRKXgcRLk/EDmql4Kg1pKCTDpxp22xdvpzQaX
	 hpQX5BootlJdcCta4L89FiloGlX7vMYdQYJEAHtW8l2RG9Ja5J9UM1FnnH4rAtklcL
	 vopKJPKcSF09Z0UK011jN58BzCokKHqv/Uu1e3EesACIiV+p3zSMVyMh+wNiDfBH6l
	 lb06Otk4xP6Fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB66CA1016;
	Thu,  4 Sep 2025 22:57:26 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 04 Sep 2025 15:53:36 -0700
Subject: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757026645; l=3145;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=IL2BQ6RwilnanWsFwUGaKxGp5LH0ZxwNNbUaCebgEgY=;
 b=iGLeJUjmReoTy77GeZlEeA7KYV6oYMc0TPFBJ1DVL9tTxSE5Hgf1zQh6tdPTNdJekk0ijz4Yg
 QdiWnSNrDULCm4Dj4OU9U1nB8rHK7JB/8ZiVvmLu+HfkifB2DxXREOS
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
bytes from the page-pool to the skb's linear part. Those 256 bytes
include part of the payload.

When attempting to do GRO in skb_gro_receive, if headlen > data_offset
(and skb->head_frag is not set), we end up aggregating packets in the
frag_list.

This is of course not good when we are CPU-limited. Also causes a worse
skb->len/truesize ratio,...

So, let's avoid copying parts of the payload to the linear part. We use
eth_get_headlen() to parse the headers and compute the length of the
protocol headers, which will be used to copy the relevant bits ot the
skb's linear part.

We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
stack needs to call pskb_may_pull() later on, we don't need to reallocate
memory.

This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
LRO enabled):

BEFORE:
=======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.01    32547.82

(netserver pinned to adjacent core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52531.67

AFTER:
======
(netserver pinned to core receiving interrupts)
$ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    52896.06

(netserver pinned to adjacent core receiving interrupts)
 $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
 87380  16384 262144    60.00    85094.90

Additional tests across a larger range of parameters w/ and w/o LRO, w/
and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
better performance with this patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60720d390de45a5b6b453ed0a3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 		dma_sync_single_for_cpu(rq->pdev, addr + head_offset, headlen,
 					rq->buff.map_dir);
 
+		headlen = eth_get_headlen(rq->netdev, head_addr, headlen);
+
 		frag_offset += headlen;
 		byte_cnt -= headlen;
 		linear_hr = skb_headroom(skb);
@@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 				pagep->frags++;
 			while (++pagep < frag_page);
 		}
+
+		headlen = eth_get_headlen(rq->netdev, mxbuf->xdp.data, headlen);
+
 		__pskb_pull_tail(skb, headlen);
 	} else {
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {

-- 
2.50.1



